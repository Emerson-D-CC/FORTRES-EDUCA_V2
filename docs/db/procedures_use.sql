USE FORTRESS_EDUCA_DB;

-- ====================================================================================================================================================
--                                          SPs PARA LOS DECORADORES Y DEMAS CONFIGURACIONES
-- ====================================================================================================================================================

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_rol_consultar_nombre;

DELIMITER $$
CREATE PROCEDURE sp_tbl_rol_consultar_nombre(
    IN p_Nombre_Rol VARCHAR(50)
)
BEGIN
    SELECT ID_Rol 
    FROM tbl_rol 
    WHERE Nombre_Rol = p_Nombre_Rol 
    AND Estado_Rol = 1;
END $$
DELIMITER ;

-- --------------------------------------------------------
-- Verificar si un JTI está activo (para blacklist)

DROP PROCEDURE IF EXISTS sp_tbl_sesion_activa_verificar_jti;

DELIMITER $$
CREATE PROCEDURE sp_tbl_sesion_activa_verificar_jti(
    IN p_jti VARCHAR(64)
)
BEGIN
    SELECT COUNT(*) AS activo
    FROM TBL_SESION_ACTIVA
    WHERE JTI = p_jti AND Activa = 1;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Registro de cambios de los datos de las tablas de la BD
DROP PROCEDURE IF EXISTS sp_insertar_auditoria;

DELIMITER $$
CREATE PROCEDURE sp_insertar_auditoria(
    IN p_tabla VARCHAR(100),
    IN p_evento VARCHAR(20),
    IN p_id_registro VARCHAR(50),
    IN p_datos_old JSON,
    IN p_datos_new JSON,
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255),
    IN p_id_usuario INT
)
BEGIN
    INSERT INTO TBL_AUDITORIA (
        Tabla_Afectada,
        Tipo_Evento,
        ID_Registro_Afectado,
        Datos_Antiguo,
        Datos_Nuevos,
        IP_Usuario,
        User_Agent,
        FK_ID_Usuario
    )
    VALUES (
        p_tabla,
        p_evento,
        p_id_registro,
        p_datos_old,
        p_datos_new,
        p_ip,
        p_user_agent,
        p_id_usuario
    );
END $$
DELIMITER ;

-- ====================================================================================================================================================
--                                          SPs PARA HOME
-- ====================================================================================================================================================

-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE LOGIN
-- ====================================================================================================================================================

-- --------------------------------------------------------
-- VALIDACIONES PARA EL INICIO DE SESIÓN

DROP PROCEDURE IF EXISTS sp_validar_data_user;

DELIMITER $$
CREATE PROCEDURE sp_validar_data_user(
    IN p_nombre_usuario VARCHAR(50)
)
BEGIN
    SELECT 
        u.ID_Usuario,
        u.Password_Salt,
        u.Doble_Factor_Activo,
        u.FK_ID_Rol,

        -- Datos de persona
        p.Primer_Nombre,
        p.Primer_Apellido,
        CONCAT(p.Primer_Nombre, ' ', p.Primer_Apellido) AS Nombre_Completo

    FROM TBL_USUARIO u
    INNER JOIN TBL_PERSONA p ON u.FK_ID_Persona = p.ID_Persona
    
    WHERE u.Nombre_Usuario = p_nombre_usuario
    AND u.Estado_Usuario = 1
    AND p.Estado_Persona = 1

    LIMIT 1;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_usuario_validar_login;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_validar_login(
    IN p_nombre_usuario VARCHAR(50),
    IN p_password_hash VARBINARY(32)
)
BEGIN
    DECLARE v_id_usuario INT;
    DECLARE v_hash VARBINARY(32);
    DECLARE v_resultado VARCHAR(10);

    -- Obtener datos del usuario
    SELECT ID_Usuario, Contraseña_Hash
    INTO v_id_usuario, v_hash
    FROM TBL_USUARIO
    WHERE Nombre_Usuario = p_nombre_usuario
    LIMIT 1;

    -- Validar existencia del usuario
    IF v_id_usuario IS NULL THEN
        SET v_resultado = 'FAILED';
    ELSE
        -- Comparar hash
        IF v_hash = p_password_hash THEN

            -- Login correcto
            UPDATE TBL_USUARIO
            SET 
                Ultimo_Login = NOW(),
                Intentos_Fallidos = 0
            WHERE ID_Usuario = v_id_usuario;

            SET v_resultado = 'SUCCESS';

        ELSE

            -- Login incorrecto
            UPDATE TBL_USUARIO
            SET 
                Intentos_Fallidos = IFNULL(Intentos_Fallidos,0) + 1
            WHERE ID_Usuario = v_id_usuario;

            SET v_resultado = 'FAILED';

        END IF;
    END IF;

    -- Retorno del resultado
    SELECT 
        v_id_usuario AS ID_Usuario,
        v_resultado AS Resultado;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_auditoria_sesion;

