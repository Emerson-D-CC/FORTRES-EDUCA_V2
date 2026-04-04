from flask import Blueprint, render_template
from flask_wtf.csrf import CSRFProtect, CSRFError
from .services import *

home_bp = Blueprint("home", __name__, url_prefix="/home")

@home_bp.route('/')
def public_home():
    return render_template('home/home.html')

@home_bp.route("/login", methods=["GET", "POST"])
def login():
    return Login().login()

@home_bp.route("/verify-mfa", methods=["GET", "POST"])
def verificar_mfa():
    return VerificarMFA().verificar()

@home_bp.route("/login_administradores", methods=["GET", "POST"])
def login_admin():
    return render_template('home/login_admin.html')

@home_bp.route('/logout', methods=['GET', 'POST'])
def logout():
    return Logout().logout()

# Manejo de error si el token es inválido o expiró
@home_bp.errorhandler(CSRFError)
def handle_csrf_error(e):
    return redirect(url_for('home.login'))

@home_bp.route("/registro", methods=["GET", "POST"])
def register():
    return Register().register()

@home_bp.route("/recuperar", methods=["GET", "POST"])
def recuperar_solicitar():
    return Recuperarcontraseña().solicitar_codigo()

@home_bp.route("/recuperar/verificar", methods=["GET", "POST"])
def recuperar_verificar():
    return Recuperarcontraseña().verificar_codigo()

@home_bp.route("/recuperar/nueva-contraseña", methods=["GET", "POST"])
def recuperar_nueva_contraseña():
    return Recuperarcontraseña().nueva_contraseña()

@home_bp.route("/politica_de_privacidad")
def privacy_policy():
    return render_template("home/privacy_policy.html")

@home_bp.route("/terminos_de_uso_y_compromisos")
def terms_of_use():
    return render_template("home/terms_of_use.html")