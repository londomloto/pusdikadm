-- MySQL dump 10.13  Distrib 5.6.26, for Win64 (x86_64)
--
-- Host: localhost    Database: e_lkh
-- ------------------------------------------------------
-- Server version	5.6.26-log

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
-- Table structure for table `bpm_diagrams`
--

DROP TABLE IF EXISTS `bpm_diagrams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bpm_diagrams` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) DEFAULT 'activity',
  `name` varchar(100) DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  `created_by` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bpm_diagrams`
--

LOCK TABLES `bpm_diagrams` WRITE;
/*!40000 ALTER TABLE `bpm_diagrams` DISABLE KEYS */;
INSERT INTO `bpm_diagrams` VALUES (60,'Graph.diagram.type.Activity','Proses Surat Masuk','proses-surat-masuk','Bisnis proses surat masuk','fdecfae1490c2b3f1c2648eabbcac440.jpg','2018-01-23 20:23:43',NULL),(61,'Graph.diagram.type.Activity','Proses Surat Keluar','proses-surat-keluar','Bisnis proses surat keluar','8bf9c4dd5e6bb307885226a0b283138c.jpg','2018-01-23 20:25:43',NULL),(62,'Graph.diagram.type.Activity','Proses Pendaftaran','proses-pendaftaran','Bisnis proses pendaftaran peserta','813d5992bc01455515a23f046d02d88e.jpg','2018-01-24 06:55:32',NULL),(63,'Graph.diagram.type.Activity','Proses Absensi','proses-absensi','Bisnis proses absensi','ab629d4ae460ce8711117d3fcd1bce60.jpg','2018-01-25 01:39:20',NULL),(64,'Graph.diagram.type.Activity','Proses Dokumen LKH','proses-dokumen-lkh','Bisnis proses dokumen LKH','5d98053560847a369fdd2315305c80ce.jpg','2018-01-25 04:03:32',NULL),(65,'Graph.diagram.type.Activity','Proses Dokumen SKP','proses-dokumen-skp','Bisnis proses dokumen SKP','e0cd01844df2980272ed0a9afc6d7846.jpg','2018-01-25 04:05:59',NULL),(66,'Graph.diagram.type.Activity','Proses Periksa LKH','proses-periksa-lkh','Bisnis proses pemeriksaan LKH','a1d87326b1656afcac40d3fd7cd8b9da.jpg','2018-01-26 13:35:20',NULL),(67,'Graph.diagram.type.Activity','Proses Periksa SKP','proses-periksa-skp','Bisnis proses pemeriksaan SKP','dcc3b2f3737556741709c9d7aa0778b1.jpg','2018-01-26 14:04:47',NULL);
/*!40000 ALTER TABLE `bpm_diagrams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bpm_forms`
--

DROP TABLE IF EXISTS `bpm_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bpm_forms` (
  `bf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bf_activity` bigint(20) DEFAULT NULL,
  `bf_name` varchar(100) DEFAULT NULL,
  `bf_description` varchar(200) DEFAULT NULL,
  `bf_tpl_file` varchar(100) DEFAULT NULL,
  `bf_tpl_orig` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`bf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bpm_forms`
--

LOCK TABLES `bpm_forms` WRITE;
/*!40000 ALTER TABLE `bpm_forms` DISABLE KEYS */;
INSERT INTO `bpm_forms` VALUES (12,808,'Site planning upload template','No description','19d1f246a90d48307faeac3fdb31a30e.html','upload.html'),(13,809,'Approval template','No description','6f64be85304054dee25e47629da7c6d3.html','approval.html'),(14,813,'Create SSR template','No description','fe6683b844815e3e1864772e20fab81c.html','create-site-ssr.html'),(15,821,'Sent Data SSR template','No description','73a72a7da1f948d2ae66541209894d24.html','send-data-ssr.html'),(16,819,'Add far end template','No description','6edbcdb933fae65132a71f658fb14038.html','add-far-end.html'),(17,817,'Review far end template','No description','dbce59b50bb42ef7997246eea071a6f7.html','review-far-end.html'),(18,811,'Update prodef template','No description','6fb5ce6462d47296620683c9d779ce27.html','upload-prodef.html'),(19,825,'Open Opportunity Form','No description','e870a901848a6d2859d15f04d6284630.html','oportunity_form_2.html'),(39,875,'Form Surat Keluar','Dokumen formulir surat keluar','3c28406d97b2d03f2dacd3abeade5948.html','form-surat-keluar.html'),(40,894,'Form pendaftaran','No description','75289f801d3be476f571c3d735b9ffb1.html','form-pendaftaran.html'),(41,901,'Form Absensi','No description','07c815496820a4cfc97e92a6015ec2a7.html','form-absensi.html'),(42,895,'Form Pendaftaran','Form untuk menginput data peserta','5db627c0354400886a4dcd752a99c823.html','form-pendaftaran.html'),(43,902,'Form Absensi','No description','a08fdcda85fc52da0017cc66cec7c569.html','form-absensi.html'),(44,896,'Form Autentikasi','Form untuk melakukan autentikasi data peserta','9c166a51e10c479e98b0686da41b550a.html','form-pendaftaran-auth.html'),(46,897,'Form Konfirmasi','No description','097a5f6abd079951b27ddddf39cb8d5d.html','form-pendaftaran-conf.html'),(47,907,'Form LKH','No description','eb562d94061d8d817f5569cee4aaf7f6.html','form-lkh.html'),(48,908,'Form LKH','No description','fa01910794e9776391507f4da222952f.html','form-lkh.html'),(51,918,'Form Pemeriksaan','No description','4c7ecddef54554c424796e3e2cf7424e.html','form-lkh-check.html'),(52,922,'Form Pemeriksaan','No description','33b88f7218d37c5b837b0dd8f2fb2012.html','form-lkh-check.html'),(53,920,'Form Cek Harian','No description','e046bbe8491c62fecf126b3ce3f27151.html','form-lkh-check-daily.html');
/*!40000 ALTER TABLE `bpm_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bpm_forms_roles`
--

DROP TABLE IF EXISTS `bpm_forms_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bpm_forms_roles` (
  `bfr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bfr_bf_id` bigint(20) DEFAULT NULL,
  `bfr_sr_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`bfr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bpm_forms_roles`
--

