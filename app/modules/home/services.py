import random

from datetime import datetime, timedelta, timezone

from flask import render_template, request, redirect, url_for, flash, session, current_app, make_response
from flask_mail import Message
from flask_jwt_extended import set_access_cookies, set_refresh_cookies, unset_jwt_cookies, get_jwt, verify_jwt_in_request, decode_token

# Configuraciones locales
from .forms import *
from .models import * # Archivo intermediario de BD y Services
from app.database.connection_db_v2 import db

# Configuraciones globales
from app.settings import Config
from app.core.extensions import mail

# Seguridad
from app.security.recaptcha import validar_recaptcha
from app.security.hash import generar_salt, hashear_contraseña
from app.security.jwt_handler import generar_access_token, generar_refresh_token
from app.security.mfa_handler import MFAHandler

# Funciones Globales
def auditoria(usuario, ip, evento, agent):
    """Registra eventos de sesión. Falla silenciosamente."""
    try:
        sp_auditoria_sesion(usuario, ip, evento, agent)
        db.commit()
    except Exception as e:
        db.rollback()
        print(f"[ERROR] Auditoría fallida: {e}")


# ====================================================================================================================================================
#                                           PAGINA LOGIN.HTML
# ====================================================================================================================================================

# Intentos fallidos antes de exigir reCAPTCHA
INTENTOS_PARA_RECAPTCHA = 3

