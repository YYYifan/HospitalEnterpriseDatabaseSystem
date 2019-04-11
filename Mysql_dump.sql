CREATE DATABASE  IF NOT EXISTS `hospitaldb` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `hospitaldb`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospitaldb
-- ------------------------------------------------------
-- Server version	5.6.39

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bed` (
  `BedID` int(11) NOT NULL AUTO_INCREMENT,
  `BedType` varchar(45) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `CcID` int(11) NOT NULL,
  `BID` int(11) NOT NULL,
  PRIMARY KEY (`BedID`,`RoomID`,`CcID`,`BID`),
  KEY `fk_Bed_Room1_idx` (`RoomID`,`CcID`,`BID`),
  CONSTRAINT `fk_Bed_Room1` FOREIGN KEY (`RoomID`, `CcID`, `BID`) REFERENCES `room` (`RoomID`, `CcID`, `BID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed`
--

LOCK TABLES `bed` WRITE;
/*!40000 ALTER TABLE `bed` DISABLE KEYS */;
INSERT INTO `bed` VALUES (1,'VIP',100,1,1),(1,'Nomal',101,1,1),(1,'Nomal',200,2,2),(2,'Nomal',101,1,1),(2,'Nomal',200,2,2);
/*!40000 ALTER TABLE `bed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `building`
--