LOCK TABLES `bpm_forms_roles` WRITE;
/*!40000 ALTER TABLE `bpm_forms_roles` DISABLE KEYS */;
INSERT INTO `bpm_forms_roles` VALUES (9,12,1),(10,13,1),(23,44,4);
/*!40000 ALTER TABLE `bpm_forms_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bpm_forms_users`
--

DROP TABLE IF EXISTS `bpm_forms_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bpm_forms_users` (
  `bfu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bfu_bf_id` bigint(20) DEFAULT NULL,
  `bfu_su_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`bfu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bpm_forms_users`
--

LOCK TABLES `bpm_forms_users` WRITE;
/*!40000 ALTER TABLE `bpm_forms_users` DISABLE KEYS */;
INSERT INTO `bpm_forms_users` VALUES (6,12,1),(8,13,1),(10,14,1),(12,15,1),(14,16,1),(16,17,1),(18,18,1);
/*!40000 ALTER TABLE `bpm_forms_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bpm_links`
--

DROP TABLE IF EXISTS `bpm_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bpm_links` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `client_id` varchar(50) DEFAULT NULL,
  `client_source` varchar(50) DEFAULT NULL,
  `client_target` varchar(50) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `router_type` varchar(255) DEFAULT NULL,
  `diagram_id` bigint(20) DEFAULT NULL,
  `source_id` bigint(20) DEFAULT NULL,
  `target_id` bigint(20) DEFAULT NULL,
  `command` varchar(1000) DEFAULT NULL,
  `stroke` varchar(50) DEFAULT NULL,
  `label` varchar(200) DEFAULT NULL,
  `label_distance` double DEFAULT NULL,
  `convex` int(11) DEFAULT '1',
  `smooth` int(11) DEFAULT '1',
  `smoothness` bigint(20) DEFAULT NULL,
  `data_source` longtext,
  `params` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=752 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bpm_links`
--

LOCK TABLES `bpm_links` WRITE;
/*!40000 ALTER TABLE `bpm_links` DISABLE KEYS */;
INSERT INTO `bpm_links` VALUES (683,'draft','graph-link-8','graph-shape-10','graph-shape-19','Graph.link.Orthogonal','orthogonal',61,875,884,'M569.9831286967822,116.5845666814817L569.9831286967885,189.24779342342407','#000','Draft',0.47307558000901,1,0,6,NULL,'[]'),(684,'koreksi-eselon-iv','graph-link-9','graph-shape-19','graph-shape-11','Graph.link.Orthogonal','orthogonal',61,884,876,'M569.983355799967,249.24779342342538L569.9997728968186,321.5369476338609','#000','Koreksi Eselon IV',0.48416946108235,1,0,6,NULL,'[]'),(685,'koreksi-eselon-iii','graph-link-10','graph-shape-11','graph-shape-12','Graph.link.Orthogonal','orthogonal',61,876,877,'M570.0000000000113,381.536947633863L569.999999999999,455.53694763386176','#000','Koreksi Eselon III',0.4983136830565,1,0,6,NULL,'[]'),(686,'koreksi-kapus','graph-link-11','graph-shape-12','graph-shape-13','Graph.link.Orthogonal','orthogonal',61,877,878,'M570.0000586039955,515.5369476338637L570.0049425149916,598.8744441330016','#000','Koreksi Kapus',0.4649794500063,1,0,6,NULL,'[]'),(687,'paraf-kapus','graph-link-12','graph-shape-13','graph-shape-14','Graph.link.Orthogonal','orthogonal',61,878,879,'M570.0050481067932,658.8744441329959L570.0097527819222,758.9999168082713','#000','Paraf Kapus',0.49937630062606,1,0,6,NULL,'[]'),(688,'cetak','graph-link-13','graph-shape-14','graph-shape-15','Graph.link.Orthogonal','orthogonal',61,879,880,'M570.0098526082814,818.9999168082695L570.0144495803305,906.0002568027639','#000','Cetak',0.5028744958368,1,0,6,NULL,'[]'),(689,'kirim','graph-link-14','graph-shape-15','graph-shape-16','Graph.link.Orthogonal','orthogonal',61,880,881,'M570.0145589413851,966.0002568027569L570.019402165544,1051.6868943777101','#000','Kirim',0.50329024130916,1,0,6,NULL,'[]'),(690,'konfirmasi','graph-link-15','graph-shape-16','graph-shape-17','Graph.link.Orthogonal','orthogonal',61,881,882,'M570.0195102556607,1111.686894377706L570.0242673890345,1203.9373090051329','#000','Konfirmasi',0.4810304202548,1,0,6,NULL,'[]'),(691,NULL,'graph-link-16','graph-shape-17','graph-shape-18','Graph.link.Orthogonal','orthogonal',61,882,883,'M570.0239690388361,1263.9373090051372L569.9834786362582,1379.6513447461373','#000','',0.5,1,0,6,NULL,'[]'),(692,'draft','graph-link-17','graph-shape-11','graph-shape-19','Graph.link.Orthogonal','orthogonal',61,876,884,'M500,351.53694763386204L386.9831286967892,351.53694763386164L386.9831286967892,235.24779342342467L499.98312869678693,235.2477934234246','#000','Draft',0.5,1,0,6,NULL,'[]'),(693,'draft','graph-link-18','graph-shape-12','graph-shape-19','Graph.link.Orthogonal','orthogonal',61,877,884,'M500,485.53694763385346L355.4914980080148,485.5369476338617L355.4914980080148,219.24779342342464L499.98312869678705,219.24779342342444','#000','Draft',0.38268561965618,1,0,6,NULL,'[]'),(694,'draft','graph-link-19','graph-shape-13','graph-shape-19','Graph.link.Orthogonal','orthogonal',61,878,884,'M500.00500111900635,628.874444133013L315.36745615346763,628.874444132998L315.36745615346763,204.81020220539L499.9831286967875,204.81020220538937','#000','Draft',0.29465045114812,1,0,6,NULL,'[]'),(695,'draft','graph-link-20','graph-shape-14','graph-shape-19','Graph.link.Orthogonal','orthogonal',61,879,884,'M640.0097997697076,788.9999168082699L786.560332503778,788.9999168082682L786.560332503778,219.24779342342464L639.9831286967869,219.24779342342478','#000','Draft',0.5,1,0,6,NULL,'[]'),(696,'registrasi','graph-link-21','graph-shape-20','graph-shape-21','Graph.link.Orthogonal','orthogonal',60,885,886,'M602.9999999999999,96.21874999999955L603,179.21874999999977','#000','Registrasi',0.5,1,0,6,NULL,'[]'),(697,'kodefikasi','graph-link-22','graph-shape-21','graph-shape-22','Graph.link.Orthogonal','orthogonal',60,886,887,'M602.9999999999994,239.2187500000004L602.9999999999999,307.2187500000009','#000','Kodefikasi',0.5,1,0,6,NULL,'[]'),(698,'scan','graph-link-23','graph-shape-22','graph-shape-23','Graph.link.Orthogonal','orthogonal',60,887,888,'M602.9999999999999,367.21875000000006L603,452.21874999999966','#000','Scan',0.5,1,0,6,NULL,'[]'),(699,'disposisi','graph-link-24','graph-shape-23','graph-shape-24','Graph.link.Orthogonal','orthogonal',60,888,889,'M603,512.2187499999989L603,600.2187500000005','#000','Disposisi',0.5,1,0,6,NULL,'[]'),(700,'teruskan','graph-link-25','graph-shape-24','graph-shape-25','Graph.link.Orthogonal','orthogonal',60,889,890,'M602.9999999999868,660.2187499999981L602.9999999999923,749.2187499999992','#000','Teruskan',0.5,1,0,6,NULL,'[]'),(701,'laksanakan','graph-link-26','graph-shape-25','graph-shape-26','Graph.link.Orthogonal','orthogonal',60,890,891,'M602.999999999994,809.2187500000009L603.0000000000009,913.2187499999997','#000','Laksanakan',0.5,1,0,6,NULL,'[]'),(702,'balas','graph-link-27','graph-shape-26','graph-shape-27','Graph.link.Orthogonal','orthogonal',60,891,892,'M603.0000000000168,973.2187500000019L602.9999999999901,1082.218750000001','#000','Balas',0.5,1,0,6,NULL,'[]'),(703,NULL,'graph-link-28','graph-shape-27','graph-shape-28','Graph.link.Orthogonal','orthogonal',60,892,893,'M602.999999999993,1142.2187500000005L602.999999999997,1238.2187500000045','#000','',0.5,1,0,6,NULL,'[]'),(704,'pendaftaran','graph-link-1','graph-shape-1','graph-shape-2','Graph.link.Orthogonal','orthogonal',62,894,895,'M430.99999999999994,96.21874999999967L431,179.21875000000014','#000','Pendaftaran',0.5,1,0,6,NULL,'[]'),(705,'autentifikasi','graph-link-2','graph-shape-2','graph-shape-3','Graph.link.Orthogonal','orthogonal',62,895,896,'M431,239.21875000000009L431,318.2187499999991','#000','Autentifikasi',0.5,1,0,6,NULL,'[]'),(706,'konfirmasi','graph-link-3','graph-shape-3','graph-shape-4','Graph.link.Orthogonal','orthogonal',62,896,897,'M431.00000000000625,378.2187500000007L431.000000000003,454.21874999999847','#000','Konfirmasi',0.5,1,0,6,NULL,'[]'),(708,'terdaftar','graph-link-4','graph-shape-4','graph-shape-5','Graph.link.Orthogonal','orthogonal',62,897,899,'M431.15929203539395,514.2187500000003L431.15929203539395,626.2187499999992','#000','Terdaftar',0.5,1,0,6,NULL,'[]'),(709,NULL,'graph-link-5','graph-shape-5','graph-shape-6','Graph.link.Orthogonal','orthogonal',62,899,900,'M431,686.2187499999993L431,765.2187499999994','#000','',0.5,1,0,6,NULL,'[]'),(710,'absensi','graph-link-1','graph-shape-1','graph-shape-2','Graph.link.Orthogonal','orthogonal',63,901,902,'M446.99999999999966,91.21874999999991L446.99999999999835,168.21874999999991','#000','Absensi',0.5,1,0,6,NULL,'[]'),(711,NULL,'graph-link-2','graph-shape-2','graph-shape-3','Graph.link.Orthogonal','orthogonal',63,902,903,'M447.0000000000019,228.2187500000004L447.00000000000523,320.2187499999982','#000','',0.5,1,0,6,NULL,'[]'),(712,'draft','graph-link-5','graph-shape-7','graph-shape-8','Graph.link.Orthogonal','orthogonal',65,904,905,'M440.0000000000005,95.21875000000037L439.9999999999991,161.21874999999991','#000','Draft',0.5,1,0,6,NULL,'[]'),(713,NULL,'graph-link-6','graph-shape-8','graph-shape-9','Graph.link.Orthogonal','orthogonal',65,905,906,'M440,221.21875000000006L440.00000000000006,305.2187499999997','#000','',0.5,1,0,6,NULL,'[]'),(714,'dokumen','graph-link-20','graph-shape-13','graph-shape-14','Graph.link.Orthogonal','orthogonal',64,907,908,'M451.00000000000006,95.21875000000045L451.00000000000176,184.2187499999999','#000','Dokumen',0.5,1,0,6,NULL,'[]'),(731,'dokumen','graph-link-1','graph-shape-1','graph-shape-5','Graph.link.Orthogonal','orthogonal',66,918,922,'M448.9999999999993,100.21874999999977L449.00000000000097,163.21874999999986','#000','Dokumen',0.5,1,0,6,NULL,'[]'),(732,'periksa-bulanan','graph-link-2','graph-shape-5','graph-shape-2','Graph.link.Orthogonal','orthogonal',66,922,919,'M448.99999999999994,223.21875000000034L449,308.2187499999997','#000','Periksa Bulanan',0.5,1,0,6,NULL,'[]'),(734,'periksa-harian','graph-link-3','graph-shape-5','graph-shape-3','Graph.link.Orthogonal','orthogonal',66,922,920,'M379,193.21874999999997L274,193.21875L273.99999999999915,308.2187500000001','#000','Periksa Harian',0.80966375775512,1,0,6,NULL,'[]'),(737,'periksa-tahunan','graph-link-4','graph-shape-5','graph-shape-6','Graph.link.Orthogonal','orthogonal',66,922,923,'M519,193.21875000000063L623,193.21875L623.0000000000011,308.21874999999915','#000','Periksa Tahunan',0.79338356844194,1,0,6,NULL,'[]'),(738,'bulanan-ok','graph-link-5','graph-shape-2','graph-shape-8','Graph.link.Orthogonal','orthogonal',66,919,925,'M448.9999999999985,368.2187500000011L448.9999999999966,490.21875000000017','#000','Bulanan OK',0.5,1,0,6,NULL,'[]'),(739,'harian-ok','graph-link-6','graph-shape-3','graph-shape-7','Graph.link.Orthogonal','orthogonal',66,920,924,'M274.0000000000048,368.21875000000034L274.0000000000018,490.21875000000034','#000','Harian OK',0.5,1,0,6,NULL,'[]'),(740,NULL,'graph-link-7','graph-shape-7','graph-shape-4','Graph.link.Orthogonal','orthogonal',66,924,921,'M273.9999999999999,550.218749999999L273.9999999999995,658.21875L419.40429701181245,658.2187499999825','#000','',0.5,1,0,6,NULL,'[]'),(741,NULL,'graph-link-8','graph-shape-8','graph-shape-4','Graph.link.Orthogonal','orthogonal',66,925,921,'M448.9999999999985,550.2187499999999L448.9999999999963,628.218750000002','#000','',0.5,1,0,6,NULL,'[]'),(742,NULL,'graph-link-9','graph-shape-9','graph-shape-4','Graph.link.Orthogonal','orthogonal',66,926,921,'M622.9999999999997,550.2187500000005L623,658.21875L478.5957029881904,658.2187499999907','#000','',0.5,1,0,6,NULL,'[]'),(743,'tahunan-ok','graph-link-10','graph-shape-6','graph-shape-9','Graph.link.Orthogonal','orthogonal',66,923,926,'M622.9999999999936,368.21875000000045L623.0000000000083,490.2187500000013','#000','Tahunan OK',0.5,1,0,6,NULL,'[]'),(744,'ok','graph-link-31','graph-shape-14','graph-shape-22','Graph.link.Orthogonal','orthogonal',64,908,927,'M381,214.21874999999946L268,214.21875L267.99999999999994,322.21874999999994','#000','OK',0.5,1,0,6,NULL,'[]'),(745,'revisi','graph-link-32','graph-shape-14','graph-shape-23','Graph.link.Orthogonal','orthogonal',64,908,928,'M521,214.2187499999996L634,214.21875L634.0000000000006,322.21874999999926','#000','Revisi',0.5,1,0,6,NULL,'[]'),(746,NULL,'graph-link-33','graph-shape-22','graph-shape-15','Graph.link.Orthogonal','orthogonal',64,927,909,'M267.999999999998,382.21875000000017L268,512.21875L421.4042970118126,512.2187500000008','#000','',0.5,1,0,6,NULL,'[]'),(747,NULL,'graph-link-34','graph-shape-23','graph-shape-15','Graph.link.Orthogonal','orthogonal',64,928,909,'M633.9999999999985,382.2187499999983L634,512.21875L480.5957029881904,512.2187500000007','#000','',0.5,1,0,6,NULL,'[]'),(748,'dokumen','graph-link-1','graph-shape-1','graph-shape-2','Graph.link.Orthogonal','orthogonal',67,929,930,'M451.00000000000006,94.21875000000021L451,178.21874999999983','#000','Dokumen',0.5,1,0,6,NULL,'[]'),(749,'pemeriksaan','graph-link-2','graph-shape-2','graph-shape-3','Graph.link.Orthogonal','orthogonal',67,930,931,'M451.00000000000085,238.21874999999977L450.9999999999987,340.21874999999994','#000','Pemeriksaan',0.5,1,0,6,NULL,'[]'),(750,'ok','graph-link-4','graph-shape-3','graph-shape-6','Graph.link.Orthogonal','orthogonal',67,931,932,'M450.99999999999517,400.2187500000008L450.9999999999971,508.21875000000034','#000','OK',0.5,1,0,6,NULL,'[]'),(751,NULL,'graph-link-5','graph-shape-6','graph-shape-7','Graph.link.Orthogonal','orthogonal',67,932,933,'M450.99999999999613,568.2187500000022L451.00000000000574,665.2187500000009','#000','',0.5,1,0,6,NULL,'[]');
/*!40000 ALTER TABLE `bpm_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bpm_shapes`
--

DROP TABLE IF EXISTS `bpm_shapes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bpm_shapes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `client_id` varchar(50) DEFAULT NULL,
  `client_parent` varchar(50) DEFAULT NULL,
  `client_pool` varchar(50) DEFAULT NULL,
  `type` varchar(100) DEFAULT NULL,
  `mode` varchar(50) DEFAULT NULL,
  `diagram_id` bigint(20) DEFAULT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `left` double DEFAULT NULL,
  `top` double DEFAULT NULL,
  `rotate` double DEFAULT NULL,
  `label` varchar(100) DEFAULT NULL,
  `fill` varchar(30) DEFAULT NULL,
  `stroke` varchar(30) DEFAULT NULL,
  `stroke_width` bigint(20) DEFAULT NULL,
  `data_source` longtext,
  `params` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=934 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bpm_shapes`
--

LOCK TABLES `bpm_shapes` WRITE;
/*!40000 ALTER TABLE `bpm_shapes` DISABLE KEYS */;
INSERT INTO `bpm_shapes` VALUES (875,'graph-shape-10',NULL,NULL,'Graph.shape.activity.Start',NULL,61,NULL,60,60,539.98312869679,56.584566681481,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(876,'graph-shape-11',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500,321.53694763386,0,'Form Koreksi Eselon IV','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(877,'graph-shape-12',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500,455.53694763386,0,'Form Koreksi Eselon III','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(878,'graph-shape-13',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500.005001119,598.874444133,0,'Form Koreksi Kapus','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(879,'graph-shape-14',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500.00979976971,758.99991680827,0,'Form Paraf Kapus','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(880,'graph-shape-15',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500.01450241888,906.00025680276,0,'Form Cetak','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(881,'graph-shape-16',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500.01945868803,1051.6868943777,0,'Form Kirim','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(882,'graph-shape-17',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,500.02431895665,1203.9373090051,0,'Form Konfirmasi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(883,'graph-shape-18',NULL,NULL,'Graph.shape.activity.Final',NULL,61,NULL,60,60,539.98312869679,1379.6514067406,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(884,'graph-shape-19',NULL,NULL,'Graph.shape.activity.Action',NULL,61,NULL,140,60,499.98312869679,189.24779342342,0,'Form Draft','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(885,'graph-shape-20',NULL,NULL,'Graph.shape.activity.Start',NULL,60,NULL,60,60,573,36.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(886,'graph-shape-21',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,179.21875,0,'Form Registrasi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(887,'graph-shape-22',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,307.21875,0,'Form Kodefikasi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(888,'graph-shape-23',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,452.21875,0,'Form Scan','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(889,'graph-shape-24',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,600.21875,0,'Form Disposisi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(890,'graph-shape-25',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,749.21875,0,'Form Teruskan','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(891,'graph-shape-26',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,913.21875,0,'Form Laksanakan','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(892,'graph-shape-27',NULL,NULL,'Graph.shape.activity.Action',NULL,60,NULL,140,60,533,1082.21875,0,'Form Balas','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(893,'graph-shape-28',NULL,NULL,'Graph.shape.activity.Final',NULL,60,NULL,60,60,573,1238.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(894,'graph-shape-1',NULL,NULL,'Graph.shape.activity.Start',NULL,62,NULL,60,60,401,36.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(895,'graph-shape-2',NULL,NULL,'Graph.shape.activity.Action',NULL,62,NULL,140,60,361,179.21875,0,'Data Pendaftaran','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(896,'graph-shape-3',NULL,NULL,'Graph.shape.activity.Action',NULL,62,NULL,140,60,361,318.21875,0,'Data Autentifikasi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(897,'graph-shape-4',NULL,NULL,'Graph.shape.activity.Action',NULL,62,NULL,140,60,361,454.21875,0,'Data Konfirmasi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(899,'graph-shape-5',NULL,NULL,'Graph.shape.activity.Action',NULL,62,NULL,140,60,361,626.21875,0,'Data Terdaftar','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(900,'graph-shape-6',NULL,NULL,'Graph.shape.activity.Final',NULL,62,NULL,60,60,401,765.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(901,'graph-shape-1',NULL,NULL,'Graph.shape.activity.Start',NULL,63,NULL,60,60,417,31.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(902,'graph-shape-2',NULL,NULL,'Graph.shape.activity.Action',NULL,63,NULL,140,60,377,168.21875,0,'Data Absensi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(903,'graph-shape-3',NULL,NULL,'Graph.shape.activity.Final',NULL,63,NULL,60,60,417,320.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(904,'graph-shape-7',NULL,NULL,'Graph.shape.activity.Start',NULL,65,NULL,60,60,410,35.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(905,'graph-shape-8',NULL,NULL,'Graph.shape.activity.Action',NULL,65,NULL,140,60,370,161.21875,0,'Dokumen SKP','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(906,'graph-shape-9',NULL,NULL,'Graph.shape.activity.Final',NULL,65,NULL,60.089513538189,60,409.95524323091,305.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(907,'graph-shape-13',NULL,NULL,'Graph.shape.activity.Start',NULL,64,NULL,60,60,421,35.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(908,'graph-shape-14',NULL,NULL,'Graph.shape.activity.Action',NULL,64,NULL,140,60,381,184.21875,0,'Dokumen LKH','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(909,'graph-shape-15',NULL,NULL,'Graph.shape.activity.Final',NULL,64,NULL,60,60,421,482.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(918,'graph-shape-1',NULL,NULL,'Graph.shape.activity.Start',NULL,66,NULL,60,60,419,40.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(919,'graph-shape-2',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,379,308.21875,0,'Data Bulanan','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(920,'graph-shape-3',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,204,308.21875,0,'Data Harian','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(921,'graph-shape-4',NULL,NULL,'Graph.shape.activity.Final',NULL,66,NULL,60,60,419,628.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]'),(922,'graph-shape-5',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,379,163.21875,0,'Dokumen Periksa','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(923,'graph-shape-6',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,553,308.21875,0,'Data Tahunan','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(924,'graph-shape-7',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,204,490.21875,0,'Data Harian OK','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(925,'graph-shape-8',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,379,490.21875,0,'Data Bulanan OK','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(926,'graph-shape-9',NULL,NULL,'Graph.shape.activity.Action',NULL,66,NULL,140,60,553,490.21875,0,'Data Tahunan OK','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(927,'graph-shape-22',NULL,NULL,'Graph.shape.activity.Action',NULL,64,NULL,140,60,198,322.21875,0,'Data OK','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(928,'graph-shape-23',NULL,NULL,'Graph.shape.activity.Action',NULL,64,NULL,140,60,564,322.21875,0,'Data Revisi','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(929,'graph-shape-1',NULL,NULL,'Graph.shape.activity.Start',NULL,67,NULL,60,60,421,34.21875,0,'Start','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(930,'graph-shape-2',NULL,NULL,'Graph.shape.activity.Action',NULL,67,NULL,140,60,381,178.21875,0,'Dokumen SKP','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(931,'graph-shape-3',NULL,NULL,'Graph.shape.activity.Action',NULL,67,NULL,140,60,381,340.21875,0,'Data Pemeriksaan','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(932,'graph-shape-6',NULL,NULL,'Graph.shape.activity.Action',NULL,67,NULL,140,60,381,508.21875,0,'Dokumen OK','rgb(255, 255, 255)','rgb(0, 0, 0)',2,NULL,'[]'),(933,'graph-shape-7',NULL,NULL,'Graph.shape.activity.Final',NULL,67,NULL,60,60,421,665.21875,0,'End','#FF4081','rgb(0, 0, 0)',2,NULL,'[]');
/*!40000 ALTER TABLE `bpm_shapes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dx_auth`
--

DROP TABLE IF EXISTS `dx_auth`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dx_auth` (
  `auth_col_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_child_id` bigint(20) DEFAULT NULL,
  `map_id` bigint(20) DEFAULT NULL,
  `dx_read` bigint(20) DEFAULT NULL,
  `dx_write` bigint(20) DEFAULT NULL,
  `dx_edit` bigint(20) DEFAULT NULL,
  `dx_delete` bigint(20) DEFAULT NULL,
  `dx_default` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`auth_col_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dx_auth`
--

LOCK TABLES `dx_auth` WRITE;
/*!40000 ALTER TABLE `dx_auth` DISABLE KEYS */;
/*!40000 ALTER TABLE `dx_auth` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dx_mapping`
--

DROP TABLE IF EXISTS `dx_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dx_mapping` (
  `map_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `map_profile_id` bigint(20) NOT NULL,
  `map_table` varchar(50) NOT NULL,
  `map_type` varchar(20) DEFAULT 'data',
  `map_xls_col` varchar(50) NOT NULL,
  `map_tbl_col` varchar(50) DEFAULT NULL,
  `map_dtype` varchar(50) DEFAULT 'string',
  `map_pk` bigint(20) DEFAULT NULL,
  `map_mandatory` bigint(20) DEFAULT NULL,
  `map_ref_table` varchar(50) DEFAULT NULL,
  `map_ref_col` varchar(50) DEFAULT NULL,
  `map_ref_fk` varchar(50) DEFAULT NULL,
  `map_ref_ignore` bigint(20) DEFAULT NULL,
  `map_active` bigint(20) DEFAULT NULL,
  `map_col_alias` varchar(100) DEFAULT NULL,
  `map_grp_seq` bigint(20) DEFAULT NULL,
  `map_sk` bigint(20) DEFAULT NULL,
  `map_ref_contents` longtext,
  `map_col_seq` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`map_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dx_mapping`
--

LOCK TABLES `dx_mapping` WRITE;
/*!40000 ALTER TABLE `dx_mapping` DISABLE KEYS */;
INSERT INTO `dx_mapping` VALUES (1,1,'example_1','data','EMAIL','email','string',1,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(3,1,'example_1','data','DEBUG','debug','string',0,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(4,1,'example_1','data','SEX','sex','int',0,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(5,1,'example_2','data','USERNAME','username','string',1,0,NULL,NULL,NULL,0,0,NULL,1,0,NULL,NULL),(6,1,'example_1','data','DOB','dob','date',0,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(7,1,'example_1','data','AVATAR','avatar','string',0,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(8,1,'example_1','data','POINTS','points','double',0,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(9,1,'example_1','data','FULLNAME','fullname','string',0,0,NULL,NULL,NULL,0,1,NULL,1,0,NULL,NULL),(10,4,'A','data','1','A','A',1,0,NULL,NULL,NULL,0,1,NULL,NULL,1,NULL,NULL);
/*!40000 ALTER TABLE `dx_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dx_profiles`
--

DROP TABLE IF EXISTS `dx_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dx_profiles` (
  `profile_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `profile_name` varchar(50) DEFAULT NULL,
  `profile_desc` varchar(200) DEFAULT NULL,
  `header_row_idx` bigint(20) DEFAULT NULL,
  `col_offset` varchar(20) DEFAULT NULL,
  `row_offset` bigint(20) DEFAULT NULL,
  `map_header` bigint(20) DEFAULT NULL,
  `has_merge_cell` int(11) DEFAULT NULL,
  PRIMARY KEY (`profile_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dx_profiles`
--

LOCK TABLES `dx_profiles` WRITE;
/*!40000 ALTER TABLE `dx_profiles` DISABLE KEYS */;
INSERT INTO `dx_profiles` VALUES (1,'Example Profile','Example profile',1,'B',2,1,NULL),(4,'foo',NULL,1,'A',2,1,NULL),(5,'bar',NULL,1,'A',1,1,NULL);
/*!40000 ALTER TABLE `dx_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kanban`
--

DROP TABLE IF EXISTS `kanban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kanban` (
  `panel_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `panel_color` varchar(100) DEFAULT NULL,
  `panel_card_filter` varchar(100) DEFAULT NULL,
  `panel_title` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`panel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban`
--

LOCK TABLES `kanban` WRITE;
/*!40000 ALTER TABLE `kanban` DISABLE KEYS */;
INSERT INTO `kanban` VALUES (1,'pink','isCardFilterTodo','To Do'),(2,'blue','isCardFilterDoing','Doing'),(3,'green','isCardFilterDone','Done');
/*!40000 ALTER TABLE `kanban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kanban_forms`
--

DROP TABLE IF EXISTS `kanban_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kanban_forms` (
  `kf_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kf_diagrams_id` bigint(20) DEFAULT NULL,
  `kf_status` bigint(20) DEFAULT NULL,
  `kf_form_edit` varchar(255) DEFAULT NULL,
  `kf_form_view` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`kf_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban_forms`
--

LOCK TABLES `kanban_forms` WRITE;
/*!40000 ALTER TABLE `kanban_forms` DISABLE KEYS */;
INSERT INTO `kanban_forms` VALUES (1,49,396,'',''),(2,49,397,'',''),(3,49,397,'Capture.JPG',''),(4,28,96,'',''),(5,28,97,'',''),(6,28,98,'',''),(7,28,99,'',''),(8,28,105,'','');
/*!40000 ALTER TABLE `kanban_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kanban_panels`
--

DROP TABLE IF EXISTS `kanban_panels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kanban_panels` (
  `kp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kp_ks_id` bigint(20) DEFAULT NULL,
  `kp_title` varchar(50) DEFAULT NULL,
  `kp_accent` varchar(30) DEFAULT NULL,
  `kp_order` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`kp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=114 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban_panels`
--

LOCK TABLES `kanban_panels` WRITE;
/*!40000 ALTER TABLE `kanban_panels` DISABLE KEYS */;
INSERT INTO `kanban_panels` VALUES (79,22,'Registrasi','#f44336',0),(80,23,'Draft','#9c27b0',0),(81,23,'Koreksi Eselon IV','#2196f3',1),(82,23,'Koreksi Eselon III','#ffc107',2),(83,23,'Koreksi Kapus','#f44336',3),(84,23,'Paraf Kapus','#607d8b',4),(85,23,'Cetak','#009688',5),(86,23,'Kirim','#607d8b',6),(87,23,'Konfirmasi','#e91e63',7),(88,24,'Pendaftaran','#2196f3',0),(89,24,'Autentifikasi','#607d8b',1),(90,24,'Konfirmasi','#e91e63',2),(91,24,'Terdaftar','#4caf50',3),(92,25,'Draft SKP','#2196f3',0),(93,25,'Pemeriksaan','#3f51b5',1),(94,25,'Notifikasi Peserta','#e91e63',2),(95,25,'Paraf Atasan','#3f51b5',3),(96,25,'Menunggu Konfirmasi','#009688',4),(97,26,'Dokumen LKH','#3f51b5',0),(99,25,'Cetak SKP','#3f51b5',5),(100,27,'Absensi','#2196f3',0),(101,26,'Dokumen OK','#9c27b0',1),(102,26,'Dokumen Revisi','#e91e63',2),(108,28,'Pemeriksaan Harian','#9c27b0',0),(109,28,'Pemeriksaan Bulanan','#607d8b',1),(110,28,'Pemeriksaan Tahunan','#4caf50',2),(111,29,'Dokumen SKP','#607d8b',0),(112,29,'Pemeriksaan','#ffc107',1),(113,29,'Dokumen OK','#e91e63',2);
/*!40000 ALTER TABLE `kanban_panels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kanban_settings`
--

DROP TABLE IF EXISTS `kanban_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kanban_settings` (
  `ks_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ks_name` varchar(100) DEFAULT NULL,
  `ks_description` varchar(200) DEFAULT NULL,
  `ks_api` varchar(100) DEFAULT NULL,
  `ks_image` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ks_id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban_settings`
--

LOCK TABLES `kanban_settings` WRITE;
/*!40000 ALTER TABLE `kanban_settings` DISABLE KEYS */;
INSERT INTO `kanban_settings` VALUES (22,'Template Surat Masuk','Template module surat masuk',NULL,NULL),(23,'Template Surat Keluar','Template module surat keluar',NULL,NULL),(24,'Template Pendaftaran','Template module pendafaran',NULL,NULL),(25,'Template SKP','Template module SKP Tahunan',NULL,NULL),(26,'Template LKH','Template module LKH',NULL,NULL),(27,'Template Absensi','Template module absensi',NULL,NULL),(28,'Template Periksa LKH','Template untuk module pemeriksaan LKH',NULL,NULL),(29,'Template Periksa SKP','Template module pemeriksaan SKP',NULL,NULL);
/*!40000 ALTER TABLE `kanban_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kanban_statuses`
--

DROP TABLE IF EXISTS `kanban_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `kanban_statuses` (
  `kst_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `kst_kp_id` bigint(20) DEFAULT NULL,
  `kst_diagrams_id` bigint(20) DEFAULT NULL,
  `kst_status` bigint(20) DEFAULT NULL,
  `kst_color` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kst_id`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kanban_statuses`
--

LOCK TABLES `kanban_statuses` WRITE;
/*!40000 ALTER TABLE `kanban_statuses` DISABLE KEYS */;
INSERT INTO `kanban_statuses` VALUES (85,79,60,696,'#000'),(86,80,61,683,'#000'),(87,80,61,692,'#000'),(88,80,61,693,'#000'),(89,80,61,694,'#000'),(90,80,61,695,'#000'),(91,81,61,684,'#000'),(92,82,61,685,'#000'),(93,83,61,686,'#000'),(94,84,61,687,'#000'),(95,85,61,688,'#000'),(96,86,61,689,'#000'),(97,87,61,690,'#000'),(98,88,62,704,'#000'),(99,89,62,705,'#000'),(100,90,62,706,'#000'),(101,91,62,708,'#000'),(102,100,63,710,'#000'),(103,97,64,714,'#000'),(104,92,65,712,'#000'),(113,101,64,744,'#000'),(114,102,64,745,'#000'),(116,108,66,734,'#000'),(117,109,66,732,'#000'),(118,110,66,737,'#000'),(119,111,67,748,'#000'),(120,112,67,749,'#000'),(121,113,67,750,'#000');
/*!40000 ALTER TABLE `kanban_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `mst_customers`
--

DROP TABLE IF EXISTS `mst_customers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mst_customers` (
  `mc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `mc_company_name` varchar(100) DEFAULT NULL,
  `mc_contact_name` varchar(100) DEFAULT NULL,
  `mc_phone` varchar(30) DEFAULT NULL,
  `mc_email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`mc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `mst_customers`
--

LOCK TABLES `mst_customers` WRITE;
/*!40000 ALTER TABLE `mst_customers` DISABLE KEYS */;
INSERT INTO `mst_customers` VALUES (1,'Pertamina','John Doe','(021) 1234567','sales@company.com'),(2,'Indofood','John Doe','(021) 1234567','sales@company.com'),(3,'XL Axiata','John Doe','(021) 1234567','sales@company.com'),(4,'Indosat','John Doe','(021) 1234567','sales@company.com'),(5,'Telkomsel','John Doe','(021) 1234567','sales@company.com'),(6,'Sampoerna','John Doe','(021) 1234567','sales@company.com'),(7,'Net Mediatama','John Doe','(021) 1234567','sales@company.com'),(8,'Rajawali Citra','John Doe','(021) 1234567','sales@company.com'),(9,'Trans Media','John Doe','(021) 1234567','sales@company.com'),(11,'Sinar Mas','John Doe','(021) 1234567','sales@company.com'),(12,'PT KCT','Said','0818990199','said@kct.co.id');
/*!40000 ALTER TABLE `mst_customers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_captcha`
--

DROP TABLE IF EXISTS `sys_captcha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_captcha` (
  `id` varchar(40) NOT NULL,
  `namespace` varchar(32) NOT NULL,
  `code` varchar(32) NOT NULL,
  `code_display` varchar(32) NOT NULL,
  `created` bigint(20) NOT NULL,
  `audio_data` longblob,
  PRIMARY KEY (`id`,`namespace`),
  KEY `idx_35968_created` (`created`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_captcha`
--

LOCK TABLES `sys_captcha` WRITE;
/*!40000 ALTER TABLE `sys_captcha` DISABLE KEYS */;
INSERT INTO `sys_captcha` VALUES ('115.178.192.61','default','wdt','wdt',1516885400,NULL);
/*!40000 ALTER TABLE `sys_captcha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_company`
--

DROP TABLE IF EXISTS `sys_company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_company` (
  `scp_id` int(11) NOT NULL AUTO_INCREMENT,
  `scp_name` varchar(255) DEFAULT NULL,
  `scp_address` varchar(255) DEFAULT NULL,
  `scp_phone` varchar(50) DEFAULT NULL,
  `scp_fax` varchar(50) DEFAULT NULL,
  `scp_email` varchar(255) DEFAULT NULL,
  `scp_homepage` varchar(255) DEFAULT NULL,
  `scp_default` int(1) DEFAULT '1',
  PRIMARY KEY (`scp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_company`
--

LOCK TABLES `sys_company` WRITE;
/*!40000 ALTER TABLE `sys_company` DISABLE KEYS */;
INSERT INTO `sys_company` VALUES (1,'Pusdiklat Tenaga Administrasi','Jl. Kemerdekaan No. 45, Ciputat, Tangerang Selatan','(021) 77126162','(021) 77182717','pusdikadm@kemenag.go.id','http://pta.kemenag.go.id',1);
/*!40000 ALTER TABLE `sys_company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_config`
--

DROP TABLE IF EXISTS `sys_config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_config` (
  `sc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sc_name` varchar(255) DEFAULT NULL,
  `sc_value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_config`
--

LOCK TABLES `sys_config` WRITE;
/*!40000 ALTER TABLE `sys_config` DISABLE KEYS */;
INSERT INTO `sys_config` VALUES (1,'app_id','21000182918'),(3,'app_title','E-LKH'),(4,'app_version','2.0.5'),(5,'app_description','Aplikasi manajemen penilaian prestasi kerja'),(6,'app_keywords',''),(7,'app_author','pusdikadm'),(8,'app_repository',''),(9,'app_token',''),(10,'app_package','FREE'),(11,'app_limit','5'),(12,'app_package_approval','1'),(13,'app_pricing','70000'),(14,'app_package_desc','Free account for your daily needs'),(15,'notif_global','You are on Free Package. <a  href=\"billing\"><b>Upgrade PRO Package </b></a> to unlock more features'),(16,'app_route_fallback','/worksheet');
/*!40000 ALTER TABLE `sys_config` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_departments`
--

DROP TABLE IF EXISTS `sys_departments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_departments` (
  `sdp_id` int(11) NOT NULL AUTO_INCREMENT,
  `sdp_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sdp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_departments`
--

LOCK TABLES `sys_departments` WRITE;
/*!40000 ALTER TABLE `sys_departments` DISABLE KEYS */;
INSERT INTO `sys_departments` VALUES (1,'Badan Litbang dan Diklat Kementerian Agama');
/*!40000 ALTER TABLE `sys_departments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_jobs`
--

DROP TABLE IF EXISTS `sys_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_jobs` (
  `sj_id` int(11) NOT NULL AUTO_INCREMENT,
  `sj_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sj_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_jobs`
--

LOCK TABLES `sys_jobs` WRITE;
/*!40000 ALTER TABLE `sys_jobs` DISABLE KEYS */;
INSERT INTO `sys_jobs` VALUES (1,'Jabatan Fungsional Umum');
/*!40000 ALTER TABLE `sys_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_labels`
--

DROP TABLE IF EXISTS `sys_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_labels` (
  `sl_label` varchar(255) DEFAULT NULL,
  `sl_created_by` int(11) DEFAULT NULL,
  `sl_created_dt` datetime DEFAULT NULL,
  `sl_color` varchar(50) DEFAULT 'var(--paper-blue-grey-500)',
  `sl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`sl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_labels`
--

LOCK TABLES `sys_labels` WRITE;
/*!40000 ALTER TABLE `sys_labels` DISABLE KEYS */;
INSERT INTO `sys_labels` VALUES ('bugs',7,'2017-12-24 13:53:18','#f44336',11),('issue',7,'2017-12-25 04:12:10','#e91e63',12),('opened',7,'2017-12-25 04:12:43','#9c27b0',13),('test',7,'2018-01-03 17:08:00','#2196f3',14),('closed',7,'2018-01-18 23:01:10','#009688',15),('prioritas',2,'2018-01-25 07:42:08','var(--paper-red-500)',16),('koreksi',2,'2018-01-25 08:06:30','var(--paper-amber-500)',17),('valid',2,'2018-01-25 08:06:47','var(--paper-green-500)',18);
/*!40000 ALTER TABLE `sys_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_menus`
--

DROP TABLE IF EXISTS `sys_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_menus` (
  `smn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smn_parent_id` bigint(20) DEFAULT NULL,
  `smn_title` varchar(50) DEFAULT NULL,
  `smn_icon` varchar(30) DEFAULT NULL,
  `smn_path` varchar(100) DEFAULT NULL,
  `smn_order` bigint(20) DEFAULT NULL,
  `smn_visible` int(11) DEFAULT '1',
  `smn_default` int(11) DEFAULT '0',
  `smn_group` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`smn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_menus`
--

LOCK TABLES `sys_menus` WRITE;
/*!40000 ALTER TABLE `sys_menus` DISABLE KEYS */;
INSERT INTO `sys_menus` VALUES (1,0,'Homepage','social:public','/home',1,1,1,NULL),(3,0,'Dashboard Statistik','dashboard','/dashboard',3,1,0,NULL),(7,0,'Konfigurasi','device:usb','/settings',7,1,0,'Aplikasi'),(19,0,'Module Kegiatan','view-carousel','/worksheet',2,1,0,'Transaksi'),(20,0,'Label Penanda','label-outline','/references/labels',5,1,0,'Referensi');
/*!40000 ALTER TABLE `sys_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_modules`
--

DROP TABLE IF EXISTS `sys_modules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_modules` (
  `sm_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sm_name` varchar(100) DEFAULT NULL,
  `sm_version` varchar(30) DEFAULT NULL,
  `sm_title` varchar(100) DEFAULT NULL,
  `sm_author` varchar(50) DEFAULT 'KCT Team',
  `sm_repository` varchar(255) DEFAULT NULL,
  `sm_api` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_modules`
--

LOCK TABLES `sys_modules` WRITE;
/*!40000 ALTER TABLE `sys_modules` DISABLE KEYS */;
INSERT INTO `sys_modules` VALUES (1,'assets','1.0.0','Assets','Londomloto','https://github.com/londomloto/pusdikadm.git','/assets'),(2,'auth','1.0.0','Authentication','Londomloto','https://github.com/londomloto/pusdikadm.git','/auth'),(3,'application','1.0.0','Application','Londomloto','https://github.com/londomloto/pusdikadm.git','/'),(5,'home','1.0.0','Homepage','Londomloto','https://github.com/londomloto/pusdikadm.git','/home'),(7,'roles','1.0.0','Roles','Londomloto','https://github.com/londomloto/pusdikadm.git','/roles'),(8,'users','1.0.0','Users','Londomloto','https://github.com/londomloto/pusdikadm.git','/users'),(9,'modules','1.0.0','Modules','Londomloto','https://github.com/londomloto/pusdikadm.git','/modules'),(13,'dashboard','1.0.0','Dashboard','Londomloto','https://github.com/londomloto/pusdikadm.git','/dashboard'),(17,'settings','1.0.0','Settings','Londomloto','https://github.com/londomloto/pusdikadm.git','/settings'),(18,'worksheet','1.0.0','Worksheet','Londomloto','https://github.com/londomloto/pusdikadm.git','/worksheet'),(19,'labels','1.0.0','Labels','Londomloto','https://github.com/londomloto/pusdikadm.git','/references/labels');
/*!40000 ALTER TABLE `sys_modules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_modules_capabilities`
--

DROP TABLE IF EXISTS `sys_modules_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_modules_capabilities` (
  `smc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `smc_sm_id` bigint(20) DEFAULT NULL,
  `smc_name` varchar(100) DEFAULT NULL,
  `smc_description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`smc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_modules_capabilities`
--

LOCK TABLES `sys_modules_capabilities` WRITE;
/*!40000 ALTER TABLE `sys_modules_capabilities` DISABLE KEYS */;
INSERT INTO `sys_modules_capabilities` VALUES (31,2,'login_browser','Mengizinkan user login dari browser'),(32,2,'login_mobile','Mengizinkan user login dari perangkat mobile');
/*!40000 ALTER TABLE `sys_modules_capabilities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_numbers`
--

DROP TABLE IF EXISTS `sys_numbers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_numbers` (
  `sn_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sn_name` varchar(50) DEFAULT NULL,
  `sn_value` bigint(20) DEFAULT NULL,
  `sn_length` bigint(20) DEFAULT NULL,
  `sn_prefix` varchar(30) DEFAULT NULL,
  `sn_suffix` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`sn_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_numbers`
--

LOCK TABLES `sys_numbers` WRITE;
/*!40000 ALTER TABLE `sys_numbers` DISABLE KEYS */;
INSERT INTO `sys_numbers` VALUES (1,'SALES_TICKET',36,5,'SP',NULL);
/*!40000 ALTER TABLE `sys_numbers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_permissions`
--

DROP TABLE IF EXISTS `sys_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_permissions` (
  `sp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sp_sr_id` bigint(20) DEFAULT NULL,
  `sp_smc_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`sp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_permissions`
--

LOCK TABLES `sys_permissions` WRITE;
/*!40000 ALTER TABLE `sys_permissions` DISABLE KEYS */;
INSERT INTO `sys_permissions` VALUES (1,1,1);
/*!40000 ALTER TABLE `sys_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_projects`
--

DROP TABLE IF EXISTS `sys_projects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_projects` (
  `sp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sp_type` varchar(30) DEFAULT 'private',
  `sp_name` varchar(255) DEFAULT NULL,
  `sp_title` varchar(255) DEFAULT NULL,
  `sp_desc` longtext,
  `sp_start_date` date DEFAULT NULL,
  `sp_end_date` date DEFAULT NULL,
  `sp_creator_id` bigint(20) DEFAULT NULL,
  `sp_created_date` datetime DEFAULT NULL,
  `sp_worksheet_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`sp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_projects`
--

LOCK TABLES `sys_projects` WRITE;
/*!40000 ALTER TABLE `sys_projects` DISABLE KEYS */;
INSERT INTO `sys_projects` VALUES (36,'private','private','Private',NULL,NULL,NULL,7,'2018-01-20 02:34:17',19),(39,'private','pendaftaran-2018','Pendaftaran 2018','Module pendaftaran peserta','2018-01-24','2018-01-24',1,'2018-01-24 07:02:26',24),(40,'public','skp-2018','SKP 2018','Module manajemen dokumen SKP','2018-01-01','2018-12-31',1,'2018-01-24 07:28:32',25),(41,'public','lkh-2018','LKH 2018','Module agenda harian','2018-01-01','2018-12-31',1,'2018-01-24 07:33:31',26),(42,'public','absensi-2018','Absensi 2018','Module absensi harian bulan Januari 2018','2018-01-01','2018-12-31',1,'2018-01-24 19:28:16',27),(45,'public','pemeriksaan-lkh-2018','Pemeriksaan LKH 2018',NULL,'2018-01-01','2018-12-31',1,'2018-01-26 13:55:59',28),(46,'public','pemeriksaan-skp-2018','Pemeriksaan SKP 2018',NULL,'2018-01-01','2018-12-31',1,'2018-01-26 14:08:44',29);
/*!40000 ALTER TABLE `sys_projects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_projects_labels`
--

DROP TABLE IF EXISTS `sys_projects_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_projects_labels` (
  `spl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `spl_sp_id` bigint(20) DEFAULT NULL,
  `spl_sl_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`spl_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_projects_labels`
--

LOCK TABLES `sys_projects_labels` WRITE;
/*!40000 ALTER TABLE `sys_projects_labels` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_projects_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_projects_users`
--

DROP TABLE IF EXISTS `sys_projects_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_projects_users` (
  `spu_sp_id` bigint(20) DEFAULT NULL,
  `spu_su_id` bigint(20) DEFAULT NULL,
  `spu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`spu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_projects_users`
--

LOCK TABLES `sys_projects_users` WRITE;
/*!40000 ALTER TABLE `sys_projects_users` DISABLE KEYS */;
INSERT INTO `sys_projects_users` VALUES (20,7,12),(21,7,13),(36,7,73),(39,1,81),(40,1,82),(41,1,83),(42,1,84),(39,2,90),(45,1,91),(46,1,92);
/*!40000 ALTER TABLE `sys_projects_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles`
--

DROP TABLE IF EXISTS `sys_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles` (
  `sr_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sr_name` varchar(100) DEFAULT NULL,
  `sr_slug` varchar(100) DEFAULT NULL,
  `sr_description` varchar(255) DEFAULT NULL,
  `sr_default` int(11) DEFAULT '0',
  `sr_created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sr_created_by` varchar(50) DEFAULT 'system',
  PRIMARY KEY (`sr_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles`
--

LOCK TABLES `sys_roles` WRITE;
/*!40000 ALTER TABLE `sys_roles` DISABLE KEYS */;
INSERT INTO `sys_roles` VALUES (4,'Administator','administator','Role untuk pengguna administrator',1,'2017-05-24 11:48:45','system'),(7,'Eselon IV','eselon-iv','Role untuk pengguna grade Eselon IV',0,'2017-09-18 02:00:50','system'),(16,'Eselon III','eselon-iii','Role untuk pengguna grade Eselon III',0,'2018-01-11 03:27:53','system'),(17,'Kapus','kapus','Role untuk pengguna grade Kapus',0,'2018-01-23 15:17:33','system'),(18,'Staff','staff','Role untuk pengguna grade staff',0,'2018-01-23 15:17:52','system'),(19,'Peserta','peserta','Role untuk pengguna biasa atau peserta',0,'2018-01-24 12:34:47','system');
/*!40000 ALTER TABLE `sys_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles_kanban`
--

DROP TABLE IF EXISTS `sys_roles_kanban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles_kanban` (
  `srk_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srk_sr_id` bigint(20) DEFAULT NULL,
  `srk_ks_id` bigint(20) DEFAULT NULL,
  `srk_selected` int(11) DEFAULT '0',
  PRIMARY KEY (`srk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles_kanban`
--

LOCK TABLES `sys_roles_kanban` WRITE;
/*!40000 ALTER TABLE `sys_roles_kanban` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_roles_kanban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles_menus`
--

DROP TABLE IF EXISTS `sys_roles_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles_menus` (
  `srm_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srm_sr_id` bigint(20) DEFAULT NULL,
  `srm_smn_id` bigint(20) DEFAULT NULL,
  `srm_selected` int(11) DEFAULT '0',
  PRIMARY KEY (`srm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles_menus`
--

LOCK TABLES `sys_roles_menus` WRITE;
/*!40000 ALTER TABLE `sys_roles_menus` DISABLE KEYS */;
INSERT INTO `sys_roles_menus` VALUES (1,4,1,1),(3,4,14,0),(4,4,3,1),(8,4,7,1),(9,4,19,1),(10,4,20,1),(11,16,1,1),(12,16,3,1),(13,16,7,0),(14,16,19,1),(15,16,20,1),(17,7,19,1),(18,7,1,1),(19,17,1,1),(20,17,3,1),(21,17,19,1),(22,18,1,1),(23,18,3,1),(24,18,7,0),(25,18,19,1),(26,18,20,1),(27,7,3,1),(28,7,20,1),(29,17,7,1),(30,17,20,1),(31,19,1,1),(32,19,3,1),(33,19,19,1),(34,19,20,1);
/*!40000 ALTER TABLE `sys_roles_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles_permissions`
--

DROP TABLE IF EXISTS `sys_roles_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles_permissions` (
  `srp_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `srp_sr_id` bigint(20) DEFAULT NULL,
  `srp_smc_id` bigint(20) DEFAULT NULL,
  `srp_selected` int(11) DEFAULT '0',
  PRIMARY KEY (`srp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles_permissions`
--

LOCK TABLES `sys_roles_permissions` WRITE;
/*!40000 ALTER TABLE `sys_roles_permissions` DISABLE KEYS */;
INSERT INTO `sys_roles_permissions` VALUES (12,4,24,0),(13,4,12,0),(14,4,3,0),(15,4,18,0),(16,4,19,0),(17,4,22,0),(18,4,23,1),(19,4,20,1),(20,4,25,0),(21,4,17,0),(22,4,16,0),(23,4,21,0),(24,4,26,0),(25,4,27,1),(26,4,28,1),(27,4,29,1),(28,4,30,1),(29,4,31,1),(30,16,32,1),(31,16,31,1),(32,4,32,1),(33,7,31,1),(34,7,32,1),(35,17,31,1),(36,17,32,1),(37,18,31,1),(38,18,32,1),(39,19,31,1),(40,19,32,1);
/*!40000 ALTER TABLE `sys_roles_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_roles_statuses`
--

DROP TABLE IF EXISTS `sys_roles_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_roles_statuses` (
  `srs_id` int(11) NOT NULL AUTO_INCREMENT,
  `srs_sp_id` int(11) DEFAULT NULL,
  `srs_sr_id` int(11) DEFAULT NULL,
  `srs_kp_id` int(11) DEFAULT NULL,
  `srs_kst_id` int(11) DEFAULT NULL,
  `srs_checked` int(1) DEFAULT '0',
  PRIMARY KEY (`srs_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_roles_statuses`
--

LOCK TABLES `sys_roles_statuses` WRITE;
/*!40000 ALTER TABLE `sys_roles_statuses` DISABLE KEYS */;
INSERT INTO `sys_roles_statuses` VALUES (11,37,7,80,86,0),(12,37,7,80,87,0),(13,37,7,80,88,0),(14,37,7,80,89,0),(15,37,7,80,90,0),(16,37,7,82,92,0),(17,37,7,83,93,0),(18,37,7,84,94,0),(19,37,7,85,95,0),(20,37,7,86,96,0),(21,37,7,87,97,0),(22,37,16,80,86,0),(23,37,16,80,87,0),(24,37,16,80,88,0),(25,37,16,80,89,0),(26,37,16,80,90,0),(27,37,16,81,91,0),(28,37,16,83,93,0),(29,37,16,84,94,0),(30,37,16,85,95,0),(31,37,16,86,96,0),(32,37,16,87,97,0),(33,37,17,80,86,0),(34,37,17,80,87,0),(35,37,17,80,88,0),(36,37,17,80,89,0),(37,37,17,80,90,0),(38,37,17,85,95,0),(39,37,18,81,91,0),(40,37,18,82,92,0),(41,37,18,83,93,0),(42,37,18,84,94,0);
/*!40000 ALTER TABLE `sys_roles_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users`
--

DROP TABLE IF EXISTS `sys_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users` (
  `su_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `su_no` varchar(100) DEFAULT NULL,
  `su_sr_id` bigint(20) DEFAULT NULL,
  `su_email` varchar(255) DEFAULT NULL,
  `su_passwd` varchar(255) DEFAULT NULL,
  `su_fullname` varchar(255) DEFAULT NULL,
  `su_avatar` varchar(255) DEFAULT NULL,
  `su_access_token` longtext,
  `su_refresh_token` longtext,
  `su_sex` varchar(30) DEFAULT NULL,
  `su_pob` varchar(100) DEFAULT NULL,
  `su_dob` date DEFAULT NULL,
  `su_scp_id` int(11) DEFAULT NULL,
  `su_sdp_id` int(11) DEFAULT NULL,
  `su_grade` varchar(100) DEFAULT NULL,
  `su_sj_id` int(11) DEFAULT NULL,
  `su_active` int(11) DEFAULT '0',
  `su_created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `su_created_by` varchar(50) DEFAULT 'system',
  `su_invite_token` longtext,
  `su_recover_token` longtext,
  `su_validation` varchar(255) DEFAULT NULL,
  `su_ticket` int(11) DEFAULT NULL,
  PRIMARY KEY (`su_id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users`
--

LOCK TABLES `sys_users` WRITE;
/*!40000 ALTER TABLE `sys_users` DISABLE KEYS */;
INSERT INTO `sys_users` VALUES (1,'197109012005012005',4,'admin@pusdikadm.xyz','$2y$08$T2h2cWZaU0lIWUpoMFBKSuwWvsjYotQZm5i7AJntaEAOZ2cymi/iu','Administrator','default-avatar-ginger-guy.png','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTcwMjk2NzAsImp0aSI6Ikp4eTh6bHhFYUZtaVFUcmxhTWZPRXhURmxYdmhid29JenpyNlB1RlV6alE9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNzAyOTY3MSwiZXhwIjoxNTE3MTEzNjcxLCJkYXRhIjp7InN1X2VtYWlsIjoiYWRtaW5AcHVzZGlrYWRtLnh5eiIsInN1X3NyX2lkIjoiNCJ9fQ.XdrtPlNoqROyVO0KM7gCUBDE2KkOItvy6jgosc3H3Kbl18-JQ_g31c3rdfnO-bw_QCUKxST7ASHOQTHKonhIpA','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTcwMjk2NzAsImp0aSI6Ikt5Z0VoSitDUzMxWVJlZnRrOVBuR0dcL2VYYkVNNVRYc0tVR1JDZlJleFg0PSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTcwMjk2NzEsImV4cCI6MTUxNzEzNzY3MSwiZGF0YSI6bnVsbH0.TVV1VzyvXXJFPBTMZJ5rNS_wkrGJw9emr9drjt3p8-dVAYdSuMCJjmj5CTA2Apmt5oMj-K_M_p1E99zU5fUUcw','Laki-laki','Banyumas','1985-07-03',1,1,'Penata, III/C',1,1,'2017-04-27 13:52:36','system',NULL,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTU2MjQ1NjgsImp0aSI6ImlJbE1VOXdaUGpmd2ZUbk9hMkdUK0oyQlVNTDZCa09oSkx1VFpJa2pCZVU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNTYyNDU2OSwiZXhwIjoxNTE1NzA4NTY5LCJkYXRhIjp7InN1X2VtYWlsIjoicm9zb0BrY3QuY28uaWQifX0.o1iI7ZWpATPgALV2P6Frdv09XcMnuIAWd6lImKyZqQN6Y5xp-_JhHC1nxDppVMEUs9qIBOFc8KNHHpBiYM-KZw',NULL,NULL),(2,NULL,7,'eselon4@pusdikadm.xyz','$2y$08$UWRzU3lrK0NFekprSWdpVelnCWtgEvCMORxnS3kSjUEGzBxxBx1lK','User Eselon IV','default-avatar-male_12.png','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY4NDQwMDcsImp0aSI6InNcL0ZObWJWS3dnXC9kVU4rcnNrNlhFMnRzcVl2S3I1OWkrVWhQckl3V1ErOD0iLCJpc3MiOiJLcmVhc2luZG8gQ2lwdGEgVGVrbm9sb2dpIiwibmJmIjoxNTE2ODQ0MDA4LCJleHAiOjE1MTY5MjgwMDgsImRhdGEiOnsic3VfZW1haWwiOiJ2aWRpQGtjdC5jby5pZCIsInN1X3NyX2lkIjoiNyJ9fQ.izKMm0aLfoJoRkKNrjNLjTxix73U_k8wUCBlgvARVCDHKYvde6vSb07fSMV60GP-Y7_FRfLWhAp0ukHgv_kVIg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY4NDQwMDcsImp0aSI6IlYwcWlJOTh3Vm5kTjhcLzlwbEl4dEFDdlVvaGRKb21RbGVXRUhJaElnaFFNPSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTY4NDQwMDgsImV4cCI6MTUxNjk1MjAwOCwiZGF0YSI6bnVsbH0.kYEcH0jp-WfSSKWS7DjWGMh8wWgtrJyiZWP-wsYbizo863CVS8esNIrDDtdr2dacXjwaFF2-Wwj6XM7MMNKZhA','Female','Cilacap',NULL,1,1,NULL,1,1,'2017-05-03 22:55:15','system',NULL,NULL,NULL,NULL),(3,NULL,16,'eselon3@pusdikadm.xyz','$2y$08$NkpiM3VlR3JlNFZqU2hsceEVsA410evwpUesAl.GKYGKxfehDXEWW','User Eselon III','defaults/avatar-0.jpg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTM4MDIxMzcsImp0aSI6Ilp6dXR6SktJaUR3NGNYM0JcL0dcL1dXS280XC9Qb001bmhNd3dPUlNQK1lCcFk9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxMzgwMjEzOCwiZXhwIjoxNTEzODg2MTM4LCJkYXRhIjp7InN1X2VtYWlsIjoiY2FoeWFAa2N0LmNvLmlkIiwic3Vfc3JfaWQiOjR9fQ._ARstWVDFeJw2EGcYYa-ALxPMvC_Kt0AoYBY9l2rI09W1nYaVsVW6z014JvO_iL5iGpv62OjbDWb_ZoT0ps4hw','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTM4MDIxMzcsImp0aSI6InlMNXBqQWFNTXgwNW45SVdoWDB0NHh4Tkx1aXJFVmh4XC9CN0FIN3JcL2w3Yz0iLCJpc3MiOiJLcmVhc2luZG8gQ2lwdGEgVGVrbm9sb2dpIiwibmJmIjoxNTEzODAyMTM4LCJleHAiOjE1MTM5MTAxMzgsImRhdGEiOm51bGx9.OWVzLds1_aPnMyEOaWWKC4mpiFZGlD5j4ZcA9YwyASj9w8yzOVFq2m02Jnh_JdLgOIaKWy_yCk-C80-3SfGrBg','Male',NULL,NULL,0,0,NULL,0,1,'2017-05-03 23:24:39','system',NULL,NULL,NULL,NULL),(4,NULL,17,'kapus@pusdikadm.xyz','$2y$08$R25qRXFZQUlZYXBKR0JpeOqrd5lLB0WKsdZBzvv.1dfe9qmXm9OdK','User Kapus','defaults/avatar-0.jpg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0OTM4ODMzMjEsImp0aSI6IlhYaERLUTBSUmtweVBKVEJYbkJNQ3ZaZzU1UnRBWXpiVUVFQkFldEZRZVU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTQ5Mzg4MzMyMiwiZXhwIjoxNDkzOTY3MzIyLCJkYXRhIjp7InN1X2VtYWlsIjoiam9obk','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE0OTM4ODMzMjEsImp0aSI6IktjdFwvRG5pWWZVUlRPY2lTZ1VJVEEwNHFIXC91dlJvYW9cL05vcVJaUmNUanc9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTQ5Mzg4MzMyMiwiZXhwIjoxNDkzOTkxMzIyLCJkYXRhIjpudWxsfQ.rQO76C44g9N','Female',NULL,NULL,NULL,NULL,NULL,NULL,1,'2017-05-04 00:20:15','system',NULL,NULL,NULL,NULL),(16,NULL,18,'staff@pusdikadm.xyz','$2y$08$Y0hZVHJCR2xjWlpHZHlnMuyL5k7KZHUSyvXZV9mzcGjpReuqbkW1S','User Pegawai','defaults/avatar-0.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2017-12-28 21:28:21','system','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTQ0OTY1MDEsImp0aSI6IktTeVpnckMrRnpxXC9veE1CblpVNE9LbU02VlJZMEJQblpHMGZOeUVqVDY4PSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTQ0OTY1MDIsImV4cCI6MTUxNDU4MDUwMiwiZGF0YSI6eyJzdV9lbWFpbCI6Im51cmZhcmlkODkyNEBnbWFpbC5jb20ifX0.nMDmk6apzl5ukFF2gdXQbnXfa8i3rB3r5YmmfI3A4V28RwRypbrYIczaI8eO1ZqWQsZOrnhPyvqYBkH7ZxP99w',NULL,NULL,NULL),(38,'1000000000',4,'roso.sasongko@gmail.com',NULL,'Roso Sasongko','defaults/avatar-0.jpg',NULL,NULL,'Laki-laki','Banyumas','2018-01-26',1,1,NULL,1,0,'2018-01-26 00:41:39','Administrator','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY5Mjk4NTUsImp0aSI6InpldVljTytYQTNqcUxMaU5UTTBxOEhCeWNOQWhVem1PMEVtSzBCY2dZRWc9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNjkyOTg1NiwiZXhwIjoxNTE5NjA4MjU2LCJkYXRhIjp7InN1X2VtYWlsIjoicm9zby5zYXNvbmdrb0BnbWFpbC5jb20ifX0.LD6WPWsqX7ldyMEdOnGy9N_oVe8NlUw9HGk2iXyATL7dzsO5egMxuhy8BRdjvSPE_3Sd2j2-bAQfDkn11wKuvw',NULL,'Informasi data valid',NULL),(44,NULL,4,'nurfarid8924@gmail.com','$2y$08$dk8wcEdFZGdLaXkxS3FOcOBKLTZfkMuMvnYurITvxJqFr4Oln5RCO','Farida','defaults/avatar-0.jpg','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY5MzUzMTMsImp0aSI6IkNuNWNMVUFxZGZhSDVFZ0FRQUpVWHJuZ0FYVFdLNmc3TGwzSVRzR1owMTA9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNjkzNTMxNCwiZXhwIjoxNTE3MDE5MzE0LCJkYXRhIjp7InN1X2VtYWlsIjoibnVyZmFyaWQ4OTI0QGdtYWlsLmNvbSIsInN1X3NyX2lkIjoiNCJ9fQ.MdrIa1kv3of1R3FW1S8TxRPRooI8PRJCsAuiEUWcy9bBA3Br9rKrcRRF3pIkZGyRtf9lmLQgZrqzk9pBPu1VBw','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY5MzUzMTMsImp0aSI6Iml0WW1UQWRKSmZKZ0JsR3BuRTFTT1p1VkJINWROS054T3lmdG45U0plSEU9IiwiaXNzIjoiS3JlYXNpbmRvIENpcHRhIFRla25vbG9naSIsIm5iZiI6MTUxNjkzNTMxNCwiZXhwIjoxNTE3MDQzMzE0LCJkYXRhIjpudWxsfQ.zeyksfoyz9nTGckkc4Gc0CflhXwenoOM5jT8wne35hGEA3laR0UG9SvFBanj-rBYimIgWYZ1W7wugw035jDwuw',NULL,NULL,NULL,NULL,NULL,NULL,NULL,1,'2018-01-26 01:04:11','Administrator',NULL,NULL,'OK',NULL),(45,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2018-01-26 01:41:34','Administrator',NULL,NULL,NULL,NULL),(46,NULL,4,'fauzister@gmail.com',NULL,'Fauzi','defaults/avatar-0.jpg',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2018-01-26 05:09:34','Administrator','eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MTY5NDMzODAsImp0aSI6IlwvMGJ3VFwvTXVcL1ZuUmVUU2E2UjZGY211clBLeTRcL0dPemlGanFlMHF0RXBvPSIsImlzcyI6IktyZWFzaW5kbyBDaXB0YSBUZWtub2xvZ2kiLCJuYmYiOjE1MTY5NDMzODEsImV4cCI6MTUxOTYyMTc4MSwiZGF0YSI6eyJzdV9lbWFpbCI6ImZhdXppc3RlckBnbWFpbC5jb20ifX0.OQBq7nBq2Ikf1fgBSyIUDsRRDrW4PanCp7Z7mSB16w_A8f8XUhPfhfXQLZ120Xmg7NBwMVHrLJ26IranI_b-fQ',NULL,NULL,13),(47,NULL,4,'budi@example.com',NULL,'Naima Sarah Mikayla','defaults/avatar-0.jpg',NULL,NULL,'Perempuan','Temanggung','2018-01-27',1,1,NULL,1,0,'2018-01-27 07:10:46','Administrator',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `sys_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users_kanban`
--

DROP TABLE IF EXISTS `sys_users_kanban`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users_kanban` (
  `suk_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `suk_su_id` bigint(20) DEFAULT NULL,
  `suk_ks_id` bigint(20) DEFAULT NULL,
  `suk_selected` int(11) DEFAULT '0',
  PRIMARY KEY (`suk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users_kanban`
--

LOCK TABLES `sys_users_kanban` WRITE;
/*!40000 ALTER TABLE `sys_users_kanban` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_users_kanban` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users_menus`
--

DROP TABLE IF EXISTS `sys_users_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users_menus` (
  `sum_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sum_su_id` bigint(20) DEFAULT NULL,
  `sum_smn_id` bigint(20) DEFAULT NULL,
  `sum_selected` int(11) DEFAULT '0',
  PRIMARY KEY (`sum_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users_menus`
--

LOCK TABLES `sys_users_menus` WRITE;
/*!40000 ALTER TABLE `sys_users_menus` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_users_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users_permissions`
--

DROP TABLE IF EXISTS `sys_users_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users_permissions` (
  `sup_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `sup_su_id` bigint(20) DEFAULT NULL,
  `sup_smc_id` bigint(20) DEFAULT NULL,
  `sup_selected` int(11) DEFAULT '0',
  PRIMARY KEY (`sup_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users_permissions`
--

LOCK TABLES `sys_users_permissions` WRITE;
/*!40000 ALTER TABLE `sys_users_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sys_users_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sys_users_statuses`
--

DROP TABLE IF EXISTS `sys_users_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sys_users_statuses` (
  `sus_id` int(11) NOT NULL AUTO_INCREMENT,
  `sus_sp_id` int(11) DEFAULT NULL,
  `sus_su_id` int(11) DEFAULT NULL,
  `sus_kp_id` int(11) DEFAULT NULL,
  `sus_kst_id` int(11) DEFAULT NULL,
  `sus_checked` int(1) DEFAULT '0',
  PRIMARY KEY (`sus_id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sys_users_statuses`
--

LOCK TABLES `sys_users_statuses` WRITE;
/*!40000 ALTER TABLE `sys_users_statuses` DISABLE KEYS */;
INSERT INTO `sys_users_statuses` VALUES (31,37,1,80,86,1),(32,37,1,80,87,1),(33,37,1,80,88,0),(34,37,1,80,89,0),(35,37,1,80,90,0),(36,37,1,81,91,1),(37,37,1,82,92,0),(38,37,1,83,93,0),(39,37,1,84,94,0),(40,37,1,85,95,0),(41,37,1,86,96,0),(42,37,1,87,97,0);
/*!40000 ALTER TABLE `sys_users_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_lkh`
--

DROP TABLE IF EXISTS `trx_lkh`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_lkh` (
  `lkh_id` int(11) NOT NULL AUTO_INCREMENT,
  `lkh_date` date DEFAULT NULL,
  `lkh_su_id` int(11) DEFAULT NULL,
  `lkh_volume` int(11) DEFAULT NULL,
  `lkh_desc` text,
  `lkh_valid` int(1) DEFAULT '1',
  PRIMARY KEY (`lkh_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_lkh`
--

LOCK TABLES `trx_lkh` WRITE;
/*!40000 ALTER TABLE `trx_lkh` DISABLE KEYS */;
INSERT INTO `trx_lkh` VALUES (1,'2018-01-26',1,5,'<p>Mencari berkas dan melengkapi data diklat teknis<br></p>',1),(2,'2018-01-24',1,1,'<p>Kosong</p>',0),(3,'2018-01-09',1,NULL,'<p><ul><li>Mengisi A</li><li>Mengisi B</li><li>Mengisi C</li></ul></p>',1),(4,'2018-01-10',1,3,'<p></p><ul><li>Mengerjakan ini</li><li>Mengerjakan itu</li><li>Mengerjakan ini dan itu</li></ul><p></p>',1);
/*!40000 ALTER TABLE `trx_lkh` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_lkh_check`
--

DROP TABLE IF EXISTS `trx_lkh_check`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_lkh_check` (
  `lkc_id` int(11) NOT NULL AUTO_INCREMENT,
  `lkc_su_id` int(11) DEFAULT NULL,
  `lkc_date` date DEFAULT NULL,
  PRIMARY KEY (`lkc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_lkh_check`
--

LOCK TABLES `trx_lkh_check` WRITE;
/*!40000 ALTER TABLE `trx_lkh_check` DISABLE KEYS */;
INSERT INTO `trx_lkh_check` VALUES (1,1,'2018-01-26'),(2,38,'2018-01-26'),(3,1,'2018-01-26'),(4,1,'2018-01-26'),(5,NULL,NULL);
/*!40000 ALTER TABLE `trx_lkh_check` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_tasks`
--

DROP TABLE IF EXISTS `trx_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_tasks` (
  `tt_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tt_title` varchar(255) DEFAULT NULL,
  `tt_flag` varchar(255) DEFAULT NULL,
  `tt_sp_id` bigint(20) DEFAULT NULL,
  `tt_desc` longtext,
  `tt_due_date` date DEFAULT NULL,
  `tt_data_id` int(11) DEFAULT NULL,
  `tt_creator_id` bigint(20) DEFAULT NULL,
  `tt_created_dt` datetime DEFAULT NULL,
  `tt_query` text,
  PRIMARY KEY (`tt_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_tasks`
--

LOCK TABLES `trx_tasks` WRITE;
/*!40000 ALTER TABLE `trx_tasks` DISABLE KEYS */;
INSERT INTO `trx_tasks` VALUES (1,'Pendaftaran Roso Sasongko','Pendaftaran',39,NULL,'2018-01-24',38,1,'2018-01-26 07:41:39',NULL),(7,'Pendaftaran Farida','Pendaftaran',39,NULL,'2018-01-24',44,1,'2018-01-26 08:04:10',NULL),(8,'Administrator - 26 Jan 2018','Agenda',41,NULL,'2018-12-31',NULL,1,'2018-01-26 11:36:07',NULL),(9,'Administrator - 26 Jan 2018','Agenda',41,NULL,'2018-12-31',1,1,'2018-01-26 11:38:42',NULL),(10,'Administrator - 24 Jan 2018','Agenda',41,NULL,'2018-12-31',2,1,'2018-01-26 11:45:56',NULL),(11,'Administrator - 09 Jan 2018','Agenda',41,NULL,'2018-12-31',3,1,'2018-01-26 12:05:27',NULL),(12,'Administrator - 10 Jan 2018','Agenda',41,NULL,'2018-12-31',4,1,'2018-01-26 12:05:58',NULL),(13,'Pendaftaran Fauzi','Pendaftaran',39,NULL,'2018-01-24',46,1,'2018-01-26 12:09:34',NULL),(14,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',NULL,1,'2018-01-26 14:34:28',NULL),(15,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',NULL,1,'2018-01-26 14:35:21',NULL),(16,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',NULL,1,'2018-01-26 14:35:40',NULL),(17,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',NULL,1,'2018-01-26 14:36:00',NULL),(18,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',1,1,'2018-01-26 14:36:20',NULL),(19,'Roso Sasongko - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',2,1,'2018-01-26 14:41:24',NULL),(20,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',3,1,'2018-01-26 14:50:37',NULL),(21,'Administrator - 26 Jan 2018','Dokumen',45,NULL,'2018-12-31',4,1,'2018-01-26 14:51:30',NULL),(22,'Pendaftaran Naima Sarah Mikayla','Pendaftaran',39,NULL,'2018-01-24',47,1,'2018-01-27 14:10:47','{\"su_email\":\"budi@example.com\",\"su_fullname\":\"Naima Sarah Mikayla\",\"su_sex\":\"Perempuan\",\"su_pob\":\"Temanggung\",\"su_dob\":\"2018-01-27\",\"su_active\":\"0\",\"sr_name\":\"Administator\",\"sr_description\":\"Role untuk pengguna administrator\",\"su_sj_name\":\"Jabatan Fungsional Umum\",\"su_scp_name\":\"Pusdiklat Tenaga Administrasi\",\"su_sdp_name\":\"Badan Litbang dan Diklat Kementerian Agama\"}');
/*!40000 ALTER TABLE `trx_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_tasks_activities`
--

DROP TABLE IF EXISTS `trx_tasks_activities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_tasks_activities` (
  `tta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tta_tt_id` bigint(20) DEFAULT NULL,
  `tta_type` varchar(50) DEFAULT NULL,
  `tta_sender` bigint(20) DEFAULT NULL,
  `tta_created` datetime DEFAULT NULL,
  `tta_data` longtext,
  `tta_file` varchar(255) DEFAULT NULL,
  `tta_icon` varchar(50) DEFAULT NULL,
  `tta_verb` text,
  PRIMARY KEY (`tta_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_tasks_activities`
--

LOCK TABLES `trx_tasks_activities` WRITE;
/*!40000 ALTER TABLE `trx_tasks_activities` DISABLE KEYS */;
INSERT INTO `trx_tasks_activities` VALUES (1,10,'update',1,'2018-01-26 11:46:17','Administrator - 25 Jan 2018',NULL,'image:edit','**[Administrator](profile/1)** mengubah kegiatan beberapa detik yang lalu'),(2,10,'update',1,'2018-01-26 11:49:49','Administrator - 24 Jan 2018',NULL,'image:edit','**[Administrator](profile/1)** mengubah kegiatan beberapa detik yang lalu'),(3,10,'add_label',1,'2018-01-26 12:04:59','[\"17\"]',NULL,'label-outline','**[Administrator](profile/1)** menambahkan label <span style=\"padding: 3px 10px; color: #fff; border-radius: 12px; background-color:var(--paper-amber-500)\">koreksi</span> beberapa detik yang lalu'),(4,9,'add_label',1,'2018-01-26 12:06:35','[\"18\"]',NULL,'label-outline','**[Administrator](profile/1)** menambahkan label <span style=\"padding: 3px 10px; color: #fff; border-radius: 12px; background-color:var(--paper-green-500)\">valid</span> beberapa detik yang lalu'),(5,22,'update',1,'2018-01-27 17:13:28','Pendaftaran Naima Sarah Mikayla',NULL,'image:edit','**[Administrator](profile/1)** mengubah kegiatan beberapa detik yang lalu'),(6,13,'add_label',1,'2018-01-27 19:55:04','[\"17\"]',NULL,'label-outline','**[Administrator](profile/1)** menambahkan label <span style=\"padding: 3px 10px; color: #fff; border-radius: 12px; background-color:var(--paper-amber-500)\">koreksi</span> beberapa detik yang lalu');
/*!40000 ALTER TABLE `trx_tasks_activities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_tasks_comments`
--

DROP TABLE IF EXISTS `trx_tasks_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_tasks_comments` (
  `ttc_tt_id` bigint(20) DEFAULT NULL,
  `ttc_sender` bigint(20) DEFAULT NULL,
  `ttc_message` longtext,
  `ttc_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ttc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_tasks_comments`
--

LOCK TABLES `trx_tasks_comments` WRITE;
/*!40000 ALTER TABLE `trx_tasks_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `trx_tasks_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_tasks_labels`
--

DROP TABLE IF EXISTS `trx_tasks_labels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_tasks_labels` (
  `ttl_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ttl_tt_id` bigint(20) DEFAULT NULL,
  `ttl_sl_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ttl_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_tasks_labels`
--

LOCK TABLES `trx_tasks_labels` WRITE;
/*!40000 ALTER TABLE `trx_tasks_labels` DISABLE KEYS */;
INSERT INTO `trx_tasks_labels` VALUES (1,10,17),(2,9,18),(3,13,17);
/*!40000 ALTER TABLE `trx_tasks_labels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_tasks_statuses`
--

DROP TABLE IF EXISTS `trx_tasks_statuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_tasks_statuses` (
  `tts_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tts_tt_id` bigint(20) DEFAULT NULL,
  `tts_status` bigint(20) DEFAULT NULL,
  `tts_target` bigint(20) DEFAULT NULL,
  `tts_worker` varchar(100) DEFAULT NULL,
  `tts_deleted` int(11) DEFAULT NULL,
  `tts_created` datetime DEFAULT NULL,
  PRIMARY KEY (`tts_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_tasks_statuses`
--

LOCK TABLES `trx_tasks_statuses` WRITE;
/*!40000 ALTER TABLE `trx_tasks_statuses` DISABLE KEYS */;
INSERT INTO `trx_tasks_statuses` VALUES (1,1,704,895,'proses-pendaftaran',1,'2018-01-26 07:41:39'),(2,1,705,896,'proses-pendaftaran',1,'2018-01-26 07:45:16'),(8,7,704,895,'proses-pendaftaran',1,'2018-01-26 08:04:11'),(9,1,706,897,'proses-pendaftaran',0,'2018-01-26 08:24:17'),(10,7,705,896,'proses-pendaftaran',1,'2018-01-26 09:27:38'),(12,7,706,897,'proses-pendaftaran',1,'2018-01-26 09:54:21'),(13,7,708,899,'proses-pendaftaran',0,'2018-01-26 09:55:13'),(14,9,714,908,'proses-dokumen-lkh',1,'2018-01-26 11:38:42'),(15,10,714,908,'proses-dokumen-lkh',1,'2018-01-26 11:45:56'),(16,10,716,910,'proses-dokumen-lkh',1,'2018-01-26 11:50:11'),(17,10,723,908,'proses-dokumen-lkh',0,'2018-01-26 12:01:19'),(18,9,716,910,'proses-dokumen-lkh',1,'2018-01-26 12:01:32'),(19,9,719,911,'proses-dokumen-lkh',0,'2018-01-26 12:01:41'),(20,11,714,908,'proses-dokumen-lkh',0,'2018-01-26 12:05:27'),(21,12,714,908,'proses-dokumen-lkh',1,'2018-01-26 12:05:58'),(22,12,716,910,'proses-dokumen-lkh',0,'2018-01-26 12:06:16'),(23,13,704,895,'proses-pendaftaran',1,'2018-01-26 12:09:34'),(24,13,705,896,'proses-pendaftaran',1,'2018-01-26 12:09:37'),(25,13,706,897,'proses-pendaftaran',0,'2018-01-26 12:09:41'),(26,18,731,922,'proses-periksa-lkh',0,'2018-01-26 14:36:20'),(27,19,731,922,'proses-periksa-lkh',0,'2018-01-26 14:41:24'),(28,20,731,922,'proses-periksa-lkh',0,'2018-01-26 14:50:38'),(29,21,731,922,'proses-periksa-lkh',1,'2018-01-26 14:51:30'),(30,21,732,919,'proses-periksa-lkh',0,'2018-01-26 14:51:32'),(31,21,734,920,'proses-periksa-lkh',0,'2018-01-26 14:51:32'),(32,21,737,923,'proses-periksa-lkh',0,'2018-01-26 14:51:32'),(33,22,704,895,'proses-pendaftaran',0,'2018-01-27 14:10:47');
/*!40000 ALTER TABLE `trx_tasks_statuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trx_tasks_users`
--

DROP TABLE IF EXISTS `trx_tasks_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trx_tasks_users` (
  `ttu_tt_id` bigint(20) DEFAULT NULL,
  `ttu_su_id` bigint(20) DEFAULT NULL,
  `ttu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ttu_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trx_tasks_users`
--

LOCK TABLES `trx_tasks_users` WRITE;
/*!40000 ALTER TABLE `trx_tasks_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `trx_tasks_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-01-28  0:36:51
