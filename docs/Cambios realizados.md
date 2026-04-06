# VERSIÓN 5.8 - 04/04/2026

1. Depuración Y Organización de Código: 
- Se eliminaron funciones de los archivos models.py, jwt_handler.py y session.py que ya no eran usadas.
- Para los archivos forms.py, models.py y services.py (para \home y \dashboard_users) se implementaron separadores y se reornedo todo el codigo para mayor legibilidad a futuro. Ahora el orden del código en los archivos corresponde al orden de las rutas en el archivo routes.py
- Para el codigo SQL del script de las tablas de la BD, se reorganizo totalmente en base a la función y las relaciones de las tablas (datos de usuario, academicos, demograficos, etc)
- Para el codigo SQL del script de la procedimientos almacenados (SP) de la BD, se analizo que SP eran usados en models.py y se apartaron en orden (mismo orden implementado con los separadores de models.py) en un archivo independiente (procedures_use.sql) para aislar y organizar los SP que si son utilizados actualmente en el programa. Aprox. más de 1600 lineas de codigo SQL borradas de SPs no usados.

2. Corrección de sistema de cerrado de sesión por tiempo limite. El JWT (jwl_handler.py) no estaba recibiendo correctamente el valor JWT_ACCESS_TOKEN_EXPIRES y por ello Flask-JWT-Extended usaba un valor por defecto de 15 minutos para la expiración del Token, causando que la sesión explirara independientemente del valor de PERMANENT_SESSION_LIFETIME y JWT_ACCESS_TOKEN_EXPIRES.


3. Creación de función global para el manejo de errores de los formularios si el usuario lo envia con una opción de indice 0.

```
    # FUNCIÓN PARA VALIDAR SI EL ID = 0
    def seleccion_valida(form, field):
        """Validador para SelectField"""
        if not field.data or field.data == 0:
            raise ValidationError("Debe seleccionar una válida.")
```

4. Correción del sistema de recuperación de contraseña. El sp_actualizar_contraseña fallaba debido a que faltaban los parametros ip, user_agent para la sección de auditoria.

5. Creación de todo el sistema para la creación de Tickets por parte del usuario:
    - Modificación del archivo ticket_request.html para eliminar campos de información ya presentes en el registro del estuidante.
    - Implementación de tarjeta en el wizard para la elección del estudiante por el cual se creara el ticket.
    - Creación del backend en routes.py, models.py, forms.py y services.py

6. Modificación del valor de {% block titulo %} de todas las páginas de \home y \dashboard_users. Ahora los titulos corresponden mejor al contenido de la página.

7. Modificación de del patrón de URL y/o dirección de las rutas de dashboard_bp y home_bp

8. Reestructuración de la base de datos:
Modificaciones:
- Para todas las tablas que solo almacenaban datos tipo opciones del programa se modifico el tipo de dato de su Primary Key de INT a TINYINT. Tablas afectadas:
    - TBL_LOCALIDAD
    - TBL_BARRIO
    - TBL_GENERO
    - TBL_PARENTESCO
    - TBL_GRUPO_PREFERENCIAL
    - TBL_ESTRATO
    - TBL_TIPO_IDENTIFICACION
    - TBL_GRADO
    - TBL_JORNADA
    - TBL_ROL
    - TBL_ESTADO_TICKET
    - TBL_TIPO_AFECTACION
    - TBL_TIPO_DOCUMENTO
- Modificación de todos los SPs relacionados con las tablas anteriores para corregir el nuevo tipo de dato de las Primary Key y las Foreing Keys.
- Modificación de finalidad de datos. La tabla TBL_GRUPO_PREFERENCIAL ahora almacena datos de grupos minoritarios y vulnerables. Los datos de los tipos de afectaciones ahora estan en la TBL_TIPO_AFECTACIÓN
- Para la implementación del sistema de creación de tickets se creo la tabla TBL_TIEMPO_RESIDENCIA.
- Modificación de el script de la inserción de datos basicos (data.sql) para funcionamiento del programa, esto segun las modificaciones prebias.
- Creación de los SPs para el sistema de creación de tickets:
    - sp_tbl_tipo_afectacion_consultar
    - sp_tbl_jornada_consultar
    - sp_tbl_tiempo_residencia_consultar
    - sp_ticket_verificar_activo
    - sp_ticket_obtener_ultimo_numero
    - sp_ticket_crear
    - sp_documento_ticket_insertar

