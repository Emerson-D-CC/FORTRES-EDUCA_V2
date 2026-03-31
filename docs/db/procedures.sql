    USE FORTRESS_EDUCA_DB;


    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_auditoria_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_auditoria_actualizar(
        IN p_ID_Auditoria BIGINT,
        IN p_Tabla_Afectada VARCHAR(100),
        IN p_Tipo_Evento VARCHAR(15),
        IN p_ID_Registro_Afectado VARCHAR(50),
        IN p_IP_Usuario VARCHAR(50),
        IN p_FK_ID_Usuario VARCHAR(16)
    )
    BEGIN
        UPDATE tbl_auditoria
        SET
            Tabla_Afectada = p_Tabla_Afectada,
            Tipo_Evento = p_Tipo_Evento,
            ID_Registro_Afectado = p_ID_Registro_Afectado,
            IP_Usuario = p_IP_Usuario,
            FK_ID_Usuario = p_FK_ID_Usuario
        WHERE ID_Auditoria = p_ID_Auditoria;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_auditoria_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_auditoria_consultar()
    BEGIN
        SELECT *
        FROM tbl_auditoria
        WHERE Estado_Auditoria = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_auditoria_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_auditoria_consultar_id(
        IN p_ID_Auditoria BIGINT
    )
    BEGIN
        SELECT *
        FROM tbl_auditoria
        WHERE ID_Auditoria = p_ID_Auditoria
        AND Estado_Auditoria = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_auditoria_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_auditoria_eliminar(
        IN p_ID_Auditoria BIGINT
    )
    BEGIN
        UPDATE tbl_auditoria
        SET Estado_Auditoria = 'INACTIVE'
        WHERE ID_Auditoria = p_ID_Auditoria;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_auditoria_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_auditoria_insertar(
        IN p_Tabla_Afectada VARCHAR(100),
        IN p_Tipo_Evento VARCHAR(15),
        IN p_ID_Registro_Afectado VARCHAR(50),
        IN p_IP_Usuario VARCHAR(50),
        IN p_FK_ID_Usuario VARCHAR(16)
    )
    BEGIN
        INSERT INTO tbl_auditoria(
            Tabla_Afectada,
            Tipo_Evento,
            ID_Registro_Afectado,
            Fecha_Auditoria,
            IP_Usuario,
            FK_ID_Usuario,
            Estado_Auditoria
        )
        VALUES(
            p_Tabla_Afectada,
            p_Tipo_Evento,
            p_ID_Registro_Afectado,
            NOW(),
            p_IP_Usuario,
            p_FK_ID_Usuario,
            'ACTIVE'
        );
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
    WHERE Estado_Localidad = 'ACTIVE'
    ORDER BY Nombre_Localidad;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_barrio_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_barrio_actualizar(
        IN p_ID_Barrio INT,
        IN p_Nombre_Barrio VARCHAR(30),
        IN p_FK_ID_Localidad INT
    )
    BEGIN
        UPDATE tbl_barrio
        SET
            Nombre_Barrio = p_Nombre_Barrio,
            FK_ID_Localidad = p_FK_ID_Localidad
        WHERE ID_Barrio = p_ID_Barrio;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_barrio_lista;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_barrio_lista()
    BEGIN
        SELECT *
        FROM tbl_barrio
        WHERE Estado_Barrio = 'ACTIVE';
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
    WHERE Estado_Barrio = 'ACTIVE'
    ORDER BY Nombre_Barrio;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_barrio_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_barrio_consultar_id(
        IN p_ID_Barrio INT
    )
    BEGIN
        SELECT *
        FROM tbl_barrio
        WHERE ID_Barrio = p_ID_Barrio
        AND Estado_Barrio = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_barrio_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_barrio_eliminar(
        IN p_ID_Barrio INT
    )
    BEGIN
        UPDATE tbl_barrio
        SET Estado_Barrio = 'INACTIVE'
        WHERE ID_Barrio = p_ID_Barrio;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_barrio_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_barrio_insertar(
        IN p_Nombre_Barrio VARCHAR(30),
        IN p_FK_ID_Localidad INT
    )
    BEGIN
        INSERT INTO tbl_barrio(
            Nombre_Barrio,
            FK_ID_Localidad,
            Estado_Barrio
        )
        VALUES(
            p_Nombre_Barrio,
            p_FK_ID_Localidad,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_barrio_por_localidad;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_barrio_por_localidad(
        IN p_FK_ID_Localidad INT
    )
    BEGIN
        SELECT 
            ID_Barrio,
            Nombre_Barrio,
            FK_ID_Localidad
        FROM tbl_barrio
        WHERE FK_ID_Localidad = p_FK_ID_Localidad
        AND Estado_Barrio = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_colegio_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_colegio_actualizar(
        IN p_ID_Colegio INT,
        IN p_Nombre_Colegio VARCHAR(100),
        IN p_Direccion_Colegio VARCHAR(100),
        IN p_FK_ID_Localidad INT
    )
    BEGIN
        UPDATE tbl_colegio
        SET
            Nombre_Colegio = p_Nombre_Colegio,
            Direccion_Colegio = p_Direccion_Colegio,
            FK_ID_Localidad = p_FK_ID_Localidad
        WHERE ID_Colegio = p_ID_Colegio;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_colegio_lista;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_colegio_lista()
    BEGIN
        SELECT *
        FROM tbl_colegio
        WHERE Estado_Colegio = 'ACTIVE';
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
    WHERE Estado_Colegio = 'ACTIVE'
    ORDER BY Nombre_Colegio;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_colegio_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_colegio_consultar_id(
        IN p_ID_Colegio INT
    )
    BEGIN
        SELECT *
        FROM tbl_colegio
        WHERE ID_Colegio = p_ID_Colegio
        AND Estado_Colegio = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_colegio_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_colegio_eliminar(
        IN p_ID_Colegio INT
    )
    BEGIN
        UPDATE tbl_colegio
        SET Estado_Colegio = 'INACTIVE'
        WHERE ID_Colegio = p_ID_Colegio;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_colegio_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_colegio_insertar(
        IN p_Nombre_Colegio VARCHAR(100),
        IN p_Direccion_Colegio VARCHAR(100),
        IN p_FK_ID_Localidad INT
    )
    BEGIN
        INSERT INTO tbl_colegio(
            Nombre_Colegio,
            Direccion_Colegio,
            FK_ID_Localidad,
            Estado_Colegio
        )
        VALUES(
            p_Nombre_Colegio,
            p_Direccion_Colegio,
            p_FK_ID_Localidad,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_cupos_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_cupos_actualizar(
        IN p_ID_Cupos INT,
        IN p_FK_ID_Grado INT,
        IN p_FK_ID_Colegio INT,
        IN p_Jornada VARCHAR(30),
        IN p_Cupos_Disponibles TINYINT
    )
    BEGIN
        UPDATE tbl_cupos
        SET
            FK_ID_Grado = p_FK_ID_Grado,
            FK_ID_Colegio = p_FK_ID_Colegio,
            Jornada = p_Jornada,
            Cupos_Disponibles = p_Cupos_Disponibles
        WHERE ID_Cupos = p_ID_Cupos;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_cupos_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_cupos_consultar()
    BEGIN
        SELECT *
        FROM tbl_cupos
        WHERE Estado_Cupos = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_cupos_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_cupos_consultar_id(
        IN p_ID_Cupos INT
    )
    BEGIN
        SELECT *
        FROM tbl_cupos
        WHERE ID_Cupos = p_ID_Cupos
        AND Estado_Cupos = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_cupos_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_cupos_eliminar(
        IN p_ID_Cupos INT
    )
    BEGIN
        UPDATE tbl_cupos
        SET Estado_Cupos = 'INACTIVE'
        WHERE ID_Cupos = p_ID_Cupos;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_cupos_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_cupos_insertar(
        IN p_FK_ID_Grado INT,
        IN p_FK_ID_Colegio INT,
        IN p_Jornada VARCHAR(30),
        IN p_Cupos_Disponibles TINYINT
    )
    BEGIN
        INSERT INTO tbl_cupos(
            FK_ID_Grado,
            FK_ID_Colegio,
            Jornada,
            Cupos_Disponibles,
            Estado_Cupos
        )
        VALUES(
            p_FK_ID_Grado,
            p_FK_ID_Colegio,
            p_Jornada,
            p_Cupos_Disponibles,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_actualizar_all;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_datos_adicionales_actualizar_all(
        IN p_ID_Datos_Adicionales VARCHAR(16),
        IN p_Email VARCHAR(255),
        IN p_Telefono VARCHAR(20),
        IN p_FK_ID_Tipo_Iden INT,
        IN p_FK_ID_Persona VARCHAR(15),
        IN p_FK_ID_Genero INT,
        IN p_FK_ID_Grupo_Preferencia INT,
        IN p_FK_ID_Estrato INT,
        IN p_FK_ID_Localidad INT
    )
    BEGIN
        UPDATE tbl_datos_adicionales
        SET
            Email = p_Email,
            Telefono = p_Telefono,
            FK_ID_Tipo_Iden = p_FK_ID_Tipo_Iden,
            FK_ID_Persona = p_FK_ID_Persona,
            FK_ID_Genero = p_FK_ID_Genero,
            FK_ID_Grupo_Preferencia = p_FK_ID_Grupo_Preferencia,
            FK_ID_Estrato = p_FK_ID_Estrato,
            FK_ID_Localidad = p_FK_ID_Localidad
        WHERE ID_Datos_Adicionales = p_ID_Datos_Adicionales;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_datos_adicionales_consultar()
    BEGIN
        SELECT *
        FROM tbl_datos_adicionales
        WHERE Estado_Datos_Adicionales = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_datos_adicionales_consultar_id(
        IN p_ID_Datos_Adicionales VARCHAR(16)
    )
    BEGIN
        SELECT *
        FROM tbl_datos_adicionales
        WHERE ID_Datos_Adicionales = p_ID_Datos_Adicionales
        AND Estado_Datos_Adicionales = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_datos_adicionales_eliminar(
        IN p_ID_Datos_Adicionales VARCHAR(16)
    )
    BEGIN
        UPDATE tbl_datos_adicionales
        SET Estado_Datos_Adicionales = 'INACTIVE'
        WHERE ID_Datos_Adicionales = p_ID_Datos_Adicionales;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_insertar;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_datos_adicionales_insertar(

        IN p_ID_Datos_Adicionales VARCHAR(16),
        IN p_Email VARCHAR(255),
        IN p_Telefono VARCHAR(20),
        IN p_FK_ID_Parentesco INT,
        IN p_FK_ID_Tipo_Iden INT,
        IN p_FK_ID_Persona VARCHAR(15),
        IN p_FK_ID_Genero INT,
        IN p_FK_ID_Grupo_Preferencial INT,
        IN p_FK_ID_Estrato INT,
        IN p_FK_ID_Barrio INT

    )
    BEGIN

    INSERT INTO TBL_DATOS_ADICIONALES(

        ID_Datos_Adicionales,
        Email,
        Telefono,
        FK_ID_Parentesco,
        FK_ID_Tipo_Iden,
        FK_ID_Persona,
        FK_ID_Genero,
        FK_ID_Grupo_Preferencial,
        FK_ID_Estrato,
        FK_ID_Barrio,

        Estado_Datos_Adicionales
    )

    VALUES(

        p_ID_Datos_Adicionales,
        p_Email,
        p_Telefono,
        p_FK_ID_Parentesco,
        p_FK_ID_Tipo_Iden,
        p_FK_ID_Persona,
        p_FK_ID_Genero,
        p_FK_ID_Grupo_Preferencial,
        p_FK_ID_Estrato,
        p_FK_ID_Barrio,

        'ACTIVE'
    );

    END $$

    DELIMITER ;

    -- --------------------------------------------------------

    --  SP: Actualizar TBL_DATOS_ADICIONALES (acudiente)
    DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_actualizar;
    DELIMITER $$
    CREATE PROCEDURE sp_tbl_datos_adicionales_actualizar(
        IN p_id_datos VARCHAR(16),
        IN p_telefono VARCHAR(20),
        IN p_id_persona VARCHAR(15),
        IN p_genero INT,
        IN p_grupo_pref INT,
        IN p_estrato INT,
        IN p_barrio INT
    )
    BEGIN
        UPDATE TBL_DATOS_ADICIONALES
        SET
            Telefono = p_telefono,
            FK_ID_Genero = p_genero,
            FK_ID_Grupo_Preferencial = p_grupo_pref,
            FK_ID_Estrato = p_estrato,
            FK_ID_Barrio = p_barrio
        WHERE ID_Datos_Adicionales = p_id_datos
        AND FK_ID_Persona = p_id_persona;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_documento_ticket_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_documento_ticket_actualizar(
        IN p_ID_Doc_Ticket INT,
        IN p_FK_ID_Ticket VARCHAR(10),
        IN p_FK_ID_Tipo_Doc INT,
        IN p_Archivo MEDIUMBLOB,
        IN p_Nombre_Original VARCHAR(100)
    )
    BEGIN
        UPDATE tbl_documento_ticket
        SET
            FK_ID_Ticket = p_FK_ID_Ticket,
            FK_ID_Tipo_Doc = p_FK_ID_Tipo_Doc,
            Archivo = p_Archivo,
            Nombre_Original = p_Nombre_Original
        WHERE ID_Doc_Ticket = p_ID_Doc_Ticket;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_documento_ticket_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_documento_ticket_consultar()
    BEGIN
        SELECT ID_Doc_Ticket, FK_ID_Ticket, FK_ID_Tipo_Doc, Nombre_Original, Fecha_Subida, Estado_Documentos
        FROM tbl_documento_ticket
        WHERE Estado_Documentos = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_documento_ticket_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_documento_ticket_consultar_id(
        IN p_ID_Doc_Ticket INT
    )
    BEGIN
        SELECT *
        FROM tbl_documento_ticket
        WHERE ID_Doc_Ticket = p_ID_Doc_Ticket
        AND Estado_Documentos = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_documento_ticket_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_documento_ticket_eliminar(
        IN p_ID_Doc_Ticket INT
    )
    BEGIN
        UPDATE tbl_documento_ticket
        SET Estado_Documentos = 'INACTIVE'
        WHERE ID_Doc_Ticket = p_ID_Doc_Ticket;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_documento_ticket_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_documento_ticket_insertar(
        IN p_FK_ID_Ticket VARCHAR(10),
        IN p_FK_ID_Tipo_Doc INT,
        IN p_Archivo MEDIUMBLOB,
        IN p_Nombre_Original VARCHAR(100)
    )
    BEGIN
        INSERT INTO tbl_documento_ticket(
            FK_ID_Ticket,
            FK_ID_Tipo_Doc,
            Archivo,
            Nombre_Original,
            Estado_Documentos
        )
        VALUES(
            p_FK_ID_Ticket,
            p_FK_ID_Tipo_Doc,
            p_Archivo,
            p_Nombre_Original,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estado_ticket_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estado_ticket_actualizar(
        IN p_ID_Estado_Ticket INT,
        IN p_Nombre_Estado VARCHAR(50),
        IN p_Estado_Final TINYINT(1)
    )
    BEGIN
        UPDATE tbl_estado_ticket
        SET
            Nombre_Estado = p_Nombre_Estado,
            Estado_Final = p_Estado_Final
        WHERE ID_Estado_Ticket = p_ID_Estado_Ticket;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estado_ticket_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estado_ticket_consultar()
    BEGIN
        SELECT 
            ID_Estado_Ticket, 
            Nombre_Estado, 
            Estado_Final, 
            Estado_Estado_Ticket
        FROM tbl_estado_ticket
        WHERE Estado_Estado_Ticket = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estado_ticket_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estado_ticket_consultar_id(
        IN p_ID_Estado_Ticket INT
    )
    BEGIN
        SELECT *
        FROM tbl_estado_ticket
        WHERE ID_Estado_Ticket = p_ID_Estado_Ticket
        AND Estado_Estado_Ticket = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estado_ticket_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estado_ticket_eliminar(
        IN p_ID_Estado_Ticket INT
    )
    BEGIN
        UPDATE tbl_estado_ticket
        SET Estado_Estado_Ticket = 'INACTIVE'
        WHERE ID_Estado_Ticket = p_ID_Estado_Ticket;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_estado_ticket_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estado_ticket_insertar(
        IN p_Nombre_Estado VARCHAR(50),
        IN p_Estado_Final TINYINT(1)
    )
    BEGIN
        INSERT INTO tbl_estado_ticket(
            Nombre_Estado,
            Estado_Final,
            Estado_Estado_Ticket
        )
        VALUES(
            p_Nombre_Estado,
            p_Estado_Final,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estrato_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estrato_actualizar(
        IN p_ID_Estrato INT,
        IN p_Numero_Estrato INT,
        IN p_Nivel_Prioridad_E TINYINT
    )
    BEGIN
        UPDATE tbl_estrato
        SET
            Numero_Estrato = p_Numero_Estrato,
            Nivel_Prioridad_E = p_Nivel_Prioridad_E
        WHERE ID_Estrato = p_ID_Estrato;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estrato_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estrato_consultar()
    BEGIN
        SELECT 
            ID_Estrato, 
            Numero_Estrato
        FROM tbl_estrato
        WHERE Estado_Estrato = 'ACTIVE'
        ORDER BY ID_Estrato;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estrato_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estrato_consultar_id(
        IN p_ID_Estrato INT
    )
    BEGIN
        SELECT *
        FROM tbl_estrato
        WHERE ID_Estrato = p_ID_Estrato
        AND Estado_Estrato = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estrato_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estrato_eliminar(
        IN p_ID_Estrato INT
    )
    BEGIN
        UPDATE tbl_estrato
        SET Estado_Estrato = 'INACTIVE'
        WHERE ID_Estrato = p_ID_Estrato;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estrato_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estrato_insertar(
        IN p_Numero_Estrato INT,
        IN p_Nivel_Prioridad_E TINYINT
    )
    BEGIN
        INSERT INTO tbl_estrato(
            Numero_Estrato,
            Nivel_Prioridad_E,
            Estado_Estrato
        )
        VALUES(
            p_Numero_Estrato,
            p_Nivel_Prioridad_E,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_actualizar_all;
    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estudiante_actualizar_all(
        IN p_ID_Estudiante VARCHAR(16),
        IN p_FK_ID_Tipo_Iden INT,
        IN p_FK_ID_Persona VARCHAR(15),
        IN p_FK_ID_Grado_Actual INT,
        IN p_FK_ID_Gardo_Proximo INT,
        IN p_FK_ID_Colegio_Anterior INT,
        IN p_FK_ID_Genero INT,
        IN p_FK_ID_Grupo_Preferencial INT,
        IN p_FK_ID_Acudiente VARCHAR(16),
        IN p_FK_ID_Parentesco INT,
        IN p_Estado_Estudiante ENUM('ACTIVE','INACTIVE')
    )
    BEGIN
        UPDATE TBL_ESTUDIANTE
        SET FK_ID_Tipo_Iden = p_FK_ID_Tipo_Iden,
            FK_ID_Persona = p_FK_ID_Persona,
            FK_ID_Grado_Actual = p_FK_ID_Grado_Actual,
            FK_ID_Gardo_Proximo = p_FK_ID_Gardo_Proximo,
            FK_ID_Colegio_Anterior = p_FK_ID_Colegio_Anterior,
            FK_ID_Genero = p_FK_ID_Genero,
            FK_ID_Grupo_Preferencial = p_FK_ID_Grupo_Preferencial,
            FK_ID_Acudiente = p_FK_ID_Acudiente,
            FK_ID_Parentesco = p_FK_ID_Parentesco,
            Estado_Estudiante = p_Estado_Estudiante
        WHERE ID_Estudiante = p_ID_Estudiante;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_actualizar;
    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estudiante_actualizar(
        IN p_grado_actual INT,
        IN p_grado_proximo INT,
        IN p_colegio INT,
        IN p_genero INT,
        IN p_grupo_pref INT,
        IN p_id_persona VARCHAR(15)
    )
    BEGIN
        UPDATE TBL_ESTUDIANTE
        SET
            FK_ID_Grado_Actual = p_grado_actual,
            FK_ID_Gardo_Proximo = p_grado_proximo,
            FK_ID_Colegio_Anterior = p_colegio,
            FK_ID_Genero = p_genero,
            FK_ID_Grupo_Preferencial = p_grupo_pref
        WHERE FK_ID_Persona = p_id_persona;
    END$$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_consultar;
    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estudiante_consultar()
    BEGIN
        SELECT * FROM TBL_ESTUDIANTE WHERE Estado_Estudiante = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estudiante_consultar_id(
        IN p_ID_Estudiante VARCHAR(16)
    )
    BEGIN
        SELECT * FROM tbl_estudiante 
        WHERE ID_Estudiante = p_ID_Estudiante AND Estado_Colegio = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estudiante_eliminar(
        IN p_ID_Estudiante VARCHAR(16)
    )
    BEGIN
        UPDATE tbl_estudiante SET Estado_Colegio = 'INACTIVE' WHERE ID_Estudiante = p_ID_Estudiante;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_estudiante_insertar(
        IN p_ID_Estudiante VARCHAR(16),
        IN p_FK_ID_Tipo_Iden INT,
        IN p_FK_ID_Persona VARCHAR(15),
        IN p_FK_ID_Grado_Actual INT,
        IN p_FK_ID_Gardo_Proximo INT,
        IN p_FK_ID_Colegio_Anterior INT,
        IN p_FK_ID_Genero INT,
        IN p_FK_ID_Grupo_Preferencial INT,
        IN p_FK_ID_Acudiente VARCHAR(16),
        IN p_FK_ID_Parentesco_Es INT
    )
    BEGIN
        INSERT INTO TBL_ESTUDIANTE (
            ID_Estudiante,
            FK_ID_Tipo_Iden,
            FK_ID_Persona,
            FK_ID_Grado_Actual,
            FK_ID_Gardo_Proximo,
            FK_ID_Colegio_Anterior,
            FK_ID_Genero,
            FK_ID_Grupo_Preferencial,
            FK_ID_Acudiente,
            FK_ID_Parentesco_Es
        )
        VALUES (
            p_ID_Estudiante,
            p_FK_ID_Tipo_Iden,
            p_FK_ID_Persona,
            p_FK_ID_Grado_Actual,
            p_FK_ID_Gardo_Proximo,
            p_FK_ID_Colegio_Anterior,
            p_FK_ID_Genero,
            p_FK_ID_Grupo_Preferencial,
            p_FK_ID_Acudiente,
            p_FK_ID_Parentesco_Es
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------
    --  SP: Perfil del estudiante (datos para pre-poblar forms)
    DROP PROCEDURE IF EXISTS sp_perfil_estudiante_consultar;
    DELIMITER $$
    CREATE PROCEDURE sp_perfil_estudiante_consultar(
        IN p_id_acudiente VARCHAR(16)
    )
    BEGIN
        SELECT
            -- Para el WHERE del UPDATE posterior
            p.ID_Persona,

            -- Identificación (solo lectura)
            ti.Nombre_Tipo_Iden,
            p.ID_Persona AS Numero_Documento,

            -- Nombre (editable)
            p.Primer_Nombre,
            p.Segundo_Nombre,
            p.Primer_Apellido,
            p.Segundo_Apellido,

            -- Demográficos (editable)
            p.Fecha_Nacimiento,
            e.FK_ID_Genero AS ID_Genero,
            e.FK_ID_Grupo_Preferencial AS ID_Grupo_Preferencial,

            -- Académicos (editable)
            e.FK_ID_Grado_Actual AS ID_Grado_Actual,
            e.FK_ID_Gardo_Proximo AS ID_Grado_Proximo,
            e.FK_ID_Colegio_Anterior AS ID_Colegio_Anterior
        FROM TBL_ESTUDIANTE e
        INNER JOIN TBL_PERSONA p ON e.FK_ID_Persona = p.ID_Persona
        INNER JOIN TBL_TIPO_IDENTIFICACION ti ON e.FK_ID_Tipo_Iden = ti.ID_Tipo_Iden
        WHERE e.FK_ID_Acudiente = p_id_acudiente
        AND e.Estado_Estudiante = 'ACTIVE'
        LIMIT 1;
    END$$

    DELIMITER ;

    -- --------------------------------------------------------
    -- Usada en decorador para validar si el acudiente ya tiene un estudiante registrado

    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_verificar_por_acudiente;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_estudiante_verificar_por_acudiente(
        IN p_id_acudiente VARCHAR(16)
    )
    BEGIN
        SELECT COUNT(*) AS tiene_estudiante
        FROM TBL_ESTUDIANTE
        WHERE FK_ID_Acudiente = p_id_acudiente
        AND Estado_Estudiante = 'ACTIVE'
        LIMIT 1;
    END$$

    DELIMITER ;

    -- --------------------------------------------------------
    -- Usada en registro para validar si existe un estudiante con el mismo documento
    DROP PROCEDURE IF EXISTS sp_tbl_estudiante_verificar_existente;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_estudiante_verificar_existente (
        IN p_id_estudiante VARCHAR(16),
        IN p_fk_id_acudiente VARCHAR(16)
    )
    BEGIN
        DECLARE existe INT;

        -- Contamos si hay coincidencias
        SELECT COUNT(*) INTO existe 
        FROM TBL_ESTUDIANTE 
        WHERE ID_Estudiante = p_id_estudiante AND FK_ID_Acudiente = p_fk_id_acudiente AND Estado_Estudiante = 'ACTIVE'; 

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_genero_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_genero_actualizar(IN p_ID_Genero INT, IN p_Nombre_Genero VARCHAR(30))
    BEGIN
        UPDATE tbl_genero SET Nombre_Genero = p_Nombre_Genero WHERE ID_Genero = p_ID_Genero;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_genero_lista;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_genero_lista()
    BEGIN
        SELECT * FROM tbl_genero WHERE Estado_Genero = 'ACTIVE';
    END $$
    DELIMITER ;


    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_genero_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_genero_consultar()
    BEGIN
    SELECT
        ID_Genero,
        Nombre_Genero
    FROM TBL_GENERO
    WHERE Estado_Genero = 'ACTIVE'
    ORDER BY Nombre_Genero;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_genero_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_genero_consultar_id(IN p_ID_Genero INT)
    BEGIN
        SELECT * FROM tbl_genero WHERE ID_Genero = p_ID_Genero AND Estado_Genero = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_genero_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_genero_eliminar(IN p_ID_Genero INT)
    BEGIN
        UPDATE tbl_genero SET Estado_Genero = 'INACTIVE' WHERE ID_Genero = p_ID_Genero;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_genero_insertar;

    DELIMITER $$
    CREATE PROCEDURE `sp_tbl_genero_insertar`(IN p_Nombre_Genero VARCHAR(30))
    BEGIN
        INSERT INTO tbl_genero(Nombre_Genero, Estado_Genero) VALUES(p_Nombre_Genero, 'ACTIVE');
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grado_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grado_actualizar(
        IN p_ID_Grado INT,
        IN p_Nombre_Grado VARCHAR(30),
        IN p_Nivel_Educativo VARCHAR(30)
    )
    BEGIN
        UPDATE tbl_grado
        SET Nombre_Grado = p_Nombre_Grado,
            Nivel_Educativo = p_Nivel_Educativo
        WHERE ID_Grado = p_ID_Grado;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grado_lista;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grado_lista()
    BEGIN
        SELECT * FROM tbl_grado WHERE Estado_Grado = 'ACTIVE';
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
    WHERE Estado_Grado = 'ACTIVE'
    ORDER BY ID_Grado;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grado_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grado_consultar_id(
        IN p_ID_Grado INT
    )
    BEGIN
        SELECT * FROM tbl_grado 
        WHERE ID_Grado = p_ID_Grado AND Estado_Grado = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grado_eliminar;

    DELIMITER $$
    CREATE PROCEDURE `sp_tbl_grado_eliminar`(
        IN p_ID_Grado INT
    )
    BEGIN
        UPDATE tbl_grado SET Estado_Grado = 'INACTIVE' WHERE ID_Grado = p_ID_Grado;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grado_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grado_insertar(
        IN p_Nombre_Grado VARCHAR(30),
        IN p_Nivel_Educativo VARCHAR(30)
    )
    BEGIN
        INSERT INTO tbl_grado(
            Nombre_Grado,
            Nivel_Educativo,
            Estado_Grado
        )
        VALUES(
            p_Nombre_Grado,
            p_Nivel_Educativo,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grupo_preferencial_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grupo_preferencial_actualizar(IN p_ID_Grupo_Preferencial INT, IN p_Nombre_Grupo_Preferencial VARCHAR(100), IN p_Nivel_Prioridad_GP TINYINT)
    BEGIN
        UPDATE tbl_grupo_preferencial SET Nombre_Grupo_Preferencial = p_Nombre_Grupo_Preferencial, Nivel_Prioridad_GP = p_Nivel_Prioridad_GP 
        WHERE ID_Grupo_Preferencial = p_ID_Grupo_Preferencial;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grupo_preferencial_lista;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grupo_preferencial_lista()
    BEGIN
        SELECT * FROM tbl_grupo_preferencial WHERE Estado_Grupo_Preferencial = 'ACTIVE';
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
    WHERE Estado_Grupo_Preferencial = 'ACTIVE'
    ORDER BY ID_Grupo_Preferencial;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grupo_preferencial_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grupo_preferencial_eliminar(IN p_ID_Grupo_Preferencial INT)
    BEGIN
        UPDATE tbl_grupo_preferencial SET Estado_Grupo_Preferencial = 'INACTIVE' WHERE ID_Grupo_Preferencial = p_ID_Grupo_Preferencial;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_grupo_preferencial_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_grupo_preferencial_insertar(IN p_Nombre_Grupo_Preferencial VARCHAR(100), IN p_Nivel_Prioridad_GP TINYINT)
    BEGIN
        INSERT INTO tbl_grupo_preferencial(Nombre_Grupo_Preferencial, Nivel_Prioridad_GP, Estado_Grupo_Preferencial) 
        VALUES(p_Nombre_Grupo_Preferencial, p_Nivel_Prioridad_GP, 'ACTIVE');
    END $$
    DELIMITER ;


    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_persona_actualizar;
    DELIMITER $$
    CREATE PROCEDURE sp_tbl_persona_actualizar(
        IN p_id_persona VARCHAR(15),
        IN p_primer_nombre VARCHAR(50),
        IN p_segundo_nombre VARCHAR(50),
        IN p_primer_apellido VARCHAR(50),
        IN p_segundo_apellido VARCHAR(50),
        IN p_fecha_nac DATE
    )
    BEGIN
        UPDATE TBL_PERSONA
        SET
            Primer_Nombre = p_primer_nombre,
            Segundo_Nombre = p_segundo_nombre,
            Primer_Apellido = p_primer_apellido,
            Segundo_Apellido = p_segundo_apellido,
            Fecha_Nacimiento = p_fecha_nac
        WHERE ID_Persona = p_id_persona;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_persona_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_persona_consultar()
    BEGIN
        SELECT * FROM tbl_persona WHERE Estado_Persona = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_persona_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_persona_eliminar(IN p_ID_Persona VARCHAR(15))
    BEGIN
        UPDATE tbl_persona SET Estado_Persona = 'INACTIVE' WHERE ID_Persona = p_ID_Persona;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_persona_insertar;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_persona_insertar(
        IN p_ID_Persona VARCHAR(15),
        IN p_Primer_Nombre VARCHAR(50),
        IN p_Segundo_Nombre VARCHAR(50),
        IN p_Primer_Apellido VARCHAR(50),
        IN p_Segundo_Apellido VARCHAR(50),
        IN p_Fecha_Nacimiento DATE
    )
    BEGIN

    INSERT INTO TBL_PERSONA(
        ID_Persona,
        Primer_Nombre,
        Segundo_Nombre,
        Primer_Apellido,
        Segundo_Apellido,
        Fecha_Nacimiento,
        Estado_Persona
    )

    VALUES(
        p_ID_Persona,
        p_Primer_Nombre,
        p_Segundo_Nombre,
        p_Primer_Apellido,
        p_Segundo_Apellido,
        p_Fecha_Nacimiento,
        'ACTIVE'
    );

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_rol_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_rol_actualizar(
        IN p_ID_Rol INT,
        IN p_Nombre_Rol VARCHAR(50),
        IN p_Descripcion_Rol VARCHAR(150)
    )
    BEGIN
        UPDATE tbl_rol
        SET Nombre_Rol = p_Nombre_Rol,
            Descripcion_Rol = p_Descripcion_Rol
        WHERE ID_Rol = p_ID_Rol;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_rol_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_rol_consultar()
    BEGIN
        SELECT * FROM tbl_rol 
        WHERE Estado_Rol = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_rol_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_rol_consultar_id(
        IN p_ID_Rol INT
    )
    BEGIN
        SELECT * FROM tbl_rol 
        WHERE ID_Rol = p_ID_Rol 
        AND Estado_Rol = 'ACTIVE';
    END $$
    DELIMITER ;


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
        AND Estado_Rol = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_rol_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_rol_eliminar(
        IN p_ID_Rol INT
    )
    BEGIN
        UPDATE tbl_rol 
        SET Estado_Rol = 'INACTIVE' 
        WHERE ID_Rol = p_ID_Rol;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_rol_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_rol_insertar(
        IN p_Nombre_Rol VARCHAR(50),
        IN p_Descripcion_Rol VARCHAR(150)
    )
    BEGIN
        INSERT INTO tbl_rol(
            Nombre_Rol,
            Descripcion_Rol,
            Estado_Rol
        )
        VALUES(
            p_Nombre_Rol,
            p_Descripcion_Rol,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_sesiones_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_sesiones_actualizar(
        IN p_ID_Sesion BIGINT,
        IN p_IP_Usuario VARCHAR(50),
        IN p_Tiempo_Cierre DATETIME,
        IN p_FK_ID_Usuario VARCHAR(16)
    )
    BEGIN
        UPDATE tbl_sesiones
        SET IP_Usuario = p_IP_Usuario,
            Tiempo_Cierre = p_Tiempo_Cierre,
            FK_ID_Usuario = p_FK_ID_Usuario
        WHERE ID_Sesion = p_ID_Sesion;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_sesiones_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_sesiones_consultar()
    BEGIN
        SELECT * FROM tbl_sesiones WHERE Estado_Sesiones = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_sesiones_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_sesiones_consultar_id(
        IN p_ID_Sesion BIGINT
    )
    BEGIN
        SELECT * FROM tbl_sesiones 
        WHERE ID_Sesion = p_ID_Sesion 
        AND Estado_Sesiones = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_sesiones_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_sesiones_eliminar(IN p_ID_Sesion BIGINT)
    BEGIN
        UPDATE tbl_sesiones SET Estado_Sesiones = 'INACTIVE' WHERE ID_Sesion = p_ID_Sesion;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_sesiones_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_sesiones_insertar (IN p_IP_Usuario VARCHAR(50), IN p_FK_ID_Usuario VARCHAR(16))
    BEGIN
        INSERT INTO tbl_sesiones(IP_Usuario, FK_ID_Usuario, Estado_Sesiones) VALUES(p_IP_Usuario, p_FK_ID_Usuario, 'ACTIVE');
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_actualizar(
        IN p_ID_Ticket VARCHAR(10),
        IN p_Titulo_Ticket VARCHAR(150),
        IN p_Descripcion_Ticket TEXT,
        IN p_Fecha_Cierre DATETIME,
        IN p_Puntaje_Prioridad INT,
        IN p_FK_ID_Usuario_Tecnico VARCHAR(16),
        IN p_FK_ID_Estado_Ticket INT,
        IN p_FK_ID_Tipo_Caso INT,
        IN p_FK_ID_Barrio INT,
        IN p_Tiempo_Residencia VARCHAR(20)
    )
    BEGIN
        UPDATE tbl_ticket
        SET Titulo_Ticket = p_Titulo_Ticket,
            Descripcion_Ticket = p_Descripcion_Ticket,
            Fecha_Cierre = p_Fecha_Cierre,
            Puntaje_Prioridad = p_Puntaje_Prioridad,
            FK_ID_Usuario_Tecnico = p_FK_ID_Usuario_Tecnico,
            FK_ID_Estado_Ticket = p_FK_ID_Estado_Ticket,
            FK_ID_Tipo_Caso = p_FK_ID_Tipo_Caso,
            FK_ID_Barrio = p_FK_ID_Barrio,
            Tiempo_Residencia = p_Tiempo_Residencia
        WHERE ID_Ticket = p_ID_Ticket;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_comentario_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_comentario_actualizar(
        IN p_ID_Ticket_Comentario INT,
        IN p_Comentario TEXT,
        IN p_Fecha_Comentario DATETIME,
        IN p_Es_Interno TINYINT(1),
        IN p_FK_ID_Usuario VARCHAR(16),
        IN p_FK_ID_Ticket VARCHAR(10)
    )
    BEGIN
        UPDATE tbl_ticket_comentario
        SET Comentario = p_Comentario,
            Fecha_Comentario = p_Fecha_Comentario,
            Es_Interno = p_Es_Interno,
            FK_ID_Usuario = p_FK_ID_Usuario,
            FK_ID_Ticket = p_FK_ID_Ticket
        WHERE ID_Ticket_Comentario = p_ID_Ticket_Comentario;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_comentario_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_comentario_consultar()
    BEGIN
        SELECT * FROM tbl_ticket_comentario 
        WHERE Estado_Comentario_Ticket = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_comentario_consultar_id;

    DELIMITER $$
    CREATE  PROCEDURE sp_tbl_ticket_comentario_consultar_id(
        IN p_ID_Ticket_Comentario INT
    )
    BEGIN
        SELECT * FROM tbl_ticket_comentario 
        WHERE ID_Ticket_Comentario = p_ID_Ticket_Comentario 
        AND Estado_Comentario_Ticket = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_comentario_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_comentario_eliminar(
        IN p_ID_Ticket_Comentario INT
    )
    BEGIN
        UPDATE tbl_ticket_comentario 
        SET Estado_Comentario_Ticket = 'INACTIVE' 
        WHERE ID_Ticket_Comentario = p_ID_Ticket_Comentario;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_comentario_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_comentario_insertar(
        IN p_Comentario TEXT,
        IN p_Fecha_Comentario DATETIME,
        IN p_Fecha_Creacion DATETIME,
        IN p_Es_Interno TINYINT(1),
        IN p_FK_ID_Usuario VARCHAR(16),
        IN p_FK_ID_Ticket VARCHAR(10)
    )
    BEGIN
        INSERT INTO tbl_ticket_comentario (
            Comentario,
            Fecha_Comentario,
            Fecha_Creacion,
            Es_Interno,
            FK_ID_Usuario,
            FK_ID_Ticket,
            Estado_Comentario_Ticket
        )
        VALUES (
            p_Comentario,
            p_Fecha_Comentario,
            p_Fecha_Creacion,
            p_Es_Interno,
            p_FK_ID_Usuario,
            p_FK_ID_Ticket,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_consultar()
    BEGIN
        SELECT * FROM tbl_ticket 
        WHERE Estado_Ticket = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_consultar_id(
        IN p_ID_Ticket VARCHAR(10)
    )
    BEGIN
        SELECT * FROM tbl_ticket 
        WHERE ID_Ticket = p_ID_Ticket 
        AND Estado_Ticket = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_eliminar(
        IN p_ID_Ticket VARCHAR(10)
    )
    BEGIN
        UPDATE tbl_ticket 
        SET Estado_Ticket = 'INACTIVE' 
        WHERE ID_Ticket = p_ID_Ticket;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_ticket_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_ticket_insertar(
        IN p_ID_Ticket VARCHAR(10),
        IN p_Titulo_Ticket VARCHAR(150),
        IN p_Descripcion_Ticket TEXT,
        IN p_Puntaje_Prioridad INT,
        IN p_FK_ID_Usuario_Creador VARCHAR(16),
        IN p_FK_ID_Usuario_Tecnico VARCHAR(16),
        IN p_FK_ID_Estado_Ticket INT,
        IN p_FK_ID_Tipo_Caso INT,
        IN p_FK_ID_Barrio INT,
        IN p_Tiempo_Residencia VARCHAR(20)
    )
    BEGIN
        INSERT INTO tbl_ticket (
            ID_Ticket,
            Titulo_Ticket,
            Descripcion_Ticket,
            Puntaje_Prioridad,
            FK_ID_Usuario_Creador,
            FK_ID_Usuario_Tecnico,
            FK_ID_Estado_Ticket,
            FK_ID_Tipo_Caso,
            FK_ID_Barrio,
            Tiempo_Residencia,
            Estado_Ticket
        )
        VALUES (
            p_ID_Ticket,
            p_Titulo_Ticket,
            p_Descripcion_Ticket,
            p_Puntaje_Prioridad,
            p_FK_ID_Usuario_Creador,
            p_FK_ID_Usuario_Tecnico,
            p_FK_ID_Estado_Ticket,
            p_FK_ID_Tipo_Caso,
            p_FK_ID_Barrio,
            p_Tiempo_Residencia,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_afectacion_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_afectacion_actualizar(
        IN p_ID_Tipo_Afectacion INT,
        IN p_Afectacion VARCHAR(100),
        IN p_Nivel_Prioridad_TC TINYINT
    )
    BEGIN
        UPDATE tbl_tipo_afectacion
        SET Afectacion = p_Afectacion,
            Nivel_Prioridad_TC = p_Nivel_Prioridad_TC
        WHERE ID_Tipo_Afectacion = p_ID_Tipo_Afectacion;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_afectacion_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_afectacion_consultar()
    BEGIN
        SELECT * FROM tbl_tipo_afectacion 
        WHERE Estado_Afectacion = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_afectacion_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_afectacion_consultar_id(
        IN p_ID_Tipo_Afectacion INT
    )
    BEGIN
        SELECT * FROM tbl_tipo_afectacion 
        WHERE ID_Tipo_Afectacion = p_ID_Tipo_Afectacion 
        AND Estado_Afectacion = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_afectacion_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_afectacion_eliminar(
        IN p_ID_Tipo_Afectacion INT
    )
    BEGIN
        UPDATE tbl_tipo_afectacion 
        SET Estado_Afectacion = 'INACTIVE' 
        WHERE ID_Tipo_Afectacion = p_ID_Tipo_Afectacion;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_afectacion_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_afectacion_insertar(
        IN p_Afectacion VARCHAR(100),
        IN p_Nivel_Prioridad_TC TINYINT
    )
    BEGIN
        INSERT INTO tbl_tipo_afectacion(
            Afectacion,
            Nivel_Prioridad_TC,
            Estado_Afectacion
        )
        VALUES(
            p_Afectacion,
            p_Nivel_Prioridad_TC,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_documento_actualizar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_documento_actualizar(
        IN p_ID_Tipo_Doc INT,
        IN p_Nombre_Tipo_Doc VARCHAR(30)
    )
    BEGIN
        UPDATE tbl_tipo_documento
        SET Nombre_Tipo_Doc = p_Nombre_Tipo_Doc
        WHERE ID_Tipo_Doc = p_ID_Tipo_Doc;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_documento_consultar_v2;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_documento_consultar_v2()
    BEGIN
        SELECT * FROM tbl_tipo_documento 
        WHERE Estado_Documentos = 'ACTIVE';
    END $$
    DELIMITER ;


    -- --------------------------------------------------------
    -- Estudiante
    DROP PROCEDURE IF EXISTS sp_tbl_tipo_identificacion_consultar_est;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_tipo_identificacion_consultar_est()

    BEGIN

    SELECT 
        ID_Tipo_Iden,
        Nombre_Tipo_Iden
    FROM TBL_TIPO_IDENTIFICACION
    WHERE Estado_Identificacion = 'ACTIVE' AND Tipo_Usuario = 'ESTUDIANTE'
    ORDER BY Nombre_Tipo_Iden;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------
    -- Acudiente
    DROP PROCEDURE IF EXISTS sp_tbl_tipo_identificacion_consultar_acu;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_tipo_identificacion_consultar_acu()

    BEGIN

    SELECT 
        ID_Tipo_Iden,
        Nombre_Tipo_Iden
    FROM TBL_TIPO_IDENTIFICACION
    WHERE Estado_Identificacion = 'ACTIVE' AND Tipo_Usuario = 'ACUDIENTE'
    ORDER BY Nombre_Tipo_Iden;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_documento_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_documento_consultar_id(
        IN p_ID_Tipo_Doc INT
    )
    BEGIN
        SELECT * FROM tbl_tipo_documento 
        WHERE ID_Tipo_Doc = p_ID_Tipo_Doc 
        AND Estado_Documentos = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_documento_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_documento_eliminar(
        IN p_ID_Tipo_Doc INT
    )
    BEGIN
        UPDATE tbl_tipo_documento 
        SET Estado_Documentos = 'INACTIVE' 
        WHERE ID_Tipo_Doc = p_ID_Tipo_Doc;
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_tipo_documento_insertar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_tipo_documento_insertar(
        IN p_Nombre_Tipo_Doc VARCHAR(30)
    )
    BEGIN
        INSERT INTO tbl_tipo_documento(
            Nombre_Tipo_Doc,
            Estado_Documentos
        )
        VALUES(
            p_Nombre_Tipo_Doc,
            'ACTIVE'
        );
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_usuario_actualizar;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_usuario_actualizar(
        IN p_ID_Usuario VARCHAR(16),
        IN p_Nombre_Usuario VARCHAR(50),
        IN p_password VARCHAR(255),
        IN p_Ultimo_Cambio_Contraseña DATETIME,
        IN p_Intentos_Fallidos INT,
        IN p_Doble_Factor_Activo ENUM('ACTIVE','INACTIVE'),
        IN p_Aceptacion_Terminos ENUM('ACCEPTED','REJECTED'),
        IN p_FK_ID_Persona VARCHAR(15),
        IN p_FK_ID_Rol INT
    )
    BEGIN

    DECLARE v_salt VARBINARY(16);
    DECLARE v_hash VARBINARY(32);

    SET v_salt = RANDOM_BYTES(16);

    SET v_hash = UNHEX(SHA2(CONCAT(HEX(v_salt), p_password),256));

    UPDATE TBL_USUARIO
    SET Nombre_Usuario = p_Nombre_Usuario,
        Password_Salt = v_salt,
        Contraseña_Hash = v_hash,
        Intentos_Fallidos = p_Intentos_Fallidos,
        Doble_Factor_Activo = p_Doble_Factor_Activo,
        Aceptacion_Terminos = p_Aceptacion_Terminos,
        FK_ID_Persona = p_FK_ID_Persona,
        FK_ID_Rol = p_FK_ID_Rol
    WHERE ID_Usuario = p_ID_Usuario;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_usuario_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_usuario_consultar()
    BEGIN
        SELECT * FROM tbl_usuario WHERE Estado_Usuario = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_usuario_consultar_id;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_usuario_consultar_id(
        IN p_ID_Usuario VARCHAR(16)
    )
    BEGIN
        SELECT * FROM tbl_usuario WHERE ID_Usuario = p_ID_Usuario AND Estado_Usuario = 'ACTIVE';
    END $$
    DELIMITER ;

    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_tbl_usuario_eliminar;

    DELIMITER $$
    CREATE PROCEDURE sp_tbl_usuario_eliminar(
        IN p_ID_Usuario VARCHAR(16)
    )
    BEGIN
        UPDATE tbl_usuario SET Estado_Usuario = 'INACTIVE' WHERE ID_Usuario = p_ID_Usuario;
    END $$
    DELIMITER ;


    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_tbl_usuario_insertar;
    DELIMITER $$
    CREATE PROCEDURE sp_tbl_usuario_insertar(
        IN p_ID_Usuario VARCHAR(16),
        IN p_Nombre_Usuario VARCHAR(50),
        IN p_password_salt VARBINARY(16),
        IN p_password_hash VARBINARY(32),
        IN p_Doble_Factor_Activo ENUM('ACTIVE','INACTIVE'),
        IN p_Aceptacion_Terminos ENUM('ACCEPTED','REJECTED'),
        IN p_FK_ID_Persona VARCHAR(15),
        IN p_FK_ID_Rol INT

    )
    BEGIN
    INSERT INTO TBL_USUARIO(
        ID_Usuario,
        Nombre_Usuario,
        Password_Salt,
        Contraseña_Hash,
        Doble_Factor_Activo,
        Aceptacion_Terminos,
        FK_ID_Persona,
        FK_ID_Rol,
        Estado_Usuario

    )
    VALUES(
        p_ID_Usuario,
        p_Nombre_Usuario,
        p_password_salt,
        p_password_hash,
        p_Doble_Factor_Activo,
        p_Aceptacion_Terminos,
        p_FK_ID_Persona,
        p_FK_ID_Rol,
        'ACTIVE'

    );

    END $$
    DELIMITER ;


    -- --------------------------------------------------------
    -- LOGIN
    -- --------------------------------------------------------

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
        AND u.Estado_Usuario = 'ACTIVE'
        AND p.Estado_Persona = 'ACTIVE'

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
        DECLARE v_id_usuario VARCHAR(16);
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
        IN p_usuario VARCHAR(16),
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
    END$$
    DELIMITER ;

    -- --------------------------------------------------------
    DROP PROCEDURE IF EXISTS sp_usuario_bloquear;


    DELIMITER $$
    CREATE PROCEDURE sp_usuario_bloquear(
        IN p_usuario VARCHAR(50)
    )
    BEGIN
        UPDATE TBL_USUARIO
        SET Estado_Usuario = 'BLOCK'
        WHERE Nombre_Usuario = p_usuario;
    END$$
    DELIMITER ;

    -- --------------------------------------------------------
    -- REGISTRO
    -- ---------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_usuario_verificar_existente;

    DELIMITER $$

    CREATE PROCEDURE sp_usuario_verificar_existente(
        IN p_Email VARCHAR(255),
        IN p_Documento VARCHAR(15)
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
    -- RECUPERACIÓN DE CONTRASEÑA
    -- --------------------------------------------------------


    DROP PROCEDURE IF EXISTS sp_usuario_actualizar_contrasena;

    DELIMITER $$

    CREATE PROCEDURE sp_usuario_actualizar_contrasena(
        IN p_username     VARCHAR(100),
        IN p_nuevo_hash   VARBINARY(32),
        IN p_nuevo_salt   VARBINARY(16)
    )
    BEGIN
        UPDATE TBL_USUARIO
        SET Contraseña_Hash = p_nuevo_hash,
            Password_Salt   = p_nuevo_salt
        WHERE Nombre_Usuario = p_username;
    END$$

    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_usuario_obtener_email;

    DELIMITER $$

    CREATE PROCEDURE sp_usuario_obtener_email(
        IN p_Nombre_Usuario VARCHAR(50)
    )
    BEGIN
        SELECT DA.Email
        FROM TBL_USUARIO U
        INNER JOIN TBL_DATOS_ADICIONALES DA ON U.FK_ID_Persona = DA.FK_ID_Persona
        WHERE U.Nombre_Usuario = p_Nombre_Usuario 
        AND DA.Email = p_Nombre_Usuario;
    END $$

    DELIMITER ;


    -- --------------------------------------------------------
    -- Estudiante
    DROP PROCEDURE IF EXISTS sp_tbl_parentesco_consultar_est;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_parentesco_consultar_est()

    BEGIN

    SELECT 
        ID_Parentesco,
        Nombre_Parentesco
    FROM TBL_PARENTESCO
    WHERE Estado_Parentesco = 'ACTIVE' AND Tipo_Usuario = 'ESTUDIANTE'
    ORDER BY ID_Parentesco;

    END $$

    DELIMITER ;


    -- --------------------------------------------------------
    -- Acudiente
    DROP PROCEDURE IF EXISTS sp_tbl_parentesco_consultar_acu;

    DELIMITER $$

    CREATE PROCEDURE sp_tbl_parentesco_consultar_acu()

    BEGIN

    SELECT 
        ID_Parentesco,
        Nombre_Parentesco
    FROM TBL_PARENTESCO
    WHERE Estado_Parentesco = 'ACTIVE' AND Tipo_Usuario = 'ACUDIENTE'
    ORDER BY ID_Parentesco;

    END $$

    DELIMITER ;

    -- --------------------------------------------------------

    DROP PROCEDURE IF EXISTS sp_perfil_acudiente_consultar;

    DELIMITER $$
    CREATE PROCEDURE sp_perfil_acudiente_consultar(
        IN p_id_usuario VARCHAR(16)
    )
    BEGIN
        SELECT
            -- Identidad (solo lectura)
            p.Primer_Nombre,
            p.Segundo_Nombre,
            p.Primer_Apellido,
            p.Segundo_Apellido,
            ti.Nombre_Tipo_Iden,
            p.ID_Persona AS Numero_Documento,

            -- Contacto (editable)
            da.Email,
            da.Telefono,

            -- Ubicación (editable)
            da.FK_ID_Barrio AS ID_Barrio,
            b.Nombre_Barrio,
            da.FK_ID_Estrato AS ID_Estrato,

            -- Demográficos (editable)
            da.FK_ID_Genero AS ID_Genero,
            da.FK_ID_Grupo_Preferencial AS ID_Grupo_Preferencial,

            -- Solo lectura
            par.Nombre_Parentesco,
            u.Fecha_Creacion
        FROM TBL_USUARIO u
        INNER JOIN TBL_PERSONA p ON u.FK_ID_Persona = p.ID_Persona
        INNER JOIN TBL_DATOS_ADICIONALES da ON da.FK_ID_Persona = p.ID_Persona
        INNER JOIN TBL_TIPO_IDENTIFICACION ti ON da.FK_ID_Tipo_Iden = ti.ID_Tipo_Iden
        INNER JOIN TBL_BARRIO b ON da.FK_ID_Barrio  = b.ID_Barrio
        INNER JOIN TBL_PARENTESCO par ON da.FK_ID_Parentesco  = par.ID_Parentesco
        WHERE u.ID_Usuario = p_id_usuario
        LIMIT 1;

    END $$
    DELIMITER ;


