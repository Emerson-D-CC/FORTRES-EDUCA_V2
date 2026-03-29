
import pandas as pd
from datetime import datetime


class DataFrameManager:
    def __init__(self, db):
        """
        Inicializa el manejador con la conexión a BD.
        
        :param db: Instancia de connection_db
        """
        self.db = db


    def cargar_usuarios(self):
        """
        Carga los usuarios desde un procedimiento almacenado
        y los convierte en un DataFrame.
        """
        try:
            data = self.db.call_procedure("sp_listar_usuarios")

            df = pd.DataFrame(data, columns=[
                "ID_Usuario",
                "Nombre",
                "Email",
                "Estado",
                "Fecha_Registro"
            ])

            return df

        except Exception as e:
            print(f"Error cargando usuarios: {e}")
            return pd.DataFrame()


    def filtrar_usuarios_activos(self, df):
        """
        Retorna solo usuarios activos.
        """
        return df[df["Estado"] == "ACTIVO"]


    def buscar_usuario_por_email(self, df, email):
        """
        Búsqueda optimizada dentro del DataFrame.
        """
        resultado = df[df["Email"] == email]
        return resultado.to_dict(orient="records")


    def estadisticas_usuarios(self, df):
        """
        Genera estadísticas básicas.
        """
        stats = {
            "total": len(df),
            "activos": len(df[df["Estado"] == "ACTIVO"]),
            "inactivos": len(df[df["Estado"] == "INACTIVO"]),
        }

        return stats


    def ordenar_por_fecha(self, df, ascendente=False):
        """
        Ordena usuarios por fecha de registro.
        """
        df["Fecha_Registro"] = pd.to_datetime(df["Fecha_Registro"])
        return df.sort_values(by="Fecha_Registro", ascending=ascendente)

    # ==============================
    # 6. EXPORTACIÓN A EXCEL
    # ==============================
    def exportar_excel(self, df, nombre_archivo=None):
        """
        Exporta el DataFrame a un archivo Excel.
        """
        if not nombre_archivo:
            nombre_archivo = f"reporte_usuarios_{datetime.now().strftime('%Y%m%d_%H%M%S')}.xlsx"

        df.to_excel(nombre_archivo, index=False)

        return nombre_archivo

    # ==============================
    # 7. PAGINACIÓN (IMPORTANTE)
    # ==============================
    def paginar(self, df, pagina=1, tamano=10):
        """
        Permite manejar grandes volúmenes de datos en bloques.
        """
        inicio = (pagina - 1) * tamano
        fin = inicio + tamano

        return df.iloc[inicio:fin]

    # ==============================
    # 8. LIMPIEZA DE DATOS
    # ==============================
    def limpiar_datos(self, df):
        """
        Limpia valores nulos o inconsistentes.
        """
        df = df.dropna()
        df = df.drop_duplicates()

        return df

    # ==============================
    # 9. CONVERSIÓN A JSON (API)
    # ==============================
    def convertir_a_json(self, df):
        """
        Convierte el DataFrame a formato JSON para respuestas API.
        """
        return df.to_dict(orient="records")