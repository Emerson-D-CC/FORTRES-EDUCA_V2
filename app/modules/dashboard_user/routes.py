from flask import Blueprint, render_template
from app.core.decorators import acudiente_required, login_required

dashboard_bp = Blueprint("dashboard", __name__, url_prefix="/sistema_cupos")

@dashboard_bp.route("/home")
@login_required
@acudiente_required
def dashboard_home():
    return render_template("dashboard_users/index.html", active_page="home")

@dashboard_bp.route("/profile")
@login_required
@acudiente_required
def dashboard_profile():
    return render_template("dashboard_users/profile.html", active_page="profile")

@dashboard_bp.route("/request")
@login_required
@acudiente_required
def dashboard_request():
    return render_template("dashboard_users/request.html", active_page="request")

@dashboard_bp.route("/security")
@login_required
@acudiente_required
def dashboard_security():
    return render_template("dashboard_users/security.html", active_page="security")

@dashboard_bp.route("/settings")
@login_required
@acudiente_required
def dashboard_settings():
    return render_template("dashboard_users/settings.html", active_page="settings")

@dashboard_bp.route("/status")
@login_required
@acudiente_required
def dashboard_status():
    return render_template("dashboard_users/status.html", active_page="status")
