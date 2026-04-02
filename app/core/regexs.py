import re
import string


class regex:
    """
    Clase que centraliza todas las validaciones con expresiones regulares
    para ser usada de forma segura y reutilizable en toda la aplicación.
    """
    # ===========================
    # VALIDACIONES DE NOMBRES
    # ===========================
    @staticmethod
    def nombre(valor: str) -> bool:
        return bool(re.fullmatch(r"[A-Za-záéíóúÁÉÍÓÚÜüÑñ']{3,15}", valor.strip()))

    # ===========================
    # CORREOS ELECTRÓNICOS
    # ===========================
    @staticmethod
    def email_personal(valor: str) -> bool:
        return bool(re.fullmatch(r"[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+){1}", valor.strip()))

    @staticmethod
    def email_empresarial(valor: str) -> bool:
        return bool(re.fullmatch(r"[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,6}){2}", valor.strip()))

    # ===========================
    # NÚMEROS TELEFÓNICOS
    # ===========================
    @staticmethod
    def telefono_con_prefijo_celular(valor: str) -> bool:
        return bool(re.fullmatch(r"(\+57\s?)3\d{9}", valor.strip()))

    @staticmethod
    def telefono_con_prefijo_fijo(valor: str) -> bool:
        return bool(re.fullmatch(r"(\+57\s?)\d{7}", valor.strip()))

    @staticmethod
    def telefono_sin_prefijo_celular(valor: str) -> bool:
        return bool(re.fullmatch(r"3\d{9}", valor.strip()))

    @staticmethod
    def telefono_sin_prefijo_fijo(valor: str) -> bool:
        return bool(re.fullmatch(r"\d{7}", valor.strip()))

    # ===========================
    # DOCUMENTOS DE IDENTIDAD
    # ===========================
    @staticmethod
    def tipo_documento(valor: str) -> bool:
        return bool(re.fullmatch(r"(CC|TI|CE|NIT)", valor.strip(), re.IGNORECASE))

    @staticmethod
    def numero_identificacion(valor: str) -> bool:
        return bool(re.fullmatch(r"\d{5,10}", valor.strip()))

    # ===========================
    # GRUPO SANGUÍNEO
    # ===========================
    @staticmethod
    def grupo_sanguineo(valor: str) -> bool:
        return bool(re.fullmatch(r"(A|B|AB|O)[+-]", valor.strip()))
    
    # ===========================
    # GÉNERO
    # ===========================
    @staticmethod
    def genero_persona(valor: str) -> bool:
        return bool(re.compile(r"^(Masculino|Femenino|No Binario|Otro|Prefiero no decirlo)$", valor.strip(), re.IGNORECASE))

    # ===========================
    # DIRECCIONES
    # ===========================
    @staticmethod
    def direccion(valor: str) -> bool:
        # Función que valida las direcciones de Bogotá D.C. con varios regex
        return bool(re.compile(
            # Expresión regular para validar direcciones  en Bogotá D.C.
            r"^(?:(Cl|Cll|Calle|Cra|Kr|Kra|Carrera|Av|Avenida|Tv|Transv|Transversal|Dg|Diag|Diagonal))\.?\s*" \
            r"\d{1,3}[A-Za-z]?(?:\s*Bis)?(?:\s*(Norte|Sur|Este|Oeste|N|S|E|O))?" \
            r"\s*#\s*\d{1,3}[A-Za-z]?(?:\s*[A-Za-z0-9]+)?(?:\s*-\s*\d{1,3}[A-Za-z0-9]*)?" \
            r"(?:\s*(?:Mz|Manzana)\s*[A-Za-z0-9]+\s*(?:Casa|Cs|Apartamento|Apto|Bloque|Blq)\s*\d{1,3}[A-Za-z]?)?$", valor.strip(), re.IGNORECASE))

    # ===========================
    # USUARIO
    # ===========================
    @staticmethod
    def usuario(valor: str) -> bool:
        return bool(re.fullmatch(r"[A-Za-z0-9_-]{3,15}", valor.strip()))

    # ===========================
    # CONTRASEÑAS
    # ===========================
    @staticmethod
    def contraseña_segura(contraseña: str) -> list:
        errores = []
        if len(contraseña) < 10:
            errores.append("Debe tener mínimo 10 caracteres.")
        if not any(c.isupper() for c in contraseña):
            errores.append("Debe contener mínimo una letra mayúscula.")
        if not any(c.islower() for c in contraseña):
            errores.append("Debe contener mínimo una letra minúscula.")
        if not any(c.isdigit() for c in contraseña):
            errores.append("Debe contener mínimo un número.")
        if not any(c in string.punctuation for c in contraseña):
            errores.append("Debe contener mínimo un carácter especial.")
        if ' ' in contraseña:
            errores.append("No debe contener espacios en blanco.")
        return errores

    # ===========================
    # MFA
    # ===========================
    @staticmethod
    def codigo_mfa(valor: str) -> bool:
        return bool(re.fullmatch(r"^\d{6}$", valor.strip()))