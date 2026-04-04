DROP DATABASE FORTRESS_EDUCA_DB;
CREATE DATABASE FORTRESS_EDUCA_DB;

USE FORTRESS_EDUCA_DB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_GRADO
--

DROP TABLE IF EXISTS TBL_GRADO;

CREATE TABLE TBL_GRADO (
    ID_Grado INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Grado VARCHAR(30) UNIQUE NOT NULL,
    Nivel_Educativo VARCHAR(30) NOT NULL,
    Estado_Grado ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_LOCALIDAD
--
DROP TABLE IF EXISTS TBL_LOCALIDAD;

CREATE TABLE TBL_LOCALIDAD (
    ID_Localidad INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Localidad VARCHAR(30) UNIQUE NOT NULL,
    Estado_Localidad ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_GENERO
--

DROP TABLE IF EXISTS TBL_GENERO;

CREATE TABLE TBL_GENERO (
    ID_Genero INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Genero VARCHAR(30) UNIQUE NOT NULL,
    Estado_Genero ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_PARENTESCO
--

DROP TABLE IF EXISTS TBL_PARENTESCO;

CREATE TABLE TBL_PARENTESCO (
    ID_Parentesco INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Parentesco VARCHAR(30) UNIQUE NOT NULL,
    Tipo_Usuario ENUM('ACUDIENTE','ESTUDIANTE') NOT NULL,
    Estado_Parentesco ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_GRUPO_PREFERENCIAL
--

DROP TABLE IF EXISTS TBL_GRUPO_PREFERENCIAL;

CREATE TABLE TBL_GRUPO_PREFERENCIAL (
    ID_Grupo_Preferencial INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Grupo_Preferencial VARCHAR(100) UNIQUE NOT NULL,
    Nivel_Prioridad_GP TINYINT(2) NOT NULL,
    Estado_Grupo_Preferencial ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_ESTRATO
--

DROP TABLE IF EXISTS TBL_ESTRATO;

CREATE TABLE TBL_ESTRATO (
    ID_Estrato INT AUTO_INCREMENT PRIMARY KEY,
    Numero_Estrato INT UNIQUE NOT NULL,
    Nivel_Prioridad_E TINYINT(2) NOT NULL,
    Estado_Estrato ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_ROL
--

DROP TABLE IF EXISTS TBL_ROL;

CREATE TABLE TBL_ROL (
    ID_Rol INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Rol VARCHAR(50) UNIQUE NOT NULL,
    Descripcion_Rol VARCHAR(150) NOT NULL,
    Estado_Rol ENUM('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_TIPO_DOCUMENTO
--

DROP TABLE IF EXISTS TBL_TIPO_DOCUMENTO;

CREATE TABLE TBL_TIPO_DOCUMENTO (
    ID_Tipo_Doc INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Doc VARCHAR(30) NOT NULL,
    Estado_Documentos ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_TIPO_IDENTIFICACION
--

DROP TABLE IF EXISTS TBL_TIPO_IDENTIFICACION;

CREATE TABLE TBL_TIPO_IDENTIFICACION (
    ID_Tipo_Iden INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Tipo_Iden VARCHAR(30) NOT NULL,
    Tipo_Usuario ENUM('ACUDIENTE','ESTUDIANTE') NOT NULL,
    Estado_Identificacion ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_TIPO_AFECTACION
--

DROP TABLE IF EXISTS TBL_TIPO_AFECTACION;

CREATE TABLE TBL_TIPO_AFECTACION (
    ID_Tipo_Afectacion INT AUTO_INCREMENT PRIMARY KEY,
    Afectacion VARCHAR(100) UNIQUE NOT NULL,
    Nivel_Prioridad_TC TINYINT(2) NOT NULL,
    Estado_Afectacion ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_ESTADO_TICKET
--

DROP TABLE IF EXISTS TBL_ESTADO_TICKET;

CREATE TABLE TBL_ESTADO_TICKET (
    ID_Estado_Ticket INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Estado VARCHAR(50) UNIQUE NOT NULL,
    Estado_Final TINYINT(1) NOT NULL,
    Estado_Estado_Ticket ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_BARRIO
--

DROP TABLE IF EXISTS TBL_BARRIO;

CREATE TABLE TBL_BARRIO (
    ID_Barrio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Barrio VARCHAR(30) UNIQUE NOT NULL,
    FK_ID_Localidad INT NOT NULL,
    Estado_Barrio ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Barrio_Localidad FOREIGN KEY (FK_ID_Localidad) REFERENCES TBL_LOCALIDAD(ID_Localidad) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_COLEGIO
--

DROP TABLE IF EXISTS TBL_COLEGIO;

CREATE TABLE TBL_COLEGIO (
    ID_Colegio INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Colegio VARCHAR(100) UNIQUE NOT NULL,
    Direccion_Colegio VARCHAR(100) UNIQUE NOT NULL,
    FK_ID_Barrio INT NOT NULL,
    Estado_Colegio ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Colegio_Barrio FOREIGN KEY (FK_ID_Barrio) REFERENCES TBL_BARRIO(ID_Barrio) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_CUPOS
--

DROP TABLE IF EXISTS TBL_CUPOS;

CREATE TABLE TBL_CUPOS (
    ID_Cupos INT AUTO_INCREMENT PRIMARY KEY,
    FK_ID_Grado INT NOT NULL,
    FK_ID_Colegio INT NOT NULL,
    Jornada VARCHAR(30) NOT NULL,
    Cupos_Disponibles TINYINT(3),
    Estado_Cupos ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Cupos_Grado FOREIGN KEY (FK_ID_Grado) REFERENCES TBL_GRADO(ID_Grado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Cupos_Colegio FOREIGN KEY (FK_ID_Colegio) REFERENCES TBL_COLEGIO(ID_Colegio) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_PERSONA
--

DROP TABLE IF EXISTS TBL_PERSONA;

CREATE TABLE TBL_PERSONA (
    ID_Persona INT AUTO_INCREMENT PRIMARY KEY,
    Num_Doc_Persona VARCHAR(30) UNIQUE NOT NULL,
    Primer_Nombre VARCHAR(50) NOT NULL,
    Segundo_Nombre VARCHAR(50),
    Primer_Apellido VARCHAR(50) NOT NULL,
    Segundo_Apellido VARCHAR(50),
    Fecha_Nacimiento DATE NOT NULL,
    Estado_Persona ENUM('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE'
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_DATOS_ADICIONALES de la persona
--

DROP TABLE IF EXISTS TBL_DATOS_ADICIONALES;

CREATE TABLE TBL_DATOS_ADICIONALES (
    ID_Datos_Adicionales INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Telefono VARCHAR(45) UNIQUE NOT NULL,

    FK_ID_Parentesco INT NOT NULL,
    FK_ID_Tipo_Iden INT NOT NULL,
    FK_ID_Persona INT UNIQUE NOT NULL,
    FK_ID_Genero INT NOT NULL,
    FK_ID_Grupo_Preferencial INT NOT NULL,
    FK_ID_Estrato INT NOT NULL,
    FK_ID_Barrio INT NOT NULL,

    Estado_Datos_Adicionales ENUM('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_DatosAd_Parentesco FOREIGN KEY (FK_ID_Parentesco) REFERENCES TBL_PARENTESCO(ID_Parentesco) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Identificacion FOREIGN KEY (FK_ID_Tipo_Iden) REFERENCES TBL_TIPO_IDENTIFICACION(ID_Tipo_Iden) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Persona FOREIGN KEY (FK_ID_Persona) REFERENCES TBL_PERSONA(ID_Persona) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Genero FOREIGN KEY (FK_ID_Genero) REFERENCES TBL_GENERO(ID_Genero) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_GP FOREIGN KEY (FK_ID_Grupo_Preferencial) REFERENCES TBL_GRUPO_PREFERENCIAL(ID_Grupo_Preferencial) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Estrato FOREIGN KEY (FK_ID_Estrato) REFERENCES TBL_ESTRATO(ID_Estrato) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_DatosAd_Barrio FOREIGN KEY (FK_ID_Barrio) REFERENCES TBL_BARRIO(ID_Barrio) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_USUARIO
--

DROP TABLE IF EXISTS TBL_USUARIO;

CREATE TABLE TBL_USUARIO (
    ID_Usuario INT AUTO_INCREMENT PRIMARY KEY,
    Nombre_Usuario VARCHAR(50) UNIQUE NOT NULL,

    Password_Salt VARBINARY(16) NOT NULL,
    Contraseña_Hash VARBINARY(32) NOT NULL,
    Ultimo_Cambio_Contraseña DATETIME NULL DEFAULT NULL,

    Ultimo_Login DATETIME NULL DEFAULT NULL,
    Intentos_Fallidos INT NULL,
    Fecha_Creacion DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,

    Doble_Factor_Activo ENUM('ACTIVE','INACTIVE') DEFAULT 'INACTIVE',
    MFA_Fecha_Configuracion DATETIME NULL DEFAULT NULL, 
    MFA_Secret VARCHAR(64) NULL DEFAULT NULL,
    MFA_Secret_Temp VARCHAR(64) NULL DEFAULT NULL,

    Notificaciones_Email TINYINT(1) NOT NULL DEFAULT 0,
    Notificaciones_Navegador TINYINT(1) NOT NULL DEFAULT 0,
    
    Aceptacion_Terminos ENUM('ACCEPTED','REJECTED') DEFAULT 'REJECTED',

    FK_ID_Persona INT UNIQUE NOT NULL,
    FK_ID_Rol INT NOT NULL,

    Estado_Usuario ENUM('ACTIVE','BLOCK','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Usuario_Persona FOREIGN KEY (FK_ID_Persona) REFERENCES TBL_PERSONA(ID_Persona) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Usuario_Rol FOREIGN KEY (FK_ID_Rol) REFERENCES TBL_ROL(ID_Rol) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_ESTUDIANTE
--

DROP TABLE IF EXISTS TBL_ESTUDIANTE;

CREATE TABLE TBL_ESTUDIANTE (
    ID_Estudiante INT AUTO_INCREMENT PRIMARY KEY,
    FK_ID_Tipo_Iden INT NOT NULL,

    FK_ID_Persona INT NOT NULL,
    FK_ID_Grado_Actual INT NOT NULL,
    FK_ID_Gardo_Proximo INT NULL,
    FK_ID_Colegio_Anterior INT NOT NULL,

    FK_ID_Genero INT NOT NULL,
    FK_ID_Grupo_Preferencial INT NOT NULL,

    FK_ID_Acudiente INT UNIQUE NOT NULL,
    FK_ID_Parentesco_Es INT NOT NULL,
    
    Estado_Estudiante ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Estudiante_Identificacion FOREIGN KEY (FK_ID_Tipo_Iden) REFERENCES TBL_TIPO_IDENTIFICACION(ID_Tipo_Iden) ON DELETE NO ACTION ON UPDATE CASCADE,

    CONSTRAINT FK_Estudiante_Persona FOREIGN KEY (FK_ID_Persona) REFERENCES TBL_PERSONA(ID_Persona) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Estudiante_Grado_Actual FOREIGN KEY (FK_ID_Grado_Actual) REFERENCES TBL_GRADO(ID_Grado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Estudiante_Grado_Proximo FOREIGN KEY (FK_ID_Gardo_Proximo) REFERENCES TBL_GRADO(ID_Grado) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Estudiante_Colegio_Anterior FOREIGN KEY (FK_ID_Colegio_Anterior) REFERENCES TBL_COLEGIO(ID_Colegio) ON DELETE NO ACTION ON UPDATE CASCADE,

    CONSTRAINT FK_Estudiante_Genero FOREIGN KEY (FK_ID_Genero) REFERENCES TBL_GENERO(ID_Genero) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Estudiante_GP FOREIGN KEY (FK_ID_Grupo_Preferencial) REFERENCES TBL_GRUPO_PREFERENCIAL(ID_Grupo_Preferencial) ON DELETE NO ACTION ON UPDATE CASCADE,

    CONSTRAINT FK_Estudiante_Acudiente FOREIGN KEY (FK_ID_Acudiente) REFERENCES TBL_USUARIO(ID_Usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Estudiante_Parentesco FOREIGN KEY (FK_ID_Parentesco_Es) REFERENCES TBL_PARENTESCO(ID_Parentesco) ON DELETE NO ACTION ON UPDATE CASCADE

) ENGINE=InnoDB;


-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_TICKET
--

DROP TABLE IF EXISTS TBL_TICKET;

CREATE TABLE TBL_TICKET (
    ID_Ticket VARCHAR(10) PRIMARY KEY,
    Titulo_Ticket VARCHAR(150) NOT NULL,
    Descripcion_Ticket TEXT NOT NULL,
    Fecha_Creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    Fecha_Cierre DATETIME,
    Puntaje_Prioridad INT NOT NULL,

    FK_ID_Usuario_Creador INT NOT NULL,
    FK_ID_Usuario_Tecnico INT,
    FK_ID_Estado_Ticket INT NOT NULL,
    FK_ID_Tipo_Caso INT NOT NULL,
    FK_ID_Barrio INT NOT NULL,

    Tiempo_Residencia VARCHAR(20),
    Estado_Ticket ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Ticket_UsuarioCreador FOREIGN KEY (FK_ID_Usuario_Creador) REFERENCES TBL_USUARIO(ID_Usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket_UsuarioTecnico FOREIGN KEY (FK_ID_Usuario_Tecnico) REFERENCES TBL_USUARIO(ID_Usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket_Estado FOREIGN KEY (FK_ID_Estado_Ticket) REFERENCES TBL_ESTADO_TICKET(ID_Estado_Ticket) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_Ticket_Barrio FOREIGN KEY (FK_ID_Barrio) REFERENCES TBL_BARRIO(ID_Barrio) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_TICKET_COMENTARIO
--

DROP TABLE IF EXISTS TBL_TICKET_COMENTARIO;

CREATE TABLE TBL_TICKET_COMENTARIO (
    ID_Ticket_Comentario INT AUTO_INCREMENT PRIMARY KEY,
    Comentario TEXT NOT NULL,
    Fecha_Comentario DATETIME NOT NULL,
    Fecha_Creacion DATETIME NOT NULL,
    Es_Interno TINYINT(1) NOT NULL,

    FK_ID_Usuario INT NOT NULL,
    FK_ID_Ticket VARCHAR(10) NOT NULL,

    Estado_Comentario_Ticket ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_TicketComentario_Usuario FOREIGN KEY (FK_ID_Usuario) REFERENCES TBL_USUARIO(ID_Usuario) ON DELETE NO ACTION ON UPDATE CASCADE,
    CONSTRAINT FK_TicketComentario_Ticket FOREIGN KEY (FK_ID_Ticket) REFERENCES TBL_TICKET(ID_Ticket) ON DELETE NO ACTION ON UPDATE CASCADE

) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_DOCUMENTO_TICKET
--

DROP TABLE IF EXISTS TBL_DOCUMENTO_TICKET;

CREATE TABLE TBL_DOCUMENTO_TICKET (
    ID_Doc_Ticket INT AUTO_INCREMENT PRIMARY KEY,
    
    FK_ID_Ticket VARCHAR(10) NOT NULL,
    FK_ID_Tipo_Doc INT NOT NULL,

    Archivo MEDIUMBLOB NOT NULL,
    Nombre_Original VARCHAR(100) NOT NULL,
    Fecha_Subida DATETIME DEFAULT CURRENT_TIMESTAMP,

    Estado_Documentos ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_DocumentoTicket_Ticket 
    FOREIGN KEY (FK_ID_Ticket) REFERENCES TBL_TICKET(ID_Ticket) 
    ON DELETE NO ACTION ON UPDATE CASCADE,

    CONSTRAINT FK_DocumentoTicket_TipoDoc 
    FOREIGN KEY (FK_ID_Tipo_Doc) REFERENCES TBL_TIPO_DOCUMENTO(ID_Tipo_Doc) 
    ON DELETE NO ACTION ON UPDATE CASCADE

) ENGINE=InnoDB;

-- -----------------------------------------------------------------------------------------------------------
-- ------------------- TABLAS PARA AUDITORIA DEL PROGRAMA

-- --------------------------------------------------------
-- 
-- Estructura de tabla para la tabla TBL_AUDITORIA
--

DROP TABLE IF EXISTS TBL_AUDITORIA;

CREATE TABLE TBL_AUDITORIA (
    ID_Auditoria BIGINT AUTO_INCREMENT PRIMARY KEY,

    Tabla_Afectada VARCHAR(100) NOT NULL,
    Tipo_Evento ENUM('CREATE','READ','UPDATE','DELETE','LOGIN','PASSWORD_CHANGE','DELETE_STUDENT','ACCOUNT_CLOSED'),

    ID_Registro_Afectado VARCHAR(50) NOT NULL,

    Datos_Antiguo JSON NULL,
    Datos_Nuevos JSON NULL,

    Fecha_Auditoria DATETIME DEFAULT CURRENT_TIMESTAMP,

    IP_Usuario VARCHAR(50) NOT NULL,
    User_Agent VARCHAR(255) NULL,

    FK_ID_Usuario INT NOT NULL,

    Estado_Auditoria ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Auditoria_Usuario FOREIGN KEY (FK_ID_Usuario) REFERENCES TBL_USUARIO(ID_Usuario) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB;

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_SESION_ACTIVA
--
DROP TABLE IF EXISTS TBL_SESION_ACTIVA;

CREATE TABLE TBL_SESION_ACTIVA (
    ID_Sesion INT AUTO_INCREMENT PRIMARY KEY,
    FK_ID_Usuario INT NOT NULL,
    JTI VARCHAR(64) NOT NULL UNIQUE,
    Dispositivo VARCHAR(255) NULL,
    IP VARCHAR(50) NULL,
    Fecha_Inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    Ultimo_Acceso DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    Activa TINYINT(1) DEFAULT 1,

    Estado_Sesion_Activa ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',

    CONSTRAINT FK_Sesion_Usuario FOREIGN KEY (FK_ID_Usuario) REFERENCES TBL_USUARIO(ID_Usuario) ON DELETE CASCADE ON UPDATE CASCADE

) ENGINE=InnoDB;

ALTER TABLE TBL_SESION_ACTIVA ADD INDEX idx_jti (JTI);

-- --------------------------------------------------------
--
-- Estructura de tabla para la tabla TBL_AUDITORIA_SESION
--

DROP TABLE IF EXISTS TBL_AUDITORIA_SESION;
 
CREATE TABLE TBL_AUDITORIA_SESION (
    ID_Auditoria BIGINT AUTO_INCREMENT PRIMARY KEY,

    FK_ID_Usuario INT NULL,
    IP_Usuario VARCHAR(45) NOT NULL,
    Tipo_Evento ENUM('LOGIN','LOGOUT','FAILED_LOGIN','FAILED_MFA','LOGIN_MFA_OK'),
    Fecha_Evento DATETIME DEFAULT CURRENT_TIMESTAMP,
    User_Agent VARCHAR(255) NOT NULL,

    Estado_Auditoria_Sesion ENUM('ACTIVE','INACTIVE') DEFAULT 'ACTIVE'

) ENGINE=InnoDB;