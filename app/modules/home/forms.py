from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SelectField, BooleanField
from wtforms.validators import DataRequired, Length, Email, EqualTo, ValidationError

from app.core.regexs import regex


class LoginForm(FlaskForm):

    username = StringField(
        "Usuario",
        validators=[DataRequired(), Length(min=3, max=100), Email()]
    )
    
    password = PasswordField(
        "Contraseña",
        validators=[DataRequired(), Length(min=6, max=255)]
    )


class RegisterForm(FlaskForm):

    # Datos personales 
    primer_nombre = StringField(
        "Primer Nombre",
        validators=[DataRequired(), Length(min=2, max=50)]
    )

    segundo_nombre = StringField(
        "Segundo Nombre",
        validators=[Length(max=50)]
    )

    primer_apellido = StringField(
        "Primer Apellido",
        validators=[DataRequired(), Length(min=2, max=50)]
    )

    segundo_apellido = StringField(
        "Segundo Apellido",
        validators=[Length(max=50)]
    )

    tipo_documento = SelectField(
        "Tipo Documento",
        validators=[DataRequired()],
        coerce=str,
        choices=[]
    )

    documento = StringField(
        "Documento",
        validators=[DataRequired(), Length(min=5, max=15)]
    )

    parentesco = SelectField(
        "Parentesco con el Menor",
        validators=[DataRequired()],
        coerce=str,
        choices=[]
    )

    telefono = StringField(
        "Teléfono",
        validators=[DataRequired(), Length(min=7, max=15)]
    )

    email = StringField(
        "Correo",
        validators=[DataRequired(), Email(), Length(max=255)]
    )

    direccion = StringField(
        "Dirección",
        validators=[DataRequired(), Length(max=255)]
    )

    barrio = SelectField(
        "Barrio",
        validators=[DataRequired()],
        coerce=int,
        choices=[]
    )

    # Seguridad 
    password = PasswordField(
        "Contraseña",
        validators=[DataRequired(), Length(min=12, max=255)]
    )

    confirm_password = PasswordField(
        "Confirmar contraseña",
        validators=[
            DataRequired(),
            EqualTo("password", message="Las contraseñas no coinciden")
        ]
    )

    terms = BooleanField(
        "Aceptación de términos",
        validators=[DataRequired()])

    def validate_documento(self, field):
        if not regex.numero_identificacion(field.data):
            raise ValidationError("El documento debe contener solo números (5-10 dígitos).")

    def validate_telefono(self, field):
        if not regex.telefono_sin_prefijo_celular(field.data):
            raise ValidationError("El teléfono debe ser un número de celular válido (10 dígitos, comienza con 3).")

    def validate_password(self, field):
        errores = regex.contraseña_segura(field.data)
        if errores:
            mensaje = "La contraseña debe cumplir con: " + ", ".join(errores)
            raise ValidationError(mensaje)
        

class RecuperarContrasenaForm(FlaskForm):
    username = StringField(
        "Correo Electrónico",
        validators=[DataRequired(), Length(min=3, max=100), Email()]
    )

class VerificarCodigoForm(FlaskForm):
    codigo = StringField(
        "Código de Verificación",
        validators=[DataRequired(), Length(min=6, max=6)]
    )

class NuevaContrasenaForm(FlaskForm):
    password = PasswordField(
        "Nueva Contraseña",
        validators=[DataRequired(), Length(min=6, max=255)]
    )
    confirmar_password = PasswordField(
        "Confirmar Contraseña",
        validators=[DataRequired(), EqualTo("password", message="Las contraseñas no coinciden.")]
    )