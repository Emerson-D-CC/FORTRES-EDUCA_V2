from flask import render_template, request, redirect, url_for, flash, session
from flask_jwt_extended import get_jwt

from app.database.connection_db_v2 import db
from app.security.hash import generar_salt, hashear_contraseña
from app.security.mfa_handler import MFAHandler

from .models import *
from .forms import *

import pyotp, time # usado para debuggin y obtener logs

# ====================================================================================================================================================
#                                           PAGINA INDEX.HTML
# ====================================================================================================================================================

class DashboardHome:
    """
    El decorador @estudiante_requerido ya garantiza que si
    se llega aquí, el estudiante existe. Solo renderiza.
    """
    def index(self):
        return render_template(
            "dashboard_users/index.html",
            active_page="home",
        )


# ====================================================================================================================================================
#                                           PAGINA PROFILE.HTML
# ====================================================================================================================================================

#  HELPERS INTERNOS

def _form_opciones_acudiente(form):
    """Asigna choices a los SelectFields del formulario del acudiente."""
    estratos = sp_obtener_estratos()
    generos = sp_obtener_generos()
    grupos_pref = sp_obtener_grupos_preferenciales()
    barrios = sp_obtener_barrios()

    form.estrato.choices = (
        [(0, "— Seleccione un Estrato —")] +
        [(e["ID_Estrato"], e["Numero_Estrato"]) for e in estratos]
    )
    form.genero.choices = (
        [(0, "— Seleccione un Género —")] +
        [(g["ID_Genero"], g["Nombre_Genero"]) for g in generos]
    )
    form.grupo_preferencial.choices = (
        [(0, "— Seleccione un Grupo —")] +
        [(gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_pref]
    )
    form.barrio.choices = (
        [(0, "— Seleccione un Barrio —")] +
        [(b["ID_Barrio"], b["Nombre_Barrio"]) for b in barrios]
    )

def _form_opciones_estudiante(form):
    """Asigna choices a todos los SelectFields del formulario del estudiante."""
    
    generos = sp_obtener_generos()
    grupos_preferenciales = sp_obtener_grupos_preferenciales()
    grados = sp_obtener_grados()
    colegios = sp_obtener_colegios()
    
    
    form.genero.choices = (
        [(0, "— Seleccione un Genero —")] +
        [(g["ID_Genero"], g["Nombre_Genero"]) for g in generos]
    )
    form.grupo_preferencial.choices = (
        [(0, "— Seleccione un Grupo —")] +
        [(gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_preferenciales]
    )
    form.grado_actual.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )
    form.grado_proximo.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )    
    form.colegio_anterior.choices = (
        [(0, "— Seleccione un Colegio —")] +
        [(c["ID_Colegio"], c["Nombre_Colegio"]) for c in colegios]
    )
    