Nota: Pendiente creación de tablas para almacenamiento de reportes por fallos en la aplicación web: TBL_TIPO_ERROR y TBL_TICKET_PAGINA


### ERRORES NO SOLUCIONADOS

Cuando el entorno virtual se cae por un error critico en el backend (El equivalente a que el servidor se caiga), las sesiones que estaban abiertas no se cierran a nivel logico: TBL_SESION_ACTIVA.Activa == 0. 

Esto sucede incluso si el sistema da por vencida la sesión (PERMANENT_SESSION_LIFETIME) y el token JWT (JWT_ACCESS_TOKEN_EXPIRES). Aunque esto no permite un acceso no autorizado por parte de un tercero dado que la sesión y el JWT a nivel lógico si se registraron como vencidos por su tiempo de vida limite, esta falla provoca que el usuario visualice una sesión abierta (adicional a la actual) en el panel de Sesiones Activas, alertando falsamente de un posible acceso no autorizado.

---------------------------------------------------------------------
# VERSIÓN 5.5 - 04/04/2026

1. Modificación completa del diseño de register.html. Además, se agrego el campo para seleccionar la fecha de nacimiento.

2. Se modifica la función de hash en \security\hash.py para que siempre retorne datos de tipo bytes.

3. Reducción y comentariado de código HTML para los archivos de \home.

4. Implementación de diseño de alerta para el modal_global.html

5. Implementación de boton para ver la contraseña ingresada en el apartado de cambio de contraseña en security.html

6. Implementación de 'shortcut icon' independiente para cada apartado:
- home: shield.ico
- dashboard_users: shield_user.ico
- admin: shield_gear.ico

7. Implementación de activación de sistema de preferencias de notificaciones por correo/navegador. (Aun no es usado)

8. Implementación de sistema para eliminado logico de usuarios (usuario + estudiantes asociados) con sistema simple de ofuscación ('DEL_', DATE_FORMAT(NOW(), '%Y%m%d%H%i%s'), '_', Dato_Sensible) para datos sensibles y con restricción UNIQUE NOT NULL en BD. Además, de la creación de un modal dedicado para la confirmación con contraseña.

9. Reestructuración de la base de datos:
Modificaciones:
- Modificación de TBL_USARIO para columnas de configuración de preferencias de notificaciones: Notificaciones_Email y Notificaciones_Navegador
- Modificación de columna Tipo_Evento de la tabla TBL_AUDITORIA_SESION para incluir el ingreso por medio de MFA
- Restructuración total del sistema de ID de las tablas relacionadas con el usaurio:
    - Los ID de TBL_PERSONA, TBL_DATOS_ADICIONALES, TBL_USUARIO y TBL_ESTUDIANTE ahora son de tipo INT AUTOINCREMENT. 
    - El documento de identidad del usuario ahora tiene una columna dedicada en TBL_PERSONA.
    - Corrección de la mayoria de los SPs relacionados con las tablas,fueron modificados en base al nuevo tipo de datos de las PK de las tablas. En especial aquellos que tenian una TRANSACTION con envio de datos a TBL_AUDITORIA. 
- Creación de SPs para el programa (Funciones para preferencia de notificaciones, eliminación de usuario):
    - sp_configuracion_obtener_notificaciones
    - sp_configuracion_actualizar_notif_email
    - sp_configuracion_actualizar_notif_navegador
    - sp_eliminar_cuenta_completa

10. Debido a la reestructuración total del sistema de usuarios en lo que respecta al id de las tablas relacionadas se tuvo que validar y modificar todo lo relacionado con la gestión de usuario (login, registro, registro estudiante, actualización de datos de acudiente/estudiante) para adaptarlo a las nuevas tablas y SPs.

