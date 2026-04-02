USE FORTRESS_EDUCA_DB;

-- -----------------------------------------------------
-- TBL_GRADO
-- -----------------------------------------------------

INSERT INTO TBL_GRADO (Nombre_Grado, Nivel_Educativo) VALUES
('Pre jardín','Preescolar'),
('Transición','Preescolar'),
('Primero','Primaria'),
('Segundo','Primaria'),
('Tercero','Primaria'),
('Cuarto','Primaria'),
('Quinto','Primaria'),
('Sexto', 'Secundaria'),
('Septimo', 'Secundaria'), 
('Octavo', 'Secundaria'), 
('Noveno', 'Secundaria'), 
('Decimo', 'Bachiller'), 
('Once', 'Bachiller');


-- -----------------------------------------------------
-- TBL_LOCALIDAD
-- -----------------------------------------------------

INSERT INTO TBL_LOCALIDAD (Nombre_Localidad) VALUES
('Engativá'),
('Otra');


-- -----------------------------------------------------
-- TBL_GENERO
-- -----------------------------------------------------

INSERT INTO TBL_GENERO (Nombre_Genero) VALUES
('Masculino'),
('Femenino'),
('No Binario'),
('Otro');


-- -----------------------------------------------------
-- TBL_GRUPO_PREFERENCIAL
-- -----------------------------------------------------

INSERT INTO TBL_GRUPO_PREFERENCIAL (Nombre_Grupo_Preferencial, Nivel_Prioridad_GP) VALUES
('Victima del conflicto',5),
('Discapacidad',4),
('Desplazado',4),
('Ninguno',0);


-- -----------------------------------------------------
-- TBL_ESTRATO
-- -----------------------------------------------------

INSERT INTO TBL_ESTRATO (Numero_Estrato, Nivel_Prioridad_E) VALUES
(1,6),
(2,5),
(3,4),
(4,3),
(5,2),
(6,1);


-- -----------------------------------------------------
-- TBL_ROL
-- -----------------------------------------------------

INSERT INTO TBL_ROL (Nombre_Rol, Descripcion_Rol) VALUES
('Sistema', 'Usuario generico del sistema'),
('Acudiente', 'Persona encargada de registrar estudiantes y la creación de sus respectivos ticktes'), 
('Tecnico', 'Resolvera tickets'), 
('Admin', 'Encargado de la pagina');

-- -----------------------------------------------------
-- TBL_PARENTESCO
-- -----------------------------------------------------

INSERT INTO TBL_PARENTESCO (Nombre_Parentesco, Tipo_Usuario) VALUES
('Hijo','ESTUDIANTE'),
('Hija','ESTUDIANTE'),
('Sobrino/a','ESTUDIANTE'),
('Hermano/a','ESTUDIANTE'),
('Nieto/a','ESTUDIANTE'),
('Hijo Adoptivo','ESTUDIANTE'),
('Hija Adoptivo','ESTUDIANTE'),
('Otro ','ESTUDIANTE'),
('Padre','ACUDIENTE'),
('Madre','ACUDIENTE'),
('Tío/a','ACUDIENTE'),
('Abuelo/a','ACUDIENTE'),
('Hermano/a Mayor','ACUDIENTE'),
('Tutor Legal','ACUDIENTE'),
('Otro','ACUDIENTE');


-- -----------------------------------------------------
-- TBL_TIPO_DOCUMENTO
-- -----------------------------------------------------

INSERT INTO TBL_TIPO_IDENTIFICACION (Nombre_Tipo_Iden, Tipo_Usuario) VALUES
('Cedula de Ciudadania','ACUDIENTE'),
('Cedula de Extranjeria','ACUDIENTE'),
('Tarjeta de Identidad','ESTUDIANTE'),
('Registro Civil','ESTUDIANTE');


-- -----------------------------------------------------
-- TBL_TIPO_AFECTACION
-- -----------------------------------------------------

INSERT INTO TBL_TIPO_AFECTACION (Afectacion, Nivel_Prioridad_TC) VALUES
('Problema de inscripcion',1),
('Solicitud de traslado',2),
('Error en sistema',3),
('Consulta general',5);


-- -----------------------------------------------------
-- TBL_ESTADO_TICKET
-- -----------------------------------------------------

INSERT INTO TBL_ESTADO_TICKET (Nombre_Estado, Estado_Final) VALUES
('Abierto',0),
('En Proceso',0),
('Resuelto',1),
('Cerrado',1);


-- -----------------------------------------------------
-- TBL_BARRIO
-- -----------------------------------------------------

INSERT INTO TBL_BARRIO (Nombre_Barrio, FK_ID_Localidad) VALUES
('Engativá Centro',1),
('Garcés Navas',1),
('Minuto de Dios',1),
('Villas de Granada',1),
('La Estrada',1),
('Santa Helenita',1),
('Boyacá Real',1),
('Álamos Norte',1),
('Álamos Sur',1),
('Las Ferias',1),
('Bolivia',1),
('Normandía',1),
('Normandía Occidental',1),
('Villa Luz',1),
('Santa Cecilia',1),
('El Luján',1),
('La Clarita',1),
('Florencia',1),
('La Granja',1),
('Marandú',1),
('Villa Gladys',1),
('San Ignacio',1),
('Los Álamos',1),
('Santa María del Lago',1),
('Tabora',1),
('El Cortijo',1),
('Granjas del Dorado',1),
('Villa Teresita',1),
('Villa Clavel',1),
('Santa Rosita',1);


