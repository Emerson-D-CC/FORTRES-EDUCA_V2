from functools import wraps, lru_cache
from flask import session, request, abort, redirect, url_for, flash

# Conexión con BD
from app.modules.home.models import sp_obtener_roles
from app.modules.dashboard_user.models import sp_verificar_estudiante_acudiente
from flask_jwt_extended import verify_jwt_in_request

@lru_cache(maxsize=None)
def _get_role_id(nombre_rol):
    """Obtiene y cachea el ID de un rol por su nombre."""
    return sp_obtener_roles(nombre_rol)


def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        # Verifica que el JWT sea válido (usa las funciones de error de __init__.py si falla)
        verify_jwt_in_request()
        return f(*args, **kwargs)
    return decorated


def admin_required(f):
    """Verifica que el usuario sea ADMIN."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            flash("Debe iniciar sesión para continuar", "warning")
            return redirect(url_for("home.login"))

        admin_id = _get_role_id("Admin")

        if admin_id is None:
            abort(500)

        if session.get('role_id') != admin_id:
            abort(403)

        return f(*args, **kwargs)
    return decorated_function


def acudiente_required(f):
    """Verifica que el usuario sea ACUDIENTE."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            flash("Debe iniciar sesión para continuar", "warning")
            return redirect(url_for("home.login"))

        acudiente_id = _get_role_id("Acudiente")

        if acudiente_id is None:
            abort(500)

        if session.get('role_id') != acudiente_id:
            abort(403)

        return f(*args, **kwargs)
    return decorated_function


# Decorador para elegir N roles son admitidos para la ruta
def role_required(*role_names):
    """Verifica que el usuario tenga uno de los roles especificados."""
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if 'user_id' not in session:
                flash("Debe iniciar sesión para continuar", "warning")
                return redirect(url_for("home.login"))

            role_ids = [_get_role_id(name) for name in role_names]

            if None in role_ids:
                abort(500)

            if session.get('role_id') not in role_ids:
                abort(403)

            return f(*args, **kwargs)
        return decorated_function
    return decorator


def estudiante_requerido(f):
    """Bloquea el acceso a rutas del dashboard si el acudienteno tiene un estudiante registrado"""
    @wraps(f)
    def decorated_function(*args, **kwargs):

        # Ya verificado en esta sesión — acceso directo sin consultar BD
        if session.get("estudiante_verificado"):
            return f(*args, **kwargs)

        id_acudiente = session.get("user_id")

        try:
            resultado = sp_verificar_estudiante_acudiente(id_acudiente)
            tiene_estudiante = (
                resultado
                and resultado[0].get("tiene_estudiante", 0) > 0
            )
        except Exception as e:
            print(f"[ERROR] Decorador estudiante_requerido: {e}")
            # Ante error técnico se permite el paso para no bloquear al usuario
            tiene_estudiante = True

        if tiene_estudiante:
            # Guardar en sesión para no repetir la consulta
            session["estudiante_verificado"] = True
            return f(*args, **kwargs)

        # Sin estudiante: redirigir a registro
        flash("Debe registrar al estudiante a su cargo para continuar.", "warning")
        return redirect(url_for("dashboard.dashboard_register_student"))

    return decorated_function