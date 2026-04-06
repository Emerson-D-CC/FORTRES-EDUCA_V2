from flask import Blueprint, render_template
from app.core.decorators import acudiente_required, login_required, estudiante_requerido

from .services import *
from .forms import FormCambiarcontraseña, FormVerificarMFA

dashboard_bp = Blueprint("dashboard", __name__, url_prefix="/sistema_cupos")

@dashboard_bp.route("/home")
@login_required
@acudiente_required
def dashboard_home():
    return DashboardHome().index()  


@dashboard_bp.route("/solicitud_ticket/nuevo", methods=["GET", "POST"])
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_ticket_request():
    return CrearTicket().crear()


@dashboard_bp.route("/estado_ticket")
@login_required
@acudiente_required
def dashboard_ticket_status():
    return render_template("dashboard_users/ticket_status.html", active_page="status")

# 
@dashboard_bp.route("/dashboard_registro_estudiante", methods=["GET", "POST"])
@login_required
@acudiente_required
def dashboard_register_student():
    return RegisterEstudiante().registrar()


@dashboard_bp.route("/perfil", methods=["GET", "POST"])
@login_required
@acudiente_required
def dashboard_profile():
    return Profile().cargar_perfil()


@dashboard_bp.route("/centro_seguridad", methods=["GET", "POST"])
@login_required
@acudiente_required
def dashboard_security():
    return Security().cargar_seguridad()

@dashboard_bp.route("/centro_seguridad/contraseña", methods=["POST"])
@login_required
@acudiente_required
def security_cambiar_contraseña():
    return Cambiarcontraseña().cambiar()

@dashboard_bp.route("/centro_seguridad/mfa/iniciar", methods=["POST"])
@login_required
@acudiente_required
def security_mfa_iniciar():
    return GestionMFA().iniciar_activacion()

@dashboard_bp.route("/centro_seguridad/mfa/confirmar", methods=["POST"])
@login_required
@acudiente_required
def security_mfa_confirmar():
    return GestionMFA().confirmar_activacion()

@dashboard_bp.route("/centro_seguridad/mfa/desactivar", methods=["POST"])
@login_required
@acudiente_required
def security_mfa_desactivar():
    return GestionMFA().desactivar()

@dashboard_bp.route("/centro_seguridad/sessions/cerrar-otras", methods=["POST"])
@login_required
@acudiente_required
def security_cerrar_otras_sesiones():
    return GestionSesiones().cerrar_otras()

@dashboard_bp.route("/centro_seguridad/sessions/<string:jti_sesion>/cerrar", methods=["POST"])
@login_required
@acudiente_required
def security_cerrar_sesion(jti_sesion):
    return GestionSesiones().cerrar_una(jti_sesion)


@dashboard_bp.route("/configuración", methods=["GET"])
@login_required
@acudiente_required
def dashboard_settings():
    return ConfiguracionGeneral().mostrar()

@dashboard_bp.route("/configuración/notif-email", methods=["POST"])
@login_required
@acudiente_required
def settings_notif_email():
    return ConfiguracionGeneral().actualizar_notif_email()

@dashboard_bp.route("/configuración/notif-navegador", methods=["POST"])
@login_required
@acudiente_required
def settings_notif_navegador():
    return ConfiguracionGeneral().actualizar_notif_navegador()

@dashboard_bp.route("/configuración/eliminar-cuenta", methods=["POST"])
@login_required
@acudiente_required
def settings_delete_account():
    return EliminarCuenta().eliminar_cuenta()