class Login:
    """Servicio de autenticación."""

    def login(self):
        form = LoginForm()

        # Se usa la IP como base pero se guarda en session para simplicidad.
        intentos_fallidos = session.get("login_intentos", 0)
        mostrar_recaptcha = intentos_fallidos >= INTENTOS_PARA_RECAPTCHA

        if request.method == "POST":

            if not form.validate_on_submit():
                errores = "; ".join(
                    f"{field}: {', '.join(msgs)}"
                    for field, msgs in form.errors.items()
                )
                print(f"Errores en el formulario: {errores}")
                return render_template(
                    "home/login.html",
                    form=form,
                    mostrar_recaptcha=mostrar_recaptcha,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
                )

            # Datos de auditoría
            ip = request.remote_addr
            user_agent = request.headers.get("User-Agent")

            # Se valida antes de consultar la BD para ahorrar recursos.
            if mostrar_recaptcha:
                token_recaptcha = request.form.get("g-recaptcha-response", "")

                if not token_recaptcha:
                    flash("Por favor complete el reCAPTCHA.", "warning")
                    return render_template(
                        "home/login.html",
                        form=form,
                        mostrar_recaptcha=True,
                        recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
                    )

                # validar_recaptcha retorna True si el token es válido
                if not validar_recaptcha(token_recaptcha):
                    flash("reCAPTCHA inválido. Intente nuevamente.", "danger")
                    return render_template(
                        "home/login.html",
                        form=form,
                        mostrar_recaptcha=True,
                        recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
                    )

            # Credenciales del formulario
            username = form.username.data
            password = form.password.data

            try:
                # Buscar datos del usuario en BD
                data_user = sp_validar_data_user(username)

                if not data_user:
                    # Se pasa None como ID si no existe en la BD. 
                    auditoria(None, ip, "FAILED_LOGIN", user_agent)

                    # Incrementar contador de intentos fallidos
                    session["login_intentos"] = intentos_fallidos + 1
                    mostrar_recaptcha = session["login_intentos"] >= INTENTOS_PARA_RECAPTCHA

                    flash("Credenciales inválidas", "danger")
                    return render_template(
                        "home/login.html",
                        form=form,
                        mostrar_recaptcha=mostrar_recaptcha,
                        recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
                    )

                data_user = data_user[0]
                salt = data_user["Password_Salt"]

                login_validate = self._validar_usuario(username, password, salt)

                if not login_validate:
                    # Auditar intento fallido con usuario existente
                    auditoria(data_user["ID_Usuario"], ip, "FAILED_LOGIN", user_agent)

                    # Incrementar contador de intentos fallidos
                    session["login_intentos"] = intentos_fallidos + 1
                    mostrar_recaptcha = session["login_intentos"] >= INTENTOS_PARA_RECAPTCHA

                    flash("Credenciales inválidas", "danger")
                    return render_template(
                        "home/login.html",
                        form=form,
                        mostrar_recaptcha=mostrar_recaptcha,
                        recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
                    )

                # --- LOGIN EXITOSO ---
                session.pop("login_intentos", None)

                primer_nombre   = data_user.get("Primer_Nombre", "")
                primer_apellido = data_user.get("Primer_Apellido", "")
                nombre_completo = data_user.get("Nombre_Completo", "")

                iniciales = (
                    (primer_nombre[0] if primer_nombre else "") +
                    (primer_apellido[0] if primer_apellido else "")
                ).upper()

                
                # Guardar datos importantes para la sesión
                session.permanent = True
                session["user_id"] = data_user["ID_Usuario"]
                session["username"] = nombre_completo
                session["username_login"] = username
                session["role_id"] = data_user["FK_ID_Rol"]
                session["double_factor"] = data_user["Doble_Factor_Activo"]
                session["nombre_acudiente"] = nombre_completo
                session["iniciales"] = iniciales
                session["session_start"] = datetime.now(timezone.utc).isoformat()
                session["ultima_actividad"] = datetime.now(timezone.utc).isoformat()
                
                # GENERAR TOKENS
                access_token = generar_access_token(
                    data_user["ID_Usuario"],
                    data_user["FK_ID_Rol"]
                )

                refresh_token = generar_refresh_token(
                    data_user["ID_Usuario"]
                )

                # RESPUESTA
                response = make_response(redirect(url_for("dashboard.dashboard_home")))

                set_access_cookies(response, access_token)
                set_refresh_cookies(response, refresh_token)
                
                try:
                    decoded = decode_token(access_token)

                    jti = decoded.get("jti", "")
                    session["jti"] = jti
                    
                    sp_registrar_sesion(
                        data_user["ID_Usuario"],
                        jti,
                        user_agent[:255] if user_agent else "Desconocido",
                        ip
                    )
                    db.commit()
                except Exception as e:
                    print(f"[WARN] No se pudo registrar sesión: {e}")
                    
                # Auditoría
                auditoria(data_user["ID_Usuario"], ip, "LOGIN", user_agent)
                
                if data_user.get("Doble_Factor_Activo") == "ACTIVE":
                    # Marcar que el usuario autenticó credenciales pero aún falta MFA
                    session["mfa_pendiente"] = True
                    session["mfa_user_autenticado"] = True  # bandera para /verify-mfa

                    # Generar tokens igual (para registrar sesión), pero redirigir a MFA
                    response = make_response(redirect(url_for("home.verificar_mfa")))
                    set_access_cookies(response, access_token)
                    set_refresh_cookies(response, refresh_token)

                    try:
                        decoded = decode_token(access_token)
                        jti = decoded.get("jti", "")
                        sp_registrar_sesion(
                            data_user["ID_Usuario"],
                            jti,
                            user_agent[:255] if user_agent else "Desconocido",
                            ip
                        )
                        db.commit()
                    except Exception as e:
                        print(f"[WARN] No se pudo registrar sesión: {e}")

                    auditoria(data_user["ID_Usuario"], ip, "LOGIN_PENDING_MFA", user_agent)
                    
                return response

            except Exception as e:
                print(f"[ERROR] Error en login: {e}")
                flash("Error interno del servidor. Intente nuevamente.", "danger")
                return render_template(
                    "home/login.html",
                    form=form,
                    mostrar_recaptcha=mostrar_recaptcha,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
                )

        # GET — renderizar formulario con estado actual de intentos
        return render_template(
            "home/login.html",
            form=form,
            mostrar_recaptcha=mostrar_recaptcha,
            recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", "")
        )

    def _validar_usuario(self, username, password, salt):
        try:
            hash_password = hashear_contraseña(password, salt)
            result = sp_validar_login(username, hash_password)

            if not result:
                return False
            return result[0].get("Resultado") == "SUCCESS"

        except Exception as e:
            print(f"[ERROR] _validar_usuario: {e}")
            return False



# ====================================================================================================================================================
#                                           FUNCIÓN DE LOGOUT
# ====================================================================================================================================================