#  PROFILE — Acudiente
class Profile:

    def cargar_perfil(self):
        """
        Carga y pre-pobla ambos formularios con los datos actuales del acudiente
        y del estudiante vinculado. Retorna el contexto listo para render_template.
        """
        # ── Formularios
        form_acu_fijos = FormAcudienteDatosPersonales()
        form_acu_edit = FormAcudienteDatosEditables()
        form_est = FormEstudianteDatosEditables()

        _form_opciones_acudiente(form_acu_edit)
        _form_opciones_estudiante(form_est)

        user_id = session["user_id"]
        if not user_id:
            flash("No se encontró sesión de usuario activa.", "danger")
            return redirect(url_for("dashboard.dashboard_home"))

        if request.method == "POST":
            form_type = request.form.get("form_type", "").strip().lower()

            if form_type == "acudiente":
                if self.actualizar_acudiente():
                    return redirect(url_for("dashboard.dashboard_profile"))
            elif form_type == "estudiante":
                if self.actualizar_estudiante():
                    return redirect(url_for("dashboard.dashboard_profile"))
            else:
                flash("Tipo de formulario no reconocido.", "danger")
                
        # ── Datos desde BD
        datos_acu_fijos = sp_obtener_perfil_acudiente(user_id)
        datos_acu = sp_obtener_perfil_acudiente(user_id)
        datos_est = sp_obtener_perfil_estudiante(user_id)
        
        
        if datos_acu_fijos:
            form_acu_fijos.primer_nombre.data = datos_acu_fijos.get("Primer_Nombre")
            form_acu_fijos.segundo_nombre.data = datos_acu_fijos.get("Segundo_Nombre")
            form_acu_fijos.primer_apellido.data = datos_acu_fijos.get("Primer_Apellido")
            form_acu_fijos.segundo_apellido.data = datos_acu_fijos.get("Segundo_Apellido")        
            form_acu_fijos.tipo_identificacion.data = datos_acu_fijos.get("Nombre_Tipo_Iden")
            form_acu_fijos.numero_documento.data = datos_acu_fijos.get("Numero_Documento")
            form_acu_fijos.parentesco.data = datos_acu_fijos.get("Nombre_Parentesco")
            form_acu_fijos.email.data = datos_acu_fijos.get("Email")

            fecha = datos_acu_fijos.get("Fecha_Creacion")
            if fecha:
                fecha_formateada = fecha.strftime("%d/%m/%Y %H:%M")
            else:
                fecha_formateada = None
            form_acu_fijos.fecha_creacion.data = fecha_formateada
            
        # ── Pre-poblar acudiente
        if datos_acu:
            form_acu_edit.telefono.data = datos_acu.get("Telefono")
            form_acu_edit.barrio.data = datos_acu.get("ID_Barrio", 0)
            form_acu_edit.genero.data = datos_acu.get("ID_Genero", 0)
            form_acu_edit.grupo_preferencial.data = datos_acu.get("ID_Grupo_Preferencial", 0)
            form_acu_edit.estrato.data = datos_acu.get("ID_Estrato", 0)

        # ── Pre-poblar estudiante
        if datos_est:
            form_est.primer_nombre.data = datos_est.get("Primer_Nombre")
            form_est.segundo_nombre.data = datos_est.get("Segundo_Nombre")
            form_est.primer_apellido.data = datos_est.get("Primer_Apellido")
            form_est.segundo_apellido.data = datos_est.get("Segundo_Apellido")
            form_est.fecha_nacimiento.data = datos_est.get("Fecha_Nacimiento")
            form_est.genero.data = datos_est.get("ID_Genero", 0)
            form_est.grupo_preferencial.data = datos_est.get("ID_Grupo_Preferencial", 0)
            form_est.grado_actual.data = datos_est.get("ID_Grado_Actual", 0)
            form_est.grado_proximo.data = datos_est.get("ID_Grado_Proximo", 0)
            form_est.colegio_anterior.data = datos_est.get("ID_Colegio_Anterior", 0)
            
        return render_template(
            "dashboard_users/profile.html",
            form_acu_fijos=form_acu_fijos,
            form_acu=form_acu_edit,
            form_est=form_est,
            datos_acu_fijos=datos_acu_fijos,
            datos_acu=datos_acu,
            datos_est=datos_est,
            active_page="profile",
        )

    # ── Guardar acudiente ─────────────────────────────────────────────────────

    def actualizar_acudiente(self):
        form = FormAcudienteDatosEditables()
        _form_opciones_acudiente(form)

        if not form.validate_on_submit():
            print("FORM ERRORS:", form.errors)
            flash("Por favor revise los campos del formulario del acudiente.", "danger")
            return False

        user_id = session.get("user_id")
        if not user_id:
            flash("No se encontró sesión de usuario activa.", "danger")
            return False
        
        datos_acu = sp_obtener_perfil_acudiente(user_id)
        if not datos_acu:
            flash("No se encontró el perfil del acudiente.", "danger")
            return False
            
        # Extraemos los IDs autoincrementales obtenidos por el SP de consulta
        persona_id = datos_acu.get("ID_Persona")
        datos_id = datos_acu.get("ID_Datos_Adicionales")

        try:
            # Enviamos los IDs enteros a la base de datos
            sp_actualizar_datos_adicionales((
                datos_id,
                form.telefono.data,
                persona_id,
                form.genero.data,
                form.grupo_preferencial.data,
                form.estrato.data,  
                form.barrio.data,
                user_id,
                request.remote_addr,
                request.headers.get("User-Agent")
            ))
            
            db.commit()
            flash("Datos actualizados correctamente.", "success")
            return True

        except Exception as e:
            db.rollback()
            flash("Error al guardar los cambios.", "danger")
            return False
    
    
    # Guardar estudiante 
    def actualizar_estudiante(self):
        form = FormEstudianteDatosEditables()
        _form_opciones_estudiante(form)

        if not form.validate_on_submit():
            flash("Por favor revise los campos del formulario del menor.", "danger")
            return False

        user_id = session.get("user_id")
        if not user_id:
            flash("No se encontró sesión de usuario activa.", "danger")
            return False

        datos_est = sp_obtener_perfil_estudiante(user_id)
        if not datos_est:
            flash("No se encontró el estudiante vinculado.", "danger")
            return False

        id_persona_est = datos_est["ID_Persona"]
        # Datos para auditoria
        ip = request.remote_addr
        user_agent = request.headers.get("User-Agent")    
            
        try:
            # 1. Actualizar TBL_PERSONA del menor
            sp_actualizar_persona((
                id_persona_est,
                form.primer_nombre.data,
                form.segundo_nombre.data or None,
                form.primer_apellido.data,
                form.segundo_apellido.data or None,
                form.fecha_nacimiento.data,
                user_id,
                ip,
                user_agent
            ))

            # 2. Actualizar TBL_ESTUDIANTE
            sp_actualizar_estudiante((
                form.grado_actual.data,
                form.grado_proximo.data,
                form.colegio_anterior.data,
                form.genero.data,
                form.grupo_preferencial.data,
                id_persona_est,
                user_id,
                ip,
                user_agent                
            ))

            db.commit()
            flash("Datos del estudiante actualizados correctamente.", "success")
            return True

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Actualización estudiante fallida: {e}")
            flash("Ocurrió un error al guardar los cambios.", "danger")
            return False
        
        
