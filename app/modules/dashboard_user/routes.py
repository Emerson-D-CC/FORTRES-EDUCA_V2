from flask import Blueprint, render_template
from app.core.decorators import acudiente_required, login_required, estudiante_requerido

from .services import *
from .forms import FormCambiarcontraseña, FormVerificarMFA

dashboard_bp = Blueprint("dashboard", __name__, url_prefix="/sistema_cupos")

@dashboard_bp.route("/home")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_home():
    return DashboardHome().index()  

@dashboard_bp.route("/dashboard_register_student", methods=["GET", "POST"])
@login_required
@acudiente_required
def dashboard_register_student():
    return RegisterEstudiante().registrar()

@dashboard_bp.route("/profile", methods=["GET", "POST"])
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_profile():
    return Profile().cargar_perfil()

@dashboard_bp.route("/request", methods=["GET", "POST"])
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_request():
    return render_template("dashboard_users/request.html", active_page="request")

@dashboard_bp.route("/security", methods=["GET", "POST"])
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_security():
    form_password = FormCambiarcontraseña()
    form_mfa_activar = FormVerificarMFA()
    form_mfa_desactivar = FormVerificarMFA()
    sesiones = GestionSesiones().cargar_vista()
    return render_template(
        "dashboard_users/security.html",
        form_password=form_password,
        form_mfa_activar=form_mfa_activar,
        form_mfa_desactivar=form_mfa_desactivar,
        sesiones=sesiones,
        active_page="security"
    )

@dashboard_bp.route("/security/password", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def security_cambiar_contraseña():
    return Cambiarcontraseña().cambiar()

@dashboard_bp.route("/security/mfa/iniciar", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def security_mfa_iniciar():
    return GestionMFA().iniciar_activacion()

@dashboard_bp.route("/security/mfa/confirmar", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def security_mfa_confirmar():
    return GestionMFA().confirmar_activacion()

@dashboard_bp.route("/security/mfa/desactivar", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def security_mfa_desactivar():
    return GestionMFA().desactivar()

@dashboard_bp.route("/security/sessions/cerrar-otras", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def security_cerrar_otras_sesiones():
    return GestionSesiones().cerrar_otras()

@dashboard_bp.route("/security/sessions/<string:jti_sesion>/cerrar", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def security_cerrar_sesion(jti_sesion):
    return GestionSesiones().cerrar_una(jti_sesion)


@dashboard_bp.route("/settings", methods=["GET"])
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_settings():
    return ConfiguracionGeneral().mostrar()

@dashboard_bp.route("/settings/notif-email", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def settings_notif_email():
    return ConfiguracionGeneral().actualizar_notif_email()

@dashboard_bp.route("/settings/notif-navegador", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def settings_notif_navegador():
    return ConfiguracionGeneral().actualizar_notif_navegador()

@dashboard_bp.route("/settings/delete-account", methods=["POST"])
@login_required
@acudiente_required
@estudiante_requerido
def settings_delete_account():
    return EliminarCuenta().eliminar_cuenta()

@dashboard_bp.route("/status")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_status():
    return render_template("dashboard_users/status.html", active_page="status")
