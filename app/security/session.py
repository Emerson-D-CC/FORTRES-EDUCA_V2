from flask import session, redirect, url_for, request
from datetime import datetime, timedelta

from app.settings import Config

TIEMPO_MAX_INACTIVIDAD = Config.PERMANENT_SESSION_LIFETIME

def controlar_sesion(app):

    @app.before_request
    def verificar_inactividad():

        # Rutas públicas que NO deben validar sesión
        rutas_publicas = [
            "home.login",
            "home.public_home",
            "static"
        ]

        if request.endpoint in rutas_publicas:
            return

        if "user_id" in session:

            ahora = datetime.utcnow()

            ultima_str = session.get("ultima_actividad")

            if ultima_str:
                ultima = datetime.fromisoformat(ultima_str)

                if ahora - ultima > TIEMPO_MAX_INACTIVIDAD:
                    session.clear()
                    return redirect(url_for("home.login"))

            # Actualizar actividad
            session["ultima_actividad"] = ahora.isoformat()