-- -----------------------------------------------------
-- TBL_COLEGIO
-- -----------------------------------------------------

INSERT INTO TBL_COLEGIO (Nombre_Colegio, Direccion_Colegio, FK_ID_Barrio) VALUES
-- Distritales (IED)
('Colegio Rodolfo Llinás IED','Kr. 1',1),
('Colegio Juan del Corral IED','Kr. 2',1),
('Colegio Magdalena Ortega de Nariño IED','Kr. 3',1),
('Colegio República de Colombia IED','Kr. 4',1),
('Colegio Garcés Navas IED','Kr. 5',1),
('Colegio Minuto de Dios Siglo XXI IED','Kr. 6',1),
('Colegio Villas de Granada IED','Kr. 7',1),
('Colegio La Estrada IED','Kr. 8',1),
('Colegio Boyacá Real IED','Kr. 9',1),
('Colegio Álamos IED','Kr. 10',1),
('Colegio Santa María del Lago IED','Kr. 11',1),
('Colegio Tabora IED','Kr. 12',1),
('Colegio Florencia IED','Kr. 13',1),
('Colegio Bolivia IED','Kr. 14',1),
('Colegio Robert F Kennedy IED','Av. Boyaca',1),
('Colegio Las Ferias IED','Kr. 15',1);


-- -----------------------------------------------------
-- TBL_CUPOS
-- -----------------------------------------------------

INSERT INTO TBL_CUPOS (FK_ID_Grado, FK_ID_Colegio, Jornada, Cupos_Disponibles) VALUES
(1,1,'Mañana',40),
(2,1,'Tarde',35),
(3,2,'Mañana',38),
(4,2,'Tarde',30),
(1,3,'Mañana',42),
(2,4,'Tarde',33),
(3,5,'Mañana',36),
(4,6,'Tarde',28),
(5,7,'Mañana',30),
(1,8,'Mañana',27),
(2,9,'Tarde',29),
(3,10,'Mañana',34),
(4,11,'Tarde',26),
(5,12,'Mañana',31);


-- -----------------------------------------------------
-- USUARIO PRUEBA: USUARIO NORMAL
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
('1019762928', 'Emerson', 'Daniel', 'Caicedo', 'Cobos', '2000-01-01', 'ACTIVE');

INSERT INTO TBL_DATOS_ADICIONALES (ID_Datos_Adicionales, Email, Telefono, FK_ID_Parentesco, FK_ID_Tipo_Iden, FK_ID_Persona, FK_ID_Genero, FK_ID_Grupo_Preferencial, FK_ID_Estrato, FK_ID_Barrio, Estado_Datos_Adicionales) VALUES 
('D1019762928', 'edcaicedoc@sanmateo.edu.co', '3213397584', '13', '1', '1019762928', '1', '4', '3', '12', 'ACTIVE');

INSERT INTO TBL_USUARIO (ID_Usuario, Nombre_Usuario, Password_Salt, Contraseña_Hash, Ultimo_Cambio_Contraseña, Ultimo_Login, Intentos_Fallidos, Fecha_Creacion, Doble_Factor_Activo, Aceptacion_Terminos, FK_ID_Persona, FK_ID_Rol, Estado_Usuario) VALUES 
('U1019762928', 'edcaicedoc@sanmateo.edu.co', 0xae4756612d1de55c3e5bd5bb29fd1e4e, 0xe2a93a325afc47f1f5688c135055040c8db14d6c22808bc2cb1e4135ee66ca3e, NULL, '2026-03-31 02:21:06', '0', '2026-03-30 23:07:59', 'INACTIVE', 'ACCEPTED', '1019762928', '2', 'ACTIVE');


-- -----------------------------------------------------
-- ESTUDIANTE PRUEBA
-- -----------------------------------------------------

INSERT INTO TBL_PERSONA (ID_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
('1524524213', 'Luis', 'Alejandro', 'Narvaez', 'Talavera', '2015-11-19', 'ACTIVE');

INSERT INTO TBL_ESTUDIANTE (ID_Estudiante, FK_ID_Tipo_Iden, FK_ID_Persona, FK_ID_Grado_Actual, FK_ID_Gardo_Proximo, FK_ID_Colegio_Anterior, FK_ID_Genero, FK_ID_Grupo_Preferencial, FK_ID_Acudiente, FK_ID_Parentesco_Es, Estado_Estudiante) VALUES 
('E1524524213', '3', '1524524213', '6', '7', '9', '1', '4', 'U1019762928', '6', 'ACTIVE');


-- -----------------------------------------------------
-- ESTUDIANTE PRUEBA
-- -----------------------------------------------------
INSERT INTO TBL_PERSONA (ID_Persona, Primer_Nombre, Segundo_Nombre, Primer_Apellido, Segundo_Apellido, Fecha_Nacimiento, Estado_Persona) VALUES 
('000000010000000', 'System', '-', 'User', '-', '2000-01-01', 'ACTIVE');

INSERT INTO TBL_USUARIO (ID_Usuario, Nombre_Usuario, Password_Salt, Contraseña_Hash, FK_ID_Persona, FK_ID_Rol) VALUES 
('SYSTEM','system@audit', UNHEX('00'), UNHEX('00'), '000000010000000', 1);