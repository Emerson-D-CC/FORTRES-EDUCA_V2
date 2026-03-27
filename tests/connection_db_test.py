import mysql.connector
from mysql.connector import Error

from app.settings import Config

class connection_db:
    # Contructor de la clase
    def __init__(self):

        # Configuración de conexión
        self.config = {
            "host": "127.0.0.1",
            "port": 3306,
            "user": "root",
            "password": "MySQL1234",
            "database": "fortress_educa_db",
        }

        self.connection = None
        self.connect()
        
    # Conectar a la base de datos
    def connect(self):        
        try:
            self.connection = mysql.connector.connect(**self.config)

            if self.connection.is_connected():
                print("[INFO] Conexión a MySQL establecida.")

        except Error as e:
            print(f"[ERROR] No se pudo conectar a MySQL: {e}")
            self.connection = None

    # Verificar conexión activa
    def ensure_connection(self):

        if self.connection is None or not self.connection.is_connected():
            print("[INFO] Reconectando a la base de datos...")
            self.connect()

    # Ejecutar procedimiento almacenado
    def call_procedure(self, nombre_sp, params=None, commit=False):

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

    # Cerrar conexión
    def close(self):

        if self.connection and self.connection.is_connected():
            self.connection.close()
            print("[INFO] Conexión a MySQL cerrada.")

db = connection_db()