DROP TABLE IF EXISTS `building`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `building` (
  `BID` int(11) NOT NULL AUTO_INCREMENT,
  `BuildingName` varchar(45) NOT NULL,
  PRIMARY KEY (`BID`),
  UNIQUE KEY `BID_UNIQUE` (`BID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `building`
--

LOCK TABLES `building` WRITE;
/*!40000 ALTER TABLE `building` DISABLE KEYS */;
INSERT INTO `building` VALUES (1,'South Building'),(2,'North Building');
/*!40000 ALTER TABLE `building` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carecenter`
--

DROP TABLE IF EXISTS `carecenter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carecenter` (
  `CcID` int(11) NOT NULL AUTO_INCREMENT,
  `CcName` varchar(45) NOT NULL,
  `BID` int(11) NOT NULL,
  `telephoneNumber` varchar(45) NOT NULL,
  PRIMARY KEY (`CcID`),
  UNIQUE KEY `CcID_UNIQUE` (`CcID`),
  KEY `fk_CareCenter_Building1_idx` (`BID`),
  CONSTRAINT `fk_CareCenter_Building1` FOREIGN KEY (`BID`) REFERENCES `building` (`BID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carecenter`
--

LOCK TABLES `carecenter` WRITE;
/*!40000 ALTER TABLE `carecenter` DISABLE KEYS */;
INSERT INTO `carecenter` VALUES (1,'internal medicine',1,'123-456-789'),(2,'surgery',2,'111-222-333');
/*!40000 ALTER TABLE `carecenter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carecenteremployee`
--

DROP TABLE IF EXISTS `carecenteremployee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carecenteremployee` (
  `EmpID` int(11) NOT NULL AUTO_INCREMENT,
  `LastName` varchar(45) NOT NULL,
  `FirstName` varchar(45) NOT NULL,
  `PhoneNumber` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  PRIMARY KEY (`EmpID`),
  UNIQUE KEY `EmpID_UNIQUE` (`EmpID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carecenteremployee`
--

LOCK TABLES `carecenteremployee` WRITE;
/*!40000 ALTER TABLE `carecenteremployee` DISABLE KEYS */;
INSERT INTO `carecenteremployee` VALUES (1,'Bob','Johns','987-654-321','111@hhh.com'),(2,'Kate','Smith','123-131-434','222@hhh.com'),(3,'Isebella','Muji','932-232-123','333@hhh.com');
/*!40000 ALTER TABLE `carecenteremployee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consumes`
--

DROP TABLE IF EXISTS `consumes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consumes` (
  `PatientID` int(11) NOT NULL,
  `ItemID` int(11) NOT NULL,
  `ConsumeDate` date NOT NULL,
  `Quantity` int(11) NOT NULL,
  `TotalPrice` double NOT NULL,
  PRIMARY KEY (`PatientID`,`ItemID`),
  KEY `fk_Patient_has_Items_Items1_idx` (`ItemID`),
  KEY `fk_Patient_has_Items_Patient1_idx` (`PatientID`),
  CONSTRAINT `fk_Patient_has_Items_Items1` FOREIGN KEY (`ItemID`) REFERENCES `items` (`ItemID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Patient_has_Items_Patient1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consumes`
--

LOCK TABLES `consumes` WRITE;
/*!40000 ALTER TABLE `consumes` DISABLE KEYS */;
INSERT INTO `consumes` VALUES (1,1,'2018-04-25',2,177.6),(1,2,'2018-04-25',2,201.8),(3,3,'2018-04-26',4,81.2),(4,5,'2018-04-27',1,330.4),(5,1,'2018-04-26',4,355.2),(5,2,'2018-04-26',1,100.9),(6,4,'2018-04-27',5,277.5);
/*!40000 ALTER TABLE `consumes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employs`
--

DROP TABLE IF EXISTS `employs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `employs` (
  `EmpID` int(11) NOT NULL,
  `CcID` int(11) NOT NULL,
  PRIMARY KEY (`EmpID`,`CcID`),
  KEY `fk_Employee_has_CareCenter_CareCenter1_idx` (`CcID`),
  KEY `fk_Employee_has_CareCenter_Employee_idx` (`EmpID`),
  CONSTRAINT `fk_Employee_has_CareCenter_CareCenter1` FOREIGN KEY (`CcID`) REFERENCES `carecenter` (`CcID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_has_CareCenter_Employee` FOREIGN KEY (`EmpID`) REFERENCES `carecenteremployee` (`EmpID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employs`
--

LOCK TABLES `employs` WRITE;
/*!40000 ALTER TABLE `employs` DISABLE KEYS */;
INSERT INTO `employs` VALUES (1,1),(2,1),(1,2),(3,2);
/*!40000 ALTER TABLE `employs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `items` (
  `ItemID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL,
  `ItemType` varchar(45) NOT NULL,
  `UnitPrice` double NOT NULL,
  PRIMARY KEY (`ItemID`),
  UNIQUE KEY `ItemID_UNIQUE` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES (1,'Anti-inflammatory','Oral',88.8),(2,'headache','Oral',100.9),(3,'cold','Oral',20.3),(4,'trauma','External',55.5),(5,'prevention','injection',330.4);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `outpatient`
--

DROP TABLE IF EXISTS `outpatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `outpatient` (
  `PatientID` int(11) NOT NULL,
  `CheckBackDate` date NOT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `fk_OutPatient_Patient1_idx` (`PatientID`),
  CONSTRAINT `fk_OutPatient_Patient1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `outpatient`
--

LOCK TABLES `outpatient` WRITE;
/*!40000 ALTER TABLE `outpatient` DISABLE KEYS */;
INSERT INTO `outpatient` VALUES (1,'2018-04-30'),(3,'2018-04-29'),(6,'2018-04-28'),(7,'0000-00-00');
/*!40000 ALTER TABLE `outpatient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `PatientID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  `ssn` varchar(45) NOT NULL,
  `address` varchar(45) NOT NULL,
  `AdmitDate` date NOT NULL,
  `PhyID` int(11) NOT NULL,
  `OutPatient` varchar(45) NOT NULL,
  `ResidentPatient` varchar(45) NOT NULL,
  PRIMARY KEY (`PatientID`),
  UNIQUE KEY `PatientID_UNIQUE` (`PatientID`),
  KEY `fk_Patient_Physician1_idx` (`PhyID`),
  CONSTRAINT `fk_Patient_Physician1` FOREIGN KEY (`PhyID`) REFERENCES `physician` (`PhyID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1,'Mujin','Zhang','123','Malden','2018-04-25',2,'Y','N'),(2,'haha','Smith','456','Boston','2018-04-26',1,'N','Y'),(3,'Bob','Brown','556','Washington','2018-04-26',3,'Y','N'),(4,'Mike','Davis','233','California','2018-04-27',2,'N','Y'),(5,'Jane','Smith','333','Malden','2018-04-26',4,'N','Y'),(6,'Fanny','Davis','666','Beijing','2018-04-27',3,'Y','N'),(7,'Fanny','Davis','666','Beijing','2018-04-27',3,'Y','N'),(8,'Fanny','Davis','666','Beijing','2018-04-27',3,'N','N'),(9,'Fanny','Davis','666','Beijing','2018-04-27',3,'N','Y'),(10,'Fanny','Davis','666','Beijing','2018-04-27',3,'N','Y');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hospitaldb`.`patient_AFTER_INSERT` AFTER INSERT ON `patient` FOR EACH ROW
BEGIN
if(new.OutPatient = 'Y')
then 
insert into outpatient(PatientID) values(new.PatientID);
end if;
if(new.ResidentPatient = 'Y')
then
insert into residentpatient(PatientID, BedID, RoomID, CcID, BID) values(new.PatientID, 1, 100, 1, 1);
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hospitaldb`.`patient_AFTER_UPDATE` AFTER UPDATE ON `patient` FOR EACH ROW
BEGIN
	insert into patient_log (username, patientID, oldname, newname)
    values (user(), old.PatientID, old.FirstName, new.FirstName);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hospitaldb`.`patient_BEFORE_DELETE` BEFORE DELETE ON `patient` FOR EACH ROW
BEGIN
	insert into patient_backup
    values (old.PatientID, old.FirstName, old.LastName, old.ssn, old.address, old.AdmitDate, old.PhyID, old.OutPatient, old.ResidentPatient);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hospitaldb`.`patient_AFTER_DELETE` AFTER DELETE ON `patient` FOR EACH ROW
BEGIN
insert into patient_deletedRecords values(user(), now(), old.patientID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `patient_backup`
--

DROP TABLE IF EXISTS `patient_backup`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_backup` (
  `patientid` int(11) NOT NULL,
  `patinetFname` varchar(45) NOT NULL,
  `patientLname` varchar(45) NOT NULL,
  `patientSsn` varchar(45) NOT NULL,
  `patientAddress` varchar(45) NOT NULL,
  `AdmitDate` date NOT NULL,
  `physicianID` int(11) NOT NULL,
  `OutPatient` varchar(45) NOT NULL,
  `ResidentPatient` varchar(45) NOT NULL,
  PRIMARY KEY (`patientid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_backup`
--

LOCK TABLES `patient_backup` WRITE;
/*!40000 ALTER TABLE `patient_backup` DISABLE KEYS */;
INSERT INTO `patient_backup` VALUES (9,'Fanny','Davis','666','Beijing','2018-04-27',3,'N','Y');
/*!40000 ALTER TABLE `patient_backup` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_deletedrecords`
--

DROP TABLE IF EXISTS `patient_deletedrecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_deletedrecords` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `Date` date NOT NULL,
  `patientID` int(11) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_deletedrecords`
--

LOCK TABLES `patient_deletedrecords` WRITE;
/*!40000 ALTER TABLE `patient_deletedrecords` DISABLE KEYS */;
/*!40000 ALTER TABLE `patient_deletedrecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient_log`
--

DROP TABLE IF EXISTS `patient_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient_log` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `patientID` int(11) DEFAULT NULL,
  `oldname` varchar(45) DEFAULT NULL,
  `newname` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient_log`
--

LOCK TABLES `patient_log` WRITE;
/*!40000 ALTER TABLE `patient_log` DISABLE KEYS */;
INSERT INTO `patient_log` VALUES (1,'root@localhost',2,'Kitty','haha'),(2,'root@localhost',1,'Yifan','Mujin');
/*!40000 ALTER TABLE `patient_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `physician`
--

DROP TABLE IF EXISTS `physician`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `physician` (
  `PhyID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(45) NOT NULL,
  `LastName` varchar(45) NOT NULL,
  PRIMARY KEY (`PhyID`),
  UNIQUE KEY `PhyID_UNIQUE` (`PhyID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `physician`
--

LOCK TABLES `physician` WRITE;
/*!40000 ALTER TABLE `physician` DISABLE KEYS */;
INSERT INTO `physician` VALUES (1,'Vanessa','Smith'),(2,'Alula','Zhang'),(3,'Yif','Liu'),(4,'Suibian','WUsuowei');
/*!40000 ALTER TABLE `physician` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `residentpatient`
--

DROP TABLE IF EXISTS `residentpatient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `residentpatient` (
  `PatientID` int(11) NOT NULL,
  `DischargedDate` date NOT NULL,
  `BedID` int(11) NOT NULL,
  `RoomID` int(11) NOT NULL,
  `CcID` int(11) NOT NULL,
  `BID` int(11) NOT NULL,
  PRIMARY KEY (`PatientID`),
  KEY `fk_ResidentPatient_Patient1_idx` (`PatientID`),
  KEY `fk_ResidentPatient_Bed1_idx` (`BedID`,`RoomID`,`CcID`,`BID`),
  CONSTRAINT `fk_ResidentPatient_Bed1` FOREIGN KEY (`BedID`, `RoomID`, `CcID`, `BID`) REFERENCES `bed` (`BedID`, `RoomID`, `CcID`, `BID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ResidentPatient_Patient1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `residentpatient`
--

LOCK TABLES `residentpatient` WRITE;
/*!40000 ALTER TABLE `residentpatient` DISABLE KEYS */;
INSERT INTO `residentpatient` VALUES (2,'2018-05-30',1,100,1,1),(4,'2018-06-10',2,101,1,1),(5,'2018-07-20',2,200,2,2),(10,'2018-08-20',1,100,1,1);
/*!40000 ALTER TABLE `residentpatient` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `hospitaldb`.`residentpatient_AFTER_DELETE` AFTER DELETE ON `residentpatient` FOR EACH ROW
BEGIN
insert into Resientpatient_deletedRecords values(user(), now(), old.patientID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `resientpatient_deletedrecords`
--

DROP TABLE IF EXISTS `resientpatient_deletedrecords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resientpatient_deletedrecords` (
  `UID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `Date` date NOT NULL,
  `patientID` int(11) NOT NULL,
  PRIMARY KEY (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resientpatient_deletedrecords`
--

LOCK TABLES `resientpatient_deletedrecords` WRITE;
/*!40000 ALTER TABLE `resientpatient_deletedrecords` DISABLE KEYS */;
INSERT INTO `resientpatient_deletedrecords` VALUES (1,'root@localhost','2018-04-26',10);
/*!40000 ALTER TABLE `resientpatient_deletedrecords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `room` (
  `RoomID` int(11) NOT NULL AUTO_INCREMENT,
  `NumOfBeds` int(11) NOT NULL,
  `CcID` int(11) NOT NULL,
  `BID` int(11) NOT NULL,
  PRIMARY KEY (`RoomID`,`CcID`,`BID`),
  UNIQUE KEY `RoomID_UNIQUE` (`RoomID`),
  KEY `fk_Room_CareCenter1_idx` (`CcID`),
  KEY `fk_Room_Building1_idx` (`BID`),
  CONSTRAINT `fk_Room_Building1` FOREIGN KEY (`BID`) REFERENCES `building` (`BID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Room_CareCenter1` FOREIGN KEY (`CcID`) REFERENCES `carecenter` (`CcID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=202 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (100,1,1,1),(101,2,1,1),(200,2,2,2),(201,8,2,2);
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treat`
--

DROP TABLE IF EXISTS `treat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treat` (
  `TreatID` int(11) NOT NULL,
  `PatientID` int(11) NOT NULL,
  `PhyID` int(11) NOT NULL,
  `Date` date NOT NULL,
  `Time` varchar(45) NOT NULL,
  `Result` varchar(45) NOT NULL,
  PRIMARY KEY (`TreatID`,`PatientID`,`PhyID`),
  KEY `fk_Treatment_has_Patient_Patient1_idx` (`PatientID`),
  KEY `fk_Treatment_has_Patient_Treatment1_idx` (`TreatID`),
  KEY `fk_Treat_Physician1_idx` (`PhyID`),
  CONSTRAINT `fk_Treat_Physician1` FOREIGN KEY (`PhyID`) REFERENCES `physician` (`PhyID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatment_has_Patient_Patient1` FOREIGN KEY (`PatientID`) REFERENCES `patient` (`PatientID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Treatment_has_Patient_Treatment1` FOREIGN KEY (`TreatID`) REFERENCES `treatment` (`TreatID`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treat`
--

LOCK TABLES `treat` WRITE;
/*!40000 ALTER TABLE `treat` DISABLE KEYS */;
INSERT INTO `treat` VALUES (1,1,2,'2018-04-25','13:00','Pending'),(1,6,3,'2018-04-27','22:00','Pending'),(2,1,2,'2018-04-25','14:00','Pending'),(2,2,1,'2018-04-26','13:00','Pending'),(2,3,3,'2018-04-26','8:00','Completed'),(3,4,2,'2018-04-27','10:00','Completed'),(3,5,4,'2018-04-26','8:00','Completed'),(4,5,4,'2018-04-27','18:00','Pending');
/*!40000 ALTER TABLE `treat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `treatment`
--

DROP TABLE IF EXISTS `treatment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `treatment` (
  `TreatID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(45) NOT NULL,
  PRIMARY KEY (`TreatID`),
  UNIQUE KEY `TreatmentID_UNIQUE` (`TreatID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `treatment`
--

LOCK TABLES `treatment` WRITE;
/*!40000 ALTER TABLE `treatment` DISABLE KEYS */;
INSERT INTO `treatment` VALUES (1,'Consultation'),(2,'Prescribetion'),(3,'Hospitalization'),(4,'Surgery');
/*!40000 ALTER TABLE `treatment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `view_carecenterinfo`
--

DROP TABLE IF EXISTS `view_carecenterinfo`;
/*!50001 DROP VIEW IF EXISTS `view_carecenterinfo`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_carecenterinfo` AS SELECT 
 1 AS `CcID`,
 1 AS `CcName`,
 1 AS `telephoneNumber`,
 1 AS `BuildingName`,
 1 AS `employeeFirstName`,
 1 AS `employeeLastName`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_consumeditems`
--

DROP TABLE IF EXISTS `view_consumeditems`;
/*!50001 DROP VIEW IF EXISTS `view_consumeditems`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_consumeditems` AS SELECT 
 1 AS `PatientID`,
 1 AS `PatientFirstName`,
 1 AS `PatientLastName`,
 1 AS `AdmitDate`,
 1 AS `ConsumeDate`,
 1 AS `ItemID`,
 1 AS `Quantity`,
 1 AS `Description`,
 1 AS `UnitPrice`,
 1 AS `TotalPrice`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_outpatient`
--

DROP TABLE IF EXISTS `view_outpatient`;
/*!50001 DROP VIEW IF EXISTS `view_outpatient`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_outpatient` AS SELECT 
 1 AS `PatientID`,
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `ssn`,
 1 AS `address`,
 1 AS `AdmitDate`,
 1 AS `CheckBackDate`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_residentpatient`
--

DROP TABLE IF EXISTS `view_residentpatient`;
/*!50001 DROP VIEW IF EXISTS `view_residentpatient`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_residentpatient` AS SELECT 
 1 AS `PatientID`,
 1 AS `FirstName`,
 1 AS `LastName`,
 1 AS `ssn`,
 1 AS `address`,
 1 AS `AdmitDate`,
 1 AS `DischargedDate`,
 1 AS `BuildingName`,
 1 AS `RoomID`,
 1 AS `BedID`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `view_treatment`
--

DROP TABLE IF EXISTS `view_treatment`;
/*!50001 DROP VIEW IF EXISTS `view_treatment`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `view_treatment` AS SELECT 
 1 AS `PatientID`,
 1 AS `PatientFirstName`,
 1 AS `PatientLastName`,
 1 AS `AdmitDate`,
 1 AS `PhysicianFirstName`,
 1 AS `PhysicianLastName`,
 1 AS `Date`,
 1 AS `Time`,
 1 AS `Description`,
 1 AS `Result`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping events for database 'hospitaldb'
--

--
-- Dumping routines for database 'hospitaldb'
--
/*!50003 DROP PROCEDURE IF EXISTS `p_findAllPatientsInACertainDate` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_findAllPatientsInACertainDate`(in d Date)
begin
select patient.PatientID, patient.FirstName, patient.LastName
from patient
where patient.AdmitDate = d;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_findAllReceivedTreatmentForAPatient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_findAllReceivedTreatmentForAPatient`(in pid int)
begin
select view_treatment.PatientFirstName, view_treatment.PatientLastName, view_treatment.Date, view_treatment.Time, view_treatment.Description as TreatmentDetails, view_treatment.Result
from view_treatment
where PatientID = pid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_findPatientPhysician` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_findPatientPhysician`(in pFn varchar(45), in pLn varchar(45))
begin
select physician.FirstName as PhysicianFirstName, physician.LastName as PhysicianLastName
from physician inner join Patient on patient.PhyID = physician.PhyID 
and patient.FirstName = pFn and patient.LastName = pLn;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_findResidentPatientLocation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_findResidentPatientLocation`(in pid int)
begin
select view_residentpatient.BuildingName, view_residentpatient.RoomID, view_residentpatient.BedID
from view_residentpatient
where PatientID = pid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_PatientConsumedItems` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_PatientConsumedItems`(in pid int)
begin
select view_consumeditems.ItemID, view_consumeditems.ConsumeDate, view_consumeditems.Quantity, view_consumeditems.Description
from view_consumeditems
where PatientID = pid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_PatientPaymentBills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_PatientPaymentBills`(in pid int)
begin
select view_consumeditems.ConsumeDate, view_consumeditems.ItemID, view_consumeditems.Quantity, view_consumeditems.UnitPrice, view_consumeditems.TotalPrice
from view_consumeditems
where PatientID = pid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_PhysicianAllPatients` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_PhysicianAllPatients`(in pid int)
begin
select patient.PatientID, patient.FirstName, patient.LastName, patient.AdmitDate, patient.OutPatient, patient.ResidentPatient
from patient
where patient.PhyID = pid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `p_searchCertainCareCenterInfo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `p_searchCertainCareCenterInfo`(in cid int)
begin
select view_carecenterinfo.CcName, view_carecenterinfo.telephoneNumber as ContactPhoneNumber, view_carecenterinfo.BuildingName, view_carecenterinfo.employeeFirstName, view_carecenterinfo.employeeLastName
from view_carecenterinfo
where CcID = cid;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `view_carecenterinfo`
--

/*!50001 DROP VIEW IF EXISTS `view_carecenterinfo`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_carecenterinfo` AS select `carecenter`.`CcID` AS `CcID`,`carecenter`.`CcName` AS `CcName`,`carecenter`.`telephoneNumber` AS `telephoneNumber`,`building`.`BuildingName` AS `BuildingName`,`carecenteremployee`.`FirstName` AS `employeeFirstName`,`carecenteremployee`.`LastName` AS `employeeLastName` from (((`carecenter` join `building` on((`carecenter`.`BID` = `building`.`BID`))) join `employs` on((`carecenter`.`CcID` = `employs`.`CcID`))) join `carecenteremployee` on((`employs`.`EmpID` = `carecenteremployee`.`EmpID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_consumeditems`
--

/*!50001 DROP VIEW IF EXISTS `view_consumeditems`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_consumeditems` AS select `patient`.`PatientID` AS `PatientID`,`patient`.`FirstName` AS `PatientFirstName`,`patient`.`LastName` AS `PatientLastName`,`patient`.`AdmitDate` AS `AdmitDate`,`consumes`.`ConsumeDate` AS `ConsumeDate`,`consumes`.`ItemID` AS `ItemID`,`consumes`.`Quantity` AS `Quantity`,`items`.`Description` AS `Description`,`items`.`UnitPrice` AS `UnitPrice`,`consumes`.`TotalPrice` AS `TotalPrice` from ((`patient` join `consumes` on((`patient`.`PatientID` = `consumes`.`PatientID`))) join `items` on((`consumes`.`ItemID` = `items`.`ItemID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_outpatient`
--

/*!50001 DROP VIEW IF EXISTS `view_outpatient`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_outpatient` AS select `patient`.`PatientID` AS `PatientID`,`patient`.`FirstName` AS `FirstName`,`patient`.`LastName` AS `LastName`,`patient`.`ssn` AS `ssn`,`patient`.`address` AS `address`,`patient`.`AdmitDate` AS `AdmitDate`,`outpatient`.`CheckBackDate` AS `CheckBackDate` from (`patient` join `outpatient` on((`patient`.`PatientID` = `outpatient`.`PatientID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_residentpatient`
--

/*!50001 DROP VIEW IF EXISTS `view_residentpatient`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_residentpatient` AS select `patient`.`PatientID` AS `PatientID`,`patient`.`FirstName` AS `FirstName`,`patient`.`LastName` AS `LastName`,`patient`.`ssn` AS `ssn`,`patient`.`address` AS `address`,`patient`.`AdmitDate` AS `AdmitDate`,`residentpatient`.`DischargedDate` AS `DischargedDate`,`building`.`BuildingName` AS `BuildingName`,`residentpatient`.`RoomID` AS `RoomID`,`residentpatient`.`BedID` AS `BedID` from ((`patient` join `residentpatient` on((`patient`.`PatientID` = `residentpatient`.`PatientID`))) join `building` on((`building`.`BID` = `residentpatient`.`BID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `view_treatment`
--

/*!50001 DROP VIEW IF EXISTS `view_treatment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `view_treatment` AS select `patient`.`PatientID` AS `PatientID`,`patient`.`FirstName` AS `PatientFirstName`,`patient`.`LastName` AS `PatientLastName`,`patient`.`AdmitDate` AS `AdmitDate`,`physician`.`FirstName` AS `PhysicianFirstName`,`physician`.`LastName` AS `PhysicianLastName`,`treat`.`Date` AS `Date`,`treat`.`Time` AS `Time`,`treatment`.`Description` AS `Description`,`treat`.`Result` AS `Result` from (((`patient` join `treat` on((`patient`.`PatientID` = `treat`.`PatientID`))) join `treatment` on((`treat`.`TreatID` = `treatment`.`TreatID`))) join `physician` on((`treat`.`PhyID` = `physician`.`PhyID`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-04-26 18:10:54
