# DECLARACIÓN DE CONSTANTES
    # Errores especificos validados por es sistema
ERROR_CODES = [400, 401, 403, 404, 405, 410, 500, 502, 503, 504]

    # Información del error enviada a la plantilla error.html
ERROR_CONFIG = {
    400: {
        "title": "Solicitud Incorrecta",
        "description": "La solicitud enviada es inválida. Verifica los datos.",
        "icon": "fas fa-exclamation-circle",
        "color": "text-warning",
    },
    401: {
        "title": "No Autorizado",
        "description": "Debes iniciar sesión para acceder.",
        "icon": "fas fa-lock",
        "color": "text-danger",
    },
    403: {
        "title": "Acceso Denegado",
        "description": "No tienes permisos para acceder a este recurso.",
        "icon": "fas fa-ban",
        "color": "text-danger",
    },
    404: {
        "title": "Página No Encontrada",
        "description": "El recurso solicitado no existe.",
        "icon": "fas fa-search",
        "color": "text-secondary",
    },
    405: {
        "title": "Metodo No Permitido",
        "description": "Este método no está permitido para la URL solicitada.",
        "icon": "fas fa-ban",
        "color": "text-secondary",
    },
    410: {
        "title": "Recurso Eliminado",
        "description": "Este recurso ya no está disponible.",
        "icon": "fas fa-trash",
        "color": "text-muted",
    },
    500: {
        "title": "Error Interno",
        "description": "Ocurrió un error inesperado.",
        "icon": "fas fa-server",
        "color": "text-danger",
    },
    502: {
        "title": "Error de Conexión",
        "description": "El servidor recibió una respuesta inválida.",
        "icon": "fas fa-plug",
        "color": "text-warning",
    },
    503: {
        "title": "Servicio No Disponible",
        "description": "El servidor está temporalmente fuera de servicio.",
        "icon": "fas fa-tools",
        "color": "text-warning",
    },
    504: {
        "title": "Tiempo de Espera Agotado",
        "description": "El servidor tardó demasiado en responder.",
        "icon": "fas fa-clock",
        "color": "text-warning",
    },
}