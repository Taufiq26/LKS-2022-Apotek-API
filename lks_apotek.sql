# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.1.48-MariaDB-0+deb9u2)
# Database: lks_apotek
# Generation Time: 2022-07-17 05:38:25 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Tbl_AccessToken
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_AccessToken`;

CREATE TABLE `Tbl_AccessToken` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Id_User` int(10) unsigned NOT NULL,
  `Token` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `TokenRelatedToUser` (`Id_User`),
  CONSTRAINT `TokenRelatedToUser` FOREIGN KEY (`Id_User`) REFERENCES `Tbl_User` (`Id_User`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Tbl_AccessToken` WRITE;
/*!40000 ALTER TABLE `Tbl_AccessToken` DISABLE KEYS */;

INSERT INTO `Tbl_AccessToken` (`id`, `Id_User`, `Token`)
VALUES
	(1,1,'da90ceb2-4ec0-435c-9054-720a765b4717'),
	(2,1,'bd63893e-7018-439b-b4d2-9fb20bed2e5f');

/*!40000 ALTER TABLE `Tbl_AccessToken` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Tbl_DataResep
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_DataResep`;

CREATE TABLE `Tbl_DataResep` (
  `Id_Resep` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `No_Resep` varchar(50) NOT NULL DEFAULT '',
  `Tgl_Resep` date NOT NULL,
  `Nama_Dokter` varchar(50) NOT NULL DEFAULT '',
  `Nama_Pasien` varchar(50) NOT NULL DEFAULT '',
  `Nama_ObatDibeli` varchar(50) NOT NULL DEFAULT '',
  `Harga_ObatDibeli` bigint(20) NOT NULL,
  `Jumlah_ObatDibeli` bigint(20) NOT NULL,
  `Id_Pasien` int(11) unsigned NOT NULL,
  PRIMARY KEY (`Id_Resep`),
  KEY `ResepRelatedToPasien` (`Id_Pasien`),
  CONSTRAINT `ResepRelatedToPasien` FOREIGN KEY (`Id_Pasien`) REFERENCES `Tbl_User` (`Id_User`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



# Dump of table Tbl_JenisObat
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_JenisObat`;

CREATE TABLE `Tbl_JenisObat` (
  `Id_JenisObat` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Jenis_Obat` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`Id_JenisObat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Tbl_JenisObat` WRITE;
/*!40000 ALTER TABLE `Tbl_JenisObat` DISABLE KEYS */;

INSERT INTO `Tbl_JenisObat` (`Id_JenisObat`, `Jenis_Obat`)
VALUES
	(1,'Tablet'),
	(2,'Syrup');

/*!40000 ALTER TABLE `Tbl_JenisObat` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Tbl_LogActivity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_LogActivity`;

CREATE TABLE `Tbl_LogActivity` (
  `Id_Log` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `waktu` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `aktifitas` varchar(50) NOT NULL DEFAULT '',
  `Id_User` int(11) unsigned NOT NULL,
  PRIMARY KEY (`Id_Log`),
  KEY `LogRelatedToUser` (`Id_User`),
  CONSTRAINT `LogRelatedToUser` FOREIGN KEY (`Id_User`) REFERENCES `Tbl_User` (`Id_User`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `Tbl_LogActivity` WRITE;
/*!40000 ALTER TABLE `Tbl_LogActivity` DISABLE KEYS */;

INSERT INTO `Tbl_LogActivity` (`Id_Log`, `waktu`, `aktifitas`, `Id_User`)
VALUES
	(1,'2022-07-15 20:44:46','Login Android',1),
	(2,'2022-07-15 22:38:43','Transaksi T001 pada Android',1),
	(3,'2022-07-17 12:52:50','Login pada Android',1);

/*!40000 ALTER TABLE `Tbl_LogActivity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Tbl_Obat
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_Obat`;

CREATE TABLE `Tbl_Obat` (
  `Id_Obat` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Kode_Obat` varchar(50) NOT NULL DEFAULT '',
  `Nama_Obat` varchar(50) NOT NULL DEFAULT '',
  `Expired_Date` date NOT NULL,
  `Jumlah` bigint(20) NOT NULL,
  `Harga` bigint(20) NOT NULL,
  PRIMARY KEY (`Id_Obat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `Tbl_Obat` WRITE;
/*!40000 ALTER TABLE `Tbl_Obat` DISABLE KEYS */;

INSERT INTO `Tbl_Obat` (`Id_Obat`, `Kode_Obat`, `Nama_Obat`, `Expired_Date`, `Jumlah`, `Harga`)
VALUES
	(1,'O001','Paramex','2069-12-31',64,6900),
	(2,'O002','Promag','2069-12-31',64,6900);

/*!40000 ALTER TABLE `Tbl_Obat` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Tbl_Transaksi
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_Transaksi`;

CREATE TABLE `Tbl_Transaksi` (
  `Id_Transaksi` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `No_Transaksi` varchar(50) NOT NULL DEFAULT '',
  `Tgl_Transaksi` date NOT NULL,
  `Nama_Pasien` varchar(50) DEFAULT '',
  `Total_Bayar` bigint(20) NOT NULL,
  `Id_User` int(11) unsigned NOT NULL,
  `Id_JenisObat` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`Id_Transaksi`),
  KEY `TransaksiRelatedToUser` (`Id_User`),
  KEY `TransaksiRelatedToJenisObat` (`Id_JenisObat`),
  CONSTRAINT `TransaksiRelatedToJenisObat` FOREIGN KEY (`Id_JenisObat`) REFERENCES `Tbl_JenisObat` (`Id_JenisObat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TransaksiRelatedToUser` FOREIGN KEY (`Id_User`) REFERENCES `Tbl_User` (`Id_User`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `Tbl_Transaksi` WRITE;
/*!40000 ALTER TABLE `Tbl_Transaksi` DISABLE KEYS */;

INSERT INTO `Tbl_Transaksi` (`Id_Transaksi`, `No_Transaksi`, `Tgl_Transaksi`, `Nama_Pasien`, `Total_Bayar`, `Id_User`, `Id_JenisObat`)
VALUES
	(1,'T001','2022-07-15',NULL,69000,1,1);

/*!40000 ALTER TABLE `Tbl_Transaksi` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Tbl_TransaksiDetail
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_TransaksiDetail`;

CREATE TABLE `Tbl_TransaksiDetail` (
  `Id_TransaksiDetail` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Id_Transaksi` int(11) unsigned NOT NULL,
  `Id_Resep` int(10) unsigned DEFAULT NULL,
  `Id_Obat` int(11) unsigned DEFAULT NULL,
  `Qty_Obat` int(11) DEFAULT NULL,
  `Subtotal` bigint(20) NOT NULL,
  PRIMARY KEY (`Id_TransaksiDetail`),
  KEY `DetailRelatedToTransaksi` (`Id_Transaksi`),
  KEY `DetailRelatedToResep` (`Id_Resep`),
  KEY `DetailRelatedToObat` (`Id_Obat`),
  CONSTRAINT `DetailRelatedToObat` FOREIGN KEY (`Id_Obat`) REFERENCES `Tbl_Obat` (`Id_Obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `DetailRelatedToResep` FOREIGN KEY (`Id_Resep`) REFERENCES `Tbl_DataResep` (`Id_Resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `DetailRelatedToTransaksi` FOREIGN KEY (`Id_Transaksi`) REFERENCES `Tbl_Transaksi` (`Id_Transaksi`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `Tbl_TransaksiDetail` WRITE;
/*!40000 ALTER TABLE `Tbl_TransaksiDetail` DISABLE KEYS */;

INSERT INTO `Tbl_TransaksiDetail` (`Id_TransaksiDetail`, `Id_Transaksi`, `Id_Resep`, `Id_Obat`, `Qty_Obat`, `Subtotal`)
VALUES
	(1,1,NULL,1,5,34500),
	(2,1,NULL,2,5,34500);

/*!40000 ALTER TABLE `Tbl_TransaksiDetail` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table Tbl_User
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_User`;

CREATE TABLE `Tbl_User` (
  `Id_User` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Tipe_User` varchar(50) NOT NULL DEFAULT '',
  `Nama_User` varchar(50) NOT NULL DEFAULT '',
  `Alamat` varchar(150) NOT NULL DEFAULT '',
  `Telepon` varchar(50) NOT NULL DEFAULT '',
  `Username` varchar(50) NOT NULL DEFAULT '',
  `Password` varchar(50) DEFAULT '',
  PRIMARY KEY (`Id_User`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

LOCK TABLES `Tbl_User` WRITE;
/*!40000 ALTER TABLE `Tbl_User` DISABLE KEYS */;

INSERT INTO `Tbl_User` (`Id_User`, `Tipe_User`, `Nama_User`, `Alamat`, `Telepon`, `Username`, `Password`)
VALUES
	(1,'Kasir','Taufik Mulyana','Kamarung','081234567890','taufik','d4305d7ed2ec97107cd6eb8dd4b6f6b7');

/*!40000 ALTER TABLE `Tbl_User` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
