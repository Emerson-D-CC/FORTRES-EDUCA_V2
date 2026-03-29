from app import create_app
from .connection_db_test import db 

app = create_app()

with app.app_context():
    def test_connection():
        print("\n=== TEST CONEXIÓN ===")
        if db.connection and db.connection.is_connected():
            print("Conexión exitosa a la BD")
        else:
            print("No hay conexión")


    def test_insert_persona():
        print("\n=== TEST PROCEDIMIENTO INSERT ===")

        try:
            resultado_1 = db.call_procedure(
                "sp_tbl_persona_insertar",
                (
                    "1019652358",
                    "Daniel",
                    "Esteban",
                    "Pinto",
                    "Nuñez",
                    "2000-01-01",
                ),
                commit=True
            )
            
            resultado_2 = db.call_procedure(
                "sp_tbl_datos_adicionales_insertar",
                (
                    "D1019652358",
                    "daniel@gmail.com",
                    "3004506985",
                    "Padre",
                    1,
                    "1019652358",
                    1,
                    1,
                    1,
                    1
                ),
                commit=True
            )

            # 1USUARIO 
            resultado_3 = db.call_procedure(
                "sp_tbl_usuario_insertar",
                (
                    "U1019652358",
                    "Esteban Pinto",
                    "0x89504E47",
                    "0x89504E470D0A1A0A000000",
                    "INACTIVE",
                    1,
                    "1019652358",
                    2
                ),
                commit=True
            )

            print("Procedimiento ejecutado correctamente")
            print("Resultado:", resultado_1)
            print("Resultado:", resultado_2)
            print("Resultado:", resultado_3)


        except Exception as e:
            print("Error ejecutando procedimiento:", e)


    def test_select_persona():
        print("\n=== TEST PROCEDIMIENTO SELECT ===")

        resultado = db.call_procedure(
            "sp_tbl_parentesco_consultar_acu"
        )

        if resultado:
            for row in resultado:
                print(row)
        else:
            print("No hay datos o el SP no retornó resultados")


if __name__ == "__main__":
    test_connection()
    # test_insert_persona()
    test_select_persona()
    db.close()
    
# Llamar test: python -m tests.test_procedures