DELIMITER $$
CREATE PROCEDURE sp_auditoria_sesion(
    IN p_usuario INT,
    IN p_ip VARCHAR(45),
    IN p_evento VARCHAR(20),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    INSERT INTO TBL_AUDITORIA_SESION(
        FK_ID_Usuario,
        IP_Usuario,
        Tipo_Evento,
        User_Agent
    )

    VALUES(
        p_usuario,
        p_ip,
        p_evento,
        p_user_agent
    );
END $$
DELIMITER ;


-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE VERIFY_MFA
-- ====================================================================================================================================================

-- --------------------------------------------------------
-- SP: Obtener secret MFA activo

DROP PROCEDURE IF EXISTS sp_tbl_usuario_obtener_mfa_secret;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_obtener_mfa_secret(
    IN p_id_usuario INT
)
BEGIN
    SELECT
        MFA_Secret,
        MFA_Secret_Temp,
        Doble_Factor_Activo
    FROM TBL_USUARIO
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;



-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE REGISTER
-- ====================================================================================================================================================

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_barrio_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_barrio_consultar()
BEGIN
    SELECT
        ID_Barrio,
        Nombre_Barrio
    FROM TBL_BARRIO
    WHERE Estado_Barrio = 1
    ORDER BY Nombre_Barrio;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_parentesco_consultar_acu;

DELIMITER $$
CREATE PROCEDURE sp_tbl_parentesco_consultar_acu()
BEGIN
    SELECT 
        ID_Parentesco,
        Nombre_Parentesco
    FROM TBL_PARENTESCO
    WHERE Estado_Parentesco = 1 AND Tipo_Usuario = 'ACUDIENTE'
    ORDER BY ID_Parentesco;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_tipo_identificacion_consultar_acu;

DELIMITER $$
CREATE PROCEDURE sp_tbl_tipo_identificacion_consultar_acu()
BEGIN
    SELECT 
        ID_Tipo_Iden,
        Nombre_Tipo_Iden
    FROM TBL_TIPO_IDENTIFICACION
    WHERE Estado_Identificacion = 1 AND Tipo_Usuario = 'ACUDIENTE'
    ORDER BY Nombre_Tipo_Iden;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_usuario_verificar_existente;

DELIMITER $$
CREATE PROCEDURE sp_usuario_verificar_existente(
    IN p_Email VARCHAR(255),
    IN p_Documento INT
)
BEGIN
    SELECT 
        u.Nombre_Usuario,
        p.ID_Persona
    FROM TBL_USUARIO u
    JOIN TBL_PERSONA p
    ON u.FK_ID_Persona = p.ID_Persona
    WHERE u.Nombre_Usuario = p_Email
    OR p.ID_Persona = p_Documento;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_registrar_usuario_completo;

DELIMITER $$
CREATE PROCEDURE sp_registrar_usuario_completo(
    -- PERSONA
    IN p_Num_Doc_Persona VARCHAR(30),
    IN p_Primer_Nombre VARCHAR(50),
    IN p_Segundo_Nombre VARCHAR(50),
    IN p_Primer_Apellido VARCHAR(50),
    IN p_Segundo_Apellido VARCHAR(50),
    IN p_Fecha_Nacimiento DATE,

    -- DATOS ADICIONALES
    IN p_Email VARCHAR(255),
    IN p_Telefono VARCHAR(45),
    IN p_FK_ID_Parentesco TINYINT,
    IN p_FK_ID_Tipo_Iden TINYINT,
    IN p_FK_ID_Genero TINYINT,
    IN p_FK_ID_Grupo_Preferencial TINYINT,
    IN p_FK_ID_Estrato TINYINT,
    IN p_FK_ID_Barrio INT,

    -- USUARIO
    IN p_Nombre_Usuario VARCHAR(50),
    IN p_password_salt VARBINARY(16),
    IN p_password_hash VARBINARY(32),
    IN p_FK_ID_Rol TINYINT,

    -- AUDITORÍA
    IN p_IP VARCHAR(50),
    IN p_User_Agent VARCHAR(255)
)
BEGIN
    DECLARE v_ID_Persona INT;
    DECLARE v_ID_Datos_Adicionales INT;
    DECLARE v_ID_Usuario INT;

    -- Manejo de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- INSERT PERSONA
    INSERT INTO TBL_PERSONA (
        Num_Doc_Persona, Primer_Nombre, Segundo_Nombre, 
        Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona
    ) VALUES (
        p_Num_Doc_Persona, p_Primer_Nombre, p_Segundo_Nombre,
        p_Primer_Apellido, p_Segundo_Apellido, p_Fecha_Nacimiento, 1
    );

    SET v_ID_Persona = LAST_INSERT_ID();

    CALL sp_insertar_auditoria(
        'TBL_PERSONA', 'CREATE', CAST(v_ID_Persona AS CHAR),
        NULL, JSON_OBJECT('Doc', p_Num_Doc_Persona, 'Nombre', p_Primer_Nombre), 
        p_IP, p_User_Agent, 'SYSTEM'
    );

    -- DATOS ADICIONALES
    INSERT INTO TBL_DATOS_ADICIONALES (
        Email, Telefono, FK_ID_Parentesco, FK_ID_Tipo_Iden, 
        FK_ID_Persona, FK_ID_Genero, FK_ID_Grupo_Preferencial, 
        FK_ID_Estrato, FK_ID_Barrio, Estado_Datos_Adicionales
    ) VALUES (
        p_Email, p_Telefono, p_FK_ID_Parentesco, p_FK_ID_Tipo_Iden,
        v_ID_Persona, p_FK_ID_Genero, p_FK_ID_Grupo_Preferencial,
        p_FK_ID_Estrato, p_FK_ID_Barrio, 1
    );

    SET v_ID_Datos_Adicionales = LAST_INSERT_ID();

    CALL sp_insertar_auditoria(
        'TBL_DATOS_ADICIONALES', 'CREATE', CAST(v_ID_Datos_Adicionales AS CHAR),
        NULL, JSON_OBJECT('Email', p_Email, 'Tel', p_Telefono), 
        p_IP, p_User_Agent, 'SYSTEM'
    );

    -- USUARIO
    INSERT INTO TBL_USUARIO (
        Nombre_Usuario, Password_Salt, Contraseña_Hash, 
        Ultimo_Cambio_Contraseña, Ultimo_Login, Intentos_Fallidos,
        Fecha_Creacion, Doble_Factor_Activo, MFA_Fecha_Configuracion,
        MFA_Secret, MFA_Secret_Temp, Notificaciones_Email,
        Notificaciones_Navegador, Aceptacion_Terminos, FK_ID_Persona,
        FK_ID_Rol, Estado_Usuario
    ) VALUES (
        p_Nombre_Usuario, p_password_salt, p_password_hash,
        NULL, NULL, 0,
        CURRENT_TIMESTAMP, 'INACTIVE', NULL,
        NULL, NULL, 0,
        0, 'ACCEPTED', v_ID_Persona,
        p_FK_ID_Rol, 1
    );

    SET v_ID_Usuario = LAST_INSERT_ID();

    CALL sp_insertar_auditoria(
        'TBL_USUARIO', 'CREATE', CAST(v_ID_Usuario AS CHAR),
        NULL, JSON_OBJECT('Username', p_Nombre_Usuario), 
        p_IP, p_User_Agent, 'SYSTEM'
    );

    COMMIT;
END $$
DELIMITER ;



-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE RECOVER_PASSWORD
-- ====================================================================================================================================================

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_usuario_obtener_email;

DELIMITER $$
CREATE PROCEDURE sp_usuario_obtener_email(
    IN p_Nombre_Usuario VARCHAR(50)
)
BEGIN
    SELECT 
        DA.Email
    FROM TBL_USUARIO U
    INNER JOIN TBL_DATOS_ADICIONALES DA ON U.FK_ID_Persona = DA.FK_ID_Persona
    WHERE U.Nombre_Usuario = p_Nombre_Usuario 
    AND DA.Email = p_Nombre_Usuario;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_usuario_recuperar_contraseña;

DELIMITER $$
CREATE PROCEDURE sp_usuario_recuperar_contraseña(
    IN p_username VARCHAR(100),
    IN p_nuevo_hash VARBINARY(32),
    IN p_nuevo_salt VARBINARY(16),
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    DECLARE v_id_usuario INT;

    START TRANSACTION;

    SELECT ID_Usuario INTO v_id_usuario
    FROM TBL_USUARIO
    WHERE Nombre_Usuario = p_username;

    UPDATE TBL_USUARIO
    SET Contraseña_Hash = p_nuevo_hash,
        Password_Salt   = p_nuevo_salt,
        Ultimo_Cambio_Contraseña = CURRENT_TIMESTAMP
    WHERE Nombre_Usuario = p_username;

    CALL sp_insertar_auditoria(
        'TBL_USUARIO',
        'PASSWORD_CHANGE',
        v_id_usuario,
        JSON_OBJECT('evento','recuperacion_password'),
        JSON_OBJECT('evento','password_actualizado'),
        p_ip,
        p_user_agent,
        5157341
    );

    COMMIT;
END $$
DELIMITER ;






-- ====================================================================================================================================================
--                                          SPs PARA DASHBOARD_USER
-- ====================================================================================================================================================

-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE REQUEST
-- ====================================================================================================================================================

-- DATOS PARA LISTAS DE OPCIONES 

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_tipo_afectacion_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_tipo_afectacion_consultar()
BEGIN
    SELECT ID_Tipo_Afectacion, Nombre_Afectacion, Nivel_Prioridad_TC
    FROM TBL_TIPO_AFECTACION
    WHERE Estado_Afectacion = 1
    ORDER BY Nivel_Prioridad_TC DESC;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_jornada_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_jornada_consultar()
BEGIN
    SELECT ID_Jornada, Nombre_Jornada
    FROM TBL_JORNADA
    WHERE Estado_Jornada = 1;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_tiempo_residencia_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_tiempo_residencia_consultar()
BEGIN
    SELECT ID_Tiempo_Residencia, Nombre_Tiempo
    FROM TBL_TIEMPO_RESIDENCIA;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Verificar ticket activo para un estudiante, un estudiante no puede tener dos tickets abiertos simultáneamente

DROP PROCEDURE IF EXISTS sp_ticket_verificar_activo;

DELIMITER $$
CREATE PROCEDURE sp_ticket_verificar_activo(
    IN p_id_estudiante INT,
    IN p_id_usuario INT
)
BEGIN
    SELECT COUNT(*) AS total_activos
    FROM TBL_TICKET t
    INNER JOIN TBL_ESTADO_TICKET e ON t.FK_ID_Estado_Ticket = e.ID_Estado_Ticket
    WHERE t.FK_ID_Estudiante = p_id_estudiante
      AND t.FK_ID_Usuario_Creador = p_id_usuario
      AND e.Estado_Final = 0
      AND t.Estado_Ticket = 1;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Generar próximo ID_Ticket en formato EDU-000000

DROP PROCEDURE IF EXISTS sp_ticket_obtener_ultimo_numero;

DELIMITER $$
CREATE PROCEDURE sp_ticket_obtener_ultimo_numero()
BEGIN
    SELECT COALESCE(
        MAX(CAST(SUBSTRING(ID_Ticket, 5) AS UNSIGNED)), 
        0
    ) AS ultimo_numero
    FROM TBL_TICKET;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_ticket_crear;

DELIMITER $$
CREATE PROCEDURE sp_ticket_crear(
    IN p_id_ticket VARCHAR(10),
    IN p_id_usuario INT,
    IN p_id_estudiante INT,
    IN p_id_tipo_afectacion  TINYINT,
    IN p_descripcion TEXT,
    IN p_id_barrio INT,
    IN p_id_tiempo_residencia TINYINT,
    IN p_id_jornada TINYINT,
    IN p_id_colegio INT,
    IN p_ip VARCHAR(45),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    DECLARE v_titulo VARCHAR(150);
    DECLARE v_puntaje INT DEFAULT 0;
    DECLARE v_nombre_est VARCHAR(120);
    DECLARE v_grado VARCHAR(60);
    DECLARE v_nivel_afectacion TINYINT DEFAULT 0;
    DECLARE v_nivel_gp TINYINT DEFAULT 0;
    DECLARE v_id_estado_inicial TINYINT;

    -- Nombre del estudiante y grado para el título
    SELECT CONCAT(p.Primer_Nombre, ' ', p.Primer_Apellido),
           gr.Nombre_Grado
    INTO   v_nombre_est, v_grado
    FROM   TBL_ESTUDIANTE e
    INNER JOIN TBL_PERSONA p ON e.FK_ID_Persona = p.ID_Persona
    INNER JOIN TBL_GRADO gr ON e.FK_ID_Gardo_Proximo = gr.ID_Grado
    WHERE  e.ID_Estudiante = p_id_estudiante;

    SET v_titulo = CONCAT('Solicitud de cupo — ', v_nombre_est, ' — ', v_grado);

    -- Puntaje de prioridad
    SELECT Nivel_Prioridad_TC INTO v_nivel_afectacion
    FROM TBL_TIPO_AFECTACION
    WHERE ID_Tipo_Afectacion = p_id_tipo_afectacion;

    SELECT gp.Nivel_Prioridad_GP INTO v_nivel_gp
    FROM TBL_ESTUDIANTE e
    INNER JOIN TBL_GRUPO_PREFERENCIAL gp 
        ON e.FK_ID_Grupo_Preferencial = gp.ID_Grupo_Preferencial
    WHERE e.ID_Estudiante = p_id_estudiante;

    SET v_puntaje = COALESCE(v_nivel_afectacion, 0) + COALESCE(v_nivel_gp, 0);

    -- Estado inicial (primer estado no final activo)
    SELECT ID_Estado_Ticket INTO v_id_estado_inicial
    FROM TBL_ESTADO_TICKET
    WHERE Estado_Final = 0 AND Estado_Estado_Ticket = 1
    ORDER BY ID_Estado_Ticket ASC
    LIMIT 1;

    -- Insertar ticket
    INSERT INTO TBL_TICKET (
        ID_Ticket, Titulo_Ticket, Descripcion_Ticket, Puntaje_Prioridad,
        FK_ID_Usuario_Creador, FK_ID_Estudiante, FK_ID_Tipo_Afectacion,
        FK_ID_Colegio_Preferencia, FK_ID_Jornada_Preferencia,
        FK_ID_Estado_Ticket, FK_ID_Barrio, FK_ID_Tiempo_Residencia
    ) VALUES (
        p_id_ticket, v_titulo, p_descripcion, v_puntaje,
        p_id_usuario, p_id_estudiante, p_id_tipo_afectacion,
        p_id_colegio, p_id_jornada,
        v_id_estado_inicial, p_id_barrio, p_id_tiempo_residencia
    );

    -- Retornar el ticket creado para confirmación
    SELECT p_id_ticket AS id_ticket, v_titulo AS titulo, v_puntaje AS puntaje;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Insertar documento de ticket

DROP PROCEDURE IF EXISTS sp_documento_ticket_insertar;

DELIMITER $$
CREATE PROCEDURE sp_documento_ticket_insertar(
    IN p_id_ticket VARCHAR(10),
    IN p_id_tipo_doc TINYINT,
    IN p_archivo MEDIUMBLOB,
    IN p_nombre_original VARCHAR(100)
)
BEGIN
    INSERT INTO TBL_DOCUMENTO_TICKET (
        FK_ID_Ticket,
        FK_ID_Tipo_Doc,
        Archivo,
        Nombre_Original
    ) VALUES (
        p_id_ticket,
        p_id_tipo_doc,
        p_archivo,
        p_nombre_original
    );
END $$
DELIMITER ;



-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE PROFILE
-- ====================================================================================================================================================

-- DATOS PARA LISTAS DE OPCIONES 

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_genero_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_genero_consultar()
BEGIN
    SELECT
        ID_Genero,
        Nombre_Genero
    FROM TBL_GENERO
    WHERE Estado_Genero = 1
    ORDER BY Nombre_Genero;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_grupo_preferencial_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_grupo_preferencial_consultar()
BEGIN
    SELECT
        ID_Grupo_Preferencial,
        Nombre_Grupo_Preferencial
    FROM TBL_GRUPO_PREFERENCIAL
    WHERE Estado_Grupo_Preferencial = 1
    ORDER BY ID_Grupo_Preferencial;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_grado_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_grado_consultar()
BEGIN
    SELECT
        ID_Grado,
        Nombre_Grado
    FROM TBL_GRADO
    WHERE Estado_Grado = 1
    ORDER BY ID_Grado;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_colegio_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_colegio_consultar()
BEGIN
    SELECT
        ID_Colegio,
        Nombre_Colegio
    FROM TBL_COLEGIO
    WHERE Estado_Colegio = 1
    ORDER BY Nombre_Colegio;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_tipo_identificacion_consultar_est;

DELIMITER $$
CREATE PROCEDURE sp_tbl_tipo_identificacion_consultar_est()
BEGIN
    SELECT 
        ID_Tipo_Iden,
        Nombre_Tipo_Iden
    FROM TBL_TIPO_IDENTIFICACION
    WHERE Estado_Identificacion = 1 AND Tipo_Usuario = 'ESTUDIANTE'
    ORDER BY Nombre_Tipo_Iden;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_estrato_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_estrato_consultar()
BEGIN
    SELECT 
        ID_Estrato, 
        Nombre_Estrato
    FROM tbl_estrato
    WHERE Estado_Estrato = 1
    ORDER BY ID_Estrato;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_localidad_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_localidad_consultar()
BEGIN
    SELECT
        ID_Localidad,
        Nombre_Localidad
    FROM TBL_LOCALIDAD
    WHERE Estado_Localidad = 1
    ORDER BY Nombre_Localidad;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_barrio_consultar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_barrio_consultar()
BEGIN
    SELECT
    ID_Barrio,
    Nombre_Barrio
    FROM TBL_BARRIO
    WHERE Estado_Barrio = 1
    ORDER BY Nombre_Barrio;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_parentesco_consultar_est;

DELIMITER $$
CREATE PROCEDURE sp_tbl_parentesco_consultar_est()
BEGIN
    SELECT 
        ID_Parentesco,
        Nombre_Parentesco
    FROM TBL_PARENTESCO
    WHERE Estado_Parentesco = 1 AND Tipo_Usuario = 'ESTUDIANTE'
    ORDER BY ID_Parentesco;
END $$
DELIMITER ;


-- --------------------------------------------------------
    -- Reutilización de sp_tbl_parentesco_consultar_acu


-- PERFIL DEL USUARIO (ACUDIENTE)

-- --------------------------------------------------------
-- SP: Obtener todos los datos de un acudiente

DROP PROCEDURE IF EXISTS sp_perfil_acudiente_consultar;

DELIMITER $$
CREATE PROCEDURE sp_perfil_acudiente_consultar(
    IN p_id_usuario INT
)
BEGIN
    SELECT
        -- Identidad (Solo lectura para el usuario)
        p.ID_Persona, -- ID técnico para el servicio Python
        p.Num_Doc_Persona AS Numero_Documento,
        p.Primer_Nombre,
        p.Segundo_Nombre,
        p.Primer_Apellido,
        p.Segundo_Apellido,
        ti.Nombre_Tipo_Iden,

        -- Contacto (Editable)
        da.ID_Datos_Adicionales,
        da.Email,
        da.Telefono,

        -- Ubicación y Demografía (Editable)
        da.FK_ID_Barrio AS ID_Barrio,
        b.Nombre_Barrio,
        da.FK_ID_Estrato AS ID_Estrato,
        da.FK_ID_Genero AS ID_Genero,
        da.FK_ID_Grupo_Preferencial AS ID_Grupo_Preferencial,

        -- Metadatos
        par.Nombre_Parentesco,
        u.Fecha_Creacion
    FROM TBL_USUARIO u
    INNER JOIN TBL_PERSONA p ON u.FK_ID_Persona = p.ID_Persona
    INNER JOIN TBL_DATOS_ADICIONALES da ON da.FK_ID_Persona = p.ID_Persona
    INNER JOIN TBL_TIPO_IDENTIFICACION ti ON da.FK_ID_Tipo_Iden = ti.ID_Tipo_Iden
    INNER JOIN TBL_BARRIO b ON da.FK_ID_Barrio = b.ID_Barrio
    INNER JOIN TBL_PARENTESCO par ON da.FK_ID_Parentesco = par.ID_Parentesco
    WHERE u.ID_Usuario = p_id_usuario
    LIMIT 1;
END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_actualizar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_datos_adicionales_actualizar(
    IN p_id_datos INT,
    IN p_telefono VARCHAR(45),
    IN p_id_persona INT,
    IN p_genero TINYINT,
    IN p_grupo_pref TINYINT,
    IN p_estrato TINYINT,
    IN p_barrio TINYINT,
    IN p_id_usuario INT,
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    DECLARE v_old JSON;
    
    START TRANSACTION;

    -- Captura estado anterior para auditoría
    SELECT JSON_OBJECT(
        'Telefono', Telefono,
        'Genero', FK_ID_Genero,
        'Grupo', FK_ID_Grupo_Preferencial,
        'Estrato', FK_ID_Estrato,
        'Barrio', FK_ID_Barrio
    ) INTO v_old
    FROM TBL_DATOS_ADICIONALES
    WHERE ID_Datos_Adicionales = p_id_datos;

    UPDATE TBL_DATOS_ADICIONALES
    SET
        Telefono = p_telefono,
        FK_ID_Genero = p_genero,
        FK_ID_Grupo_Preferencial = p_grupo_pref,
        FK_ID_Estrato = p_estrato,
        FK_ID_Barrio = p_barrio
    WHERE ID_Datos_Adicionales = p_id_datos
      AND FK_ID_Persona = p_id_persona;

    CALL sp_insertar_auditoria(
        'TBL_DATOS_ADICIONALES', 'UPDATE', CAST(p_id_datos AS CHAR),
        v_old, 
        JSON_OBJECT('Telefono', p_telefono, 'Genero', p_genero, 'Barrio', p_barrio),
        p_ip, p_user_agent, p_id_usuario
    );

    COMMIT;
END $$
DELIMITER ;


--      PERFIL DE ESTUDIANTES

-- --------------------------------------------------------
-- SP: Obtener todos los estudiantes de un acudiente (lista para tarjetas)

DROP PROCEDURE IF EXISTS sp_perfil_estudiantes_por_acudiente;

DELIMITER $$
CREATE PROCEDURE sp_perfil_estudiantes_por_acudiente(IN p_id_usuario INT)
BEGIN
    SELECT
        e.ID_Estudiante,
        p.Primer_Nombre,
        p.Segundo_Nombre,
        p.Primer_Apellido,
        p.Segundo_Apellido,
        p.Fecha_Nacimiento,
        ti.Nombre_Tipo_Iden,
        p.Num_Doc_Persona AS Numero_Documento,
        g.Nombre_Genero,
        gp.Nombre_Grupo_Preferencial,
        gr_a.Nombre_Grado AS Nombre_Grado_Actual,
        gr_p.Nombre_Grado AS Nombre_Grado_Proximo,
        c.Nombre_Colegio AS Nombre_Colegio_Anterior,
        e.Estado_Estudiante,

        -- IDs para pre-poblar formulario de edición
        e.FK_ID_Genero AS ID_Genero,
        e.FK_ID_Grupo_Preferencial AS ID_Grupo_Preferencial,
        e.FK_ID_Grado_Actual AS ID_Grado_Actual,
        e.FK_ID_Gardo_Proximo AS ID_Grado_Proximo,
        e.FK_ID_Colegio_Anterior AS ID_Colegio_Anterior,
        e.FK_ID_Persona AS ID_Persona,
        e.FK_ID_Tipo_Iden AS ID_Tipo_Iden,
        e.FK_ID_Parentesco_Es AS ID_Parentesco

    FROM TBL_ESTUDIANTE e
    INNER JOIN TBL_PERSONA p ON e.FK_ID_Persona = p.ID_Persona
    INNER JOIN TBL_TIPO_IDENTIFICACION ti ON e.FK_ID_Tipo_Iden = ti.ID_Tipo_Iden
    INNER JOIN TBL_GENERO g ON e.FK_ID_Genero = g.ID_Genero
    INNER JOIN TBL_GRUPO_PREFERENCIAL gp ON e.FK_ID_Grupo_Preferencial = gp.ID_Grupo_Preferencial
    INNER JOIN TBL_GRADO gr_a ON e.FK_ID_Grado_Actual = gr_a.ID_Grado
    LEFT JOIN TBL_GRADO gr_p ON e.FK_ID_Gardo_Proximo = gr_p.ID_Grado
    INNER JOIN TBL_COLEGIO c ON e.FK_ID_Colegio_Anterior = c.ID_Colegio

    WHERE e.FK_ID_Acudiente = p_id_usuario
      AND e.Estado_Estudiante = 1
    ORDER BY p.Primer_Apellido, p.Primer_Nombre;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- SP: Obtener un estudiante específico por su ID (para edición)

DROP PROCEDURE IF EXISTS sp_perfil_estudiante_por_id;

DELIMITER $$
CREATE PROCEDURE sp_perfil_estudiante_por_id(
    IN p_id_estudiante INT,
    IN p_id_usuario INT
)
BEGIN
    SELECT
        e.ID_Estudiante,
        p.ID_Persona,
        p.Primer_Nombre,
        p.Segundo_Nombre,
        p.Primer_Apellido,
        p.Segundo_Apellido,
        p.Fecha_Nacimiento,
        ti.Nombre_Tipo_Iden,
        p.Num_Doc_Persona AS Numero_Documento,
        e.FK_ID_Genero AS ID_Genero,
        e.FK_ID_Grupo_Preferencial AS ID_Grupo_Preferencial,
        e.FK_ID_Grado_Actual AS ID_Grado_Actual,
        e.FK_ID_Gardo_Proximo AS ID_Grado_Proximo,
        e.FK_ID_Colegio_Anterior AS ID_Colegio_Anterior,
        e.FK_ID_Tipo_Iden AS ID_Tipo_Iden,
        ti.Nombre_Tipo_Iden,
        p.Num_Doc_Persona AS Numero_Documento

    FROM TBL_ESTUDIANTE e
    INNER JOIN TBL_PERSONA p ON e.FK_ID_Persona = p.ID_Persona
    INNER JOIN TBL_TIPO_IDENTIFICACION ti ON e.FK_ID_Tipo_Iden = ti.ID_Tipo_Iden
    WHERE e.ID_Estudiante = p_id_estudiante
      AND e.FK_ID_Acudiente = p_id_usuario
      AND e.Estado_Estudiante = 1;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- SP: Verificar cuántos estudiantes activos tiene un acudiente

DROP PROCEDURE IF EXISTS sp_tbl_estudiante_verificar_por_acudiente;

DELIMITER $$
CREATE PROCEDURE sp_tbl_estudiante_verificar_por_acudiente(IN p_id_acudiente INT)
BEGIN
    SELECT COUNT(*) AS total_estudiantes
    FROM TBL_ESTUDIANTE
    WHERE FK_ID_Acudiente   = p_id_acudiente
      AND Estado_Estudiante = 1;
END $$
DELIMITER ;


-- --------------------------------------------------------
--  SP: Perfil del estudiante (datos para pre-poblar forms)

DROP PROCEDURE IF EXISTS sp_perfil_estudiante_consultar;

DELIMITER $$
CREATE PROCEDURE sp_perfil_estudiante_consultar(
    IN p_id_acudiente INT
)
BEGIN
    SELECT
        -- Llaves primarias técnicas
        e.ID_Estudiante, 
        p.ID_Persona,

        -- Identificación (Solo lectura)
        ti.Nombre_Tipo_Iden,
        p.Num_Doc_Persona AS Numero_Documento,

        -- Datos Personales (Editables)
        p.Primer_Nombre,
        p.Segundo_Nombre,
        p.Primer_Apellido,
        p.Segundo_Apellido,
        p.Fecha_Nacimiento,

        -- Demográficos
        e.FK_ID_Genero AS ID_Genero,
        e.FK_ID_Grupo_Preferencial AS ID_Grupo_Preferencial,

        -- Académicos (Editables)
        e.FK_ID_Grado_Actual AS ID_Grado_Actual,
        e.FK_ID_Gardo_Proximo AS ID_Grado_Proximo,
        e.FK_ID_Colegio_Anterior AS ID_Colegio_Anterior
        
    FROM TBL_ESTUDIANTE e
    INNER JOIN TBL_PERSONA p ON e.FK_ID_Persona = p.ID_Persona
    INNER JOIN TBL_TIPO_IDENTIFICACION ti ON e.FK_ID_Tipo_Iden = ti.ID_Tipo_Iden
    WHERE e.FK_ID_Acudiente = p_id_acudiente
      AND e.Estado_Estudiante = 1
    LIMIT 1;

END $$
DELIMITER ;


--      ACTUALIZAR DATOS

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_persona_actualizar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_persona_actualizar(
    IN p_id_persona INT,
    IN p_primer_nombre VARCHAR(50),
    IN p_segundo_nombre VARCHAR(50),
    IN p_primer_apellido VARCHAR(50),
    IN p_segundo_apellido VARCHAR(50),
    IN p_fecha_nac DATE,

    -- AUDITORÍA
    IN p_id_usuario INT,
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    DECLARE v_old JSON;
    DECLARE v_new JSON;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error actualizando persona';
    END;

    START TRANSACTION;

    -- VALIDAR EXISTENCIA
    IF NOT EXISTS (
        SELECT 1 FROM TBL_PERSONA WHERE ID_Persona = p_id_persona
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Persona no existe';
    END IF;

    -- OLD DATA
    SELECT JSON_OBJECT(
        'Primer_Nombre', Primer_Nombre,
        'Segundo_Nombre', Segundo_Nombre,
        'Primer_Apellido', Primer_Apellido,
        'Segundo_Apellido', Segundo_Apellido,
        'Fecha_Nacimiento', Fecha_Nacimiento
    )
    INTO v_old
    FROM TBL_PERSONA
    WHERE ID_Persona = p_id_persona;

    -- UPDATE
    UPDATE TBL_PERSONA
    SET
        Primer_Nombre = p_primer_nombre,
        Segundo_Nombre = p_segundo_nombre,
        Primer_Apellido = p_primer_apellido,
        Segundo_Apellido = p_segundo_apellido,
        Fecha_Nacimiento = p_fecha_nac
    WHERE ID_Persona = p_id_persona;

    -- NEW DATA
    SET v_new = JSON_OBJECT(
        'Primer_Nombre', p_primer_nombre,
        'Segundo_Nombre', p_segundo_nombre,
        'Primer_Apellido', p_primer_apellido,
        'Segundo_Apellido', p_segundo_apellido,
        'Fecha_Nacimiento', p_fecha_nac
    );

    -- AUDITORÍA
    CALL sp_insertar_auditoria(
        'TBL_PERSONA',
        'UPDATE',
        p_id_persona,
        v_old,
        v_new,
        p_ip,
        p_user_agent,
        p_id_usuario
    );

    COMMIT;

END $$
DELIMITER ;


-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_estudiante_actualizar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_estudiante_actualizar(
    IN p_grado_actual TINYINT,
    IN p_grado_proximo TINYINT,
    IN p_colegio INT,
    IN p_genero TINYINT,
    IN p_grupo_pref TINYINT,
    IN p_id_persona INT,

    -- AUDITORÍA
    IN p_id_usuario INT,
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    DECLARE v_old JSON;
    DECLARE v_new JSON;
    DECLARE v_id_estudiante INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error actualizando estudiante';
    END;

    START TRANSACTION;

    -- VALIDAR EXISTENCIA
    SELECT ID_Estudiante
    INTO v_id_estudiante
    FROM TBL_ESTUDIANTE
    WHERE FK_ID_Persona = p_id_persona
    LIMIT 1;

    IF v_id_estudiante IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Estudiante no existe';
    END IF;

    -- OLD DATA
    SELECT JSON_OBJECT(
        'Grado_Actual', FK_ID_Grado_Actual,
        'Grado_Proximo', FK_ID_Gardo_Proximo,
        'Colegio', FK_ID_Colegio_Anterior,
        'Genero', FK_ID_Genero,
        'Grupo_Preferencial', FK_ID_Grupo_Preferencial
    )
    
    INTO v_old
    FROM TBL_ESTUDIANTE
    WHERE ID_Estudiante = v_id_estudiante;

    -- UPDATE
    UPDATE TBL_ESTUDIANTE
    SET
        FK_ID_Grado_Actual = p_grado_actual,
        FK_ID_Gardo_Proximo = p_grado_proximo,
        FK_ID_Colegio_Anterior = p_colegio,
        FK_ID_Genero = p_genero,
        FK_ID_Grupo_Preferencial = p_grupo_pref
    WHERE ID_Estudiante = v_id_estudiante;

    -- NEW DATA
    SET v_new = JSON_OBJECT(
        'Grado_Actual', p_grado_actual,
        'Grado_Proximo', p_grado_proximo,
        'Colegio', p_colegio,
        'Genero', p_genero,
        'Grupo_Preferencial', p_grupo_pref
    );

    -- AUDITORÍA
    CALL sp_insertar_auditoria(
        'TBL_ESTUDIANTE',
        'UPDATE',
        v_id_estudiante,
        v_old,
        v_new,
        p_ip,
        p_user_agent,
        p_id_usuario
    );

    COMMIT;

END $$
DELIMITER ;


--      REGISTRAR ESTUDIANTE

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_registrar_estudiante_completo;

DELIMITER $$
CREATE PROCEDURE sp_registrar_estudiante_completo(
    -- PERSONA
    IN p_Num_Doc_Persona VARCHAR(30),
    IN p_Primer_Nombre VARCHAR(50),
    IN p_Segundo_Nombre VARCHAR(50),
    IN p_Primer_Apellido VARCHAR(50),
    IN p_Segundo_Apellido VARCHAR(50),
    IN p_Fecha_Nacimiento DATE,

    -- ESTUDIANTE
    IN p_FK_ID_Tipo_Iden TINYINT,
    IN p_FK_ID_Grado_Actual TINYINT,
    IN p_FK_ID_Gardo_Proximo TINYINT,
    IN p_FK_ID_Colegio_Anterior INT,
    IN p_FK_ID_Genero TINYINT,
    IN p_FK_ID_Grupo_Preferencial TINYINT,
    IN p_FK_ID_Acudiente INT,
    IN p_FK_ID_Parentesco_Es TINYINT,

    -- AUDITORÍA
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    -- Variables para capturar los IDs generados automáticamente
    DECLARE v_ID_Persona_New INT;
    DECLARE v_ID_Estudiante_New INT;

    -- Manejador de errores
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error en registro completo de estudiante';
    END;

    START TRANSACTION;

    -- INSERT PERSONA
    INSERT INTO TBL_PERSONA(
        Num_Doc_Persona,
        Primer_Nombre,
        Segundo_Nombre,
        Primer_Apellido,
        Segundo_Apellido,
        Fecha_Nacimiento,
        Estado_Persona
    )
    VALUES(
        p_Num_Doc_Persona,
        p_Primer_Nombre,
        p_Segundo_Nombre,
        p_Primer_Apellido,
        p_Segundo_Apellido,
        p_Fecha_Nacimiento,
        1
    );

    -- Capturar el ID generado para la persona
    SET v_ID_Persona_New = LAST_INSERT_ID();

    CALL sp_insertar_auditoria(
        'TBL_PERSONA',
        'CREATE',
        CAST(v_ID_Persona_New AS CHAR),
        NULL,
        JSON_OBJECT('Doc', p_Num_Doc_Persona, 'Nombre', p_Primer_Nombre),
        p_ip,
        p_user_agent,
        p_FK_ID_Acudiente
    );

    -- INSERT ESTUDIANTE
    INSERT INTO TBL_ESTUDIANTE (
        FK_ID_Tipo_Iden,
        FK_ID_Persona,
        FK_ID_Grado_Actual,
        FK_ID_Gardo_Proximo,
        FK_ID_Colegio_Anterior,
        FK_ID_Genero,
        FK_ID_Grupo_Preferencial,
        FK_ID_Acudiente,
        FK_ID_Parentesco_Es,
        Estado_Estudiante
    )
    VALUES (
        p_FK_ID_Tipo_Iden,
        v_ID_Persona_New,
        p_FK_ID_Grado_Actual,
        p_FK_ID_Gardo_Proximo,
        p_FK_ID_Colegio_Anterior,
        p_FK_ID_Genero,
        p_FK_ID_Grupo_Preferencial,
        p_FK_ID_Acudiente,
        p_FK_ID_Parentesco_Es,
        1
    );

    -- Capturar el ID generado para el estudiante
    SET v_ID_Estudiante_New = LAST_INSERT_ID();

    CALL sp_insertar_auditoria(
        'TBL_ESTUDIANTE',
        'CREATE',
        CAST(v_ID_Estudiante_New AS CHAR),
        NULL,
        JSON_OBJECT('ID_Persona', v_ID_Persona_New, 'Grado', p_FK_ID_Grado_Actual),
        p_ip,
        p_user_agent,
        p_FK_ID_Acudiente
    );

    COMMIT;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Usada en registro para validar si existe un estudiante con el mismo documento

DROP PROCEDURE IF EXISTS sp_tbl_estudiante_verificar_existente;

DELIMITER $$
CREATE PROCEDURE sp_tbl_estudiante_verificar_existente (
    IN p_num_doc VARCHAR(30),
    IN p_fk_id_acudiente INT
)
BEGIN

    SELECT COUNT(*) AS existe 
    FROM TBL_ESTUDIANTE e
    INNER JOIN TBL_PERSONA p ON e.FK_ID_Persona = p.ID_Persona
    WHERE p.Num_Doc_Persona = p_num_doc 
      AND e.FK_ID_Acudiente = p_fk_id_acudiente 
      AND e.Estado_Estudiante = 1; 
END $$
DELIMITER ;


-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE SECURITY
-- ====================================================================================================================================================

--      SISTEMA DE CAMBIO DE CONTRASEÑA

-- --------------------------------------------------------
-- Cambio de contraseña desde perfil

DROP PROCEDURE IF EXISTS sp_tbl_usuario_cambiar_contraseña_perfil;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_cambiar_contraseña_perfil(
    IN p_id_usuario INT,
    IN p_nuevo_hash VARBINARY(32),
    IN p_nuevo_salt VARBINARY(16),
    IN p_ip VARCHAR(50),
    IN p_user_agent VARCHAR(255)
)
BEGIN
    
    START TRANSACTION;

        -- Actualización de credenciales
        UPDATE TBL_USUARIO
        SET Contraseña_Hash = p_nuevo_hash,
            Password_Salt = p_nuevo_salt,
            Ultimo_Cambio_Contraseña = CURRENT_TIMESTAMP
        WHERE ID_Usuario = p_id_usuario;

        -- Registro de auditoría
        CALL sp_insertar_auditoria(
            'TBL_USUARIO', 
            'PASSWORD_CHANGE', 
            CAST(p_id_usuario AS CHAR),
            JSON_OBJECT('evento', 'cambio_password_perfil'),
            JSON_OBJECT('resultado', 'exitoso'),
            p_ip, 
            p_user_agent, 
            p_id_usuario
        );

    COMMIT;
END $$
DELIMITER ;


-- --------------------------------------------------------
    -- Reutilización de sp_validar_data_user



--      SISTEMA DE MFA

-- --------------------------------------------------------
-- Guardar secret MFA temporal

DROP PROCEDURE IF EXISTS sp_tbl_usuario_guardar_mfa_secret_temp;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_guardar_mfa_secret_temp(
    IN p_id_usuario INT,
    IN p_secret VARCHAR(64)
)
BEGIN
    UPDATE TBL_USUARIO
    SET MFA_Secret_Temp = p_secret
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Confirmar y activar MFA

DROP PROCEDURE IF EXISTS sp_tbl_usuario_activar_mfa;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_activar_mfa(
    IN p_id_usuario INT
)
BEGIN
    UPDATE TBL_USUARIO
    SET MFA_Fecha_Configuracion = CURRENT_TIMESTAMP,
        MFA_Secret = MFA_Secret_Temp,
        MFA_Secret_Temp = NULL,
        Doble_Factor_Activo = 'ACTIVE'
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Desactivar MFA

DROP PROCEDURE IF EXISTS sp_tbl_usuario_desactivar_mfa;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_desactivar_mfa(
    IN p_id_usuario INT
)
BEGIN
    UPDATE TBL_USUARIO
    SET MFA_Fecha_Configuracion = CURRENT_TIMESTAMP,
        MFA_Secret = NULL,
        MFA_Secret_Temp = NULL,
        Doble_Factor_Activo = 'INACTIVE'
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Obtener secret MFA activo

DROP PROCEDURE IF EXISTS sp_tbl_usuario_obtener_mfa_secret;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_obtener_mfa_secret(
    IN p_id_usuario INT
)
BEGIN
    SELECT MFA_Secret, MFA_Secret_Temp, Doble_Factor_Activo
    FROM TBL_USUARIO
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;


--      SISTEMA PARA VALIDAR SESIONES ACTIVAS

-- --------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_sesion_activa_registrar_sesion;

DELIMITER $$
CREATE PROCEDURE sp_tbl_sesion_activa_registrar_sesion(
    IN p_id_usuario INT,
    IN p_jti VARCHAR(64),
    IN p_dispositivo VARCHAR(255),
    IN p_ip VARCHAR(50)
)
BEGIN
    INSERT INTO TBL_SESION_ACTIVA (FK_ID_Usuario, JTI, Dispositivo, IP)
    VALUES (p_id_usuario, p_jti, p_dispositivo, p_ip)
    ON DUPLICATE KEY UPDATE Ultimo_Acceso = CURRENT_TIMESTAMP;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Listar sesiones activas de un usuario

DROP PROCEDURE IF EXISTS sp_tbl_sesion_activa_listar_sesiones;

DELIMITER $$
CREATE PROCEDURE sp_tbl_sesion_activa_listar_sesiones(
    IN p_id_usuario INT
)
BEGIN
    SELECT ID_Sesion, JTI, Dispositivo, IP, Fecha_Inicio, Ultimo_Acceso
    FROM TBL_SESION_ACTIVA
    WHERE FK_ID_Usuario = p_id_usuario
      AND Activa = 1
    ORDER BY Ultimo_Acceso DESC;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- Cerrar sesión específica (por JTI)

DROP PROCEDURE IF EXISTS sp_tbl_sesion_activa_cerrar_sesion;

DELIMITER $$
CREATE PROCEDURE sp_tbl_sesion_activa_cerrar_sesion(
    IN p_jti VARCHAR(64)
)
BEGIN
    UPDATE TBL_SESION_ACTIVA
    SET Activa = 0
    WHERE JTI = p_jti;
END $$
DELIMITER ;


-- --------------------------------------------------------
-- SP: Cerrar todas las sesiones de un usuario

DROP PROCEDURE IF EXISTS sp_tbl_sesion_activa_cerrar_todas_sesiones;

DELIMITER $$
CREATE PROCEDURE sp_tbl_sesion_activa_cerrar_todas_sesiones(
    IN p_id_usuario INT,
    IN p_jti_actual VARCHAR(64)   -- excluir la sesión actual
)
BEGIN
    UPDATE TBL_SESION_ACTIVA
    SET Activa = 0
    WHERE FK_ID_Usuario = p_id_usuario
      AND JTI <> p_jti_actual;
END $$
DELIMITER ;




-- ====================================================================================================================================================
-- SP PARA LA PAGINA DE SETTINGS
-- ====================================================================================================================================================

--      SISTEMA DE CONFIGURACIONES VARIAS

-- --------------------------------------------------------
-- SP: Obtener preferencias de notificación del usuario

DROP PROCEDURE IF EXISTS sp_configuracion_obtener_notificaciones;
 
DELIMITER $$
CREATE PROCEDURE sp_configuracion_obtener_notificaciones(
    IN p_id_usuario INT
)
BEGIN
    SELECT
        Notificaciones_Email,
        Notificaciones_Navegador
    FROM TBL_USUARIO
    WHERE ID_Usuario = p_id_usuario
      AND Estado_Usuario = 1;
END $$
DELIMITER ;
 
 
-- --------------------------------------------------------
-- SP: Actualizar notificaciones de correo electrónico

DROP PROCEDURE IF EXISTS sp_configuracion_actualizar_notif_email;
 
DELIMITER $$
CREATE PROCEDURE sp_configuracion_actualizar_notif_email(
    IN p_id_usuario INT,
    IN p_activo TINYINT(1)
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;
 
    SELECT COUNT(*) INTO v_existe
    FROM TBL_USUARIO
    WHERE ID_Usuario   = p_id_usuario
      AND Estado_Usuario = 1;
 
    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Usuario no encontrado o inactivo.';
    END IF;
 
    UPDATE TBL_USUARIO
    SET Notificaciones_Email = p_activo
    WHERE ID_Usuario = p_id_usuario;
 
    -- Devuelve el estado actualizado para confirmación
    SELECT Notificaciones_Email AS notif_email_activo
    FROM TBL_USUARIO
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;
 
 
-- --------------------------------------------------------
-- SP: Actualizar notificaciones del navegador

DROP PROCEDURE IF EXISTS sp_configuracion_actualizar_notif_navegador;
 
DELIMITER $$
CREATE PROCEDURE sp_configuracion_actualizar_notif_navegador(
    IN p_id_usuario INT,
    IN p_activo TINYINT(1)
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;
 
    SELECT COUNT(*) INTO v_existe
    FROM TBL_USUARIO
    WHERE ID_Usuario    = p_id_usuario
      AND Estado_Usuario = 1;
 
    IF v_existe = 0 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Usuario no encontrado o inactivo.';
    END IF;
 
    UPDATE TBL_USUARIO
    SET Notificaciones_Navegador = p_activo
    WHERE ID_Usuario = p_id_usuario;
 
    -- Devuelve el estado actualizado para confirmación
    SELECT Notificaciones_Navegador AS notif_navegador_activo
    FROM TBL_USUARIO
    WHERE ID_Usuario = p_id_usuario;
END $$
DELIMITER ;


--      SISTEMA PARA ELIMINAR AL USUARIO ACTUAL

-- --------------------------------------------------------
    -- Reutilización de sp_tbl_usuario_validar_login


-- --------------------------------------------------------
-- SP: Eliminar Usuario y Estudiante asociado

DROP PROCEDURE IF EXISTS sp_eliminar_cuenta_completa;

DELIMITER $$
CREATE PROCEDURE sp_eliminar_cuenta_completa(
    IN p_ID_Usuario INT,
    IN p_IP VARCHAR(50),
    IN p_User_Agent VARCHAR(255)
)
BEGIN
    -- Declaración de variable para el prefijo de ofuscación
    DECLARE v_Timestamp VARCHAR(20);
    
    -- Manejador de errores para hacer ROLLBACK
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error en la eliminación completa del usuario y sus estudiantes asociados';
    END;

    -- Generar una marca de tiempo única para esta transacción
    SET v_Timestamp = DATE_FORMAT(NOW(), '%Y%m%d%H%i%s');

    START TRANSACTION;
        
        -- OFUSCAR Y DESACTIVAR PERSONAS DE LOS ESTUDIANTES 
        UPDATE TBL_PERSONA 
        SET Num_Doc_Persona = CONCAT('DEL_', v_Timestamp, '_', Num_Doc_Persona),
            Estado_Persona = 0
        WHERE ID_Persona IN (
            SELECT FK_ID_Persona FROM TBL_ESTUDIANTE WHERE FK_ID_Acudiente = p_ID_Usuario
        );

        -- INACTIVAR REGISTROS EN TBL_ESTUDIANTE
        UPDATE TBL_ESTUDIANTE 
        SET Estado_Estudiante = 0
        WHERE FK_ID_Acudiente = p_ID_Usuario;

        -- Registro de auditoría para los estudiantes
        CALL sp_insertar_auditoria(
            'TBL_ESTUDIANTE', 'DELETE_STUDENT', CAST(p_ID_Usuario AS CHAR),
            NULL, JSON_OBJECT('Accion', 'Baja masiva por retiro de acudiente'),
            p_IP, p_User_Agent, p_ID_Usuario
        );

        -- LOGICA DE OFUSCACIÓN DE USUARIO Y DATOS ADICIONALES
        UPDATE TBL_USUARIO u
        JOIN TBL_DATOS_ADICIONALES d ON u.FK_ID_Persona = d.FK_ID_Persona
        SET u.Estado_Usuario = 0,
            u.Nombre_Usuario = CONCAT('del_', v_Timestamp, '_', u.Nombre_Usuario),
            d.Estado_Datos_Adicionales = 0,
            d.Email = CONCAT('del_', v_Timestamp, '_', d.Email),
            d.Telefono = CONCAT('del_', v_Timestamp, '_', d.Telefono)
        WHERE u.ID_Usuario = p_ID_Usuario;

        -- INACTIVAR Y OFUSCAR PERSONA DEL USUARIO
        UPDATE TBL_PERSONA p
        JOIN TBL_USUARIO u ON p.ID_Persona = u.FK_ID_Persona
        SET p.Estado_Persona = 0,
            p.Num_Doc_Persona = CONCAT('DEL_', v_Timestamp, '_', p.Num_Doc_Persona)
        WHERE u.ID_Usuario = p_ID_Usuario;

        -- Auditoría final del cierre de cuenta
        CALL sp_insertar_auditoria(
            'SISTEMA', 'ACCOUNT_CLOSED', CAST(p_ID_Usuario AS CHAR),
            NULL, JSON_OBJECT('Status', 'Cuenta inactivada y datos UNIQUE liberados'),
            p_IP, p_User_Agent, p_ID_Usuario
        );

    COMMIT;
END $$
DELIMITER ;