USE FORTRESS_EDUCA_DB;

-- -----------------------------------------------------
-- TBL_GRADO
-- -----------------------------------------------------

INSERT INTO TBL_GRADO (ID_Grado, Nombre_Grado, Nivel_Educativo) VALUES
    (1,'Pre jardín','Preescolar'),
    (2,'Transición','Preescolar'),
    (3,'Primero','Primaria'),
    (4,'Segundo','Primaria'),
    (5,'Tercero','Primaria'),
    (6,'Cuarto','Primaria'),
    (7,'Quinto','Primaria'),
    (8,'Sexto', 'Secundaria'),
    (9,'Septimo', 'Secundaria'), 
    (10,'Octavo', 'Secundaria'), 
    (11,'Noveno', 'Secundaria'), 
    (12,'Decimo', 'Bachiller'), 
    (13,'Once', 'Bachiller');


-- -----------------------------------------------------
-- TBL_LOCALIDAD
-- -----------------------------------------------------

INSERT INTO TBL_LOCALIDAD (ID_Localidad, Nombre_Localidad) VALUES
    (1,'Engativá'),
    (2,'Otra');


-- -----------------------------------------------------
-- TBL_GENERO
-- -----------------------------------------------------

INSERT INTO TBL_GENERO (ID_Genero, Nombre_Genero) VALUES
    (1,'Masculino'),
    (2,'Femenino'),
    (3,'No Binario'),
    (4,'Otro');


-- -----------------------------------------------------
-- TBL_GRUPO_PREFERENCIAL
-- -----------------------------------------------------

INSERT INTO TBL_GRUPO_PREFERENCIAL (ID_Grupo_Preferencial, Nombre_Grupo_Preferencial, Nivel_Prioridad_GP) VALUES
    (1,'Comunidad Indígena',30),
    (2,'Afrocolombiano',25),
    (3,'Refugiado',25),
    (4,'LGBTQ+',20),
    (5,'Pobreza Extrema',20),
    (6,'Ninguno',20);


-- -----------------------------------------------------
-- TBL_ESTRATO
-- -----------------------------------------------------

INSERT INTO TBL_ESTRATO (ID_Estrato, Nombre_Estrato, Nivel_Prioridad_E) VALUES
    (1,'Estrato 1',60),
    (2,'Estrato 2',50),
    (3,'Estrato 3',40),
    (4,'Estrato 4',30);


-- -----------------------------------------------------
-- TBL_ROL
-- -----------------------------------------------------

INSERT INTO TBL_ROL (ID_Rol, Nombre_Rol, Descripcion_Rol) VALUES
    (1,'Sistema', 'Usuario generico del sistema'),
    (2,'Acudiente', 'Persona encargada de registrar estudiantes y la creación de sus respectivos ticktes'), 
    (3,'Tecnico', 'Resolvera tickets'), 
    (4,'Admin', 'Encargado de la pagina');


-- -----------------------------------------------------
-- TBL_PARENTESCO
-- -----------------------------------------------------

INSERT INTO TBL_PARENTESCO (ID_Parentesco, Nombre_Parentesco, Tipo_Usuario) VALUES
    (1,'Hijo','ESTUDIANTE'),
    (2,'Hija','ESTUDIANTE'),
    (3,'Sobrino/a','ESTUDIANTE'),
    (4,'Hermano/a','ESTUDIANTE'),
    (5,'Nieto/a','ESTUDIANTE'),
    (6,'Hijo Adoptivo','ESTUDIANTE'),
    (7,'Hija Adoptiva','ESTUDIANTE'),
    (8,'Otro ','ESTUDIANTE'),
    (9,'Padre','ACUDIENTE'),
    (10,'Madre','ACUDIENTE'),
    (11,'Tío/a','ACUDIENTE'),
    (12,'Abuelo/a','ACUDIENTE'),
    (13,'Hermano/a Mayor','ACUDIENTE'),
    (14,'Tutor Legal','ACUDIENTE'),
    (15,'Otro','ACUDIENTE');


