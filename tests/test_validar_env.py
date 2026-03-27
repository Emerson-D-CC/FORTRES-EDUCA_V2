import os
from pathlib import Path
from dotenv import load_dotenv

# Obtener la raíz del proyecto

# Cargar .env desde la raíz
load_dotenv('.env')

A = os.getenv("DB_HOST")
B = os.getenv("DB_USER")
C = os.getenv("DB_NAME")


print("HOST:", A)
print("USER:", B)
print("DB:", C)