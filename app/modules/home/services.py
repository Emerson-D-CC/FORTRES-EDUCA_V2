import random

from datetime import datetime, timedelta

from flask import render_template, request, redirect, url_for, flash, session, current_app
from flask_mail import Message

# Configuraciones locales
from .forms import *
from .models import * # Archivo intermediario de BD y Services

# Configuraciones globales
from app.settings import Config

# Seguridad
from app.security.recaptcha import validar_recaptcha
from app.security.hash import generar_salt, hashear_contrasena
from app.core.extensions import mail


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
                    self._auditoria(None, ip, "FAILED_LOGIN", user_agent)

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
                    self._auditoria(data_user["ID_Usuario"], ip, "FAILED_LOGIN", user_agent)

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

                # Resetear contador de intentos al ingresar correctamente
                session.pop("login_intentos", None)

                # Construir nombre e iniciales para el header.
                primer_nombre   = data_user.get("Primer_Nombre", "")
                primer_apellido = data_user.get("Primer_Apellido", "")
                nombre_completo = data_user.get("Nombre_Completo", "")

                # Iniciales
                iniciales = (
                    (primer_nombre[0] if primer_nombre else "") +
                    (primer_apellido[0] if primer_apellido else "")
                ).upper()

                # Guardar sesión incluyendo datos para el header
                session["user_id"] = data_user["ID_Usuario"]
                session["username"] = nombre_completo
                session["role_id"] = data_user["FK_ID_Rol"]
                session["double_factor"] = data_user["Doble_Factor_Activo"]
                session["nombre_acudiente"] = nombre_completo
                session["iniciales"] = iniciales

                # Auditar login exitoso
                self._auditoria(data_user["ID_Usuario"], ip, "LOGIN", user_agent)

                return redirect(url_for("dashboard.dashboard_home"))

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


    def logout(self):
        """Cierra la sesión del usuario activo."""
        ip = request.remote_addr
        user_agent = request.headers.get("User-Agent")
        id_usuario = session.get("user_id")

        if id_usuario:
            self._auditoria(id_usuario, ip, "LOGOUT", user_agent)

        session.clear()
        return redirect(url_for("home.login"))


    def _validar_usuario(self, username, password, salt):
        try:
            hash_password = hashear_contrasena(password, salt)
            result = sp_validar_login(username, hash_password)

            if not result:
                return False
            return result[0].get("Resultado") == "SUCCESS"

        except Exception as e:
            print(f"[ERROR] _validar_usuario: {e}")
            return False


    def _auditoria(self, usuario, ip, evento, agent):
        """Registra eventos de sesión. Falla silenciosamente."""
        try:
            sp_auditoria_sesion(usuario, ip, evento, agent)
        except Exception as e:
            print(f"[ERROR] Auditoría fallida: {e}")


class Register:

    PEPPER = Config.PEPPER

    def register(self):
        """Maneja GET y POST del formulario de registro."""

        # Obtener datos de la BD para los select del formulario
        localidades     = sp_obtener_localidades()
        tipos_documento = sp_obtener_tipos_documento()

        form = RegisterForm()

        form.localidad.choices = [
            (loc["ID_Localidad"], loc["Nombre_Localidad"]) for loc in localidades
        ]
        form.tipo_documento.choices = [
            (doc["ID_Tipo_Iden"], doc["Nombre_Tipo_Iden"]) for doc in tipos_documento
        ]

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

            # Construir IDs compuestos
            persona_id = form.documento.data
            usuario_id = f"U{form.documento.data}"
            datos_id   = f"D{form.documento.data}"

            try:
                # Verificar duplicados antes de insertar
                user_exists = sp_usuario_existe(form.email.data, persona_id)

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
                hash_password = hashear_contrasena(form.password.data, salt)

                # Insertar PERSONA
                sp_insertar_persona((
                    persona_id,
                    form.primer_nombre.data,
                    form.segundo_nombre.data or None,
                    form.primer_apellido.data,
                    form.segundo_apellido.data or None,
                    "2000-01-01",
                ))

                # Insertar DATOS ADICIONALES
                sp_insertar_datos_adicionales((
                    datos_id,
                    form.email.data,
                    form.telefono.data,
                    form.parentesco.data,
                    form.tipo_documento.data,
                    persona_id,
                    1, 1, 1,
                    form.localidad.data
                ))

                # Insertar USUARIO
                sp_insertar_usuario((
                    usuario_id,
                    form.email.data,
                    salt,
                    hash_password,
                    "INACTIVE",
                    1,
                    persona_id,
                    2
                ))

                flash("Cuenta creada correctamente. Ya puede iniciar sesión.", "success")
                return redirect(url_for("home.login"))

            except Exception as e:
                print(f"[ERROR] Registro fallido: {e}")
                flash("Ocurrió un error al registrar. Intente nuevamente.", "danger")
                return render_template(
                    "home/registro.html",
                    form=form,
                    recaptcha_site_key=current_app.config.get("RECAPTCHA_SITE_KEY", ""),
                    recaptcha_error=None
                )


class RecuperarContrasena:

    PEPPER = Config.PEPPER
    CODIGO_TTL_MINUTOS = 10  # tiempo de expiración codigo

    #  Solicitar código
    def solicitar_codigo(self):
        """GET / POST — el usuario ingresa su correo y recibe el código."""
        form = RecuperarContrasenaForm()

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
            "username":   username,
            "codigo":     codigo,
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

        return redirect(url_for("home.recuperar_nueva_contrasena"))

    #  Nueva contraseña
    def nueva_contrasena(self):
        """GET / POST — el usuario define su nueva contraseña."""
        form = NuevaContrasenaForm()

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
        nuevo_hash = hashear_contrasena(form.password.data, nuevo_salt)

        try:
            sp_actualizar_contrasena(username, nuevo_hash, nuevo_salt)
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