---------------------------------------------------------------------
# VERSIÓN 4.6 - 02/04/2026

1. Implementación de función para cambio de contraseña en la página security.html
 
2. Implementación de control de sesiones abiertas del usuario.
El sistema permite ver las sesiones abiertas de un usuario en otros dispositivos, permitiendo la opción de cerrarlas de forma remota.
Modificaciones:
- Modificación de clase Login
- Modificación de clase Logout
- Modificación del decorador login_required para el cierre completo de la sesión por inactividad.

3. Implementación de 2FA por medio de Microsoft Authenticator.
El sistema permite activar y usar (de forma opciona) el sistema de MFA como 2FA.
Se creo el archivo verify_mfa.html para la pagina web.
La logical del sistema de MFA se encuentra en \security\nfa_handler.py y en \home\services.py

Modificaciones:
- Modificación de la clase Login para validar si el usuario ha activado el MFA.
- Se agregaron los campos del archivo de MFA en forms.py.
- Creación de la ruta verificar_mfa
- Creación de nuevo regex para validar los codigos de Authenticator

4. Modificación del diseño y estilo de modal_global.html (anteriormente flash_modal.html). Además, de la creación de un archivo .css dedicado.

5. Reestructuración de la base de datos:
Modificaciones:
    - Creación de TBL_SESION_ACTIVA
    - Modificación  de TBL_USARIO para columnas de configuración MFA
    - Creación de SPs para el programa (Funciones de cambio de contraseña, gestor de sesiones e implementación de MFA):
        - sp_tbl_sesion_activa_verificar_jti
        - sp_tbl_sesion_activa_cerrar_todas_sesiones
        - sp_tbl_sesion_activa_cerrar_sesion
        - sp_tbl_sesion_activa_listar_sesiones
        - sp_tbl_sesion_activa_registrar_sesion
        - sp_tbl_usuario_obtener_mfa_secret
        - sp_tbl_usuario_desactivar_mfa
        - sp_tbl_usuario_activar_mfa
        - sp_tbl_usuario_guardar_mfa_secret_temp
        - sp_tbl_usuario_cambiar_contrasena_perfil

6. Implementación de nuevas librerias:
- qrcode
- pyotp

---------------------------------------------------------------------
# VERSIÓN 4.5 - 01/04/2026
1. Reestructuración de la base de datos:
    Modificaciones:

    - Modificación total de la TBL_AUDITORIA. Ahora esta tabla se encarga del registro de modificación de datos en todas las tablas.
    - Unificación en un solo SP de los SPs utilizados en el proceso de registro y actualización de datos (SPs de TBL_PERSONA, TBL_USUARIO, TBL_DATOS ADICIONALES y TBL_ESTUDIANTE). SP obtenidos: 
        - sp_registrar_usuario_completo
        - sp_registrar_estudiante_completo
        - sp_tbl_estudiante_actualizar
        - sp_tbl_datos_adicionales_actualizar
    - Modificación de todos los SP con funciones CREATE, UPDATE y DELETE para convertirlo en aun trassapción SQL y poder registrar en TBL_AUDITORIA

2. Implementación de JWT usando flask_jwt_extended.
    Modificaciones:

    - Nuevo archivo para la logica \security\jwt_handler.py
    - Modificación de Login
    - Modificación del decorador @login_required
    - Nuevas variables criticas en .env
    - Implementación de cookies

3. Se adapto la clase de Logout para funcionar con JWT. Se limpie la sesión y se eliminan las cookies JWT

4. Implementación de sistema de limite de tiempo de sesión por innactividad. Se limito la duración total de la sesión a 24 horas, previniendo sesiones eternas.
    Modificaciones:
    - Nuevo archivo para la logica \security\session.py
    - Modificación de Login
    - Modificación de jwt_handler.py para que se limpie la sesión y se invalidan las cookies JWT

5. Instalación de nuevas librerias para implementación de JWT:
    - Flask-JWT-Extended==4.7.1
    - PyJWT==2.12.1