-- -----------------------------------------------------
-- TBL_TIPO_DOCUMENTO_IDENTIDAD
-- -----------------------------------------------------

INSERT INTO TBL_TIPO_IDENTIFICACION (ID_Tipo_Iden, Nombre_Tipo_Iden, Tipo_Usuario) VALUES
    (1,'Cedula de Ciudadania','ACUDIENTE'),
    (2,'Cedula de Extranjeria','ACUDIENTE'),
    (3,'Tarjeta de Identidad','ESTUDIANTE'),
    (4,'Registro Civil','ESTUDIANTE');


-- -----------------------------------------------------
-- TBL_TIPO_AFECTACION
-- -----------------------------------------------------

INSERT INTO TBL_TIPO_AFECTACION (ID_Tipo_Afectacion, Nombre_Afectacion, Nivel_Prioridad_TC) VALUES
    (1,'Desplazamiento Forzado',40),
    (2,'Víctima del Conflicto Armado',35),
    (3,'Vulnerabilidad Económica',20),
    (4,'No Escolarizado',15),
    (5,'Otro',5);


-- -----------------------------------------------------
-- TBL_BARRIO
-- -----------------------------------------------------

INSERT INTO TBL_BARRIO (ID_Barrio, Nombre_Barrio, FK_ID_Localidad) VALUES
    (1,'Engativá Centro',1),
    (2,'Garcés Navas',1),
    (4,'Minuto de Dios',1),
    (5,'Villas de Granada',1),
    (6,'La Estrada',1),
    (7,'Santa Helenita',1),
    (8,'Boyacá Real',1),
    (9,'Álamos Norte',1),
    (10,'Álamos Sur',1),
    (11,'Las Ferias',1),
    (12,'Santa Rosita',1),
    (13,'Bolivia',1),
    (14,'Normandía',1),
    (15,'Normandía Occidental',1),
    (16,'Villa Luz',1),
    (17,'Santa Cecilia',1),
    (18,'El Luján',1),
    (19,'La Clarita',1),
    (20,'Florencia',1),
    (21,'La Granja',1),
    (22,'Marandú',1),
    (23,'Villa Gladys',1),
    (24,'San Ignacio',1),
    (25,'Los Álamos',1),
    (26,'Santa María del Lago',1),
    (27,'Tabora',1),
    (28,'El Cortijo',1),
    (29,'Granjas del Dorado',1),
    (30,'Villa Teresita',1),
    (31,'Villa Clavel',1);


-- -----------------------------------------------------
-- TBL_COLEGIO
-- -----------------------------------------------------

INSERT INTO TBL_COLEGIO (ID_Colegio, Nombre_Colegio, Direccion_Colegio, FK_ID_Barrio) VALUES
-- Distritales (IED)
    (1,'No Aplica','N/A',1),
    (2,'Colegio Juan del Corral IED','Kr. 2',1),
    (3,'Colegio Magdalena Ortega de Nariño IED','Kr. 3',1),
    (4,'Colegio República de Colombia IED','Kr. 4',1),
    (5,'Colegio Garcés Navas IED','Kr. 5',1),
    (6,'Colegio Minuto de Dios Siglo XXI IED','Kr. 6',1),
    (7,'Colegio Villas de Granada IED','Kr. 7',1),
    (8,'Colegio La Estrada IED','Kr. 8',1),
    (9,'Colegio Boyacá Real IED','Kr. 9',1),
    (10,'Colegio Álamos IED','Kr. 10',1),
    (11,'Colegio Santa María del Lago IED','Kr. 11',1),
    (12,'Colegio Tabora IED','Kr. 12',1),
    (13,'Colegio Florencia IED','Kr. 13',1),
    (14,'Colegio Bolivia IED','Kr. 14',1),
    (15,'Colegio Robert F Kennedy IED','Av. Boyaca',1),
    (16,'Colegio Las Ferias IED','Kr. 15',1),
    (17,'Colegio Rodolfo Llinás IED','Kr. 16',1),
    (18,'Colegio Antonio Nariño IED','Kr. 17',1);


