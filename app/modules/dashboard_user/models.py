from app.database.connection_db_v2 import db


# =========================
# OBSIONES GENERALES
# =========================

def sp_obtener_generos():
    return db.call_procedure(
        "sp_tbl_genero_consultar",
        ()
    ) or []


def sp_obtener_grupos_preferenciales():
    return db.call_procedure(
        "sp_tbl_grupo_preferencial_consultar",
        ()
    ) or []


def sp_obtener_grados():
    return db.call_procedure(
        "sp_tbl_grado_consultar",
        ()
    ) or []


def sp_obtener_colegios():
    return db.call_procedure(
        "sp_tbl_colegio_consultar",
        ()
    ) or []


def sp_obtener_tipos_identificacion():
    return db.call_procedure(
        "sp_tbl_tipo_identificacion_consultar_est",
        ()
    ) or []


def sp_obtener_estratos():
    return db.call_procedure(
        "sp_tbl_estrato_consultar",
        ()
    ) or []


def sp_obtener_localidades():
    return db.call_procedure(
        "sp_tbl_localidad_consultar",
        ()
    ) or []


def sp_verificar_estudiante_acudiente(id_acudiente):
    """Verifica si un acudiente ya tiene un estudiante registrado."""
    return db.call_procedure(
        "sp_tbl_estudiante_verificar_por_acudiente",
        (id_acudiente,)
    )

# =========================
# TBL_PERSONA
# =========================

def sp_insertar_persona(data):
    return db.call_procedure(
        "sp_tbl_persona_insertar",
        data,
        commit=False
    )


def sp_actualizar_persona(data):
    return db.call_procedure(
        "sp_tbl_persona_actualizar",
        data,
        commit=False
    )


# =========================
# TBL_DATOS_ADICIONALES
# =========================

def sp_insertar_datos_adicionales(data):
    return db.call_procedure(
        "sp_tbl_datos_adicionales_insertar",
        data,
        commit=False
    )


def sp_actualizar_datos_adicionales(data):
    return db.call_procedure(
        "sp_tbl_datos_adicionales_actualizar",
        data,
        commit=False
    )


# =========================
# TBL_ESTUDIANTE
# =========================

def sp_estudiante_existe(id_estudiante):
    return db.call_procedure(
        "sp_tbl_estudiante_verificar_existente",
        (id_estudiante,)
    )


def sp_insertar_estudiante(data):
    return db.call_procedure(
        "sp_tbl_estudiante_insertar",
        data,
        commit=False
    )


def sp_actualizar_estudiante(data):
    return db.call_procedure(
        "sp_tbl_estudiante_actualizar",
        data,
        commit=False
    )


# =========================
# REGISTER (Acudiente)
# =========================

def sp_usuario_existe(email, persona_id):
    return db.call_procedure(
        "sp_usuario_verificar_existente",
        (email, persona_id)
    )


def sp_insertar_usuario(data):
    return db.call_procedure(
        "sp_tbl_usuario_insertar",
        data,
        commit=False
    )