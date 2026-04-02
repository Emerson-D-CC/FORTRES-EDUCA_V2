from app.database.connection_db_v2 import db

# ====================================================================================================================================================
#                                           PAGINA PROFILE.HTML
# ====================================================================================================================================================

# POBLAR OPCIONES PARA EL CABIO DE DATOS

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


def sp_obtener_barrios():
    return db.call_procedure(
        "sp_tbl_barrio_consultar", 
        ()
    ) or []


def sp_obtener_parentesco_est():
    return db.call_procedure(
        "sp_tbl_parentesco_consultar_est",
        ()
    ) or []


def sp_obtener_parentesco_acu():
    return db.call_procedure(
        "sp_tbl_parentesco_consultar_acu",
        ()
    ) or []


def sp_verificar_estudiante_acudiente(id_acudiente):
    """Verifica si un acudiente ya tiene un estudiante registrado."""
    return db.call_procedure(
        "sp_tbl_estudiante_verificar_por_acudiente",
        (id_acudiente,)
    )

# PERFIL — Carga de datos

def sp_obtener_perfil_acudiente(id_usuario):
    resultado = db.call_procedure("sp_perfil_acudiente_consultar", (id_usuario,))
    return resultado[0] if resultado else None


def sp_obtener_perfil_estudiante(id_usuario):
    resultado = db.call_procedure("sp_perfil_estudiante_consultar", (id_usuario,))
    return resultado[0] if resultado else None


# TBL_PERSONA

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


# TBL_DATOS_ADICIONALES

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


# TBL_ESTUDIANTE

def sp_estudiante_existe(id_estudiante, id_usuario):
    return db.call_procedure(
        "sp_tbl_estudiante_verificar_existente",
        (id_estudiante, id_usuario)
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


# REGISTER (Acudiente)

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

# REGISTER (Acudiente)

def sp_registrar_estudiante(data):
    return db.call_procedure(
        "sp_registrar_estudiante_completo",
        data,
        commit=False
    )




# ====================================================================================================================================================
#                                           PAGINA SECURITY.HTML
# ====================================================================================================================================================
    
# CONTRASEÑA
 
def sp_cambiar_contrasena_perfil(id_usuario, hash_actual, nuevo_hash, nuevo_salt, ip, user_agent):
    """Valida la contraseña actual y actualiza a la nueva."""
    return db.call_procedure(
        "sp_tbl_usuario_cambiar_contrasena_perfil",
        (id_usuario, hash_actual, nuevo_hash, nuevo_salt, ip, user_agent),
        commit=False
    )

def sp_validar_data_user(username):
        return db.call_procedure(
        "sp_validar_data_user",
        (username,)
    )
        
# MFA

def sp_guardar_mfa_secret_temp(id_usuario, secret):
    """Guarda el secret temporal mientras el usuario no ha confirmado el código."""
    return db.call_procedure(
        "sp_tbl_usuario_guardar_mfa_secret_temp",
        (id_usuario, secret),
        commit=False
    )

def sp_activar_mfa(id_usuario):
    """Mueve el secret temporal al campo definitivo y activa 2FA."""
    return db.call_procedure(
        "sp_tbl_usuario_activar_mfa",
        (id_usuario,),
        commit=False
    )

def sp_desactivar_mfa(id_usuario):
    """Borra el secret y desactiva 2FA."""
    return db.call_procedure(
        "sp_tbl_usuario_desactivar_mfa",
        (id_usuario,),
        commit=False
    )

def sp_obtener_mfa_secret(id_usuario):
    """Devuelve el estado y secrets MFA del usuario."""
    return db.call_procedure(
        "sp_tbl_usuario_obtener_mfa_secret",
        (id_usuario,),
        commit=False
    )

# SISTEMA PARA VALIDAR SESIONES ACTIVAS

def sp_registrar_sesion(id_usuario, jti, dispositivo, ip):
    """Registra o actualiza una sesión activa."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_registrar_sesion",
        (id_usuario, jti, dispositivo, ip),
        commit=False
    )

def sp_listar_sesiones(id_usuario):
    """Lista las sesiones activas de un usuario."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_listar_sesiones",
        (id_usuario,),
        commit=False
    )

def sp_cerrar_sesion(jti):
    """Marca como inactiva una sesión por su JTI."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_cerrar_sesion",
        (jti,),
        commit=False
    )

def sp_cerrar_todas_sesiones(id_usuario, jti_actual):
    """Cierra todas las sesiones excepto la actual."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_cerrar_todas_sesiones",
        (id_usuario, jti_actual),
        commit=False
    )

def sp_verificar_jti(jti):
    """Verifica si un JTI está activo (para token blacklist)."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_verificar_jti",
        (jti,),
        commit=False
    )