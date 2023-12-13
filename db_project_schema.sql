-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: train
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `accidentinfo`
--

DROP TABLE IF EXISTS `accidentinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accidentinfo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `StationID` int DEFAULT NULL,
  `AccidentTime` datetime DEFAULT NULL,
  `Weather` varchar(255) DEFAULT NULL,
  `AccidentType` varchar(255) DEFAULT NULL,
  `InjuredCount` int DEFAULT NULL,
  `ActionTaken` text,
  PRIMARY KEY (`id`),
  KEY `StationID` (`StationID`),
  CONSTRAINT `accidentinfo_ibfk_1` FOREIGN KEY (`StationID`) REFERENCES `station` (`StationID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accidentinfo`
--

LOCK TABLES `accidentinfo` WRITE;
/*!40000 ALTER TABLE `accidentinfo` DISABLE KEYS */;
INSERT INTO `accidentinfo` VALUES (1,2,'2023-11-10 08:00:00','비','지연',0,'정상운행'),(2,5,'2023-11-15 08:30:00','비','지연',0,'지연운행'),(3,6,'2023-11-20 12:45:00','강풍','탈선',0,'운행중지'),(4,1,'2023-11-25 18:20:00','맑음','신호고장',0,'재정비'),(5,3,'2023-11-30 22:10:00','흐림','지연',0,'정상운행'),(6,2,'2023-12-05 04:30:00','비','지연',0,'지연운행'),(7,8,'2023-12-08 14:15:00','눈','지연',0,'지연운행'),(8,10,'2023-12-10 10:00:00','맑음','신호고장',0,'재정비'),(9,9,'2023-12-11 20:45:00','흐림','지연',0,'정상운행'),(10,7,'2023-12-12 09:00:00','강풍','지연',0,'지연운행');
/*!40000 ALTER TABLE `accidentinfo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`bs06136`@`%`*/ /*!50003 TRIGGER `AfterInsertAccident` AFTER INSERT ON `accidentinfo` FOR EACH ROW BEGIN
    -- 새로 추가된 AccidentInfo 데이터에 대한 처리 프로시저 호출
    CALL HandleAccident(NEW.StationID, NEW.AccidentTime, NEW.Weather, NEW.AccidentType, NEW.InjuredCount, NEW.ActionTaken);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `actualoperation`
--

DROP TABLE IF EXISTS `actualoperation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actualoperation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `TimetableID` int DEFAULT NULL,
  `DepartureStationID` int DEFAULT NULL,
  `ArrivalStationID` int DEFAULT NULL,
  `DepartureTime` datetime DEFAULT NULL,
  `ArrivalTime` datetime DEFAULT NULL,
  `Changes` text,
  PRIMARY KEY (`id`),
  KEY `TimetableID` (`TimetableID`),
  KEY `DepartureStationID` (`DepartureStationID`),
  KEY `ArrivalStationID` (`ArrivalStationID`),
  CONSTRAINT `actualoperation_ibfk_1` FOREIGN KEY (`TimetableID`) REFERENCES `timetable` (`TimeID`),
  CONSTRAINT `actualoperation_ibfk_2` FOREIGN KEY (`DepartureStationID`) REFERENCES `station` (`StationID`),
  CONSTRAINT `actualoperation_ibfk_3` FOREIGN KEY (`ArrivalStationID`) REFERENCES `station` (`StationID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actualoperation`
--

LOCK TABLES `actualoperation` WRITE;
/*!40000 ALTER TABLE `actualoperation` DISABLE KEYS */;
/*!40000 ALTER TABLE `actualoperation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `attendancerecord`
--

DROP TABLE IF EXISTS `attendancerecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `attendancerecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `AttendanceDateTime` datetime DEFAULT NULL,
  `AttendanceStatus` varchar(50) DEFAULT NULL,
  `AttendanceLocation` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `attendancerecord_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `attendancerecord`
--

LOCK TABLES `attendancerecord` WRITE;
/*!40000 ALTER TABLE `attendancerecord` DISABLE KEYS */;
INSERT INTO `attendancerecord` VALUES (1,1,'2023-12-01 09:32:15','정상','서울역'),(2,2,'2023-12-02 15:21:40','지각','광주역'),(3,3,'2023-12-03 07:48:03','정상','서울역'),(4,4,'2023-12-04 12:05:28','정상','울산역'),(5,5,'2023-12-05 16:37:51','정상','서울역'),(6,6,'2023-12-06 06:59:12','정상','부산역'),(7,7,'2023-12-07 13:43:09','정상','전주역'),(8,8,'2023-12-08 10:18:37','정상','전주역'),(9,9,'2023-12-09 17:12:45','정상','강릉역'),(10,10,'2023-12-10 08:27:19','정상','대전역');
/*!40000 ALTER TABLE `attendancerecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo`
--

DROP TABLE IF EXISTS `cargo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo` (
  `CargoID` int NOT NULL AUTO_INCREMENT,
  `CargoType` int NOT NULL,
  `CargoWeight` int NOT NULL,
  PRIMARY KEY (`CargoID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo`
--

LOCK TABLES `cargo` WRITE;
/*!40000 ALTER TABLE `cargo` DISABLE KEYS */;
INSERT INTO `cargo` VALUES (1,1,500),(2,2,750),(3,3,300),(4,4,900),(5,1,450),(6,2,600),(7,3,350),(8,4,800),(9,1,550),(10,2,700);
/*!40000 ALTER TABLE `cargo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`bs06136`@`%`*/ /*!50003 TRIGGER `AfterInsertCargo` AFTER INSERT ON `cargo` FOR EACH ROW BEGIN
    DECLARE routeID INT;
    DECLARE fareID INT;

    -- Cargo, Route 및 Fare 테이블에 새로운 데이터 추가
    SET routeID = 1; -- 적절한 노선 ID로 설정
    SET fareID = 1;  -- 적절한 요금 ID로 설정

    -- 새로 추가된 Cargo 및 관련 정보를 프로시저를 통해 결제 정보로 추가
    CALL CreateCargoPayment(NEW.CargoID, routeID, fareID, NEW.CargoWeight * NEW.CargoType, CURRENT_DATE);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cargocustomer`
--

DROP TABLE IF EXISTS `cargocustomer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargocustomer` (
  `CustomerID` int NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`CustomerID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargocustomer`
--

LOCK TABLES `cargocustomer` WRITE;
/*!40000 ALTER TABLE `cargocustomer` DISABLE KEYS */;
INSERT INTO `cargocustomer` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
/*!40000 ALTER TABLE `cargocustomer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargopayment`
--

DROP TABLE IF EXISTS `cargopayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargopayment` (
  `CargoPaymentID` int NOT NULL AUTO_INCREMENT,
  `CustomerID` int NOT NULL,
  `CargoID` int NOT NULL,
  `RouteID` int NOT NULL,
  `FareID` int NOT NULL,
  `PaymentAmount` decimal(10,2) NOT NULL,
  `PaymentDate` date NOT NULL,
  `IsRefunded` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`CargoPaymentID`),
  KEY `CustomerID` (`CustomerID`),
  KEY `CargoID` (`CargoID`),
  KEY `FareID` (`FareID`),
  KEY `RouteID` (`RouteID`),
  CONSTRAINT `cargopayment_ibfk_1` FOREIGN KEY (`CustomerID`) REFERENCES `cargocustomer` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cargopayment_ibfk_2` FOREIGN KEY (`CargoID`) REFERENCES `cargo` (`CargoID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cargopayment_ibfk_3` FOREIGN KEY (`FareID`) REFERENCES `fare` (`FareID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cargopayment_ibfk_4` FOREIGN KEY (`RouteID`) REFERENCES `route` (`RouteID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargopayment`
--

LOCK TABLES `cargopayment` WRITE;
/*!40000 ALTER TABLE `cargopayment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargopayment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connected_route`
--

DROP TABLE IF EXISTS `connected_route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connected_route` (
  `RouteID` int NOT NULL,
  `num` int NOT NULL,
  `DetailedRouteID` int NOT NULL,
  PRIMARY KEY (`RouteID`,`num`,`DetailedRouteID`),
  KEY `DetailedRouteID` (`DetailedRouteID`),
  CONSTRAINT `connected_route_ibfk_1` FOREIGN KEY (`DetailedRouteID`) REFERENCES `detailedroute` (`DetailedRouteID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `connected_route_ibfk_2` FOREIGN KEY (`RouteID`) REFERENCES `route` (`RouteID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connected_route`
--

LOCK TABLES `connected_route` WRITE;
/*!40000 ALTER TABLE `connected_route` DISABLE KEYS */;
INSERT INTO `connected_route` VALUES (102,1,1),(103,1,1),(107,1,1),(502,3,1),(602,3,1),(802,2,1),(902,2,1),(108,1,2),(208,2,2),(104,1,3),(105,1,3),(106,1,3),(109,1,3),(110,1,3),(205,2,3),(206,2,3),(209,2,3),(201,1,4),(205,1,4),(206,1,4),(208,1,4),(209,1,4),(301,2,4),(701,3,4),(103,2,5),(107,2,5),(203,1,5),(204,1,5),(207,1,5),(210,1,5),(301,1,6),(302,1,6),(402,2,6),(701,2,6),(702,2,6),(1002,3,6),(305,1,7),(306,1,7),(308,1,7),(309,1,7),(705,2,7),(708,2,7),(709,2,7),(107,3,8),(207,2,8),(210,2,8),(307,1,8),(310,1,8),(407,2,8),(410,2,8),(807,3,8),(907,2,8),(701,1,9),(702,1,9),(703,1,9),(704,1,9),(705,1,9),(708,1,9),(709,1,9),(1002,2,9),(1003,2,9),(210,3,10),(310,2,10),(410,3,10),(706,1,10),(710,1,10),(507,3,11),(607,2,11),(1002,1,11),(1003,1,11),(1007,1,11),(706,2,12),(1001,1,12),(1004,1,12),(1005,1,12),(1006,1,12),(1008,1,12),(1009,1,12),(110,3,13),(507,2,13),(510,2,13),(607,1,13),(610,1,13),(810,3,13),(910,2,13),(601,1,14),(602,1,14),(603,1,14),(604,1,14),(608,1,14),(609,1,14),(1001,2,14),(1004,2,14),(1008,2,14),(1009,2,14),(401,2,15),(501,2,15),(502,2,15),(601,2,15),(602,2,15),(901,1,15),(902,1,15),(1001,3,15),(503,2,16),(603,2,16),(803,2,16),(807,2,16),(903,1,16),(907,1,16),(308,2,17),(408,2,17),(508,2,17),(608,2,17),(708,3,17),(908,1,17),(1008,3,17),(106,2,18),(110,2,18),(206,3,18),(306,2,18),(406,2,18),(806,2,18),(810,2,18),(906,1,18),(910,1,18),(801,1,19),(802,1,19),(803,1,20),(804,1,20),(805,1,20),(806,1,20),(807,1,20),(809,1,20),(810,1,20),(402,1,21),(403,1,21),(407,1,21),(410,1,21),(401,1,22),(405,1,22),(406,1,22),(408,1,22),(409,1,22),(204,2,23),(304,1,23),(704,2,23),(104,2,24),(504,2,24),(604,2,24),(804,2,24),(904,1,24),(1004,3,24),(501,1,25),(502,1,25),(503,1,25),(504,1,25),(508,1,25),(509,1,25),(506,1,26),(507,1,26),(510,1,26),(105,2,27),(205,3,27),(305,2,27),(405,2,27),(705,3,27),(805,2,27),(905,1,27),(605,1,28),(1005,2,28);
/*!40000 ALTER TABLE `connected_route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `conveniencefacility`
--

DROP TABLE IF EXISTS `conveniencefacility`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `conveniencefacility` (
  `id` int NOT NULL AUTO_INCREMENT,
  `StationID` int DEFAULT NULL,
  `toilet` int DEFAULT NULL,
  `convenienceStore` int DEFAULT NULL,
  `restaurant` int DEFAULT NULL,
  `cafe` int DEFAULT NULL,
  `giftshop` int DEFAULT NULL,
  `ticketStore` int DEFAULT NULL,
  `ParkingArea` int DEFAULT NULL,
  `ATM` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `StationID` (`StationID`),
  CONSTRAINT `conveniencefacility_ibfk_1` FOREIGN KEY (`StationID`) REFERENCES `station` (`StationID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `conveniencefacility`
--

LOCK TABLES `conveniencefacility` WRITE;
/*!40000 ALTER TABLE `conveniencefacility` DISABLE KEYS */;
INSERT INTO `conveniencefacility` VALUES (1,1,4,5,12,10,3,2,2,3),(2,2,4,2,5,5,1,1,1,2),(3,3,3,3,10,8,3,2,1,2),(4,4,2,2,6,2,1,1,1,1),(5,5,1,2,1,3,1,1,1,1),(6,6,4,4,10,10,4,2,2,4),(7,7,1,2,8,6,2,1,1,2),(8,8,1,1,0,1,1,1,1,1),(9,9,2,2,4,5,2,1,1,1),(10,10,2,3,5,6,1,1,1,2);
/*!40000 ALTER TABLE `conveniencefacility` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customerconsultationrecord`
--

DROP TABLE IF EXISTS `customerconsultationrecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customerconsultationrecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `CustomerName` varchar(255) NOT NULL,
  `ConsultationDate` date DEFAULT NULL,
  `ConsultationType` varchar(255) DEFAULT NULL,
  `ConsultationContent` text,
  `ProcessingStatus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `customerconsultationrecord_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customerconsultationrecord`
--

LOCK TABLES `customerconsultationrecord` WRITE;
/*!40000 ALTER TABLE `customerconsultationrecord` DISABLE KEYS */;
INSERT INTO `customerconsultationrecord` VALUES (1,1,'김현수','2023-11-02','열차운행','열차가 10분이나 지연됐습니다. 다음부턴 피해보지 않게 주의해주세요.','처리완료'),(2,1,'김현수','2023-11-10','열차서비스','화장실이 청결하지 않았습니다. 신경써주세요','처리완료'),(3,2,'김주영','2023-11-11','분실물','에어팟을 잃어버렸는데 습득하시면 연락 부탁드립니다.','처리완료'),(4,1,'김현수','2023-11-16','열차서비스','객차 내에서 불쾌한 냄새가 납니다. 신경써주세요','처리완료'),(5,7,'장해영','2023-11-17','결제','카카오페이 결제 시 오류가 나는데 왜 그런건가요?','처리완료'),(6,4,'박정은','2023-11-20','열차운행','열차가 1시간 지연되어 보상 부탁드립니다.','처리완료'),(7,2,'강수흔','2023-11-23','열차운행','서울-전주행 평일 14시 기차는 이제 더이상 운행 안 하는건가요?','처리완료'),(8,7,'김현수','2023-11-25','열차서비스','객차 내에서 시끄럽게 통화하는 승객들 관리해주세요.','처리완료'),(9,9,'김현수','2023-12-10','열차운행','10시 기차이고, 10시 40초쯤에 도착했는데 열차가 떠나네요? 10시 1분도 안됐는데 이러면 안 되는 거 아닌가요?','처리중'),(10,9,'최종환','2023-12-11','분실물','모자를 분실했습니다. 습듯 시 연락 부탁드립니다.','진행중');
/*!40000 ALTER TABLE `customerconsultationrecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailedroute`
--

DROP TABLE IF EXISTS `detailedroute`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailedroute` (
  `DetailedRouteID` int NOT NULL AUTO_INCREMENT,
  `StartID` int NOT NULL,
  `EndID` int NOT NULL,
  PRIMARY KEY (`DetailedRouteID`),
  KEY `StartID` (`StartID`),
  KEY `EndID` (`EndID`),
  CONSTRAINT `detailedroute_ibfk_1` FOREIGN KEY (`StartID`) REFERENCES `station` (`StationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailedroute_ibfk_2` FOREIGN KEY (`EndID`) REFERENCES `station` (`StationID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailedroute`
--

LOCK TABLES `detailedroute` WRITE;
/*!40000 ALTER TABLE `detailedroute` DISABLE KEYS */;
INSERT INTO `detailedroute` VALUES (1,1,2),(2,1,8),(3,1,9),(4,2,1),(5,2,3),(6,3,2),(7,3,9),(8,3,7),(9,7,3),(10,7,10),(11,10,7),(12,10,6),(13,6,10),(14,6,9),(15,9,1),(16,9,3),(17,9,8),(18,9,6),(19,8,1),(20,8,9),(21,4,3),(22,4,9),(23,3,4),(24,9,4),(25,5,9),(26,5,6),(27,9,5),(28,6,5);
/*!40000 ALTER TABLE `detailedroute` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`bs06136`@`%`*/ /*!50003 TRIGGER `AfterInsertDetailedRoute` AFTER INSERT ON `detailedroute` FOR EACH ROW BEGIN
    DECLARE StartStation INT;
    DECLARE EndStation INT;

    SELECT StartID, EndID INTO StartStation, EndStation FROM DetailedRoute WHERE DetailedRouteID = NEW.DetailedRouteID;

    INSERT INTO Connected_Route(RouteID, num, DetailedRouteID)
    VALUES (NEW.DetailedRouteID, 1, NEW.DetailedRouteID),
           (NEW.DetailedRouteID, 2, StartStation),
           (NEW.DetailedRouteID, 3, EndStation);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `ReferenceID` int DEFAULT NULL,
  `WorkScheduleID` int DEFAULT NULL,
  `EmployeeName` varchar(255) NOT NULL,
  `Salary` int DEFAULT NULL,
  `Position` varchar(255) DEFAULT NULL,
  `ContactNumber` varchar(20) DEFAULT NULL,
  `HireDate` date DEFAULT NULL,
  `EmployeeInfo` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,NULL,1,'이한솔',4000,'승무원','010-0000-0000','2020-12-01','1995년 출생. 숙명여대 경제학과 졸업'),(2,NULL,2,'노영권',4000,'승무원','010-1111-1111','2021-01-01','1999년 출생. 가천대 컴퓨터공학과 졸업'),(3,NULL,3,'박연하',4000,'기관사','010-2222-2222','2018-07-01','1991년 출생. 국민대 기계공학과 졸업'),(4,NULL,4,'송민정',4000,'승무원','010-3333-3333','2021-02-01','1998년 출생. 가천대 일어일문학과 졸업'),(5,NULL,5,'이신영',5000,'기관사','010-4444-4444','2023-03-01','1995년 출생. 성신여대 경제학과 졸업'),(6,NULL,6,'이다영',3000,'미화원','010-5555-5555','2022-11-01','2001년 출생. 숭실대 무역학과 졸업'),(7,NULL,7,'조주원',4000,'승무원','010-6666-6666','2022-11-01','2002년 출생. 중앙대 소프트웨어학과 졸업'),(8,NULL,8,'이종현',5000,'미화원','010-7777-7777','2008-11-01','1979년 출생. 세종대 경영학과 졸업'),(9,NULL,9,'이성민',5000,'승무원','010-8888-8888','2012-06-01','1986년 출생. 경희대 경영학과 졸업'),(10,NULL,10,'한누리',6000,'기관사','010-9999-9999','2013-12-01','1986년 출생. 서경대 물리학과 졸업');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fare`
--

DROP TABLE IF EXISTS `fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fare` (
  `FareID` int NOT NULL,
  `Fare` int NOT NULL,
  PRIMARY KEY (`FareID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fare`
--

LOCK TABLES `fare` WRITE;
/*!40000 ALTER TABLE `fare` DISABLE KEYS */;
INSERT INTO `fare` VALUES (1,10000),(2,12000),(3,9000),(4,15000),(5,8000),(6,11000),(7,20000),(8,25000),(9,30000),(10,35000);
/*!40000 ALTER TABLE `fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `Feedback_ID` int NOT NULL,
  `Name` varchar(45) NOT NULL,
  `Date` datetime NOT NULL,
  `Feedback_contents` longtext NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`Feedback_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lostitems`
--

DROP TABLE IF EXISTS `lostitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lostitems` (
  `id` int NOT NULL AUTO_INCREMENT,
  `OwnerName` varchar(255) DEFAULT NULL,
  `ItemInfo` text,
  `DateInfo` date DEFAULT NULL,
  `FoundLocation` int DEFAULT NULL,
  `ProcessingStatus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FoundLocation` (`FoundLocation`),
  CONSTRAINT `lostitems_ibfk_1` FOREIGN KEY (`FoundLocation`) REFERENCES `station` (`StationID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lostitems`
--

LOCK TABLES `lostitems` WRITE;
/*!40000 ALTER TABLE `lostitems` DISABLE KEYS */;
INSERT INTO `lostitems` VALUES (1,'김민수','검은색 삼성 갤럭시 S21휴대폰','2023-11-08',1,'폐기'),(2,'이지은','갈색 루이비통 가죽 지갑','2023-11-18',3,'회수'),(3,NULL,'하트모양 키링이 달린 열쇠','2023-11-19',4,'보관'),(4,'최유진','파란색 아디다스 백팩','2023-11-21',6,'보관'),(5,'장하은','분홍색 가죽 카드지갑','2023-11-30',2,'보관'),(6,'강지후','에어팟프로','2023-11-30',1,'회수'),(7,NULL,'노란색 단우산','2023-12-01',10,'보관'),(8,NULL,'투명한 플라스틱 물병','2023-12-03',9,'보관'),(9,'황수민','초록색 국민은행 카드','2023-12-05',1,'폐기'),(10,'조은지','애플펜슬','2023-12-08',7,'회수');
/*!40000 ALTER TABLE `lostitems` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`bs06136`@`%`*/ /*!50003 TRIGGER `AfterInsertLostItem` AFTER INSERT ON `lostitems` FOR EACH ROW BEGIN
    -- 새로 추가된 LostItems 데이터에 대한 처리 프로시저 호출
    CALL HandleLostItem(NEW.OwnerName, NEW.ItemInfo, NEW.DateInfo, NEW.FoundLocation, NEW.ProcessingStatus);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `maintenance`
--

DROP TABLE IF EXISTS `maintenance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance` (
  `Maintenance_ID` int NOT NULL,
  `mechanic_ID` varchar(45) NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`Maintenance_ID`,`mechanic_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `maintenance_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance`
--

LOCK TABLES `maintenance` WRITE;
/*!40000 ALTER TABLE `maintenance` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenance_record`
--

DROP TABLE IF EXISTS `maintenance_record`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenance_record` (
  `Maintenance_ID` int DEFAULT NULL,
  `Maintenance_Record` varchar(45) NOT NULL,
  `Maintenance_Datetime` date NOT NULL,
  KEY `Maintenance_ID` (`Maintenance_ID`),
  CONSTRAINT `maintenance_record_ibfk_1` FOREIGN KEY (`Maintenance_ID`) REFERENCES `maintenance` (`Maintenance_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenance_record`
--

LOCK TABLES `maintenance_record` WRITE;
/*!40000 ALTER TABLE `maintenance_record` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenance_record` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `PassengerID` int NOT NULL,
  PRIMARY KEY (`PassengerID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1),(2),(3),(4),(5);
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `PaymentID` int NOT NULL AUTO_INCREMENT,
  `TrainID` int NOT NULL,
  `CarriageNum` int NOT NULL,
  `SeatNum` int NOT NULL,
  `TimeID` int NOT NULL,
  `PassengerID` int NOT NULL,
  `RouteID` int NOT NULL,
  `FareID` int NOT NULL,
  `PromotionID` int DEFAULT NULL,
  `PointPaymentID` int DEFAULT NULL,
  `Refunded` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`PaymentID`),
  KEY `TrainID` (`TrainID`,`CarriageNum`,`TimeID`),
  KEY `PassengerID` (`PassengerID`),
  KEY `RouteID` (`RouteID`),
  KEY `FareID` (`FareID`),
  KEY `PromotionID` (`PromotionID`),
  KEY `PointPaymentID` (`PointPaymentID`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`TrainID`, `CarriageNum`, `TimeID`) REFERENCES `seat` (`TrainID`, `CarriageNum`, `TimeID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`PassengerID`) REFERENCES `passenger` (`PassengerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`RouteID`) REFERENCES `route` (`RouteID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_4` FOREIGN KEY (`FareID`) REFERENCES `fare` (`FareID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_5` FOREIGN KEY (`PromotionID`) REFERENCES `promotion` (`PromotionID`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_6` FOREIGN KEY (`PointPaymentID`) REFERENCES `pointpay` (`PointPaymentID`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pointpay`
--

DROP TABLE IF EXISTS `pointpay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pointpay` (
  `PointPaymentID` int NOT NULL AUTO_INCREMENT,
  `PassengerID` int NOT NULL,
  `PointsBefore` int NOT NULL,
  `PointsAfter` int NOT NULL,
  `PointsUsed` int NOT NULL,
  PRIMARY KEY (`PointPaymentID`),
  KEY `PassengerID` (`PassengerID`),
  CONSTRAINT `pointpay_ibfk_1` FOREIGN KEY (`PassengerID`) REFERENCES `passenger` (`PassengerID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pointpay`
--

LOCK TABLES `pointpay` WRITE;
/*!40000 ALTER TABLE `pointpay` DISABLE KEYS */;
/*!40000 ALTER TABLE `pointpay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_info`
--

DROP TABLE IF EXISTS `product_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product_info` (
  `Product_ID` int NOT NULL,
  `Product_Name` varchar(45) NOT NULL,
  `Product_Price` varchar(45) NOT NULL,
  `expiration_date` date NOT NULL,
  PRIMARY KEY (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_info`
--

LOCK TABLES `product_info` WRITE;
/*!40000 ALTER TABLE `product_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `promotion`
--

DROP TABLE IF EXISTS `promotion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `promotion` (
  `PromotionID` int NOT NULL,
  `discount` int NOT NULL,
  PRIMARY KEY (`PromotionID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `promotion`
--

LOCK TABLES `promotion` WRITE;
/*!40000 ALTER TABLE `promotion` DISABLE KEYS */;
INSERT INTO `promotion` VALUES (1,10),(2,15),(3,5),(4,20),(5,25),(6,30),(7,35),(8,40),(9,45),(10,50);
/*!40000 ALTER TABLE `promotion` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`bs06136`@`%`*/ /*!50003 TRIGGER `AfterInsertPromotionAndFare` AFTER INSERT ON `promotion` FOR EACH ROW BEGIN
    DECLARE fareID INT;

    -- Fare 테이블에 새로운 일반 요금 추가
    INSERT INTO Fare (Fare) VALUES (10000);

    -- 방금 추가된 Fare의 FareID 가져오기
    SELECT MAX(FareID) INTO fareID FROM Fare;

    -- 새로 추가된 Promotion과 Fare 정보를 프로시저를 통해 업데이트
    CALL ApplyPromotionAndFare(NEW.PromotionID, fareID);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `refund`
--

DROP TABLE IF EXISTS `refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund` (
  `refund_id` int NOT NULL AUTO_INCREMENT,
  `PaymentID` int NOT NULL,
  PRIMARY KEY (`refund_id`),
  KEY `PaymentID` (`PaymentID`),
  CONSTRAINT `refund_ibfk_1` FOREIGN KEY (`PaymentID`) REFERENCES `payment` (`PaymentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund`
--

LOCK TABLES `refund` WRITE;
/*!40000 ALTER TABLE `refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `RouteID` int NOT NULL,
  `StartID` int NOT NULL,
  `EndID` int NOT NULL,
  PRIMARY KEY (`RouteID`),
  KEY `StartID` (`StartID`),
  KEY `EndID` (`EndID`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`StartID`) REFERENCES `station` (`StationID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`EndID`) REFERENCES `station` (`StationID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
INSERT INTO `route` VALUES (102,1,2),(103,1,3),(104,1,4),(105,1,5),(106,1,6),(107,1,7),(108,1,8),(109,1,9),(110,1,10),(201,2,1),(203,2,3),(204,2,4),(205,2,5),(206,2,6),(207,2,7),(208,2,8),(209,2,9),(210,2,10),(301,3,1),(302,3,2),(304,3,4),(305,3,5),(306,3,6),(307,3,7),(308,3,8),(309,3,9),(310,3,10),(401,4,1),(402,4,2),(403,4,3),(405,4,5),(406,4,6),(407,4,7),(408,4,8),(409,4,9),(410,4,10),(501,5,1),(502,5,2),(503,5,3),(504,5,4),(506,5,6),(507,5,7),(508,5,8),(509,5,9),(510,5,10),(601,6,1),(602,6,2),(603,6,3),(604,6,4),(605,6,5),(607,6,7),(608,6,8),(609,6,9),(610,6,10),(701,7,1),(702,7,2),(703,7,3),(704,7,4),(705,7,5),(706,7,6),(708,7,8),(709,7,9),(710,7,10),(801,8,1),(802,8,2),(803,8,3),(804,8,4),(805,8,5),(806,8,6),(807,8,7),(809,8,9),(810,8,10),(901,9,1),(902,9,2),(903,9,3),(904,9,4),(905,9,5),(906,9,6),(907,9,7),(908,9,8),(910,9,10),(1001,10,1),(1002,10,2),(1003,10,3),(1004,10,4),(1005,10,5),(1006,10,6),(1007,10,7),(1008,10,8),(1009,10,9);
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `TrainID` int NOT NULL,
  `CarriageNum` int NOT NULL,
  `SeatInformation` int NOT NULL,
  `TimeID` int NOT NULL,
  PRIMARY KEY (`TrainID`,`CarriageNum`,`TimeID`),
  KEY `TimeID` (`TimeID`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `seat_ibfk_2` FOREIGN KEY (`TimeID`) REFERENCES `timetable` (`TimeID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
INSERT INTO `seat` VALUES (1,1,0,1),(1,1,0,2),(1,1,0,3),(2,1,0,4),(2,1,0,5),(2,1,0,6);
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_payment`
--

DROP TABLE IF EXISTS `service_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_payment` (
  `PaymentID` int NOT NULL,
  `ServiceID` int NOT NULL,
  PRIMARY KEY (`PaymentID`,`ServiceID`),
  KEY `ServiceID` (`ServiceID`),
  CONSTRAINT `service_payment_ibfk_1` FOREIGN KEY (`PaymentID`) REFERENCES `payment` (`PaymentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `service_payment_ibfk_2` FOREIGN KEY (`ServiceID`) REFERENCES `service_type` (`ServiceID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_payment`
--

LOCK TABLES `service_payment` WRITE;
/*!40000 ALTER TABLE `service_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_type`
--

DROP TABLE IF EXISTS `service_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_type` (
  `ServiceID` int NOT NULL,
  `Service_type` int NOT NULL,
  `Service_cost` int NOT NULL,
  PRIMARY KEY (`ServiceID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_type`
--

LOCK TABLES `service_type` WRITE;
/*!40000 ALTER TABLE `service_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `StationID` int NOT NULL AUTO_INCREMENT,
  `StationName` varchar(255) NOT NULL,
  `Location` varchar(255) NOT NULL,
  `Facilities` text,
  `PlatformCount` int DEFAULT NULL,
  PRIMARY KEY (`StationID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES (1,'서울역','서울 용산구 한강대로 405',NULL,10),(2,'광명역','경기 광명시 광명역로 21',NULL,10),(3,'대전역','대전 동구 중앙로 215',NULL,10),(4,'대구역','대구 북구 태평로 161',NULL,4),(5,'울산역','울산 울주군 삼남읍 울산역로 177',NULL,2),(6,'부산역','부산 동구 중앙대로 206',NULL,10),(7,'전주역','전북 전주시 덕진구 동부대로 680',NULL,4),(8,'강릉역','강원 강릉시 용지로 176',NULL,2),(9,'신경주역','경북 경주시 건천읍 경주역로 80',NULL,4),(10,'광주역','광주 북구 무등로 235',NULL,8);
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `Stock_id` int NOT NULL,
  `quantity` int NOT NULL,
  `Receiving_date` date NOT NULL,
  `Vending_machine_ID` int NOT NULL,
  `Product_ID` int NOT NULL,
  PRIMARY KEY (`Stock_id`),
  KEY `Vending_machine_ID` (`Vending_machine_ID`),
  KEY `Product_ID` (`Product_ID`),
  CONSTRAINT `stock_ibfk_1` FOREIGN KEY (`Vending_machine_ID`) REFERENCES `vending_machine` (`Vending_Machine_ID`),
  CONSTRAINT `stock_ibfk_2` FOREIGN KEY (`Product_ID`) REFERENCES `product_info` (`Product_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stock`
--

LOCK TABLES `stock` WRITE;
/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timetable` (
  `TimeID` int NOT NULL AUTO_INCREMENT,
  `TrainID` int DEFAULT NULL,
  `departure_time` time DEFAULT NULL,
  `arrival_time` time DEFAULT NULL,
  `operating_day` date DEFAULT NULL,
  `DetailedRouteID` int DEFAULT NULL,
  PRIMARY KEY (`TimeID`),
  KEY `TrainID` (`TrainID`),
  KEY `DetailedRouteID` (`DetailedRouteID`),
  CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `timetable_ibfk_2` FOREIGN KEY (`DetailedRouteID`) REFERENCES `detailedroute` (`DetailedRouteID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable`
--

LOCK TABLES `timetable` WRITE;
/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
INSERT INTO `timetable` VALUES (1,1,'08:00:00','10:30:00','2023-01-01',3),(2,1,'14:00:00','16:30:00','2023-01-01',18),(3,1,'09:00:00','11:30:00','2023-01-02',13),(4,2,'09:30:00','12:00:00','2023-01-01',1),(5,2,'16:30:00','19:00:00','2023-01-01',5),(6,2,'10:30:00','13:00:00','2023-01-02',8),(7,3,'10:00:00','12:30:00','2023-01-01',4),(8,3,'17:00:00','19:30:00','2023-01-01',3),(9,3,'11:00:00','13:30:00','2023-01-02',27),(10,4,'10:30:00','13:00:00','2023-01-01',4),(11,4,'17:30:00','20:00:00','2023-01-01',3),(12,4,'11:30:00','14:00:00','2023-01-02',18),(13,5,'11:00:00','13:30:00','2023-01-01',5),(14,5,'18:00:00','20:30:00','2023-01-01',8),(15,5,'12:00:00','14:30:00','2023-01-02',10);
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `TrainID` int NOT NULL,
  `Num` int NOT NULL,
  PRIMARY KEY (`TrainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1,101),(2,102),(3,103),(4,104),(5,105);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_compartment`
--

DROP TABLE IF EXISTS `train_compartment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_compartment` (
  `TrainID` int NOT NULL,
  `Num` int NOT NULL,
  `compartment_type_id` int NOT NULL,
  `seat_num` int NOT NULL,
  PRIMARY KEY (`TrainID`,`Num`),
  CONSTRAINT `train_compartment_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_compartment`
--

LOCK TABLES `train_compartment` WRITE;
/*!40000 ALTER TABLE `train_compartment` DISABLE KEYS */;
INSERT INTO `train_compartment` VALUES (1,1,1,50),(2,1,1,30),(3,1,1,20),(4,1,1,40),(5,1,1,25);
/*!40000 ALTER TABLE `train_compartment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vending_machine`
--

DROP TABLE IF EXISTS `vending_machine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vending_machine` (
  `Vending_Machine_ID` int NOT NULL,
  `Install_Date` date NOT NULL,
  `Install_Location` varchar(45) NOT NULL,
  `management_company_name` varchar(45) NOT NULL,
  `manager` varchar(45) NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`Vending_Machine_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `vending_machine_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vending_machine`
--

LOCK TABLES `vending_machine` WRITE;
/*!40000 ALTER TABLE `vending_machine` DISABLE KEYS */;
/*!40000 ALTER TABLE `vending_machine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vending_payment`
--

DROP TABLE IF EXISTS `vending_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vending_payment` (
  `Payment_ID` int NOT NULL,
  `Payment_Date` date NOT NULL,
  `Payment_method` varchar(45) NOT NULL,
  `Product_ID` int NOT NULL,
  `Price` int NOT NULL,
  `Vending_machine_ID` int NOT NULL,
  PRIMARY KEY (`Payment_ID`),
  KEY `Vending_machine_ID` (`Vending_machine_ID`),
  CONSTRAINT `vending_payment_ibfk_1` FOREIGN KEY (`Vending_machine_ID`) REFERENCES `vending_machine` (`Vending_Machine_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vending_payment`
--

LOCK TABLES `vending_payment` WRITE;
/*!40000 ALTER TABLE `vending_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `vending_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workschedule`
--

DROP TABLE IF EXISTS `workschedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `workschedule` (
  `id` int NOT NULL AUTO_INCREMENT,
  `EmployeeID` int DEFAULT NULL,
  `ScheduleID` int DEFAULT NULL,
  `WorkType` varchar(255) DEFAULT NULL,
  `WorkDescription` text,
  `WorkStatus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ScheduleID` (`ScheduleID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `workschedule_ibfk_1` FOREIGN KEY (`ScheduleID`) REFERENCES `timetable` (`TimeID`),
  CONSTRAINT `workschedule_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workschedule`
--

LOCK TABLES `workschedule` WRITE;
/*!40000 ALTER TABLE `workschedule` DISABLE KEYS */;
/*!40000 ALTER TABLE `workschedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'train'
--

--
-- Dumping routines for database 'train'
--
/*!50003 DROP FUNCTION IF EXISTS `ProcessRefund` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` FUNCTION `ProcessRefund`(paymentID INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    -- 결제 정보 업데이트
    CALL UpdatePaymentForRefund(paymentID);

    -- 환불 정보 기록
    CALL RecordRefund(paymentID);

    -- 성공적으로 환불 처리되었음을 반환
    RETURN TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `RecordRefund` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` FUNCTION `RecordRefund`(paymentID INT) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    -- 환불 정보를 Refund 테이블에 추가
    INSERT INTO Refund (PaymentID) VALUES (paymentID);
    RETURN TRUE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `ReserveAndProcessCargoBulk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` FUNCTION `ReserveAndProcessCargoBulk`(cargoDataList TEXT) RETURNS int
    NO SQL
BEGIN
    DECLARE cargoID INT;
    DECLARE routeID INT;
    DECLARE fareID INT;
    DECLARE paymentAmount DECIMAL(10, 2);

    -- 임시 테이블 생성
    CREATE TEMPORARY TABLE IF NOT EXISTS TempCargoData (
        CargoType INT,
        CargoWeight INT
    );

    -- 화물 정보 삽입
    INSERT INTO Cargo (CargoType, CargoWeight)
    SELECT CargoType, CargoWeight FROM TempCargoData;

    -- 새로 추가된 화물 정보의 ID 가져오기
    SELECT LAST_INSERT_ID() INTO cargoID;

    -- 화물 운송 노선 정보 삽입 (가정: 노선은 고정 값)
    INSERT INTO Route (StartID, EndID) VALUES (1, 2);

    -- 새로 추가된 노선 정보의 ID 가져오기
    SELECT LAST_INSERT_ID() INTO routeID;

    -- 화물 요금 정보 삽입 (가정: 요금은 고정 값)
    INSERT INTO Fare (Fare) VALUES (100);

    -- 새로 추가된 요금 정보의 ID 가져오기
    SELECT LAST_INSERT_ID() INTO fareID;

    -- 화물 운송 비용 계산
    SET paymentAmount = (SELECT SUM(CargoWeight * CargoType) FROM TempCargoData);

    -- 화물 결제 정보를 CargoPayment 테이블에 추가
    INSERT INTO CargoPayment (CargoID, RouteID, FareID, PaymentAmount, PaymentDate)
    VALUES (cargoID, routeID, fareID, paymentAmount, CURRENT_DATE);

    -- 화물 결제 정보를 Payment 테이블에 추가
    INSERT INTO Payment (RouteID, FareID)
    VALUES (routeID, fareID);

    -- 임시 테이블 삭제
    DROP TEMPORARY TABLE IF EXISTS TempCargoData;

    -- 예약한 화물 정보의 ID 반환
    RETURN cargoID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ApplyPromotionAndFare` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` PROCEDURE `ApplyPromotionAndFare`(IN promoID INT, IN fareID INT)
BEGIN
    DECLARE discountValue INT;
    DECLARE fareValue INT;

    -- Promotion 테이블에서 할인율 조회
    SELECT discount INTO discountValue FROM Promotion WHERE PromotionID = promoID;

    -- Fare 테이블에서 기본 요금 조회
    SELECT Fare INTO fareValue FROM Fare WHERE FareID = fareID;

    -- 할인된 요금을 Fare 테이블에 업데이트
    UPDATE Fare SET Fare = fareValue - (fareValue * discountValue / 100) WHERE FareID = fareID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `CreateCargoPayment` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` PROCEDURE `CreateCargoPayment`(IN cargoID INT, IN routeID INT, IN fareID INT, IN paymentAmount DECIMAL(10, 2), IN paymentDate DATE)
BEGIN
    -- 화물 결제 정보를 CargoPayment 테이블에 추가
    INSERT INTO CargoPayment (CargoID, RouteID, FareID, PaymentAmount, PaymentDate)
    VALUES (cargoID, routeID, fareID, paymentAmount, paymentDate);

    -- 화물 결제 정보를 Payment 테이블에 추가
    INSERT INTO Payment (RouteID, FareID)
    VALUES (routeID, fareID);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `HandleAccident` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` PROCEDURE `HandleAccident`(IN stationID INT, IN accidentTime DATETIME, IN weather VARCHAR(255),
    IN accidentType VARCHAR(255), IN injuredCount INT, IN actionTaken TEXT)
BEGIN
    INSERT INTO AccidentInfo (StationID, AccidentTime, Weather, AccidentType, InjuredCount, ActionTaken)
    VALUES (stationID, accidentTime, weather, accidentType, injuredCount, actionTaken);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `HandleLostItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` PROCEDURE `HandleLostItem`(IN ownerName VARCHAR(255), IN itemInfo TEXT, IN dateInfo DATE, IN foundLocation INT, IN processingStatus VARCHAR(50))
BEGIN
    -- 물품 분실 정보 삽입
    INSERT INTO LostItems (OwnerName, ItemInfo, DateInfo, FoundLocation, ProcessingStatus)
    VALUES (ownerName, itemInfo, dateInfo, foundLocation, processingStatus);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertStation` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` PROCEDURE `InsertStation`(IN StationName VARCHAR(255), IN Location VARCHAR(255), IN PlatformCount INT)
BEGIN
    INSERT INTO Station(StationName, Location, PlatformCount) VALUES (StationName, Location, PlatformCount);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `UpdatePaymentForRefund` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`bs06136`@`%` PROCEDURE `UpdatePaymentForRefund`(IN paymentID INT)
BEGIN
    -- 결제 정보를 업데이트하여 환불 여부를 나타냄
    UPDATE Payment SET Refunded = TRUE WHERE PaymentID = paymentID;
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

-- Dump completed on 2023-12-13 20:07:49
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: train2
-- ------------------------------------------------------
-- Server version	8.1.0

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
-- Table structure for table `actual_run`
--

DROP TABLE IF EXISTS `actual_run`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `actual_run` (
  `Actual_Run_ID` int NOT NULL,
  `Run_Date` int NOT NULL,
  `Actual_Departure_Time` int NOT NULL,
  `Actual_Arrival_Time` int NOT NULL,
  `Station_ID` int NOT NULL,
  PRIMARY KEY (`Actual_Run_ID`),
  KEY `Station_ID` (`Station_ID`),
  CONSTRAINT `actual_run_ibfk_1` FOREIGN KEY (`Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `actual_run`
--

LOCK TABLES `actual_run` WRITE;
/*!40000 ALTER TABLE `actual_run` DISABLE KEYS */;
/*!40000 ALTER TABLE `actual_run` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `additional_service_id`
--

DROP TABLE IF EXISTS `additional_service_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `additional_service_id` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `additional_service_id_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `service_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `additional_service_id`
--

LOCK TABLES `additional_service_id` WRITE;
/*!40000 ALTER TABLE `additional_service_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `additional_service_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo_carriage`
--

DROP TABLE IF EXISTS `cargo_carriage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo_carriage` (
  `Cargo_carriage_ID` int NOT NULL,
  `CarriageID` int NOT NULL,
  `Capacity` int NOT NULL,
  `Model_ID` int NOT NULL,
  PRIMARY KEY (`Cargo_carriage_ID`),
  KEY `CarriageID` (`CarriageID`),
  CONSTRAINT `cargo_carriage_ibfk_1` FOREIGN KEY (`CarriageID`) REFERENCES `carriage` (`CarriageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo_carriage`
--

LOCK TABLES `cargo_carriage` WRITE;
/*!40000 ALTER TABLE `cargo_carriage` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargo_carriage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo_compartment_fare`
--

DROP TABLE IF EXISTS `cargo_compartment_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo_compartment_fare` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `cargo_compartment_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `cargo_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo_compartment_fare`
--

LOCK TABLES `cargo_compartment_fare` WRITE;
/*!40000 ALTER TABLE `cargo_compartment_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargo_compartment_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo_fare`
--

DROP TABLE IF EXISTS `cargo_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo_fare` (
  `Fare_ID` int NOT NULL,
  `Cargo_detail_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `cargo_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo_fare`
--

LOCK TABLES `cargo_fare` WRITE;
/*!40000 ALTER TABLE `cargo_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargo_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cargo_payment`
--

DROP TABLE IF EXISTS `cargo_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cargo_payment` (
  `payment_id` int NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `cargo_payment_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cargo_payment`
--

LOCK TABLES `cargo_payment` WRITE;
/*!40000 ALTER TABLE `cargo_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `cargo_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carriage`
--

DROP TABLE IF EXISTS `carriage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `carriage` (
  `CarriageID` int NOT NULL,
  `TrainID` int NOT NULL,
  `Order` int NOT NULL,
  `ManufactureYear` int NOT NULL,
  `Manufacturer` int NOT NULL,
  PRIMARY KEY (`CarriageID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `carriage_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carriage`
--

LOCK TABLES `carriage` WRITE;
/*!40000 ALTER TABLE `carriage` DISABLE KEYS */;
/*!40000 ALTER TABLE `carriage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commercialuse_carriage`
--

DROP TABLE IF EXISTS `commercialuse_carriage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `commercialuse_carriage` (
  `CommercialUse_carriage_ID` int NOT NULL,
  `CarriageID` int NOT NULL,
  `Capacity` int NOT NULL,
  `Model_ID` int NOT NULL,
  PRIMARY KEY (`CommercialUse_carriage_ID`),
  KEY `CarriageID` (`CarriageID`),
  CONSTRAINT `commercialuse_carriage_ibfk_1` FOREIGN KEY (`CarriageID`) REFERENCES `carriage` (`CarriageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commercialuse_carriage`
--

LOCK TABLES `commercialuse_carriage` WRITE;
/*!40000 ALTER TABLE `commercialuse_carriage` DISABLE KEYS */;
/*!40000 ALTER TABLE `commercialuse_carriage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company_user`
--

DROP TABLE IF EXISTS `company_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `company_user` (
  `user_id` int NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `company_num` int NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `company_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company_user`
--

LOCK TABLES `company_user` WRITE;
/*!40000 ALTER TABLE `company_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `company_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connected_path`
--

DROP TABLE IF EXISTS `connected_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connected_path` (
  `Path_ID` int NOT NULL,
  `order` int NOT NULL,
  `Departure_Station_ID` int NOT NULL,
  `End_Station_ID` int NOT NULL,
  PRIMARY KEY (`Path_ID`,`order`),
  KEY `Departure_Station_ID` (`Departure_Station_ID`),
  KEY `End_Station_ID` (`End_Station_ID`),
  CONSTRAINT `connected_path_ibfk_1` FOREIGN KEY (`Path_ID`) REFERENCES `path` (`Path_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `connected_path_ibfk_2` FOREIGN KEY (`Departure_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `connected_path_ibfk_3` FOREIGN KEY (`End_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connected_path`
--

LOCK TABLES `connected_path` WRITE;
/*!40000 ALTER TABLE `connected_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `connected_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `container_fare`
--

DROP TABLE IF EXISTS `container_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `container_fare` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `container_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `cargo_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `container_fare`
--

LOCK TABLES `container_fare` WRITE;
/*!40000 ALTER TABLE `container_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `container_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detailed_path`
--

DROP TABLE IF EXISTS `detailed_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detailed_path` (
  `Path_ID` int NOT NULL,
  `Departure_Station_ID` int NOT NULL,
  `End_Station_ID` int NOT NULL,
  PRIMARY KEY (`Path_ID`),
  KEY `Departure_Station_ID` (`Departure_Station_ID`),
  KEY `End_Station_ID` (`End_Station_ID`),
  CONSTRAINT `detailed_path_ibfk_1` FOREIGN KEY (`Path_ID`) REFERENCES `path` (`Path_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailed_path_ibfk_2` FOREIGN KEY (`Departure_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailed_path_ibfk_3` FOREIGN KEY (`End_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detailed_path`
--

LOCK TABLES `detailed_path` WRITE;
/*!40000 ALTER TABLE `detailed_path` DISABLE KEYS */;
/*!40000 ALTER TABLE `detailed_path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `fare`
--

DROP TABLE IF EXISTS `fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fare` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fare`
--

LOCK TABLES `fare` WRITE;
/*!40000 ALTER TABLE `fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `in_flight_meal_id`
--

DROP TABLE IF EXISTS `in_flight_meal_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `in_flight_meal_id` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `in_flight_meal_id_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `service_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `in_flight_meal_id`
--

LOCK TABLES `in_flight_meal_id` WRITE;
/*!40000 ALTER TABLE `in_flight_meal_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `in_flight_meal_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `individual_user`
--

DROP TABLE IF EXISTS `individual_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `individual_user` (
  `user_id` int NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `user_age` int NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `individual_user_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `individual_user`
--

LOCK TABLES `individual_user` WRITE;
/*!40000 ALTER TABLE `individual_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `individual_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itx`
--

DROP TABLE IF EXISTS `itx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itx` (
  `ITX_ID` int NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`ITX_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `itx_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itx`
--

LOCK TABLES `itx` WRITE;
/*!40000 ALTER TABLE `itx` DISABLE KEYS */;
/*!40000 ALTER TABLE `itx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ktx`
--

DROP TABLE IF EXISTS `ktx`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ktx` (
  `Ktx_ID` int NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`Ktx_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `ktx_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ktx`
--

LOCK TABLES `ktx` WRITE;
/*!40000 ALTER TABLE `ktx` DISABLE KEYS */;
/*!40000 ALTER TABLE `ktx` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locomotive`
--

DROP TABLE IF EXISTS `locomotive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `locomotive` (
  `LocomotiveID` int NOT NULL,
  `TrainID` int NOT NULL,
  `Order` int NOT NULL,
  `ManufactureYear` int NOT NULL,
  `Manufacturer` int NOT NULL,
  PRIMARY KEY (`LocomotiveID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `locomotive_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locomotive`
--

LOCK TABLES `locomotive` WRITE;
/*!40000 ALTER TABLE `locomotive` DISABLE KEYS */;
/*!40000 ALTER TABLE `locomotive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenanceid`
--

DROP TABLE IF EXISTS `maintenanceid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenanceid` (
  `MaintenanceID` int NOT NULL,
  `MaintenanceRecordID` int NOT NULL,
  `LocomotiveID` int DEFAULT NULL,
  `CarriageID` int DEFAULT NULL,
  PRIMARY KEY (`MaintenanceID`),
  KEY `CarriageID` (`CarriageID`),
  KEY `LocomotiveID` (`LocomotiveID`),
  CONSTRAINT `maintenanceid_ibfk_1` FOREIGN KEY (`CarriageID`) REFERENCES `carriage` (`CarriageID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `maintenanceid_ibfk_2` FOREIGN KEY (`LocomotiveID`) REFERENCES `locomotive` (`LocomotiveID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenanceid`
--

LOCK TABLES `maintenanceid` WRITE;
/*!40000 ALTER TABLE `maintenanceid` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenanceid` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenancerecord`
--

DROP TABLE IF EXISTS `maintenancerecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenancerecord` (
  `MaintenanceRecordID` int NOT NULL,
  `MaintenanceID` int NOT NULL,
  `MaintenanceDate` int NOT NULL,
  `Mechanic` int NOT NULL,
  `MaintenanceDetails` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`MaintenanceRecordID`),
  KEY `MaintenanceID` (`MaintenanceID`),
  CONSTRAINT `maintenancerecord_ibfk_1` FOREIGN KEY (`MaintenanceID`) REFERENCES `maintenanceid` (`MaintenanceID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenancerecord`
--

LOCK TABLES `maintenancerecord` WRITE;
/*!40000 ALTER TABLE `maintenancerecord` DISABLE KEYS */;
/*!40000 ALTER TABLE `maintenancerecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mugunghwa`
--

DROP TABLE IF EXISTS `mugunghwa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mugunghwa` (
  `Mugunghwa_ID` int NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`Mugunghwa_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `mugunghwa_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mugunghwa`
--

LOCK TABLES `mugunghwa` WRITE;
/*!40000 ALTER TABLE `mugunghwa` DISABLE KEYS */;
/*!40000 ALTER TABLE `mugunghwa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `normal_fare`
--

DROP TABLE IF EXISTS `normal_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `normal_fare` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `normal_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `passenger_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `normal_fare`
--

LOCK TABLES `normal_fare` WRITE;
/*!40000 ALTER TABLE `normal_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `normal_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger_fare`
--

DROP TABLE IF EXISTS `passenger_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger_fare` (
  `Fare_ID` int NOT NULL,
  `Fare_detail_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `passenger_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger_fare`
--

LOCK TABLES `passenger_fare` WRITE;
/*!40000 ALTER TABLE `passenger_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `passenger_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passengers_carriage`
--

DROP TABLE IF EXISTS `passengers_carriage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passengers_carriage` (
  `passengers_carriage_ID` int NOT NULL,
  `CarriageID` int NOT NULL,
  `Capacity` int NOT NULL,
  `Model_ID` int NOT NULL,
  PRIMARY KEY (`passengers_carriage_ID`),
  KEY `CarriageID` (`CarriageID`),
  CONSTRAINT `passengers_carriage_ibfk_1` FOREIGN KEY (`CarriageID`) REFERENCES `carriage` (`CarriageID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passengers_carriage`
--

LOCK TABLES `passengers_carriage` WRITE;
/*!40000 ALTER TABLE `passengers_carriage` DISABLE KEYS */;
/*!40000 ALTER TABLE `passengers_carriage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `path`
--

DROP TABLE IF EXISTS `path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `path` (
  `Path_ID` int NOT NULL,
  `Start_Station_ID` int NOT NULL,
  `End_Station_ID` int NOT NULL,
  PRIMARY KEY (`Path_ID`),
  KEY `Start_Station_ID` (`Start_Station_ID`),
  KEY `End_Station_ID` (`End_Station_ID`),
  CONSTRAINT `path_ibfk_1` FOREIGN KEY (`Start_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `path_ibfk_2` FOREIGN KEY (`End_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `path`
--

LOCK TABLES `path` WRITE;
/*!40000 ALTER TABLE `path` DISABLE KEYS */;
/*!40000 ALTER TABLE `path` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment`
--

DROP TABLE IF EXISTS `payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payment` (
  `payment_id` int NOT NULL,
  `Fare_ID` int NOT NULL,
  `seatID` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  KEY `Fare_ID` (`Fare_ID`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_2` FOREIGN KEY (`Fare_ID`) REFERENCES `seat` (`SeatID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_ibfk_3` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment`
--

LOCK TABLES `payment` WRITE;
/*!40000 ALTER TABLE `payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refund`
--

DROP TABLE IF EXISTS `refund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refund` (
  `payment_id` int NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `refund_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refund`
--

LOCK TABLES `refund` WRITE;
/*!40000 ALTER TABLE `refund` DISABLE KEYS */;
/*!40000 ALTER TABLE `refund` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `route`
--

DROP TABLE IF EXISTS `route`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `route` (
  `Route_ID` int NOT NULL,
  `Route_Name` int NOT NULL,
  `Start_Station_ID` int NOT NULL,
  `End_Station_ID` int NOT NULL,
  PRIMARY KEY (`Route_ID`),
  KEY `Start_Station_ID` (`Start_Station_ID`),
  KEY `End_Station_ID` (`End_Station_ID`),
  CONSTRAINT `route_ibfk_1` FOREIGN KEY (`Route_ID`) REFERENCES `path` (`Path_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `route_ibfk_2` FOREIGN KEY (`Start_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `route_ibfk_3` FOREIGN KEY (`End_Station_ID`) REFERENCES `station` (`Station_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `route`
--

LOCK TABLES `route` WRITE;
/*!40000 ALTER TABLE `route` DISABLE KEYS */;
/*!40000 ALTER TABLE `route` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saemaeul`
--

DROP TABLE IF EXISTS `saemaeul`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saemaeul` (
  `Saemaeul_ID` int NOT NULL,
  `TrainID` int NOT NULL,
  PRIMARY KEY (`Saemaeul_ID`),
  KEY `TrainID` (`TrainID`),
  CONSTRAINT `saemaeul_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saemaeul`
--

LOCK TABLES `saemaeul` WRITE;
/*!40000 ALTER TABLE `saemaeul` DISABLE KEYS */;
/*!40000 ALTER TABLE `saemaeul` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `season_fare`
--

DROP TABLE IF EXISTS `season_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `season_fare` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `season_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `passenger_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `season_fare`
--

LOCK TABLES `season_fare` WRITE;
/*!40000 ALTER TABLE `season_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `season_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seat`
--

DROP TABLE IF EXISTS `seat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seat` (
  `SeatID` int NOT NULL,
  `SeatNum` int NOT NULL,
  `SeatClass` int NOT NULL,
  `TrainID` int NOT NULL,
  `Timetable_id` int NOT NULL,
  PRIMARY KEY (`SeatID`),
  KEY `TrainID` (`TrainID`),
  KEY `Timetable_id` (`Timetable_id`),
  CONSTRAINT `seat_ibfk_1` FOREIGN KEY (`TrainID`) REFERENCES `train` (`TrainID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `seat_ibfk_2` FOREIGN KEY (`Timetable_id`) REFERENCES `timetable` (`Timetable_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seat`
--

LOCK TABLES `seat` WRITE;
/*!40000 ALTER TABLE `seat` DISABLE KEYS */;
/*!40000 ALTER TABLE `seat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_fare`
--

DROP TABLE IF EXISTS `service_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_fare` (
  `Fare_ID` int NOT NULL,
  `Service_Detail_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `service_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_fare`
--

LOCK TABLES `service_fare` WRITE;
/*!40000 ALTER TABLE `service_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service_payment`
--

DROP TABLE IF EXISTS `service_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service_payment` (
  `payment_id` int NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `service_payment_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service_payment`
--

LOCK TABLES `service_payment` WRITE;
/*!40000 ALTER TABLE `service_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `service_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `special_fare`
--

DROP TABLE IF EXISTS `special_fare`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `special_fare` (
  `Fare_ID` int NOT NULL,
  `Amount` decimal(10,2) DEFAULT NULL,
  `Condition` int NOT NULL,
  `Service_Name` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Fare_ID`),
  CONSTRAINT `special_fare_ibfk_1` FOREIGN KEY (`Fare_ID`) REFERENCES `passenger_fare` (`Fare_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `special_fare`
--

LOCK TABLES `special_fare` WRITE;
/*!40000 ALTER TABLE `special_fare` DISABLE KEYS */;
/*!40000 ALTER TABLE `special_fare` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `Station_ID` int NOT NULL,
  `Station_Name` int NOT NULL,
  `Location` int NOT NULL,
  PRIMARY KEY (`Station_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_payment`
--

DROP TABLE IF EXISTS `ticket_payment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_payment` (
  `payment_id` int NOT NULL,
  `type` varchar(20) DEFAULT NULL,
  `amount` int NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `ticket_payment_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_payment`
--

LOCK TABLES `ticket_payment` WRITE;
/*!40000 ALTER TABLE `ticket_payment` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_payment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `timetable`
--

DROP TABLE IF EXISTS `timetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `timetable` (
  `Timetable_ID` int NOT NULL,
  `Departure_Time` int NOT NULL,
  `Arrival_Time` int NOT NULL,
  `Path_ID` int NOT NULL,
  PRIMARY KEY (`Timetable_ID`),
  KEY `Path_ID` (`Path_ID`),
  CONSTRAINT `timetable_ibfk_1` FOREIGN KEY (`Path_ID`) REFERENCES `path` (`Path_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `timetable`
--

LOCK TABLES `timetable` WRITE;
/*!40000 ALTER TABLE `timetable` DISABLE KEYS */;
/*!40000 ALTER TABLE `timetable` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `TrainID` int NOT NULL,
  `Traintype` int NOT NULL,
  PRIMARY KEY (`TrainID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL,
  `name` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_id`
--

DROP TABLE IF EXISTS `user_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_id` (
  `user_id` int NOT NULL,
  `user_id_word` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_id_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_id`
--

LOCK TABLES `user_id` WRITE;
/*!40000 ALTER TABLE `user_id` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_password`
--

DROP TABLE IF EXISTS `user_password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_password` (
  `user_id` int NOT NULL,
  `user_password` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `user_password_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_password`
--

LOCK TABLES `user_password` WRITE;
/*!40000 ALTER TABLE `user_password` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'train2'
--

--
-- Dumping routines for database 'train2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-13 20:07:50
