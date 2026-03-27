from flask import Blueprint, render_template
from app.core.decorators import admin_required, login_required

admin_bp = Blueprint("admin", __name__, url_prefix="/admin")

@admin_bp.route("/dashboard", endpoint="admin_dashboard")
@login_required
@admin_required
def dashboard():
    return render_template("admin/dashboard.html", active_page="dashboard")

@admin_bp.route("/cases", endpoint="admin_cases")
@login_required
@admin_required
def cases():
    return render_template("admin/cases.html", active_page="cases")

@admin_bp.route("/users", endpoint="admin_users")
@login_required
@admin_required
def users():
    return render_template("admin/users.html", active_page="users")

@admin_bp.route("/history", endpoint="admin_history")
@login_required
@admin_required
def history():
    return render_template("admin/history.html", active_page="history")

@admin_bp.route("/settings", endpoint="admin_settings")
@login_required
@admin_required
def settings():
    return render_template("admin/settings.html", active_page="settings")
