from flask_wtf import FlaskForm
from wtforms import StringField, SelectField, DateField, TelField, EmailField, HiddenField
from wtforms.validators import DataRequired, Length, Optional, Email


# =========================
# PERFIL - Acudiente
# =========================

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


# =========================
# PERFIL - Estudiante
# =========================

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

    
# =========================
# REGISTRO - Nuevo Estudiante
# =========================

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
