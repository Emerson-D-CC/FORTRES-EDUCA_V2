from flask import session, redirect, url_for, request
from datetime import datetime, timezone
from flask_jwt_extended import unset_jwt_cookies, verify_jwt_in_request, get_jwt

from app.settings import Config
from app.database.connection_db_v2 import db
from app.modules.dashboard_user.models import sp_cerrar_sesion

TIEMPO_MAX_INACTIVIDAD = Config.PERMANENT_SESSION_LIFETIME
MAX_SESSION_DURATION   = Config.MAX_SESSION_DURATION


def _cerrar_sesion_inactiva():
    """Marca la sesión JWT actual como inactiva en BD y limpia Flask session."""
    try:
        verify_jwt_in_request(optional=True)
        claims = get_jwt()
        if claims:
            jti = claims.get("jti", "")
            if jti:
                sp_cerrar_sesion(jti)
                db.commit()
    except Exception as e:
        print(f"[WARN] No se pudo cerrar sesión en BD (inactividad): {e}")
    finally:
        session.clear()


def controlar_sesion(app):

    @app.before_request
    def verificar_inactividad():

        rutas_publicas = [
            "home.login",
            "home.public_home",
            "home.login_admin",
            "home.register",
            "home.recuperar_solicitar",
            "home.recuperar_verificar",
            "home.recuperar_nueva_contrasena",
            "home.privacy_policy",
            "home.terms_of_use",
        ]

        if request.endpoint in rutas_publicas:
            return

        if "user_id" in session:
            ahora = datetime.now(timezone.utc)

            # Verificar duración máxima de sesión
            session_start_str = session.get("session_start")
            if session_start_str:
                try:
                    session_start = datetime.fromisoformat(session_start_str)
                    if ahora - session_start > MAX_SESSION_DURATION:
                        _cerrar_sesion_inactiva()          # ← marca BD + limpia sesión
                        response = redirect(url_for("home.login"))
                        unset_jwt_cookies(response)
                        return response
                except ValueError:
                    _cerrar_sesion_inactiva()
                    response = redirect(url_for("home.login"))
                    unset_jwt_cookies(response)
                    return response

            ultima_str = session.get("ultima_actividad")
            if ultima_str:
                try:
                    ultima = datetime.fromisoformat(ultima_str)
                    if ahora - ultima > TIEMPO_MAX_INACTIVIDAD:
                        _cerrar_sesion_inactiva()          # ← marca BD + limpia sesión
                        response = redirect(url_for("home.login"))
                        unset_jwt_cookies(response)
                        return response
                except ValueError:
                    _cerrar_sesion_inactiva()
                    response = redirect(url_for("home.login"))
                    unset_jwt_cookies(response)
                    return response

            # Actualizar última actividad
            session["ultima_actividad"] = ahora.isoformat()