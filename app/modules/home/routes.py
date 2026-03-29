from flask import Blueprint, render_template
from .services import *

home_bp = Blueprint("home", __name__, url_prefix="/home")

@home_bp.route('/')
def public_home():
    return render_template('home/home.html')

@home_bp.route("/login", methods=["GET", "POST"])
def login():
    return Login().login()

@home_bp.route("/login_administradores", methods=["GET", "POST"])
def login_admin():
    return render_template('home/login_admin.html')

@home_bp.route("/logout")
def logout():
    return Login().logout()

@home_bp.route("/registro", methods=["GET", "POST"])
def register():
    return Register().register()

@home_bp.route("/recuperar", methods=["GET", "POST"])
def recuperar_solicitar():
    return RecuperarContrasena().solicitar_codigo()

@home_bp.route("/recuperar/verificar", methods=["GET", "POST"])
def recuperar_verificar():
    return RecuperarContrasena().verificar_codigo()

@home_bp.route("/recuperar/nueva-contrasena", methods=["GET", "POST"])
def recuperar_nueva_contrasena():
    return RecuperarContrasena().nueva_contrasena()

@home_bp.route("/politica_de_privacidad")
def privacy_policy():
    return render_template("home/privacy_policy.html")

@home_bp.route("/terminos_de_uso_y_compromisos")
def terms_of_use():
    return render_template("home/terms_of_use.html")