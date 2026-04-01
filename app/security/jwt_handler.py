from flask_jwt_extended import create_access_token, create_refresh_token
from flask import redirect, url_for, flash, session

# Generar Access Token
def generar_access_token(user_id, role_id):
    # Los datos extra (role_id) se pasan en additional_claims
    additional_claims = {"role_id": role_id}
    return create_access_token(identity=str(user_id), additional_claims=additional_claims)

# Generar Refresh Token
def generar_refresh_token(user_id):
    return create_refresh_token(identity=str(user_id))

def handle_unauthorized_error(err_str):
    session.clear()
    flash("No se encontró una sesión activa.", "warning")
    return redirect(url_for("home.login"))

def handle_expired_error(jwt_header, jwt_data):
    session.clear()
    flash("Tu sesión ha expirado. Por favor, ingresa de nuevo.", "danger")
    return redirect(url_for("home.login"))

def handle_invalid_error(err_str):
    session.clear()
    flash("Token inválido o manipulado.", "danger")
    return redirect(url_for("home.login"))