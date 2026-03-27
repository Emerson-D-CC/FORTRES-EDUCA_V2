from functools import wraps, lru_cache
from flask import session, abort, redirect, url_for, flash
from app.modules.home.models import sp_obtener_roles


@lru_cache(maxsize=None)
def _get_role_id(nombre_rol):
    """Obtiene y cachea el ID de un rol por su nombre."""
    return sp_obtener_roles(nombre_rol)


def login_required(f):
    """Verifica que el usuario tenga sesión activa."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            # [FIX #4] — Redirigir al login con mensaje en lugar de abort(401) crudo
            flash("Debe iniciar sesión para continuar", "warning")
            return redirect(url_for("home.login"))
        return f(*args, **kwargs)
    return decorated_function


def admin_required(f):
    """Verifica que el usuario sea ADMIN."""
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            flash("Debe iniciar sesión para continuar", "warning")
            return redirect(url_for("home.login"))

        # [FIX #1 #2 #3] — Usar caché; admin_id ahora es un entero comparable
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

        # [FIX #1 #2 #3] — Usar caché; acudiente_id ahora es un entero comparable
        # [FIX] Corregido también el typo: "acuidiente" → "acudiente"
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

            # [FIX #1 #2 #3] — IDs cacheados y como enteros comparables
            role_ids = [_get_role_id(name) for name in role_names]

            if None in role_ids:
                abort(500)

            if session.get('role_id') not in role_ids:
                abort(403)

            return f(*args, **kwargs)
        return decorated_function
    return decorator