class Logout:
    def logout(self):
        """Cierra la sesión del usuario activo usando Flask-JWT-Extended."""
        try:
            verify_jwt_in_request(optional=True)
            claims = get_jwt()

            if claims:
                user_id = claims.get("sub")
                jti = claims.get("jti", "")
                ip = request.remote_addr
                user_agent = request.headers.get("User-Agent")

                # Marcar sesión como inactiva en BD
                if jti:
                    try:
                        sp_cerrar_sesion(jti)
                        db.commit()
                    except Exception as e:
                        print(f"[WARN] No se pudo cerrar sesión en BD: {e}")

                auditoria(user_id, ip, "LOGOUT", user_agent)

            response = make_response(redirect(url_for("home.login")))
            unset_jwt_cookies(response)
            session.clear()
            return response

        except Exception as e:
            print(f"[ERROR] Logout: {e}")
            response = make_response(redirect(url_for("home.login")))
            unset_jwt_cookies(response)
            session.clear()
            return response



# ====================================================================================================================================================
#                                           PAGINA VERIFY_MFA.HTML
# ====================================================================================================================================================

class VerificarMFA:
    """Valida el código TOTP durante el login para usuarios con 2FA activo."""

    def verificar(self):
        # Solo accesible si viene de un login exitoso con MFA pendiente
        if not session.get("mfa_pendiente") or not session.get("mfa_user_autenticado"):
            return redirect(url_for("home.login"))

        form = FormVerificarMFA()

        if request.method == "POST" and form.validate_on_submit():
            id_usuario = session.get("user_id")
            ip = request.remote_addr
            user_agent = request.headers.get("User-Agent", "")

            try:
                data = sp_obtener_mfa_secret(id_usuario)
                if not data:
                    flash("Error de sesión. Inicie sesión nuevamente.", "danger")
                    return redirect(url_for("home.login"))

                row = data[0]
                secret = row.get("MFA_Secret") or row.get("mfa_secret")
                if isinstance(secret, (bytes, bytearray)):
                    secret = secret.decode("utf-8")

                if not secret or not MFAHandler.verificar_codigo(secret, form.codigo_mfa.data.strip()):
                    auditoria(id_usuario, ip, "FAILED_MFA", user_agent)
                    flash("Código incorrecto. Intente de nuevo.", "danger")
                    return render_template("home/verify_mfa.html", form=form)

                # MFA válido: limpiar banderas y permitir acceso
                session.pop("mfa_pendiente", None)
                session.pop("mfa_user_autenticado", None)
                auditoria(id_usuario, ip, "LOGIN_MFA_OK", user_agent)
                return redirect(url_for("dashboard.dashboard_home"))

            except Exception as e:
                print(f"[ERROR] VerificarMFA.verificar: {e}")
                flash("Error interno. Intente nuevamente.", "danger")

        return render_template("home/verify_mfa.html", form=form)
    
    

# ====================================================================================================================================================
#                                           PAGINA REGISTER.HTML
# ====================================================================================================================================================

