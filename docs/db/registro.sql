
-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_PERSONA
--

DROP TABLE IF EXISTS TBL_PERSONA;

CREATE TABLE TBL_PERSONA (
    ID_Persona VARCHAR(15) PRIMARY KEY,
    Primer_Nombre VARCHAR(50) NOT NULL,
    Segundo_Nombre VARCHAR(50),
    Primer_Apellido VARCHAR(50) NOT NULL,
    Segundo_Apellido VARCHAR(50),
    Fecha_Nacimiento DATE NOT NULL,
    Estado_Persona ENUM('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;


-- -----------------------------------------

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
--
-- Estructura de tabla para la tabla TBL_USUARIO
--
DROP TABLE IF EXISTS TBL_USUARIO;

CREATE TABLE TBL_USUARIO (
    ID_Usuario VARCHAR(16) PRIMARY KEY,
    Nombre_Usuario VARCHAR(50) UNIQUE NOT NULL,

    Password_Salt VARBINARY(16) NOT NULL,
    Contraseña_Hash VARBINARY(32) NOT NULL,

    Ultimo_Login DATETIME NULL DEFAULT NULL,
    Intentos_Fallidos INT NULL,
    Fecha_Creacion DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,

    Doble_Factor_Activo ENUM('ACTIVE','INACTIVE') DEFAULT 'INACTIVE',
    Aceptacion_Terminos TINYINT(2) NULL,

    FK_ID_Persona VARCHAR(15) NOT NULL,
    FK_ID_Rol INT NOT NULL,

    Estado_Usuario ENUM('ACTIVE','BLOCK','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Usuario_Persona FOREIGN KEY (FK_ID_Persona) REFERENCES TBL_PERSONA(ID_Persona) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Usuario_Rol FOREIGN KEY (FK_ID_Rol) REFERENCES TBL_ROL(ID_Rol) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_usuario_insertar;
DELIMITER $$
CREATE PROCEDURE sp_tbl_usuario_insertar(
    IN p_ID_Usuario VARCHAR(16),
    IN p_Nombre_Usuario VARCHAR(50),
    IN p_password_salt VARBINARY(16),
    IN p_password_hash VARBINARY(32),
    IN p_Doble_Factor_Activo ENUM('ACTIVE','INACTIVE'),
    IN p_Aceptacion_Terminos TINYINT,
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
--
-- Estructura de tabla para la tabla TBL_DATOS_ADICIONALES de la persona
--

DROP TABLE IF EXISTS TBL_DATOS_ADICIONALES;

CREATE TABLE TBL_DATOS_ADICIONALES (
    ID_Datos_Adicionales VARCHAR(16) PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefono VARCHAR(20) UNIQUE NOT NULL,
    Parentesco VARCHAR(20) NOT NULL,

    FK_ID_Tipo_Iden INT NOT NULL,
    FK_ID_Persona VARCHAR(15) NOT NULL,
    FK_ID_Genero INT NOT NULL,
    FK_ID_Grupo_Preferencial INT NOT NULL,
    FK_ID_Estrato INT NOT NULL,
    FK_ID_Localidad INT NOT NULL,

    Estado_Datos_Adicionales ENUM('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_DatosAd_Identificacion FOREIGN KEY (FK_ID_Tipo_Iden) REFERENCES TBL_TIPO_IDENTIFICACION(ID_Tipo_Iden) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Persona FOREIGN KEY (FK_ID_Persona) REFERENCES TBL_PERSONA(ID_Persona) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Genero FOREIGN KEY (FK_ID_Genero) REFERENCES TBL_GENERO(ID_Genero) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_GP FOREIGN KEY (FK_ID_Grupo_Preferencial) REFERENCES TBL_GRUPO_PREFERENCIAL(ID_Grupo_Preferencial) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Estrato FOREIGN KEY (FK_ID_Estrato) REFERENCES TBL_ESTRATO(ID_Estrato) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Localidad FOREIGN KEY (FK_ID_Localidad) REFERENCES TBL_LOCALIDAD(ID_Localidad) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;

-- -------------------------------------------------------

DROP PROCEDURE IF EXISTS sp_tbl_datos_adicionales_insertar;

DELIMITER $$

CREATE PROCEDURE sp_tbl_datos_adicionales_insertar(

    IN p_ID_Datos_Adicionales VARCHAR(16),
    IN p_Email VARCHAR(255),
    IN p_Telefono VARCHAR(20),
    IN p_Parentesco VARCHAR(20),
    IN p_FK_ID_Tipo_Iden INT,
    IN p_FK_ID_Persona VARCHAR(15),
    IN p_FK_ID_Genero INT,
    IN p_FK_ID_Grupo_Preferencial INT,
    IN p_FK_ID_Estrato INT,
    IN p_FK_ID_Localidad INT

)
BEGIN

INSERT INTO TBL_DATOS_ADICIONALES(

    ID_Datos_Adicionales,
    Email,
    Telefono,
    Parentesco,
    FK_ID_Tipo_Iden,
    FK_ID_Persona,
    FK_ID_Genero,
    FK_ID_Grupo_Preferencial,
    FK_ID_Estrato,
    FK_ID_Localidad,

    Estado_Datos_Adicionales
)

VALUES(

    p_ID_Datos_Adicionales,
    p_Email,
    p_Telefono,
    p_Parentesco,
    p_FK_ID_Tipo_Iden,
    p_FK_ID_Persona,
    p_FK_ID_Genero,
    p_FK_ID_Grupo_Preferencial,
    p_FK_ID_Estrato,
    p_FK_ID_Localidad,

    'ACTIVE'
);

END $$

DELIMITER ;