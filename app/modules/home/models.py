from app.database.connection_db_v2 import db

# ====================================================================================================================================================
#                                           PAGINA LOGIN.HTML
# ====================================================================================================================================================

# DECORADORES

def sp_obtener_roles(nombre_rol):
    try:

        resultado = db.call_procedure("sp_tbl_rol_consultar_nombre", (nombre_rol,)) or []

        if not resultado:
            print(f"[WARNING] Rol '{nombre_rol}' no encontrado en BD")
            return None

        return resultado[0]["ID_Rol"]

    except Exception as e:
        print(f"[ERROR] No se pudo consultar rol '{nombre_rol}': {e}")
        return None

# VALIDACIONES PARA EL INICIO DE SESIÓN

def sp_validar_data_user(username):
        return db.call_procedure(
        "sp_validar_data_user",
        (username,)
    )

def sp_validar_login(username, password):
    return db.call_procedure(
        "sp_tbl_usuario_validar_login",
        (username, password)
    )

def sp_auditoria_sesion(id_usuario, ip, evento, navegador):
    return db.call_procedure(
        "sp_auditoria_sesion",
        (id_usuario, ip, evento, navegador)
    )

def sp_registrar_sesion(id_usuario, jti, dispositivo, ip):
    """Registra o actualiza una sesión activa."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_registrar_sesion",
        (id_usuario, jti, dispositivo, ip),
        commit=False
    )

# Cerrar sesión
def sp_cerrar_sesion(jti):
    """Marca como inactiva una sesión por su JTI."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_cerrar_sesion",
        (jti,),
        commit=False
    )


# ====================================================================================================================================================
#                                           PAGINA VERIFY_MFA.HTML
# ====================================================================================================================================================


def sp_obtener_mfa_secret(id_usuario):
    """Devuelve el estado y secrets MFA del usuario."""
    return db.call_procedure(
        "sp_tbl_usuario_obtener_mfa_secret",
        (id_usuario,),
        commit=False
    )

# ====================================================================================================================================================
#                                           PAGINA REGISTER.HTML
# ====================================================================================================================================================

# POBLAR OPCIONES DEL REGISTRO

def sp_obtener_barrios():
    return db.call_procedure(
        "sp_tbl_barrio_consultar", 
        ()
    ) or []


def sp_obtener_parentesco_acu():
    return db.call_procedure(
        "sp_tbl_parentesco_consultar_acu", 
        ()
    ) or []
    
    
def sp_obtener_tipos_documento():
    return db.call_procedure(
        "sp_tbl_tipo_identificacion_consultar_acu", 
        ()
    ) or []


def sp_usuario_existe(email, persona_id):
    return db.call_procedure(
        "sp_usuario_verificar_existente",
        (email, persona_id)
    )

# REGISTRAR AL USUARIO

def sp_registrar_usuario(data):
    return db.call_procedure(
        "sp_registrar_usuario_completo",
        data,
        commit=False
    )
    
# ====================================================================================================================================================
#                                           PAGINA RECOVER_PASSWORD.HTML
# ====================================================================================================================================================

def sp_obtener_email_por_username(username):
    """Obtiene el email asociado a un usuario (username = correo en este sistema)."""
    result = db.call_procedure(
        "sp_usuario_obtener_email",
        (username,),
        commit=True
    )
    return result[0]["Email"] if result else None


def sp_actualizar_contrasena(username, nuevo_hash, nuevo_salt):
    """Actualiza el hash y salt de la contraseña del usuario."""
    return db.call_procedure(
        "sp_usuario_recuperar_contrasena",
        (username, nuevo_hash, nuevo_salt),
        commit=False
    )