import unittest
from app.core.regexs import *

class TestValidaciones(unittest.TestCase):

    def test_Validar_Nombre(self):
        # Casos erróneos
        self.assertFalse(regex.nombre("Lu"))
        self.assertFalse(regex.nombre("Luis123"))
        self.assertFalse(regex.nombre("Luis@"))
        self.assertFalse(regex.nombre("Luis Eduardo"))
        self.assertFalse(regex.nombre("aaaaaaaaaaaaaaaa"))

        # Casos correctos
        self.assertTrue(regex.nombre("Luis"))
        self.assertTrue(regex.nombre("Eduardo"))
        self.assertTrue(regex.nombre("José"))
        self.assertTrue(regex.nombre("Ángel"))

        # Caso vacío
        self.assertFalse(regex.nombre(""))

    def test_Validar_Email_Personal(self):
        # Casos erróneos
        self.assertFalse(regex.email_personal("luis@gmail"))
        self.assertFalse(regex.email_personal("luis@gmail.com.co"))
        self.assertFalse(regex.email_personal("luis@gmail..com"))
        self.assertFalse(regex.email_personal("luisgmail.com"))
        self.assertFalse(regex.email_personal("luis @gmail.com"))

        # Casos correctos
        self.assertTrue(regex.email_personal("luis@gmail.com"))
        self.assertTrue(regex.email_personal("eduardo@hotmail.es"))
        self.assertTrue(regex.email_personal("jose.perez@outlook.com"))
        self.assertTrue(regex.email_personal("angel_123@yahoo.com"))

        # Caso vacío
        self.assertFalse(regex.email_personal(""))

    def test_Validar_Email_Empresarial(self):
        # Casos erróneos
        self.assertFalse(regex.email_empresarial("luis@empresa"))
        self.assertFalse(regex.email_empresarial("luis@empresa.com"))
        self.assertFalse(regex.email_empresarial("luis@empresa.com.co.net"))
        self.assertFalse(regex.email_empresarial("luis @empresa.com.co"))

        # Casos correctos
        self.assertTrue(regex.email_empresarial("luis@empresa.edu.co"))
        self.assertTrue(regex.email_empresarial("eduardo@sena.com.co"))
        self.assertTrue(regex.email_empresarial("jose.perez@universidad.edu.co"))

        # Caso vacío
        self.assertFalse(regex.email_empresarial(""))

    def test_Validar_Numero_Con_Prefijo_Celular(self):
        # Casos erróneos
        self.assertFalse(regex.telefono_con_prefijo_celular("3001234567"))
        self.assertFalse(regex.telefono_con_prefijo_celular("+57 1234567"))
        self.assertFalse(regex.telefono_con_prefijo_celular("+57 300123456"))
        self.assertFalse(regex.telefono_con_prefijo_celular("+57 30012345678"))
        self.assertFalse(regex.telefono_con_prefijo_celular("57 3001234567"))

        # Casos correctos
        self.assertTrue(regex.telefono_con_prefijo_celular("+573001234567"))
        self.assertTrue(regex.telefono_con_prefijo_celular("+57 3001234567"))
        self.assertTrue(regex.telefono_con_prefijo_celular("+573219876543"))

        # Caso vacío
        self.assertFalse(regex.telefono_con_prefijo_celular(""))

    def test_Validar_Numero_Con_Prefijo_Telefono(self):
        # Casos erróneos
        self.assertFalse(regex.telefono_con_prefijo_fijo("1234567"))
        self.assertFalse(regex.telefono_con_prefijo_fijo("+57 3001234567"))
        self.assertFalse(regex.telefono_con_prefijo_fijo("+57 123456"))
        self.assertFalse(regex.telefono_con_prefijo_fijo("+57 12345678"))
        self.assertFalse(regex.telefono_con_prefijo_fijo("57 1234567"))

        # Casos correctos
        self.assertTrue(regex.telefono_con_prefijo_fijo("+571234567"))
        self.assertTrue(regex.telefono_con_prefijo_fijo("+57 1234567"))
        self.assertTrue(regex.telefono_con_prefijo_fijo("+577654321"))

        # Caso vacío
        self.assertFalse(regex.telefono_con_prefijo_fijo(""))

    def test_Validar_Numero_Sin_Prefijo_Celular(self):
        # Casos erróneos
        self.assertFalse(regex.telefono_sin_prefijo_celular("+573001234567"))
        self.assertFalse(regex.telefono_sin_prefijo_celular("1234567"))
        self.assertFalse(regex.telefono_sin_prefijo_celular("300123456"))
        self.assertFalse(regex.telefono_sin_prefijo_celular("30012345678"))

        # Casos correctos
        self.assertTrue(regex.telefono_sin_prefijo_celular("3001234567"))
        self.assertTrue(regex.telefono_sin_prefijo_celular("3219876543"))

        # Caso vacío
        self.assertFalse(regex.telefono_sin_prefijo_celular(""))

    def test_Validar_Numero_Sin_Prefijo_Telefono(self):
        # Casos erróneos
        self.assertFalse(regex.telefono_sin_prefijo_fijo("+571234567"))
        self.assertFalse(regex.telefono_sin_prefijo_fijo("3001234567"))
        self.assertFalse(regex.telefono_sin_prefijo_fijo("123456"))
        self.assertFalse(regex.telefono_sin_prefijo_fijo("12345678"))

        # Casos correctos
        self.assertTrue(regex.telefono_sin_prefijo_fijo("1234567"))
        self.assertTrue(regex.telefono_sin_prefijo_fijo("7654321"))

        # Caso vacío
        self.assertFalse(regex.telefono_sin_prefijo_fijo(""))

    def test_Validar_Direccion(self):
        # Casos erróneos
        self.assertFalse(regex.direccion("Calle 123"))
        self.assertFalse(regex.direccion("Cra 45 # 67"))

        # Casos correctos
        self.assertTrue(regex.direccion("Calle 123 # 45 - 67"))
        self.assertTrue(regex.direccion("Cra 45 # 67 - 89"))
        self.assertTrue(regex.direccion("Av 1 # 23 - 45"))
        self.assertTrue(regex.direccion("Dg 78 # 90 - 12"))
        self.assertTrue(regex.direccion("Cll 100 # 1 - 2"))

        # Caso vacío
        self.assertFalse(regex.direccion(""))

    def test_Validar_Tipo_Documento(self):
        # Casos erróneos
        self.assertFalse(regex.tipo_documento("Cedula"))
        self.assertFalse(regex.tipo_documento("tarjeta"))
        self.assertFalse(regex.tipo_documento("Pasaporte"))
        self.assertFalse(regex.tipo_documento("OTRO"))

        # Casos correctos
        self.assertTrue(regex.tipo_documento("CC"))
        self.assertTrue(regex.tipo_documento("TI"))
        self.assertTrue(regex.tipo_documento("CE"))
        self.assertTrue(regex.tipo_documento("NIT"))
        self.assertTrue(regex.tipo_documento("cc"))

        # Caso vacío
        self.assertFalse(regex.tipo_documento(""))

    def test_Validar_Num_ID(self):
        # Casos erróneos
        self.assertFalse(regex.numero_identificacion("1234"))
        self.assertFalse(regex.numero_identificacion("12345678901"))
        self.assertFalse(regex.numero_identificacion("1234567a"))
        self.assertFalse(regex.numero_identificacion("123 456 789"))

        # Casos correctos
        self.assertTrue(regex.numero_identificacion("12345"))
        self.assertTrue(regex.numero_identificacion("1234567890"))
        self.assertTrue(regex.numero_identificacion("1029384756"))

        # Caso vacío
        self.assertFalse(regex.numero_identificacion(""))

    def test_Validar_Genero(self):
        # Casos erróneos
        self.assertFalse(regex.genero_persona("Hombre"))
        self.assertFalse(regex.genero_persona("Mujer"))
        self.assertFalse(regex.genero_persona("helicoptero apache"))

        # Casos correctos
        self.assertTrue(regex.genero_persona("Masculino"))
        self.assertTrue(regex.genero_persona("Femenino"))
        self.assertTrue(regex.genero_persona("No Binario"))
        self.assertTrue(regex.genero_persona("Otro"))
        self.assertTrue(regex.genero_persona("Prefiero no decirlo"))
        self.assertTrue(regex.genero_persona("masculino"))

        # Caso vacío
        self.assertFalse(regex.genero_persona(""))

    def test_Validar_Grupo_Sanguineo(self):
        # Casos erróneos
        self.assertFalse(regex.grupo_sanguineo("A"))
        self.assertFalse(regex.grupo_sanguineo("B+ "))
        self.assertFalse(regex.grupo_sanguineo("C+"))
        self.assertFalse(regex.grupo_sanguineo("O- positivo"))

        # Casos correctos
        self.assertTrue(regex.grupo_sanguineo("A+"))
        self.assertTrue(regex.grupo_sanguineo("A-"))
        self.assertTrue(regex.grupo_sanguineo("B+"))
        self.assertTrue(regex.grupo_sanguineo("B-"))
        self.assertTrue(regex.grupo_sanguineo("AB+"))
        self.assertTrue(regex.grupo_sanguineo("AB-"))
        self.assertTrue(regex.grupo_sanguineo("O+"))
        self.assertTrue(regex.grupo_sanguineo("O-"))

        # Caso vacío
        self.assertFalse(regex.grupo_sanguineo(""))

    def test_Validar_Usuario(self):
        # Casos erróneos
        self.assertFalse(regex.usuario("lu"))
        self.assertFalse(regex.usuario("luis eduardo"))
        self.assertFalse(regex.usuario("luis@eduardo"))
        self.assertFalse(regex.usuario("aaaaaaaaaaaaaaaa"))

        # Casos correctos
        self.assertTrue(regex.usuario("luis"))
        self.assertTrue(regex.usuario("luis_eduardo"))
        self.assertTrue(regex.usuario("luis-eduardo"))
        self.assertTrue(regex.usuario("luis123"))

        # Caso vacío
        self.assertFalse(regex.usuario(""))

    def test_Validar_Contraseña_1(self):
        # Casos erróneos
        self.assertFalse(regex.contraseña_segura("1234567"))
        self.assertFalse(regex.contraseña_segura("abcdefgh"))
        self.assertFalse(regex.contraseña_segura("ABCDEFGH"))
        self.assertFalse(regex.contraseña_segura("12345678"))
        self.assertFalse(regex.contraseña_segura("!@#$%^&*"))
        self.assertFalse(regex.contraseña_segura("Abcdefg1"))
        self.assertFalse(regex.contraseña_segura("Abcdefg!"))
        self.assertFalse(regex.contraseña_segura("abcdefg1!"))
        self.assertFalse(regex.contraseña_segura("ABCDEFG1!"))

        # Casos correctos
        self.assertTrue(regex.contraseña_segura("Abcdefg1!"))
        self.assertTrue(regex.contraseña_segura("12345678Aa!"))
        self.assertTrue(regex.contraseña_segura("!@#$Asdf1234"))

        # Caso vacío
        self.assertFalse(regex.contraseña_segura(""))


if __name__ == '__main__':
    unittest.main(verbosity=2)