class Register:

    PEPPER = Config.PEPPER

    def _form_registro_acudiente(self, form):
        barrio = sp_obtener_barrios()
        parentesco = sp_obtener_parentesco_acu()
        tipos_documento = sp_obtener_tipos_documento()
        
        form.barrio.choices = [
            (bar["ID_Barrio"], bar["Nombre_Barrio"]) for bar in barrio
        ]
        form.parentesco.choices = [
            (par["ID_Parentesco"], par["Nombre_Parentesco"]) for par in parentesco
        ]
        form.tipo_documento.choices = [
            (doc["ID_Tipo_Iden"], doc["Nombre_Tipo_Iden"]) for doc in tipos_documento
        ]

    def register(self):
        """Maneja GET y POST del formulario de registro."""
        
        form = RegisterForm()
        self._form_registro_acudiente(form)
        
        if request.method == "GET":
            # Pasar la site key para renderizar el widget reCAPTCHA
            return render_template(
                "home/registro.html",
                form=form,
                recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                recaptcha_error=None
            )

        # ----- POST -----
        if request.method == "POST":

            # Validar token antes de procesar cualquier dato. Si el falla, se devuelve el formulario inmediatamente
            token_recaptcha = request.form.get("g-recaptcha-response", "")

            if not token_recaptcha:
                # No completó el widget — devolver con mensaje de error
                return render_template(
                    "home/registro.html",
                    form=form,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                    recaptcha_error="Por favor complete la verificación reCAPTCHA."
                )

            if not validar_recaptcha(token_recaptcha):
                # Token inválido o expirado
                return render_template(
                    "home/registro.html",
                    form=form,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                    recaptcha_error="reCAPTCHA inválido. Intente nuevamente."
                )

            # Validación del formulario despues del reCAPTCHA
            if not form.validate_on_submit():
                errores = "; ".join(
                    f"{field}: {', '.join(msgs)}"
                    for field, msgs in form.errors.items()
                )
                print(f"Errores en el formulario: {errores}")
                flash("Error con el formulario. Por favor revise los campos.", "danger")
                return render_template(
                    "home/registro.html",
                    form=form,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                    recaptcha_error=None
                )

            try:
                # Verificar duplicados antes de insertar
                user_exists = sp_usuario_existe(form.email.data)

                if user_exists:
                    flash("El documento o correo ya está registrado.", "warning")
                    return render_template(
                        "home/registro.html",
                        form=form,
                        recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                        recaptcha_error=None
                    )

                # Hash de contraseña
                salt = generar_salt()
                hash_password = hashear_contraseña(form.password.data, salt)
                # Datos para auditoria
                ip = request.remote_addr
                user_agent = request.headers.get("User-Agent")

                sp_registrar_usuario((

                    # PERSONA
                    form.primer_nombre.data,
                    form.segundo_nombre.data or None,
                    form.primer_apellido.data,
                    form.segundo_apellido.data or None,
                    form.fecha_nacimiento.data,

                    # DATOS
                    form.email.data,
                    form.telefono.data,
                    form.parentesco.data,
                    form.tipo_documento.data,
                    1,
                    1,
                    1,
                    form.barrio.data,

                    # USUARIO
                    form.email.data,
                    salt,
                    hash_password,
                    2,

                    # AUDITORÍA
                    ip,
                    user_agent
                ))
                
                db.commit() # confirmar cambios
                
                flash("Cuenta creada correctamente. Ya puede iniciar sesión.", "success")
                return redirect(url_for("home.login"))

            except Exception as e:
                print(f"[ERROR] Registro fallido: {e}")
                flash("Ocurrió un error al registrar. Intente nuevamente.", "danger")
                
                db.rollback() # revetir todo si hay un error
                
                return render_template(
                    "home/registro.html",
                    form=form,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                    recaptcha_error=None
                )



# ====================================================================================================================================================
#                                           PAGINA RECOVER_PASSWORD.HTML
# ====================================================================================================================================================

