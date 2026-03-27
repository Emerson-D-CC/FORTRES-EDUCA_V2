-- --------------------------------------------------------
-- PREPARACIÓN
-- --------------------------------------------------------

USE fortress_db;

SELECT VERSION();

SELECT COUNT(*) AS estudiantes FROM TBL_ESTUDIANTE;
SELECT COUNT(*) AS tickets FROM TBL_TICKET;
SELECT COUNT(*) AS comentarios_ticket FROM TBL_TICKET_COMENTARIO;
SELECT COUNT(*) AS usuarios FROM TBL_USUARIO;
SELECT COUNT(*) AS documentos_ticket FROM TBL_DOCUMENTO_TICKET;


-- --------------------------------------------------------
-- DIAGNOSTICO DE RENDIMIENTO
-- --------------------------------------------------------

-- Consulta 1: Tickets por usuario

EXPLAIN
SELECT t.ID_Ticket, t.Titulo_Ticket, t.Fecha_Creacion
FROM TBL_TICKET t
WHERE t.FK_ID_Usuario_Creador = 'U101000001';

CREATE INDEX idx_ticket_usuario
ON TBL_TICKET(FK_ID_Usuario_Creador);

EXPLAIN
SELECT t.ID_Ticket, t.Titulo_Ticket, t.Fecha_Creacion
FROM TBL_TICKET t
WHERE t.FK_ID_Usuario_Creador = 'U101000001';



-- Consulta 2: Lista de tickets con datos del usuario (JOIN)

EXPLAIN
SELECT t.ID_Ticket, u.Nombre_Usuario, t.Titulo_Ticket
FROM TBL_TICKET t
JOIN TBL_USUARIO u 
ON u.ID_Usuario = t.FK_ID_Usuario_Creador
WHERE t.FK_ID_Estado_Ticket = 1;

CREATE INDEX idx_ticket_estado
ON TBL_TICKET(FK_ID_Estado_Ticket);

EXPLAIN
SELECT t.ID_Ticket, u.Nombre_Usuario, t.Titulo_Ticket
FROM TBL_TICKET t
JOIN TBL_USUARIO u 
ON u.ID_Usuario = t.FK_ID_Usuario_Creador
WHERE t.FK_ID_Estado_Ticket = 1;



-- Consulta 3: Comentarios por ticket (JOIN + filtro)

EXPLAIN
SELECT c.ID_Ticket_Comentario, c.Comentario, c.Fecha_Comentario, u.Nombre_Usuario
FROM TBL_TICKET_COMENTARIO c
JOIN TBL_USUARIO u 
ON u.ID_Usuario = c.FK_ID_Usuario
WHERE c.FK_ID_Ticket = 'EDU-000001'
ORDER BY c.Fecha_Comentario;

CREATE INDEX idx_comentario_ticket
ON TBL_TICKET_COMENTARIO(FK_ID_Ticket);

EXPLAIN
SELECT c.ID_Ticket_Comentario, c.Comentario, c.Fecha_Comentario, u.Nombre_Usuario
FROM TBL_TICKET_COMENTARIO c
JOIN TBL_USUARIO u 
ON u.ID_Usuario = c.FK_ID_Usuario
WHERE c.FK_ID_Ticket = 'EDU-000001'
ORDER BY c.Fecha_Comentario;



-- Consulta 4: Documentos adjuntos por ticket

EXPLAIN
SELECT d.ID_Doc_Ticket, d.Nombre_Original, d.Fecha_Subida
FROM TBL_DOCUMENTO_TICKET d
WHERE d.FK_ID_Ticket = 'EDU-000001';

CREATE INDEX idx_documento_ticket
ON TBL_DOCUMENTO_TICKET(FK_ID_Ticket);

EXPLAIN
SELECT d.ID_Doc_Ticket, d.Nombre_Original, d.Fecha_Subida
FROM TBL_DOCUMENTO_TICKET d
WHERE d.FK_ID_Ticket = 'EDU-000001';



-- Consulta 5: Conteo de tickets por estado (GROUP BY)

EXPLAIN
SELECT FK_ID_Estado_Ticket, COUNT(*) AS total_tickets
FROM TBL_TICKET
GROUP BY FK_ID_Estado_Ticket;

CREATE INDEX idx_ticket_estado_usuario
ON TBL_TICKET(FK_ID_Estado_Ticket, FK_ID_Usuario_Creador);

EXPLAIN
SELECT FK_ID_Estado_Ticket, COUNT(*) AS total_tickets
FROM TBL_TICKET
GROUP BY FK_ID_Estado_Ticket;


-- --------------------------------------------------------
-- SEGURIDAD (USUARIOS, PERMISOS Y VISTAS)
-- --------------------------------------------------------

-- Usuario de solo lectura
CREATE USER 'report_user'@'%' IDENTIFIED BY 'StrongPass_2026!';
GRANT SELECT ON fortress_db.* TO 'report_user'@'%';
FLUSH PRIVILEGES;


-- Vista Publica sin Email
CREATE OR REPLACE VIEW v_estudiantes_publico AS
SELECT 
    e.ID_Estudiante,
    p.ID_Persona,
    CONCAT(p.Primer_Nombre,' ',p.Primer_Apellido) AS Nombre_Completo,
    g.Nombre_Grado,
    e.Estado_Colegio
FROM TBL_ESTUDIANTE e
JOIN TBL_PERSONA p 
ON p.ID_Persona = e.FK_ID_Persona
JOIN TBL_GRADO g
ON g.ID_Grado = e.FK_ID_Grado;


-- Evidencia Permisos Asignados
SHOW GRANTS FOR 'report_user'@'%';


