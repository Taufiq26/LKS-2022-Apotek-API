# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.5.5-10.1.48-MariaDB-0+deb9u2)
# Database: lks_apotek
# Generation Time: 2022-07-15 06:16:06 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


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
  `Jumlah_ObatDibeli` bigint(50) NOT NULL,
  `Id_Pasien` int(11) unsigned NOT NULL,
  PRIMARY KEY (`Id_Resep`),
  KEY `ResepRelatedToPasien` (`Id_Pasien`),
  CONSTRAINT `ResepRelatedToPasien` FOREIGN KEY (`Id_Pasien`) REFERENCES `Tbl_User` (`Id_User`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



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



# Dump of table Tbl_Transaksi
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Tbl_Transaksi`;

CREATE TABLE `Tbl_Transaksi` (
  `Id_Transaksi` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `No_Transaksi` varchar(50) NOT NULL DEFAULT '',
  `Tgl_Transaksi` date NOT NULL,
  `Total_Bayar` bigint(20) NOT NULL,
  `Id_User` int(11) unsigned NOT NULL,
  `Id_Obat` int(11) unsigned NOT NULL,
  `Id_Resep` int(11) unsigned NOT NULL,
  PRIMARY KEY (`Id_Transaksi`),
  KEY `TransaksiRelatedToUser` (`Id_User`),
  KEY `TransaksiRelatedToObat` (`Id_Obat`),
  KEY `TransaksiRelatedToResep` (`Id_Resep`),
  CONSTRAINT `TransaksiRelatedToObat` FOREIGN KEY (`Id_Obat`) REFERENCES `Tbl_Obat` (`Id_Obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TransaksiRelatedToResep` FOREIGN KEY (`Id_Resep`) REFERENCES `Tbl_DataResep` (`Id_Resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `TransaksiRelatedToUser` FOREIGN KEY (`Id_User`) REFERENCES `Tbl_User` (`Id_User`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



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




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