-- -----------------------------------------------------
-- TBL_JORNADA
-- -----------------------------------------------------

INSERT INTO TBL_JORNADA (ID_Jornada, Nombre_Jornada) VALUES
    (1,'Mañana'),
    (2,'Tarde'),
    (3,'Nocturna');


-- -----------------------------------------------------
-- TBL_CUPOS
-- -----------------------------------------------------

INSERT INTO TBL_CUPOS (FK_ID_Grado, FK_ID_Colegio, FK_ID_Jornada, Cupos_Disponibles) VALUES
    (1,1,1,40),
    (2,1,2,35),
    (3,2,1,38),
    (4,2,2,30),
    (1,3,1,42),
    (2,4,2,33),
    (3,5,1,36),
    (4,6,2,28),
    (5,7,1,30),
    (1,8,1,27),
    (2,9,2,29),
    (3,10,1,34),
    (4,11,2,26),
    (5,12,1,31);


-- -----------------------------------------------------
-- TBL_ESTADO_TICKET
-- -----------------------------------------------------

INSERT INTO TBL_ESTADO_TICKET (ID_Estado_Ticket, Nombre_Estado, Estado_Final) VALUES
    (1,'Abierto',0),
    (2,'En Revisión',0),
    (3,'Validación de Documentos',0),
    (4,'Pendiente Acción de Usuario',0),
    (5,'Asignación de Cupo',0),
    (6,'Rechazado',1),
    (7,'Cancelado a Petición',1),
    (8,'Solucionado',1);


-- -----------------------------------------------------
-- TBL_TIEMPO_RESIDENCIA
-- -----------------------------------------------------

INSERT INTO TBL_TIEMPO_RESIDENCIA (ID_Tiempo_Residencia, Nombre_Tiempo) VALUES
    (1,'Menos de 1 mes'),
    (2,'1 a 6 meses'),
    (3,'6 meses a 1 año'),
    (4,'Más de 1 año');


-- -----------------------------------------------------
-- TBL_TIPO_DOCUMENTO
-- -----------------------------------------------------

-- INSERT INTO TBL_TIPO_DOCUMENTO (ID_Tipo_Doc, Nombre_Tipo_Doc) VALUES
--     (1,'PDF'),
--     (2,'PNG'),
--     (3,'JPG');

INSERT INTO TBL_TIPO_DOCUMENTO (ID_Tipo_Doc, Nombre_Tipo_Doc) VALUES
    (1, 'Documento Acudiente'),
    (2, 'Documento Menor'),
    (3, 'Certificado Académico'),
    (4, 'Documento Víctima');


-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- USUARIO GENERAL DEL SISTEMA
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Num_Doc_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
    (5157341, '000000010000000', 'System', '-', 'User', '-', '2000-01-01', 1);

INSERT INTO TBL_USUARIO (ID_Usuario, Nombre_Usuario, Password_Salt, Contraseña_Hash, FK_ID_Persona, FK_ID_Rol) VALUES 
    (5157341,'system@audit', UNHEX('00'), UNHEX('00'), 5157341, 1);


-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- USUARIO PRUEBA: USUARIO NORMAL N°1
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Num_Doc_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
    (1, '1019762928', 'Emerson', 'Daniel', 'Caicedo', 'Cobos', '2000-01-01', 1);

INSERT INTO TBL_DATOS_ADICIONALES (ID_Datos_Adicionales, Email, Telefono, FK_ID_Parentesco, FK_ID_Tipo_Iden, FK_ID_Persona, FK_ID_Genero, FK_ID_Grupo_Preferencial, FK_ID_Estrato, FK_ID_Barrio, Estado_Datos_Adicionales) VALUES 
    (1, 'edcaicedoc@sanmateo.edu.co', '3213397584', '13', '1', '1', '1', '4', '3', '18', 1);

