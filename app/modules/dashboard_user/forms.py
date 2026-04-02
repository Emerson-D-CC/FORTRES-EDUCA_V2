from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, DateField, TelField, PasswordField
from wtforms.validators import DataRequired, Length, Optional, EqualTo, ValidationError

from app.core.regexs import regex


from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField
from wtforms.validators import DataRequired, Length, EqualTo, Regexp
# ====================================================================================================================================================
#                                           PAGINA PROFILE.HTML
# ====================================================================================================================================================

# PERFIL - Acudiente

class FormAcudienteDatosPersonales(FlaskForm):
    """Campos NO editables del acudiente (solo lectura, sin validación activa)."""

    primer_nombre = StringField("Primer Nombre")
    segundo_nombre = StringField("Segundo Nombre")
    primer_apellido = StringField("Primer Apellido")
    segundo_apellido = StringField("Segundo Apellido")
    tipo_identificacion = StringField("Tipo de Documento")
    numero_documento = StringField("Número de Documento")
    parentesco = StringField("Parentesco")
    fecha_creacion = StringField("Fecha de Registro")
    email = StringField("Correo Electrónico")

class FormAcudienteDatosEditables(FlaskForm):
    """Campos editables del acudiente."""

    telefono = TelField(
        "Teléfono / Celular",
        validators = [DataRequired(), Length(min=7, max=20)]
    )
    
    barrio = SelectField(
        "Barrio",
        validators = [DataRequired()],
        coerce = int
    )
    
    genero = SelectField(
        "Género",
        validators = [DataRequired()],
        coerce = int
    )

    grupo_preferencial = SelectField(
        "Grupo Preferencial",
        validators = [DataRequired()],
        coerce = int
    )

    estrato = SelectField(
        "Estrato",
        validators = [DataRequired()],
        coerce = int
    )


# PERFIL - Estudiante

class FormEstudianteDatosPersonales(FlaskForm):
    """Campos NO editables del estudiante en perfil."""

    tipo_identificacion = StringField("Tipo de Identificación")
    
    numero_documento = StringField("Número de Documento")


class FormEstudianteDatosEditables(FlaskForm):
    """Campos editables del estudiante en perfil."""

    primer_nombre = StringField(
        "Primer Nombre",
        validators = [DataRequired(), Length(max=50)]
    )

    segundo_nombre = StringField(
        "Segundo Nombre",
        validators = [Optional(), Length(max=50)]
    )

    primer_apellido = StringField(
        "Primer Apellido",
        validators = [DataRequired(), Length(max=50)]
    )

    segundo_apellido = StringField(
        "Segundo Apellido",
        validators = [Optional(), Length(max=50)]
    )

    fecha_nacimiento = DateField(
        "Fecha de Nacimiento",
        validators = [DataRequired()]
    )

    genero = SelectField(
        "Género",
        validators = [DataRequired()],
        coerce = int
    )

    grupo_preferencial = SelectField(
        "Grupo Preferencial",
        validators = [DataRequired()],
        coerce = int
    )

    grado_actual = SelectField(
        "Último Grado Aprobado",
        validators = [DataRequired()],
        coerce = int
    )

    grado_proximo = SelectField(
        "Grado a Cursar",
        validators = [DataRequired()],
        coerce = int
    )

    colegio_anterior = SelectField(
        "Última Institución Educativa",
        validators = [DataRequired()],
        coerce = int
    )

    
# REGISTRO - Nuevo Estudiante

class FormRegistroEstudiante(FlaskForm):
    """Formulario completo para registrar un nuevo estudiante."""

    # Datos de identidad (TBL_PERSONA)
    primer_nombre = StringField(
        "Primer Nombre",
        validators = [DataRequired(), Length(max=50)]
    )

    segundo_nombre = StringField(
        "Segundo Nombre",
        validators = [Optional(), Length(max=50)]
    )

    primer_apellido = StringField(
        "Primer Apellido",
        validators = [DataRequired(), Length(max=50)]
    )

    segundo_apellido = StringField(
        "Segundo Apellido",
        validators = [Optional(), Length(max=50)]
    )

    fecha_nacimiento = DateField(
        "Fecha de Nacimiento",
        validators = [DataRequired()]
    )

    # Datos del estudiante (TBL_ESTUDIANTE)
    tipo_identificacion = SelectField(
        "Tipo de Identificación",
        validators = [DataRequired()],
        coerce = int,
        choices = [],
        validate_choice = False
    )

    numero_documento = StringField(
        "Número de Documento",
        validators = [DataRequired(), Length(max=15)]
    )

    genero = SelectField(
        "Género",
        validators = [DataRequired()],
        coerce = int,
        choices = [],
        validate_choice = False
    )

    grupo_preferencial = SelectField(
        "Grupo Preferencial",
        validators = [DataRequired()],
        coerce = int,
        choices = [],
        validate_choice = False
    )

    grado_actual = SelectField(
        "Último Grado Aprobado",
        validators = [DataRequired()],
        coerce = int,
        choices = [],
        validate_choice = False
    )

    grado_proximo = SelectField(
        "Grado a Cursar",
        validators = [DataRequired()],
        coerce = int,
        choices = [],
        validate_choice = False
    )

    colegio_anterior = SelectField(
        "Última Institución Educativa",
        validators = [DataRequired()],
        coerce = int,
        choices = [],
        validate_choice = False
    )

    parentesco = SelectField(
        "Parentesco con el Acudiente",
        validators = [DataRequired()],
        coerce=str,
        choices = [],
        validate_choice = False
    )

# ====================================================================================================================================================
#                                           PAGINA SECURITY.HTML
# ====================================================================================================================================================


class FormCambiarContrasena(FlaskForm):
    """Formulario para cambiar la contraseña desde el perfil."""

    contrasena_actual = PasswordField(
        "Contraseña Actual",
        validators=[DataRequired(message="La contraseña actual es obligatoria.")]
    )

    nueva_contrasena = PasswordField(
        "Nueva Contraseña",
        validators=[
            DataRequired(message="La nueva contraseña es obligatoria."), 
            Length(min=12, max=255, message="Mínimo 12 caracteres.")
        ]
    )

    confirmar_contrasena = PasswordField(
        "Confirmar Nueva Contraseña",
        validators=[
            DataRequired(message="Confirme la nueva contraseña."),
            EqualTo("nueva_contrasena", message="Las contraseñas no coinciden.")
        ]
    )
    
    def validate_nueva_contrasena(self, field):
        errores = regex.contraseña_segura(field.data)
        if errores:
            mensaje = "La contraseña debe cumplir con: " + ", ".join(errores)
            raise ValidationError(mensaje)


class FormVerificarMFA(FlaskForm):
    """Formulario para confirmar un código TOTP al activar o autenticar 2FA."""

    codigo_mfa = StringField(
        "Código de verificación",
        validators=[DataRequired(message="Ingrese el código de 6 dígitos."), Length(min=6, max=6, message="El código debe tener exactamente 6 dígitos.")]
    )
    
    def validate_codigo_mfa(self, field):
        # regex.codigo_mfa retorna True si es válido (6 dígitos), False si es inválido
        if not regex.codigo_mfa(field.data):
            raise ValidationError("El código debe ser exactamente 6 dígitos numéricos.")