-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: dionysus.sgc.ox.ac.uk    Database: database2
-- ------------------------------------------------------
-- Server version	8.3.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assay`
--

DROP TABLE IF EXISTS `assay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `assay` (
  `pkey` int NOT NULL AUTO_INCREMENT,
  `assay_id` varchar(40) NOT NULL,
  `assay_type` varchar(10) DEFAULT NULL,
  `compound_pkey` int NOT NULL,
  `target_pkey` int NOT NULL,
  `assay_ic50` float DEFAULT NULL,
  `datestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`pkey`),
  KEY `assay_target_FK` (`target_pkey`),
  KEY `assay_compounds_FK` (`compound_pkey`),
  CONSTRAINT `assay_compounds_FK` FOREIGN KEY (`compound_pkey`) REFERENCES `compounds` (`pkey`),
  CONSTRAINT `assay_target_FK` FOREIGN KEY (`target_pkey`) REFERENCES `target` (`pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assay`
--

LOCK TABLES `assay` WRITE;
/*!40000 ALTER TABLE `assay` DISABLE KEYS */;
INSERT INTO `assay` VALUES (1,'Assay1','',1,1,0.000004,'2024-05-14 14:48:11'),(2,'Assay2','',2,1,0.6516,'2024-05-14 14:50:17'),(3,'Assay3','',3,1,0.651651,'2024-05-14 14:58:19'),(4,'Assay4','',4,4,0.77,'2024-05-14 14:58:22'),(5,'Assay5','',5,4,0.5468,'2024-05-14 14:58:26'),(6,'Assay6','',6,11,0.65165,'2024-05-14 15:38:00'),(7,'Assay7','',7,7,0.65,'2024-05-14 15:01:17'),(8,'Assay8','',8,8,0.7,'2024-05-14 15:01:25'),(9,'Assay9','',9,10,0.651,'2024-05-14 14:58:42'),(10,'Assay10','',10,12,0.968136,'2024-05-14 16:00:04');
/*!40000 ALTER TABLE `assay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `compounds`
--

DROP TABLE IF EXISTS `compounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `compounds` (
  `pkey` int NOT NULL AUTO_INCREMENT,
  `compoundid` varchar(20) NOT NULL,
  `preferredname` varchar(255) DEFAULT NULL,
  `smiles` varchar(500) NOT NULL,
  `datestamp` datetime DEFAULT NULL,
  PRIMARY KEY (`pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compounds`
--

LOCK TABLES `compounds` WRITE;
/*!40000 ALTER TABLE `compounds` DISABLE KEYS */;
INSERT INTO `compounds` VALUES (1,'Compound1','one','O=Cc1ccc(O)c(OC)c1','2024-05-14 14:48:10'),(2,'Compound2','two','CC(=O)NCCC1=CNc2c1cc(OC)cc2','2024-05-14 14:50:15'),(3,'Compound3','three','CCc(c1)ccc2[n+]1ccc3c2[nH]c4c3cccc4','2024-05-14 14:58:17'),(4,'Compound4','four','CN1CCC[C@H]1c2cccnc2','2024-05-14 14:58:21'),(5,'Compound5','five','CCC[C@@H](O)CC\\C=C\\C=C\\C#CC#C\\C=C\\CO','2024-05-14 14:58:24'),(6,'Compound6','six','CC1=C(C(=O)C[C@@H]1OC(=O)[C@@H]2[C@H]','2024-05-14 14:58:28'),(7,'Compound7','seven','O1C=C[C@H]([C@H]1O2)c3c2cc(OC)c4c3OC(=O)C5=C4CCC(=O)5','2024-05-14 15:01:15'),(8,'Compound8','eight','OC[C@@H](O1)[C@@H](O)[C@H](O)[C@@H](O)[C@H](O)1','2024-05-14 15:01:22'),(9,'Compound9','nine','OC[C@@H](O1)[C@@H](O)[C@H](O)','2024-05-14 14:58:40'),(10,'Compound10','ten','CC(=O)OCCC(/C)=C\\C[C@H](C(C)=C)CCC=C','2024-05-14 14:58:43');
/*!40000 ALTER TABLE `compounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `target`
--

DROP TABLE IF EXISTS `target`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `target` (
  `pkey` int NOT NULL AUTO_INCREMENT,
  `gene_symbol` varchar(25) NOT NULL,
  `synonyms` varchar(250) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `ncbi_gene_id` bigint NOT NULL,
  `datestamp` datetime NOT NULL,
  PRIMARY KEY (`pkey`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `target`
--

LOCK TABLES `target` WRITE;
/*!40000 ALTER TABLE `target` DISABLE KEYS */;
INSERT INTO `target` VALUES (1,'Target1','one','First target',1,'2024-05-14 14:58:00'),(2,'Target2','two','Second target',2,'2024-05-14 14:58:10'),(3,'Target3','three','Third target',3,'2024-05-14 14:58:15'),(4,'Target4','four','Fourth target',4,'2024-05-14 14:58:20'),(5,'Target5','five','Fith target',5,'2024-05-14 14:58:22'),(6,'Target6','six','Sixth target',6,'2024-05-14 14:58:25'),(7,'Target7','seven','Seventh target',7,'2024-05-14 14:58:28'),(8,'Target8','eight','Eighth target',8,'2024-05-14 14:58:30'),(9,'Target9','nine','Nineth target',9,'2024-05-14 14:58:35'),(10,'Target10','ten','Tenth target',10,'2024-05-14 14:58:40'),(11,'Target16','Sixteen','Sixteenth target',16,'2024-05-14 15:34:00'),(12,'Target19','Nineteen','ineteenth target',19,'2024-05-14 15:45:00');
/*!40000 ALTER TABLE `target` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'database2'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-14 16:38:29
