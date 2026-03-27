import os
from dotenv import load_dotenv
from pathlib import Path

# Obtener ruta raíz del proyecto
BASE_DIR = Path(__file__).resolve().parent.parent.parent

# Cargar archivo .env
load_dotenv(BASE_DIR / ".env")

class Config:
    """Configuración base de la aplicación"""

    # Seguridad
    SECRET_KEY = os.getenv("SECRET_KEY")
    PEPPER = os.getenv("PASSWORD_PEPPER")

    # Configuración de correo
    MAIL_SERVER = os.getenv("MAIL_SERVER")
    MAIL_PORT = int(os.getenv("MAIL_PORT", 587))
    MAIL_USE_TLS = os.getenv("MAIL_USE_TLS", "True") == "True"
    MAIL_USERNAME = os.getenv("MAIL_USERNAME")
    MAIL_PASSWORD = os.getenv("MAIL_PASSWORD", "").replace(" ", "")
    MAIL_DEFAULT_SENDER = os.getenv("MAIL_DEFAULT_SENDER")

    # Configuración bade de datos
    DB_HOST = os.getenv("DB_HOST")
    DB_PORT = int(os.getenv("DB_PORT", 3306))
    DB_USER = os.getenv("DB_USER")
    DB_PASSWORD = os.getenv("DB_PASSWORD")
    DB_NAME = os.getenv("DB_NAME")

    # Configuración de reCAPTCHA
    RECAPTCHA_SITE_KEY = os.getenv("RECAPTCHA_SITE_KEY")
    RECAPTCHA_SECRET_KEY = os.getenv("RECAPTCHA_SECRET_KEY")

    # Configuración adicional. IMPLEMENTAR EN EL FUTURO
    SESSION_COOKIE_SECURE = False
    SESSION_COOKIE_HTTPONLY = True
    REMEMBER_COOKIE_HTTPONLY = True

class DevelopmentConfig(Config):
    DEBUG = True

class ProductionConfig(Config):
    DEBUG = False