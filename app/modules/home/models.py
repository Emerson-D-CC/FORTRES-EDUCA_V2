from app.database.connection_db_v2 import db

# =========================
# DECORADORES
# =========================

def sp_obtener_roles(nombre_rol):
    try:

        resultado = db.call_procedure("sp_tbl_rol_consultar_nombre", (nombre_rol,)) or []

        if not resultado:
            print(f"[WARNING] Rol '{nombre_rol}' no encontrado en BD")
            return None

        # Retornar el ID escalar, no la lista completa
        return resultado[0]["ID_Rol"]

    except Exception as e:
        print(f"[ERROR] No se pudo consultar rol '{nombre_rol}': {e}")
        return None

# =========================
# LOGIN
# =========================

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


# =========================
# REGISTER
# =========================

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


# def sp_insertar_persona(data):
#     return db.call_procedure(
#         "sp_tbl_persona_insertar",
#         data,
#         commit=False
#     )


# def sp_insertar_datos_adicionales(data):
#     return db.call_procedure(
#         "sp_tbl_datos_adicionales_insertar",
#         data,
#         commit=False
#     )


# def sp_insertar_usuario(data):
#     return db.call_procedure(
#         "sp_tbl_usuario_insertar",
#         data,
#         commit=False
#     )
    
# SP para registrar todos los datos
def sp_registrar_usuario(data):
    return db.call_procedure(
        "sp_registrar_usuario_completo",
        data,
        commit=False
    )
    
# =========================
# RECOVER PASSWORD
# =========================

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