# ====================================================================================================================================================
#                                           PAGINA REGISTER_STUDENT.HTML
# ====================================================================================================================================================

def _form_opciones_estudiante_register(form):
    """Asigna choices a todos los SelectFields del formulario del estudiante."""
    
    generos = sp_obtener_generos()
    grupos_preferenciales = sp_obtener_grupos_preferenciales()
    grados = sp_obtener_grados()
    colegios = sp_obtener_colegios()
    tipos_identificacion = sp_obtener_tipos_identificacion()
    parentesco_estudiante = sp_obtener_parentesco_est()
    
    
    form.genero.choices = (
        [(0, "— Seleccione un Genero —")] +
        [(g["ID_Genero"], g["Nombre_Genero"]) for g in generos]
    )
    form.grupo_preferencial.choices = (
        [(0, "— Seleccione un Grupo —")] +
        [(gp["ID_Grupo_Preferencial"], gp["Nombre_Grupo_Preferencial"]) for gp in grupos_preferenciales]
    )
    form.grado_actual.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )
    form.grado_proximo.choices = (
        [(0, "— Seleccione un grado —")] +
        [(gr["ID_Grado"], gr["Nombre_Grado"]) for gr in grados]
    )    
    form.colegio_anterior.choices = (
        [(0, "— Seleccione un Colegio —")] +
        [(c["ID_Colegio"], c["Nombre_Colegio"]) for c in colegios]
    )
    form.tipo_identificacion.choices = (
        [(0, "— Seleccione una Identificación —")] +
        [(t["ID_Tipo_Iden"], t["Nombre_Tipo_Iden"]) for t in tipos_identificacion]
    )
    form.parentesco.choices = (
        [(0, "— Seleccione un Parentesco —")] +
        [(p["ID_Parentesco"], p["Nombre_Parentesco"]) for p in parentesco_estudiante]
    )

