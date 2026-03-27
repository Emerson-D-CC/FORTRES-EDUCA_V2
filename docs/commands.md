CREACIÓN ENTORNO VIRTUAL
pip install virutalenv
py -m venv env

INICIAR EL ENTORNO VIRTUAL
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\env\Scripts\Activate.ps1

ACTIVAR EL SERVIDOR
python run.py


REQUERIMENTS
pip freeze > requirements.txt // Tomar librerias del env
pip install -r requirements.txt  // Instalar librerias del archivo requirements.txt