from flask_jwt_extended import create_access_token, create_refresh_token, unset_jwt_cookies
from flask import redirect, url_for, flash, session, make_response

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
    response = make_response(redirect(url_for("home.login")))
    unset_jwt_cookies(response)
    flash("No se encontró una sesión activa.", "warning")
    return response

def handle_expired_error(jwt_header, jwt_data):
    session.clear()
    response = make_response(redirect(url_for("home.login")))
    unset_jwt_cookies(response)
    flash("Tu sesión ha expirado. Por favor, ingresa de nuevo.", "danger")
    return response

def handle_invalid_error(err_str):
    session.clear()
    response = make_response(redirect(url_for("home.login")))
    unset_jwt_cookies(response)
    flash("Token inválido o manipulado.", "danger")
    return response