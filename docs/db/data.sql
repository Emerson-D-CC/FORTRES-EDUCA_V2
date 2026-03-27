USE FORTRESS_EDUCA_DB;

-- -----------------------------------------------------
-- TBL_GRADO
-- -----------------------------------------------------

INSERT INTO TBL_GRADO (Nombre_Grado, Nivel_Educativo) VALUES
('Primero','Primaria'),
('Segundo','Primaria'),
('Tercero','Primaria'),
('Sexto','Secundaria'),
('Decimo','Media');

-- -----------------------------------------------------
-- TBL_LOCALIDAD
-- -----------------------------------------------------

INSERT INTO TBL_LOCALIDAD (Nombre_Localidad) VALUES
('Engativá'),

-- -----------------------------------------------------
-- TBL_GENERO
-- -----------------------------------------------------

INSERT INTO TBL_GENERO (Nombre_Genero) VALUES
('Masculino'),
('Femenino'),
('No Binario');

-- -----------------------------------------------------
-- TBL_GRUPO_PREFERENCIAL
-- -----------------------------------------------------

INSERT INTO TBL_GRUPO_PREFERENCIAL (Nombre_Grupo_Preferencial, Nivel_Prioridad_GP) VALUES
('Victima del conflicto',1),
('Discapacidad',2),
('Desplazado',3),
('Ninguno',5);

-- -----------------------------------------------------
-- TBL_ESTRATO
-- -----------------------------------------------------

INSERT INTO TBL_ESTRATO (Numero_Estrato, Nivel_Prioridad_E) VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6);

-- -----------------------------------------------------
-- TBL_ROL
-- -----------------------------------------------------

INSERT INTO TBL_ROL (Nombre_Rol, Descripcion_Rol) VALUES
('Estudiante', 'Persona por la cual se creara el ticket'), 
('Acudiente', 'Persona encargada de registrar estudiantes y la creación de sus respectivos ticktes'), 
('Tecnico', 'Resolvera tickets'), 
('Admin', 'Encargado de la pagina');
-- -----------------------------------------------------
-- TBL_TIPO_DOCUMENTO
-- -----------------------------------------------------

INSERT INTO TBL_TIPO_IDENTIFICACION (Nombre_Tipo_Iden) VALUES
('Cedula de Ciudadania'),
('Cedula de Extranjeria'),
('Tarjeta de Identidad'),
('Registro Civil');

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
-- TBL_COLEGIO
-- -----------------------------------------------------

INSERT INTO TBL_COLEGIO (Nombre_Colegio, Direccion_Colegio, FK_ID_Localidad) VALUES
-- Distritales (IED)
('Colegio Rodolfo Llinás IED','Barrio Bolivia',1),
('Colegio Juan del Corral IED','Barrio Las Ferias',1),
('Colegio Magdalena Ortega de Nariño IED','Engativá',1),
('Colegio República de Colombia IED','Engativá',1),
('Colegio Garcés Navas IED','Garcés Navas',1),
('Colegio Minuto de Dios Siglo XXI IED','Minuto de Dios',1),
('Colegio Villas de Granada IED','Villas de Granada',1),
('Colegio La Estrada IED','La Estrada',1),
('Colegio Boyacá Real IED','Boyacá Real',1),
('Colegio Álamos IED','Álamos',1),
('Colegio Santa María del Lago IED','Santa María del Lago',1),
('Colegio Tabora IED','Tabora',1),
('Colegio Florencia IED','Florencia',1),
('Colegio Bolivia IED','Bolivia',1),
('Colegio Las Ferias IED','Las Ferias',1),

-- Privados (representativos)
('Liceo Moderno Engativá','Engativá Centro',1),
('Colegio San José Norte','Engativá',1),
('Colegio Psicopedagógico Villa Luz','Villa Luz',1),
('Colegio Bilingüe Nueva Alejandría','Normandía',1),
('Colegio Empresarial de los Andes','Álamos',1);

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