INSERT INTO TBL_USUARIO (ID_Usuario, Nombre_Usuario, Password_Salt, Contraseña_Hash, Ultimo_Cambio_Contraseña, Ultimo_Login, Intentos_Fallidos, Fecha_Creacion, Doble_Factor_Activo, MFA_Fecha_Configuracion, MFA_Secret, MFA_Secret_Temp, Notificaciones_Email, Notificaciones_Navegador, Aceptacion_Terminos, FK_ID_Persona, FK_ID_Rol, Estado_Usuario) VALUES 
    (1, 'edcaicedoc@sanmateo.edu.co', 0xe403ae2a10b333e48db107b88b68cc9e, 0x5720741e1c1640d7a23b6ddff3a1f5e4926aadebc018255d77f770eb65ddfc80, '2026-04-02 05:11:15', '2026-04-03 07:02:15', '0', '2026-03-30 23:07:59', 'INACTIVE', '2026-04-03 01:16:41', NULL, NULL, '0', '0', 'ACCEPTED', '1', '2', 1);

-- -----------------------------------------------------
-- ESTUDIANTE PRUEBA N°1
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Num_Doc_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
    (3, '1524524213', 'Luis', 'Alejandro', 'Narvaez', 'Talavera', '2015-11-19', 1);

INSERT INTO TBL_ESTUDIANTE (ID_Estudiante, FK_ID_Tipo_Iden, FK_ID_Persona, FK_ID_Grado_Actual, FK_ID_Gardo_Proximo, FK_ID_Colegio_Anterior, FK_ID_Genero, FK_ID_Grupo_Preferencial, FK_ID_Acudiente, FK_ID_Parentesco_Es, Estado_Estudiante) VALUES 
    (1, '3', '3', '6', '7', '9', '1', '4', '1', '6', 1);


-- ----------------------------------------------------------------------------------------------------------------------------------------------------
-- USUARIO PRUEBA: USUARIO NORMAL N°2
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Num_Doc_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
    (2, '54269132', 'Luis', 'Felipe', 'Gonzalez', 'Mogollon', '2000-01-01', 1);

INSERT INTO TBL_DATOS_ADICIONALES (ID_Datos_Adicionales, Email, Telefono, FK_ID_Parentesco, FK_ID_Tipo_Iden, FK_ID_Persona, FK_ID_Genero, FK_ID_Grupo_Preferencial, FK_ID_Estrato, FK_ID_Barrio, Estado_Datos_Adicionales) VALUES 
    (2, 'danicaicedo2005@gmail.com', '3152512350', '9', '1', '2', '1', '4', '3', '19', 1);

INSERT INTO TBL_USUARIO (ID_Usuario, Nombre_Usuario, Password_Salt, Contraseña_Hash, Ultimo_Cambio_Contraseña, Ultimo_Login, Intentos_Fallidos, Fecha_Creacion, Doble_Factor_Activo, MFA_Fecha_Configuracion, MFA_Secret, MFA_Secret_Temp, Notificaciones_Email, Notificaciones_Navegador, Aceptacion_Terminos, FK_ID_Persona, FK_ID_Rol, Estado_Usuario) VALUES 
    (2, 'danicaicedo2005@gmail.com', 0x6c8edbad240dbbcfb74eeda63e441685, 0xfe3f6c1f587645add5312aace99fc51ce340c5ed1b6d90b719f4e974f9d5e11e, NULL, NULL, NULL, '2026-04-03 17:09:56', 'INACTIVE', NULL, NULL, NULL, '0', '0', 'ACCEPTED', '2', '2', 1);

-- -----------------------------------------------------
-- ESTUDIANTE PRUEBA N°2
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Num_Doc_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
    (4, '1064298354', 'Andres', 'Felipe', 'Saenz', 'Gutierrez', '2008-06-19', 1);

INSERT INTO TBL_ESTUDIANTE (ID_Estudiante, FK_ID_Tipo_Iden, FK_ID_Persona, FK_ID_Grado_Actual, FK_ID_Gardo_Proximo, FK_ID_Colegio_Anterior, FK_ID_Genero, FK_ID_Grupo_Preferencial, FK_ID_Acudiente, FK_ID_Parentesco_Es, Estado_Estudiante) VALUES 
    (2, '3', '4', '10', '11', '11', '1', '1', '2', '6', 1);