import mysql.connector
from mysql.connector import Error

from app.settings import Config

class connection_db:

    def __init__(self):
        """Contructor de la clase"""

        # Configuración de conexión
        self.config = {
            "host": Config.DB_HOST,
            "port": Config.DB_PORT,
            "user": Config.DB_USER,
            "password": Config.DB_PASSWORD,
            "database": Config.DB_NAME,
        }

        self.connection = None
        self.connect()
        
        
    def connect(self):
        """Conectar a la base de datos"""       
        try:
            self.connection = mysql.connector.connect(**self.config)

            if self.connection.is_connected():
                print("[INFO] Conexión a MySQL establecida.")

        except Error as e:
            print(f"[ERROR] No se pudo conectar a MySQL: {e}")
            self.connection = None


    def ensure_connection(self):
        """Verificar conexión activa"""
        if self.connection is None or not self.connection.is_connected():
            print("[INFO] Reconectando a la base de datos...")
            self.connect()


    def call_procedure(self, nombre_sp, params=None, commit=False):
        """Ejecutar procedimiento almacenado"""
        self.ensure_connection()

        if params is None:
            params = ()

        try:
            cursor = self.connection.cursor(dictionary=True)

            cursor.callproc(nombre_sp, params)

            resultados = []

            # Leer resultados si el SP devuelve datos
            for result in cursor.stored_results():
                resultados.extend(result.fetchall())

            if commit:
                self.connection.commit()

            cursor.close()

            return resultados if resultados else None

        except Error as e:
            print(f"[ERROR] Fallo ejecutando SP '{nombre_sp}': {e}")
            return None
            
            
    def rollback(self):
        """Revierte la transacción activa."""
        try:
            if self.connection and self.connection.is_connected():
                self.connection.rollback()
        except Error as e:
            print(f"[ERROR] Fallo al hacer rollback: {e}")


    def commit(self):
        """Confirma la transacción activa."""
        try:
            if self.connection and self.connection.is_connected():
                self.connection.commit()
        except Error as e:
            print(f"[ERROR] Fallo al hacer commit: {e}")

    def close(self):
        """Cierra la conexión"""
        if self.connection and self.connection.is_connected():
            self.connection.close()
            print("[INFO] Conexión a MySQL cerrada.")
            
db = connection_db()