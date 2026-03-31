VERSIÓN 4.0
1. Implementación de modals globales: Modal Obligatorio y Modal Informativo

2. Reestructuración de la base de datos:
    - Creación de TBL_PARENTESCO
    - Modificación de TBL_USUARIO, TBL_DATOS_ADICIONALES, TBL_COLEGIO a nivel de FK
    - Modificación de todos los SP de las tablas mensionadas.

3. Creación de los siguientes templates:
    - terms_of_use.html
    - register_student.html

4. Creación de todo el sistema para el registro del estudiante del acudiente. Paso obligatorio para el usuario para  continuar con el programa

5. Creación de SP y decoradores para validar si el usuario cuenta con un estudiante registrado

6. Modificación del registro del usuario. Ahora en vez de registrar la localidad, se registra el barrio del usuario. Además, de moficación a la logica de todas las casillas de las listas tomadas de la DB.

7. Creación de cádigo para la conexión de la base de datos experimental.  Funciones de commit y rollback independientes para mayor control (sin novedades de mal funcionamiento por el momento)

8. Creación de la lógica del archivo profile.html para la actualización de datos del acudiente y el estudiante. Nota: No se valido funcionamiento.

---------------------------------------------------------------------
VERSIÓN 3.7
1. Implementación de Sistema de recuperación de contraseña con uso de Flask-Mail.
    
    1.1. Creación de nuevos procedures para la función de recuperación de contraseña. Se encuentran en docs/db/procedures.sql

2. Se filtro y creo una función reutilizable para el tema del hash de las contraseñas. La función sirve para login, registro y recuperar contraseña
Ubicación app/secutity/hash.py

3. Se modifico el diseño del modal general, de danger a info.
NOTA: Validar si crear más modales para diferentes contexto o intentar adaptar el actual para que sea modular

4. Se creo pagina para las Politicas de Privacidad. Acceso desde el fotter de home.

---------------------------------------------------------------------
VERSIÓN 3.6.2
1. Corrección e implementación de reCAPTCHA en login y registro. Funcionamiento validado.
Error: La implementación de reCAPTCHA en registro esta causando fallas en los campos de contraseña y confirmación_contraseña respecto a sus efectos dados por home.js.

2. Corrección de Modal flash

3. Implementación de extención para mantener en todas las paginas los valores del header (Nombre Usuario e Iniciales) cuando el usuario se logea.
NOTA: Si el error_handler no funciona es porque comentarie su instancia en __init__.py para saber de forma más directa si habia un error en el programa.

---------------------------------------------------------------------
VERSIÓN 3.6
1. Todo el sistema de rutas corregido y funcional.

2. Creación e implementación de decoradores en las rutas de dashboard_Admin y dashboard_users.

3. Corrección del sistema de login de usuario. Ahora es funcional.

4. Separación de login Admin y Users. Ruta de login admin en el fotter.

5. Tablas y procedimientos alterados en la DB. Codigos actualizados en la carpeta /docs/db

6. Creación e implementación de modal flash reutilizable.

7. Intalación de requests en entorno virtual env. Validar archivo de requirements.txt

8. Intento de implementación de recaptcha (No funciono). Variables criticas de recaptcha agregadas en archivo .env y consultadas en archivo setting.py

9. Implementación del archivo models.py para llamados a la DB con los Procedures (SP) para mayor orden. Ahora services solo maneja datos y logica, todos los llamados a la DB deben estar en models.py.

---------------------------------------------------------------------
VERSIÓN 3.5
1. Toda la organización de \modules y \templates reestructurada. Ahora los archivos en vez de estar dividido por función, esta dividido por apartado en la aplicación web (no es la estructura original por módulos de Flask pero es más fácil de manejar, por lo menos al momento de crear las rutas).

2. Implementación de jinja en todos los HTML para reducir código. Creación de layout y componentes HTML reutilizables.

3. Restructuración de CSS y JS según apartado, con archivos globales para determinados elementos.

4. Sistema de rutas completo (rutas básicas con render_template para las paginas que no tienen controlador en backend).

5. Implementación de sistema de errores de HTML y SERVIDOR con errorhandler (Sin funcionamiento conprobado, tenia sueño)
---------------------------------------------------------------------
