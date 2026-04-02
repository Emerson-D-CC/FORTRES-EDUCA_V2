from app.database.connection_db_v2 import db



# ====================================================================================================================================================
#                                            DECORATORS.PY
# ====================================================================================================================================================
    
def sp_verificar_jti(jti):
    """Verifica si un JTI está activo (para token blacklist)."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_verificar_jti",
        (jti,),
        commit=False
    )

# ====================================================================================================================================================
#                                            SESSION.PY
# ====================================================================================================================================================
 

def sp_cerrar_sesion(jti):
    """Marca como inactiva una sesión por su JTI."""
    return db.call_procedure(
        "sp_tbl_sesion_activa_cerrar_sesion",
        (jti,),
        commit=False
    )
