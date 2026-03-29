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
('Estudiante', 'Persona por la cual se creara el ticket'), 
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