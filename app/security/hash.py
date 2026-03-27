import hashlib
import secrets

from app.settings import Config


def generar_salt() -> bytes:
    """Genera un salt aleatorio de 16 bytes criptográficamente seguro."""
    return secrets.token_bytes(16)


def hashear_contrasena(password: str, salt: bytes) -> bytes:
    """ Genera el hash SHA-256 de una contraseña usando salt + password + pepper. """
    
    pepper: str | bytes = Config.PEPPER

    # Normalizar tipos — todo debe ser bytes antes de concatenar
    if isinstance(password, str):
        password = password.encode("utf-8")
    if isinstance(pepper, str):
        pepper = pepper.encode("utf-8")
    if isinstance(salt, str):
        salt = salt.encode("utf-8")

    # salt + password + pepper
    return hashlib.sha256(salt + password + pepper).digest()