class RegisterEstudiante:

    def registrar(self):
        """
        Maneja GET y POST del formulario de registro del estudiante.
        ID_Estudiante = 'E' + ID_Persona del menor (VARCHAR 16).
        """

        form = FormRegistroEstudiante()
        _form_opciones_estudiante_register(form)

        if request.method == "GET":
            return render_template(
                "dashboard_users/register_student.html",
                form=form,
            )

        # ----- POST -----
        if not form.validate_on_submit():
            errores = "; ".join(
                f"{field}: {', '.join(msgs)}"
                for field, msgs in form.errors.items()
            )
            print(f"Errores en el formulario: {errores}")
            flash("Por favor revise los campos del formulario.", "danger")
            return render_template(
                "dashboard_user/register_student.html",
                form=form,
            )

        # Construir IDs compuestos
        id_persona_estudiante = form.numero_documento.data
        id_estudiante = f"E{id_persona_estudiante}"

        id_persona = session["user_id"]
        # Datos para auditoria
        ip = request.remote_addr
        user_agent = request.headers.get("User-Agent")
        
        try:
            # Verificar que el estudiante no esté ya registrado
            estudiante_existente = sp_estudiante_existe(id_estudiante, id_persona)
            if estudiante_existente:
                flash("Este estudiante ya se encuentra registrado.", "warning")
                return render_template(
                    "dashboard_user/register_student.html",
                    form=form,
                )

            # Registrar estudiante
            sp_registrar_estudiante((
                # Datos TBL_PERSONA
                id_persona_estudiante,
                form.primer_nombre.data,
                form.segundo_nombre.data or None,
                form.primer_apellido.data,
                form.segundo_apellido.data or None,
                form.fecha_nacimiento.data,
                
                # Datos TBL_ESTUDIANTE
                id_estudiante,
                form.tipo_identificacion.data,
                form.grado_actual.data,
                form.grado_proximo.data,
                form.colegio_anterior.data,
                form.genero.data,
                form.grupo_preferencial.data,
                id_persona,
                form.parentesco.data,
                
                # Datos TBL_AUDITORIA
                ip,
                user_agent
            ))

            db.commit()
            
            session["estudiante_verificado"] = True
            flash("Estudiante registrado correctamente.", "success")
            return redirect(url_for("dashboard.dashboard_home"))

        except Exception as e:
            db.rollback()
            print(f"[ERROR] Registro de estudiante fallido: {e}")
            session["estudiante_verificado"] = False
            flash("Ocurrió un error al registrar al estudiante. Intente nuevamente.", "danger")
            return render_template(
                "dashboard_user/register_student.html",
                form=form,
            )

# ====================================================================================================================================================
#                                           PAGINA SECURITY.HTML
# ====================================================================================================================================================


