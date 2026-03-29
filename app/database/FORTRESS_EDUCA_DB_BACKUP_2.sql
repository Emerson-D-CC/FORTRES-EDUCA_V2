CREATE DATABASE  IF NOT EXISTS `fortress_educa_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `fortress_educa_db`;
-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: fortress_educa_db
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tbl_auditoria`
--

DROP TABLE IF EXISTS `tbl_auditoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_auditoria` (
  `ID_Auditoria` bigint NOT NULL AUTO_INCREMENT,
  `Tabla_Afectada` varchar(100) NOT NULL,
  `Tipo_Evento` varchar(15) NOT NULL,
  `ID_Registro_Afectado` varchar(50) NOT NULL,
  `Fecha_Auditoria` datetime DEFAULT CURRENT_TIMESTAMP,
  `IP_Usuario` varchar(50) NOT NULL,
  `FK_ID_Usuario` varchar(16) NOT NULL,
  `Estado_Auditoria` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Auditoria`),
  KEY `FK_Auditoria_Usuario` (`FK_ID_Usuario`),
  CONSTRAINT `FK_Auditoria_Usuario` FOREIGN KEY (`FK_ID_Usuario`) REFERENCES `tbl_usuario` (`ID_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_auditoria`
--

LOCK TABLES `tbl_auditoria` WRITE;
/*!40000 ALTER TABLE `tbl_auditoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_auditoria_sesion`
--

DROP TABLE IF EXISTS `tbl_auditoria_sesion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_auditoria_sesion` (
  `ID_Auditoria` bigint NOT NULL AUTO_INCREMENT,
  `FK_ID_Usuario` varchar(16) DEFAULT NULL,
  `IP_Usuario` varchar(45) DEFAULT NULL,
  `Tipo_Evento` enum('LOGIN','LOGOUT','FAILED_LOGIN') DEFAULT NULL,
  `Fecha_Evento` datetime DEFAULT CURRENT_TIMESTAMP,
  `User_Agent` varchar(255) DEFAULT NULL,
  `Estado` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Auditoria`),
  KEY `FK_Auditoria_Sesion_Usuario` (`FK_ID_Usuario`),
  CONSTRAINT `FK_Auditoria_Sesion_Usuario` FOREIGN KEY (`FK_ID_Usuario`) REFERENCES `tbl_usuario` (`ID_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_auditoria_sesion`
--

LOCK TABLES `tbl_auditoria_sesion` WRITE;
/*!40000 ALTER TABLE `tbl_auditoria_sesion` DISABLE KEYS */;
INSERT INTO `tbl_auditoria_sesion` VALUES (19,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-26 03:11:05','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(20,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-26 03:12:38','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(21,NULL,'127.0.0.1','FAILED_LOGIN','2026-03-26 03:12:49','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(22,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-26 03:21:24','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(23,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-26 03:23:14','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(24,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-26 03:24:39','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(25,'U54269719','127.0.0.1','LOGIN','2026-03-26 03:26:09','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(33,NULL,'127.0.0.1','FAILED_LOGIN','2026-03-27 04:02:18','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(34,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-27 04:02:25','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(35,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-27 04:02:32','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE'),(36,'U1019762928','127.0.0.1','FAILED_LOGIN','2026-03-27 04:39:33','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36','ACTIVE');
/*!40000 ALTER TABLE `tbl_auditoria_sesion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_barrio`
--

DROP TABLE IF EXISTS `tbl_barrio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_barrio` (
  `ID_Barrio` int NOT NULL AUTO_INCREMENT,
  `Nombre_Barrio` varchar(30) NOT NULL,
  `FK_ID_Localidad` int NOT NULL,
  `Estado_Barrio` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Barrio`),
  UNIQUE KEY `Nombre_Barrio` (`Nombre_Barrio`),
  KEY `FK_Barrio_Localidad` (`FK_ID_Localidad`),
  CONSTRAINT `FK_Barrio_Localidad` FOREIGN KEY (`FK_ID_Localidad`) REFERENCES `tbl_localidad` (`ID_Localidad`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_barrio`
--

LOCK TABLES `tbl_barrio` WRITE;
/*!40000 ALTER TABLE `tbl_barrio` DISABLE KEYS */;
INSERT INTO `tbl_barrio` VALUES (5,'Engativ√° Centro',1,'ACTIVE'),(6,'Garc√©s Navas',1,'ACTIVE'),(7,'Minuto de Dios',1,'ACTIVE'),(8,'Villas de Granada',1,'ACTIVE'),(9,'La Estrada',1,'ACTIVE'),(10,'Santa Helenita',1,'ACTIVE'),(11,'Boyac√° Real',1,'ACTIVE'),(12,'√Ålamos Norte',1,'ACTIVE'),(13,'√Ålamos Sur',1,'ACTIVE'),(14,'Las Ferias',1,'ACTIVE'),(15,'Bolivia',1,'ACTIVE'),(16,'Normand√≠a',1,'ACTIVE'),(17,'Normand√≠a Occidental',1,'ACTIVE'),(18,'Villa Luz',1,'ACTIVE'),(19,'Santa Cecilia',1,'ACTIVE'),(20,'El Luj√°n',1,'ACTIVE'),(21,'La Clarita',1,'ACTIVE'),(22,'Florencia',1,'ACTIVE'),(23,'La Granja',1,'ACTIVE'),(24,'Marand√∫',1,'ACTIVE'),(25,'Villa Gladys',1,'ACTIVE'),(26,'San Ignacio',1,'ACTIVE'),(27,'Los √Ålamos',1,'ACTIVE'),(28,'Santa Mar√≠a del Lago',1,'ACTIVE'),(29,'Tabora',1,'ACTIVE'),(30,'El Cortijo',1,'ACTIVE'),(31,'Granjas del Dorado',1,'ACTIVE'),(32,'Villa Teresita',1,'ACTIVE'),(33,'Villa Clavel',1,'ACTIVE'),(34,'Santa Rosita',1,'ACTIVE');
/*!40000 ALTER TABLE `tbl_barrio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_colegio`
--

DROP TABLE IF EXISTS `tbl_colegio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_colegio` (
  `ID_Colegio` int NOT NULL AUTO_INCREMENT,
  `Nombre_Colegio` varchar(100) NOT NULL,
  `Direccion_Colegio` varchar(100) NOT NULL,
  `FK_ID_Localidad` int NOT NULL,
  `Estado_Colegio` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Colegio`),
  UNIQUE KEY `Nombre_Colegio` (`Nombre_Colegio`),
  UNIQUE KEY `Direccion_Colegio` (`Direccion_Colegio`),
  KEY `FK_Colegio_Localidad` (`FK_ID_Localidad`),
  CONSTRAINT `FK_Colegio_Localidad` FOREIGN KEY (`FK_ID_Localidad`) REFERENCES `tbl_localidad` (`ID_Localidad`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_colegio`
--

LOCK TABLES `tbl_colegio` WRITE;
/*!40000 ALTER TABLE `tbl_colegio` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_colegio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_cupos`
--

DROP TABLE IF EXISTS `tbl_cupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_cupos` (
  `ID_Cupos` int NOT NULL AUTO_INCREMENT,
  `FK_ID_Grado` int NOT NULL,
  `FK_ID_Colegio` int NOT NULL,
  `Jornada` varchar(30) NOT NULL,
  `Cupos_Disponibles` tinyint DEFAULT NULL,
  `Estado_Cupos` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Cupos`),
  KEY `FK_Cupos_Grado` (`FK_ID_Grado`),
  KEY `FK_Cupos_Colegio` (`FK_ID_Colegio`),
  CONSTRAINT `FK_Cupos_Colegio` FOREIGN KEY (`FK_ID_Colegio`) REFERENCES `tbl_colegio` (`ID_Colegio`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Cupos_Grado` FOREIGN KEY (`FK_ID_Grado`) REFERENCES `tbl_grado` (`ID_Grado`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_cupos`
--

LOCK TABLES `tbl_cupos` WRITE;
/*!40000 ALTER TABLE `tbl_cupos` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_cupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_datos_adicionales`
--

DROP TABLE IF EXISTS `tbl_datos_adicionales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_datos_adicionales` (
  `ID_Datos_Adicionales` varchar(16) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Telefono` varchar(20) NOT NULL,
  `Parentesco` varchar(20) NOT NULL,
  `FK_ID_Tipo_Iden` int NOT NULL,
  `FK_ID_Persona` varchar(15) NOT NULL,
  `FK_ID_Genero` int NOT NULL,
  `FK_ID_Grupo_Preferencial` int NOT NULL,
  `FK_ID_Estrato` int NOT NULL,
  `FK_ID_Localidad` int NOT NULL,
  `Estado_Datos_Adicionales` enum('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Datos_Adicionales`),
  UNIQUE KEY `Email` (`Email`),
  UNIQUE KEY `Telefono` (`Telefono`),
  KEY `FK_DatosAd_Identificacion` (`FK_ID_Tipo_Iden`),
  KEY `FK_DatosAd_Persona` (`FK_ID_Persona`),
  KEY `FK_DatosAd_Genero` (`FK_ID_Genero`),
  KEY `FK_DatosAd_GP` (`FK_ID_Grupo_Preferencial`),
  KEY `FK_DatosAd_Estrato` (`FK_ID_Estrato`),
  KEY `FK_DatosAd_Localidad` (`FK_ID_Localidad`),
  CONSTRAINT `FK_DatosAd_Estrato` FOREIGN KEY (`FK_ID_Estrato`) REFERENCES `tbl_estrato` (`ID_Estrato`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DatosAd_Genero` FOREIGN KEY (`FK_ID_Genero`) REFERENCES `tbl_genero` (`ID_Genero`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DatosAd_GP` FOREIGN KEY (`FK_ID_Grupo_Preferencial`) REFERENCES `tbl_grupo_preferencial` (`ID_Grupo_Preferencial`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DatosAd_Identificacion` FOREIGN KEY (`FK_ID_Tipo_Iden`) REFERENCES `tbl_tipo_identificacion` (`ID_Tipo_Iden`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DatosAd_Localidad` FOREIGN KEY (`FK_ID_Localidad`) REFERENCES `tbl_localidad` (`ID_Localidad`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DatosAd_Persona` FOREIGN KEY (`FK_ID_Persona`) REFERENCES `tbl_persona` (`ID_Persona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_datos_adicionales`
--

LOCK TABLES `tbl_datos_adicionales` WRITE;
/*!40000 ALTER TABLE `tbl_datos_adicionales` DISABLE KEYS */;
INSERT INTO `tbl_datos_adicionales` VALUES ('D1019652358','daniel@gmail.com','3004506985','Padre',1,'1019652358',1,1,1,1,'ACTIVE'),('D1019762928','edcaicedoc@sanmateo.edu.co','3213397085','hermano',1,'1019762928',1,1,1,1,'ACTIVE'),('D1268945650','admin@panyfrut.com','3213397584','padre',1,'1268945650',1,1,1,1,'ACTIVE'),('D54269712','lanarvaezt@sanmateo.edu.co','3004305068','tutor',1,'54269712',1,1,1,1,'ACTIVE'),('D54269719','danicaicedo2005@gmail.com','3004305099','abuelo',1,'54269719',1,1,1,1,'ACTIVE');
/*!40000 ALTER TABLE `tbl_datos_adicionales` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_documento_ticket`
--

DROP TABLE IF EXISTS `tbl_documento_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_documento_ticket` (
  `ID_Doc_Ticket` int NOT NULL AUTO_INCREMENT,
  `FK_ID_Ticket` varchar(10) NOT NULL,
  `FK_ID_Tipo_Doc` int NOT NULL,
  `Archivo` mediumblob NOT NULL,
  `Nombre_Original` varchar(100) NOT NULL,
  `Fecha_Subida` datetime DEFAULT CURRENT_TIMESTAMP,
  `Estado_Documentos` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Doc_Ticket`),
  KEY `FK_DocumentoTicket_Ticket` (`FK_ID_Ticket`),
  KEY `FK_DocumentoTicket_TipoDoc` (`FK_ID_Tipo_Doc`),
  CONSTRAINT `FK_DocumentoTicket_Ticket` FOREIGN KEY (`FK_ID_Ticket`) REFERENCES `tbl_ticket` (`ID_Ticket`) ON UPDATE CASCADE,
  CONSTRAINT `FK_DocumentoTicket_TipoDoc` FOREIGN KEY (`FK_ID_Tipo_Doc`) REFERENCES `tbl_tipo_documento` (`ID_Tipo_Doc`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_documento_ticket`
--

LOCK TABLES `tbl_documento_ticket` WRITE;
/*!40000 ALTER TABLE `tbl_documento_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_documento_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_estado_ticket`
--

DROP TABLE IF EXISTS `tbl_estado_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_estado_ticket` (
  `ID_Estado_Ticket` int NOT NULL AUTO_INCREMENT,
  `Nombre_Estado` varchar(50) NOT NULL,
  `Estado_Final` tinyint(1) NOT NULL,
  `Estado_Estado_Ticket` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Estado_Ticket`),
  UNIQUE KEY `Nombre_Estado` (`Nombre_Estado`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_estado_ticket`
--

LOCK TABLES `tbl_estado_ticket` WRITE;
/*!40000 ALTER TABLE `tbl_estado_ticket` DISABLE KEYS */;
INSERT INTO `tbl_estado_ticket` VALUES (1,'Abierto',0,'ACTIVE'),(2,'En Proceso',0,'ACTIVE'),(3,'Resuelto',1,'ACTIVE'),(4,'Cerrado',1,'ACTIVE');
/*!40000 ALTER TABLE `tbl_estado_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_estrato`
--

DROP TABLE IF EXISTS `tbl_estrato`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_estrato` (
  `ID_Estrato` int NOT NULL AUTO_INCREMENT,
  `Numero_Estrato` int NOT NULL,
  `Nivel_Prioridad_E` tinyint NOT NULL,
  `Estado_Estrato` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Estrato`),
  UNIQUE KEY `Numero_Estrato` (`Numero_Estrato`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_estrato`
--

LOCK TABLES `tbl_estrato` WRITE;
/*!40000 ALTER TABLE `tbl_estrato` DISABLE KEYS */;
INSERT INTO `tbl_estrato` VALUES (1,1,1,'ACTIVE'),(2,2,2,'ACTIVE'),(3,3,3,'ACTIVE'),(4,4,4,'ACTIVE'),(5,5,5,'ACTIVE'),(6,6,6,'ACTIVE');
/*!40000 ALTER TABLE `tbl_estrato` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_estudiante`
--

DROP TABLE IF EXISTS `tbl_estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_estudiante` (
  `ID_Estudiante` int NOT NULL AUTO_INCREMENT,
  `FK_ID_Persona` varchar(15) NOT NULL,
  `FK_ID_Grado` int NOT NULL,
  `FK_ID_Acudiente` varchar(15) NOT NULL,
  `Parentesco` varchar(10) DEFAULT NULL,
  `Estado_Colegio` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Estudiante`),
  KEY `FK_Estudiante_Persona` (`FK_ID_Persona`),
  KEY `FK_Estudiante_Grado` (`FK_ID_Grado`),
  KEY `FK_Estudiante_Acudiente` (`FK_ID_Acudiente`),
  CONSTRAINT `FK_Estudiante_Acudiente` FOREIGN KEY (`FK_ID_Acudiente`) REFERENCES `tbl_persona` (`ID_Persona`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Estudiante_Grado` FOREIGN KEY (`FK_ID_Grado`) REFERENCES `tbl_grado` (`ID_Grado`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Estudiante_Persona` FOREIGN KEY (`FK_ID_Persona`) REFERENCES `tbl_persona` (`ID_Persona`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_estudiante`
--

LOCK TABLES `tbl_estudiante` WRITE;
/*!40000 ALTER TABLE `tbl_estudiante` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_genero`
--

DROP TABLE IF EXISTS `tbl_genero`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_genero` (
  `ID_Genero` int NOT NULL AUTO_INCREMENT,
  `Nombre_Genero` varchar(30) NOT NULL,
  `Estado_Genero` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Genero`),
  UNIQUE KEY `Nombre_Genero` (`Nombre_Genero`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_genero`
--

LOCK TABLES `tbl_genero` WRITE;
/*!40000 ALTER TABLE `tbl_genero` DISABLE KEYS */;
INSERT INTO `tbl_genero` VALUES (1,'Masculino','ACTIVE'),(2,'Femenino','ACTIVE'),(3,'No Binario','ACTIVE');
/*!40000 ALTER TABLE `tbl_genero` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_grado`
--

DROP TABLE IF EXISTS `tbl_grado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_grado` (
  `ID_Grado` int NOT NULL AUTO_INCREMENT,
  `Nombre_Grado` varchar(30) NOT NULL,
  `Nivel_Educativo` varchar(30) NOT NULL,
  `Estado_Grado` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Grado`),
  UNIQUE KEY `Nombre_Grado` (`Nombre_Grado`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_grado`
--

LOCK TABLES `tbl_grado` WRITE;
/*!40000 ALTER TABLE `tbl_grado` DISABLE KEYS */;
INSERT INTO `tbl_grado` VALUES (1,'Primero','Primaria','ACTIVE'),(2,'Segundo','Primaria','ACTIVE'),(3,'Tercero','Primaria','ACTIVE'),(4,'Sexto','Secundaria','ACTIVE'),(5,'Decimo','Media','ACTIVE');
/*!40000 ALTER TABLE `tbl_grado` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_grupo_preferencial`
--

DROP TABLE IF EXISTS `tbl_grupo_preferencial`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_grupo_preferencial` (
  `ID_Grupo_Preferencial` int NOT NULL AUTO_INCREMENT,
  `Nombre_Grupo_Preferencial` varchar(100) NOT NULL,
  `Nivel_Prioridad_GP` tinyint NOT NULL,
  `Estado_Grupo_Preferencial` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Grupo_Preferencial`),
  UNIQUE KEY `Nombre_Grupo_Preferencial` (`Nombre_Grupo_Preferencial`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_grupo_preferencial`
--

LOCK TABLES `tbl_grupo_preferencial` WRITE;
/*!40000 ALTER TABLE `tbl_grupo_preferencial` DISABLE KEYS */;
INSERT INTO `tbl_grupo_preferencial` VALUES (1,'Victima del conflicto',1,'ACTIVE'),(2,'Discapacidad',2,'ACTIVE'),(3,'Desplazado',3,'ACTIVE'),(4,'Ninguno',5,'ACTIVE');
/*!40000 ALTER TABLE `tbl_grupo_preferencial` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_localidad`
--

DROP TABLE IF EXISTS `tbl_localidad`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_localidad` (
  `ID_Localidad` int NOT NULL AUTO_INCREMENT,
  `Nombre_Localidad` varchar(30) NOT NULL,
  `Estado_Localidad` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Localidad`),
  UNIQUE KEY `Nombre_Localidad` (`Nombre_Localidad`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_localidad`
--

LOCK TABLES `tbl_localidad` WRITE;
/*!40000 ALTER TABLE `tbl_localidad` DISABLE KEYS */;
INSERT INTO `tbl_localidad` VALUES (1,'Engativ√°','ACTIVE');
/*!40000 ALTER TABLE `tbl_localidad` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_persona`
--

DROP TABLE IF EXISTS `tbl_persona`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_persona` (
  `ID_Persona` varchar(15) NOT NULL,
  `Primer_Nombre` varchar(50) NOT NULL,
  `Segundo_Nombre` varchar(50) DEFAULT NULL,
  `Primer_Apellido` varchar(50) NOT NULL,
  `Segundo_Apellido` varchar(50) DEFAULT NULL,
  `Fecha_Nacimiento` date NOT NULL,
  `Estado_Persona` enum('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Persona`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_persona`
--

LOCK TABLES `tbl_persona` WRITE;
/*!40000 ALTER TABLE `tbl_persona` DISABLE KEYS */;
INSERT INTO `tbl_persona` VALUES ('1019652358','Daniel','Esteban','Pinto','Nu√±ez','2000-01-01','ACTIVE'),('1019762928','Emerson','Daniel','Caicedo','Cobos','2000-01-01','ACTIVE'),('1268945650','Dan','Den','Din','Don','2000-01-01','ACTIVE'),('54269712','Luis','Alejandro','Narvaez','Talavera','2000-01-01','ACTIVE'),('54269719','User','User1','User2','User3','2000-01-01','ACTIVE');
/*!40000 ALTER TABLE `tbl_persona` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_rol`
--

DROP TABLE IF EXISTS `tbl_rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_rol` (
  `ID_Rol` int NOT NULL AUTO_INCREMENT,
  `Nombre_Rol` varchar(50) NOT NULL,
  `Descripcion_Rol` varchar(150) NOT NULL,
  `Estado_Rol` enum('ACTIVE','BLOCKED','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Rol`),
  UNIQUE KEY `Nombre_Rol` (`Nombre_Rol`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_rol`
--

LOCK TABLES `tbl_rol` WRITE;
/*!40000 ALTER TABLE `tbl_rol` DISABLE KEYS */;
INSERT INTO `tbl_rol` VALUES (1,'Estudiante','Persona por la cual se creara el ticket','ACTIVE'),(2,'Acudiente','Persona encargada de registrar estudiantes y la creaci√≥n de sus respectivos ticktes','ACTIVE'),(3,'Tecnico','Resolvera tickets','ACTIVE'),(4,'Admin','Encargado de la pagina','ACTIVE');
/*!40000 ALTER TABLE `tbl_rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_sesiones`
--

DROP TABLE IF EXISTS `tbl_sesiones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_sesiones` (
  `ID_Sesion` bigint NOT NULL AUTO_INCREMENT,
  `IP_Usuario` varchar(50) NOT NULL,
  `Tiempo_Acceso` datetime DEFAULT CURRENT_TIMESTAMP,
  `Tiempo_Cierre` datetime NOT NULL,
  `FK_ID_Usuario` varchar(16) NOT NULL,
  `Estado_Sesiones` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Sesion`),
  KEY `FK_Sesiones_Usuario` (`FK_ID_Usuario`),
  CONSTRAINT `FK_Sesiones_Usuario` FOREIGN KEY (`FK_ID_Usuario`) REFERENCES `tbl_usuario` (`ID_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_sesiones`
--

LOCK TABLES `tbl_sesiones` WRITE;
/*!40000 ALTER TABLE `tbl_sesiones` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_sesiones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ticket`
--

DROP TABLE IF EXISTS `tbl_ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ticket` (
  `ID_Ticket` varchar(10) NOT NULL,
  `Titulo_Ticket` varchar(150) NOT NULL,
  `Descripcion_Ticket` text NOT NULL,
  `Fecha_Creacion` datetime DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Cierre` datetime DEFAULT NULL,
  `Puntaje_Prioridad` int NOT NULL,
  `FK_ID_Usuario_Creador` varchar(16) NOT NULL,
  `FK_ID_Usuario_Tecnico` varchar(16) DEFAULT NULL,
  `FK_ID_Estado_Ticket` int NOT NULL,
  `FK_ID_Tipo_Caso` int NOT NULL,
  `FK_ID_Barrio` int NOT NULL,
  `Tiempo_Residencia` varchar(20) DEFAULT NULL,
  `Estado_Ticket` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Ticket`),
  KEY `FK_Ticket_UsuarioCreador` (`FK_ID_Usuario_Creador`),
  KEY `FK_Ticket_UsuarioTecnico` (`FK_ID_Usuario_Tecnico`),
  KEY `FK_Ticket_Estado` (`FK_ID_Estado_Ticket`),
  KEY `FK_Ticket_Barrio` (`FK_ID_Barrio`),
  CONSTRAINT `FK_Ticket_Barrio` FOREIGN KEY (`FK_ID_Barrio`) REFERENCES `tbl_barrio` (`ID_Barrio`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Ticket_Estado` FOREIGN KEY (`FK_ID_Estado_Ticket`) REFERENCES `tbl_estado_ticket` (`ID_Estado_Ticket`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Ticket_UsuarioCreador` FOREIGN KEY (`FK_ID_Usuario_Creador`) REFERENCES `tbl_usuario` (`ID_Usuario`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Ticket_UsuarioTecnico` FOREIGN KEY (`FK_ID_Usuario_Tecnico`) REFERENCES `tbl_usuario` (`ID_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ticket`
--

LOCK TABLES `tbl_ticket` WRITE;
/*!40000 ALTER TABLE `tbl_ticket` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_ticket_comentario`
--

DROP TABLE IF EXISTS `tbl_ticket_comentario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_ticket_comentario` (
  `ID_Ticket_Comentario` int NOT NULL AUTO_INCREMENT,
  `Comentario` text NOT NULL,
  `Fecha_Comentario` datetime NOT NULL,
  `Fecha_Creacion` datetime NOT NULL,
  `Es_Interno` tinyint(1) NOT NULL,
  `FK_ID_Usuario` varchar(16) NOT NULL,
  `FK_ID_Ticket` varchar(10) NOT NULL,
  `Estado_Comentario_Ticket` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Ticket_Comentario`),
  KEY `FK_TicketComentario_Usuario` (`FK_ID_Usuario`),
  KEY `FK_TicketComentario_Ticket` (`FK_ID_Ticket`),
  CONSTRAINT `FK_TicketComentario_Ticket` FOREIGN KEY (`FK_ID_Ticket`) REFERENCES `tbl_ticket` (`ID_Ticket`) ON UPDATE CASCADE,
  CONSTRAINT `FK_TicketComentario_Usuario` FOREIGN KEY (`FK_ID_Usuario`) REFERENCES `tbl_usuario` (`ID_Usuario`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_ticket_comentario`
--

LOCK TABLES `tbl_ticket_comentario` WRITE;
/*!40000 ALTER TABLE `tbl_ticket_comentario` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_ticket_comentario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_afectacion`
--

DROP TABLE IF EXISTS `tbl_tipo_afectacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_afectacion` (
  `ID_Tipo_Afectacion` int NOT NULL AUTO_INCREMENT,
  `Afectacion` varchar(100) NOT NULL,
  `Nivel_Prioridad_TC` tinyint NOT NULL,
  `Estado_Afectacion` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Tipo_Afectacion`),
  UNIQUE KEY `Afectacion` (`Afectacion`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_afectacion`
--

LOCK TABLES `tbl_tipo_afectacion` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_afectacion` DISABLE KEYS */;
INSERT INTO `tbl_tipo_afectacion` VALUES (1,'Problema de inscripcion',1,'ACTIVE'),(2,'Solicitud de traslado',2,'ACTIVE'),(3,'Error en sistema',3,'ACTIVE'),(4,'Consulta general',5,'ACTIVE');
/*!40000 ALTER TABLE `tbl_tipo_afectacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_documento`
--

DROP TABLE IF EXISTS `tbl_tipo_documento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_documento` (
  `ID_Tipo_Doc` int NOT NULL AUTO_INCREMENT,
  `Nombre_Tipo_Doc` varchar(30) NOT NULL,
  `Estado_Documentos` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Tipo_Doc`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_documento`
--

LOCK TABLES `tbl_tipo_documento` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_documento` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbl_tipo_documento` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_tipo_identificacion`
--

DROP TABLE IF EXISTS `tbl_tipo_identificacion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_tipo_identificacion` (
  `ID_Tipo_Iden` int NOT NULL AUTO_INCREMENT,
  `Nombre_Tipo_Iden` varchar(30) NOT NULL,
  `Estado_Identificacion` enum('ACTIVE','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Tipo_Iden`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_tipo_identificacion`
--

LOCK TABLES `tbl_tipo_identificacion` WRITE;
/*!40000 ALTER TABLE `tbl_tipo_identificacion` DISABLE KEYS */;
INSERT INTO `tbl_tipo_identificacion` VALUES (1,'Cedula de Ciudadania','ACTIVE'),(2,'Cedula de Extranjeria','ACTIVE'),(3,'Tarjeta de Identidad','ACTIVE'),(4,'Registro Civil','ACTIVE');
/*!40000 ALTER TABLE `tbl_tipo_identificacion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbl_usuario`
--

DROP TABLE IF EXISTS `tbl_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbl_usuario` (
  `ID_Usuario` varchar(16) NOT NULL,
  `Nombre_Usuario` varchar(50) NOT NULL,
  `Password_Salt` varbinary(16) NOT NULL,
  `Contrase√±a_Hash` varbinary(32) NOT NULL,
  `Ultimo_Login` datetime DEFAULT NULL,
  `Intentos_Fallidos` int DEFAULT NULL,
  `Fecha_Creacion` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Doble_Factor_Activo` enum('ACTIVE','INACTIVE') DEFAULT 'INACTIVE',
  `Aceptacion_Terminos` tinyint DEFAULT NULL,
  `FK_ID_Persona` varchar(15) NOT NULL,
  `FK_ID_Rol` int NOT NULL,
  `Estado_Usuario` enum('ACTIVE','BLOCK','INACTIVE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`ID_Usuario`),
  UNIQUE KEY `Nombre_Usuario` (`Nombre_Usuario`),
  KEY `FK_Usuario_Persona` (`FK_ID_Persona`),
  KEY `FK_Usuario_Rol` (`FK_ID_Rol`),
  CONSTRAINT `FK_Usuario_Persona` FOREIGN KEY (`FK_ID_Persona`) REFERENCES `tbl_persona` (`ID_Persona`) ON UPDATE CASCADE,
  CONSTRAINT `FK_Usuario_Rol` FOREIGN KEY (`FK_ID_Rol`) REFERENCES `tbl_rol` (`ID_Rol`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbl_usuario`
--

LOCK TABLES `tbl_usuario` WRITE;
/*!40000 ALTER TABLE `tbl_usuario` DISABLE KEYS */;
INSERT INTO `tbl_usuario` VALUES ('U1019652358','Esteban Pinto',_binary '0x89504E47',_binary '0x89504E470D0A1A0A000000',NULL,NULL,'2026-03-21 03:25:23','INACTIVE',1,'1019652358',2,'ACTIVE'),('U1019762928','edcaicedoc@sanmateo.edu.co',_binary 'K>2µ\Ê4Ñ|	¶ÒÙ0\r',_binary 'ó	õ\Ë?§\„\’nõê9Ç:aÛ3©\÷Ué•sS∏∑',NULL,8,'2026-03-23 21:05:25','INACTIVE',1,'1019762928',2,'ACTIVE'),('U1268945650','admin@panyfrut.com',_binary '{ÿúÄ^N@>\ﬁ^Æ\ V˚\Ÿ',_binary '0+≤ìß\·≠Y\„\›\Ô\«\…#\r\Â˛ÆFV(\„I˚1\Î\Í\Ìπ',NULL,NULL,'2026-03-21 04:17:30','INACTIVE',1,'1268945650',2,'ACTIVE'),('U54269712','lanarvaezt@sanmateo.edu.co',_binary 'Fòx\ŸÚXî\Èˇ˜,l ¢π',_binary '\‰åm\‘a˜\«\À\\S0$¸Æ\…:!TN≥\…\œ\'ço/ü\ﬂrç',NULL,NULL,'2026-03-25 02:57:39','INACTIVE',1,'54269712',2,'ACTIVE'),('U54269719','danicaicedo2005@gmail.com',_binary 'õj4\⁄˝ôNY\…)˙\Â›á',_binary 'di\Ô\Zµ@˝\“±Æ\”DoÜ\Ë?¢{§l\ÁI3fmù','2026-03-26 03:26:09',0,'2026-03-26 03:25:50','INACTIVE',1,'54269719',2,'ACTIVE');
/*!40000 ALTER TABLE `tbl_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'fortress_educa_db'
--

--
-- Dumping routines for database 'fortress_educa_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `sp_auditoria_sesion` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_auditoria_sesion`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_auditoria_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_auditoria_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_auditoria_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_auditoria_consultar`()
BEGIN
    SELECT *
    FROM tbl_auditoria
    WHERE Estado_Auditoria = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_auditoria_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_auditoria_consultar_id`(
    IN p_ID_Auditoria BIGINT
)
BEGIN
    SELECT *
    FROM tbl_auditoria
    WHERE ID_Auditoria = p_ID_Auditoria
    AND Estado_Auditoria = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_auditoria_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_auditoria_eliminar`(
    IN p_ID_Auditoria BIGINT
)
BEGIN
    UPDATE tbl_auditoria
    SET Estado_Auditoria = 'INACTIVE'
    WHERE ID_Auditoria = p_ID_Auditoria;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_auditoria_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_auditoria_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_barrio_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_barrio_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_barrio_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_barrio_consultar`()
BEGIN
    SELECT *
    FROM tbl_barrio
    WHERE Estado_Barrio = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_barrio_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_barrio_consultar_id`(
    IN p_ID_Barrio INT
)
BEGIN
    SELECT *
    FROM tbl_barrio
    WHERE ID_Barrio = p_ID_Barrio
    AND Estado_Barrio = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_barrio_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_barrio_eliminar`(
    IN p_ID_Barrio INT
)
BEGIN
    UPDATE tbl_barrio
    SET Estado_Barrio = 'INACTIVE'
    WHERE ID_Barrio = p_ID_Barrio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_barrio_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_barrio_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_barrio_por_localidad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_barrio_por_localidad`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_colegio_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_colegio_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_colegio_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_colegio_consultar`()
BEGIN
    SELECT *
    FROM tbl_colegio
    WHERE Estado_Colegio = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_colegio_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_colegio_consultar_id`(
    IN p_ID_Colegio INT
)
BEGIN
    SELECT *
    FROM tbl_colegio
    WHERE ID_Colegio = p_ID_Colegio
    AND Estado_Colegio = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_colegio_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_colegio_eliminar`(
    IN p_ID_Colegio INT
)
BEGIN
    UPDATE tbl_colegio
    SET Estado_Colegio = 'INACTIVE'
    WHERE ID_Colegio = p_ID_Colegio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_colegio_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_colegio_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_cupos_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_cupos_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_cupos_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_cupos_consultar`()
BEGIN
    SELECT *
    FROM tbl_cupos
    WHERE Estado_Cupos = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_cupos_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_cupos_consultar_id`(
    IN p_ID_Cupos INT
)
BEGIN
    SELECT *
    FROM tbl_cupos
    WHERE ID_Cupos = p_ID_Cupos
    AND Estado_Cupos = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_cupos_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_cupos_eliminar`(
    IN p_ID_Cupos INT
)
BEGIN
    UPDATE tbl_cupos
    SET Estado_Cupos = 'INACTIVE'
    WHERE ID_Cupos = p_ID_Cupos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_cupos_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_cupos_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_datos_adicionales_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_datos_adicionales_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_datos_adicionales_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_datos_adicionales_consultar`()
BEGIN
    SELECT *
    FROM tbl_datos_adicionales
    WHERE Estado_Datos_Adicionales = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_datos_adicionales_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_datos_adicionales_consultar_id`(
    IN p_ID_Datos_Adicionales VARCHAR(16)
)
BEGIN
    SELECT *
    FROM tbl_datos_adicionales
    WHERE ID_Datos_Adicionales = p_ID_Datos_Adicionales
    AND Estado_Datos_Adicionales = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_datos_adicionales_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_datos_adicionales_eliminar`(
    IN p_ID_Datos_Adicionales VARCHAR(16)
)
BEGIN
    UPDATE tbl_datos_adicionales
    SET Estado_Datos_Adicionales = 'INACTIVE'
    WHERE ID_Datos_Adicionales = p_ID_Datos_Adicionales;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_datos_adicionales_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_datos_adicionales_insertar`(

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_documento_ticket_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_documento_ticket_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_documento_ticket_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_documento_ticket_consultar`()
BEGIN
    SELECT ID_Doc_Ticket, FK_ID_Ticket, FK_ID_Tipo_Doc, Nombre_Original, Fecha_Subida, Estado_Documentos
    FROM tbl_documento_ticket
    WHERE Estado_Documentos = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_documento_ticket_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_documento_ticket_consultar_id`(
    IN p_ID_Doc_Ticket INT
)
BEGIN
    SELECT *
    FROM tbl_documento_ticket
    WHERE ID_Doc_Ticket = p_ID_Doc_Ticket
    AND Estado_Documentos = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_documento_ticket_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_documento_ticket_eliminar`(
    IN p_ID_Doc_Ticket INT
)
BEGIN
    UPDATE tbl_documento_ticket
    SET Estado_Documentos = 'INACTIVE'
    WHERE ID_Doc_Ticket = p_ID_Doc_Ticket;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_documento_ticket_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_documento_ticket_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estado_ticket_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estado_ticket_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estado_ticket_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estado_ticket_consultar`()
BEGIN
    SELECT 
        ID_Estado_Ticket, 
        Nombre_Estado, 
        Estado_Final, 
        Estado_Estado_Ticket
    FROM tbl_estado_ticket
    WHERE Estado_Estado_Ticket = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estado_ticket_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estado_ticket_consultar_id`(
    IN p_ID_Estado_Ticket INT
)
BEGIN
    SELECT *
    FROM tbl_estado_ticket
    WHERE ID_Estado_Ticket = p_ID_Estado_Ticket
    AND Estado_Estado_Ticket = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estado_ticket_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estado_ticket_eliminar`(
    IN p_ID_Estado_Ticket INT
)
BEGIN
    UPDATE tbl_estado_ticket
    SET Estado_Estado_Ticket = 'INACTIVE'
    WHERE ID_Estado_Ticket = p_ID_Estado_Ticket;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estado_ticket_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estado_ticket_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estrato_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estrato_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estrato_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estrato_consultar`()
BEGIN
    SELECT 
        ID_Estrato, 
        Numero_Estrato, 
        Nivel_Prioridad_E, 
        Estado_Estrato
    FROM tbl_estrato
    WHERE Estado_Estrato = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estrato_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estrato_consultar_id`(
    IN p_ID_Estrato INT
)
BEGIN
    SELECT *
    FROM tbl_estrato
    WHERE ID_Estrato = p_ID_Estrato
    AND Estado_Estrato = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estrato_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estrato_eliminar`(
    IN p_ID_Estrato INT
)
BEGIN
    UPDATE tbl_estrato
    SET Estado_Estrato = 'INACTIVE'
    WHERE ID_Estrato = p_ID_Estrato;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estrato_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estrato_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estudiante_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estudiante_actualizar`(
    IN p_ID_Estudiante INT,
    IN p_FK_ID_Persona VARCHAR(15),
    IN p_FK_ID_Grado INT,
    IN p_FK_ID_Acudiente VARCHAR(15),
    IN p_Parentesco VARCHAR(10)
)
BEGIN
    UPDATE tbl_estudiante
    SET FK_ID_Persona = p_FK_ID_Persona,
        FK_ID_Grado = p_FK_ID_Grado,
        FK_ID_Acudiente = p_FK_ID_Acudiente,
        Parentesco = p_Parentesco
    WHERE ID_Estudiante = p_ID_Estudiante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estudiante_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estudiante_consultar`()
BEGIN
    SELECT * FROM tbl_estudiante WHERE Estado_Colegio = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estudiante_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estudiante_consultar_id`(
    IN p_ID_Estudiante INT
)
BEGIN
    SELECT * FROM tbl_estudiante 
    WHERE ID_Estudiante = p_ID_Estudiante AND Estado_Colegio = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estudiante_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estudiante_eliminar`(
    IN p_ID_Estudiante INT
)
BEGIN
    UPDATE tbl_estudiante SET Estado_Colegio = 'INACTIVE' WHERE ID_Estudiante = p_ID_Estudiante;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_estudiante_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_estudiante_insertar`(
    IN p_FK_ID_Persona VARCHAR(15),
    IN p_FK_ID_Grado INT,
    IN p_FK_ID_Acudiente VARCHAR(15),
    IN p_Parentesco VARCHAR(10)
)
BEGIN
    INSERT INTO tbl_estudiante(
        FK_ID_Persona,
        FK_ID_Grado,
        FK_ID_Acudiente,
        Parentesco,
        Estado_Colegio
    )
    VALUES(
        p_FK_ID_Persona,
        p_FK_ID_Grado,
        p_FK_ID_Acudiente,
        p_Parentesco,
        'ACTIVE'
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_genero_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_genero_actualizar`(IN p_ID_Genero INT, IN p_Nombre_Genero VARCHAR(30))
BEGIN
    UPDATE tbl_genero SET Nombre_Genero = p_Nombre_Genero WHERE ID_Genero = p_ID_Genero;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_genero_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_genero_consultar`()
BEGIN
    SELECT * FROM tbl_genero WHERE Estado_Genero = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_genero_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_genero_consultar_id`(IN p_ID_Genero INT)
BEGIN
    SELECT * FROM tbl_genero WHERE ID_Genero = p_ID_Genero AND Estado_Genero = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_genero_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_genero_eliminar`(IN p_ID_Genero INT)
BEGIN
    UPDATE tbl_genero SET Estado_Genero = 'INACTIVE' WHERE ID_Genero = p_ID_Genero;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_genero_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_genero_insertar`(IN p_Nombre_Genero VARCHAR(30))
BEGIN
    INSERT INTO tbl_genero(Nombre_Genero, Estado_Genero) VALUES(p_Nombre_Genero, 'ACTIVE');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grado_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grado_actualizar`(
    IN p_ID_Grado INT,
    IN p_Nombre_Grado VARCHAR(30),
    IN p_Nivel_Educativo VARCHAR(30)
)
BEGIN
    UPDATE tbl_grado
    SET Nombre_Grado = p_Nombre_Grado,
        Nivel_Educativo = p_Nivel_Educativo
    WHERE ID_Grado = p_ID_Grado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grado_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grado_consultar`()
BEGIN
    SELECT * FROM tbl_grado WHERE Estado_Grado = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grado_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grado_consultar_id`(
    IN p_ID_Grado INT
)
BEGIN
    SELECT * FROM tbl_grado 
    WHERE ID_Grado = p_ID_Grado AND Estado_Grado = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grado_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grado_eliminar`(
    IN p_ID_Grado INT
)
BEGIN
    UPDATE tbl_grado SET Estado_Grado = 'INACTIVE' WHERE ID_Grado = p_ID_Grado;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grado_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grado_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grupo_preferencial_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grupo_preferencial_actualizar`(IN p_ID_Grupo_Preferencial INT, IN p_Nombre_Grupo_Preferencial VARCHAR(100), IN p_Nivel_Prioridad_GP TINYINT)
BEGIN
    UPDATE tbl_grupo_preferencial SET Nombre_Grupo_Preferencial = p_Nombre_Grupo_Preferencial, Nivel_Prioridad_GP = p_Nivel_Prioridad_GP 
    WHERE ID_Grupo_Preferencial = p_ID_Grupo_Preferencial;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grupo_preferencial_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grupo_preferencial_consultar`()
BEGIN
    SELECT * FROM tbl_grupo_preferencial WHERE Estado_Grupo_Preferencial = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grupo_preferencial_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grupo_preferencial_eliminar`(IN p_ID_Grupo_Preferencial INT)
BEGIN
    UPDATE tbl_grupo_preferencial SET Estado_Grupo_Preferencial = 'INACTIVE' WHERE ID_Grupo_Preferencial = p_ID_Grupo_Preferencial;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_grupo_preferencial_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_grupo_preferencial_insertar`(IN p_Nombre_Grupo_Preferencial VARCHAR(100), IN p_Nivel_Prioridad_GP TINYINT)
BEGIN
    INSERT INTO tbl_grupo_preferencial(Nombre_Grupo_Preferencial, Nivel_Prioridad_GP, Estado_Grupo_Preferencial) 
    VALUES(p_Nombre_Grupo_Preferencial, p_Nivel_Prioridad_GP, 'ACTIVE');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_localidad_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_localidad_consultar`()
BEGIN

SELECT
    ID_Localidad,
    Nombre_Localidad
FROM TBL_LOCALIDAD
WHERE Estado_Localidad = 'ACTIVE'
ORDER BY Nombre_Localidad;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_persona_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_persona_actualizar`(
    IN p_ID_Persona VARCHAR(15), 
    IN p_Primer_Nombre VARCHAR(50), 
    IN p_Segundo_Nombre VARCHAR(50), 
    IN p_Primer_Apellido VARCHAR(50), 
    IN p_Segundo_Apellido VARCHAR(50), 
    IN p_Fecha_Nacimiento DATE
)
BEGIN
    UPDATE tbl_persona SET Primer_Nombre = p_Primer_Nombre, Segundo_Nombre = p_Segundo_Nombre, Primer_Apellido = p_Primer_Apellido, Segundo_Apellido = p_Segundo_Apellido, Fecha_Nacimiento = p_Fecha_Nacimiento WHERE ID_Persona = p_ID_Persona;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_persona_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_persona_consultar`()
BEGIN
    SELECT * FROM tbl_persona WHERE Estado_Persona = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_persona_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_persona_eliminar`(IN p_ID_Persona VARCHAR(15))
BEGIN
    UPDATE tbl_persona SET Estado_Persona = 'INACTIVE' WHERE ID_Persona = p_ID_Persona;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_persona_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_persona_insertar`(
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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_rol_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_rol_actualizar`(
    IN p_ID_Rol INT,
    IN p_Nombre_Rol VARCHAR(50),
    IN p_Descripcion_Rol VARCHAR(150)
)
BEGIN
    UPDATE tbl_rol
    SET Nombre_Rol = p_Nombre_Rol,
        Descripcion_Rol = p_Descripcion_Rol
    WHERE ID_Rol = p_ID_Rol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_rol_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_rol_consultar`()
BEGIN
    SELECT * FROM tbl_rol 
    WHERE Estado_Rol = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_rol_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_rol_consultar_id`(
    IN p_ID_Rol INT
)
BEGIN
    SELECT * FROM tbl_rol 
    WHERE ID_Rol = p_ID_Rol 
    AND Estado_Rol = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_rol_consultar_nombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_rol_consultar_nombre`(
    IN p_Nombre_Rol VARCHAR(50)
)
BEGIN
    SELECT ID_Rol 
    FROM tbl_rol 
    WHERE Nombre_Rol = p_Nombre_Rol 
    AND Estado_Rol = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_rol_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_rol_eliminar`(
    IN p_ID_Rol INT
)
BEGIN
    UPDATE tbl_rol 
    SET Estado_Rol = 'INACTIVE' 
    WHERE ID_Rol = p_ID_Rol;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_rol_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_rol_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_sesiones_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_sesiones_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_sesiones_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_sesiones_consultar`()
BEGIN
    SELECT * FROM tbl_sesiones WHERE Estado_Sesiones = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_sesiones_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_sesiones_consultar_id`(
    IN p_ID_Sesion BIGINT
)
BEGIN
    SELECT * FROM tbl_sesiones 
    WHERE ID_Sesion = p_ID_Sesion 
    AND Estado_Sesiones = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_sesiones_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_sesiones_eliminar`(IN p_ID_Sesion BIGINT)
BEGIN
    UPDATE tbl_sesiones SET Estado_Sesiones = 'INACTIVE' WHERE ID_Sesion = p_ID_Sesion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_sesiones_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_sesiones_insertar`(IN p_IP_Usuario VARCHAR(50), IN p_FK_ID_Usuario VARCHAR(16))
BEGIN
    INSERT INTO tbl_sesiones(IP_Usuario, FK_ID_Usuario, Estado_Sesiones) VALUES(p_IP_Usuario, p_FK_ID_Usuario, 'ACTIVE');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_comentario_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_comentario_actualizar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_comentario_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_comentario_consultar`()
BEGIN
    SELECT * FROM tbl_ticket_comentario 
    WHERE Estado_Comentario_Ticket = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_comentario_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_comentario_consultar_id`(
    IN p_ID_Ticket_Comentario INT
)
BEGIN
    SELECT * FROM tbl_ticket_comentario 
    WHERE ID_Ticket_Comentario = p_ID_Ticket_Comentario 
    AND Estado_Comentario_Ticket = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_comentario_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_comentario_eliminar`(
    IN p_ID_Ticket_Comentario INT
)
BEGIN
    UPDATE tbl_ticket_comentario 
    SET Estado_Comentario_Ticket = 'INACTIVE' 
    WHERE ID_Ticket_Comentario = p_ID_Ticket_Comentario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_comentario_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_comentario_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_consultar`()
BEGIN
    SELECT * FROM tbl_ticket 
    WHERE Estado_Ticket = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_consultar_id`(
    IN p_ID_Ticket VARCHAR(10)
)
BEGIN
    SELECT * FROM tbl_ticket 
    WHERE ID_Ticket = p_ID_Ticket 
    AND Estado_Ticket = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_eliminar`(
    IN p_ID_Ticket VARCHAR(10)
)
BEGIN
    UPDATE tbl_ticket 
    SET Estado_Ticket = 'INACTIVE' 
    WHERE ID_Ticket = p_ID_Ticket;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_ticket_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_ticket_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_afectacion_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_afectacion_actualizar`(
    IN p_ID_Tipo_Afectacion INT,
    IN p_Afectacion VARCHAR(100),
    IN p_Nivel_Prioridad_TC TINYINT
)
BEGIN
    UPDATE tbl_tipo_afectacion
    SET Afectacion = p_Afectacion,
        Nivel_Prioridad_TC = p_Nivel_Prioridad_TC
    WHERE ID_Tipo_Afectacion = p_ID_Tipo_Afectacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_afectacion_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_afectacion_consultar`()
BEGIN
    SELECT * FROM tbl_tipo_afectacion 
    WHERE Estado_Afectacion = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_afectacion_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_afectacion_consultar_id`(
    IN p_ID_Tipo_Afectacion INT
)
BEGIN
    SELECT * FROM tbl_tipo_afectacion 
    WHERE ID_Tipo_Afectacion = p_ID_Tipo_Afectacion 
    AND Estado_Afectacion = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_afectacion_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_afectacion_eliminar`(
    IN p_ID_Tipo_Afectacion INT
)
BEGIN
    UPDATE tbl_tipo_afectacion 
    SET Estado_Afectacion = 'INACTIVE' 
    WHERE ID_Tipo_Afectacion = p_ID_Tipo_Afectacion;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_afectacion_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_afectacion_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_documento_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_documento_actualizar`(
    IN p_ID_Tipo_Doc INT,
    IN p_Nombre_Tipo_Doc VARCHAR(30)
)
BEGIN
    UPDATE tbl_tipo_documento
    SET Nombre_Tipo_Doc = p_Nombre_Tipo_Doc
    WHERE ID_Tipo_Doc = p_ID_Tipo_Doc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_documento_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_documento_consultar`()
BEGIN

SELECT 
    ID_Tipo_Documento,
    Nombre_Documento
FROM TBL_TIPO_DOCUMENTO
WHERE Estado_Documentos = 'ACTIVE'
ORDER BY Nombre_Documento;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_documento_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_documento_consultar_id`(
    IN p_ID_Tipo_Doc INT
)
BEGIN
    SELECT * FROM tbl_tipo_documento 
    WHERE ID_Tipo_Doc = p_ID_Tipo_Doc 
    AND Estado_Documentos = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_documento_consultar_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_documento_consultar_v2`()
BEGIN
    SELECT * FROM tbl_tipo_documento 
    WHERE Estado_Documentos = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_documento_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_documento_eliminar`(
    IN p_ID_Tipo_Doc INT
)
BEGIN
    UPDATE tbl_tipo_documento 
    SET Estado_Documentos = 'INACTIVE' 
    WHERE ID_Tipo_Doc = p_ID_Tipo_Doc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_documento_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_documento_insertar`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_tipo_identificacion_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_tipo_identificacion_consultar`()
BEGIN

SELECT 
    ID_Tipo_Iden,
    Nombre_Tipo_Iden
FROM TBL_TIPO_IDENTIFICACION
WHERE Estado_Identificacion = 'ACTIVE'
ORDER BY Nombre_Tipo_Iden;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_actualizar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_actualizar`(
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

UPDATE TBL_USUARIO
SET Nombre_Usuario = p_Nombre_Usuario,
    Password_Salt = v_salt,
    Contrase√±a_Hash = v_hash,
    Intentos_Fallidos = p_Intentos_Fallidos,
    Doble_Factor_Activo = p_Doble_Factor_Activo,
    Aceptacion_Terminos = p_Aceptacion_Terminos,
    FK_ID_Persona = p_FK_ID_Persona,
    FK_ID_Rol = p_FK_ID_Rol
WHERE ID_Usuario = p_ID_Usuario;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_consultar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_consultar`()
BEGIN
    SELECT * FROM tbl_usuario WHERE Estado_Usuario = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_consultar_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_consultar_id`(
    IN p_ID_Usuario VARCHAR(16)
)
BEGIN
    SELECT * FROM tbl_usuario WHERE ID_Usuario = p_ID_Usuario AND Estado_Usuario = 'ACTIVE';
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_eliminar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_eliminar`(
    IN p_ID_Usuario VARCHAR(16)
)
BEGIN
    UPDATE tbl_usuario SET Estado_Usuario = 'INACTIVE' WHERE ID_Usuario = p_ID_Usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_insertar` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_insertar`(

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
    Contrase√±a_Hash,

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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_insertar_v2` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_insertar_v2`(
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
    Contrase√±a_Hash,
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_insertar_v3` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_insertar_v3`(
    IN p_ID_Usuario VARCHAR(16),
    IN p_Nombre_Usuario VARCHAR(50),
    IN p_Contrase√±a_Hash VARCHAR(255),
    IN p_Intentos_Fallidos INT,
    IN p_Doble_Factor_Activo ENUM('ACTIVE','INACTIVE'),
    IN p_Aceptacion_Terminos TINYINT,
    IN p_FK_ID_Persona VARCHAR(15),
    IN p_FK_ID_Rol INT
)
BEGIN
    INSERT INTO tbl_usuario(
        ID_Usuario, Nombre_Usuario, Contrase√±a_Hash, Intentos_Fallidos, 
        Doble_Factor_Activo, Aceptacion_Terminos, FK_ID_Persona, FK_ID_Rol, Estado_Usuario
    )
    VALUES(
        p_ID_Usuario, p_Nombre_Usuario, p_Contrase√±a_Hash, p_Intentos_Fallidos, 
        p_Doble_Factor_Activo, p_Aceptacion_Terminos, p_FK_ID_Persona, p_FK_ID_Rol, 'ACTIVE'
    );
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_tbl_usuario_validar_login` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_tbl_usuario_validar_login`(
    IN p_nombre_usuario VARCHAR(50),
    IN p_password_hash VARBINARY(32)
)
BEGIN
    DECLARE v_id_usuario VARCHAR(16);
    DECLARE v_hash VARBINARY(32);
    DECLARE v_resultado VARCHAR(10);

    -- Obtener datos del usuario
    SELECT ID_Usuario, Contrase√±a_Hash
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
        
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_actualizar_contrasena` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_actualizar_contrasena`(
    IN p_username     VARCHAR(100),
    IN p_nuevo_hash   VARBINARY(32),
    IN p_nuevo_salt   VARBINARY(16)
)
BEGIN
    UPDATE TBL_USUARIO
    SET Contrase√±a_Hash = p_nuevo_hash,
        Password_Salt   = p_nuevo_salt
    WHERE Nombre_Usuario = p_username;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_bloquear` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_bloquear`(
    IN p_usuario VARCHAR(50)
)
BEGIN
    UPDATE TBL_USUARIO
    SET Estado_Usuario = 'BLOCK'
    WHERE Nombre_Usuario = p_usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_obtener_email` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_obtener_email`(
    IN p_Nombre_Usuario VARCHAR(50)
)
BEGIN
    SELECT DA.Email
    FROM TBL_USUARIO U
    INNER JOIN TBL_DATOS_ADICIONALES DA ON U.FK_ID_Persona = DA.FK_ID_Persona
    WHERE U.Nombre_Usuario = p_Nombre_Usuario 
      AND DA.Email = p_Nombre_Usuario;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_usuario_verificar_existente` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_usuario_verificar_existente`(

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

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_validar_data_user` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_unicode_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_validar_data_user`(
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
    INNER JOIN TBL_PERSONA p 
        ON u.FK_ID_Persona = p.ID_Persona

    WHERE u.Nombre_Usuario = p_nombre_usuario
      AND u.Estado_Usuario = 'ACTIVE'
      AND p.Estado_Persona = 'ACTIVE'

    LIMIT 1;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-03-27 16:08:48
