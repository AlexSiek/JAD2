CREATE DATABASE  IF NOT EXISTS `j2ee` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `j2ee`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: j2ee
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `buyorder`
--

DROP TABLE IF EXISTS `buyorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `buyorder` (
  `id` int NOT NULL AUTO_INCREMENT,
  `productId` int NOT NULL,
  `userId` int NOT NULL,
  `orderStatus` int NOT NULL,
  `createAt` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `qty` int NOT NULL,
  `addressline1` varchar(255) DEFAULT NULL,
  `addressline2` varchar(255) DEFAULT NULL,
  `postalCode` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `productId_idx` (`productId`),
  KEY `userId_idx` (`userId`),
  KEY `pdtId_idx` (`productId`),
  KEY `uId_idx` (`userId`),
  KEY `pId_idx` (`productId`),
  KEY `usId_idx` (`userId`),
  CONSTRAINT `pId` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  CONSTRAINT `usId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `buyorder`
--

LOCK TABLES `buyorder` WRITE;
/*!40000 ALTER TABLE `buyorder` DISABLE KEYS */;
INSERT INTO `buyorder` VALUES (5,19,2,3,'2020-05-26 03:51:57',1,NULL,NULL,NULL),(6,1,2,2,'2020-05-26 03:51:57',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `buyorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart`
--

DROP TABLE IF EXISTS `cart`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `userId` int NOT NULL,
  `productId` int NOT NULL,
  `qty` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `pdtId_idx` (`productId`),
  KEY `userId_idx` (`userId`),
  CONSTRAINT `pdtId` FOREIGN KEY (`productId`) REFERENCES `product` (`id`),
  CONSTRAINT `userId` FOREIGN KEY (`userId`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart`
--

LOCK TABLES `cart` WRITE;
/*!40000 ALTER TABLE `cart` DISABLE KEYS */;
INSERT INTO `cart` VALUES (18,2,1,1),(19,2,8,1),(20,8,1,1);
/*!40000 ALTER TABLE `cart` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoryName` varchar(255) NOT NULL,
  `categoryDesc` mediumtext NOT NULL,
  `categoryImg` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `categoryName_UNIQUE` (`categoryName`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (3,'Motherboard','A motherboard is one of the most essential parts of a computer system. It holds together many of the crucial components of a computer, including the central processing unit (CPU), memory and connectors for input and output devices.','../images/motherboard.png'),(4,'CPU','CPU (pronounced as separate letters) is the abbreviation for central processing unit. Sometimes referred to simply as the central processor, but more commonly called a processor, the CPU is the brains of the computer where most calculations take place.','../images/cpu.png'),(5,'GPU','A graphics processing unit (GPU) is a specialized electronic circuit designed to rapidly manipulate and alter memory to accelerate the creation of images in a frame buffer intended for output to a display device. GPUs are used in embedded systems, mobile phones, personal computers, workstations, and game consoles.','../images/gpu.png'),(6,'RAM','RAM (pronounced ramm) is an acronym for random access memory, a type of computer memory that can be accessed randomly; that is, any byte of memory can be accessed without touching the preceding bytes. RAM is found in servers, PCs, tablets, smartphones and other devices, such as printers.','../images/ram.png'),(16,'Cases','A computer case, also known as a computer chassis, tower, system unit, or cabinet, is the enclosure that contains most of the components of a personal computer. ','../images/case.png');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `id` int NOT NULL AUTO_INCREMENT,
  `categoryId` int NOT NULL,
  `productName` varchar(255) NOT NULL,
  `vendor` varchar(255) NOT NULL,
  `pdtDesc` mediumtext NOT NULL,
  `qty` int NOT NULL,
  `buyPrice` decimal(65,2) NOT NULL,
  `MSRP` decimal(65,2) NOT NULL,
  `imgURL` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `productName_UNIQUE` (`productName`),
  KEY `catergoryId_idx` (`categoryId`),
  CONSTRAINT `catId` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES (1,3,'MSI MEG Z390 ACE','MSI','Supports 9th / 8th Gen Intel® Core? / Pentium® Gold / Celeron® processors for LGA 1151 socket',15,80.00,72.98,'../images/products/MSI_MEG_Z390_ACE.jpg'),(2,3,'MSI PRO Z390-A PRO','MSI','Supports 9th / 8th Gen Intel® Core? / Pentium® Celeron® processors for LGA 1151 socket',13,150.00,129.99,'../images/products/MSI_PRO_Z390-A_PRO.jpg'),(3,3,'MSI B450-A PRO ProSeries','MSI','Supports 1st, 2nd and 3rd Gen AMD® Ryzen?/ Ryzen? with Radeon? Vega Graphics / 2nd Gen AMD® Ryzen? with Radeon? Graphics and Athlon? with Radeon? Vega Graphics Desktop Processors for Socket AM4',2,220.00,208.99,'../images/products/MSI_B450-A PRO_ProSeries_files.jpg'),(4,3,'ASUS ROG Strix B450-F','ASUS','AM4 socket: Ready for AMD Ryzen™ processors',25,250.00,219.99,'../images/products/ASUS_ROG_Strix_B450-F.jpg'),(6,4,'AMD RYZEN 7 3700X 8-Core 3.6 GHz (4.4 GHz Max Boost)','AMD','The world\'s most advanced processor in the desktop PC gaming segment',20,310.00,294.99,'../images/products/AMD_RYZEN_7_3700X.jpg'),(7,4,'AMD RYZEN 5 3600 6-Core 3.6 GHz (4.2 GHz Max Boost)','AMD','The world\'s most advanced processor in the desktop PC gaming segment',14,190.00,172.99,'../images/products/AMD_RYZEN_5_3600.jpg'),(8,4,'Intel Core i7-9700K Coffee Lake 8-Core 3.6 GHz','Intel','8 Cores / 8 Threads',20,400.00,379.99,'../images/products/Intel_Core_i7-9700K.jpg'),(9,4,'Intel Core i9-9900K Coffee Lake 8-Core, 16-Thread, 3.6 GHz ','Intel','8 Cores / 16 Threads',10,550.00,529.99,'../images/products/Intel_Core_i9-9900K.jpg'),(10,5,'Gigabyte GeForce RTX 2060 Super','GIGABYTE','Powered by GeForce RTX 2060 Super\r\nNvidia Turing architecture & Real time Ray Tracing\r\nWindforce 2x cooling system with alternate spinning fans\r\nIntuitive controls with AORUS engine\r\nCore Clock 1680 MHz',5,500.00,479.00,'../images/products/Gigabyte_GeForce_RTX_2060_Super.jpg'),(19,5,'MSI GeForce RTX 2060 SUPER','MSI','8GB 256-Bit GDDR6\r\nBoost Clock 1695 MHz\r\n1 x HDMI 2.0b 3 x DisplayPort 1.4\r\n2176 CUDA Cores\r\nPCI Express 3.0 x16',4,600.00,570.00,'../images/products/MSI_GeForce_RTX_2060_SUPER.jpg'),(37,5,'MSI GeForce RTX 2080 SUPER ','MSI','8GB 256-Bit GDDR6\r\nBoost Clock 1845 MHz\r\n1 x HDMI 2.0b 3 x DisplayPort 1.4\r\n3072 CUDA Cores\r\nPCI Express 3.0 x16',5,1100.00,1044.00,'../images/products/MSI_GeForce_RTX_2080_SUPER.jpg'),(38,5,'ASUS ROG STRIX AMD Radeon RX 5700 XT','ASUS','Auto-Extreme Technology uses automation to enhance reliability\r\n8GB 256-Bit GDDR6\r\nCore Clock OC Mode: 1840 MHz\r\nGaming Mode: 1770 MHz\r\nBoost Clock OC Mode: 2035 MHz\r\nGaming Mode: 2010 MHz\r\n1 x HDMI 2.0b 3 x DisplayPort 1.4\r\n2560 Stream Processors\r\nPCI Express 4.0',5,500.00,459.00,'../images/products/ASUS_ROG_STRIX_AMD_Radeon_RX_5700_XT.jpg'),(39,6,'G.SKILL TridentZ RGB Series 16GB','G.SKILL','DDR4 3200 (PC4 25600)\r\nTiming 16-18-18-38\r\nCAS Latency 16\r\nVoltage 1.35V',15,100.00,93.00,'../images/products/G.SKILL_TridentZ_RGB_Series_16GB.jpg'),(40,6,'CORSAIR Vengeance LPX 32GB (4 x 8GB)','CORSAIR','DDR4 3000 (PC4 24000)\r\nTiming 16-20-20-38\r\nCAS Latency 16\r\nVoltage 1.35V\r\n',0,180.00,159.00,'../images/products/CORSAIR_Vengeance_LPX_32GB_(4_x_8GB).jpg'),(42,6,'G.SKILL Trident Z Neo (For AMD Ryzen) Series 32GB (4 x 8GB)','G.SKILL','DDR4 3600 (PC4 28800)\r\nTiming 18-22-22-42\r\nCAS Latency 18\r\nVoltage 1.35V\r\nCompatible with AMD Ryzen 3000 Series CPUs & AMD X570 Motherboards',0,219.99,204.99,'../images/products/G.SKILL_Trident_Z_Neo_(For_AMD_Ryzen)_Series_32GB_(4 x_8GB).jpg'),(44,16,'Fractal Design Meshify C Black','Fractal','Lightly tinted tempered glass side panel\r\nStreamlined high-airflow design\r\nDistinctive new styling with sharp, stealthy aesthetic\r\nNewly designed angular mesh front panel maximizes air intake\r\nPerformance and capacity of a full tower in a compact mid-tower size\r\nPower supply shroud conceals drive cage and excess cabling\r\n3 radiator positions with up to triple fan in front and dual fan up top\r\nFully adjustable and removable drive cage holds 2 x 3.5\"/2.5\" HDD/SSD\r\nSSD plate behind motherboard tray supports up to 3 x 2.5\" drives\r\nEasy-to-clean front-access removable filters on front, top and base',10,100.00,89.99,'../images/products/Fractal Design Meshify C Black.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `mobileNumber` int NOT NULL,
  `type` varchar(45) NOT NULL,
  `addressline1` varchar(255) DEFAULT NULL,
  `addressline2` varchar(255) DEFAULT NULL,
  `postalCode` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `username_UNIQUE` (`username`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `mobileNumber_UNIQUE` (`mobileNumber`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Javan Ong','adminpassword','javanTanFake@gmail.com',88776655,'Admin',NULL,NULL,NULL),(2,'Chris Tan','chrisNTan','chrisTan2@gmail.com',99887766,'Member',NULL,NULL,NULL),(3,'Steven Lim','rootPassword','stevenLimTheBoss@gmail.com',90123489,'Root',NULL,NULL,NULL),(8,'Bobby James','bob','bobbyJames@gmail.com',12312312,'Member',NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'j2ee'
--

--
-- Dumping routines for database 'j2ee'
--
/*!50003 DROP PROCEDURE IF EXISTS `findAllProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `findAllProduct`()
BEGIN
SELECT * FROM product;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `findProduct` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `findProduct`(IN pdtId int)
BEGIN
SELECT * FROM product WHERE id = pdtId;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `findProductFromCat` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `findProductFromCat`(IN id int)
BEGIN
SELECT * FROM product WHERE categoryId = id;
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

-- Dump completed on 2020-08-04  0:22:29