class Cambiarcontraseña:
    """Gestiona el cambio de contraseña desde el perfil del usuario."""

    def cambiar(self):
        form = FormCambiarcontraseña()
        
        ip = request.remote_addr
        user_agent = request.headers.get("User-Agent", "")
        id_usuario = session.get("user_id")
        username = session.get("username_login")

        if request.method == "POST":
            if not form.validate_on_submit():
                errores = "; ".join(
                    f"{f}: {', '.join(m)}" for f, m in form.errors.items()
                )
                flash(f"Errores en el formulario: {errores}", "danger")
                return redirect(url_for("dashboard.dashboard_security"))

            contraseña_actual = form.contraseña_actual.data
            nueva_contraseña = form.nueva_contraseña.data

            try:
                # Obtener datos del usuario actual para validar contraseña
                data_user = sp_validar_data_user(username)
                if not data_user:
                    flash("Sesión inválida. Por favor inicie sesión nuevamente.", "danger")
                    return redirect(url_for("dashboard.dashboard_security"))

                data_user = data_user[0]
                
                salt_actual = data_user["Password_Salt"]

                validar_contraseña = self._validar_usuario(username, contraseña_actual, salt_actual)
                
                if not validar_contraseña:
                    flash("La contraseña actual no es correcta.", "danger")
                    return redirect(url_for("dashboard.dashboard_security"))

                # Generar nuevo salt + hash
                nuevo_salt = generar_salt()
                nuevo_hash = hashear_contraseña(nueva_contraseña, nuevo_salt)

                # Llamar SP para cambiar contraseña
                sp_cambiar_contraseña_perfil(id_usuario, nuevo_hash, nuevo_salt, ip, user_agent)
                
                db.commit()
                flash("Contraseña actualizada correctamente.", "success")
                return redirect(url_for("dashboard.dashboard_security"))

            except Exception as e:
                db.rollback()
                print(f"[ERROR] Cambiarcontraseña: {e}")
                flash("Error interno. Intente nuevamente.", "danger")
                return redirect(url_for("dashboard.dashboard_security"))

        # GET — Renderizar página de seguridad con formulario
        return render_template(
            "dashboard_users/security.html",
            form_password=form,
            active_page="security"
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


#  GESTIÓN DE MFA (Microsoft Authenticator / TOTP)

class GestionMFA:
    """Activa, desactiva y verifica el doble factor de autenticación."""

    def iniciar_activacion(self):
        
        id_usuario = session.get("user_id")
        username = session.get("username")

        try:

            
            # Verificar si ya hay un secret temporal pendiente en BD
            data = sp_obtener_mfa_secret(id_usuario)
            row = data[0] if data else {}

            secret_temp_existente = row.get("MFA_Secret_Temp")
            if isinstance(secret_temp_existente, (bytes, bytearray)):
                secret_temp_existente = secret_temp_existente.decode("utf-8")

            # Si ya hay un secret temporal, reutilizarlo en lugar de generar uno nuevo
            if secret_temp_existente and session.get("mfa_secret_temp") == secret_temp_existente:
                flash("Ya tiene un QR pendiente. Escanéelo e ingrese el código para confirmar.", "info")
                return redirect(url_for("dashboard.dashboard_security"))

            # No hay secret pendiente: generar uno nuevo
            secret = MFAHandler.generar_secret()
            uri = MFAHandler.generar_uri(secret, username)
            qr_b64 = MFAHandler.generar_qr_base64(uri)

            sp_guardar_mfa_secret_temp(id_usuario, secret)
            db.commit()

            session['mfa_secret_temp'] = secret
            session['mfa_qr_temp'] = f"data:image/png;base64,{qr_b64}"
            
            print(f"[DEBUG] iniciar_activacion - secret generado: {secret}")
            print(f"[DEBUG] iniciar_activacion - session mfa_secret_temp antes: {session.get('mfa_secret_temp')}")
            
            flash("QR generado. Escaneelo con Microsoft Authenticator e ingrese el código para confirmar.", "info")
            return redirect(url_for("dashboard.dashboard_security"))

        except Exception as e:
            db.rollback()
            print(f"[ERROR] iniciar_activacion MFA: {e}")
            flash("No se pudo generar el QR. Intente nuevamente.", "danger")
            return redirect(url_for("dashboard.dashboard_security"))

    def confirmar_activacion(self):
        """
        POST: Recibe el código TOTP y, si es válido, activa el MFA.
        """
        form = FormVerificarMFA()
        id_usuario = session.get("user_id")

        if not form.validate_on_submit():
            errores = "; ".join(f"{f}: {', '.join(m)}" for f, m in form.errors.items())
            flash(f"Errores en el formulario: {errores}", "danger")
            return redirect(url_for("dashboard.dashboard_security"))

        try:
            # Obtener secret desde la BD (fuente de verdad)
            data = sp_obtener_mfa_secret(id_usuario)
            if not data:
                flash("Sesión expirada. Inicie el proceso nuevamente.", "danger")
                return redirect(url_for("dashboard.dashboard_security"))
            
            row = data[0]

            # Normalizar: el driver puede retornar bytes o str
            secret_temp = row.get("MFA_Secret_Temp") or row.get("mfa_secret_temp")
            if isinstance(secret_temp, (bytes, bytearray)):
                secret_temp = secret_temp.decode("utf-8")

            if not secret_temp:
                # Fallback: usar el secret guardado en sesión
                secret_temp = session.get("mfa_secret_temp")

            if not secret_temp:
                flash("No hay configuración pendiente. Inicie el proceso nuevamente.", "danger")
                return redirect(url_for("dashboard.dashboard_security"))

            codigo_ingresado = form.codigo_mfa.data.strip()

            # LOGS DE DIAGNÓSTICO
            # totp = pyotp.TOTP(secret_temp)
            # ahora = time.time()

            # verificacion = sp_obtener_mfa_secret(id_usuario)
            # print(f"[DEBUG] Secret guardado en BD: {verificacion}")

            # print(f"[DEBUG] secret_temp   : {secret_temp}")
            # print(f"[DEBUG] codigo ingresado : {codigo_ingresado}")
            # print(f"[DEBUG] codigo esperado  : {totp.now()}")
            # print(f"[DEBUG] verify window=0  : {totp.verify(codigo_ingresado, valid_window=0)}")
            # print(f"[DEBUG] verify window=1  : {totp.verify(codigo_ingresado, valid_window=1)}")
            # print(f"[DEBUG] verify window=4  : {totp.verify(codigo_ingresado, valid_window=4)}")
            
            # codigos_validos = [totp.at(ahora + (i * 30)) for i in range(-5, 6)]
            # print(f"[DEBUG] codigos ventana : {codigos_validos}")
            # print(f"[DEBUG] ingresado en ventana: {codigo_ingresado in codigos_validos}")
            
            if not MFAHandler.verificar_codigo(secret_temp, codigo_ingresado):
                flash("Código incorrecto. Verifique la hora de su dispositivo e intente de nuevo.", "danger")
                return redirect(url_for("dashboard.dashboard_security"))

            sp_activar_mfa(id_usuario)
            db.commit()

            session["double_factor"] = "ACTIVE"
            session.pop('mfa_secret_temp', None)
            session.pop('mfa_qr_temp', None)

            flash("Autenticación de dos factores activada correctamente.", "success")
            return redirect(url_for("dashboard.dashboard_security"))

        except Exception as e:
            db.rollback()
            print(f"[ERROR] confirmar_activacion MFA: {e}")
            flash("Error interno al confirmar. Intente nuevamente.", "danger")
            return redirect(url_for("dashboard.dashboard_security"))

    def desactivar(self):
        """
        POST: Desactiva el MFA después de verificar un código vigente.
        """
        form = FormVerificarMFA()
        id_usuario = session.get("user_id")

        if not form.validate_on_submit():
            errores = "; ".join(f"{f}: {', '.join(m)}" for f, m in form.errors.items())
            flash(f"Errores en el formulario: {errores}", "danger")
            return redirect(url_for("dashboard.dashboard_security"))

        try:
            data = sp_obtener_mfa_secret(id_usuario)
            if not data:
                flash("Sesión expirada. Inicie sesión nuevamente.", "danger")
                return redirect(url_for("home.login"))

            row = data[0]

            # Normalizar igual que en confirmar_activacion
            secret = row.get("MFA_Secret") or row.get("mfa_secret")
            if isinstance(secret, (bytes, bytearray)):
                secret = secret.decode("utf-8")

            if not secret:
                flash("El 2FA no está activo en tu cuenta.", "warning")
                return redirect(url_for("dashboard.dashboard_security"))

            if not MFAHandler.verificar_codigo(secret, form.codigo_mfa.data.strip()):
                flash("Código incorrecto. No se puede desactivar.", "danger")
                return redirect(url_for("dashboard.dashboard_security"))

            sp_desactivar_mfa(id_usuario)
            db.commit()

            session["double_factor"] = "INACTIVE"

            flash("Autenticación de dos factores desactivada.", "success")
            return redirect(url_for("dashboard.dashboard_security"))

        except Exception as e:
            db.rollback()
            print(f"[ERROR] desactivar MFA: {e}")
            flash("Error interno. Intente nuevamente.", "danger")
            return redirect(url_for("dashboard.dashboard_security"))


class GestionSesiones:
    """Consulta y revoca sesiones activas del usuario."""

    def cargar_vista(self):
        id_usuario = session.get("user_id")
        try:
            sesiones = sp_listar_sesiones(id_usuario)
            jti_actual = get_jwt().get("jti", "")

            sesiones_formateadas = []
            for s in (sesiones or []):
                sesiones_formateadas.append({
                    "id":          s["ID_Sesion"],
                    "JTI":         s["JTI"],
                    "dispositivo": s["Dispositivo"] or "Desconocido",
                    "ip":          s["IP"] or "—",
                    "inicio":      s["Fecha_Inicio"].strftime("%d/%m/%Y %H:%M") if s.get("Fecha_Inicio") else "—",
                    "ultimo":      s["Ultimo_Acceso"].strftime("%d/%m/%Y %H:%M") if s.get("Ultimo_Acceso") else "—",
                    "es_actual":   s["JTI"] == jti_actual,
                })

            session['sesiones_activas'] = sesiones_formateadas
            return sesiones_formateadas

        except Exception as e:
            print(f"[ERROR] listar sesiones: {e}")
            return []

    def cerrar_otras(self):
        id_usuario = session.get("user_id")
        try:
            jti_actual = get_jwt().get("jti", "")
            sp_cerrar_todas_sesiones(id_usuario, jti_actual)
            db.commit()
            flash("Todas las demás sesiones han sido cerradas.", "success")
        except Exception as e:
            db.rollback()
            print(f"[ERROR] cerrar_otras: {e}")
            flash("Error al cerrar sesiones. Intente nuevamente.", "danger")
        return redirect(url_for("dashboard.dashboard_security"))

    def cerrar_una(self, jti_sesion: str):
        id_usuario = session.get("user_id")
        try:
            sesiones = sp_listar_sesiones(id_usuario) or []
            sesion = next((s for s in sesiones if s["JTI"] == jti_sesion), None)

            if not sesion:
                flash("Sesión no encontrada.", "warning")
                return redirect(url_for("dashboard.dashboard_security"))

            jti_actual = get_jwt().get("jti", "")
            if jti_sesion == jti_actual:
                flash("No puede cerrar su sesión actual desde aquí.", "danger")
                return redirect(url_for("dashboard.dashboard_security"))

            sp_cerrar_sesion(jti_sesion)
            db.commit()
            flash("Sesión cerrada correctamente.", "success")
        except Exception as e:
            db.rollback()
            print(f"[ERROR] cerrar_una: {e}")
            flash("Error al cerrar sesión. Intente nuevamente.", "danger")
        return redirect(url_for("dashboard.dashboard_security"))
    
            
# ====================================================================================================================================================
#                                           PAGINA SETTINGS.HTML
# ====================================================================================================================================================

 
class ConfiguracionGeneral:
    #  Carga inicial: GET /settings 
    
    def mostrar(self):

        id_usuario = session.get("user_id")
        
        prefs = sp_configuracion_obtener_notificaciones(id_usuario)
 
        # Si el SP no devuelve resultados, inicializamos valores seguros
        if prefs and len(prefs) > 0:
            notif_email = bool(prefs[0]["Notificaciones_Email"])
            notif_navegador = bool(prefs[0]["Notificaciones_Navegador"])
        else:
            notif_email = False
            notif_navegador = False
 
        form_email      = FormNotificacionesEmail()
        form_navegador  = FormNotificacionesNavegador()
        form_eliminar   = FormEliminarCuenta()
 
        # Pre-seleccionar checkboxes según el estado guardado en BD
        form_email.notificaciones_email.data          = notif_email
        form_navegador.notificaciones_navegador.data  = notif_navegador
 
        return render_template(
            "dashboard_users/settings.html",
            form_email=form_email,
            form_navegador=form_navegador,
            form_eliminar=form_eliminar,
            notif_email_activo=notif_email,
            notif_navegador_activo=notif_navegador,
        )
 
    #  Actualizar notificaciones de correo
    
    def actualizar_notif_email(self):
        """Procesa el formulario de notificaciones por correo electrónico."""
        form_email = FormNotificacionesEmail()
 
        if form_email.validate_on_submit():
            activo = 1 if form_email.notificaciones_email.data else 0
 
            try:
                id_usuario = session.get("user_id")

                sp_configuracion_actualizar_notif_email(id_usuario, activo)
 
                estado = "activadas" if activo else "desactivadas"
                flash(
                    f"Las notificaciones por correo han sido {estado} correctamente.",
                    "success"
                )
 
            except Exception:
                flash(
                    "Ocurrió un error al actualizar las notificaciones por correo. "
                    "Intenta de nuevo más tarde.",
                    "danger"
                )
        else:
            flash("Solicitud inválida. Por favor recarga la página e intenta de nuevo.", "warning")
 
        return redirect(url_for("dashboard.dashboard_settings"))
 
    #  Actualizar notificaciones de navegador: POST
    def actualizar_notif_navegador(self):
        """
        Procesa el formulario de notificaciones del navegador.
        """
        form_navegador = FormNotificacionesNavegador()

        if form_navegador.validate_on_submit():
            activo = 1 if form_navegador.notificaciones_navegador.data else 0

            try:
                id_usuario = session.get("user_id")
                sp_configuracion_actualizar_notif_navegador(id_usuario, activo)

                estado = "activadas" if activo else "desactivadas"
                flash(
                    f"Las notificaciones del navegador han sido {estado} correctamente.",
                    "success"
                )

            except Exception:
                flash(
                    "Ocurrió un error al actualizar las notificaciones del navegador. "
                    "Intenta de nuevo más tarde.",
                    "danger"
                )
        else:
            flash("Solicitud inválida. Por favor recarga la página e intenta de nuevo.", "warning")

        return redirect(url_for("dashboard.dashboard_settings"))


class EliminarCuenta:
    
    def eliminar_cuenta(self):
        form_eliminar = FormEliminarCuenta()
        
        if form_eliminar.validate_on_submit():
            id_usuario = session.get("user_id")
            username = session.get("username_login")
            
            if not id_usuario or not username:
                flash("Sesión no válida. Por favor inicia sesión de nuevo.", "danger")
                return redirect(url_for("home.login"))
            
            password = form_eliminar.contraseña.data

            try:
                # 1. Obtener sal y validar contraseña
                data_user = sp_validar_data_user(username)
                if not data_user:
                    raise Exception("Usuario no encontrado")
                
                data_user = data_user[0]
                salt = data_user["Password_Salt"]

                if not self._validar_usuario(username, password, salt):
                    flash("Contraseña incorrecta. No se procedió con la eliminación.", "danger")
                    return redirect(url_for("dashboard.dashboard_settings"))
                
                # 2. Proceder con la eliminación lógica
                ip = request.remote_addr or ""
                user_agent = request.headers.get("User-Agent", "")
                
                sp_eliminar_cuenta_completa(id_usuario, ip, user_agent)
                
                session.clear()
                flash("Cuenta eliminada correctamente. Hasta pronto.", "success")
                return redirect(url_for("home.login"))

            except Exception as e:
                db.rollback()
                print(f"[ERROR] eliminar_cuenta: {e}")
                flash("Error de sistema al procesar la solicitud.", "danger")
                return redirect(url_for("dashboard.dashboard_settings"))
            
        # Si el formulario no es válido o falta la contraseña
        flash("Debe ingresar su contraseña para confirmar.", "warning")
        return redirect(url_for("dashboard.dashboard_settings"))

    def _validar_usuario(self, username, password, salt):
        try:
            hash_password = hashear_contraseña(password, salt)
            result = sp_validar_login(username, hash_password)
            # Retorna True solo si el resultado es SUCCESS
            return result and result[0].get("Resultado") == "SUCCESS"
        except Exception as e:
            print(f"[ERROR] _validar_usuario: {e}")
            return False