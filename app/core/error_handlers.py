from flask import render_template, request
from werkzeug.exceptions import HTTPException

# LAMADO DE CONSTANTES
from .error_config import ERROR_CODES, ERROR_CONFIG

# LAYOUT DINÁMICO SEGÚN APARTADO
def get_layout_for_request():
    path = request.path

    if path.startswith("/admin"):
        return "layout_admin.html"
    elif path.startswith("/dashboard"):
        return "layout_dashboard.html"
    return "layout_public.html"


# RENDER CENTRALIZADO
def render_error(e, code=None, custom_message=None):

    layout = get_layout_for_request()
    error_code = code if code else getattr(e, "code", 500)

    config = ERROR_CONFIG.get(error_code, {
        "title": "Error",
        "description": "Ocurrió un problema inesperado.",
        "icon": "fas fa-exclamation-triangle",
        "color": "text-danger",
    })

    return render_template(
        "errors/error.html",
        layout=layout,
        error_code=error_code,
        error_title=config["title"],
        error_description=custom_message or getattr(e, "description", None) or config["description"],
        error_icon=config["icon"],
        error_color=config["color"],
    ), error_code


# FACTORY DE HANDLERS
def make_handler(code):
    def handler(e):
        return render_error(e, code=code)
    return handler


# REGISTRO DE HANDLERS
def register_error_handlers(app):

    # Handlers específicos
    for code in ERROR_CODES:
        app.register_error_handler(code, make_handler(code))

    # HTTPException (otros códigos no definidos)
    @app.errorhandler(HTTPException)
    def handle_http_exception(e):
        return render_error(e)

    # Excepciones generales (errores inesperados)
    @app.errorhandler(Exception)
    def handle_unexpected_error(e):
        return render_error(
            e,
            code=500,
            custom_message="Error interno inesperado."
        )