class Recuperarcontraseña:

    PEPPER = Config.PEPPER
    CODIGO_TTL_MINUTOS = 10  # tiempo de expiración codigo

    #  Solicitar código
    def solicitar_codigo(self):
        """GET / POST — el usuario ingresa su correo y recibe el código."""
        form = RecuperarcontraseñaForm()

        if request.method == "GET":
            return render_template("home/recover_password.html", form=form, paso=1)

        if not form.validate_on_submit():
            flash("Por favor ingrese un correo válido.", "danger")
            return render_template("home/recover_password.html", form=form, paso=1)

        username = form.username.data.strip().lower()

        # Verificar si el usuario existe
        email = sp_obtener_email_por_username(username)
        if not email:
            # Mensaje genérico para no revelar si el usuario existe
            flash("Si el correo está registrado, recibirá un código en breve.", "info")
            return render_template("home/recover_password.html", form=form, paso=1)

        # Generar código aleatorio de 6 dígitos
        codigo = str(random.randint(100000, 999999))
        expiracion = (datetime.utcnow() + timedelta(minutes=self.CODIGO_TTL_MINUTOS)).isoformat()

        # Guardar en sesión
        session["recuperacion"] = {
            "username": username,
            "codigo": codigo,
            "expiracion": expiracion,
            "verificado": False
        }

        # Enviar correo
        try:
            self._enviar_correo_codigo(email, codigo)
        except Exception as e:
            current_app.logger.error(f"Error enviando correo de recuperación: {e}")
            flash("No se pudo enviar el correo. Intente más tarde.", "danger")
            return render_template("home/recover_password.html", form=form, paso=1)

        flash("Código enviado. Revise su bandeja de entrada.", "success")
        return redirect(url_for("home.recuperar_verificar"))

    #  Verificar código
    def verificar_codigo(self):
        """GET / POST — el usuario ingresa el código recibido."""
        form = VerificarCodigoForm()

        # Redirigir si no hay sesión de recuperación activa
        if "recuperacion" not in session:
            flash("Sesión expirada. Inicie el proceso nuevamente.", "warning")
            return redirect(url_for("home.recuperar_solicitar"))

        if request.method == "GET":
            return render_template("home/recover_password.html", form=form, paso=2)

        if not form.validate_on_submit():
            flash("Ingrese el código de 6 dígitos.", "danger")
            return render_template("home/recover_password.html", form=form, paso=2)

        datos = session["recuperacion"]

        # Verificar expiración
        if datetime.utcnow() > datetime.fromisoformat(datos["expiracion"]):
            session.pop("recuperacion", None)
            flash("El código expiró. Solicite uno nuevo.", "warning")
            return redirect(url_for("home.recuperar_solicitar"))

        # Comparar código
        if form.codigo.data.strip() != datos["codigo"]:
            flash("Código incorrecto. Verifique e intente de nuevo.", "danger")
            return render_template("home/recover_password.html", form=form, paso=2)

        # Marcar como verificado en sesión
        session["recuperacion"]["verificado"] = True
        session.modified = True

        return redirect(url_for("home.recuperar_nueva_contraseña"))

    #  Nueva contraseña
    def nueva_contraseña(self):
        """GET / POST — el usuario define su nueva contraseña."""
        form = NuevacontraseñaForm()

        datos = session.get("recuperacion")

        # Validar que haya pasado por el paso 2
        if not datos or not datos.get("verificado"):
            flash("Acceso no autorizado. Complete el proceso de verificación.", "warning")
            return redirect(url_for("home.recuperar_solicitar"))

        if request.method == "GET":
            return render_template("home/recover_password.html", form=form, paso=3)

        if not form.validate_on_submit():
            flash("Por favor revise los campos.", "danger")
            return render_template("home/recover_password.html", form=form, paso=3)

        username = datos["username"]

        # Generar nuevo salt y hash con pepper
        nuevo_salt = generar_salt()
        nuevo_hash = hashear_contraseña(form.password.data, nuevo_salt)
        # Datos para auditoria
        ip = request.remote_addr
        user_agent = request.headers.get("User-Agent")
        
        try:
            sp_actualizar_contraseña(username, nuevo_hash, nuevo_salt, ip, user_agent)
        except Exception as e:
            current_app.logger.error(f"Error actualizando contraseña: {e}")
            flash("Error al actualizar la contraseña. Intente más tarde.", "danger")
            return render_template("home/recover_password.html", form=form, paso=3)

        # Limpiar sesión de recuperación
        session.pop("recuperacion", None)

        flash("¡Contraseña actualizada exitosamente! Ya puede iniciar sesión.", "success")
        return redirect(url_for("home.login"))

    #  Envio Correo
    def _enviar_correo_codigo(self, destinatario: str, codigo: str):
        """Envía el correo con el código de verificación."""
        msg = Message(
            subject="Recuperación de contraseña - Fortress Educa",
            recipients=[destinatario]
        )
        msg.html = f"""
        <div style="font-family: Arial, sans-serif; max-width: 480px; margin: auto; padding: 24px;
                    border: 1px solid #e0e0e0; border-radius: 8px;">
            <h2 style="color: #1a3a5c;">Recuperación de Contraseña</h2>
            <p>Recibimos una solicitud para restablecer la contraseña de su cuenta en
               <strong>Fortress Educa</strong>.</p>
            <p>Su código de verificación es:</p>
            <div style="font-size: 36px; font-weight: bold; letter-spacing: 8px;
                        color: #2e7d32; text-align: center; padding: 16px 0;">
                {codigo}
            </div>
            <p style="color: #666; font-size: 13px;">
                Este código es válido por <strong>{self.CODIGO_TTL_MINUTOS} minutos</strong>.
                Si usted no solicitó este cambio, ignore este correo.
            </p>
            <hr style="border: none; border-top: 1px solid #eee;">
            <p style="color: #999; font-size: 11px;">
                Plataforma de Cupos Educativos · Alcaldía Local de Engativá
            </p>
        </div>
        """
        mail.send(msg)