-- --------------------------------------------------------
-- VALIDACION POST-RESTORE
-- --------------------------------------------------------

USE fortress_db_restore;

SHOW TABLES;

SELECT COUNT(*) AS estudiantes FROM TBL_ESTUDIANTE;
SELECT COUNT(*) AS tickets FROM TBL_TICKET;
SELECT COUNT(*) AS comentarios_ticket FROM TBL_TICKET_COMENTARIO;
SELECT COUNT(*) AS usuarios FROM TBL_USUARIO;
SELECT COUNT(*) AS documentos_ticket FROM TBL_DOCUMENTO_TICKET;


-- --------------------------------------------------------
-- SIMULACIÓN DE "DESASTRE"
-- --------------------------------------------------------

DROP DATABASE fortress_db;

USE fortress_db;

SHOW TABLES;

SELECT COUNT(*) AS estudiantes FROM TBL_ESTUDIANTE;
SELECT COUNT(*) AS tickets FROM TBL_TICKET;
SELECT COUNT(*) AS comentarios_ticket FROM TBL_TICKET_COMENTARIO;
SELECT COUNT(*) AS usuarios FROM TBL_USUARIO;
SELECT COUNT(*) AS documentos_ticket FROM TBL_DOCUMENTO_TICKET;


-- --------------------------------------------------------
-- PROTECCIÓN CONTRASEÑAS
-- --------------------------------------------------------

-- Tabla usuarios

    -- Modificación de la tabla TBL_USUARIO para seguridad de contraseña

ALTER TABLE TBL_USUARIO
ADD Password_Salt VARBINARY(16) NOT NULL AFTER Nombre_Usuario;


CREATE TABLE IF NOT EXISTS TBL_USUARIO (
    ID_Usuario VARCHAR(16) PRIMARY KEY,
    Nombre_Usuario VARCHAR(50) UNIQUE NOT NULL,

    Password_Salt VARBINARY(16) NOT NULL,
    Contraseña_Hash VARBINARY(32) NOT NULL,

    Ultimo_Login DATETIME,
    Intentos_Fallidos INT,
    Fecha_Creacion DATETIME DEFAULT CURRENT_TIMESTAMP,

    Doble_Factor_Activo ENUM('ACTIVE','INACTIVE'),
    Aceptacion_Terminos TINYINT(2) NOT NULL,

    FK_ID_Persona VARCHAR(15) NOT NULL,
    FK_ID_Rol INT NOT NULL,

    Estado_Usuario ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Usuario_Persona FOREIGN KEY (FK_ID_Persona) REFERENCES TBL_PERSONA(ID_Persona) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Usuario_Rol FOREIGN KEY (FK_ID_Rol) REFERENCES TBL_ROL(ID_Rol) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;


-- Procedimiento Almacenado (salt + hash)

DROP PROCEDURE IF EXISTS sp_tbl_usuario_insertar;

DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_insertar(
    IN p_ID_Usuario VARCHAR(16),
    IN p_Nombre_Usuario VARCHAR(50),
    IN p_password VARCHAR(255),
    IN p_Intentos_Fallidos INT,
    IN p_Doble_Factor_Activo ENUM('ACTIVE','INACTIVE'),
    IN p_Aceptacion_Terminos TINYINT,
    IN p_FK_ID_Persona VARCHAR(15),
    IN p_FK_ID_Rol INT
)
BEGIN

    DECLARE v_salt VARBINARY(16);
    DECLARE v_hash VARBINARY(32);

    SET v_salt = RANDOM_BYTES(16);
    SET v_hash = UNHEX(SHA2(CONCAT(HEX(v_salt), p_password),256));

INSERT INTO TBL_USUARIO(
    ID_Usuario,
    Nombre_Usuario,
    Password_Salt,
    Contraseña_Hash,
    Intentos_Fallidos,
    Doble_Factor_Activo,
    Aceptacion_Terminos,
    FK_ID_Persona,
    FK_ID_Rol,
    Estado_Usuario
)

VALUES(
    p_ID_Usuario,
    p_Nombre_Usuario,
    v_salt,
    v_hash,
    p_Intentos_Fallidos,
    p_Doble_Factor_Activo,
    p_Aceptacion_Terminos,
    p_FK_ID_Persona,
    p_FK_ID_Rol,
    'ACTIVE'
);
END $$

DELIMITER ;


-- Funcion para validar contraseña

DROP FUNCTION IF EXISTS fn_validar_password_usuario;

DELIMITER $$
CREATE FUNCTION fn_validar_password_usuario(
    p_username VARCHAR(50),
    p_password VARCHAR(255)
)

RETURNS TINYINT(1)
DETERMINISTIC
READS SQL DATA
BEGIN

    DECLARE v_salt VARBINARY(16);
    DECLARE v_hash VARBINARY(32);
    DECLARE v_calc VARBINARY(32);

    SELECT Password_Salt, Contraseña_Hash
    INTO v_salt, v_hash
    FROM TBL_USUARIO
    WHERE Nombre_Usuario = p_username
    LIMIT 1;

    IF v_salt IS NULL THEN
    RETURN 0;
    END IF;

    SET v_calc = UNHEX(SHA2(CONCAT(HEX(v_salt), p_password),256));

    IF v_calc = v_hash THEN
    RETURN 1;
    END IF;

    RETURN 0;
END $$

DELIMITER ;


-- Prueba   

CALL sp_tbl_usuario_insertar('U101000004','Ana','MiClave123!', 0, 'ACTIVE', 1, '101000002', 1 );
SELECT fn_validar_password_usuario('ana','MiClave123!') AS acceso;
SELECT fn_validar_password_usuario('ana','otra') AS acceso; 