CREATE DATABASE  IF NOT EXISTS `laboratory` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `laboratory`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: laboratory
-- ------------------------------------------------------
-- Server version	8.0.22

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
-- Table structure for table `reactions`
--

DROP TABLE IF EXISTS `reactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reactions` (
  `Reaction_id` int NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Temperature` float NOT NULL,
  `Pressure` float NOT NULL,
  `Yield` float NOT NULL,
  `Synth_Protocol` longtext,
  PRIMARY KEY (`Reaction_id`),
  UNIQUE KEY `Reaction_id_UNIQUE` (`Reaction_id`) /*!80000 INVISIBLE */
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reactions`
--

LOCK TABLES `reactions` WRITE;
/*!40000 ALTER TABLE `reactions` DISABLE KEYS */;
INSERT INTO `reactions` VALUES (1,'2021-02-01',298.15,200,64.2,'FLASK IN THE OIL BATH AND HEAT TO 25 DEGREES'),(2,'2021-01-15',293.15,1000,45.1,'OVERNIGHT AT 20 DEG'),(3,'2021-01-15',294.15,1100,46,'NITROGEN, 21 DEG C'),(4,'2020-10-27',268.15,500,60.34,'REACTION IS CONDUCED IN 3 FREE-PUMP-THAW CYCLES'),(5,'2021-02-01',273.15,340.3,54.56,'ROUND BOTTOM FLASK IN ICED WATER FOR 2 H'),(6,'2019-04-23',333.15,1000,89,'NITROGEN, 60 C, 4 H'),(7,'2021-02-01',353.55,340,54.6,'NITROGEN, 80.4 DEG C, 4 H'),(8,'2019-04-23',296.15,760,89,'NITROGEN, 23 DEG C, 4 H'),(9,'2021-02-01',403.15,1100,55,'FLASK IN THE OIL BATH AND HEAT TO 130 DEGREES C'),(10,'2021-01-15',298.15,900,45.07,'NITROGEN, ROOM TEMP'),(11,'2018-05-07',273.15,400,89,'ROUND BOTTOM FLASK IN ICED WATER FOR 2 H'),(12,'2019-04-23',373.15,450,20.9,'NITROGEN'),(13,'2020-11-29',413.15,1200,45,'NITROGEN, 140 C , 4 H'),(14,'2019-04-23',273.15,770,50,'ROUND BOTTOM FLASK IN ICED WATER FOR 2 H'),(15,'2020-03-30',403.15,800,60.1,'FLASK IN THE OIL BATH AND HEAT TO 130 DEGREES'),(16,'2021-01-04',358.15,1100,90,'FIRST, COOL DOWN THE REACTION AND THEN ADD REAGENT 4 AND HEAT UP TO 85 ° OVERNIGHT'),(17,'2020-12-13',363.15,1000,54.5,'HEAT THE FLASK TO 90°C AND RUNG THE REACTION OVERNIGHT.'),(18,'2020-11-29',403.15,800,64.3,'FLASK IN THE OIL BATH AND HEAT TO 130 DEGREES, FOR 2 H'),(19,'2019-11-03',353.15,1000,88,'PURGE N2 FOR 20 MIN, HEAT UP THE OIL BATH AND IMMERSE THE FLASK FOR OVERNIGHT'),(20,'2019-11-05',353.15,1000,90,'PURGE N2 FOR 20 MIN, HEAT UP THE OIL BATH AND IMMERSE THE FLASK FOR OVERNIGHT'),(21,'2020-09-23',313.15,1000,83.4,'COOL DOWN TO 0 DEG C AND THEN PURGE WITH ARGON, SEAL OFF AND HEAT TO 40 °C FOR 4 HOURS');
/*!40000 ALTER TABLE `reactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reactions_overview`
--

DROP TABLE IF EXISTS `reactions_overview`;
/*!50001 DROP VIEW IF EXISTS `reactions_overview`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reactions_overview` AS SELECT 
 1 AS `Avg_No_Chem_per_Reaction`,
 1 AS `Avg_No_User_per_Reaction`,
 1 AS `AVG_TEMP_DEG_C`,
 1 AS `AVG_YIELD_PER_CENT`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reactions_reagents`
--

DROP TABLE IF EXISTS `reactions_reagents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reactions_reagents` (
  `Reaction_id` int NOT NULL,
  `Reagent_id` int NOT NULL,
  KEY `fk_Reactions_has_Reagents_Reagents1_idx` (`Reagent_id`),
  KEY `fk_Reactions_has_Reagents_Reactions1_idx` (`Reaction_id`),
  CONSTRAINT `fk_Reactions_has_Reagents_Reactions1` FOREIGN KEY (`Reaction_id`) REFERENCES `reactions` (`Reaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Reactions_has_Reagents_Reagents1` FOREIGN KEY (`Reagent_id`) REFERENCES `reagents` (`Reagent_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reactions_reagents`
--

LOCK TABLES `reactions_reagents` WRITE;
/*!40000 ALTER TABLE `reactions_reagents` DISABLE KEYS */;
INSERT INTO `reactions_reagents` VALUES (1,2),(2,2),(2,3),(3,1),(3,3),(4,1),(4,2),(4,3),(5,1),(5,2),(6,1),(6,4),(7,1),(7,2),(7,3),(8,2),(8,4),(8,5),(9,2),(9,4),(10,2),(10,4),(11,3),(11,2),(12,2),(12,4),(12,1),(13,2),(13,5),(14,1),(14,2),(14,3),(15,3),(15,2),(16,1),(16,4),(16,3),(17,2),(17,5),(17,4),(18,2),(18,3),(19,2),(19,3),(19,4),(19,5),(20,2),(20,3),(20,4),(20,5),(21,1),(21,3),(21,4);
/*!40000 ALTER TABLE `reactions_reagents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reactions_users`
--

DROP TABLE IF EXISTS `reactions_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reactions_users` (
  `Reaction_id` int NOT NULL,
  `User_id` int NOT NULL,
  KEY `fk_Users_has_Reactions_Users_idx` (`User_id`),
  KEY `fk_Users_has_Reactions_Reactions1_idx` (`Reaction_id`),
  CONSTRAINT `fk_Users_has_Reactions_Reactions1` FOREIGN KEY (`Reaction_id`) REFERENCES `reactions` (`Reaction_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_Users_has_Reactions_Users` FOREIGN KEY (`User_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reactions_users`
--

LOCK TABLES `reactions_users` WRITE;
/*!40000 ALTER TABLE `reactions_users` DISABLE KEYS */;
INSERT INTO `reactions_users` VALUES (1,1),(1,3),(2,2),(3,1),(4,3),(5,4),(6,2),(7,2),(8,3),(9,2),(9,3),(10,1),(10,4),(10,2),(11,1),(12,1),(13,1),(14,3),(15,1),(15,4),(15,2),(16,2),(16,4),(17,4),(18,5),(18,4),(19,5),(20,5),(21,2);
/*!40000 ALTER TABLE `reactions_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `reagent_use`
--

DROP TABLE IF EXISTS `reagent_use`;
/*!50001 DROP VIEW IF EXISTS `reagent_use`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `reagent_use` AS SELECT 
 1 AS `REAGENT_ID`,
 1 AS `LOCATION_ID`,
 1 AS `NO_REACTIONS`,
 1 AS `NO_USERS`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `reagents`
--

DROP TABLE IF EXISTS `reagents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reagents` (
  `Reagent_id` int NOT NULL AUTO_INCREMENT,
  `CAS` varchar(45) NOT NULL,
  `Location_ID` varchar(45) NOT NULL,
  `Purchase_Date` date DEFAULT NULL,
  `Open_Date` date DEFAULT NULL,
  `Supplier_ID` int DEFAULT NULL,
  `Price_Eur` float DEFAULT NULL,
  PRIMARY KEY (`Reagent_id`),
  UNIQUE KEY `Reagent_id_UNIQUE` (`Reagent_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reagents`
--

LOCK TABLES `reagents` WRITE;
/*!40000 ALTER TABLE `reagents` DISABLE KEYS */;
INSERT INTO `reagents` VALUES (1,'64-17-5','2L+','2018-01-10','2018-02-22',1,12.5),(2,'75-09-2','3R-','2018-01-12','2018-02-22',1,20),(3,'67-63-0','1R+','2018-01-15','2018-03-01',1,15),(4,'110-54-3','1R-','2018-02-05','2018-02-24',2,14.7),(5,'111-65-9','2L+','2018-03-15','2018-03-05',1,9.9),(6,'141-78-6','4R-','2018-02-25','2018-03-10',3,30);
/*!40000 ALTER TABLE `reagents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `user_metrics`
--

DROP TABLE IF EXISTS `user_metrics`;
/*!50001 DROP VIEW IF EXISTS `user_metrics`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `user_metrics` AS SELECT 
 1 AS `user_id`,
 1 AS `Full_Name`,
 1 AS `No_Reactions`,
 1 AS `REACTION_DATES`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `Start_Date` date NOT NULL,
  `First_Name` varchar(45) NOT NULL,
  `Family_Name` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'2015-06-01','ALISON','SMITH'),(2,'2019-10-01','DAVID','ADAMSON-PEREZ'),(3,'2006-01-01','JOHN','MULLER'),(4,'2021-02-01','ANN','JOHNSON'),(5,'2010-11-01','MARIA','HELM');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'laboratory'
--
/*!50003 DROP FUNCTION IF EXISTS `format_date_diff` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `format_date_diff`(date2 date, date1 date) RETURNS varchar(10) CHARSET utf8mb4
    READS SQL DATA
    DETERMINISTIC
BEGIN
	
  DECLARE yyyy integer; # year number
  DECLARE mm INTEGER;      # month number
  DECLARE dd integer; # day number
  DECLARE diff varchar(15);
 
  set yyyy=floor(datediff(date2,date1)/365);
  set mm=floor(mod(datediff(date2,date1),365)/30);
  set dd=datediff(date2,date1)-365*yyyy-30*mm;
  set diff=concat(yyyy,'-',mm,'-',dd);
  
  #SELECT floor(datediff(rea.Date,chem.purchase_date)/365) INTO yyyy 
   # FROM reactions as rea, reagents as chem;
    
  #SELECT floor(mod(datediff(rea.Date,chem.purchase_date),365)/30) into mm
	#FROM reactions as rea, reagents as chem;

 # SELECT datediff(rea.date,chem.date)-365*yyyy-30*mm into dd
	#FROM reactions as rea, reagents as chem;
 
 # select concat(yyyy,' y ',mm,' m ',dd, ' d') ,'%d,%m,%Y' into diff
  #  FROM reactions as rea, reagents as chem;
 
    
  RETURN diff;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `reactions_overview`
--

/*!50001 DROP VIEW IF EXISTS `reactions_overview`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `reactions_overview` AS select (count(`rr`.`Reagent_id`) / count(distinct `rr`.`Reaction_id`)) AS `Avg_No_Chem_per_Reaction`,(select (count(`ru`.`User_id`) / count(distinct `ru`.`Reaction_id`)) from `reactions_users` `ru`) AS `Avg_No_User_per_Reaction`,(select (avg(`reactions`.`Temperature`) - 273.15) from `reactions`) AS `AVG_TEMP_DEG_C`,(select avg(`reactions`.`Yield`) from `reactions`) AS `AVG_YIELD_PER_CENT` from `reactions_reagents` `rr` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reagent_use`
--

/*!50001 DROP VIEW IF EXISTS `reagent_use`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `reagent_use` AS select `chem`.`Reagent_id` AS `REAGENT_ID`,`chem`.`Location_ID` AS `LOCATION_ID`,count(`rr`.`Reaction_id`) AS `NO_REACTIONS`,count(distinct `ru`.`User_id`) AS `NO_USERS` from (((`reagents` `chem` join `reactions_reagents` `rr` on((`chem`.`Reagent_id` = `rr`.`Reagent_id`))) join `reactions` `rea` on((`rr`.`Reaction_id` = `rea`.`Reaction_id`))) join `reactions_users` `ru` on((`rr`.`Reaction_id` = `ru`.`Reaction_id`))) group by `chem`.`Reagent_id` order by `chem`.`Reagent_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `user_metrics`
--

/*!50001 DROP VIEW IF EXISTS `user_metrics`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `user_metrics` AS select `u`.`user_id` AS `user_id`,concat(`u`.`First_Name`,' ',`u`.`Family_Name`) AS `Full_Name`,count(`ru`.`Reaction_id`) AS `No_Reactions`,group_concat(distinct `rea`.`Date` order by `rea`.`Date` DESC separator ', ') AS `REACTION_DATES` from ((`users` `u` join `reactions_users` `ru` on((`u`.`user_id` = `ru`.`User_id`))) join `reactions` `rea` on((`rea`.`Reaction_id` = `ru`.`Reaction_id`))) group by `u`.`user_id` order by `u`.`user_id` */;
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

