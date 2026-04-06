from flask import Flask, redirect, url_for, session, flash
from flask_wtf.csrf import CSRFProtect

from app.settings import DevelopmentConfig

# Importar blueprints
from app.modules.home.routes import home_bp
from app.modules.admin.routes import admin_bp
from app.modules.dashboard_user.routes import dashboard_bp
# Importar controladores de errores
from app.core.error_handlers import register_error_handlers
from app.core.extensions import register_context_processors, mail
# Utilidades de seguridad
from flask_jwt_extended import JWTManager
from app.security.jwt_handler import handle_unauthorized_error, handle_expired_error, handle_invalid_error
from app.security.session import controlar_sesion


def create_app():

    app = Flask(__name__, template_folder="templates", static_folder="static")

    # Cargar configuración
    app.config.from_object(DevelopmentConfig)

    # Controlador de sesiones
    controlar_sesion(app)

    # Inicializar extensiones
    mail.init_app(app)
    
    csrf = CSRFProtect()    
    csrf.init_app(app)
    
    # Registrar blueprints
    app.register_blueprint(home_bp)
    app.register_blueprint(admin_bp)
    app.register_blueprint(dashboard_bp)

    # Controlador de errores 
    # register_error_handlers(app)
    
    # Datos del usuario requiridos en header 
    register_context_processors(app)

    # Manejador en caso de fallo del token JWT
    jwt = JWTManager(app)
    jwt.unauthorized_loader(handle_unauthorized_error)
    jwt.expired_token_loader(handle_expired_error)
    jwt.invalid_token_loader(handle_invalid_error)
    
    # Inicializar en pagina principal
    @app.route("/")
    def index():
        return redirect(url_for('home.public_home'))
    
    return app