---------------------------------------------------------------------
# VERSIÓN 4.1 - 01/04/2026
1. Reestructuración de la base de datos:
    - Modificaciones menores de TBL_USUARIO, TBL_ESTUDIANTE
    - Creación de Script para inserción de usuario y estudiante de prueba.
    - Creación de todos los SP utilizados en dashboard_user/models.py
    - Modificación de SP de las tablas modificas mensionadas.

2. Corrección de la lógica del archivo profile.html y su backend dashboard_user/services.py para la actualización de datos del acudiente y el estudiante. Funcionamiento validado.

3. Creación de clase Logout para que sea un proceso independiente de la clase Login

4. Creación de función global auditoria para todos los procesos de login y/o logout.

5. Correcciones ortográficas de algunos HTML.  

---------------------------------------------------------------------
# VERSIÓN 4.0 - 29/03/2026
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
# VERSIÓN 3.7 - 25/03/2026
1. Implementación de Sistema de recuperación de contraseña con uso de Flask-Mail.
    
    1.1. Creación de nuevos procedures para la función de recuperación de contraseña. Se encuentran en docs/db/procedures.sql

2. Se filtro y creo una función reutilizable para el tema del hash de las contraseñas. La función sirve para login, registro y recuperar contraseña
Ubicación app/secutity/hash.py

3. Se modifico el diseño del modal general, de danger a info.
NOTA: Validar si crear más modales para diferentes contexto o intentar adaptar el actual para que sea modular

4. Se creo pagina para las Politicas de Privacidad. Acceso desde el fotter de home.

---------------------------------------------------------------------
# VERSIÓN 3.6.2 - 24/03/2026
1. Corrección e implementación de reCAPTCHA en login y registro. Funcionamiento validado.
Error: La implementación de reCAPTCHA en registro esta causando fallas en los campos de contraseña y confirmación_contraseña respecto a sus efectos dados por home.js.

2. Corrección de Modal flash

3. Implementación de extención para mantener en todas las paginas los valores del header (Nombre Usuario e Iniciales) cuando el usuario se logea.
NOTA: Si el error_handler no funciona es porque comentarie su instancia en __init__.py para saber de forma más directa si habia un error en el programa.

---------------------------------------------------------------------
# VERSIÓN 3.6 - 23/03/2026
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
# VERSIÓN 3.5 - 22/03/2026
1. Toda la organización de \modules y \templates reestructurada. Ahora los archivos en vez de estar dividido por función, esta dividido por apartado en la aplicación web (no es la estructura original por módulos de Flask pero es más fácil de manejar, por lo menos al momento de crear las rutas).

2. Implementación de jinja en todos los HTML para reducir código. Creación de layout y componentes HTML reutilizables.

3. Restructuración de CSS y JS según apartado, con archivos globales para determinados elementos.

4. Sistema de rutas completo (rutas básicas con render_template para las paginas que no tienen controlador en backend).

5. Implementación de sistema de errores de HTML y SERVIDOR con errorhandler (Sin funcionamiento conprobado, tenia sueño)

---------------------------------------------------------------------
# VERSIÓN 3.4 - 2.0

Reestructuración total del proyecto, todo el coentenido ya creado fue adaptado para funcionar con el framework Flask.

CONTENIDO ADAPTADO:
- Rutas 
- Logica
- Conexión a la BD
- Estructura utilizada en DJANGO

CONTENIDO DESECHADO
- Modelos de las tablas de la BD
- Configuración para la nueva versión de MariaDB

Luego de la restructuración se ralizaron multiples cambios al programa entre Luis G, Luis T y Emerson C. Se cuentan con el control de versiones de dichas modificaciones pero no se registraron de forma escrita los cambios.

---------------------------------------------------------------------
# VERSIONES INFERIORES A LA 2.0

La aplicación web en su edad temprada se habia planteado realizarla usando el framework DJANGO. Además, no se tienen registro de contro de versiones de todo el codigo en esas versiones.

---------------------------------------------------------------------