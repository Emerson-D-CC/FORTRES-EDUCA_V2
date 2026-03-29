from flask import Blueprint, render_template
from app.core.decorators import acudiente_required, login_required, estudiante_requerido

from .service import *

dashboard_bp = Blueprint("dashboard", __name__, url_prefix="/sistema_cupos")

@dashboard_bp.route("/home")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_home():
    return DashboardHome().index()  

@dashboard_bp.route("/dashboard_register_student")
@login_required
@acudiente_required
def dashboard_register_student():
    return RegisterEstudiante().registrar()

@dashboard_bp.route("/profile")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_profile():
    return render_template("dashboard_users/profile.html", active_page="profile")

@dashboard_bp.route("/request")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_request():
    return render_template("dashboard_users/request.html", active_page="request")

@dashboard_bp.route("/security")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_security():
    return render_template("dashboard_users/security.html", active_page="security")

@dashboard_bp.route("/settings")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_settings():
    return render_template("dashboard_users/settings.html", active_page="settings")

@dashboard_bp.route("/status")
@login_required
@acudiente_required
@estudiante_requerido
def dashboard_status():
    return render_template("dashboard_users/status.html", active_page="status")
