/*
SQLyog Enterprise v13.1.1 (64 bit)
MySQL - 10.4.16-MariaDB : Database - sik
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sik` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `sik`;

/*Table structure for table `admin` */

DROP TABLE IF EXISTS `admin`;

CREATE TABLE `admin` (
  `usere` text DEFAULT NULL,
  `passworde` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `akun_bayar` */

DROP TABLE IF EXISTS `akun_bayar`;

CREATE TABLE `akun_bayar` (
  `nama_bayar` varchar(50) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `ppn` double DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`),
  KEY `akun_bayar_ibfk_1` (`kd_rek`),
  KEY `ppn` (`ppn`),
  CONSTRAINT `akun_bayar_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `akun_penagihan_piutang` */

DROP TABLE IF EXISTS `akun_penagihan_piutang`;

CREATE TABLE `akun_penagihan_piutang` (
  `kd_rek` varchar(15) NOT NULL,
  `nama_bank` varchar(70) DEFAULT NULL,
  `atas_nama` varchar(50) DEFAULT NULL,
  `no_rek` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_rek`),
  CONSTRAINT `akun_penagihan_piutang_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `akun_piutang` */

DROP TABLE IF EXISTS `akun_piutang`;

CREATE TABLE `akun_piutang` (
  `nama_bayar` varchar(50) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  PRIMARY KEY (`nama_bayar`),
  UNIQUE KEY `kd_rek_2` (`kd_rek`,`kd_pj`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `akun_piutang_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `akun_piutang_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ambil_dankes` */

DROP TABLE IF EXISTS `ambil_dankes`;

CREATE TABLE `ambil_dankes` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `ktg` varchar(50) NOT NULL,
  `dankes` double NOT NULL,
  PRIMARY KEY (`id`,`tanggal`),
  KEY `ktg` (`ktg`),
  KEY `dankes` (`dankes`),
  CONSTRAINT `ambil_dankes_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `angsuran_koperasi` */

DROP TABLE IF EXISTS `angsuran_koperasi`;

CREATE TABLE `angsuran_koperasi` (
  `id` int(11) NOT NULL,
  `tanggal_pinjam` date NOT NULL,
  `tanggal_angsur` date NOT NULL,
  `pokok` double NOT NULL,
  `jasa` double NOT NULL,
  PRIMARY KEY (`id`,`tanggal_pinjam`,`tanggal_angsur`),
  KEY `id` (`id`),
  KEY `pokok` (`pokok`),
  KEY `jasa` (`jasa`),
  CONSTRAINT `angsuran_koperasi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `antrian_loket` */

DROP TABLE IF EXISTS `antrian_loket`;

CREATE TABLE `antrian_loket` (
  `kd` int(50) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `noantrian` varchar(50) NOT NULL,
  `postdate` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `antrian_referensi` */

DROP TABLE IF EXISTS `antrian_referensi`;

CREATE TABLE `antrian_referensi` (
  `tanggal_periksa` date NOT NULL,
  `nomor_referensi` varchar(50) NOT NULL,
  PRIMARY KEY (`nomor_referensi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `antriapotek` */

DROP TABLE IF EXISTS `antriapotek`;

CREATE TABLE `antriapotek` (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL,
  KEY `loket` (`loket`) USING BTREE,
  KEY `antrian` (`antrian`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `antrics` */

DROP TABLE IF EXISTS `antrics`;

CREATE TABLE `antrics` (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL,
  KEY `antrian` (`antrian`),
  KEY `loket` (`loket`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `antriloket` */

DROP TABLE IF EXISTS `antriloket`;

CREATE TABLE `antriloket` (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL,
  KEY `loket` (`loket`),
  KEY `antrian` (`antrian`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `antriprioritas` */

DROP TABLE IF EXISTS `antriprioritas`;

CREATE TABLE `antriprioritas` (
  `loket` int(11) NOT NULL,
  `antrian` int(11) NOT NULL,
  KEY `antrian` (`antrian`),
  KEY `loket` (`loket`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `aplicare_ketersediaan_kamar` */

DROP TABLE IF EXISTS `aplicare_ketersediaan_kamar`;

CREATE TABLE `aplicare_ketersediaan_kamar` (
  `kode_kelas_aplicare` varchar(15) NOT NULL DEFAULT '',
  `kd_bangsal` char(5) NOT NULL DEFAULT '',
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL DEFAULT 'Kelas 1',
  `kapasitas` int(11) DEFAULT NULL,
  `tersedia` int(11) DEFAULT NULL,
  `tersediapria` int(11) DEFAULT NULL,
  `tersediawanita` int(11) DEFAULT NULL,
  `tersediapriawanita` int(11) DEFAULT NULL,
  PRIMARY KEY (`kode_kelas_aplicare`,`kd_bangsal`,`kelas`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `kapasitas` (`kapasitas`),
  KEY `tersedia` (`tersedia`),
  KEY `tersediapria` (`tersediapria`),
  KEY `tersediawanita` (`tersediawanita`),
  KEY `tersediapriawanita` (`tersediapriawanita`),
  CONSTRAINT `aplicare_ketersediaan_kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `asuhan_gizi` */

DROP TABLE IF EXISTS `asuhan_gizi`;

CREATE TABLE `asuhan_gizi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` date NOT NULL,
  `antropometri_bb` char(5) DEFAULT NULL,
  `antropometri_tb` char(5) DEFAULT NULL,
  `antropometri_imt` char(5) DEFAULT NULL,
  `antropometri_lla` char(5) DEFAULT NULL,
  `antropometri_tl` char(5) DEFAULT NULL,
  `antropometri_ulna` char(5) NOT NULL,
  `antropometri_bbideal` char(5) NOT NULL,
  `antropometri_bbperu` char(5) NOT NULL,
  `antropometri_tbperu` char(5) NOT NULL,
  `antropometri_bbpertb` char(5) NOT NULL,
  `antropometri_llaperu` char(5) NOT NULL,
  `biokimia` varchar(100) DEFAULT NULL,
  `fisik_klinis` varchar(100) DEFAULT NULL,
  `alergi_telur` enum('Ya','Tidak') DEFAULT NULL,
  `alergi_susu_sapi` enum('Ya','Tidak') DEFAULT NULL,
  `alergi_kacang` enum('Ya','Tidak') DEFAULT NULL,
  `alergi_gluten` enum('Ya','Tidak') DEFAULT NULL,
  `alergi_udang` enum('Ya','Tidak') DEFAULT NULL,
  `alergi_ikan` enum('Ya','Tidak') DEFAULT NULL,
  `alergi_hazelnut` enum('Ya','Tidak') DEFAULT NULL,
  `pola_makan` varchar(100) DEFAULT NULL,
  `riwayat_personal` varchar(100) DEFAULT NULL,
  `diagnosis` varchar(100) DEFAULT NULL,
  `intervensi_gizi` varchar(100) DEFAULT NULL,
  `monitoring_evaluasi` varchar(100) DEFAULT NULL,
  `nip` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tanggal`),
  KEY `nip` (`nip`),
  CONSTRAINT `asuhan_gizi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `asuhan_gizi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `asuransi` */

DROP TABLE IF EXISTS `asuransi`;

CREATE TABLE `asuransi` (
  `stts` char(5) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`),
  KEY `biaya` (`biaya`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `aturan_pakai` */

DROP TABLE IF EXISTS `aturan_pakai`;

CREATE TABLE `aturan_pakai` (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `aturan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`tgl_perawatan`,`jam`,`no_rawat`,`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `aturan_pakai_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `aturan_pakai_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `baca_lab_pa` */

DROP TABLE IF EXISTS `baca_lab_pa`;

CREATE TABLE `baca_lab_pa` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `idpa` varchar(20) DEFAULT NULL,
  `diagnosa_klinik` varchar(50) DEFAULT NULL,
  `makroskopik` varchar(10240) DEFAULT NULL,
  `mikroskopik` varchar(10240) DEFAULT NULL,
  `kesimpulan` varchar(10240) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_periksa`,`jam`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bahasa_pasien` */

DROP TABLE IF EXISTS `bahasa_pasien`;

CREATE TABLE `bahasa_pasien` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_bahasa` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama_bahasa` (`nama_bahasa`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;

/*Table structure for table `balasan_pengaduan` */

DROP TABLE IF EXISTS `balasan_pengaduan`;

CREATE TABLE `balasan_pengaduan` (
  `id_pengaduan` varchar(15) NOT NULL,
  `pesan_balasan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pengaduan`),
  CONSTRAINT `balasan_pengaduan_ibfk_1` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bangsal` */

DROP TABLE IF EXISTS `bangsal`;

CREATE TABLE `bangsal` (
  `kd_bangsal` char(5) NOT NULL,
  `nm_bangsal` varchar(30) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_bangsal`),
  KEY `nm_bangsal` (`nm_bangsal`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bangsal_depo` */

DROP TABLE IF EXISTS `bangsal_depo`;

CREATE TABLE `bangsal_depo` (
  `kd_bangsal` char(5) NOT NULL,
  `nm_bangsal` varchar(30) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_bangsal`),
  KEY `nm_bangsal` (`nm_bangsal`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bank` */

DROP TABLE IF EXISTS `bank`;

CREATE TABLE `bank` (
  `namabank` varchar(50) NOT NULL,
  PRIMARY KEY (`namabank`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `barcode` */

DROP TABLE IF EXISTS `barcode`;

CREATE TABLE `barcode` (
  `id` int(11) NOT NULL,
  `barcode` varchar(25) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode` (`barcode`),
  CONSTRAINT `barcode_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bayar_pemesanan` */

DROP TABLE IF EXISTS `bayar_pemesanan`;

CREATE TABLE `bayar_pemesanan` (
  `tgl_bayar` date DEFAULT NULL,
  `no_faktur` varchar(20) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `no_bukti` varchar(20) DEFAULT NULL,
  UNIQUE KEY `tgl_bayar` (`tgl_bayar`,`no_faktur`),
  KEY `bayar_pemesanan_ibfk_2` (`nip`),
  KEY `bayar_pemesanan_ibfk_3` (`nama_bayar`),
  KEY `bayar_pemesanan_ibfk_1` (`no_faktur`),
  CONSTRAINT `bayar_pemesanan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `pemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bayar_pemesanan_non_medis` */

DROP TABLE IF EXISTS `bayar_pemesanan_non_medis`;

CREATE TABLE `bayar_pemesanan_non_medis` (
  `tgl_bayar` date DEFAULT NULL,
  `no_faktur` varchar(20) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `no_bukti` varchar(20) DEFAULT NULL,
  KEY `tgl_bayar` (`tgl_bayar`),
  KEY `no_faktur` (`no_faktur`),
  KEY `nip` (`nip`),
  KEY `nama_bayar` (`nama_bayar`),
  CONSTRAINT `bayar_pemesanan_non_medis_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `ipsrspemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_non_medis_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `bayar_pemesanan_non_medis_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bayar_piutang` */

DROP TABLE IF EXISTS `bayar_piutang`;

CREATE TABLE `bayar_piutang` (
  `tgl_bayar` date NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `besar_cicilan` double NOT NULL,
  `catatan` varchar(100) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kd_rek` varchar(15) NOT NULL,
  `kd_rek_kontra` varchar(15) NOT NULL,
  PRIMARY KEY (`tgl_bayar`,`no_rkm_medis`,`no_rawat`,`kd_rek`,`kd_rek_kontra`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `nota_piutang` (`no_rawat`),
  KEY `besar_cicilan` (`besar_cicilan`),
  KEY `catatan` (`catatan`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_rek_kontra` (`kd_rek_kontra`),
  CONSTRAINT `bayar_piutang_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `bayar_piutang_ibfk_3` FOREIGN KEY (`kd_rek_kontra`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `beri_bhp_radiologi` */

DROP TABLE IF EXISTS `beri_bhp_radiologi`;

CREATE TABLE `beri_bhp_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `tgl_periksa` (`tgl_periksa`),
  KEY `jam` (`jam`),
  KEY `jumlah` (`jumlah`),
  CONSTRAINT `beri_bhp_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `beri_bhp_radiologi_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON UPDATE CASCADE,
  CONSTRAINT `beri_bhp_radiologi_ibfk_6` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `beri_obat_operasi` */

DROP TABLE IF EXISTS `beri_obat_operasi`;

CREATE TABLE `beri_obat_operasi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_obat` varchar(15) NOT NULL,
  `hargasatuan` double NOT NULL,
  `jumlah` double NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_obat` (`kd_obat`),
  KEY `tanggal` (`tanggal`),
  KEY `hargasatuan` (`hargasatuan`),
  KEY `jumlah` (`jumlah`),
  CONSTRAINT `beri_obat_operasi_ibfk_2` FOREIGN KEY (`kd_obat`) REFERENCES `obatbhp_ok` (`kd_obat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `beri_obat_operasi_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `berkas_digital_perawatan` */

DROP TABLE IF EXISTS `berkas_digital_perawatan`;

CREATE TABLE `berkas_digital_perawatan` (
  `no_rawat` varchar(17) NOT NULL,
  `kode` varchar(10) NOT NULL,
  `lokasi_file` varchar(600) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode`,`lokasi_file`),
  KEY `kode` (`kode`),
  CONSTRAINT `berkas_digital_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `berkas_digital_perawatan_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `master_berkas_digital` (`kode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `berkas_pegawai` */

DROP TABLE IF EXISTS `berkas_pegawai`;

CREATE TABLE `berkas_pegawai` (
  `nik` varchar(20) NOT NULL,
  `tgl_uploud` date NOT NULL,
  `kode_berkas` varchar(10) NOT NULL,
  `berkas` varchar(500) NOT NULL,
  KEY `nik` (`nik`),
  KEY `kode_berkas` (`kode_berkas`),
  CONSTRAINT `berkas_pegawai_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `berkas_pegawai_ibfk_2` FOREIGN KEY (`kode_berkas`) REFERENCES `master_berkas_pegawai` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `biaya_harian` */

DROP TABLE IF EXISTS `biaya_harian`;

CREATE TABLE `biaya_harian` (
  `kd_kamar` varchar(15) NOT NULL,
  `nama_biaya` varchar(50) NOT NULL,
  `besar_biaya` double NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`kd_kamar`,`nama_biaya`),
  KEY `besar_biaya` (`besar_biaya`),
  KEY `jml` (`jml`),
  CONSTRAINT `biaya_harian_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `biaya_sekali` */

DROP TABLE IF EXISTS `biaya_sekali`;

CREATE TABLE `biaya_sekali` (
  `kd_kamar` varchar(15) NOT NULL,
  `nama_biaya` varchar(50) NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`kd_kamar`,`nama_biaya`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `besar_biaya` (`besar_biaya`),
  CONSTRAINT `biaya_sekali_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bidang` */

DROP TABLE IF EXISTS `bidang`;

CREATE TABLE `bidang` (
  `nama` varchar(15) NOT NULL,
  PRIMARY KEY (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `billing` */

DROP TABLE IF EXISTS `billing`;

CREATE TABLE `billing` (
  `noindex` int(11) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_byr` date DEFAULT NULL,
  `no` varchar(50) NOT NULL,
  `nm_perawatan` varchar(200) NOT NULL,
  `pemisah` char(1) NOT NULL,
  `biaya` double NOT NULL,
  `jumlah` double NOT NULL,
  `tambahan` double NOT NULL,
  `totalbiaya` double NOT NULL,
  `status` enum('Laborat','Radiologi','Operasi','Obat','Ranap Dokter','Ranap Dokter Paramedis','Ranap Paramedis','Ralan Dokter','Ralan Dokter Paramedis','Ralan Paramedis','Tambahan','Potongan','Administrasi','Kamar','-','Registrasi','Harian','Service','TtlObat','TtlRanap Dokter','TtlRanap Paramedis','TtlRalan Dokter','TtlRalan Paramedis','TtlKamar','Dokter','Perawat','TtlTambahan','Retur Obat','TtlRetur Obat','Resep Pulang','TtlResep Pulang','TtlPotongan','TtlLaborat','TtlOperasi','TtlRadiologi','Tagihan') DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `status` (`status`),
  KEY `totalbiaya` (`totalbiaya`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `tgl_byr` (`tgl_byr`),
  KEY `no` (`no`),
  KEY `pemisah` (`pemisah`),
  KEY `biaya` (`biaya`),
  KEY `jumlah` (`jumlah`),
  KEY `tambahan` (`tambahan`),
  CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `booking_operasi` */

DROP TABLE IF EXISTS `booking_operasi`;

CREATE TABLE `booking_operasi` (
  `no_rawat` varchar(17) DEFAULT NULL,
  `kode_paket` varchar(15) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam_mulai` time DEFAULT NULL,
  `jam_selesai` time DEFAULT NULL,
  `status` enum('Menunggu','Proses Operasi','Selesai') DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_paket` (`kode_paket`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `booking_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_2` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_operasi_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `booking_periksa` */

DROP TABLE IF EXISTS `booking_periksa`;

CREATE TABLE `booking_periksa` (
  `no_booking` varchar(17) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `nama` varchar(40) DEFAULT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `no_telp` varchar(40) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `kd_poli` varchar(5) DEFAULT NULL,
  `tambahan_pesan` varchar(400) DEFAULT NULL,
  `status` enum('Diterima','Ditolak','Belum Dibalas') NOT NULL,
  `tanggal_booking` datetime NOT NULL,
  PRIMARY KEY (`no_booking`),
  UNIQUE KEY `tanggal` (`tanggal`,`no_telp`),
  KEY `kd_poli` (`kd_poli`),
  CONSTRAINT `booking_periksa_ibfk_1` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `booking_periksa_balasan` */

DROP TABLE IF EXISTS `booking_periksa_balasan`;

CREATE TABLE `booking_periksa_balasan` (
  `no_booking` varchar(17) NOT NULL,
  `balasan` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`no_booking`),
  CONSTRAINT `booking_periksa_balasan_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `booking_periksa_diterima` */

DROP TABLE IF EXISTS `booking_periksa_diterima`;

CREATE TABLE `booking_periksa_diterima` (
  `no_booking` varchar(17) NOT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_booking`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `booking_periksa_diterima_ibfk_1` FOREIGN KEY (`no_booking`) REFERENCES `booking_periksa` (`no_booking`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_periksa_diterima_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `booking_registrasi` */

DROP TABLE IF EXISTS `booking_registrasi`;

CREATE TABLE `booking_registrasi` (
  `tanggal_booking` date DEFAULT NULL,
  `jam_booking` time DEFAULT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `tanggal_periksa` date NOT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `kd_poli` varchar(5) DEFAULT NULL,
  `no_reg` varchar(8) DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `limit_reg` int(1) DEFAULT NULL,
  `waktu_kunjungan` datetime DEFAULT NULL,
  `status` enum('Terdaftar','Belum','Batal','Dokter Berhalangan') DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`,`tanggal_periksa`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `kd_poli` (`kd_poli`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `booking_registrasi_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `booking_registrasi_ibfk_4` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bpjs` */

DROP TABLE IF EXISTS `bpjs`;

CREATE TABLE `bpjs` (
  `stts` char(5) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bpjs_prb` */

DROP TABLE IF EXISTS `bpjs_prb`;

CREATE TABLE `bpjs_prb` (
  `no_sep` varchar(40) NOT NULL,
  `prb` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `bpjs_prb_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bridging_dukcapil` */

DROP TABLE IF EXISTS `bridging_dukcapil`;

CREATE TABLE `bridging_dukcapil` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `no_id` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `bridging_dukcapil_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bridging_inhealth` */

DROP TABLE IF EXISTS `bridging_inhealth`;

CREATE TABLE `bridging_inhealth` (
  `no_sjp` varchar(40) NOT NULL DEFAULT '',
  `no_rawat` varchar(17) DEFAULT NULL,
  `tglsep` datetime DEFAULT NULL,
  `tglrujukan` datetime DEFAULT NULL,
  `no_rujukan` varchar(30) DEFAULT NULL,
  `kdppkrujukan` varchar(12) DEFAULT NULL,
  `nmppkrujukan` varchar(200) DEFAULT NULL,
  `kdppkpelayanan` varchar(12) DEFAULT NULL,
  `nmppkpelayanan` varchar(200) DEFAULT NULL,
  `jnspelayanan` enum('1','2','3','4') DEFAULT NULL,
  `catatan` varchar(100) DEFAULT NULL,
  `diagawal` varchar(10) DEFAULT NULL,
  `nmdiagnosaawal` varchar(100) DEFAULT NULL,
  `diagawal2` varchar(10) NOT NULL,
  `nmdiagnosaawal2` varchar(100) NOT NULL,
  `kdpolitujuan` varchar(5) DEFAULT NULL,
  `nmpolitujuan` varchar(50) DEFAULT NULL,
  `klsrawat` enum('000','100','101','102','103','104','110','200','201','202','203','204','210','300','301','302','303','304','310','311','312','400','401','402','403','404','410','411','412','413','500','510','511','512','610','611','612','613','710','711','712','713','910','911','912','913') DEFAULT NULL,
  `klsdesc` varchar(50) DEFAULT NULL,
  `kdbu` varchar(12) DEFAULT NULL,
  `nmbu` varchar(200) DEFAULT NULL,
  `lakalantas` enum('0','1','2') DEFAULT NULL,
  `lokasilaka` varchar(100) DEFAULT NULL,
  `user` varchar(25) DEFAULT NULL,
  `nomr` varchar(15) DEFAULT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `jkel` enum('LAKI-LAKI','PEREMPUAN') DEFAULT NULL,
  `no_kartu` varchar(25) DEFAULT NULL,
  `tglpulang` datetime DEFAULT NULL,
  `plan` varchar(35) NOT NULL,
  `plandesc` varchar(100) NOT NULL,
  `idakomodasi` varchar(20) DEFAULT NULL,
  `tipesjp` varchar(35) DEFAULT NULL,
  `tipecob` varchar(35) DEFAULT NULL,
  PRIMARY KEY (`no_sjp`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `bridging_inhealth_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bridging_rujukan_bpjs` */

DROP TABLE IF EXISTS `bridging_rujukan_bpjs`;

CREATE TABLE `bridging_rujukan_bpjs` (
  `no_sep` varchar(40) NOT NULL,
  `tglRujukan` date DEFAULT NULL,
  `ppkDirujuk` varchar(20) DEFAULT NULL,
  `nm_ppkDirujuk` varchar(100) DEFAULT NULL,
  `jnsPelayanan` enum('1','2') DEFAULT NULL,
  `catatan` varchar(200) DEFAULT NULL,
  `diagRujukan` varchar(10) DEFAULT NULL,
  `nama_diagRujukan` varchar(400) DEFAULT NULL,
  `tipeRujukan` enum('0. Penuh','1. Partial','2. Rujuk Balik') DEFAULT NULL,
  `poliRujukan` varchar(15) DEFAULT NULL,
  `nama_poliRujukan` varchar(50) DEFAULT NULL,
  `no_rujukan` varchar(40) DEFAULT NULL,
  `user` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `bridging_rujukan_bpjs_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `bridging_sep` */

DROP TABLE IF EXISTS `bridging_sep`;

CREATE TABLE `bridging_sep` (
  `no_sep` varchar(40) NOT NULL DEFAULT '',
  `no_rawat` varchar(17) DEFAULT NULL,
  `tglsep` date DEFAULT NULL,
  `tglrujukan` date DEFAULT NULL,
  `no_rujukan` varchar(40) DEFAULT NULL,
  `kdppkrujukan` varchar(12) DEFAULT NULL,
  `nmppkrujukan` varchar(200) DEFAULT NULL,
  `kdppkpelayanan` varchar(12) DEFAULT NULL,
  `nmppkpelayanan` varchar(200) DEFAULT NULL,
  `jnspelayanan` enum('1','2') DEFAULT NULL,
  `catatan` varchar(100) DEFAULT NULL,
  `diagawal` varchar(10) DEFAULT NULL,
  `nmdiagnosaawal` varchar(400) DEFAULT NULL,
  `kdpolitujuan` varchar(15) DEFAULT NULL,
  `nmpolitujuan` varchar(50) DEFAULT NULL,
  `klsrawat` enum('1','2','3') DEFAULT NULL,
  `lakalantas` enum('0','1') DEFAULT NULL,
  `user` varchar(25) DEFAULT NULL,
  `nomr` varchar(15) DEFAULT NULL,
  `nama_pasien` varchar(100) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `peserta` varchar(100) DEFAULT NULL,
  `jkel` enum('L','P') DEFAULT NULL,
  `no_kartu` varchar(25) DEFAULT NULL,
  `tglpulang` datetime DEFAULT NULL,
  `asal_rujukan` enum('1. Faskes 1','2. Faskes 2(RS)') NOT NULL,
  `eksekutif` enum('0. Tidak','1.Ya') NOT NULL,
  `cob` enum('0. Tidak','1.Ya') NOT NULL,
  `penjamin` varchar(15) NOT NULL,
  `notelep` varchar(40) NOT NULL,
  `katarak` enum('0. Tidak','1.Ya') NOT NULL,
  `tglkkl` date NOT NULL,
  `keterangankkl` varchar(100) NOT NULL,
  `suplesi` enum('0. Tidak','1.Ya') NOT NULL,
  `no_sep_suplesi` varchar(40) NOT NULL,
  `kdprop` varchar(10) NOT NULL,
  `nmprop` varchar(50) NOT NULL,
  `kdkab` varchar(10) NOT NULL,
  `nmkab` varchar(50) NOT NULL,
  `kdkec` varchar(10) NOT NULL,
  `nmkec` varchar(50) NOT NULL,
  `noskdp` varchar(6) NOT NULL,
  `kddpjp` varchar(10) NOT NULL,
  `nmdpdjp` varchar(100) NOT NULL,
  PRIMARY KEY (`no_sep`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `bridging_sep_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `cacat_fisik` */

DROP TABLE IF EXISTS `cacat_fisik`;

CREATE TABLE `cacat_fisik` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_cacat` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama_cacat` (`nama_cacat`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Table structure for table `catatan_pasien` */

DROP TABLE IF EXISTS `catatan_pasien`;

CREATE TABLE `catatan_pasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `catatan` text DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `catatan_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `catatan_perawatan` */

DROP TABLE IF EXISTS `catatan_perawatan`;

CREATE TABLE `catatan_perawatan` (
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `no_rawat` varchar(17) DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `catatan` varchar(700) DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `catatan_perawatan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `catatan_perawatan_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `closing_kasir` */

DROP TABLE IF EXISTS `closing_kasir`;

CREATE TABLE `closing_kasir` (
  `shift` enum('Pagi','Siang','Sore','Malam') NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`),
  KEY `jam_masuk` (`jam_masuk`),
  KEY `jam_pulang` (`jam_pulang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `comments` */

DROP TABLE IF EXISTS `comments`;

CREATE TABLE `comments` (
  `cid` int(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `comment` mediumtext NOT NULL,
  `cpid` int(9) NOT NULL,
  `commented_date` varchar(20) NOT NULL,
  PRIMARY KEY (`cid`),
  KEY `cpid` (`cpid`),
  KEY `cid` (`cid`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`cpid`) REFERENCES `posts` (`pid`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `cssd_barang` */

DROP TABLE IF EXISTS `cssd_barang`;

CREATE TABLE `cssd_barang` (
  `no_inventaris` varchar(30) NOT NULL,
  `jenis_barang` enum('Heacting Set','Partus Set','Set Bedah') DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`),
  CONSTRAINT `cssd_barang_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `dansos` */

DROP TABLE IF EXISTS `dansos`;

CREATE TABLE `dansos` (
  `dana` double NOT NULL,
  PRIMARY KEY (`dana`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_batch` */

DROP TABLE IF EXISTS `data_batch`;

CREATE TABLE `data_batch` (
  `no_batch` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `tgl_beli` date NOT NULL,
  `tgl_kadaluarsa` date NOT NULL,
  `asal` enum('Penerimaan','Pengadaan','Hibah') NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `dasar` double NOT NULL,
  `h_beli` double DEFAULT NULL,
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL,
  `jumlahbeli` double NOT NULL,
  `sisa` double NOT NULL,
  PRIMARY KEY (`no_batch`,`kode_brng`,`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `data_batch_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_hais` */

DROP TABLE IF EXISTS `data_hais`;

CREATE TABLE `data_hais` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `ETT` int(11) DEFAULT NULL,
  `CVL` int(11) DEFAULT NULL,
  `IVL` int(11) DEFAULT NULL,
  `UC` int(11) DEFAULT NULL,
  `VAP` int(11) DEFAULT NULL,
  `IAD` int(11) DEFAULT NULL,
  `PLEB` int(11) DEFAULT NULL,
  `ISK` int(11) DEFAULT NULL,
  `ILO` int(11) NOT NULL,
  `HAP` int(11) DEFAULT NULL,
  `Tinea` int(11) DEFAULT NULL,
  `Scabies` int(11) DEFAULT NULL,
  `DEKU` enum('IYA','TIDAK') DEFAULT NULL,
  `SPUTUM` varchar(200) DEFAULT NULL,
  `DARAH` varchar(200) DEFAULT NULL,
  `URINE` varchar(200) DEFAULT NULL,
  `ANTIBIOTIK` varchar(200) DEFAULT NULL,
  `kd_kamar` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`) USING BTREE,
  KEY `no_rawat` (`no_rawat`) USING BTREE,
  KEY `ETT` (`ETT`) USING BTREE,
  KEY `CVL` (`CVL`) USING BTREE,
  KEY `IVL` (`IVL`) USING BTREE,
  KEY `SPUTUM` (`SPUTUM`) USING BTREE,
  KEY `ANTIBIOTIK` (`ANTIBIOTIK`) USING BTREE,
  KEY `DARAH` (`DARAH`) USING BTREE,
  KEY `URINE` (`URINE`) USING BTREE,
  KEY `DEKU` (`DEKU`) USING BTREE,
  KEY `ISK` (`ISK`) USING BTREE,
  KEY `PLEB` (`PLEB`) USING BTREE,
  KEY `IAD` (`IAD`) USING BTREE,
  KEY `VAP` (`VAP`) USING BTREE,
  KEY `UC` (`UC`) USING BTREE,
  KEY `ILO` (`ILO`) USING BTREE,
  KEY `kd_kamar` (`kd_kamar`) USING BTREE,
  CONSTRAINT `data_HAIs_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_HAIs_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `data_klasifikasi` */

DROP TABLE IF EXISTS `data_klasifikasi`;

CREATE TABLE `data_klasifikasi` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `Minimal` enum('IYA','TIDAK') DEFAULT NULL,
  `Partial` enum('IYA','TIDAK') DEFAULT NULL,
  `Total` enum('IYA','TIDAK') DEFAULT NULL,
  `kd_kamar` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `DEKU` (`Partial`),
  KEY `kd_kamar` (`kd_kamar`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_tb` */

DROP TABLE IF EXISTS `data_tb`;

CREATE TABLE `data_tb` (
  `no_rawat` varchar(17) NOT NULL,
  `id_tb_03` varchar(30) DEFAULT NULL,
  `id_periode_laporan` enum('1=Januari - Maret','2=April - Juni','3=Juli - September','4=Oktober - Desember') DEFAULT NULL,
  `tanggal_buat_laporan` datetime DEFAULT NULL,
  `tahun_buat_laporan` year(4) DEFAULT NULL,
  `kd_wasor` int(11) DEFAULT NULL,
  `noregkab` int(11) DEFAULT NULL,
  `id_propinsi` varchar(15) DEFAULT NULL,
  `kd_kabupaten` varchar(15) DEFAULT NULL,
  `id_kecamatan` varchar(15) DEFAULT NULL,
  `id_kelurahan` varchar(15) DEFAULT NULL,
  `nama_rujukan` enum('Inisiatif pasien/Keluarga','Anggota Masyarakat/Kader','Faskes','Dokter Praktek Mandiri','Poli lain','Lain-lain') DEFAULT NULL,
  `sebutkan1` varchar(100) DEFAULT NULL,
  `tipe_diagnosis` enum('Terkonfirmasi bakteriologis','Terdiagnosis klinis') DEFAULT NULL,
  `klasifikasi_lokasi_anatomi` enum('Paru','Ekstraparu') DEFAULT NULL,
  `klasifikasi_riwayat_pengobatan` enum('Baru','Kambuh','Diobati setelah gagal','Diobati Setelah Putus Berobat','Lain-lain','Riwayat Pengobatan Sebelumnya Tidak Diketahui','Pindahan') DEFAULT NULL,
  `klasifikasi_status_hiv` enum('Positif','Negatif','Tidak diketahui') DEFAULT NULL,
  `total_skoring_anak` enum('1','2','3','4','5','6','7','8','9','10','11','12','13','Tidak dilakukan') DEFAULT NULL,
  `konfirmasiSkoring5` enum('Uji Tuberkulin Positif','Ada Kontak TB Paru','Uji Tuberkulin Negatif','Tidak Ada Kontak TB Paru') DEFAULT NULL,
  `konfirmasiSkoring6` enum('Ada Kontak TB Paru','Tidak Ada','Tidak Jelas Kontak TB Paru') DEFAULT NULL,
  `tanggal_mulai_pengobatan` date DEFAULT NULL,
  `paduan_oat` varchar(500) DEFAULT NULL,
  `sumber_obat` enum('Program TB','Bayar Sendiri','Asuransi','Lain-lain') DEFAULT NULL,
  `sebutkan` varchar(500) DEFAULT NULL,
  `sebelum_pengobatan_hasil_mikroskopis` enum('Positif','Negatif','Tidak dilakukan') DEFAULT NULL,
  `sebelum_pengobatan_hasil_tes_cepat` enum('Rif sensitif','Rif resisten','Negatif','Rif Indeterminated','Invalid','Error','No Result','Tidak dilakukan') DEFAULT NULL,
  `sebelum_pengobatan_hasil_biakan` enum('Negatif','1-19 BTA','1+','2+','3+','4+','NTM','Kontaminasi','Tidak dilakukan') DEFAULT NULL,
  `noreglab_bulan_2` varchar(15) DEFAULT NULL,
  `hasil_mikroskopis_bulan_2` enum('Positif','Negatif','Tidak dilakukan') DEFAULT NULL,
  `noreglab_bulan_3` varchar(15) DEFAULT NULL,
  `hasil_mikroskopis_bulan_3` enum('Positif','Negatif','Tidak dilakukan') DEFAULT NULL,
  `noreglab_bulan_5` varchar(15) DEFAULT NULL,
  `hasil_mikroskopis_bulan_5` enum('Positif','Negatif','Tidak dilakukan') DEFAULT NULL,
  `akhir_pengobatan_noreglab` varchar(15) DEFAULT NULL,
  `akhir_pengobatan_hasil_mikroskopis` enum('Positif','Negatif','Tidak dilakukan') DEFAULT NULL,
  `tanggal_hasil_akhir_pengobatan` date DEFAULT NULL,
  `hasil_akhir_pengobatan` enum('Sembuh','Pengobatan Lengkap','Lost To Follow Up','Meninggal','Gagal','Pindah') DEFAULT NULL,
  `tanggal_dianjurkan_tes` date DEFAULT NULL,
  `tanggal_tes_hiv` date DEFAULT NULL,
  `hasil_tes_hiv` enum('Reaktif','Non Reaktif','Indeterminated') DEFAULT NULL,
  `ppk` enum('Ya','Tidak') DEFAULT NULL,
  `art` enum('Ya','Tidak') DEFAULT NULL,
  `tb_dm` enum('Ya','Tidak') DEFAULT NULL,
  `terapi_dm` enum('OHO','Inj. Insulin','') DEFAULT NULL,
  `pindah_ro` enum('Ya','Tidak') DEFAULT NULL,
  `status_pengobatan` enum('Sesuai Standar','Tidak Sesuai Standar') DEFAULT NULL,
  `foto_toraks` enum('Positif','Negatif','Tidak Dilakukan') DEFAULT NULL,
  `toraks_tdk_dilakukan` enum('Tidak dilakukan','Setelah terapi antibioka non OAT: tidak ada perbaikan Klinis, ada faktor resiko TB, dan atas pertimbangan dokter','Setelah terapi antibioka non OAT: ada Perbaikan Klinis') DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `kode_icd_x` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `kode_icd_x` (`kode_icd_x`),
  CONSTRAINT `data_tb_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_tb_ibfk_2` FOREIGN KEY (`kode_icd_x`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igd` */

DROP TABLE IF EXISTS `data_triase_igd`;

CREATE TABLE `data_triase_igd` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_kunjungan` datetime NOT NULL,
  `cara_masuk` enum('Jalan','Brankar','Kursi Roda','Digendong') NOT NULL,
  `alat_transportasi` enum('-','AGD','Sendiri','Swasta') NOT NULL,
  `alasan_kedatangan` enum('Datang Sendiri','Polisi','Rujukan','-') NOT NULL,
  `keterangan_kedatangan` varchar(100) NOT NULL,
  `kode_kasus` varchar(3) NOT NULL,
  `tekanan_darah` varchar(8) NOT NULL,
  `nadi` varchar(3) NOT NULL,
  `pernapasan` varchar(3) NOT NULL,
  `suhu` varchar(5) NOT NULL,
  `saturasi_o2` varchar(3) NOT NULL,
  `nyeri` varchar(5) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `kode_kasus` (`kode_kasus`),
  CONSTRAINT `data_triase_igd_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igd_ibfk_2` FOREIGN KEY (`kode_kasus`) REFERENCES `master_triase_macam_kasus` (`kode_kasus`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igddetail_skala1` */

DROP TABLE IF EXISTS `data_triase_igddetail_skala1`;

CREATE TABLE `data_triase_igddetail_skala1` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_skala1` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_skala1`),
  KEY `data_triase_igddetail_skala1_ibfk_1` (`kode_skala1`),
  CONSTRAINT `data_triase_igddetail_skala1_ibfk_1` FOREIGN KEY (`kode_skala1`) REFERENCES `master_triase_skala1` (`kode_skala1`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala1_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igddetail_skala2` */

DROP TABLE IF EXISTS `data_triase_igddetail_skala2`;

CREATE TABLE `data_triase_igddetail_skala2` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_skala2` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_skala2`),
  KEY `kode_skala2` (`kode_skala2`),
  CONSTRAINT `data_triase_igddetail_skala2_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala2_ibfk_2` FOREIGN KEY (`kode_skala2`) REFERENCES `master_triase_skala2` (`kode_skala2`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igddetail_skala3` */

DROP TABLE IF EXISTS `data_triase_igddetail_skala3`;

CREATE TABLE `data_triase_igddetail_skala3` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_skala3` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_skala3`),
  KEY `kode_skala3` (`kode_skala3`),
  CONSTRAINT `data_triase_igddetail_skala3_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala3_ibfk_2` FOREIGN KEY (`kode_skala3`) REFERENCES `master_triase_skala3` (`kode_skala3`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igddetail_skala4` */

DROP TABLE IF EXISTS `data_triase_igddetail_skala4`;

CREATE TABLE `data_triase_igddetail_skala4` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_skala4` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_skala4`),
  KEY `kode_skala4` (`kode_skala4`),
  CONSTRAINT `data_triase_igddetail_skala4_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala4_ibfk_2` FOREIGN KEY (`kode_skala4`) REFERENCES `master_triase_skala4` (`kode_skala4`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igddetail_skala5` */

DROP TABLE IF EXISTS `data_triase_igddetail_skala5`;

CREATE TABLE `data_triase_igddetail_skala5` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_skala5` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_skala5`),
  KEY `kode_skala5` (`kode_skala5`),
  CONSTRAINT `data_triase_igddetail_skala5_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igddetail_skala5_ibfk_2` FOREIGN KEY (`kode_skala5`) REFERENCES `master_triase_skala5` (`kode_skala5`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igdprimer` */

DROP TABLE IF EXISTS `data_triase_igdprimer`;

CREATE TABLE `data_triase_igdprimer` (
  `no_rawat` varchar(17) NOT NULL,
  `keluhan_utama` varchar(400) NOT NULL,
  `kebutuhan_khusus` enum('-','UPPA','Airborne','Dekontaminan') NOT NULL,
  `catatan` varchar(100) NOT NULL,
  `plan` enum('Ruang Resusitasi','Ruang Kritis') NOT NULL,
  `tanggaltriase` datetime NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`kd_dokter`),
  CONSTRAINT `data_triase_igdprimer_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igdprimer_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `data_triase_igdsekunder` */

DROP TABLE IF EXISTS `data_triase_igdsekunder`;

CREATE TABLE `data_triase_igdsekunder` (
  `no_rawat` varchar(17) NOT NULL,
  `anamnesa_singkat` varchar(400) NOT NULL,
  `catatan` varchar(100) NOT NULL,
  `plan` enum('Zona Kuning','Zona Hijau') NOT NULL,
  `tanggaltriase` datetime NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`kd_dokter`),
  CONSTRAINT `data_triase_igdsekunder_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `data_triase_igdsekunder_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `databarang` */

DROP TABLE IF EXISTS `databarang`;

CREATE TABLE `databarang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(80) DEFAULT NULL,
  `kode_satbesar` char(4) NOT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `letak_barang` varchar(50) DEFAULT NULL,
  `dasar` double NOT NULL,
  `h_beli` double DEFAULT NULL,
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL,
  `stokminimal` double DEFAULT NULL,
  `kdjns` char(4) DEFAULT NULL,
  `isi` double NOT NULL,
  `kapasitas` double NOT NULL,
  `expire` date DEFAULT NULL,
  `status` enum('0','1') NOT NULL,
  `kode_industri` char(5) DEFAULT NULL,
  `kode_kategori` char(4) DEFAULT NULL,
  `kode_golongan` char(4) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `kdjns` (`kdjns`),
  KEY `nama_brng` (`nama_brng`),
  KEY `letak_barang` (`letak_barang`),
  KEY `h_beli` (`h_beli`),
  KEY `h_distributor` (`ralan`),
  KEY `h_grosir` (`kelas1`),
  KEY `h_retail` (`kelas2`),
  KEY `stok` (`stokminimal`),
  KEY `kapasitas` (`kapasitas`),
  KEY `kode_industri` (`kode_industri`),
  KEY `kelas3` (`kelas3`),
  KEY `utama` (`utama`),
  KEY `vip` (`vip`),
  KEY `vvip` (`vvip`),
  KEY `beliluar` (`beliluar`),
  KEY `jualbebas` (`jualbebas`),
  KEY `karyawan` (`karyawan`),
  KEY `expire` (`expire`),
  KEY `status` (`status`),
  KEY `kode_kategori` (`kode_kategori`),
  KEY `kode_golongan` (`kode_golongan`),
  KEY `kode_satbesar` (`kode_satbesar`),
  CONSTRAINT `databarang_ibfk_2` FOREIGN KEY (`kdjns`) REFERENCES `jenis` (`kdjns`) ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_4` FOREIGN KEY (`kode_industri`) REFERENCES `industrifarmasi` (`kode_industri`) ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_5` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_barang` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_6` FOREIGN KEY (`kode_golongan`) REFERENCES `golongan_barang` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `databarang_ibfk_7` FOREIGN KEY (`kode_satbesar`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `datasuplier` */

DROP TABLE IF EXISTS `datasuplier`;

CREATE TABLE `datasuplier` (
  `kode_suplier` char(5) NOT NULL,
  `nama_suplier` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `nama_bank` varchar(30) DEFAULT NULL,
  `rekening` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`),
  KEY `nama_suplier` (`nama_suplier`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `departemen` */

DROP TABLE IF EXISTS `departemen`;

CREATE TABLE `departemen` (
  `dep_id` char(4) NOT NULL,
  `nama` varchar(25) NOT NULL,
  PRIMARY KEY (`dep_id`),
  KEY `nama` (`nama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `deposit` */

DROP TABLE IF EXISTS `deposit`;

CREATE TABLE `deposit` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_deposit` datetime NOT NULL,
  `besar_deposit` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL,
  KEY `nip` (`nip`),
  KEY `besar_deposit` (`besar_deposit`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `deposit_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deposit_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_beri_diet` */

DROP TABLE IF EXISTS `detail_beri_diet`;

CREATE TABLE `detail_beri_diet` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_kamar` varchar(15) NOT NULL,
  `tanggal` date NOT NULL,
  `waktu` enum('Pagi','Siang','Sore','Malam') NOT NULL,
  `kd_diet` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_kamar`,`tanggal`,`waktu`,`kd_diet`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `kd_diet` (`kd_diet`),
  KEY `tanggal` (`tanggal`),
  KEY `waktu` (`waktu`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `detail_beri_diet_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_5` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_beri_diet_ibfk_6` FOREIGN KEY (`kd_diet`) REFERENCES `diet` (`kd_diet`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_nota_inap` */

DROP TABLE IF EXISTS `detail_nota_inap`;

CREATE TABLE `detail_nota_inap` (
  `no_rawat` varchar(17) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `besarppn` double DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `nama_bayar` (`nama_bayar`),
  KEY `besarppn` (`besarppn`),
  KEY `besar_bayar` (`besar_bayar`),
  CONSTRAINT `detail_nota_inap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_nota_inap_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_nota_jalan` */

DROP TABLE IF EXISTS `detail_nota_jalan`;

CREATE TABLE `detail_nota_jalan` (
  `no_rawat` varchar(17) NOT NULL,
  `nama_bayar` varchar(50) NOT NULL,
  `besarppn` double DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`nama_bayar`),
  KEY `no_rawat` (`no_rawat`),
  KEY `nama_bayar` (`nama_bayar`),
  KEY `besarppn` (`besarppn`),
  KEY `besar_bayar` (`besar_bayar`),
  CONSTRAINT `detail_nota_jalan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_nota_jalan_ibfk_2` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_obat_racikan` */

DROP TABLE IF EXISTS `detail_obat_racikan`;

CREATE TABLE `detail_obat_racikan` (
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `no_racik` varchar(2) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  PRIMARY KEY (`tgl_perawatan`,`jam`,`no_rawat`,`no_racik`,`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `detail_obat_racikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_obat_racikan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_obat_racikan_jual` */

DROP TABLE IF EXISTS `detail_obat_racikan_jual`;

CREATE TABLE `detail_obat_racikan_jual` (
  `nota_jual` varchar(20) NOT NULL,
  `no_racik` varchar(2) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  PRIMARY KEY (`nota_jual`,`no_racik`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `detail_obat_racikan_jual_ibfk_1` FOREIGN KEY (`nota_jual`) REFERENCES `penjualan` (`nota_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_obat_racikan_jual_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_pemberian_obat` */

DROP TABLE IF EXISTS `detail_pemberian_obat`;

CREATE TABLE `detail_pemberian_obat` (
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam` time NOT NULL DEFAULT '00:00:00',
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL,
  `h_beli` double DEFAULT NULL,
  `biaya_obat` double DEFAULT NULL,
  `jml` double NOT NULL,
  `embalase` double DEFAULT NULL,
  `tuslah` double DEFAULT NULL,
  `total` double NOT NULL,
  `status` enum('Ralan','Ranap') DEFAULT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`tgl_perawatan`,`jam`,`no_rawat`,`kode_brng`,`no_batch`,`no_faktur`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_obat` (`kode_brng`),
  KEY `tgl_perawatan` (`tgl_perawatan`),
  KEY `jam` (`jam`),
  KEY `jml` (`jml`),
  KEY `tambahan` (`embalase`),
  KEY `total` (`total`),
  KEY `biaya_obat` (`biaya_obat`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `tuslah` (`tuslah`),
  KEY `status` (`status`),
  CONSTRAINT `detail_pemberian_obat_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pemberian_obat_ibfk_5` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_penagihan_piutang` */

DROP TABLE IF EXISTS `detail_penagihan_piutang`;

CREATE TABLE `detail_penagihan_piutang` (
  `no_tagihan` varchar(17) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `sisapiutang` double NOT NULL,
  PRIMARY KEY (`no_tagihan`,`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `detail_penagihan_piutang_ibfk_1` FOREIGN KEY (`no_tagihan`) REFERENCES `penagihan_piutang` (`no_tagihan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_penagihan_piutang_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_pengajuan_barang_medis` */

DROP TABLE IF EXISTS `detail_pengajuan_barang_medis`;

CREATE TABLE `detail_pengajuan_barang_medis` (
  `no_pengajuan` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pengajuan` double DEFAULT NULL,
  `total` double NOT NULL,
  `jumlah2` double NOT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `no_pengajuan` (`no_pengajuan`),
  CONSTRAINT `detail_pengajuan_barang_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_medis_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_medis_ibfk_3` FOREIGN KEY (`no_pengajuan`) REFERENCES `pengajuan_barang_medis` (`no_pengajuan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_pengajuan_barang_nonmedis` */

DROP TABLE IF EXISTS `detail_pengajuan_barang_nonmedis`;

CREATE TABLE `detail_pengajuan_barang_nonmedis` (
  `no_pengajuan` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pengajuan` double DEFAULT NULL,
  `total` double NOT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `no_pengajuan` (`no_pengajuan`),
  CONSTRAINT `detail_pengajuan_barang_nonmedis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_nonmedis_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_pengajuan_barang_nonmedis_ibfk_3` FOREIGN KEY (`no_pengajuan`) REFERENCES `pengajuan_barang_nonmedis` (`no_pengajuan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_pengeluaran_obat_bhp` */

DROP TABLE IF EXISTS `detail_pengeluaran_obat_bhp`;

CREATE TABLE `detail_pengeluaran_obat_bhp` (
  `no_keluar` varchar(15) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `no_batch` varchar(20) DEFAULT NULL,
  `jumlah` double NOT NULL,
  `harga_beli` double NOT NULL,
  `total` double NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `jumlah` (`jumlah`),
  KEY `harga_beli` (`harga_beli`),
  KEY `total` (`total`),
  KEY `no_keluar` (`no_keluar`),
  CONSTRAINT `detail_pengeluaran_obat_bhp_ibfk_1` FOREIGN KEY (`no_keluar`) REFERENCES `pengeluaran_obat_bhp` (`no_keluar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_pengeluaran_obat_bhp_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_pengeluaran_obat_bhp_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_periksa_lab` */

DROP TABLE IF EXISTS `detail_periksa_lab`;

CREATE TABLE `detail_periksa_lab` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `id_template` int(11) NOT NULL,
  `nilai` varchar(60) NOT NULL,
  `nilai_rujukan` varchar(30) NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_item` double NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`tgl_periksa`,`jam`,`id_template`),
  KEY `id_template` (`id_template`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `tgl_periksa` (`tgl_periksa`),
  KEY `jam` (`jam`),
  KEY `nilai` (`nilai`),
  KEY `nilai_rujukan` (`nilai_rujukan`),
  KEY `keterangan` (`keterangan`),
  KEY `biaya_item` (`biaya_item`),
  KEY `menejemen` (`menejemen`),
  KEY `kso` (`kso`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `bhp` (`bhp`),
  KEY `bagian_perujuk` (`bagian_perujuk`),
  KEY `bagian_dokter` (`bagian_dokter`),
  KEY `bagian_laborat` (`bagian_laborat`),
  CONSTRAINT `detail_periksa_lab_ibfk_10` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_periksa_lab_ibfk_12` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_permintaan_medis` */

DROP TABLE IF EXISTS `detail_permintaan_medis`;

CREATE TABLE `detail_permintaan_medis` (
  `no_permintaan` varchar(20) DEFAULT NULL,
  `kode_brng` varchar(15) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  KEY `no_permintaan` (`no_permintaan`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  CONSTRAINT `detail_permintaan_medis_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_medis` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_medis_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_medis_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_permintaan_non_medis` */

DROP TABLE IF EXISTS `detail_permintaan_non_medis`;

CREATE TABLE `detail_permintaan_non_medis` (
  `no_permintaan` varchar(20) DEFAULT NULL,
  `kode_brng` varchar(15) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  KEY `no_permintaan` (`no_permintaan`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  CONSTRAINT `detail_permintaan_non_medis_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_non_medis` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_non_medis_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_permintaan_non_medis_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_piutang_pasien` */

DROP TABLE IF EXISTS `detail_piutang_pasien`;

CREATE TABLE `detail_piutang_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `nama_bayar` varchar(50) NOT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `totalpiutang` double DEFAULT NULL,
  `sisapiutang` double DEFAULT NULL,
  `tgltempo` date DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`nama_bayar`),
  KEY `nama_bayar` (`nama_bayar`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `detail_piutang_pasien_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `detail_piutang_pasien_ibfk_4` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_piutang` (`nama_bayar`) ON UPDATE CASCADE,
  CONSTRAINT `detail_piutang_pasien_ibfk_5` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_surat_pemesanan_medis` */

DROP TABLE IF EXISTS `detail_surat_pemesanan_medis`;

CREATE TABLE `detail_surat_pemesanan_medis` (
  `no_pemesanan` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pesan` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  `jumlah2` double DEFAULT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_pesan` (`h_pesan`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `no_pemesanan` (`no_pemesanan`),
  CONSTRAINT `detail_surat_pemesanan_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_surat_pemesanan_medis_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_surat_pemesanan_medis_ibfk_3` FOREIGN KEY (`no_pemesanan`) REFERENCES `surat_pemesanan_medis` (`no_pemesanan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detail_surat_pemesanan_non_medis` */

DROP TABLE IF EXISTS `detail_surat_pemesanan_non_medis`;

CREATE TABLE `detail_surat_pemesanan_non_medis` (
  `no_pemesanan` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pesan` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_pesan` (`h_pesan`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `no_pemesanan` (`no_pemesanan`),
  CONSTRAINT `detail_surat_pemesanan_non_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detail_surat_pemesanan_non_medis_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detail_surat_pemesanan_non_medis_ibfk_3` FOREIGN KEY (`no_pemesanan`) REFERENCES `surat_pemesanan_non_medis` (`no_pemesanan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detailbeli` */

DROP TABLE IF EXISTS `detailbeli`;

CREATE TABLE `detailbeli` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `jumlah2` double DEFAULT NULL,
  `kadaluarsa` date DEFAULT NULL,
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_beli` (`h_beli`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `jumlah2` (`jumlah2`),
  CONSTRAINT `detailbeli_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailbeli_ibfk_6` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detailbeli_ibfk_7` FOREIGN KEY (`no_faktur`) REFERENCES `pembelian` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detailhibah_obat_bhp` */

DROP TABLE IF EXISTS `detailhibah_obat_bhp`;

CREATE TABLE `detailhibah_obat_bhp` (
  `no_hibah` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_hibah` double DEFAULT NULL,
  `subtotalhibah` double DEFAULT NULL,
  `h_diakui` double NOT NULL,
  `subtotaldiakui` double NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `jumlah2` double DEFAULT NULL,
  `kadaluarsa` date DEFAULT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `no_hibah` (`no_hibah`),
  CONSTRAINT `detailhibah_obat_bhp_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailhibah_obat_bhp_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detailhibah_obat_bhp_ibfk_3` FOREIGN KEY (`no_hibah`) REFERENCES `hibah_obat_bhp` (`no_hibah`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detailjual` */

DROP TABLE IF EXISTS `detailjual`;

CREATE TABLE `detailjual` (
  `nota_jual` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `tambahan` double DEFAULT NULL,
  `embalase` double NOT NULL,
  `tuslah` double NOT NULL,
  `aturan_pakai` varchar(150) NOT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `h_jual` (`h_jual`),
  KEY `h_beli` (`h_beli`),
  KEY `jumlah` (`jumlah`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `bsr_dis` (`bsr_dis`),
  KEY `tambahan` (`tambahan`),
  KEY `total` (`total`),
  CONSTRAINT `detailjual_ibfk_1` FOREIGN KEY (`nota_jual`) REFERENCES `penjualan` (`nota_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailjual_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailjual_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detailjurnal` */

DROP TABLE IF EXISTS `detailjurnal`;

CREATE TABLE `detailjurnal` (
  `no_jurnal` varchar(20) DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `debet` double DEFAULT NULL,
  `kredit` double DEFAULT NULL,
  KEY `no_jurnal` (`no_jurnal`),
  KEY `kd_rek` (`kd_rek`),
  KEY `debet` (`debet`),
  KEY `kredit` (`kredit`),
  CONSTRAINT `detailjurnal_ibfk_1` FOREIGN KEY (`no_jurnal`) REFERENCES `jurnal` (`no_jurnal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailjurnal_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detailpesan` */

DROP TABLE IF EXISTS `detailpesan`;

CREATE TABLE `detailpesan` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pesan` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `jumlah2` double DEFAULT NULL,
  `kadaluarsa` date DEFAULT NULL,
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_pesan` (`h_pesan`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `jumlah2` (`jumlah2`),
  CONSTRAINT `detailpesan_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailpesan_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `detailpesan_ibfk_3` FOREIGN KEY (`no_faktur`) REFERENCES `pemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detailpiutang` */

DROP TABLE IF EXISTS `detailpiutang`;

CREATE TABLE `detailpiutang` (
  `nota_piutang` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `aturan_pakai` varchar(150) NOT NULL,
  KEY `nota_jual` (`nota_piutang`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `h_jual` (`h_jual`),
  KEY `h_beli` (`h_beli`),
  KEY `jumlah` (`jumlah`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `bsr_dis` (`bsr_dis`),
  KEY `total` (`total`),
  CONSTRAINT `detailpiutang_ibfk_1` FOREIGN KEY (`nota_piutang`) REFERENCES `piutang` (`nota_piutang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailpiutang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detailpiutang_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `deteksi_dini_corona` */

DROP TABLE IF EXISTS `deteksi_dini_corona`;

CREATE TABLE `deteksi_dini_corona` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` date NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `gejala_demam` enum('Ya','Tidak') DEFAULT NULL,
  `gejala_batuk` enum('Ya','Tidak') DEFAULT NULL,
  `gejala_sesak` enum('Ya','Tidak') DEFAULT NULL,
  `gejala_tanggal_pertama` date DEFAULT NULL,
  `gejala_riwayat_sakit` varchar(50) DEFAULT NULL,
  `gejala_riwayat_periksa` varchar(50) DEFAULT NULL,
  `faktor_riwayat_perjalanan` enum('Ya','Tidak') NOT NULL,
  `faktor_asal_daerah` varchar(50) NOT NULL,
  `faktor_tanggal_kedatangan` date NOT NULL,
  `faktor_paparan_kontakpositif` enum('Ya','Tidak') NOT NULL,
  `faktor_paparan_kontakpdp` enum('Ya','Tidak') NOT NULL,
  `faktor_paparan_faskespositif` enum('Ya','Tidak') NOT NULL,
  `faktor_paparan_perjalananln` enum('Ya','Tidak') NOT NULL,
  `faktor_paparan_pasarhewan` enum('Ya','Tidak') NOT NULL,
  `kesimpulan` enum('ODP','PDP','OTG','Bukan ketiganya') NOT NULL,
  `tindak_lanjut` enum('Rujuk','Rawat Inap','Rawat Jalan') NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`nip`),
  CONSTRAINT `deteksi_dini_corona_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `deteksi_dini_corona_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detreturbeli` */

DROP TABLE IF EXISTS `detreturbeli`;

CREATE TABLE `detreturbeli` (
  `no_retur_beli` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jml_beli` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `jml_retur2` double DEFAULT NULL,
  KEY `no_retur_beli` (`no_retur_beli`),
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `h_beli` (`h_beli`),
  KEY `jml_beli` (`jml_beli`),
  KEY `h_retur` (`h_retur`),
  KEY `jml_retur` (`jml_retur`),
  KEY `total` (`total`),
  KEY `jml_retur2` (`jml_retur2`),
  CONSTRAINT `detreturbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturbeli_ibfk_3` FOREIGN KEY (`no_retur_beli`) REFERENCES `returbeli` (`no_retur_beli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturbeli_ibfk_4` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detreturjual` */

DROP TABLE IF EXISTS `detreturjual`;

CREATE TABLE `detreturjual` (
  `no_retur_jual` varchar(20) NOT NULL,
  `nota_jual` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jml_jual` double DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  KEY `no_retur_jual` (`no_retur_jual`),
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jml_jual` (`jml_jual`),
  KEY `h_jual` (`h_jual`),
  KEY `jml_retur` (`jml_retur`),
  KEY `h_retur` (`h_retur`),
  KEY `subtotal` (`subtotal`),
  CONSTRAINT `detreturjual_ibfk_1` FOREIGN KEY (`no_retur_jual`) REFERENCES `returjual` (`no_retur_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturjual_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturjual_ibfk_4` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `detreturpiutang` */

DROP TABLE IF EXISTS `detreturpiutang`;

CREATE TABLE `detreturpiutang` (
  `no_retur_piutang` varchar(20) NOT NULL,
  `nota_piutang` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `jml_piutang` double DEFAULT NULL,
  `h_piutang` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  KEY `no_retur_piutang` (`no_retur_piutang`),
  KEY `nota_piutang` (`nota_piutang`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jml_piutang` (`jml_piutang`),
  KEY `h_piutang` (`h_piutang`),
  KEY `jml_retur` (`jml_retur`),
  KEY `h_retur` (`h_retur`),
  KEY `subtotal` (`subtotal`),
  CONSTRAINT `detreturpiutang_ibfk_4` FOREIGN KEY (`no_retur_piutang`) REFERENCES `returpiutang` (`no_retur_piutang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturpiutang_ibfk_5` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `detreturpiutang_ibfk_6` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `diagnosa_corona` */

DROP TABLE IF EXISTS `diagnosa_corona`;

CREATE TABLE `diagnosa_corona` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `kode_icd` varchar(10) NOT NULL,
  `nama_penyakit` varchar(200) DEFAULT NULL,
  `status` enum('Primer','Sekunder') DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`,`kode_icd`),
  CONSTRAINT `diagnosa_corona_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien_corona` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `diagnosa_pasien` */

DROP TABLE IF EXISTS `diagnosa_pasien`;

CREATE TABLE `diagnosa_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_penyakit` varchar(10) NOT NULL,
  `status` enum('Ralan','Ranap') NOT NULL,
  `prioritas` tinyint(4) NOT NULL,
  `status_penyakit` enum('Lama','Baru') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_penyakit`,`status`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `status` (`status`),
  KEY `prioritas` (`prioritas`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `diagnosa_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `diagnosa_pasien_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `diet` */

DROP TABLE IF EXISTS `diet`;

CREATE TABLE `diet` (
  `kd_diet` varchar(3) NOT NULL,
  `nama_diet` varchar(50) NOT NULL,
  PRIMARY KEY (`kd_diet`),
  KEY `nama_diet` (`nama_diet`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `dokter` */

DROP TABLE IF EXISTS `dokter`;

CREATE TABLE `dokter` (
  `kd_dokter` varchar(20) NOT NULL,
  `nm_dokter` varchar(50) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(20) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `gol_drh` enum('A','B','O','AB','-') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `almt_tgl` varchar(60) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `kd_sps` char(5) DEFAULT NULL,
  `alumni` varchar(60) DEFAULT NULL,
  `no_ijn_praktek` varchar(40) DEFAULT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_dokter`),
  KEY `kd_sps` (`kd_sps`),
  KEY `nm_dokter` (`nm_dokter`),
  KEY `jk` (`jk`),
  KEY `tmp_lahir` (`tmp_lahir`),
  KEY `tgl_lahir` (`tgl_lahir`),
  KEY `gol_drh` (`gol_drh`),
  KEY `agama` (`agama`),
  KEY `almt_tgl` (`almt_tgl`),
  KEY `no_telp` (`no_telp`),
  KEY `stts_nikah` (`stts_nikah`),
  KEY `alumni` (`alumni`),
  KEY `no_ijn_praktek` (`no_ijn_praktek`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `status` (`status`),
  CONSTRAINT `dokter_ibfk_2` FOREIGN KEY (`kd_sps`) REFERENCES `spesialis` (`kd_sps`) ON UPDATE CASCADE,
  CONSTRAINT `dokter_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `pegawai` (`nik`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `dpjp_ranap` */

DROP TABLE IF EXISTS `dpjp_ranap`;

CREATE TABLE `dpjp_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_dokter`),
  KEY `dpjp_ranap_ibfk_2` (`kd_dokter`),
  CONSTRAINT `dpjp_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `dpjp_ranap_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `emergency_index` */

DROP TABLE IF EXISTS `emergency_index`;

CREATE TABLE `emergency_index` (
  `kode_emergency` varchar(3) NOT NULL,
  `nama_emergency` varchar(200) DEFAULT NULL,
  `indek` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`kode_emergency`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `evaluasi_kinerja` */

DROP TABLE IF EXISTS `evaluasi_kinerja`;

CREATE TABLE `evaluasi_kinerja` (
  `kode_evaluasi` varchar(3) NOT NULL,
  `nama_evaluasi` varchar(200) DEFAULT NULL,
  `indek` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`kode_evaluasi`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `evaluasi_kinerja_pegawai` */

DROP TABLE IF EXISTS `evaluasi_kinerja_pegawai`;

CREATE TABLE `evaluasi_kinerja_pegawai` (
  `id` int(11) NOT NULL,
  `kode_evaluasi` varchar(3) NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`,`kode_evaluasi`,`tahun`,`bulan`) USING BTREE,
  KEY `kode_evaluasi` (`kode_evaluasi`) USING BTREE,
  CONSTRAINT `evaluasi_kinerja_pegawai_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `evaluasi_kinerja_pegawai_ibfk_2` FOREIGN KEY (`kode_evaluasi`) REFERENCES `evaluasi_kinerja` (`kode_evaluasi`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `gambar` */

DROP TABLE IF EXISTS `gambar`;

CREATE TABLE `gambar` (
  `inde` int(11) NOT NULL,
  `bpjs` longblob NOT NULL,
  `nyeri` longblob NOT NULL,
  PRIMARY KEY (`inde`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `gambar_radiologi` */

DROP TABLE IF EXISTS `gambar_radiologi`;

CREATE TABLE `gambar_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `lokasi_gambar` varchar(500) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_periksa`,`jam`,`lokasi_gambar`),
  CONSTRAINT `gambar_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `geolocation_presensi` */

DROP TABLE IF EXISTS `geolocation_presensi`;

CREATE TABLE `geolocation_presensi` (
  `id` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `latitude` varchar(200) NOT NULL,
  `longitude` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `geolocation_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `golongan_barang` */

DROP TABLE IF EXISTS `golongan_barang`;

CREATE TABLE `golongan_barang` (
  `kode` char(4) NOT NULL,
  `nama` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `golongan_polri` */

DROP TABLE IF EXISTS `golongan_polri`;

CREATE TABLE `golongan_polri` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_golongan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `golongan_tni` */

DROP TABLE IF EXISTS `golongan_tni`;

CREATE TABLE `golongan_tni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_golongan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `gudangbarang` */

DROP TABLE IF EXISTS `gudangbarang`;

CREATE TABLE `gudangbarang` (
  `kode_brng` varchar(15) NOT NULL,
  `kd_bangsal` char(5) NOT NULL DEFAULT '',
  `stok` double NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`kode_brng`,`kd_bangsal`,`no_batch`,`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `stok` (`stok`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `gudangbarang_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `gudangbarang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `harian_kurangi_bulanan` */

DROP TABLE IF EXISTS `harian_kurangi_bulanan`;

CREATE TABLE `harian_kurangi_bulanan` (
  `harian` int(11) NOT NULL,
  `bulanan` int(11) NOT NULL,
  KEY `harian` (`harian`),
  KEY `bulanan` (`bulanan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `hasil_radiologi` */

DROP TABLE IF EXISTS `hasil_radiologi`;

CREATE TABLE `hasil_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `hasil` text NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_periksa`,`jam`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `hasil_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `hemodialisa` */

DROP TABLE IF EXISTS `hemodialisa`;

CREATE TABLE `hemodialisa` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `lama` varchar(5) DEFAULT NULL,
  `akses` varchar(30) DEFAULT NULL,
  `dialist` varchar(30) DEFAULT NULL,
  `transfusi` varchar(5) DEFAULT NULL,
  `penarikan` varchar(5) DEFAULT NULL,
  `qb` varchar(5) DEFAULT NULL,
  `qd` varchar(5) DEFAULT NULL,
  `ureum` varchar(10) DEFAULT NULL,
  `hb` varchar(10) DEFAULT NULL,
  `hbsag` varchar(10) DEFAULT NULL,
  `creatinin` varchar(10) DEFAULT NULL,
  `hiv` varchar(10) DEFAULT NULL,
  `hcv` varchar(10) DEFAULT NULL,
  `lain` varchar(200) DEFAULT NULL,
  `kd_penyakit` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tanggal`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `hemodialisa_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `hemodialisa_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE,
  CONSTRAINT `hemodialisa_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `hibah_obat_bhp` */

DROP TABLE IF EXISTS `hibah_obat_bhp`;

CREATE TABLE `hibah_obat_bhp` (
  `no_hibah` varchar(20) NOT NULL,
  `kode_pemberi` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_hibah` date DEFAULT NULL,
  `totalhibah` double NOT NULL,
  `totalnilai` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_hibah`),
  KEY `kode_pemberi` (`kode_pemberi`),
  KEY `nip` (`nip`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `hibah_obat_bhp_ibfk_1` FOREIGN KEY (`kode_pemberi`) REFERENCES `pemberihibah` (`kode_pemberi`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hibah_obat_bhp_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `hibah_obat_bhp_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `icd9` */

DROP TABLE IF EXISTS `icd9`;

CREATE TABLE `icd9` (
  `kode` varchar(8) NOT NULL,
  `deskripsi_panjang` varchar(250) DEFAULT NULL,
  `deskripsi_pendek` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_coder_nik` */

DROP TABLE IF EXISTS `inacbg_coder_nik`;

CREATE TABLE `inacbg_coder_nik` (
  `nik` varchar(20) NOT NULL,
  `no_ik` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`nik`),
  CONSTRAINT `inacbg_coder_nik_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_data_terkirim` */

DROP TABLE IF EXISTS `inacbg_data_terkirim`;

CREATE TABLE `inacbg_data_terkirim` (
  `no_sep` varchar(40) NOT NULL,
  `nik` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_data_terkirim_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_data_terkirim2` */

DROP TABLE IF EXISTS `inacbg_data_terkirim2`;

CREATE TABLE `inacbg_data_terkirim2` (
  `no_sep` varchar(40) NOT NULL,
  `nik` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_data_terkirim2_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `inacbg_klaim_baru2` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_grouping_stage1` */

DROP TABLE IF EXISTS `inacbg_grouping_stage1`;

CREATE TABLE `inacbg_grouping_stage1` (
  `no_sep` varchar(40) NOT NULL,
  `code_cbg` varchar(10) DEFAULT NULL,
  `deskripsi` varchar(200) DEFAULT NULL,
  `tarif` double DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_grouping_stage1_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_grouping_stage12` */

DROP TABLE IF EXISTS `inacbg_grouping_stage12`;

CREATE TABLE `inacbg_grouping_stage12` (
  `no_sep` varchar(40) NOT NULL,
  `code_cbg` varchar(10) DEFAULT NULL,
  `deskripsi` varchar(200) DEFAULT NULL,
  `tarif` double DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_grouping_stage12_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `inacbg_klaim_baru2` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_klaim_baru` */

DROP TABLE IF EXISTS `inacbg_klaim_baru`;

CREATE TABLE `inacbg_klaim_baru` (
  `no_sep` varchar(40) NOT NULL DEFAULT '',
  `patient_id` varchar(30) DEFAULT NULL,
  `admission_id` varchar(30) DEFAULT NULL,
  `hospital_admission_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_sep`),
  CONSTRAINT `inacbg_klaim_baru_ibfk_1` FOREIGN KEY (`no_sep`) REFERENCES `bridging_sep` (`no_sep`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_klaim_baru2` */

DROP TABLE IF EXISTS `inacbg_klaim_baru2`;

CREATE TABLE `inacbg_klaim_baru2` (
  `no_rawat` varchar(17) NOT NULL,
  `no_sep` varchar(40) NOT NULL DEFAULT '',
  `patient_id` varchar(30) DEFAULT NULL,
  `admission_id` varchar(30) DEFAULT NULL,
  `hospital_admission_id` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_sep` (`no_sep`),
  CONSTRAINT `inacbg_klaim_baru2_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inacbg_noklaim_corona` */

DROP TABLE IF EXISTS `inacbg_noklaim_corona`;

CREATE TABLE `inacbg_noklaim_corona` (
  `no_rawat` varchar(17) NOT NULL,
  `no_klaim` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_klaim` (`no_klaim`),
  CONSTRAINT `inacbg_noklaim_corona_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `indekref` */

DROP TABLE IF EXISTS `indekref`;

CREATE TABLE `indekref` (
  `kdindex` char(4) NOT NULL,
  `n` double NOT NULL,
  `ttl` double NOT NULL,
  KEY `kdindex` (`kdindex`),
  KEY `n` (`n`),
  KEY `ttl` (`ttl`),
  CONSTRAINT `indekref_ibfk_1` FOREIGN KEY (`kdindex`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `indexins` */

DROP TABLE IF EXISTS `indexins`;

CREATE TABLE `indexins` (
  `dep_id` char(4) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`dep_id`),
  KEY `persen` (`persen`),
  CONSTRAINT `indexins_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `indextotal` */

DROP TABLE IF EXISTS `indextotal`;

CREATE TABLE `indextotal` (
  `kdindex` char(4) NOT NULL,
  `ttl` double NOT NULL,
  KEY `kdindex` (`kdindex`),
  KEY `ttl` (`ttl`),
  CONSTRAINT `indextotal_ibfk_1` FOREIGN KEY (`kdindex`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `industrifarmasi` */

DROP TABLE IF EXISTS `industrifarmasi`;

CREATE TABLE `industrifarmasi` (
  `kode_industri` char(5) NOT NULL DEFAULT '',
  `nama_industri` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_industri`),
  KEY `nama_industri` (`nama_industri`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inhealth_jenpel_ruang_rawat` */

DROP TABLE IF EXISTS `inhealth_jenpel_ruang_rawat`;

CREATE TABLE `inhealth_jenpel_ruang_rawat` (
  `kd_kamar` varchar(15) NOT NULL,
  `kode_jenpel_ruang_rawat` varchar(20) NOT NULL,
  `nama_jenpel_ruang_rawat` varchar(100) DEFAULT NULL,
  `tarif` double NOT NULL,
  PRIMARY KEY (`kd_kamar`),
  CONSTRAINT `inhealth_jenpel_ruang_rawat_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inhealth_maping_dokter` */

DROP TABLE IF EXISTS `inhealth_maping_dokter`;

CREATE TABLE `inhealth_maping_dokter` (
  `kd_dokter` varchar(20) NOT NULL,
  `kd_inhealth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`) USING BTREE,
  CONSTRAINT `inhealth_maping_dokter_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `inhealth_maping_poli` */

DROP TABLE IF EXISTS `inhealth_maping_poli`;

CREATE TABLE `inhealth_maping_poli` (
  `kd_poli_rs` varchar(5) NOT NULL,
  `kd_poli_inhealth` varchar(15) DEFAULT NULL,
  `nm_poli_inhealth` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kd_poli_rs`) USING BTREE,
  CONSTRAINT `inhealth_maping_poli_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `inhealth_tindakan_laborat` */

DROP TABLE IF EXISTS `inhealth_tindakan_laborat`;

CREATE TABLE `inhealth_tindakan_laborat` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_inhealth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  CONSTRAINT `inhealth_tindakan_laborat_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inhealth_tindakan_operasi` */

DROP TABLE IF EXISTS `inhealth_tindakan_operasi`;

CREATE TABLE `inhealth_tindakan_operasi` (
  `kode_paket` varchar(15) NOT NULL,
  `kd_inhealth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_paket`),
  CONSTRAINT `inhealth_tindakan_operasi_ibfk_1` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inhealth_tindakan_radiologi` */

DROP TABLE IF EXISTS `inhealth_tindakan_radiologi`;

CREATE TABLE `inhealth_tindakan_radiologi` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_inhealth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `inhealth_tindakan_radiologi_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `inhealth_tindakan_ralan` */

DROP TABLE IF EXISTS `inhealth_tindakan_ralan`;

CREATE TABLE `inhealth_tindakan_ralan` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_inhealth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `inhealth_tindakan_ralan_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `inhealth_tindakan_ranap` */

DROP TABLE IF EXISTS `inhealth_tindakan_ranap`;

CREATE TABLE `inhealth_tindakan_ranap` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_inhealth` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  CONSTRAINT `inhealth_tindakan_ranap_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `insiden_keselamatan` */

DROP TABLE IF EXISTS `insiden_keselamatan`;

CREATE TABLE `insiden_keselamatan` (
  `kode_insiden` varchar(5) NOT NULL,
  `nama_insiden` varchar(100) NOT NULL,
  `jenis_insiden` enum('KPC','KTC','KNC','KTD','Sentinel') NOT NULL,
  `dampak` enum('1. Tidak Signifikan','2. Minor','3. Moderat','4. Mayor','5. Katastropik') NOT NULL,
  PRIMARY KEY (`kode_insiden`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `insiden_keselamatan_pasien` */

DROP TABLE IF EXISTS `insiden_keselamatan_pasien`;

CREATE TABLE `insiden_keselamatan_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_kejadian` date NOT NULL,
  `jam_kejadian` time NOT NULL,
  `tgl_lapor` date NOT NULL,
  `jam_lapor` time NOT NULL,
  `kode_insiden` varchar(5) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `lokasi` varchar(60) NOT NULL,
  `kronologis` varchar(200) NOT NULL,
  `unit_terkait` varchar(60) NOT NULL,
  `akibat` varchar(150) NOT NULL,
  `tindakan_insiden` varchar(150) NOT NULL,
  `identifikasi_masalah` varchar(150) NOT NULL,
  `rtl` varchar(150) NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_insiden` (`kode_insiden`),
  KEY `nip` (`nip`),
  CONSTRAINT `insiden_keselamatan_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `insiden_keselamatan_pasien_ibfk_2` FOREIGN KEY (`kode_insiden`) REFERENCES `insiden_keselamatan` (`kode_insiden`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `insiden_keselamatan_pasien_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris` */

DROP TABLE IF EXISTS `inventaris`;

CREATE TABLE `inventaris` (
  `no_inventaris` varchar(30) NOT NULL,
  `kode_barang` varchar(20) DEFAULT NULL,
  `asal_barang` enum('Beli','Bantuan','Hibah','-') DEFAULT NULL,
  `tgl_pengadaan` date DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `status_barang` enum('Ada','Rusak','Hilang','Perbaikan','Dipinjam','-') DEFAULT NULL,
  `id_ruang` char(5) DEFAULT NULL,
  `no_rak` char(3) DEFAULT NULL,
  `no_box` char(3) DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`),
  KEY `kode_barang` (`kode_barang`),
  KEY `kd_ruang` (`id_ruang`),
  KEY `asal_barang` (`asal_barang`),
  KEY `tgl_pengadaan` (`tgl_pengadaan`),
  KEY `harga` (`harga`),
  KEY `status_barang` (`status_barang`),
  KEY `no_rak` (`no_rak`),
  KEY `no_box` (`no_box`),
  CONSTRAINT `inventaris_ibfk_1` FOREIGN KEY (`kode_barang`) REFERENCES `inventaris_barang` (`kode_barang`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_ibfk_2` FOREIGN KEY (`id_ruang`) REFERENCES `inventaris_ruang` (`id_ruang`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_barang` */

DROP TABLE IF EXISTS `inventaris_barang`;

CREATE TABLE `inventaris_barang` (
  `kode_barang` varchar(20) NOT NULL,
  `nama_barang` varchar(60) DEFAULT NULL,
  `jml_barang` int(11) DEFAULT NULL,
  `kode_produsen` varchar(10) DEFAULT NULL,
  `id_merk` varchar(10) DEFAULT NULL,
  `thn_produksi` year(4) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `id_kategori` char(10) DEFAULT NULL,
  `id_jenis` char(10) DEFAULT NULL,
  PRIMARY KEY (`kode_barang`),
  KEY `kode_produsen` (`kode_produsen`),
  KEY `id_merk` (`id_merk`),
  KEY `id_kategori` (`id_kategori`),
  KEY `id_jenis` (`id_jenis`),
  KEY `nama_barang` (`nama_barang`),
  KEY `jml_barang` (`jml_barang`),
  KEY `thn_produksi` (`thn_produksi`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `inventaris_barang_ibfk_5` FOREIGN KEY (`kode_produsen`) REFERENCES `inventaris_produsen` (`kode_produsen`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_6` FOREIGN KEY (`id_merk`) REFERENCES `inventaris_merk` (`id_merk`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_7` FOREIGN KEY (`id_kategori`) REFERENCES `inventaris_kategori` (`id_kategori`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_barang_ibfk_8` FOREIGN KEY (`id_jenis`) REFERENCES `inventaris_jenis` (`id_jenis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_jenis` */

DROP TABLE IF EXISTS `inventaris_jenis`;

CREATE TABLE `inventaris_jenis` (
  `id_jenis` char(10) NOT NULL,
  `nama_jenis` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_jenis`),
  KEY `nama_jenis` (`nama_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_kategori` */

DROP TABLE IF EXISTS `inventaris_kategori`;

CREATE TABLE `inventaris_kategori` (
  `id_kategori` char(10) NOT NULL,
  `nama_kategori` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_kategori`),
  KEY `nama_kategori` (`nama_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_merk` */

DROP TABLE IF EXISTS `inventaris_merk`;

CREATE TABLE `inventaris_merk` (
  `id_merk` varchar(10) NOT NULL,
  `nama_merk` varchar(40) NOT NULL,
  PRIMARY KEY (`id_merk`),
  KEY `nama_merk` (`nama_merk`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_peminjaman` */

DROP TABLE IF EXISTS `inventaris_peminjaman`;

CREATE TABLE `inventaris_peminjaman` (
  `peminjam` varchar(50) NOT NULL DEFAULT '',
  `tlp` varchar(13) NOT NULL,
  `no_inventaris` varchar(30) NOT NULL DEFAULT '',
  `tgl_pinjam` date NOT NULL DEFAULT '0000-00-00',
  `tgl_kembali` date DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') DEFAULT NULL,
  PRIMARY KEY (`peminjam`,`no_inventaris`,`tgl_pinjam`,`nip`),
  KEY `no_inventaris` (`no_inventaris`),
  KEY `nip` (`nip`),
  KEY `tgl_kembali` (`tgl_kembali`),
  KEY `status_pinjam` (`status_pinjam`),
  CONSTRAINT `inventaris_peminjaman_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON UPDATE CASCADE,
  CONSTRAINT `inventaris_peminjaman_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_produsen` */

DROP TABLE IF EXISTS `inventaris_produsen`;

CREATE TABLE `inventaris_produsen` (
  `kode_produsen` varchar(10) NOT NULL,
  `nama_produsen` varchar(40) DEFAULT NULL,
  `alamat_produsen` varchar(70) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `website_produsen` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_produsen`),
  KEY `nama_produsen` (`nama_produsen`),
  KEY `alamat_produsen` (`alamat_produsen`),
  KEY `no_telp` (`no_telp`),
  KEY `email` (`email`),
  KEY `website_produsen` (`website_produsen`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `inventaris_ruang` */

DROP TABLE IF EXISTS `inventaris_ruang`;

CREATE TABLE `inventaris_ruang` (
  `id_ruang` varchar(5) NOT NULL,
  `nama_ruang` varchar(40) NOT NULL,
  PRIMARY KEY (`id_ruang`),
  KEY `nama_ruang` (`nama_ruang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrs_detail_returbeli` */

DROP TABLE IF EXISTS `ipsrs_detail_returbeli`;

CREATE TABLE `ipsrs_detail_returbeli` (
  `no_retur_beli` varchar(15) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(10) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_retur_beli` (`no_retur_beli`),
  CONSTRAINT `ipsrs_detail_returbeli_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `ipsrs_detail_returbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrs_detail_returbeli_ibfk_3` FOREIGN KEY (`no_retur_beli`) REFERENCES `ipsrsreturbeli` (`no_retur_beli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrs_riwayat_barang` */

DROP TABLE IF EXISTS `ipsrs_riwayat_barang`;

CREATE TABLE `ipsrs_riwayat_barang` (
  `kode_brng` varchar(10) DEFAULT NULL,
  `stok_awal` double DEFAULT NULL,
  `masuk` double DEFAULT NULL,
  `keluar` double DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pengadaan','Penerimaan','Retur Beli','Opname','Stok Keluar','Pengambilan UTD') DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `petugas` varchar(20) DEFAULT NULL,
  `status` enum('Simpan','Hapus') DEFAULT NULL,
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `ipsrs_riwayat_barang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsbarang` */

DROP TABLE IF EXISTS `ipsrsbarang`;

CREATE TABLE `ipsrsbarang` (
  `kode_brng` varchar(15) NOT NULL,
  `nama_brng` varchar(80) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jenis` char(5) DEFAULT NULL,
  `stok` double NOT NULL,
  `harga` double NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nama_brng` (`nama_brng`),
  KEY `jenis` (`jenis`(1)),
  KEY `stok` (`stok`),
  KEY `harga` (`harga`),
  KEY `jenis_2` (`jenis`),
  CONSTRAINT `ipsrsbarang_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `ipsrsbarang_ibfk_2` FOREIGN KEY (`jenis`) REFERENCES `ipsrsjenisbarang` (`kd_jenis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsdetailbeli` */

DROP TABLE IF EXISTS `ipsrsdetailbeli`;

CREATE TABLE `ipsrsdetailbeli` (
  `no_faktur` varchar(15) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `jumlah` (`jumlah`),
  KEY `harga` (`harga`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `no_faktur` (`no_faktur`),
  CONSTRAINT `ipsrsdetailbeli_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `ipsrspembelian` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailbeli_ibfk_4` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailbeli_ibfk_5` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsdetailpengeluaran` */

DROP TABLE IF EXISTS `ipsrsdetailpengeluaran`;

CREATE TABLE `ipsrsdetailpengeluaran` (
  `no_keluar` varchar(15) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `jumlah` (`jumlah`),
  KEY `harga` (`harga`),
  KEY `total` (`total`),
  KEY `no_keluar` (`no_keluar`),
  CONSTRAINT `ipsrsdetailpengeluaran_ibfk_1` FOREIGN KEY (`no_keluar`) REFERENCES `ipsrspengeluaran` (`no_keluar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailpengeluaran_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailpengeluaran_ibfk_4` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsdetailpesan` */

DROP TABLE IF EXISTS `ipsrsdetailpesan`;

CREATE TABLE `ipsrsdetailpesan` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  CONSTRAINT `ipsrsdetailpesan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `ipsrspemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailpesan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsdetailpesan_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsjenisbarang` */

DROP TABLE IF EXISTS `ipsrsjenisbarang`;

CREATE TABLE `ipsrsjenisbarang` (
  `kd_jenis` char(5) NOT NULL,
  `nm_jenis` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsopname` */

DROP TABLE IF EXISTS `ipsrsopname`;

CREATE TABLE `ipsrsopname` (
  `kode_brng` varchar(15) NOT NULL,
  `h_beli` double DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` int(11) NOT NULL,
  `real` int(11) NOT NULL,
  `selisih` int(11) NOT NULL,
  `nomihilang` double NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  PRIMARY KEY (`kode_brng`,`tanggal`),
  KEY `stok` (`stok`),
  KEY `real` (`real`),
  KEY `selisih` (`selisih`),
  KEY `nomihilang` (`nomihilang`),
  KEY `keterangan` (`keterangan`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `ipsrsopname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrspembelian` */

DROP TABLE IF EXISTS `ipsrspembelian`;

CREATE TABLE `ipsrspembelian` (
  `no_faktur` varchar(15) NOT NULL,
  `kode_suplier` char(5) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `tgl_beli` date NOT NULL,
  `subtotal` double NOT NULL,
  `potongan` double NOT NULL,
  `total` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `tgl_beli` (`tgl_beli`),
  KEY `subtotal` (`subtotal`),
  KEY `potongan` (`potongan`),
  KEY `total` (`total`),
  KEY `ipsrspembelian_ibfk_5` (`kd_rek`),
  CONSTRAINT `ipsrspembelian_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrspembelian_ibfk_5` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrspembelian_ibfk_6` FOREIGN KEY (`kode_suplier`) REFERENCES `ipsrssuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrspemesanan` */

DROP TABLE IF EXISTS `ipsrspemesanan`;

CREATE TABLE `ipsrspemesanan` (
  `no_faktur` varchar(20) NOT NULL,
  `no_order` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_pesan` date DEFAULT NULL,
  `tgl_faktur` date DEFAULT NULL,
  `tgl_tempo` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double NOT NULL,
  `status` enum('Sudah Dibayar','Belum Dibayar','Belum Lunas') DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  CONSTRAINT `ipsrspemesanan_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `ipsrssuplier` (`kode_suplier`) ON UPDATE CASCADE,
  CONSTRAINT `ipsrspemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrspengeluaran` */

DROP TABLE IF EXISTS `ipsrspengeluaran`;

CREATE TABLE `ipsrspengeluaran` (
  `no_keluar` varchar(15) NOT NULL,
  `tanggal` date NOT NULL,
  `nip` varchar(20) NOT NULL,
  `keterangan` varchar(100) NOT NULL,
  PRIMARY KEY (`no_keluar`),
  KEY `nip` (`nip`),
  KEY `tanggal` (`tanggal`),
  KEY `keterangan` (`keterangan`),
  CONSTRAINT `ipsrspengeluaran_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrsreturbeli` */

DROP TABLE IF EXISTS `ipsrsreturbeli`;

CREATE TABLE `ipsrsreturbeli` (
  `no_retur_beli` varchar(15) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `kode_suplier` char(5) NOT NULL,
  `catatan` varchar(40) NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_retur_beli`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  CONSTRAINT `ipsrsreturbeli_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `ipsrssuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ipsrsreturbeli_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ipsrssuplier` */

DROP TABLE IF EXISTS `ipsrssuplier`;

CREATE TABLE `ipsrssuplier` (
  `kode_suplier` char(5) NOT NULL,
  `nama_suplier` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `nama_bank` varchar(30) DEFAULT NULL,
  `rekening` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`),
  KEY `nama_suplier` (`nama_suplier`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jabatan` */

DROP TABLE IF EXISTS `jabatan`;

CREATE TABLE `jabatan` (
  `kd_jbtn` char(4) NOT NULL DEFAULT '',
  `nm_jbtn` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`kd_jbtn`),
  KEY `nm_jbtn` (`nm_jbtn`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jabatan_polri` */

DROP TABLE IF EXISTS `jabatan_polri`;

CREATE TABLE `jabatan_polri` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jabatan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `jabatan_tni` */

DROP TABLE IF EXISTS `jabatan_tni`;

CREATE TABLE `jabatan_tni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_jabatan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `jadwal` */

DROP TABLE IF EXISTS `jadwal`;

CREATE TABLE `jadwal` (
  `kd_dokter` varchar(20) NOT NULL,
  `hari_kerja` enum('SENIN','SELASA','RABU','KAMIS','JUMAT','SABTU','AKHAD') NOT NULL DEFAULT 'SENIN',
  `jam_mulai` time NOT NULL DEFAULT '00:00:00',
  `jam_selesai` time DEFAULT NULL,
  `kd_poli` char(5) DEFAULT NULL,
  `kuota` int(11) DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`,`hari_kerja`,`jam_mulai`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `kd_poli` (`kd_poli`),
  KEY `jam_mulai` (`jam_mulai`),
  KEY `jam_selesai` (`jam_selesai`),
  CONSTRAINT `jadwal_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `jadwal_ibfk_2` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jadwal_pegawai` */

DROP TABLE IF EXISTS `jadwal_pegawai`;

CREATE TABLE `jadwal_pegawai` (
  `id` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  PRIMARY KEY (`id`,`tahun`,`bulan`),
  KEY `h1` (`h1`),
  KEY `h2` (`h2`),
  KEY `h3` (`h3`),
  KEY `h4` (`h4`),
  KEY `h30` (`h30`),
  KEY `h31` (`h31`),
  KEY `h29` (`h29`),
  KEY `h28` (`h28`),
  KEY `h18` (`h18`),
  KEY `h9` (`h9`),
  CONSTRAINT `jadwal_pegawai_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jadwal_tambahan` */

DROP TABLE IF EXISTS `jadwal_tambahan`;

CREATE TABLE `jadwal_tambahan` (
  `id` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` enum('01','02','03','04','05','06','07','08','09','10','11','12') NOT NULL,
  `h1` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h2` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h3` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h4` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h5` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h6` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h7` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h8` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h9` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h10` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h11` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h12` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h13` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h14` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h15` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h16` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h17` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h18` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h19` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h20` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h21` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h22` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h23` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h24` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h25` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h26` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h27` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h28` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h29` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h30` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  `h31` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10','') NOT NULL,
  PRIMARY KEY (`id`,`tahun`,`bulan`),
  CONSTRAINT `jadwal_tambahan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jam_jaga` */

DROP TABLE IF EXISTS `jam_jaga`;

CREATE TABLE `jam_jaga` (
  `no_id` int(11) NOT NULL AUTO_INCREMENT,
  `dep_id` char(4) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`no_id`),
  UNIQUE KEY `dep_id_2` (`dep_id`,`shift`),
  KEY `dep_id` (`dep_id`),
  KEY `shift` (`shift`),
  KEY `jam_masuk` (`jam_masuk`),
  KEY `jam_pulang` (`jam_pulang`),
  CONSTRAINT `jam_jaga_ibfk_1` FOREIGN KEY (`dep_id`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Table structure for table `jam_masuk` */

DROP TABLE IF EXISTS `jam_masuk`;

CREATE TABLE `jam_masuk` (
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_masuk` time NOT NULL,
  `jam_pulang` time NOT NULL,
  PRIMARY KEY (`shift`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jamsostek` */

DROP TABLE IF EXISTS `jamsostek`;

CREATE TABLE `jamsostek` (
  `stts` char(5) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`stts`),
  KEY `biaya` (`biaya`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jasa_lain` */

DROP TABLE IF EXISTS `jasa_lain`;

CREATE TABLE `jasa_lain` (
  `thn` year(4) NOT NULL,
  `bln` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `bsr_jasa` double NOT NULL,
  `ktg` varchar(40) NOT NULL,
  PRIMARY KEY (`thn`,`bln`,`id`,`bsr_jasa`,`ktg`),
  KEY `id` (`id`),
  CONSTRAINT `jasa_lain_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jenis` */

DROP TABLE IF EXISTS `jenis`;

CREATE TABLE `jenis` (
  `kdjns` char(4) NOT NULL,
  `nama` varchar(30) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`kdjns`),
  KEY `nama` (`nama`),
  KEY `keterangan` (`keterangan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jgmlm` */

DROP TABLE IF EXISTS `jgmlm`;

CREATE TABLE `jgmlm` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`),
  KEY `id` (`id`),
  KEY `jml` (`jml`),
  CONSTRAINT `jgmlm_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jnj_jabatan` */

DROP TABLE IF EXISTS `jnj_jabatan`;

CREATE TABLE `jnj_jabatan` (
  `kode` varchar(10) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `tnj` double NOT NULL,
  `indek` tinyint(4) NOT NULL,
  PRIMARY KEY (`kode`),
  KEY `nama` (`nama`),
  KEY `tnj` (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jns_perawatan` */

DROP TABLE IF EXISTS `jns_perawatan`;

CREATE TABLE `jns_perawatan` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `kd_kategori` char(5) DEFAULT NULL,
  `material` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byrdr` double DEFAULT NULL,
  `total_byrpr` double DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `kd_poli` char(5) NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_kategori` (`kd_kategori`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_poli` (`kd_poli`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `material` (`material`),
  KEY `tarif_tindakandr` (`tarif_tindakandr`),
  KEY `tarif_tindakanpr` (`tarif_tindakanpr`),
  KEY `total_byrdr` (`total_byrdr`),
  KEY `total_byrpr` (`total_byrpr`),
  KEY `kso` (`kso`),
  KEY `menejemen` (`menejemen`),
  KEY `status` (`status`),
  KEY `total_byrdrpr` (`total_byrdrpr`),
  KEY `bhp` (`bhp`),
  CONSTRAINT `jns_perawatan_ibfk_1` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jns_perawatan_inap` */

DROP TABLE IF EXISTS `jns_perawatan_inap`;

CREATE TABLE `jns_perawatan_inap` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `kd_kategori` char(5) NOT NULL,
  `material` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byrdr` double DEFAULT NULL,
  `total_byrpr` double DEFAULT NULL,
  `total_byrdrpr` double NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `status` enum('0','1') NOT NULL,
  `kelas` enum('-','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `kd_kategori` (`kd_kategori`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `material` (`material`),
  KEY `tarif_tindakandr` (`tarif_tindakandr`),
  KEY `tarif_tindakanpr` (`tarif_tindakanpr`),
  KEY `total_byrdr` (`total_byrdr`),
  KEY `total_byrpr` (`total_byrpr`),
  KEY `bhp` (`bhp`),
  KEY `kso` (`kso`),
  KEY `menejemen` (`menejemen`),
  KEY `status` (`status`),
  KEY `total_byrdrpr` (`total_byrdrpr`),
  CONSTRAINT `jns_perawatan_inap_ibfk_7` FOREIGN KEY (`kd_kategori`) REFERENCES `kategori_perawatan` (`kd_kategori`) ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_8` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `jns_perawatan_inap_ibfk_9` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jns_perawatan_lab` */

DROP TABLE IF EXISTS `jns_perawatan_lab`;

CREATE TABLE `jns_perawatan_lab` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byr` double DEFAULT NULL,
  `kd_pj` char(3) NOT NULL,
  `status` enum('0','1') NOT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `tarif_perujuk` (`tarif_perujuk`),
  KEY `tarif_tindakan_dokter` (`tarif_tindakan_dokter`),
  KEY `tarif_tindakan_petugas` (`tarif_tindakan_petugas`),
  KEY `total_byr` (`total_byr`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `bhp` (`bhp`),
  KEY `kso` (`kso`),
  KEY `menejemen` (`menejemen`),
  KEY `status` (`status`),
  CONSTRAINT `jns_perawatan_lab_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jns_perawatan_radiologi` */

DROP TABLE IF EXISTS `jns_perawatan_radiologi`;

CREATE TABLE `jns_perawatan_radiologi` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `total_byr` double DEFAULT NULL,
  `kd_pj` char(3) NOT NULL,
  `status` enum('0','1') NOT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `tarif_perujuk` (`tarif_perujuk`),
  KEY `tarif_tindakan_dokter` (`tarif_tindakan_dokter`),
  KEY `tarif_tindakan_petugas` (`tarif_tindakan_petugas`),
  KEY `total_byr` (`total_byr`),
  KEY `bhp` (`bhp`),
  KEY `kso` (`kso`),
  KEY `menejemen` (`menejemen`),
  KEY `status` (`status`),
  CONSTRAINT `jns_perawatan_radiologi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jns_perawatan_utd` */

DROP TABLE IF EXISTS `jns_perawatan_utd`;

CREATE TABLE `jns_perawatan_utd` (
  `kd_jenis_prw` varchar(15) NOT NULL DEFAULT '',
  `nm_perawatan` varchar(80) DEFAULT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double DEFAULT NULL,
  `tarif_perujuk` double DEFAULT NULL,
  `tarif_tindakan_dokter` double DEFAULT NULL,
  `tarif_tindakan_petugas` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `manajemen` double DEFAULT NULL,
  `total_byr` double DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `jns_perawatan_utd_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jumpasien` */

DROP TABLE IF EXISTS `jumpasien`;

CREATE TABLE `jumpasien` (
  `thn` year(4) NOT NULL,
  `bln` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`thn`,`bln`,`id`),
  KEY `id` (`id`),
  KEY `jml` (`jml`),
  CONSTRAINT `jumpasien_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `jurnal` */

DROP TABLE IF EXISTS `jurnal`;

CREATE TABLE `jurnal` (
  `no_jurnal` varchar(20) NOT NULL,
  `no_bukti` varchar(20) DEFAULT NULL,
  `tgl_jurnal` date DEFAULT NULL,
  `jenis` enum('U','P') DEFAULT NULL,
  `keterangan` varchar(350) DEFAULT NULL,
  PRIMARY KEY (`no_jurnal`),
  KEY `no_bukti` (`no_bukti`),
  KEY `tgl_jurnal` (`tgl_jurnal`),
  KEY `jenis` (`jenis`),
  KEY `keterangan` (`keterangan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_bagian_tubuh` */

DROP TABLE IF EXISTS `k3rs_bagian_tubuh`;

CREATE TABLE `k3rs_bagian_tubuh` (
  `kode_bagian` varchar(5) NOT NULL,
  `bagian_tubuh` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_bagian`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_dampak_cidera` */

DROP TABLE IF EXISTS `k3rs_dampak_cidera`;

CREATE TABLE `k3rs_dampak_cidera` (
  `kode_dampak` varchar(5) NOT NULL,
  `dampak_cidera` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_dampak`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_jenis_cidera` */

DROP TABLE IF EXISTS `k3rs_jenis_cidera`;

CREATE TABLE `k3rs_jenis_cidera` (
  `kode_cidera` varchar(5) NOT NULL,
  `jenis_cidera` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_cidera`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_jenis_luka` */

DROP TABLE IF EXISTS `k3rs_jenis_luka`;

CREATE TABLE `k3rs_jenis_luka` (
  `kode_luka` varchar(5) NOT NULL,
  `jenis_luka` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_luka`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_jenis_pekerjaan` */

DROP TABLE IF EXISTS `k3rs_jenis_pekerjaan`;

CREATE TABLE `k3rs_jenis_pekerjaan` (
  `kode_pekerjaan` varchar(5) NOT NULL,
  `jenis_pekerjaan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_pekerjaan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_lokasi_kejadian` */

DROP TABLE IF EXISTS `k3rs_lokasi_kejadian`;

CREATE TABLE `k3rs_lokasi_kejadian` (
  `kode_lokasi` varchar(5) NOT NULL,
  `lokasi_kejadian` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_lokasi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_penyebab` */

DROP TABLE IF EXISTS `k3rs_penyebab`;

CREATE TABLE `k3rs_penyebab` (
  `kode_penyebab` varchar(5) NOT NULL,
  `penyebab_kecelakaan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_penyebab`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `k3rs_peristiwa` */

DROP TABLE IF EXISTS `k3rs_peristiwa`;

CREATE TABLE `k3rs_peristiwa` (
  `no_k3rs` varchar(20) NOT NULL,
  `tgl_insiden` date NOT NULL,
  `waktu_insiden` time NOT NULL,
  `kode_pekerjaan` varchar(5) NOT NULL,
  `tgl_pelaporan` date NOT NULL,
  `waktu_pelaporan` time NOT NULL,
  `kode_lokasi` varchar(5) NOT NULL,
  `kronologi_kejadian` varchar(300) NOT NULL,
  `kode_penyebab` varchar(5) NOT NULL,
  `nik` varchar(20) NOT NULL,
  `kategori_cidera` enum('Ringan','Sedang','Berat','Fatal') NOT NULL,
  `kode_cidera` varchar(5) NOT NULL,
  `kode_luka` varchar(5) NOT NULL,
  `kode_bagian` varchar(5) NOT NULL,
  `lt` int(11) NOT NULL,
  `penyebab_langsung_kondisi` varchar(100) NOT NULL,
  `penyebab_langsung_tindakan` varchar(100) NOT NULL,
  `penyebab_tidak_langsung_pribadi` varchar(100) NOT NULL,
  `penyebab_tidak_langsung_pekerjaan` varchar(100) NOT NULL,
  `barang_bukti` enum('Ya','Tidak') NOT NULL,
  `kode_dampak` varchar(5) NOT NULL,
  `nik_pelapor` varchar(20) NOT NULL,
  `perbaikan_jenis_tindakan` enum('Tindakan Perbaikan','Tindakan Pencegahan') NOT NULL,
  `perbaikan_rencana_tindakan` varchar(200) NOT NULL,
  `perbaikan_target` date NOT NULL,
  `perbaikan_wewenang` varchar(100) NOT NULL,
  `nik_timk3` varchar(20) NOT NULL,
  `catatan` varchar(200) NOT NULL,
  PRIMARY KEY (`no_k3rs`),
  KEY `kode_pekerjaan` (`kode_pekerjaan`),
  KEY `kode_lokasi` (`kode_lokasi`),
  KEY `kode_penyebab` (`kode_penyebab`),
  KEY `nik` (`nik`),
  KEY `kode_cidera` (`kode_cidera`),
  KEY `kode_luka` (`kode_luka`),
  KEY `kode_dampak` (`kode_dampak`),
  KEY `nik_timk3` (`nik_timk3`),
  KEY `nik_pelapor` (`nik_pelapor`),
  KEY `kode_bagian` (`kode_bagian`),
  CONSTRAINT `k3rs_peristiwa_ibfk_1` FOREIGN KEY (`kode_cidera`) REFERENCES `k3rs_jenis_cidera` (`kode_cidera`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_10` FOREIGN KEY (`kode_bagian`) REFERENCES `k3rs_bagian_tubuh` (`kode_bagian`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_2` FOREIGN KEY (`kode_dampak`) REFERENCES `k3rs_dampak_cidera` (`kode_dampak`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_3` FOREIGN KEY (`kode_lokasi`) REFERENCES `k3rs_lokasi_kejadian` (`kode_lokasi`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_4` FOREIGN KEY (`kode_luka`) REFERENCES `k3rs_jenis_luka` (`kode_luka`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_5` FOREIGN KEY (`kode_pekerjaan`) REFERENCES `k3rs_jenis_pekerjaan` (`kode_pekerjaan`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_6` FOREIGN KEY (`kode_penyebab`) REFERENCES `k3rs_penyebab` (`kode_penyebab`) ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_7` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_8` FOREIGN KEY (`nik_pelapor`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `k3rs_peristiwa_ibfk_9` FOREIGN KEY (`nik_timk3`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kabupaten` */

DROP TABLE IF EXISTS `kabupaten`;

CREATE TABLE `kabupaten` (
  `kd_kab` int(11) NOT NULL AUTO_INCREMENT,
  `nm_kab` varchar(60) NOT NULL,
  PRIMARY KEY (`kd_kab`),
  UNIQUE KEY `nm_kab` (`nm_kab`)
) ENGINE=InnoDB AUTO_INCREMENT=1902 DEFAULT CHARSET=latin1;

/*Table structure for table `kamar` */

DROP TABLE IF EXISTS `kamar`;

CREATE TABLE `kamar` (
  `kd_kamar` varchar(15) NOT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  `trf_kamar` double DEFAULT NULL,
  `status` enum('ISI','KOSONG','DIBERSIHKAN','DIBOOKING') DEFAULT NULL,
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') DEFAULT NULL,
  `statusdata` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_kamar`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `trf_kamar` (`trf_kamar`),
  KEY `status` (`status`),
  KEY `kelas` (`kelas`),
  KEY `statusdata` (`statusdata`),
  CONSTRAINT `kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kamar_inap` */

DROP TABLE IF EXISTS `kamar_inap`;

CREATE TABLE `kamar_inap` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_kamar` varchar(15) NOT NULL,
  `trf_kamar` double DEFAULT NULL,
  `diagnosa_awal` varchar(100) DEFAULT NULL,
  `diagnosa_akhir` varchar(100) DEFAULT NULL,
  `tgl_masuk` date NOT NULL DEFAULT '0000-00-00',
  `jam_masuk` time NOT NULL DEFAULT '00:00:00',
  `tgl_keluar` date DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `lama` double DEFAULT NULL,
  `ttl_biaya` double DEFAULT NULL,
  `stts_pulang` enum('Sehat','Rujuk','APS','+','Meninggal','Sembuh','Membaik','Pulang Paksa','-','Pindah Kamar','Status Belum Lengkap','Atas Persetujuan Dokter','Atas Permintaan Sendiri','Lain-lain') NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_masuk`,`jam_masuk`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `diagnosa_awal` (`diagnosa_awal`),
  KEY `diagnosa_akhir` (`diagnosa_akhir`),
  KEY `tgl_keluar` (`tgl_keluar`),
  KEY `jam_keluar` (`jam_keluar`),
  KEY `lama` (`lama`),
  KEY `ttl_biaya` (`ttl_biaya`),
  KEY `stts_pulang` (`stts_pulang`),
  KEY `trf_kamar` (`trf_kamar`),
  CONSTRAINT `kamar_inap_ibfk_2` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `kamar_inap_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kasift` */

DROP TABLE IF EXISTS `kasift`;

CREATE TABLE `kasift` (
  `id` int(11) NOT NULL,
  `jmlks` bigint(20) NOT NULL,
  `bsr` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jmlks` (`jmlks`),
  KEY `bsr` (`bsr`),
  CONSTRAINT `kasift_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kategori_barang` */

DROP TABLE IF EXISTS `kategori_barang`;

CREATE TABLE `kategori_barang` (
  `kode` char(4) NOT NULL,
  `nama` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kategori_pemasukan_lain` */

DROP TABLE IF EXISTS `kategori_pemasukan_lain`;

CREATE TABLE `kategori_pemasukan_lain` (
  `kode_kategori` varchar(5) NOT NULL,
  `nama_kategori` varchar(40) DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `kd_rek2` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kode_kategori`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_rek2` (`kd_rek2`),
  CONSTRAINT `kategori_pemasukan_lain_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `kategori_pemasukan_lain_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kategori_pengeluaran_harian` */

DROP TABLE IF EXISTS `kategori_pengeluaran_harian`;

CREATE TABLE `kategori_pengeluaran_harian` (
  `kode_kategori` varchar(5) NOT NULL,
  `nama_kategori` varchar(40) DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `kd_rek2` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kode_kategori`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_rek2` (`kd_rek2`),
  CONSTRAINT `kategori_pengeluaran_harian_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `kategori_pengeluaran_harian_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kategori_penyakit` */

DROP TABLE IF EXISTS `kategori_penyakit`;

CREATE TABLE `kategori_penyakit` (
  `kd_ktg` varchar(8) NOT NULL,
  `nm_kategori` varchar(30) DEFAULT NULL,
  `ciri_umum` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`kd_ktg`),
  KEY `nm_kategori` (`nm_kategori`),
  KEY `ciri_umum` (`ciri_umum`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kategori_perawatan` */

DROP TABLE IF EXISTS `kategori_perawatan`;

CREATE TABLE `kategori_perawatan` (
  `kd_kategori` char(5) NOT NULL,
  `nm_kategori` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kd_kategori`),
  KEY `nm_kategori` (`nm_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `keanggotaan` */

DROP TABLE IF EXISTS `keanggotaan`;

CREATE TABLE `keanggotaan` (
  `id` int(11) NOT NULL,
  `koperasi` char(5) NOT NULL,
  `jamsostek` char(5) NOT NULL,
  `bpjs` char(5) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `koperasi` (`koperasi`),
  KEY `jamsostek` (`jamsostek`),
  KEY `bpjs` (`bpjs`),
  CONSTRAINT `keanggotaan_ibfk_3` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `keanggotaan_ibfk_4` FOREIGN KEY (`koperasi`) REFERENCES `koperasi` (`stts`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `keanggotaan_ibfk_5` FOREIGN KEY (`jamsostek`) REFERENCES `jamsostek` (`stts`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `keanggotaan_ibfk_6` FOREIGN KEY (`bpjs`) REFERENCES `bpjs` (`stts`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kecamatan` */

DROP TABLE IF EXISTS `kecamatan`;

CREATE TABLE `kecamatan` (
  `kd_kec` int(11) NOT NULL AUTO_INCREMENT,
  `nm_kec` varchar(60) NOT NULL,
  PRIMARY KEY (`kd_kec`),
  UNIQUE KEY `nm_kec` (`nm_kec`)
) ENGINE=InnoDB AUTO_INCREMENT=6841 DEFAULT CHARSET=latin1;

/*Table structure for table `kegiatan` */

DROP TABLE IF EXISTS `kegiatan`;

CREATE TABLE `kegiatan` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nomor` char(4) COLLATE utf8mb4_unicode_ci NOT NULL,
  `keluhan` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `pelayanan` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ruang` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('belum','selesai') COLLATE utf8mb4_unicode_ci NOT NULL,
  `ket` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `kegiatan_nomor_unique` (`nomor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `kelompok_jabatan` */

DROP TABLE IF EXISTS `kelompok_jabatan`;

CREATE TABLE `kelompok_jabatan` (
  `kode_kelompok` varchar(3) NOT NULL,
  `nama_kelompok` varchar(100) DEFAULT NULL,
  `indek` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`kode_kelompok`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `kelurahan` */

DROP TABLE IF EXISTS `kelurahan`;

CREATE TABLE `kelurahan` (
  `kd_kel` int(11) NOT NULL AUTO_INCREMENT,
  `nm_kel` varchar(60) NOT NULL,
  PRIMARY KEY (`kd_kel`),
  UNIQUE KEY `nm_kel` (`nm_kel`)
) ENGINE=InnoDB AUTO_INCREMENT=41528 DEFAULT CHARSET=latin1;

/*Table structure for table `kesling_limbah_b3medis` */

DROP TABLE IF EXISTS `kesling_limbah_b3medis`;

CREATE TABLE `kesling_limbah_b3medis` (
  `nip` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `jmllimbah` double DEFAULT NULL,
  `tujuan_penyerahan` varchar(50) DEFAULT NULL,
  `bukti_dokumen` varchar(20) DEFAULT NULL,
  `sisa_di_tps` double DEFAULT NULL,
  PRIMARY KEY (`nip`,`tanggal`),
  CONSTRAINT `kesling_limbah_b3medis_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kesling_limbah_domestik` */

DROP TABLE IF EXISTS `kesling_limbah_domestik`;

CREATE TABLE `kesling_limbah_domestik` (
  `nip` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `jumlahlimbah` double DEFAULT NULL,
  `tanggalangkut` datetime DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nip`,`tanggal`),
  CONSTRAINT `kesling_limbah_domestik_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kesling_mutu_air_limbah` */

DROP TABLE IF EXISTS `kesling_mutu_air_limbah`;

CREATE TABLE `kesling_mutu_air_limbah` (
  `nip` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `meteran` double DEFAULT NULL,
  `jumlahharian` double DEFAULT NULL,
  `ph` double DEFAULT NULL,
  `suhu` double DEFAULT NULL,
  PRIMARY KEY (`nip`,`tanggal`),
  CONSTRAINT `kesling_mutu_air_limbah_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kesling_pemakaian_air_pdam` */

DROP TABLE IF EXISTS `kesling_pemakaian_air_pdam`;

CREATE TABLE `kesling_pemakaian_air_pdam` (
  `nip` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `meteran` double DEFAULT NULL,
  `jumlahharian` double DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nip`,`tanggal`),
  CONSTRAINT `kesling_pemakaian_air_pdam_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kesling_pemakaian_air_tanah` */

DROP TABLE IF EXISTS `kesling_pemakaian_air_tanah`;

CREATE TABLE `kesling_pemakaian_air_tanah` (
  `nip` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `meteran` double DEFAULT NULL,
  `jumlahharian` double DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nip`,`tanggal`),
  CONSTRAINT `kesling_pemakaian_air_tanah` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kesling_pest_control` */

DROP TABLE IF EXISTS `kesling_pest_control`;

CREATE TABLE `kesling_pest_control` (
  `nip` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `rincian_kegiatan` text DEFAULT NULL,
  `rekomendasi` text DEFAULT NULL,
  PRIMARY KEY (`nip`,`tanggal`),
  CONSTRAINT `kesling_pest_control_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ketidakhadiran` */

DROP TABLE IF EXISTS `ketidakhadiran`;

CREATE TABLE `ketidakhadiran` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jns` enum('A','S','C','I') NOT NULL,
  `ktg` varchar(40) NOT NULL,
  `jml` int(10) DEFAULT NULL,
  PRIMARY KEY (`tgl`,`id`,`jns`),
  KEY `id` (`id`),
  KEY `ktg` (`ktg`),
  KEY `jml` (`jml`),
  CONSTRAINT `ketidakhadiran_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `kodesatuan` */

DROP TABLE IF EXISTS `kodesatuan`;

CREATE TABLE `kodesatuan` (
  `kode_sat` char(4) NOT NULL,
  `satuan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_sat`),
  KEY `satuan` (`satuan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `konver_sat` */

DROP TABLE IF EXISTS `konver_sat`;

CREATE TABLE `konver_sat` (
  `nilai` double NOT NULL,
  `kode_sat` char(4) NOT NULL DEFAULT '',
  `nilai_konversi` double NOT NULL,
  `sat_konversi` char(4) NOT NULL DEFAULT '',
  PRIMARY KEY (`nilai`,`kode_sat`,`nilai_konversi`,`sat_konversi`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nilai` (`nilai`),
  KEY `nilai_konversi` (`nilai_konversi`),
  CONSTRAINT `konver_sat_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `koperasi` */

DROP TABLE IF EXISTS `koperasi`;

CREATE TABLE `koperasi` (
  `stts` char(5) NOT NULL,
  `wajib` double NOT NULL,
  PRIMARY KEY (`stts`),
  KEY `wajib` (`wajib`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `laporan_operasi` */

DROP TABLE IF EXISTS `laporan_operasi`;

CREATE TABLE `laporan_operasi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `diagnosa_preop` varchar(100) NOT NULL,
  `diagnosa_postop` varchar(100) NOT NULL,
  `jaringan_dieksekusi` varchar(100) NOT NULL,
  `selesaioperasi` datetime NOT NULL,
  `permintaan_pa` enum('Ya','Tidak') NOT NULL,
  `laporan_operasi` text NOT NULL,
  PRIMARY KEY (`no_rawat`,`tanggal`) USING BTREE,
  CONSTRAINT `laporan_operasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `lite_antrian_loket` */

DROP TABLE IF EXISTS `lite_antrian_loket`;

CREATE TABLE `lite_antrian_loket` (
  `kd` int(50) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `noantrian` varchar(50) NOT NULL,
  `postdate` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `lite_options` */

DROP TABLE IF EXISTS `lite_options`;

CREATE TABLE `lite_options` (
  `id` int(10) NOT NULL AUTO_INCREMENT,
  `module` varchar(50) NOT NULL,
  `field` varchar(250) NOT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=994 DEFAULT CHARSET=utf8;

/*Table structure for table `log_dukcapil_aceh` */

DROP TABLE IF EXISTS `log_dukcapil_aceh`;

CREATE TABLE `log_dukcapil_aceh` (
  `no_ktp` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `user` varchar(30) NOT NULL,
  PRIMARY KEY (`no_ktp`,`tanggal`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_dokter_dpjpvclaim` */

DROP TABLE IF EXISTS `maping_dokter_dpjpvclaim`;

CREATE TABLE `maping_dokter_dpjpvclaim` (
  `kd_dokter` varchar(20) NOT NULL,
  `kd_dokter_bpjs` varchar(20) DEFAULT NULL,
  `nm_dokter_bpjs` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`),
  CONSTRAINT `maping_dokter_dpjpvclaim_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_dokter_pcare` */

DROP TABLE IF EXISTS `maping_dokter_pcare`;

CREATE TABLE `maping_dokter_pcare` (
  `kd_dokter` varchar(20) NOT NULL,
  `kd_dokter_pcare` varchar(20) DEFAULT NULL,
  `nm_dokter_pcare` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kd_dokter`),
  CONSTRAINT `maping_dokter_pcare_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_obat_pcare` */

DROP TABLE IF EXISTS `maping_obat_pcare`;

CREATE TABLE `maping_obat_pcare` (
  `kode_brng` varchar(15) NOT NULL,
  `kode_brng_pcare` varchar(15) NOT NULL,
  `nama_brng_pcare` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  CONSTRAINT `maping_obat_pcare_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_poli_bpjs` */

DROP TABLE IF EXISTS `maping_poli_bpjs`;

CREATE TABLE `maping_poli_bpjs` (
  `kd_poli_rs` varchar(5) NOT NULL,
  `kd_poli_bpjs` varchar(15) NOT NULL,
  `nm_poli_bpjs` varchar(40) NOT NULL,
  PRIMARY KEY (`kd_poli_rs`),
  CONSTRAINT `maping_poli_bpjs_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_poliklinik_pcare` */

DROP TABLE IF EXISTS `maping_poliklinik_pcare`;

CREATE TABLE `maping_poliklinik_pcare` (
  `kd_poli_rs` char(5) NOT NULL,
  `kd_poli_pcare` char(5) DEFAULT NULL,
  `nm_poli_pcare` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kd_poli_rs`),
  CONSTRAINT `maping_poliklinik_pcare_ibfk_1` FOREIGN KEY (`kd_poli_rs`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_tindakan_pcare` */

DROP TABLE IF EXISTS `maping_tindakan_pcare`;

CREATE TABLE `maping_tindakan_pcare` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_tindakan_pcare` varchar(15) DEFAULT NULL,
  `nm_tindakan_pcare` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  CONSTRAINT `maping_tindakan_pcare_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `maping_tindakan_ranap_pcare` */

DROP TABLE IF EXISTS `maping_tindakan_ranap_pcare`;

CREATE TABLE `maping_tindakan_ranap_pcare` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_tindakan_pcare` varchar(15) DEFAULT NULL,
  `nm_tindakan_pcare` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  CONSTRAINT `maping_tindakan_ranap_pcare_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_aturan_pakai` */

DROP TABLE IF EXISTS `master_aturan_pakai`;

CREATE TABLE `master_aturan_pakai` (
  `aturan` varchar(150) NOT NULL,
  PRIMARY KEY (`aturan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_berkas_digital` */

DROP TABLE IF EXISTS `master_berkas_digital`;

CREATE TABLE `master_berkas_digital` (
  `kode` varchar(10) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_berkas_pegawai` */

DROP TABLE IF EXISTS `master_berkas_pegawai`;

CREATE TABLE `master_berkas_pegawai` (
  `kode` varchar(10) NOT NULL,
  `kategori` enum('Tenaga klinis Dokter Umum','Tenaga klinis Dokter Spesialis','Tenaga klinis Perawat dan Bidan','Tenaga klinis Profesi Lain','Tenaga Non Klinis') NOT NULL,
  `nama_berkas` varchar(300) NOT NULL,
  `no_urut` tinyint(4) NOT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_imunisasi` */

DROP TABLE IF EXISTS `master_imunisasi`;

CREATE TABLE `master_imunisasi` (
  `kode_imunisasi` varchar(3) NOT NULL,
  `nama_imunisasi` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_imunisasi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_masalah_keperawatan` */

DROP TABLE IF EXISTS `master_masalah_keperawatan`;

CREATE TABLE `master_masalah_keperawatan` (
  `kode_masalah` varchar(3) NOT NULL,
  `nama_masalah` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_masalah`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_masalah_keperawatan_anak` */

DROP TABLE IF EXISTS `master_masalah_keperawatan_anak`;

CREATE TABLE `master_masalah_keperawatan_anak` (
  `kode_masalah` varchar(3) NOT NULL,
  `nama_masalah` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_masalah`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_masalah_keperawatan_gigi` */

DROP TABLE IF EXISTS `master_masalah_keperawatan_gigi`;

CREATE TABLE `master_masalah_keperawatan_gigi` (
  `kode_masalah` varchar(3) NOT NULL,
  `nama_masalah` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`kode_masalah`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_tindakan` */

DROP TABLE IF EXISTS `master_tindakan`;

CREATE TABLE `master_tindakan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) NOT NULL,
  `jm` double NOT NULL,
  `jns` enum('Karyawan','dr umum','dr spesialis') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama` (`nama`),
  KEY `jm` (`jm`),
  KEY `jns` (`jns`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_macam_kasus` */

DROP TABLE IF EXISTS `master_triase_macam_kasus`;

CREATE TABLE `master_triase_macam_kasus` (
  `kode_kasus` varchar(3) NOT NULL,
  `macam_kasus` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_kasus`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_pemeriksaan` */

DROP TABLE IF EXISTS `master_triase_pemeriksaan`;

CREATE TABLE `master_triase_pemeriksaan` (
  `kode_pemeriksaan` varchar(3) NOT NULL,
  `nama_pemeriksaan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`kode_pemeriksaan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_skala1` */

DROP TABLE IF EXISTS `master_triase_skala1`;

CREATE TABLE `master_triase_skala1` (
  `kode_pemeriksaan` varchar(3) NOT NULL,
  `kode_skala1` varchar(3) NOT NULL,
  `pengkajian_skala1` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_skala1`),
  KEY `kode_pemeriksaan` (`kode_pemeriksaan`),
  CONSTRAINT `master_triase_skala1_ibfk_1` FOREIGN KEY (`kode_pemeriksaan`) REFERENCES `master_triase_pemeriksaan` (`kode_pemeriksaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_skala2` */

DROP TABLE IF EXISTS `master_triase_skala2`;

CREATE TABLE `master_triase_skala2` (
  `kode_pemeriksaan` varchar(3) NOT NULL,
  `kode_skala2` varchar(3) NOT NULL,
  `pengkajian_skala2` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_skala2`),
  KEY `kode_pemeriksaan` (`kode_pemeriksaan`),
  CONSTRAINT `master_triase_skala2_ibfk_1` FOREIGN KEY (`kode_pemeriksaan`) REFERENCES `master_triase_pemeriksaan` (`kode_pemeriksaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_skala3` */

DROP TABLE IF EXISTS `master_triase_skala3`;

CREATE TABLE `master_triase_skala3` (
  `kode_pemeriksaan` varchar(3) NOT NULL,
  `kode_skala3` varchar(3) NOT NULL,
  `pengkajian_skala3` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_skala3`),
  KEY `kode_pemeriksaan` (`kode_pemeriksaan`),
  CONSTRAINT `master_triase_skala3_ibfk_1` FOREIGN KEY (`kode_pemeriksaan`) REFERENCES `master_triase_pemeriksaan` (`kode_pemeriksaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_skala4` */

DROP TABLE IF EXISTS `master_triase_skala4`;

CREATE TABLE `master_triase_skala4` (
  `kode_pemeriksaan` varchar(3) NOT NULL,
  `kode_skala4` varchar(3) NOT NULL,
  `pengkajian_skala4` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_skala4`),
  KEY `kode_pemeriksaan` (`kode_pemeriksaan`),
  CONSTRAINT `master_triase_skala1_ibfk_4` FOREIGN KEY (`kode_pemeriksaan`) REFERENCES `master_triase_pemeriksaan` (`kode_pemeriksaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_triase_skala5` */

DROP TABLE IF EXISTS `master_triase_skala5`;

CREATE TABLE `master_triase_skala5` (
  `kode_pemeriksaan` varchar(3) NOT NULL,
  `kode_skala5` varchar(3) NOT NULL,
  `pengkajian_skala5` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_skala5`),
  KEY `kode_pemeriksaan` (`kode_pemeriksaan`),
  CONSTRAINT `master_triase_skala1_ibfk_5` FOREIGN KEY (`kode_pemeriksaan`) REFERENCES `master_triase_pemeriksaan` (`kode_pemeriksaan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `master_tunjangan_bulanan` */

DROP TABLE IF EXISTS `master_tunjangan_bulanan`;

CREATE TABLE `master_tunjangan_bulanan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(60) NOT NULL,
  `tnj` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nama` (`nama`),
  KEY `tnj` (`tnj`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Table structure for table `master_tunjangan_harian` */

DROP TABLE IF EXISTS `master_tunjangan_harian`;

CREATE TABLE `master_tunjangan_harian` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama` varchar(40) NOT NULL,
  `tnj` double NOT NULL,
  PRIMARY KEY (`id`),
  KEY `nama` (`nama`),
  KEY `tnj` (`tnj`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `matrik_akun_jns_perawatan` */

DROP TABLE IF EXISTS `matrik_akun_jns_perawatan`;

CREATE TABLE `matrik_akun_jns_perawatan` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `pendapatan_tindakan` varchar(15) DEFAULT NULL,
  `beban_jasa_dokter` varchar(15) DEFAULT NULL,
  `utang_jasa_dokter` varchar(15) DEFAULT NULL,
  `beban_jasa_paramedis` varchar(15) DEFAULT NULL,
  `utang_jasa_paramedis` varchar(15) DEFAULT NULL,
  `beban_kso` varchar(15) DEFAULT NULL,
  `utang_kso` varchar(15) DEFAULT NULL,
  `hpp_persediaan` varchar(15) DEFAULT NULL,
  `persediaan_bhp` varchar(15) DEFAULT NULL,
  `beban_jasa_sarana` varchar(15) DEFAULT NULL,
  `utang_jasa_sarana` varchar(15) DEFAULT NULL,
  `beban_menejemen` varchar(15) DEFAULT NULL,
  `utang_menejemen` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  KEY `beban_jasa_dokter` (`beban_jasa_dokter`) USING BTREE,
  KEY `beban_jasa_paramedis` (`beban_jasa_paramedis`) USING BTREE,
  KEY `beban_jasa_sarana` (`beban_jasa_sarana`) USING BTREE,
  KEY `beban_kso` (`beban_kso`) USING BTREE,
  KEY `beban_menejemen` (`beban_menejemen`) USING BTREE,
  KEY `hpp_persediaan` (`hpp_persediaan`) USING BTREE,
  KEY `pendapatan_tindakan` (`pendapatan_tindakan`) USING BTREE,
  KEY `persediaan_bhp` (`persediaan_bhp`) USING BTREE,
  KEY `utang_jasa_dokter` (`utang_jasa_dokter`) USING BTREE,
  KEY `utang_jasa_paramedis` (`utang_jasa_paramedis`) USING BTREE,
  KEY `utang_jasa_sarana` (`utang_jasa_sarana`) USING BTREE,
  KEY `utang_kso` (`utang_kso`) USING BTREE,
  KEY `utang_menejemen` (`utang_menejemen`) USING BTREE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_10` FOREIGN KEY (`utang_jasa_dokter`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_11` FOREIGN KEY (`utang_jasa_paramedis`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_12` FOREIGN KEY (`utang_jasa_sarana`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_13` FOREIGN KEY (`utang_kso`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_14` FOREIGN KEY (`utang_menejemen`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_2` FOREIGN KEY (`beban_jasa_dokter`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_3` FOREIGN KEY (`beban_jasa_paramedis`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_4` FOREIGN KEY (`beban_jasa_sarana`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_5` FOREIGN KEY (`beban_kso`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_6` FOREIGN KEY (`beban_menejemen`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_7` FOREIGN KEY (`hpp_persediaan`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_8` FOREIGN KEY (`pendapatan_tindakan`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_ibfk_9` FOREIGN KEY (`persediaan_bhp`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `matrik_akun_jns_perawatan_inap` */

DROP TABLE IF EXISTS `matrik_akun_jns_perawatan_inap`;

CREATE TABLE `matrik_akun_jns_perawatan_inap` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `pendapatan_tindakan` varchar(15) DEFAULT NULL,
  `beban_jasa_dokter` varchar(15) DEFAULT NULL,
  `utang_jasa_dokter` varchar(15) DEFAULT NULL,
  `beban_jasa_paramedis` varchar(15) DEFAULT NULL,
  `utang_jasa_paramedis` varchar(15) DEFAULT NULL,
  `beban_kso` varchar(15) DEFAULT NULL,
  `utang_kso` varchar(15) DEFAULT NULL,
  `hpp_persediaan` varchar(15) DEFAULT NULL,
  `persediaan_bhp` varchar(15) DEFAULT NULL,
  `beban_jasa_sarana` varchar(15) DEFAULT NULL,
  `utang_jasa_sarana` varchar(15) DEFAULT NULL,
  `beban_menejemen` varchar(15) DEFAULT NULL,
  `utang_menejemen` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis_prw`) USING BTREE,
  KEY `beban_jasa_dokter` (`beban_jasa_dokter`) USING BTREE,
  KEY `beban_jasa_paramedis` (`beban_jasa_paramedis`) USING BTREE,
  KEY `beban_jasa_sarana` (`beban_jasa_sarana`) USING BTREE,
  KEY `beban_kso` (`beban_kso`) USING BTREE,
  KEY `beban_menejemen` (`beban_menejemen`) USING BTREE,
  KEY `hpp_persediaan` (`hpp_persediaan`) USING BTREE,
  KEY `pendapatan_tindakan` (`pendapatan_tindakan`) USING BTREE,
  KEY `persediaan_bhp` (`persediaan_bhp`) USING BTREE,
  KEY `utang_jasa_dokter` (`utang_jasa_dokter`) USING BTREE,
  KEY `utang_jasa_paramedis` (`utang_jasa_paramedis`) USING BTREE,
  KEY `utang_jasa_sarana` (`utang_jasa_sarana`) USING BTREE,
  KEY `utang_kso` (`utang_kso`) USING BTREE,
  KEY `utang_menejemen` (`utang_menejemen`) USING BTREE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_10` FOREIGN KEY (`beban_kso`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_11` FOREIGN KEY (`beban_menejemen`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_12` FOREIGN KEY (`hpp_persediaan`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_13` FOREIGN KEY (`pendapatan_tindakan`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_14` FOREIGN KEY (`persediaan_bhp`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_2` FOREIGN KEY (`utang_jasa_dokter`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_3` FOREIGN KEY (`utang_jasa_paramedis`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_4` FOREIGN KEY (`utang_jasa_sarana`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_5` FOREIGN KEY (`utang_kso`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_6` FOREIGN KEY (`utang_menejemen`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_7` FOREIGN KEY (`beban_jasa_dokter`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_8` FOREIGN KEY (`beban_jasa_paramedis`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrik_akun_jns_perawatan_inap_ibfk_9` FOREIGN KEY (`beban_jasa_sarana`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `metode_racik` */

DROP TABLE IF EXISTS `metode_racik`;

CREATE TABLE `metode_racik` (
  `kd_racik` varchar(3) NOT NULL,
  `nm_racik` varchar(30) NOT NULL,
  PRIMARY KEY (`kd_racik`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `mlite_antrian_loket` */

DROP TABLE IF EXISTS `mlite_antrian_loket`;

CREATE TABLE `mlite_antrian_loket` (
  `kd` int(50) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  `noantrian` varchar(50) NOT NULL,
  `postdate` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL DEFAULT '00:00:00',
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_antrian_referensi` */

DROP TABLE IF EXISTS `mlite_antrian_referensi`;

CREATE TABLE `mlite_antrian_referensi` (
  `tanggal_periksa` date NOT NULL,
  `nomor_kartu` varchar(50) NOT NULL,
  `nomor_referensi` varchar(50) NOT NULL,
  PRIMARY KEY (`nomor_referensi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_billing` */

DROP TABLE IF EXISTS `mlite_billing`;

CREATE TABLE `mlite_billing` (
  `id_billing` int(11) NOT NULL AUTO_INCREMENT,
  `kd_billing` varchar(100) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `jumlah_total` int(100) NOT NULL,
  `potongan` int(100) NOT NULL,
  `jumlah_harus_bayar` int(100) NOT NULL,
  `jumlah_bayar` int(100) NOT NULL,
  `tgl_billing` date NOT NULL,
  `jam_billing` time NOT NULL,
  `id_user` int(11) NOT NULL,
  `keterangan` varchar(100) NOT NULL,
  PRIMARY KEY (`id_billing`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_geolocation_presensi` */

DROP TABLE IF EXISTS `mlite_geolocation_presensi`;

CREATE TABLE `mlite_geolocation_presensi` (
  `id` int(11) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `latitude` varchar(200) NOT NULL,
  `longitude` varchar(200) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `mlite_geolocation_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_login_attempts` */

DROP TABLE IF EXISTS `mlite_login_attempts`;

CREATE TABLE `mlite_login_attempts` (
  `ip` text DEFAULT NULL,
  `attempts` int(100) NOT NULL,
  `expires` int(100) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_modules` */

DROP TABLE IF EXISTS `mlite_modules`;

CREATE TABLE `mlite_modules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dir` text DEFAULT NULL,
  `sequence` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_pasien_galleries` */

DROP TABLE IF EXISTS `mlite_pasien_galleries`;

CREATE TABLE `mlite_pasien_galleries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `slug` text NOT NULL,
  `img_per_page` varchar(50) NOT NULL DEFAULT '0',
  `sort` varchar(50) NOT NULL DEFAULT 'DESC',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_pasien_galleries_items` */

DROP TABLE IF EXISTS `mlite_pasien_galleries_items`;

CREATE TABLE `mlite_pasien_galleries_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gallery` varchar(50) NOT NULL,
  `src` text NOT NULL,
  `title` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_remember_me` */

DROP TABLE IF EXISTS `mlite_remember_me`;

CREATE TABLE `mlite_remember_me` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` text DEFAULT NULL,
  `user_id` int(10) NOT NULL,
  `expiry` int(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `mlite_remember_me_ibfk_1` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_settings` */

DROP TABLE IF EXISTS `mlite_settings`;

CREATE TABLE `mlite_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `module` text DEFAULT NULL,
  `field` text DEFAULT NULL,
  `value` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=233 DEFAULT CHARSET=utf8;

/*Table structure for table `mlite_users` */

DROP TABLE IF EXISTS `mlite_users`;

CREATE TABLE `mlite_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text DEFAULT NULL,
  `fullname` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `avatar` text DEFAULT NULL,
  `email` text DEFAULT NULL,
  `role` varchar(100) NOT NULL DEFAULT 'user',
  `cap` varchar(100) DEFAULT '',
  `access` varchar(500) NOT NULL DEFAULT 'dashboard',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `monitoring_asuhan_gizi` */

DROP TABLE IF EXISTS `monitoring_asuhan_gizi`;

CREATE TABLE `monitoring_asuhan_gizi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `monitoring` varchar(200) DEFAULT NULL,
  `evaluasi` varchar(200) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tanggal`),
  KEY `nip` (`nip`),
  CONSTRAINT `monitoring_asuhan_gizi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `monitoring_asuhan_gizi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `mutasi_berkas` */

DROP TABLE IF EXISTS `mutasi_berkas`;

CREATE TABLE `mutasi_berkas` (
  `no_rawat` varchar(17) NOT NULL,
  `status` enum('Sudah Dikirim','Sudah Diterima','Sudah Kembali','Tidak Ada','Masuk Ranap') DEFAULT NULL,
  `dikirim` datetime DEFAULT NULL,
  `diterima` datetime DEFAULT NULL,
  `kembali` datetime DEFAULT NULL,
  `tidakada` datetime DEFAULT NULL,
  `ranap` datetime NOT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `mutasi_berkas_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `mutasibarang` */

DROP TABLE IF EXISTS `mutasibarang`;

CREATE TABLE `mutasibarang` (
  `kode_brng` varchar(15) NOT NULL,
  `jml` double NOT NULL,
  `harga` double NOT NULL,
  `kd_bangsaldari` char(5) NOT NULL,
  `kd_bangsalke` char(5) NOT NULL,
  `tanggal` datetime NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`kode_brng`,`kd_bangsaldari`,`kd_bangsalke`,`tanggal`,`no_batch`,`no_faktur`),
  KEY `kd_bangsaldari` (`kd_bangsaldari`),
  KEY `kd_bangsalke` (`kd_bangsalke`),
  KEY `jml` (`jml`),
  KEY `keterangan` (`keterangan`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `mutasibarang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_2` FOREIGN KEY (`kd_bangsaldari`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `mutasibarang_ibfk_3` FOREIGN KEY (`kd_bangsalke`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `nota_inap` */

DROP TABLE IF EXISTS `nota_inap`;

CREATE TABLE `nota_inap` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `no_nota` varchar(17) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `Uang_Muka` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_nota` (`no_nota`),
  KEY `tanggal` (`tanggal`),
  KEY `jam` (`jam`),
  KEY `Uang_Muka` (`Uang_Muka`),
  CONSTRAINT `nota_inap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `nota_jalan` */

DROP TABLE IF EXISTS `nota_jalan`;

CREATE TABLE `nota_jalan` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `no_nota` varchar(17) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `Jasa_Medik_Dokter_Tindakan_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Paramedis_Tindakan_Ralan` double DEFAULT NULL,
  `KSO_Tindakan_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Dokter_Laborat_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Petugas_Laborat_Ralan` double DEFAULT NULL,
  `Kso_Laborat_Ralan` double DEFAULT NULL,
  `Persediaan_Laborat_Rawat_Jalan` double DEFAULT NULL,
  `Jasa_Medik_Dokter_Radiologi_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Petugas_Radiologi_Ralan` double DEFAULT NULL,
  `Kso_Radiologi_Ralan` double DEFAULT NULL,
  `Persediaan_Radiologi_Rawat_Jalan` double DEFAULT NULL,
  `Obat_Rawat_Jalan` double DEFAULT NULL,
  `Jasa_Medik_Dokter_Operasi_Ralan` double DEFAULT NULL,
  `Jasa_Medik_Paramedis_Operasi_Ralan` double DEFAULT NULL,
  `Obat_Operasi_Ralan` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  UNIQUE KEY `no_nota` (`no_nota`),
  KEY `tanggal` (`tanggal`),
  KEY `jam` (`jam`),
  KEY `Jasa_Medik_Dokter_Tindakan_Ralan` (`Jasa_Medik_Dokter_Tindakan_Ralan`),
  KEY `Jasa_Medik_Paramedis_Tindakan_Ralan` (`Jasa_Medik_Paramedis_Tindakan_Ralan`),
  CONSTRAINT `nota_jalan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `obat_penyakit` */

DROP TABLE IF EXISTS `obat_penyakit`;

CREATE TABLE `obat_penyakit` (
  `kd_penyakit` varchar(10) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL,
  `referensi` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kd_penyakit`,`kode_brng`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `kd_obat` (`kode_brng`),
  CONSTRAINT `obat_penyakit_ibfk_1` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE,
  CONSTRAINT `obat_penyakit_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `obat_racikan` */

DROP TABLE IF EXISTS `obat_racikan`;

CREATE TABLE `obat_racikan` (
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `no_racik` varchar(2) NOT NULL,
  `nama_racik` varchar(100) NOT NULL,
  `kd_racik` varchar(3) NOT NULL,
  `jml_dr` int(11) NOT NULL,
  `aturan_pakai` varchar(150) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`tgl_perawatan`,`jam`,`no_rawat`,`no_racik`),
  KEY `kd_racik` (`kd_racik`),
  KEY `no_rawat` (`no_rawat`),
  KEY `no_racik` (`no_racik`),
  CONSTRAINT `obat_racikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `obat_racikan_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `obat_racikan_jual` */

DROP TABLE IF EXISTS `obat_racikan_jual`;

CREATE TABLE `obat_racikan_jual` (
  `nota_jual` varchar(20) NOT NULL,
  `no_racik` varchar(2) NOT NULL,
  `nama_racik` varchar(100) NOT NULL,
  `kd_racik` varchar(3) NOT NULL,
  `jml_dr` int(11) NOT NULL,
  `aturan_pakai` varchar(150) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`nota_jual`,`no_racik`),
  KEY `kd_racik` (`kd_racik`),
  CONSTRAINT `obat_racikan_jual_ibfk_1` FOREIGN KEY (`nota_jual`) REFERENCES `penjualan` (`nota_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `obat_racikan_jual_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `obatbhp_ok` */

DROP TABLE IF EXISTS `obatbhp_ok`;

CREATE TABLE `obatbhp_ok` (
  `kd_obat` varchar(15) NOT NULL,
  `nm_obat` varchar(50) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `hargasatuan` double NOT NULL,
  PRIMARY KEY (`kd_obat`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nm_obat` (`nm_obat`),
  KEY `hargasatuan` (`hargasatuan`),
  CONSTRAINT `obatbhp_ok_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `operasi` */

DROP TABLE IF EXISTS `operasi`;

CREATE TABLE `operasi` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_operasi` datetime NOT NULL,
  `jenis_anasthesi` varchar(8) NOT NULL,
  `kategori` enum('-','Khusus','Besar','Sedang','Kecil','Elektive','Emergency') DEFAULT NULL,
  `operator1` varchar(20) NOT NULL,
  `operator2` varchar(20) NOT NULL,
  `operator3` varchar(20) NOT NULL,
  `asisten_operator1` varchar(20) NOT NULL,
  `asisten_operator2` varchar(20) NOT NULL,
  `asisten_operator3` varchar(20) DEFAULT NULL,
  `instrumen` varchar(20) DEFAULT NULL,
  `dokter_anak` varchar(20) NOT NULL,
  `perawaat_resusitas` varchar(20) NOT NULL,
  `dokter_anestesi` varchar(20) NOT NULL,
  `asisten_anestesi` varchar(20) NOT NULL,
  `asisten_anestesi2` varchar(20) DEFAULT NULL,
  `bidan` varchar(20) NOT NULL,
  `bidan2` varchar(20) DEFAULT NULL,
  `bidan3` varchar(20) DEFAULT NULL,
  `perawat_luar` varchar(20) NOT NULL,
  `omloop` varchar(20) DEFAULT NULL,
  `omloop2` varchar(20) DEFAULT NULL,
  `omloop3` varchar(20) DEFAULT NULL,
  `omloop4` varchar(20) DEFAULT NULL,
  `omloop5` varchar(20) DEFAULT NULL,
  `dokter_pjanak` varchar(20) DEFAULT NULL,
  `dokter_umum` varchar(20) DEFAULT NULL,
  `kode_paket` varchar(15) NOT NULL,
  `biayaoperator1` double NOT NULL,
  `biayaoperator2` double NOT NULL,
  `biayaoperator3` double NOT NULL,
  `biayaasisten_operator1` double NOT NULL,
  `biayaasisten_operator2` double NOT NULL,
  `biayaasisten_operator3` double DEFAULT NULL,
  `biayainstrumen` double DEFAULT NULL,
  `biayadokter_anak` double NOT NULL,
  `biayaperawaat_resusitas` double NOT NULL,
  `biayadokter_anestesi` double NOT NULL,
  `biayaasisten_anestesi` double NOT NULL,
  `biayaasisten_anestesi2` double DEFAULT NULL,
  `biayabidan` double NOT NULL,
  `biayabidan2` double DEFAULT NULL,
  `biayabidan3` double DEFAULT NULL,
  `biayaperawat_luar` double NOT NULL,
  `biayaalat` double NOT NULL,
  `biayasewaok` double NOT NULL,
  `akomodasi` double DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `biaya_omloop` double DEFAULT NULL,
  `biaya_omloop2` double DEFAULT NULL,
  `biaya_omloop3` double DEFAULT NULL,
  `biaya_omloop4` double DEFAULT NULL,
  `biaya_omloop5` double DEFAULT NULL,
  `biayasarpras` double DEFAULT NULL,
  `biaya_dokter_pjanak` double DEFAULT NULL,
  `biaya_dokter_umum` double DEFAULT NULL,
  `status` enum('Ranap','Ralan') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_operasi`,`kode_paket`),
  KEY `no_rawat` (`no_rawat`),
  KEY `operator1` (`operator1`),
  KEY `operator2` (`operator2`),
  KEY `operator3` (`operator3`),
  KEY `asisten_operator1` (`asisten_operator1`),
  KEY `asisten_operator2` (`asisten_operator2`),
  KEY `asisten_operator3` (`instrumen`),
  KEY `dokter_anak` (`dokter_anak`),
  KEY `perawaat_resusitas` (`perawaat_resusitas`),
  KEY `dokter_anestesi` (`dokter_anestesi`),
  KEY `asisten_anestesi` (`asisten_anestesi`),
  KEY `bidan` (`bidan`),
  KEY `perawat_luar` (`perawat_luar`),
  KEY `kode_paket` (`kode_paket`),
  KEY `operasi_ibfk_45` (`bidan2`),
  KEY `operasi_ibfk_46` (`bidan3`),
  KEY `operasi_ibfk_47` (`omloop`),
  KEY `operasi_ibfk_48` (`omloop2`),
  KEY `operasi_ibfk_49` (`omloop3`),
  KEY `dokter_pjanak` (`dokter_pjanak`),
  KEY `dokter_umum` (`dokter_umum`),
  KEY `asisten_operator3_2` (`asisten_operator3`),
  KEY `asisten_anestesi2` (`asisten_anestesi2`),
  KEY `omloop4` (`omloop4`),
  KEY `omloop5` (`omloop5`),
  CONSTRAINT `operasi_ibfk_31` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_32` FOREIGN KEY (`operator1`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_33` FOREIGN KEY (`operator2`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_34` FOREIGN KEY (`operator3`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_35` FOREIGN KEY (`asisten_operator1`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_36` FOREIGN KEY (`asisten_operator2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_37` FOREIGN KEY (`instrumen`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_38` FOREIGN KEY (`dokter_anak`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_39` FOREIGN KEY (`perawaat_resusitas`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_40` FOREIGN KEY (`dokter_anestesi`) REFERENCES `dokter` (`kd_dokter`) ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_41` FOREIGN KEY (`asisten_anestesi`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_42` FOREIGN KEY (`bidan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_43` FOREIGN KEY (`perawat_luar`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_44` FOREIGN KEY (`kode_paket`) REFERENCES `paket_operasi` (`kode_paket`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_45` FOREIGN KEY (`bidan2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_46` FOREIGN KEY (`bidan3`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_47` FOREIGN KEY (`omloop`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_48` FOREIGN KEY (`omloop2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_49` FOREIGN KEY (`omloop3`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_50` FOREIGN KEY (`dokter_pjanak`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_51` FOREIGN KEY (`dokter_umum`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_52` FOREIGN KEY (`asisten_operator3`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_53` FOREIGN KEY (`asisten_anestesi2`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_54` FOREIGN KEY (`omloop4`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `operasi_ibfk_55` FOREIGN KEY (`omloop5`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `opname` */

DROP TABLE IF EXISTS `opname`;

CREATE TABLE `opname` (
  `kode_brng` varchar(15) NOT NULL,
  `h_beli` double DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` double NOT NULL,
  `real` double NOT NULL,
  `selisih` double NOT NULL,
  `nomihilang` double NOT NULL,
  `lebih` double NOT NULL,
  `nomilebih` double NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`kode_brng`,`tanggal`,`kd_bangsal`,`no_batch`,`no_faktur`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `stok` (`stok`),
  KEY `real` (`real`),
  KEY `selisih` (`selisih`),
  KEY `nomihilang` (`nomihilang`),
  KEY `keterangan` (`keterangan`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `opname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `opname_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `paket_operasi` */

DROP TABLE IF EXISTS `paket_operasi`;

CREATE TABLE `paket_operasi` (
  `kode_paket` varchar(15) NOT NULL,
  `nm_perawatan` varchar(80) NOT NULL,
  `kategori` enum('Kebidanan','Operasi') DEFAULT NULL,
  `operator1` double NOT NULL,
  `operator2` double NOT NULL,
  `operator3` double NOT NULL,
  `asisten_operator1` double DEFAULT NULL,
  `asisten_operator2` double NOT NULL,
  `asisten_operator3` double DEFAULT NULL,
  `instrumen` double DEFAULT NULL,
  `dokter_anak` double NOT NULL,
  `perawaat_resusitas` double NOT NULL,
  `dokter_anestesi` double NOT NULL,
  `asisten_anestesi` double NOT NULL,
  `asisten_anestesi2` double DEFAULT NULL,
  `bidan` double NOT NULL,
  `bidan2` double DEFAULT NULL,
  `bidan3` double DEFAULT NULL,
  `perawat_luar` double NOT NULL,
  `sewa_ok` double NOT NULL,
  `alat` double NOT NULL,
  `akomodasi` double DEFAULT NULL,
  `bagian_rs` double NOT NULL,
  `omloop` double NOT NULL,
  `omloop2` double DEFAULT NULL,
  `omloop3` double DEFAULT NULL,
  `omloop4` double DEFAULT NULL,
  `omloop5` double DEFAULT NULL,
  `sarpras` double DEFAULT NULL,
  `dokter_pjanak` double DEFAULT NULL,
  `dokter_umum` double DEFAULT NULL,
  `kd_pj` char(3) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  `kelas` enum('-','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') DEFAULT NULL,
  PRIMARY KEY (`kode_paket`),
  KEY `nm_perawatan` (`nm_perawatan`),
  KEY `operator1` (`operator1`),
  KEY `operator2` (`operator2`),
  KEY `operator3` (`operator3`),
  KEY `asisten_operator1` (`asisten_operator1`),
  KEY `asisten_operator2` (`asisten_operator2`),
  KEY `asisten_operator3` (`instrumen`),
  KEY `dokter_anak` (`dokter_anak`),
  KEY `perawat_resusitas` (`perawaat_resusitas`),
  KEY `dokter_anestasi` (`dokter_anestesi`),
  KEY `asisten_anastesi` (`asisten_anestesi`),
  KEY `bidan` (`bidan`),
  KEY `perawat_luar` (`perawat_luar`),
  KEY `sewa_ok` (`sewa_ok`),
  KEY `alat` (`alat`),
  KEY `sewa_vk` (`akomodasi`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `omloop` (`omloop`),
  KEY `kd_pj` (`kd_pj`),
  KEY `asisten_anestesi2` (`asisten_anestesi2`),
  KEY `omloop2` (`omloop2`),
  KEY `omloop3` (`omloop3`),
  KEY `omloop4` (`omloop4`),
  KEY `omloop5` (`omloop5`),
  KEY `status` (`status`),
  KEY `kategori` (`kategori`),
  KEY `bidan2` (`bidan2`),
  KEY `bidan3` (`bidan3`),
  KEY `asisten_operator3_2` (`asisten_operator3`),
  CONSTRAINT `paket_operasi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pangkat_polri` */

DROP TABLE IF EXISTS `pangkat_polri`;

CREATE TABLE `pangkat_polri` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pangkat` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `pangkat_tni` */

DROP TABLE IF EXISTS `pangkat_tni`;

CREATE TABLE `pangkat_tni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pangkat` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `parkir` */

DROP TABLE IF EXISTS `parkir`;

CREATE TABLE `parkir` (
  `nip` varchar(20) DEFAULT NULL,
  `nomer_kartu` varchar(5) DEFAULT NULL,
  `kd_parkir` varchar(5) DEFAULT NULL,
  `no_kendaraan` varchar(15) NOT NULL DEFAULT '',
  `tgl_masuk` date NOT NULL DEFAULT '0000-00-00',
  `jam_masuk` time NOT NULL DEFAULT '00:00:00',
  `tgl_keluar` date DEFAULT NULL,
  `jam_keluar` time DEFAULT NULL,
  `lama_parkir` int(11) DEFAULT NULL,
  `ttl_biaya` double DEFAULT NULL,
  PRIMARY KEY (`no_kendaraan`,`tgl_masuk`,`jam_masuk`),
  KEY `kd_barcode` (`nomer_kartu`),
  KEY `kd_petugas` (`nip`),
  KEY `kd_parkir` (`kd_parkir`),
  CONSTRAINT `parkir_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `parkir_ibfk_2` FOREIGN KEY (`kd_parkir`) REFERENCES `parkir_jenis` (`kd_parkir`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `parkir_barcode` */

DROP TABLE IF EXISTS `parkir_barcode`;

CREATE TABLE `parkir_barcode` (
  `kode_barcode` varchar(15) NOT NULL,
  `nomer_kartu` varchar(5) NOT NULL,
  PRIMARY KEY (`kode_barcode`),
  UNIQUE KEY `no_card` (`nomer_kartu`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `parkir_jenis` */

DROP TABLE IF EXISTS `parkir_jenis`;

CREATE TABLE `parkir_jenis` (
  `kd_parkir` char(5) NOT NULL,
  `jns_parkir` varchar(50) NOT NULL,
  `biaya` double NOT NULL,
  `jenis` enum('Harian','Jam') NOT NULL,
  PRIMARY KEY (`kd_parkir`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pasien` */

DROP TABLE IF EXISTS `pasien`;

CREATE TABLE `pasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `nm_pasien` varchar(40) DEFAULT NULL,
  `no_ktp` varchar(20) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(15) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `nm_ibu` varchar(40) NOT NULL,
  `alamat` varchar(200) DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') DEFAULT NULL,
  `pekerjaan` varchar(35) DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `tgl_daftar` date DEFAULT NULL,
  `no_tlp` varchar(40) DEFAULT NULL,
  `umur` varchar(20) NOT NULL,
  `pnd` enum('TS','TK','SD','SMP','SMA','SLTA/SEDERAJAT','D1','D2','D3','D4','S1','S2','S3','-') NOT NULL,
  `keluarga` enum('AYAH','IBU','ISTRI','SUAMI','SAUDARA','ANAK') DEFAULT NULL,
  `namakeluarga` varchar(50) NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `no_peserta` varchar(25) DEFAULT NULL,
  `kd_kel` int(11) NOT NULL,
  `kd_kec` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `pekerjaanpj` varchar(35) NOT NULL,
  `alamatpj` varchar(100) NOT NULL,
  `kelurahanpj` varchar(60) NOT NULL,
  `kecamatanpj` varchar(60) NOT NULL,
  `kabupatenpj` varchar(60) NOT NULL,
  `perusahaan_pasien` varchar(8) NOT NULL,
  `suku_bangsa` int(11) NOT NULL,
  `bahasa_pasien` int(11) NOT NULL,
  `cacat_fisik` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `nip` varchar(30) NOT NULL,
  `kd_prop` int(11) NOT NULL,
  `propinsipj` varchar(30) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_kec` (`kd_kec`),
  KEY `kd_kab` (`kd_kab`),
  KEY `nm_pasien` (`nm_pasien`),
  KEY `alamat` (`alamat`),
  KEY `kd_kel_2` (`kd_kel`),
  KEY `no_ktp` (`no_ktp`),
  KEY `no_peserta` (`no_peserta`),
  KEY `perusahaan_pasien` (`perusahaan_pasien`),
  KEY `suku_bangsa` (`suku_bangsa`),
  KEY `bahasa_pasien` (`bahasa_pasien`),
  KEY `cacat_fisik` (`cacat_fisik`),
  KEY `kd_prop` (`kd_prop`),
  CONSTRAINT `pasien_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_2` FOREIGN KEY (`kd_kel`) REFERENCES `kelurahan` (`kd_kel`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_3` FOREIGN KEY (`kd_kec`) REFERENCES `kecamatan` (`kd_kec`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_4` FOREIGN KEY (`kd_kab`) REFERENCES `kabupaten` (`kd_kab`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_5` FOREIGN KEY (`perusahaan_pasien`) REFERENCES `perusahaan_pasien` (`kode_perusahaan`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_6` FOREIGN KEY (`suku_bangsa`) REFERENCES `suku_bangsa` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_7` FOREIGN KEY (`bahasa_pasien`) REFERENCES `bahasa_pasien` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_8` FOREIGN KEY (`cacat_fisik`) REFERENCES `cacat_fisik` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_ibfk_9` FOREIGN KEY (`kd_prop`) REFERENCES `propinsi` (`kd_prop`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pasien_bayi` */

DROP TABLE IF EXISTS `pasien_bayi`;

CREATE TABLE `pasien_bayi` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `umur_ibu` varchar(8) NOT NULL,
  `nama_ayah` varchar(50) NOT NULL,
  `umur_ayah` varchar(8) NOT NULL,
  `berat_badan` varchar(10) NOT NULL,
  `panjang_badan` varchar(10) NOT NULL,
  `lingkar_kepala` varchar(10) NOT NULL,
  `proses_lahir` varchar(60) NOT NULL,
  `anakke` char(2) NOT NULL,
  `jam_lahir` time NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `diagnosa` varchar(60) DEFAULT NULL,
  `penyulit_kehamilan` varchar(60) DEFAULT NULL,
  `ketuban` varchar(60) DEFAULT NULL,
  `lingkar_perut` varchar(10) DEFAULT NULL,
  `lingkar_dada` varchar(10) DEFAULT NULL,
  `penolong` varchar(20) DEFAULT NULL,
  `no_skl` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  UNIQUE KEY `no_skl` (`no_skl`),
  KEY `umur_ibu` (`umur_ibu`),
  KEY `umur_ayah` (`umur_ayah`),
  KEY `berat_badan` (`berat_badan`),
  KEY `panjang_badan` (`panjang_badan`),
  KEY `lingkar_kepala` (`lingkar_kepala`),
  KEY `proses_lahir` (`proses_lahir`),
  KEY `anakke` (`anakke`),
  KEY `jam_lahir` (`jam_lahir`),
  KEY `keterangan` (`keterangan`),
  KEY `penolong` (`penolong`),
  CONSTRAINT `pasien_bayi_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pasien_bayi_ibfk_2` FOREIGN KEY (`penolong`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pasien_corona` */

DROP TABLE IF EXISTS `pasien_corona`;

CREATE TABLE `pasien_corona` (
  `no_pengenal` varchar(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `inisial` varchar(15) DEFAULT NULL,
  `nama_lengkap` varchar(40) DEFAULT NULL,
  `tgl_masuk` date DEFAULT NULL,
  `kode_jk` varchar(1) DEFAULT NULL,
  `nama_jk` varchar(10) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `kode_kewarganegaraan` varchar(5) DEFAULT NULL,
  `nama_kewarganegaraan` varchar(25) DEFAULT NULL,
  `kode_penularan` varchar(5) DEFAULT NULL,
  `sumber_penularan` varchar(40) DEFAULT NULL,
  `kd_kelurahan` varchar(15) DEFAULT NULL,
  `nm_kelurahan` varchar(20) DEFAULT NULL,
  `kd_kecamatan` varchar(10) DEFAULT NULL,
  `nm_kecamatan` varchar(20) DEFAULT NULL,
  `kd_kabupaten` varchar(6) DEFAULT NULL,
  `nm_kabupaten` varchar(20) DEFAULT NULL,
  `kd_propinsi` varchar(3) DEFAULT NULL,
  `nm_propinsi` varchar(20) DEFAULT NULL,
  `tgl_keluar` date DEFAULT NULL,
  `kode_statuskeluar` varchar(5) DEFAULT NULL,
  `nama_statuskeluar` varchar(40) DEFAULT NULL,
  `tgl_lapor` datetime DEFAULT NULL,
  `kode_statusrawat` varchar(5) DEFAULT NULL,
  `nama_statusrawat` varchar(40) DEFAULT NULL,
  `kode_statusisolasi` varchar(5) DEFAULT NULL,
  `nama_statusisolasi` varchar(100) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `notelp` varchar(40) DEFAULT NULL,
  `sebab_kematian` varchar(60) DEFAULT NULL,
  `kode_jenis_pasien` varchar(5) NOT NULL,
  `nama_jenis_pasien` varchar(40) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `pasien_corona_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pasien_mati` */

DROP TABLE IF EXISTS `pasien_mati`;

CREATE TABLE `pasien_mati` (
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `no_rkm_medis` varchar(15) NOT NULL DEFAULT '',
  `keterangan` varchar(100) DEFAULT NULL,
  `temp_meninggal` enum('-','Rumah Sakit','Puskesmas','Rumah Bersalin','Rumah Tempat Tinggal','Lain-lain (Termasuk Doa)','Tidak tahu') DEFAULT NULL,
  `icd1` varchar(20) DEFAULT NULL,
  `icd2` varchar(20) DEFAULT NULL,
  `icd3` varchar(20) DEFAULT NULL,
  `icd4` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `pasien_mati_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pasien_polri` */

DROP TABLE IF EXISTS `pasien_polri`;

CREATE TABLE `pasien_polri` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `golongan_polri` int(11) NOT NULL,
  `pangkat_polri` int(11) NOT NULL,
  `satuan_polri` int(11) NOT NULL,
  `jabatan_polri` int(11) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `golongan_polri` (`golongan_polri`),
  KEY `pangkat_polri` (`pangkat_polri`),
  KEY `satuan_polri` (`satuan_polri`),
  KEY `jabatan` (`jabatan_polri`),
  CONSTRAINT `pasien_polri_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pasien_polri_ibfk_2` FOREIGN KEY (`golongan_polri`) REFERENCES `golongan_polri` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_polri_ibfk_3` FOREIGN KEY (`pangkat_polri`) REFERENCES `pangkat_polri` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_polri_ibfk_4` FOREIGN KEY (`satuan_polri`) REFERENCES `satuan_polri` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_polri_ibfk_5` FOREIGN KEY (`jabatan_polri`) REFERENCES `jabatan_polri` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pasien_tni` */

DROP TABLE IF EXISTS `pasien_tni`;

CREATE TABLE `pasien_tni` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `golongan_tni` int(11) NOT NULL,
  `pangkat_tni` int(11) NOT NULL,
  `satuan_tni` int(11) NOT NULL,
  `jabatan_tni` int(11) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  KEY `golongan_tni` (`golongan_tni`),
  KEY `pangkat_tni` (`pangkat_tni`),
  KEY `satuan_tni` (`satuan_tni`),
  KEY `jabatan` (`jabatan_tni`),
  CONSTRAINT `pasien_tni_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pasien_tni_ibfk_2` FOREIGN KEY (`golongan_tni`) REFERENCES `golongan_tni` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_tni_ibfk_3` FOREIGN KEY (`pangkat_tni`) REFERENCES `pangkat_tni` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_tni_ibfk_4` FOREIGN KEY (`satuan_tni`) REFERENCES `satuan_tni` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pasien_tni_ibfk_5` FOREIGN KEY (`jabatan_tni`) REFERENCES `jabatan_tni` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `password_asuransi` */

DROP TABLE IF EXISTS `password_asuransi`;

CREATE TABLE `password_asuransi` (
  `kd_pj` char(3) NOT NULL,
  `usere` varchar(700) DEFAULT NULL,
  `passworde` varchar(700) DEFAULT NULL,
  PRIMARY KEY (`kd_pj`),
  UNIQUE KEY `usere` (`usere`,`passworde`),
  CONSTRAINT `password_asuransi_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `password_resets` */

DROP TABLE IF EXISTS `password_resets`;

CREATE TABLE `password_resets` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `pcare_kegiatan_kelompok` */

DROP TABLE IF EXISTS `pcare_kegiatan_kelompok`;

CREATE TABLE `pcare_kegiatan_kelompok` (
  `eduId` varchar(15) NOT NULL,
  `clubId` varchar(5) DEFAULT NULL,
  `namaClub` varchar(100) NOT NULL,
  `tglPelayanan` date DEFAULT NULL,
  `nmKegiatan` varchar(30) DEFAULT NULL,
  `nmKelompok` varchar(30) DEFAULT NULL,
  `materi` varchar(100) DEFAULT NULL,
  `pembicara` varchar(50) DEFAULT NULL,
  `lokasi` varchar(50) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `biaya` double DEFAULT NULL,
  PRIMARY KEY (`eduId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pcare_kunjungan_umum` */

DROP TABLE IF EXISTS `pcare_kunjungan_umum`;

CREATE TABLE `pcare_kunjungan_umum` (
  `no_rawat` varchar(17) NOT NULL,
  `noKunjungan` varchar(40) DEFAULT NULL,
  `tglDaftar` date DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `nm_pasien` varchar(40) DEFAULT NULL,
  `noKartu` varchar(25) DEFAULT NULL,
  `kdPoli` char(5) DEFAULT NULL,
  `nmPoli` varchar(50) DEFAULT NULL,
  `keluhan` varchar(400) DEFAULT NULL,
  `kdSadar` varchar(5) DEFAULT NULL,
  `nmSadar` varchar(50) DEFAULT NULL,
  `sistole` varchar(3) DEFAULT NULL,
  `diastole` varchar(3) DEFAULT NULL,
  `beratBadan` varchar(5) DEFAULT NULL,
  `tinggiBadan` varchar(5) DEFAULT NULL,
  `respRate` varchar(3) DEFAULT NULL,
  `heartRate` varchar(3) DEFAULT NULL,
  `terapi` varchar(400) DEFAULT NULL,
  `kdStatusPulang` varchar(5) DEFAULT NULL,
  `nmStatusPulang` varchar(50) DEFAULT NULL,
  `tglPulang` date DEFAULT NULL,
  `kdDokter` varchar(20) DEFAULT NULL,
  `nmDokter` varchar(50) DEFAULT NULL,
  `kdDiag1` varchar(10) DEFAULT NULL,
  `nmDiag1` varchar(400) DEFAULT NULL,
  `kdDiag2` varchar(10) DEFAULT NULL,
  `nmDiag2` varchar(400) DEFAULT NULL,
  `kdDiag3` varchar(10) DEFAULT NULL,
  `nmDiag3` varchar(400) DEFAULT NULL,
  `status` enum('Terkirim','Gagal') NOT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `pcare_kunjungan_umum_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pcare_obat_diberikan` */

DROP TABLE IF EXISTS `pcare_obat_diberikan`;

CREATE TABLE `pcare_obat_diberikan` (
  `no_rawat` varchar(17) NOT NULL,
  `noKunjungan` varchar(40) NOT NULL,
  `kdObatSK` varchar(10) DEFAULT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`noKunjungan`,`tgl_perawatan`,`jam`,`kode_brng`,`no_batch`,`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `pcare_obat_diberikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pcare_obat_diberikan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `maping_obat_pcare` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pcare_pendaftaran` */

DROP TABLE IF EXISTS `pcare_pendaftaran`;

CREATE TABLE `pcare_pendaftaran` (
  `no_rawat` varchar(17) NOT NULL,
  `tglDaftar` date NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `nm_pasien` varchar(40) NOT NULL,
  `kdProviderPeserta` varchar(15) NOT NULL,
  `noKartu` varchar(25) NOT NULL,
  `kdPoli` varchar(5) NOT NULL,
  `nmPoli` varchar(50) NOT NULL,
  `keluhan` varchar(400) NOT NULL,
  `kunjSakit` enum('Kunjungan Sakit','Kunjungan Sehat') NOT NULL,
  `sistole` varchar(3) NOT NULL,
  `diastole` varchar(3) NOT NULL,
  `beratBadan` varchar(5) NOT NULL,
  `tinggiBadan` varchar(5) NOT NULL,
  `respRate` varchar(3) NOT NULL,
  `heartRate` varchar(3) NOT NULL,
  `rujukBalik` varchar(3) NOT NULL,
  `kdTkp` enum('10 Rawat Jalan','20 Rawat Inap','50 Promotif Preventif') NOT NULL,
  `noUrut` varchar(5) NOT NULL,
  `status` enum('Terkirim','Gagal') NOT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `pcare_pendaftaran_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pcare_peserta_kegiatan_kelompok` */

DROP TABLE IF EXISTS `pcare_peserta_kegiatan_kelompok`;

CREATE TABLE `pcare_peserta_kegiatan_kelompok` (
  `eduId` varchar(15) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  PRIMARY KEY (`eduId`,`no_rkm_medis`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `pcare_peserta_kegiatan_kelompok_ibfk_1` FOREIGN KEY (`eduId`) REFERENCES `pcare_kegiatan_kelompok` (`eduId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pcare_peserta_kegiatan_kelompok_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pcare_tindakan_ralan_diberikan` */

DROP TABLE IF EXISTS `pcare_tindakan_ralan_diberikan`;

CREATE TABLE `pcare_tindakan_ralan_diberikan` (
  `no_rawat` varchar(17) NOT NULL,
  `noKunjungan` varchar(40) NOT NULL,
  `kdTindakanSK` varchar(15) DEFAULT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double NOT NULL,
  `menejemen` double NOT NULL,
  `biaya_rawat` double NOT NULL,
  PRIMARY KEY (`no_rawat`,`noKunjungan`,`tgl_perawatan`,`jam`,`kd_jenis_prw`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `pcare_tindakan_ralan_diberikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pcare_tindakan_ralan_diberikan_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `maping_tindakan_pcare` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pcare_tindakan_ranap_diberikan` */

DROP TABLE IF EXISTS `pcare_tindakan_ranap_diberikan`;

CREATE TABLE `pcare_tindakan_ranap_diberikan` (
  `no_rawat` varchar(17) NOT NULL,
  `noKunjungan` varchar(40) NOT NULL,
  `kdTindakanSK` varchar(15) DEFAULT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam` time NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double NOT NULL,
  `menejemen` double NOT NULL,
  `biaya_rawat` double NOT NULL,
  PRIMARY KEY (`no_rawat`,`noKunjungan`,`tgl_perawatan`,`jam`,`kd_jenis_prw`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `pcare_tindakan_ranap_diberikan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pcare_tindakan_ranap_diberikan_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `maping_tindakan_ranap_pcare` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pegawai` */

DROP TABLE IF EXISTS `pegawai`;

CREATE TABLE `pegawai` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nik` varchar(20) NOT NULL,
  `nama` varchar(50) NOT NULL,
  `jk` enum('Pria','Wanita') NOT NULL,
  `jbtn` varchar(25) NOT NULL,
  `jnj_jabatan` varchar(5) NOT NULL,
  `kode_kelompok` varchar(3) NOT NULL,
  `kode_resiko` varchar(3) NOT NULL,
  `kode_emergency` varchar(3) NOT NULL,
  `departemen` char(4) NOT NULL,
  `bidang` varchar(15) NOT NULL,
  `stts_wp` char(5) NOT NULL,
  `stts_kerja` char(3) NOT NULL,
  `npwp` varchar(15) NOT NULL,
  `pendidikan` varchar(80) NOT NULL,
  `gapok` double NOT NULL,
  `tmp_lahir` varchar(20) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(60) NOT NULL,
  `kota` varchar(20) NOT NULL,
  `mulai_kerja` date NOT NULL,
  `ms_kerja` enum('<1','PT','FT>1') NOT NULL,
  `indexins` char(4) NOT NULL,
  `bpd` varchar(50) NOT NULL,
  `rekening` varchar(25) NOT NULL,
  `stts_aktif` enum('AKTIF','CUTI','KELUAR','TENAGA LUAR') NOT NULL,
  `wajibmasuk` tinyint(4) NOT NULL,
  `pengurang` double NOT NULL,
  `indek` tinyint(4) NOT NULL,
  `mulai_kontrak` date DEFAULT NULL,
  `cuti_diambil` int(11) NOT NULL,
  `dankes` double NOT NULL,
  `photo` varchar(500) DEFAULT NULL,
  `no_ktp` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nik_2` (`nik`),
  KEY `departemen` (`departemen`),
  KEY `bidang` (`bidang`),
  KEY `stts_wp` (`stts_wp`),
  KEY `stts_kerja` (`stts_kerja`),
  KEY `pendidikan` (`pendidikan`),
  KEY `indexins` (`indexins`),
  KEY `jnj_jabatan` (`jnj_jabatan`),
  KEY `bpd` (`bpd`),
  KEY `nama` (`nama`),
  KEY `jbtn` (`jbtn`),
  KEY `npwp` (`npwp`),
  KEY `dankes` (`dankes`),
  KEY `cuti_diambil` (`cuti_diambil`),
  KEY `mulai_kontrak` (`mulai_kontrak`),
  KEY `stts_aktif` (`stts_aktif`),
  KEY `tmp_lahir` (`tmp_lahir`),
  KEY `alamat` (`alamat`),
  KEY `mulai_kerja` (`mulai_kerja`),
  KEY `gapok` (`gapok`),
  KEY `kota` (`kota`),
  KEY `pengurang` (`pengurang`),
  KEY `indek` (`indek`),
  KEY `jk` (`jk`),
  KEY `ms_kerja` (`ms_kerja`),
  KEY `tgl_lahir` (`tgl_lahir`),
  KEY `rekening` (`rekening`),
  KEY `wajibmasuk` (`wajibmasuk`),
  KEY `kode_emergency` (`kode_emergency`) USING BTREE,
  KEY `kode_kelompok` (`kode_kelompok`) USING BTREE,
  KEY `kode_resiko` (`kode_resiko`) USING BTREE,
  CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`jnj_jabatan`) REFERENCES `jnj_jabatan` (`kode`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_10` FOREIGN KEY (`kode_kelompok`) REFERENCES `kelompok_jabatan` (`kode_kelompok`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_11` FOREIGN KEY (`kode_resiko`) REFERENCES `resiko_kerja` (`kode_resiko`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`departemen`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_3` FOREIGN KEY (`bidang`) REFERENCES `bidang` (`nama`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_4` FOREIGN KEY (`stts_wp`) REFERENCES `stts_wp` (`stts`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_5` FOREIGN KEY (`stts_kerja`) REFERENCES `stts_kerja` (`stts`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_6` FOREIGN KEY (`pendidikan`) REFERENCES `pendidikan` (`tingkat`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_7` FOREIGN KEY (`indexins`) REFERENCES `departemen` (`dep_id`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_8` FOREIGN KEY (`bpd`) REFERENCES `bank` (`namabank`) ON UPDATE CASCADE,
  CONSTRAINT `pegawai_ibfk_9` FOREIGN KEY (`kode_emergency`) REFERENCES `emergency_index` (`kode_emergency`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1118 DEFAULT CHARSET=latin1;

/*Table structure for table `pemasukan_lain` */

DROP TABLE IF EXISTS `pemasukan_lain`;

CREATE TABLE `pemasukan_lain` (
  `no_masuk` varchar(15) NOT NULL,
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `kode_kategori` varchar(5) NOT NULL DEFAULT '',
  `besar` double DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `keperluan` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`no_masuk`),
  KEY `pemasukan_lain_ibfk_2` (`kode_kategori`),
  KEY `pemasukan_lain_ibfk_1` (`nip`),
  CONSTRAINT `pemasukan_lain_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemasukan_lain_ibfk_2` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_pemasukan_lain` (`kode_kategori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pembagian_akte` */

DROP TABLE IF EXISTS `pembagian_akte`;

CREATE TABLE `pembagian_akte` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_akte_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pembagian_resume` */

DROP TABLE IF EXISTS `pembagian_resume`;

CREATE TABLE `pembagian_resume` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_resume_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pembagian_tuslah` */

DROP TABLE IF EXISTS `pembagian_tuslah`;

CREATE TABLE `pembagian_tuslah` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_tuslah_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pembagian_warung` */

DROP TABLE IF EXISTS `pembagian_warung`;

CREATE TABLE `pembagian_warung` (
  `id` int(11) NOT NULL,
  `persen` double NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `pembagian_warung_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pembelian` */

DROP TABLE IF EXISTS `pembelian`;

CREATE TABLE `pembelian` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_beli` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `tagihan` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `pembelian_ibfk_4` (`kd_rek`),
  CONSTRAINT `pembelian_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pembelian_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pembelian_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pembelian_ibfk_4` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemberihibah` */

DROP TABLE IF EXISTS `pemberihibah`;

CREATE TABLE `pemberihibah` (
  `kode_pemberi` char(5) NOT NULL,
  `nama_pemberi` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`kode_pemberi`),
  KEY `nama_suplier` (`nama_pemberi`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_ginekologi_ralan` */

DROP TABLE IF EXISTS `pemeriksaan_ginekologi_ralan`;

CREATE TABLE `pemeriksaan_ginekologi_ralan` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `inspeksi` varchar(50) DEFAULT NULL,
  `inspeksi_vulva` varchar(50) DEFAULT NULL,
  `inspekulo_gine` varchar(50) DEFAULT NULL,
  `fluxus_gine` enum('+','-') DEFAULT NULL,
  `fluor_gine` enum('+','-') DEFAULT NULL,
  `vulva_inspekulo` varchar(50) NOT NULL,
  `portio_inspekulo` varchar(50) DEFAULT NULL,
  `sondage` varchar(50) DEFAULT NULL,
  `portio_dalam` varchar(50) DEFAULT NULL,
  `bentuk` varchar(50) DEFAULT NULL,
  `cavum_uteri` varchar(50) DEFAULT NULL,
  `mobilitas` enum('+','-') DEFAULT NULL,
  `ukuran` varchar(50) DEFAULT NULL,
  `nyeri_tekan` enum('+','-') DEFAULT NULL,
  `adnexa_kanan` varchar(50) DEFAULT NULL,
  `adnexa_kiri` varchar(50) NOT NULL,
  `cavum_douglas` varchar(50) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  CONSTRAINT `pemeriksaan_ginekologi_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_ginekologi_ranap` */

DROP TABLE IF EXISTS `pemeriksaan_ginekologi_ranap`;

CREATE TABLE `pemeriksaan_ginekologi_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `inspeksi` varchar(50) DEFAULT NULL,
  `inspeksi_vulva` varchar(50) DEFAULT NULL,
  `inspekulo_gine` varchar(50) DEFAULT NULL,
  `fluxus_gine` enum('+','-') DEFAULT NULL,
  `fluor_gine` enum('+','-') DEFAULT NULL,
  `vulva_inspekulo` varchar(50) NOT NULL,
  `portio_inspekulo` varchar(50) DEFAULT NULL,
  `sondage` varchar(50) DEFAULT NULL,
  `portio_dalam` varchar(50) DEFAULT NULL,
  `bentuk` varchar(50) DEFAULT NULL,
  `cavum_uteri` varchar(50) DEFAULT NULL,
  `mobilitas` enum('+','-') DEFAULT NULL,
  `ukuran` varchar(50) DEFAULT NULL,
  `nyeri_tekan` enum('+','-') DEFAULT NULL,
  `adnexa_kanan` varchar(50) DEFAULT NULL,
  `adnexa_kiri` varchar(50) NOT NULL,
  `cavum_douglas` varchar(50) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  CONSTRAINT `pemeriksaan_ginekologi_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_obstetri_ralan` */

DROP TABLE IF EXISTS `pemeriksaan_obstetri_ralan`;

CREATE TABLE `pemeriksaan_obstetri_ralan` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `tinggi_uteri` varchar(5) DEFAULT NULL,
  `janin` enum('Tunggal','Gemelli','-') DEFAULT NULL,
  `letak` varchar(50) DEFAULT NULL,
  `panggul` enum('-','5/5','4/5','3/5','2/5','1/5') DEFAULT NULL,
  `denyut` varchar(5) DEFAULT NULL,
  `kontraksi` enum('+','-') DEFAULT NULL,
  `kualitas_mnt` varchar(5) DEFAULT NULL,
  `kualitas_dtk` varchar(5) DEFAULT NULL,
  `fluksus` enum('+','-') DEFAULT NULL,
  `albus` enum('+','-') DEFAULT NULL,
  `vulva` varchar(50) DEFAULT NULL,
  `portio` varchar(50) DEFAULT NULL,
  `dalam` enum('Kenyal','Lunak') DEFAULT NULL,
  `tebal` varchar(5) DEFAULT NULL,
  `arah` enum('depan','axial','belakang') DEFAULT NULL,
  `pembukaan` varchar(50) DEFAULT NULL,
  `penurunan` varchar(50) DEFAULT NULL,
  `denominator` varchar(50) NOT NULL,
  `ketuban` enum('-','+') DEFAULT NULL,
  `feto` enum('Normal','Susp.CPD-FPD','CPD-FPD') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  CONSTRAINT `pemeriksaan_obstetri_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_obstetri_ranap` */

DROP TABLE IF EXISTS `pemeriksaan_obstetri_ranap`;

CREATE TABLE `pemeriksaan_obstetri_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `tinggi_uteri` varchar(5) DEFAULT NULL,
  `janin` enum('Tunggal','Gemelli','-') DEFAULT NULL,
  `letak` varchar(50) DEFAULT NULL,
  `panggul` enum('-','5/5','4/5','3/5','2/5','1/5') DEFAULT NULL,
  `denyut` varchar(5) DEFAULT NULL,
  `kontraksi` enum('+','-') DEFAULT NULL,
  `kualitas_mnt` varchar(5) DEFAULT NULL,
  `kualitas_dtk` varchar(5) DEFAULT NULL,
  `fluksus` enum('+','-') DEFAULT NULL,
  `albus` enum('+','-') DEFAULT NULL,
  `vulva` varchar(50) DEFAULT NULL,
  `portio` varchar(50) DEFAULT NULL,
  `dalam` enum('Kenyal','Lunak') DEFAULT NULL,
  `tebal` varchar(5) DEFAULT NULL,
  `arah` enum('depan','axial','belakang') DEFAULT NULL,
  `pembukaan` varchar(50) DEFAULT NULL,
  `penurunan` varchar(50) DEFAULT NULL,
  `denominator` varchar(50) NOT NULL,
  `ketuban` enum('-','+') DEFAULT NULL,
  `feto` enum('Normal','Susp.CPD-FPD','CPD-FPD') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  CONSTRAINT `pemeriksaan_obstetri_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_odontogram` */

DROP TABLE IF EXISTS `pemeriksaan_odontogram`;

CREATE TABLE `pemeriksaan_odontogram` (
  `no_rkm_medis` varchar(6) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date DEFAULT NULL,
  `jam_rawat` time DEFAULT NULL,
  `gg_xx` char(5) NOT NULL,
  `value` char(7) NOT NULL,
  `catatan` varchar(400) NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `pemeriksaan_odontogram_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_ralan` */

DROP TABLE IF EXISTS `pemeriksaan_ralan`;

CREATE TABLE `pemeriksaan_ralan` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` char(5) DEFAULT NULL,
  `tensi` char(8) NOT NULL,
  `nadi` char(3) DEFAULT NULL,
  `respirasi` char(3) DEFAULT NULL,
  `tinggi` char(5) DEFAULT NULL,
  `berat` char(5) DEFAULT NULL,
  `gcs` varchar(10) DEFAULT NULL,
  `kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma') NOT NULL,
  `keluhan` varchar(400) DEFAULT NULL,
  `pemeriksaan` varchar(400) DEFAULT NULL,
  `alergi` varchar(50) DEFAULT NULL,
  `imun_ke` enum('-','1','2','3','4','5','6','7','8','10','11','12','13') DEFAULT NULL,
  `rtl` varchar(400) NOT NULL,
  `penilaian` varchar(400) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `pemeriksaan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemeriksaan_ranap` */

DROP TABLE IF EXISTS `pemeriksaan_ranap`;

CREATE TABLE `pemeriksaan_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `suhu_tubuh` char(5) DEFAULT NULL,
  `tensi` char(8) NOT NULL,
  `nadi` char(3) DEFAULT NULL,
  `respirasi` char(3) DEFAULT NULL,
  `tinggi` char(5) DEFAULT NULL,
  `berat` char(5) DEFAULT NULL,
  `gcs` varchar(10) DEFAULT NULL,
  `kesadaran` enum('Compos Mentis','Somnolence','Sopor','Coma') NOT NULL,
  `keluhan` varchar(400) DEFAULT NULL,
  `pemeriksaan` varchar(400) DEFAULT NULL,
  `alergi` varchar(50) DEFAULT NULL,
  `penilaian` varchar(400) NOT NULL,
  `rtl` varchar(400) NOT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `pemeriksaan_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pemesanan` */

DROP TABLE IF EXISTS `pemesanan`;

CREATE TABLE `pemesanan` (
  `no_faktur` varchar(20) NOT NULL,
  `no_order` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_pesan` date DEFAULT NULL,
  `tgl_faktur` date DEFAULT NULL,
  `tgl_tempo` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `status` enum('Sudah Dibayar','Belum Dibayar','Belum Lunas') DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `pemesanan_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pemesanan_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `peminjaman_berkas` */

DROP TABLE IF EXISTS `peminjaman_berkas`;

CREATE TABLE `peminjaman_berkas` (
  `peminjam` varchar(60) NOT NULL,
  `id_ruang` varchar(5) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `tgl_pinjam` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `nip` varchar(20) NOT NULL,
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') NOT NULL,
  PRIMARY KEY (`peminjam`,`id_ruang`,`no_rkm_medis`,`tgl_pinjam`,`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `nip` (`nip`),
  KEY `id_ruang` (`id_ruang`),
  CONSTRAINT `peminjaman_berkas_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `peminjaman_berkas_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `peminjaman_berkas_ibfk_3` FOREIGN KEY (`id_ruang`) REFERENCES `inventaris_ruang` (`id_ruang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `peminjaman_koperasi` */

DROP TABLE IF EXISTS `peminjaman_koperasi`;

CREATE TABLE `peminjaman_koperasi` (
  `id` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `pinjaman` double NOT NULL,
  `banyak_angsur` int(11) NOT NULL,
  `pokok` double NOT NULL,
  `jasa` double NOT NULL,
  `status` enum('Lunas','Belum Lunas') NOT NULL,
  PRIMARY KEY (`id`,`tanggal`),
  CONSTRAINT `peminjaman_koperasi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penagihan_piutang` */

DROP TABLE IF EXISTS `penagihan_piutang`;

CREATE TABLE `penagihan_piutang` (
  `no_tagihan` varchar(17) NOT NULL,
  `tanggal` date NOT NULL,
  `tanggaltempo` date NOT NULL,
  `tempo` int(11) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `nip_menyetujui` varchar(20) NOT NULL,
  `kd_pj` varchar(3) NOT NULL,
  `catatan` varchar(100) NOT NULL,
  `kd_rek` varchar(15) NOT NULL,
  `status` enum('Proses Penagihan','Sudah Dibayar') NOT NULL,
  PRIMARY KEY (`no_tagihan`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_rek` (`kd_rek`),
  KEY `penagihan_piutang_ibfk_1` (`nip`),
  KEY `nip_menyetujui` (`nip_menyetujui`),
  CONSTRAINT `penagihan_piutang_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penagihan_piutang_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `penagihan_piutang_ibfk_3` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penagihan_piutang_ibfk_4` FOREIGN KEY (`nip_menyetujui`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pencapaian_kinerja` */

DROP TABLE IF EXISTS `pencapaian_kinerja`;

CREATE TABLE `pencapaian_kinerja` (
  `kode_pencapaian` varchar(3) NOT NULL,
  `nama_pencapaian` varchar(200) DEFAULT NULL,
  `indek` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`kode_pencapaian`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `pencapaian_kinerja_pegawai` */

DROP TABLE IF EXISTS `pencapaian_kinerja_pegawai`;

CREATE TABLE `pencapaian_kinerja_pegawai` (
  `id` int(11) NOT NULL,
  `kode_pencapaian` varchar(3) NOT NULL,
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`id`,`kode_pencapaian`,`tahun`,`bulan`) USING BTREE,
  KEY `kode_pencapaian` (`kode_pencapaian`) USING BTREE,
  CONSTRAINT `pencapaian_kinerja_pegawai_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pencapaian_kinerja_pegawai_ibfk_2` FOREIGN KEY (`kode_pencapaian`) REFERENCES `pencapaian_kinerja` (`kode_pencapaian`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `pendidikan` */

DROP TABLE IF EXISTS `pendidikan`;

CREATE TABLE `pendidikan` (
  `tingkat` varchar(80) NOT NULL,
  `indek` tinyint(4) NOT NULL,
  `gapok1` double NOT NULL,
  `kenaikan` double NOT NULL,
  `maksimal` int(11) NOT NULL,
  PRIMARY KEY (`tingkat`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengaduan` */

DROP TABLE IF EXISTS `pengaduan`;

CREATE TABLE `pengaduan` (
  `id` varchar(15) NOT NULL,
  `tanggal` datetime NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `pesan` varchar(255) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `pengaduan_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengajuan_barang_medis` */

DROP TABLE IF EXISTS `pengajuan_barang_medis`;

CREATE TABLE `pengajuan_barang_medis` (
  `no_pengajuan` varchar(20) NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('Proses Pengajuan','Disetujui','Ditolak') DEFAULT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`no_pengajuan`),
  KEY `nip` (`nip`),
  CONSTRAINT `pengajuan_barang_medis_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengajuan_barang_nonmedis` */

DROP TABLE IF EXISTS `pengajuan_barang_nonmedis`;

CREATE TABLE `pengajuan_barang_nonmedis` (
  `no_pengajuan` varchar(20) NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('Proses Pengajuan','Disetujui','Ditolak') DEFAULT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`no_pengajuan`),
  KEY `nip` (`nip`),
  CONSTRAINT `pengajuan_barang_nonmedis_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengajuan_cuti` */

DROP TABLE IF EXISTS `pengajuan_cuti`;

CREATE TABLE `pengajuan_cuti` (
  `no_pengajuan` varchar(17) NOT NULL,
  `tanggal` date NOT NULL,
  `tanggal_awal` date NOT NULL,
  `tanggal_akhir` date NOT NULL,
  `nik` varchar(20) NOT NULL,
  `urgensi` enum('Tahunan','Besar','Sakit','Bersalin','Alasan Penting','Keterangan Lainnya') NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `jumlah` int(11) NOT NULL,
  `kepentingan` varchar(70) NOT NULL,
  `nik_pj` varchar(20) NOT NULL,
  `status` enum('Proses Pengajuan','Disetujui','Ditolak') NOT NULL,
  PRIMARY KEY (`no_pengajuan`),
  KEY `nik` (`nik`),
  KEY `nik_pj` (`nik_pj`),
  CONSTRAINT `pengajuan_cuti_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON UPDATE CASCADE,
  CONSTRAINT `pengajuan_cuti_ibfk_2` FOREIGN KEY (`nik_pj`) REFERENCES `pegawai` (`nik`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengajuan_inventaris` */

DROP TABLE IF EXISTS `pengajuan_inventaris`;

CREATE TABLE `pengajuan_inventaris` (
  `no_pengajuan` varchar(20) NOT NULL,
  `tanggal` date NOT NULL,
  `nik` varchar(20) NOT NULL,
  `urgensi` enum('Cito','Emergensi','Biasa') NOT NULL,
  `latar_belakang` varchar(200) NOT NULL,
  `nama_barang` varchar(70) NOT NULL,
  `spesifikasi` varchar(200) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  `keterangan` varchar(70) NOT NULL,
  `nik_pj` varchar(20) NOT NULL,
  `status` enum('Proses Pengajuan','Disetujui','Ditolak') NOT NULL,
  PRIMARY KEY (`no_pengajuan`),
  KEY `nik` (`nik`),
  KEY `nik_pj` (`nik_pj`),
  CONSTRAINT `pengajuan_inventaris_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON UPDATE CASCADE,
  CONSTRAINT `pengajuan_inventaris_ibfk_2` FOREIGN KEY (`nik_pj`) REFERENCES `pegawai` (`nik`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengeluaran_harian` */

DROP TABLE IF EXISTS `pengeluaran_harian`;

CREATE TABLE `pengeluaran_harian` (
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `kode_kategori` varchar(5) DEFAULT NULL,
  `biaya` double NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `keterangan` varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`tanggal`,`keterangan`),
  KEY `nip` (`nip`),
  KEY `pengeluaran_harian_ibfk_2` (`kode_kategori`),
  CONSTRAINT `pengeluaran_harian_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pengeluaran_harian_ibfk_2` FOREIGN KEY (`kode_kategori`) REFERENCES `kategori_pengeluaran_harian` (`kode_kategori`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengeluaran_obat_bhp` */

DROP TABLE IF EXISTS `pengeluaran_obat_bhp`;

CREATE TABLE `pengeluaran_obat_bhp` (
  `no_keluar` varchar(15) NOT NULL,
  `tanggal` date NOT NULL,
  `nip` varchar(20) NOT NULL,
  `keterangan` varchar(200) NOT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  PRIMARY KEY (`no_keluar`),
  KEY `nip` (`nip`),
  KEY `tanggal` (`tanggal`),
  KEY `keterangan` (`keterangan`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `pengeluaran_obat_bhp_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `pengeluaran_obat_bhp_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengumuman_epasien` */

DROP TABLE IF EXISTS `pengumuman_epasien`;

CREATE TABLE `pengumuman_epasien` (
  `nik` varchar(20) NOT NULL,
  `tanggal` datetime NOT NULL,
  `pengumuman` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`nik`,`tanggal`),
  CONSTRAINT `pengumuman_epasien_ibfk_1` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pengurangan_biaya` */

DROP TABLE IF EXISTS `pengurangan_biaya`;

CREATE TABLE `pengurangan_biaya` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `nama_pengurangan` varchar(60) NOT NULL,
  `besar_pengurangan` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`nama_pengurangan`),
  CONSTRAINT `pengurangan_biaya_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penilaian_awal_keperawatan_gigi` */

DROP TABLE IF EXISTS `penilaian_awal_keperawatan_gigi`;

CREATE TABLE `penilaian_awal_keperawatan_gigi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') NOT NULL,
  `td` varchar(8) NOT NULL DEFAULT '',
  `nadi` varchar(5) NOT NULL DEFAULT '',
  `rr` varchar(5) NOT NULL,
  `suhu` varchar(5) NOT NULL DEFAULT '',
  `bb` varchar(5) NOT NULL DEFAULT '',
  `tb` varchar(5) NOT NULL DEFAULT '',
  `bmi` varchar(10) NOT NULL,
  `keluhan_utama` varchar(150) NOT NULL DEFAULT '',
  `riwayat_penyakit` enum('Tidak Ada','Diabetes Melitus','Hipertensi','Penyakit Jantung','HIV','Hepatitis','Haemophilia','Lain-lain') DEFAULT NULL,
  `ket_riwayat_penyakit` varchar(30) NOT NULL,
  `alergi` varchar(25) NOT NULL DEFAULT '',
  `riwayat_perawatan_gigi` enum('Tidak','Ya, Kapan') NOT NULL,
  `ket_riwayat_perawatan_gigi` varchar(50) NOT NULL DEFAULT '',
  `kebiasaan_sikat_gigi` enum('1x','2x','3x','Mandi','Setelah Makan','Sebelum Tidur') NOT NULL,
  `kebiasaan_lain` enum('Tidak ada','Minum kopi/teh','Minum alkohol','Bruxism','Menggigit pensil','Mengunyah 1 sisi rahang','Merokok','Lain-lain') DEFAULT NULL,
  `ket_kebiasaan_lain` varchar(30) NOT NULL,
  `obat_yang_diminum_saatini` varchar(100) DEFAULT NULL,
  `alat_bantu` enum('Tidak','Ya') NOT NULL,
  `ket_alat_bantu` varchar(30) NOT NULL,
  `prothesa` enum('Tidak','Ya') NOT NULL,
  `ket_pro` varchar(50) NOT NULL,
  `status_psiko` enum('Tenang','Takut','Cemas','Depresi','Lain-lain') NOT NULL,
  `ket_psiko` varchar(70) NOT NULL,
  `hub_keluarga` enum('Baik','Tidak Baik') NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') NOT NULL,
  `ket_tinggal` varchar(40) NOT NULL,
  `ekonomi` enum('Baik','Cukup','Kurang') NOT NULL,
  `budaya` enum('Tidak Ada','Ada') NOT NULL,
  `ket_budaya` varchar(50) NOT NULL,
  `edukasi` enum('Pasien','Keluarga') NOT NULL,
  `ket_edukasi` varchar(50) NOT NULL,
  `berjalan_a` enum('Ya','Tidak') NOT NULL,
  `berjalan_b` enum('Ya','Tidak') NOT NULL,
  `berjalan_c` enum('Ya','Tidak') NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') NOT NULL,
  `lapor` enum('Ya','Tidak') NOT NULL,
  `ket_lapor` varchar(15) NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') NOT NULL,
  `lokasi` varchar(50) NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `durasi` varchar(25) NOT NULL,
  `frekuensi` varchar(25) NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat','Tidak ada nyeri','Lain-lain') NOT NULL,
  `ket_nyeri` varchar(40) NOT NULL,
  `pada_dokter` enum('Tidak','Ya') NOT NULL,
  `ket_dokter` varchar(15) NOT NULL,
  `kebersihan_mulut` enum('Baik','Cukup','Kurang') NOT NULL,
  `mukosa_mulut` enum('Normal','Pigmentasi','Radang') NOT NULL,
  `karies` enum('Ada','Tidak') NOT NULL,
  `karang_gigi` enum('Ada','Tidak') NOT NULL,
  `gingiva` enum('Normal','Radang') NOT NULL,
  `palatum` enum('Normal','Radang') NOT NULL,
  `rencana` varchar(200) NOT NULL,
  `nip` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`nip`),
  CONSTRAINT `penilaian_awal_keperawatan_gigi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_gigi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penilaian_awal_keperawatan_gigi_masalah` */

DROP TABLE IF EXISTS `penilaian_awal_keperawatan_gigi_masalah`;

CREATE TABLE `penilaian_awal_keperawatan_gigi_masalah` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_masalah` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_masalah`),
  KEY `kode_masalah` (`kode_masalah`),
  CONSTRAINT `penilaian_awal_keperawatan_gigi_masalah_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_gigi_masalah_ibfk_2` FOREIGN KEY (`kode_masalah`) REFERENCES `master_masalah_keperawatan_gigi` (`kode_masalah`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penilaian_awal_keperawatan_kebidanan` */

DROP TABLE IF EXISTS `penilaian_awal_keperawatan_kebidanan`;

CREATE TABLE `penilaian_awal_keperawatan_kebidanan` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') NOT NULL,
  `td` varchar(8) NOT NULL DEFAULT '',
  `nadi` varchar(5) NOT NULL DEFAULT '',
  `rr` varchar(5) NOT NULL,
  `suhu` varchar(5) NOT NULL DEFAULT '',
  `gcs` varchar(10) NOT NULL,
  `bb` varchar(5) NOT NULL DEFAULT '',
  `tb` varchar(5) NOT NULL DEFAULT '',
  `lila` varchar(5) NOT NULL,
  `bmi` varchar(10) NOT NULL,
  `tfu` varchar(10) NOT NULL,
  `tbj` varchar(10) NOT NULL,
  `letak` varchar(10) NOT NULL,
  `presentasi` varchar(10) NOT NULL,
  `penurunan` varchar(10) NOT NULL,
  `his` varchar(10) NOT NULL,
  `kekuatan` varchar(10) NOT NULL,
  `lamanya` varchar(10) NOT NULL,
  `bjj` varchar(10) NOT NULL,
  `ket_bjj` enum('Teratur','Tidak Teratur') NOT NULL,
  `portio` varchar(10) NOT NULL,
  `serviks` varchar(10) NOT NULL,
  `ketuban` varchar(10) NOT NULL,
  `hodge` varchar(10) NOT NULL,
  `inspekulo` enum('Dilakukan','Tidak') NOT NULL,
  `ket_inspekulo` varchar(50) NOT NULL,
  `ctg` enum('Dilakukan','Tidak') NOT NULL,
  `ket_ctg` varchar(50) NOT NULL,
  `usg` enum('Dilakukan','Tidak') NOT NULL,
  `ket_usg` varchar(50) NOT NULL,
  `lab` enum('Dilakukan','Tidak') NOT NULL,
  `ket_lab` varchar(50) NOT NULL,
  `lakmus` enum('Dilakukan','Tidak') NOT NULL,
  `ket_lakmus` varchar(50) NOT NULL,
  `panggul` enum('Luas','Sedang','Sempit','Tidak Dilakukan Pemeriksaan') NOT NULL,
  `keluhan_utama` varchar(1000) NOT NULL DEFAULT '',
  `umur` varchar(10) NOT NULL,
  `lama` varchar(10) NOT NULL,
  `banyaknya` varchar(10) NOT NULL,
  `haid` varchar(20) NOT NULL,
  `siklus` varchar(10) NOT NULL,
  `ket_siklus` enum('Teratur','Tidak Teratur') NOT NULL,
  `ket_siklus1` enum('Tidak Ada Masalah','Dismenorhea','Spotting','Menorhagia','PMS') NOT NULL,
  `status` enum('Menikah','Tidak / Belum Menikah') NOT NULL,
  `kali` varchar(5) NOT NULL,
  `usia1` varchar(5) NOT NULL,
  `ket1` enum('-','Masih Menikah','Cerai','Meninggal') NOT NULL,
  `usia2` varchar(5) DEFAULT NULL,
  `ket2` enum('-','Masih Menikah','Cerai','Meninggal') DEFAULT NULL,
  `usia3` varchar(5) DEFAULT NULL,
  `ket3` enum('-','Masih Menikah','Cerai','Meninggal') DEFAULT NULL,
  `hpht` date DEFAULT NULL,
  `usia_kehamilan` varchar(10) NOT NULL,
  `tp` date DEFAULT NULL,
  `imunisasi` enum('Tidak','Ya') NOT NULL,
  `ket_imunisasi` varchar(10) NOT NULL,
  `g` varchar(10) NOT NULL,
  `p` varchar(10) NOT NULL,
  `a` varchar(10) NOT NULL,
  `hidup` varchar(10) NOT NULL,
  `ginekologi` enum('Tidak Ada','Infertilitas','Infeksi Virus','PMS','Cervisitis Kronis','Endometriosis','Mioma','Polip Cervix','Kanker Kandungan','Operasi Kandungan') NOT NULL,
  `kebiasaan` enum('-','Obat Obatan','Vitamin','Jamu Jamuan') NOT NULL,
  `ket_kebiasaan` varchar(50) NOT NULL,
  `kebiasaan1` enum('Tidak','Ya') NOT NULL,
  `ket_kebiasaan1` varchar(5) NOT NULL,
  `kebiasaan2` enum('Tidak','Ya') NOT NULL,
  `ket_kebiasaan2` varchar(5) NOT NULL,
  `kebiasaan3` enum('Tidak','Ya') NOT NULL,
  `kb` enum('Belum Pernah','Suntik','Pil','AKDR','MOW') NOT NULL,
  `ket_kb` varchar(10) NOT NULL,
  `komplikasi` enum('Tidak Ada','Ada') NOT NULL,
  `ket_komplikasi` varchar(50) NOT NULL,
  `berhenti` varchar(20) NOT NULL,
  `alasan` varchar(50) NOT NULL,
  `alat_bantu` enum('Tidak','Ya') NOT NULL,
  `ket_bantu` varchar(50) NOT NULL DEFAULT '',
  `prothesa` enum('Tidak','Ya') NOT NULL,
  `ket_pro` varchar(50) NOT NULL,
  `adl` enum('Mandiri','Dibantu') NOT NULL,
  `status_psiko` enum('Tenang','Takut','Cemas','Depresi','Lain-Lain') NOT NULL,
  `ket_psiko` varchar(50) NOT NULL,
  `hub_keluarga` enum('Baik','Tidak Baik') NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') NOT NULL,
  `ket_tinggal` varchar(50) NOT NULL,
  `ekonomi` enum('Baik','Cukup','Kurang') NOT NULL,
  `budaya` enum('Tidak Ada','Ada') NOT NULL,
  `ket_budaya` varchar(50) NOT NULL,
  `edukasi` enum('Pasien','Keluarga') NOT NULL,
  `ket_edukasi` varchar(50) NOT NULL,
  `berjalan_a` enum('Ya','Tidak') NOT NULL,
  `berjalan_b` enum('Ya','Tidak') NOT NULL,
  `berjalan_c` enum('Ya','Tidak') NOT NULL,
  `hasil` enum('Tidak Beresiko (Tidak Ditemukan A Dan B)','Resiko Rendah (Ditemukan A/B)','Resiko Tinggi (Ditemukan A Dan B)') NOT NULL,
  `lapor` enum('Ya','Tidak') NOT NULL,
  `ket_lapor` varchar(10) NOT NULL,
  `sg1` enum('Tidak','Tidak Yakin','Ya(1-5 Kg)','Ya(6-10Kg)','Ya(11-15Kg)','Ya(>15Kg)') NOT NULL,
  `nilai1` enum('0','1','2','3','4') NOT NULL,
  `sg2` enum('Ya','Tidak') NOT NULL,
  `nilai2` enum('0','1') NOT NULL,
  `total_hasil` varchar(5) NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-Lain') NOT NULL,
  `ket_provokes` varchar(40) NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-Lain') NOT NULL,
  `ket_quality` varchar(40) NOT NULL,
  `lokasi` varchar(40) NOT NULL,
  `menyebar` enum('Tidak','Ya') NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `durasi` varchar(5) NOT NULL,
  `nyeri_hilang` enum('Istirahat','Mendengar Musik','Minum Obat') NOT NULL,
  `ket_nyeri` varchar(40) NOT NULL,
  `pada_dokter` enum('Tidak','Ya') NOT NULL,
  `ket_dokter` varchar(10) NOT NULL,
  `masalah` varchar(1000) NOT NULL,
  `tindakan` varchar(1000) NOT NULL,
  `nip` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`nip`),
  CONSTRAINT `penilaian_awal_keperawatan_kebidanan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_kebidanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penilaian_awal_keperawatan_ralan` */

DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ralan`;

CREATE TABLE `penilaian_awal_keperawatan_ralan` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') NOT NULL,
  `td` varchar(8) NOT NULL DEFAULT '',
  `nadi` varchar(5) NOT NULL DEFAULT '',
  `rr` varchar(5) NOT NULL,
  `suhu` varchar(5) NOT NULL DEFAULT '',
  `gcs` varchar(5) NOT NULL,
  `bb` varchar(5) NOT NULL DEFAULT '',
  `tb` varchar(5) NOT NULL DEFAULT '',
  `bmi` varchar(10) NOT NULL,
  `keluhan_utama` varchar(150) NOT NULL DEFAULT '',
  `rpd` varchar(100) NOT NULL DEFAULT '',
  `rpk` varchar(100) NOT NULL,
  `rpo` varchar(100) NOT NULL,
  `alergi` varchar(25) NOT NULL DEFAULT '',
  `alat_bantu` enum('Tidak','Ya') NOT NULL,
  `ket_bantu` varchar(50) NOT NULL DEFAULT '',
  `prothesa` enum('Tidak','Ya') NOT NULL,
  `ket_pro` varchar(50) NOT NULL,
  `adl` enum('Mandiri','Dibantu') NOT NULL,
  `status_psiko` enum('Tenang','Takut','Cemas','Depresi','Lain-lain') NOT NULL,
  `ket_psiko` varchar(70) NOT NULL,
  `hub_keluarga` enum('Baik','Tidak Baik') NOT NULL,
  `tinggal_dengan` enum('Sendiri','Orang Tua','Suami / Istri','Lainnya') NOT NULL,
  `ket_tinggal` varchar(40) NOT NULL,
  `ekonomi` enum('Baik','Cukup','Kurang') NOT NULL,
  `budaya` enum('Tidak Ada','Ada') NOT NULL,
  `ket_budaya` varchar(50) NOT NULL,
  `edukasi` enum('Pasien','Keluarga') NOT NULL,
  `ket_edukasi` varchar(50) NOT NULL,
  `berjalan_a` enum('Ya','Tidak') NOT NULL,
  `berjalan_b` enum('Ya','Tidak') NOT NULL,
  `berjalan_c` enum('Ya','Tidak') NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') NOT NULL,
  `lapor` enum('Ya','Tidak') NOT NULL,
  `ket_lapor` varchar(15) NOT NULL,
  `sg1` enum('Tidak','Tidak Yakin','Ya, 1-5 Kg','Ya, 6-10 Kg','Ya, 11-15 Kg','Ya, >15 Kg') NOT NULL,
  `nilai1` enum('0','1','2','3','4') NOT NULL,
  `sg2` enum('Ya','Tidak') NOT NULL,
  `nilai2` enum('0','1') NOT NULL,
  `total_hasil` tinyint(4) NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') NOT NULL,
  `provokes` enum('Proses Penyakit','Benturan','Lain-lain') NOT NULL,
  `ket_provokes` varchar(40) NOT NULL,
  `quality` enum('Seperti Tertusuk','Berdenyut','Teriris','Tertindih','Tertiban','Lain-lain') NOT NULL,
  `ket_quality` varchar(50) NOT NULL,
  `lokasi` varchar(50) NOT NULL,
  `menyebar` enum('Tidak','Ya') NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `durasi` varchar(25) NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') NOT NULL,
  `ket_nyeri` varchar(40) NOT NULL,
  `pada_dokter` enum('Tidak','Ya') NOT NULL,
  `ket_dokter` varchar(15) NOT NULL,
  `rencana` varchar(200) NOT NULL,
  `nip` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`nip`),
  CONSTRAINT `penilaian_awal_keperawatan_ralan_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penilaian_awal_keperawatan_ralan_bayi` */

DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ralan_bayi`;

CREATE TABLE `penilaian_awal_keperawatan_ralan_bayi` (
  `no_rawat` varchar(17) NOT NULL,
  `tanggal` datetime NOT NULL,
  `informasi` enum('Autoanamnesis','Alloanamnesis') NOT NULL,
  `td` varchar(8) NOT NULL DEFAULT '',
  `nadi` varchar(5) NOT NULL DEFAULT '',
  `rr` varchar(5) NOT NULL,
  `suhu` varchar(5) NOT NULL DEFAULT '',
  `gcs` varchar(5) NOT NULL,
  `bb` varchar(5) NOT NULL DEFAULT '',
  `tb` varchar(5) NOT NULL DEFAULT '',
  `lp` varchar(5) NOT NULL DEFAULT '',
  `lk` varchar(5) NOT NULL DEFAULT '',
  `ld` varchar(5) NOT NULL DEFAULT '',
  `keluhan_utama` varchar(150) NOT NULL DEFAULT '',
  `rpd` varchar(100) NOT NULL DEFAULT '',
  `rpk` varchar(100) NOT NULL,
  `rpo` varchar(100) NOT NULL,
  `alergi` varchar(25) NOT NULL DEFAULT '',
  `anakke` tinyint(4) NOT NULL,
  `darisaudara` tinyint(4) NOT NULL,
  `caralahir` enum('Spontan','Sectio Caesaria','Lain-Lain') NOT NULL,
  `ket_caralahir` varchar(30) NOT NULL,
  `umurkelahiran` enum('Cukup Bulan','Kurang Bulan') NOT NULL,
  `kelainanbawaan` enum('Tidak Ada','Ada') NOT NULL,
  `ket_kelainan_bawaan` varchar(30) NOT NULL,
  `usiatengkurap` varchar(15) NOT NULL,
  `usiaduduk` varchar(15) NOT NULL,
  `usiaberdiri` varchar(15) NOT NULL,
  `usiagigipertama` varchar(15) NOT NULL,
  `usiaberjalan` varchar(15) NOT NULL,
  `usiabicara` varchar(15) NOT NULL,
  `usiamembaca` varchar(15) NOT NULL,
  `usiamenulis` varchar(15) NOT NULL,
  `gangguanemosi` varchar(50) NOT NULL,
  `alat_bantu` enum('Tidak','Ya') NOT NULL,
  `ket_bantu` varchar(50) NOT NULL DEFAULT '',
  `prothesa` enum('Tidak','Ya') NOT NULL,
  `ket_pro` varchar(50) NOT NULL,
  `adl` enum('Mandiri','Dibantu') NOT NULL,
  `status_psiko` enum('Tenang','Takut','Cemas','Depresi','Lain-lain') NOT NULL,
  `ket_psiko` varchar(70) NOT NULL,
  `hub_keluarga` enum('Baik','Tidak Baik') NOT NULL,
  `pengasuh` enum('Orang Tua','Kakek/Nenek','Keluarga Lainnya') NOT NULL,
  `ket_pengasuh` varchar(40) NOT NULL,
  `ekonomi` enum('Baik','Cukup','Kurang') NOT NULL,
  `budaya` enum('Tidak Ada','Ada') NOT NULL,
  `ket_budaya` varchar(50) NOT NULL,
  `edukasi` enum('Orang Tua','Keluarga') NOT NULL,
  `ket_edukasi` varchar(50) NOT NULL,
  `berjalan_a` enum('Ya','Tidak') NOT NULL,
  `berjalan_b` enum('Ya','Tidak') NOT NULL,
  `berjalan_c` enum('Ya','Tidak') NOT NULL,
  `hasil` enum('Tidak beresiko (tidak ditemukan a dan b)','Resiko rendah (ditemukan a/b)','Resiko tinggi (ditemukan a dan b)') NOT NULL,
  `lapor` enum('Ya','Tidak') NOT NULL,
  `ket_lapor` varchar(15) NOT NULL,
  `sg1` enum('Tidak','Ya') NOT NULL,
  `nilai1` enum('0','1') NOT NULL,
  `sg2` enum('Tidak','Ya') NOT NULL,
  `nilai2` enum('0','1') NOT NULL,
  `sg3` enum('Tidak','Ya') NOT NULL,
  `nilai3` enum('0','1') NOT NULL,
  `sg4` enum('Tidak','Ya') NOT NULL,
  `nilai4` enum('0','1') NOT NULL,
  `total_hasil` tinyint(4) NOT NULL,
  `wajah` enum('Tersenyum/tidak ada ekspresi khusus','Terkadang meringis/menarik diri','Sering menggetarkan dagu dan mengatupkan rahang') NOT NULL,
  `nilaiwajah` enum('0','1','2') NOT NULL,
  `kaki` enum('Gerakan normal/relaksasi','Tidak tenang/tegang','Kaki dibuat menendang/menarik') NOT NULL,
  `nilaikaki` enum('0','1','2') NOT NULL,
  `aktifitas` enum('Tidur posisi normal, mudah bergerak','Gerakan menggeliat/berguling, kaku','Melengkungkan punggung/kaku menghentak') NOT NULL,
  `nilaiaktifitas` enum('0','1','2') NOT NULL,
  `menangis` enum('Tidak menangis (mudah bergerak)','Mengerang/merengek','Menangis terus menerus, terisak, menjerit') NOT NULL,
  `nilaimenangis` enum('0','1','2') NOT NULL,
  `bersuara` enum('Bersuara normal/tenang','Tenang bila dipeluk, digendong/diajak bicara','Sulit untuk menenangkan') NOT NULL,
  `nilaibersuara` enum('0','1','2') NOT NULL,
  `hasilnyeri` tinyint(4) NOT NULL,
  `nyeri` enum('Tidak Ada Nyeri','Nyeri Akut','Nyeri Kronis') NOT NULL,
  `lokasi` varchar(50) NOT NULL,
  `skala_nyeri` enum('0','1','2','3','4','5','6','7','8','9','10') NOT NULL,
  `durasi` varchar(25) NOT NULL,
  `frekuensi` varchar(25) NOT NULL,
  `nyeri_hilang` enum('Istirahat','Medengar Musik','Minum Obat') NOT NULL,
  `ket_nyeri` varchar(40) NOT NULL,
  `pada_dokter` enum('Tidak','Ya') NOT NULL,
  `ket_dokter` varchar(15) NOT NULL,
  `rencana` varchar(200) NOT NULL,
  `nip` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `nip` (`nip`),
  CONSTRAINT `penilaian_awal_keperawatan_ralan_bayi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_bayi_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penilaian_awal_keperawatan_ralan_masalah` */

DROP TABLE IF EXISTS `penilaian_awal_keperawatan_ralan_masalah`;

CREATE TABLE `penilaian_awal_keperawatan_ralan_masalah` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_masalah` varchar(3) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_masalah`),
  KEY `kode_masalah` (`kode_masalah`),
  CONSTRAINT `penilaian_awal_keperawatan_ralan_masalah_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penilaian_awal_keperawatan_ralan_masalah_ibfk_2` FOREIGN KEY (`kode_masalah`) REFERENCES `master_masalah_keperawatan` (`kode_masalah`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penjab` */

DROP TABLE IF EXISTS `penjab`;

CREATE TABLE `penjab` (
  `kd_pj` char(3) NOT NULL,
  `png_jawab` varchar(30) NOT NULL,
  `nama_perusahaan` varchar(60) NOT NULL,
  `alamat_asuransi` varchar(130) NOT NULL,
  `no_telp` varchar(40) NOT NULL,
  `attn` varchar(60) NOT NULL,
  PRIMARY KEY (`kd_pj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penjualan` */

DROP TABLE IF EXISTS `penjualan`;

CREATE TABLE `penjualan` (
  `nota_jual` varchar(20) NOT NULL,
  `tgl_jual` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `nm_pasien` varchar(50) DEFAULT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  `jns_jual` enum('Jual Bebas','Karyawan','Beli Luar','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Utama/BPJS','VIP','VVIP') DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `status` enum('Belum Dibayar','Sudah Dibayar') DEFAULT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`nota_jual`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `penjualan_ibfk_12` (`kd_rek`),
  KEY `nama_bayar` (`nama_bayar`),
  CONSTRAINT `penjualan_ibfk_10` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_11` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_12` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_13` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON UPDATE CASCADE,
  CONSTRAINT `penjualan_ibfk_9` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penyakit` */

DROP TABLE IF EXISTS `penyakit`;

CREATE TABLE `penyakit` (
  `kd_penyakit` varchar(10) NOT NULL,
  `nm_penyakit` varchar(100) DEFAULT NULL,
  `ciri_ciri` text DEFAULT NULL,
  `keterangan` varchar(60) DEFAULT NULL,
  `kd_ktg` varchar(8) DEFAULT NULL,
  `status` enum('Menular','Tidak Menular') NOT NULL,
  PRIMARY KEY (`kd_penyakit`),
  KEY `kd_ktg` (`kd_ktg`),
  KEY `nm_penyakit` (`nm_penyakit`),
  KEY `status` (`status`),
  CONSTRAINT `penyakit_ibfk_1` FOREIGN KEY (`kd_ktg`) REFERENCES `kategori_penyakit` (`kd_ktg`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `penyakit_pd3i` */

DROP TABLE IF EXISTS `penyakit_pd3i`;

CREATE TABLE `penyakit_pd3i` (
  `kd_penyakit` varchar(10) NOT NULL,
  PRIMARY KEY (`kd_penyakit`),
  CONSTRAINT `penyakit_pd3i_ibfk_1` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perawatan_corona` */

DROP TABLE IF EXISTS `perawatan_corona`;

CREATE TABLE `perawatan_corona` (
  `no_rawat` varchar(17) NOT NULL,
  `pemulasaraan_jenazah` enum('Tidak','Ya') DEFAULT NULL,
  `kantong_jenazah` enum('Tidak','Ya') DEFAULT NULL,
  `peti_jenazah` enum('Tidak','Ya') DEFAULT NULL,
  `plastik_erat` enum('Tidak','Ya') DEFAULT NULL,
  `desinfektan_jenazah` enum('Tidak','Ya') DEFAULT NULL,
  `mobil_jenazah` enum('Tidak','Ya') DEFAULT NULL,
  `desinfektan_mobil_jenazah` enum('Tidak','Ya') DEFAULT NULL,
  `covid19_status_cd` enum('ODP','PDP','Positif') DEFAULT NULL,
  `nomor_kartu_t` varchar(30) DEFAULT NULL,
  `episodes1` int(11) DEFAULT NULL,
  `episodes2` int(11) DEFAULT NULL,
  `episodes3` int(11) DEFAULT NULL,
  `episodes4` int(11) DEFAULT NULL,
  `episodes5` int(11) DEFAULT NULL,
  `episodes6` int(11) DEFAULT NULL,
  `covid19_cc_ind` enum('Tidak','Ya') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `perawatan_corona_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perbaikan_inventaris` */

DROP TABLE IF EXISTS `perbaikan_inventaris`;

CREATE TABLE `perbaikan_inventaris` (
  `no_permintaan` varchar(15) NOT NULL,
  `tanggal` date NOT NULL,
  `uraian_kegiatan` varchar(255) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `pelaksana` enum('Teknisi Rumah Sakit','Teknisi Rujukan','Pihak ke III') NOT NULL,
  `biaya` double NOT NULL,
  `keterangan` varchar(255) NOT NULL,
  `status` enum('Bisa Diperbaiki','Tidak Bisa Diperbaiki') NOT NULL,
  PRIMARY KEY (`no_permintaan`),
  KEY `nip` (`nip`),
  CONSTRAINT `perbaikan_inventaris_ibfk_1` FOREIGN KEY (`no_permintaan`) REFERENCES `permintaan_perbaikan_inventaris` (`no_permintaan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `perbaikan_inventaris_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `periksa_lab` */

DROP TABLE IF EXISTS `periksa_lab`;

CREATE TABLE `periksa_lab` (
  `no_rawat` varchar(17) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `status` enum('Ralan','Ranap') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`tgl_periksa`,`jam`),
  KEY `nip` (`nip`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  CONSTRAINT `periksa_lab_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_11` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_12` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_13` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_lab_ibfk_9` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `periksa_radiologi` */

DROP TABLE IF EXISTS `periksa_radiologi`;

CREATE TABLE `periksa_radiologi` (
  `no_rawat` varchar(17) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `dokter_perujuk` varchar(20) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_perujuk` double NOT NULL,
  `tarif_tindakan_dokter` double NOT NULL,
  `tarif_tindakan_petugas` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya` double NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `status` enum('Ranap','Ralan') DEFAULT NULL,
  `proyeksi` varchar(50) NOT NULL,
  `kV` varchar(10) NOT NULL,
  `mAS` varchar(10) NOT NULL,
  `FFD` varchar(10) NOT NULL,
  `BSF` varchar(10) NOT NULL,
  `inak` varchar(10) NOT NULL,
  `jml_penyinaran` varchar(10) NOT NULL,
  `dosis` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`tgl_periksa`,`jam`),
  KEY `nip` (`nip`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  CONSTRAINT `periksa_radiologi_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_5` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_7` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `periksa_radiologi_ibfk_8` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perkiraan_biaya_ranap` */

DROP TABLE IF EXISTS `perkiraan_biaya_ranap`;

CREATE TABLE `perkiraan_biaya_ranap` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_penyakit` varchar(10) NOT NULL,
  `tarif` double NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `kd_penyakit` (`kd_penyakit`),
  CONSTRAINT `perkiraan_biaya_ranap_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `perkiraan_biaya_ranap_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_detail_permintaan_lab` */

DROP TABLE IF EXISTS `permintaan_detail_permintaan_lab`;

CREATE TABLE `permintaan_detail_permintaan_lab` (
  `noorder` varchar(15) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `id_template` int(11) NOT NULL,
  `stts_bayar` enum('Sudah','Belum') DEFAULT NULL,
  PRIMARY KEY (`noorder`,`kd_jenis_prw`,`id_template`),
  KEY `id_template` (`id_template`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_3` FOREIGN KEY (`id_template`) REFERENCES `template_laboratorium` (`id_template`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_detail_permintaan_lab_ibfk_4` FOREIGN KEY (`noorder`) REFERENCES `permintaan_lab` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_lab` */

DROP TABLE IF EXISTS `permintaan_lab`;

CREATE TABLE `permintaan_lab` (
  `noorder` varchar(15) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `jam_permintaan` time NOT NULL,
  `tgl_sampel` date NOT NULL,
  `jam_sampel` time NOT NULL,
  `tgl_hasil` date NOT NULL,
  `jam_hasil` time NOT NULL,
  `dokter_perujuk` varchar(20) NOT NULL,
  `status` enum('ralan','ranap') NOT NULL,
  `informasi_tambahan` varchar(60) NOT NULL,
  `diagnosa_klinis` varchar(80) NOT NULL,
  PRIMARY KEY (`noorder`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `permintaan_lab_ibfk_2` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_lab_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_medis` */

DROP TABLE IF EXISTS `permintaan_medis`;

CREATE TABLE `permintaan_medis` (
  `no_permintaan` varchar(20) NOT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('Baru','Disetujui','Tidak Disetujui') DEFAULT NULL,
  `kd_bangsaltujuan` char(5) NOT NULL,
  PRIMARY KEY (`no_permintaan`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `permintaan_medis_ibfk_2` (`nip`),
  KEY `kd_bangsaltujuan` (`kd_bangsaltujuan`),
  CONSTRAINT `permintaan_medis_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_medis_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_medis_ibfk_3` FOREIGN KEY (`kd_bangsaltujuan`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_non_medis` */

DROP TABLE IF EXISTS `permintaan_non_medis`;

CREATE TABLE `permintaan_non_medis` (
  `no_permintaan` varchar(20) NOT NULL,
  `ruang` varchar(50) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('Baru','Disetujui','Tidak Disetujui') DEFAULT NULL,
  PRIMARY KEY (`no_permintaan`),
  KEY `nip` (`nip`),
  CONSTRAINT `permintaan_non_medis_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_obat` */

DROP TABLE IF EXISTS `permintaan_obat`;

CREATE TABLE `permintaan_obat` (
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  PRIMARY KEY (`tanggal`,`jam`,`no_rawat`,`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `permintaan_obat_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_obat_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_pemeriksaan_lab` */

DROP TABLE IF EXISTS `permintaan_pemeriksaan_lab`;

CREATE TABLE `permintaan_pemeriksaan_lab` (
  `noorder` varchar(15) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `stts_bayar` enum('Sudah','Belum') DEFAULT NULL,
  PRIMARY KEY (`noorder`,`kd_jenis_prw`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `permintaan_pemeriksaan_lab_ibfk_1` FOREIGN KEY (`noorder`) REFERENCES `permintaan_lab` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_pemeriksaan_lab_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_pemeriksaan_radiologi` */

DROP TABLE IF EXISTS `permintaan_pemeriksaan_radiologi`;

CREATE TABLE `permintaan_pemeriksaan_radiologi` (
  `noorder` varchar(15) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `stts_bayar` enum('Sudah','Belum') DEFAULT NULL,
  PRIMARY KEY (`noorder`,`kd_jenis_prw`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `permintaan_pemeriksaan_radiologi_ibfk_1` FOREIGN KEY (`noorder`) REFERENCES `permintaan_radiologi` (`noorder`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_pemeriksaan_radiologi_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_radiologi` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_perbaikan_inventaris` */

DROP TABLE IF EXISTS `permintaan_perbaikan_inventaris`;

CREATE TABLE `permintaan_perbaikan_inventaris` (
  `no_permintaan` varchar(15) NOT NULL,
  `no_inventaris` varchar(30) DEFAULT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `tanggal` datetime DEFAULT NULL,
  `deskripsi_kerusakan` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`no_permintaan`),
  KEY `no_inventaris` (`no_inventaris`),
  KEY `nik` (`nik`),
  CONSTRAINT `permintaan_perbaikan_inventaris_ibfk_1` FOREIGN KEY (`no_inventaris`) REFERENCES `inventaris` (`no_inventaris`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_perbaikan_inventaris_ibfk_2` FOREIGN KEY (`nik`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_radiologi` */

DROP TABLE IF EXISTS `permintaan_radiologi`;

CREATE TABLE `permintaan_radiologi` (
  `noorder` varchar(15) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_permintaan` date NOT NULL,
  `jam_permintaan` time NOT NULL,
  `tgl_sampel` date NOT NULL,
  `jam_sampel` time NOT NULL,
  `tgl_hasil` date NOT NULL,
  `jam_hasil` time NOT NULL,
  `dokter_perujuk` varchar(20) NOT NULL,
  `status` enum('ralan','ranap') NOT NULL,
  `informasi_tambahan` varchar(60) NOT NULL,
  `diagnosa_klinis` varchar(80) NOT NULL,
  PRIMARY KEY (`noorder`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `permintaan_radiologi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `permintaan_radiologi_ibfk_3` FOREIGN KEY (`dokter_perujuk`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `permintaan_registrasi` */

DROP TABLE IF EXISTS `permintaan_registrasi`;

CREATE TABLE `permintaan_registrasi` (
  `no_rawat` varchar(17) NOT NULL,
  `biaya` double NOT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `permintaan_registrasi_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_anggota` */

DROP TABLE IF EXISTS `perpustakaan_anggota`;

CREATE TABLE `perpustakaan_anggota` (
  `no_anggota` varchar(10) NOT NULL,
  `nama_anggota` varchar(40) DEFAULT NULL,
  `tmp_lahir` varchar(20) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `j_kel` enum('L','P') DEFAULT NULL,
  `alamat` varchar(70) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `tgl_gabung` date DEFAULT NULL,
  `masa_berlaku` date DEFAULT NULL,
  `jenis_anggota` enum('Pasien','Pegawai','Umum') NOT NULL,
  `nomer_id` varchar(20) NOT NULL,
  PRIMARY KEY (`no_anggota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_bayar_denda` */

DROP TABLE IF EXISTS `perpustakaan_bayar_denda`;

CREATE TABLE `perpustakaan_bayar_denda` (
  `tgl_denda` date NOT NULL DEFAULT '0000-00-00',
  `no_anggota` varchar(10) NOT NULL DEFAULT '',
  `no_inventaris` varchar(20) NOT NULL DEFAULT '',
  `kode_denda` char(5) NOT NULL DEFAULT '',
  `besar_denda` double DEFAULT NULL,
  `keterangan_denda` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`tgl_denda`,`no_anggota`,`no_inventaris`,`kode_denda`),
  KEY `kode_denda` (`kode_denda`),
  KEY `no_anggota` (`no_anggota`),
  KEY `no_inventaris` (`no_inventaris`),
  CONSTRAINT `perpustakaan_bayar_denda_ibfk_1` FOREIGN KEY (`no_anggota`) REFERENCES `perpustakaan_anggota` (`no_anggota`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_bayar_denda_ibfk_2` FOREIGN KEY (`no_inventaris`) REFERENCES `perpustakaan_inventaris` (`no_inventaris`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_bayar_denda_ibfk_3` FOREIGN KEY (`kode_denda`) REFERENCES `perpustakaan_denda` (`kode_denda`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_bayar_denda_harian` */

DROP TABLE IF EXISTS `perpustakaan_bayar_denda_harian`;

CREATE TABLE `perpustakaan_bayar_denda_harian` (
  `tgl_denda` date NOT NULL DEFAULT '0000-00-00',
  `no_anggota` varchar(10) NOT NULL DEFAULT '',
  `no_inventaris` varchar(20) NOT NULL DEFAULT '',
  `keterlambatan` int(4) DEFAULT NULL,
  `besar_denda` double DEFAULT NULL,
  PRIMARY KEY (`tgl_denda`,`no_anggota`,`no_inventaris`),
  KEY `no_anggota` (`no_anggota`),
  KEY `no_inventaris` (`no_inventaris`),
  CONSTRAINT `perpustakaan_bayar_denda_harian_ibfk_1` FOREIGN KEY (`no_anggota`) REFERENCES `perpustakaan_anggota` (`no_anggota`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_bayar_denda_harian_ibfk_2` FOREIGN KEY (`no_inventaris`) REFERENCES `perpustakaan_inventaris` (`no_inventaris`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_buku` */

DROP TABLE IF EXISTS `perpustakaan_buku`;

CREATE TABLE `perpustakaan_buku` (
  `kode_buku` varchar(10) NOT NULL DEFAULT '',
  `judul_buku` varchar(200) DEFAULT NULL,
  `jml_halaman` char(5) DEFAULT NULL,
  `kode_penerbit` varchar(10) DEFAULT NULL,
  `kode_pengarang` varchar(7) DEFAULT NULL,
  `thn_terbit` year(4) DEFAULT NULL,
  `isbn` varchar(20) DEFAULT NULL,
  `id_kategori` char(5) DEFAULT NULL,
  `id_jenis` char(5) DEFAULT NULL,
  PRIMARY KEY (`kode_buku`),
  KEY `kode_penerbit` (`kode_penerbit`),
  KEY `kode_pengarang` (`kode_pengarang`),
  KEY `id_kategori` (`id_kategori`),
  KEY `id_jenis` (`id_jenis`),
  CONSTRAINT `perpustakaan_buku_ibfk_1` FOREIGN KEY (`kode_penerbit`) REFERENCES `perpustakaan_penerbit` (`kode_penerbit`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_buku_ibfk_2` FOREIGN KEY (`kode_pengarang`) REFERENCES `perpustakaan_pengarang` (`kode_pengarang`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_buku_ibfk_3` FOREIGN KEY (`id_kategori`) REFERENCES `perpustakaan_kategori` (`id_kategori`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_buku_ibfk_4` FOREIGN KEY (`id_jenis`) REFERENCES `perpustakaan_jenis_buku` (`id_jenis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_denda` */

DROP TABLE IF EXISTS `perpustakaan_denda`;

CREATE TABLE `perpustakaan_denda` (
  `kode_denda` char(5) NOT NULL,
  `jenis_denda` varchar(40) DEFAULT NULL,
  `besar_denda` double DEFAULT NULL,
  PRIMARY KEY (`kode_denda`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_ebook` */

DROP TABLE IF EXISTS `perpustakaan_ebook`;

CREATE TABLE `perpustakaan_ebook` (
  `kode_ebook` varchar(10) NOT NULL DEFAULT '',
  `judul_ebook` varchar(200) DEFAULT NULL,
  `jml_halaman` char(5) DEFAULT NULL,
  `kode_penerbit` varchar(10) DEFAULT NULL,
  `kode_pengarang` varchar(7) DEFAULT NULL,
  `thn_terbit` year(4) DEFAULT NULL,
  `id_kategori` char(5) DEFAULT NULL,
  `id_jenis` char(5) DEFAULT NULL,
  `berkas` varchar(1000) NOT NULL,
  PRIMARY KEY (`kode_ebook`),
  KEY `kode_penerbit` (`kode_penerbit`),
  KEY `kode_pengarang` (`kode_pengarang`),
  KEY `id_kategori` (`id_kategori`),
  KEY `id_jenis` (`id_jenis`),
  CONSTRAINT `perpustakaan_ebook_ibfk_1` FOREIGN KEY (`kode_penerbit`) REFERENCES `perpustakaan_penerbit` (`kode_penerbit`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_ebook_ibfk_2` FOREIGN KEY (`kode_pengarang`) REFERENCES `perpustakaan_pengarang` (`kode_pengarang`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_ebook_ibfk_3` FOREIGN KEY (`id_kategori`) REFERENCES `perpustakaan_kategori` (`id_kategori`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_ebook_ibfk_4` FOREIGN KEY (`id_jenis`) REFERENCES `perpustakaan_jenis_buku` (`id_jenis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_inventaris` */

DROP TABLE IF EXISTS `perpustakaan_inventaris`;

CREATE TABLE `perpustakaan_inventaris` (
  `no_inventaris` varchar(20) NOT NULL DEFAULT '',
  `kode_buku` varchar(10) DEFAULT NULL,
  `asal_buku` enum('Beli','Bantuan','Hibah','-') DEFAULT NULL,
  `tgl_pengadaan` date DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `status_buku` enum('Ada','Rusak','Hilang','Dipinjam','-') DEFAULT NULL,
  `kd_ruang` char(5) DEFAULT NULL,
  `no_rak` char(3) DEFAULT NULL,
  `no_box` char(3) DEFAULT NULL,
  PRIMARY KEY (`no_inventaris`),
  KEY `kode_buku` (`kode_buku`),
  KEY `kd_ruang` (`kd_ruang`),
  CONSTRAINT `perpustakaan_inventaris_ibfk_1` FOREIGN KEY (`kode_buku`) REFERENCES `perpustakaan_buku` (`kode_buku`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_inventaris_ibfk_2` FOREIGN KEY (`kd_ruang`) REFERENCES `perpustakaan_ruang` (`kd_ruang`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_jenis_buku` */

DROP TABLE IF EXISTS `perpustakaan_jenis_buku`;

CREATE TABLE `perpustakaan_jenis_buku` (
  `id_jenis` char(5) NOT NULL,
  `nama_jenis` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_kategori` */

DROP TABLE IF EXISTS `perpustakaan_kategori`;

CREATE TABLE `perpustakaan_kategori` (
  `id_kategori` char(5) NOT NULL,
  `nama_kategori` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`id_kategori`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_peminjaman` */

DROP TABLE IF EXISTS `perpustakaan_peminjaman`;

CREATE TABLE `perpustakaan_peminjaman` (
  `no_anggota` varchar(10) DEFAULT NULL,
  `no_inventaris` varchar(20) DEFAULT NULL,
  `tgl_pinjam` date DEFAULT NULL,
  `tgl_kembali` date DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `status_pinjam` enum('Masih Dipinjam','Sudah Kembali') DEFAULT NULL,
  KEY `no_anggota` (`no_anggota`),
  KEY `no_inventaris` (`no_inventaris`),
  KEY `nip` (`nip`),
  CONSTRAINT `perpustakaan_peminjaman_ibfk_1` FOREIGN KEY (`no_anggota`) REFERENCES `perpustakaan_anggota` (`no_anggota`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_peminjaman_ibfk_2` FOREIGN KEY (`no_inventaris`) REFERENCES `perpustakaan_inventaris` (`no_inventaris`) ON UPDATE CASCADE,
  CONSTRAINT `perpustakaan_peminjaman_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_penerbit` */

DROP TABLE IF EXISTS `perpustakaan_penerbit`;

CREATE TABLE `perpustakaan_penerbit` (
  `kode_penerbit` varchar(10) NOT NULL,
  `nama_penerbit` varchar(40) DEFAULT NULL,
  `alamat_penerbit` varchar(70) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `email` varchar(25) DEFAULT NULL,
  `website_penerbit` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kode_penerbit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_pengarang` */

DROP TABLE IF EXISTS `perpustakaan_pengarang`;

CREATE TABLE `perpustakaan_pengarang` (
  `kode_pengarang` varchar(7) NOT NULL,
  `nama_pengarang` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode_pengarang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_ruang` */

DROP TABLE IF EXISTS `perpustakaan_ruang`;

CREATE TABLE `perpustakaan_ruang` (
  `kd_ruang` char(5) NOT NULL DEFAULT '',
  `nm_ruang` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kd_ruang`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `perpustakaan_set_peminjaman` */

DROP TABLE IF EXISTS `perpustakaan_set_peminjaman`;

CREATE TABLE `perpustakaan_set_peminjaman` (
  `max_pinjam` int(11) DEFAULT NULL,
  `lama_pinjam` int(11) DEFAULT NULL,
  `denda_perhari` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `personal_pasien` */

DROP TABLE IF EXISTS `personal_pasien`;

CREATE TABLE `personal_pasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `gambar` varchar(1000) DEFAULT NULL,
  `password` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `personal_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `persur` */

DROP TABLE IF EXISTS `persur`;

CREATE TABLE `persur` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `kd_survei` char(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_survei` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `persur_kd_survei_unique` (`kd_survei`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `perusahaan_pasien` */

DROP TABLE IF EXISTS `perusahaan_pasien`;

CREATE TABLE `perusahaan_pasien` (
  `kode_perusahaan` varchar(8) NOT NULL,
  `nama_perusahaan` varchar(70) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `kota` varchar(40) DEFAULT NULL,
  `no_telp` varchar(27) DEFAULT NULL,
  PRIMARY KEY (`kode_perusahaan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `petugas` */

DROP TABLE IF EXISTS `petugas`;

CREATE TABLE `petugas` (
  `nip` varchar(20) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(20) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `gol_darah` enum('A','B','O','AB','-') DEFAULT NULL,
  `agama` varchar(12) DEFAULT NULL,
  `stts_nikah` enum('BELUM MENIKAH','MENIKAH','JANDA','DUDHA','JOMBLO') DEFAULT NULL,
  `alamat` varchar(60) DEFAULT NULL,
  `kd_jbtn` char(4) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `status` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`nip`),
  KEY `kd_jbtn` (`kd_jbtn`),
  KEY `nama` (`nama`),
  KEY `nip` (`nip`),
  KEY `tmp_lahir` (`tmp_lahir`),
  KEY `tgl_lahir` (`tgl_lahir`),
  KEY `agama` (`agama`),
  KEY `stts_nikah` (`stts_nikah`),
  KEY `alamat` (`alamat`),
  CONSTRAINT `petugas_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON UPDATE CASCADE,
  CONSTRAINT `petugas_ibfk_5` FOREIGN KEY (`kd_jbtn`) REFERENCES `jabatan` (`kd_jbtn`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `piutang` */

DROP TABLE IF EXISTS `piutang`;

CREATE TABLE `piutang` (
  `nota_piutang` varchar(20) NOT NULL,
  `tgl_piutang` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `nm_pasien` varchar(50) DEFAULT NULL,
  `catatan` varchar(40) DEFAULT NULL,
  `jns_jual` enum('Jual Bebas','Karyawan','Beli Luar','Rawat Jalan','Kelas 1','Kelas 2','Kelas 3','Utama','VIP','VVIP') DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `uangmuka` double DEFAULT NULL,
  `sisapiutang` double NOT NULL,
  `status` enum('UMUM','PAJAK') DEFAULT NULL,
  `tgltempo` date NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`nota_piutang`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `piutang_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `piutang_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `piutang_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `piutang_pasien` */

DROP TABLE IF EXISTS `piutang_pasien`;

CREATE TABLE `piutang_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_piutang` date DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `status` enum('Lunas','Belum Lunas') NOT NULL,
  `totalpiutang` double DEFAULT NULL,
  `uangmuka` double DEFAULT NULL,
  `sisapiutang` double NOT NULL,
  `tgltempo` date NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `piutang_pasien_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `piutang_pasien_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pnm_tnj_bulanan` */

DROP TABLE IF EXISTS `pnm_tnj_bulanan`;

CREATE TABLE `pnm_tnj_bulanan` (
  `id` int(11) NOT NULL,
  `id_tnj` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_tnj`),
  KEY `id_tnj` (`id_tnj`),
  CONSTRAINT `pnm_tnj_bulanan_ibfk_5` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pnm_tnj_bulanan_ibfk_6` FOREIGN KEY (`id_tnj`) REFERENCES `master_tunjangan_bulanan` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `pnm_tnj_harian` */

DROP TABLE IF EXISTS `pnm_tnj_harian`;

CREATE TABLE `pnm_tnj_harian` (
  `id` int(11) NOT NULL,
  `id_tnj` int(11) NOT NULL,
  PRIMARY KEY (`id`,`id_tnj`),
  KEY `id_tnj` (`id_tnj`),
  CONSTRAINT `pnm_tnj_harian_ibfk_5` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `pnm_tnj_harian_ibfk_6` FOREIGN KEY (`id_tnj`) REFERENCES `master_tunjangan_harian` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `poliklinik` */

DROP TABLE IF EXISTS `poliklinik`;

CREATE TABLE `poliklinik` (
  `kd_poli` char(5) NOT NULL DEFAULT '',
  `nm_poli` varchar(50) DEFAULT NULL,
  `registrasi` double NOT NULL,
  `registrasilama` double NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kd_poli`),
  KEY `nm_poli` (`nm_poli`),
  KEY `registrasi` (`registrasi`),
  KEY `registrasilama` (`registrasilama`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `posts` */

DROP TABLE IF EXISTS `posts`;

CREATE TABLE `posts` (
  `pid` int(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `desc` mediumtext NOT NULL,
  `image_url` varchar(100) NOT NULL,
  `vid_url` varchar(100) NOT NULL,
  `date` varchar(20) NOT NULL,
  PRIMARY KEY (`pid`),
  KEY `pid` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `potongan` */

DROP TABLE IF EXISTS `potongan`;

CREATE TABLE `potongan` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `id` int(11) NOT NULL,
  `bpjs` double NOT NULL,
  `jamsostek` double NOT NULL,
  `dansos` double NOT NULL,
  `simwajib` double NOT NULL,
  `angkop` double NOT NULL,
  `angla` double NOT NULL,
  `telpri` double NOT NULL,
  `pajak` double NOT NULL,
  `pribadi` double NOT NULL,
  `lain` double NOT NULL,
  `ktg` varchar(50) NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `potongan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `presensi` */

DROP TABLE IF EXISTS `presensi`;

CREATE TABLE `presensi` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jns` enum('HR','HB') NOT NULL,
  `lembur` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `propinsi` */

DROP TABLE IF EXISTS `propinsi`;

CREATE TABLE `propinsi` (
  `kd_prop` int(11) NOT NULL AUTO_INCREMENT,
  `nm_prop` varchar(30) NOT NULL,
  PRIMARY KEY (`kd_prop`),
  UNIQUE KEY `nm_prop` (`nm_prop`)
) ENGINE=InnoDB AUTO_INCREMENT=1563 DEFAULT CHARSET=latin1;

/*Table structure for table `prosedur_pasien` */

DROP TABLE IF EXISTS `prosedur_pasien`;

CREATE TABLE `prosedur_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `kode` varchar(8) NOT NULL,
  `status` enum('Ralan','Ranap') NOT NULL,
  `prioritas` tinyint(4) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode`,`status`),
  KEY `kode` (`kode`),
  CONSTRAINT `prosedur_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `prosedur_pasien_ibfk_2` FOREIGN KEY (`kode`) REFERENCES `icd9` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ranap_gabung` */

DROP TABLE IF EXISTS `ranap_gabung`;

CREATE TABLE `ranap_gabung` (
  `no_rawat` varchar(17) NOT NULL,
  `no_rawat2` varchar(17) NOT NULL,
  PRIMARY KEY (`no_rawat`,`no_rawat2`),
  KEY `no_rawat2` (`no_rawat2`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `ranap_gabung_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `ranap_gabung_ibfk_2` FOREIGN KEY (`no_rawat2`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawat_inap_dr` */

DROP TABLE IF EXISTS `rawat_inap_dr`;

CREATE TABLE `rawat_inap_dr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `tgl_perawatan` (`tgl_perawatan`),
  KEY `biaya_rawat` (`biaya_rawat`),
  KEY `jam_rawat` (`jam_rawat`),
  CONSTRAINT `rawat_inap_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_dr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawat_inap_drpr` */

DROP TABLE IF EXISTS `rawat_inap_drpr`;

CREATE TABLE `rawat_inap_drpr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`nip`,`tgl_perawatan`,`jam_rawat`),
  KEY `rawat_inap_drpr_ibfk_2` (`kd_jenis_prw`),
  KEY `rawat_inap_drpr_ibfk_3` (`kd_dokter`),
  KEY `rawat_inap_drpr_ibfk_4` (`nip`),
  CONSTRAINT `rawat_inap_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawat_inap_pr` */

DROP TABLE IF EXISTS `rawat_inap_pr`;

CREATE TABLE `rawat_inap_pr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL DEFAULT '0000-00-00',
  `jam_rawat` time NOT NULL DEFAULT '00:00:00',
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`nip`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `nip` (`nip`),
  KEY `biaya_rawat` (`biaya_rawat`),
  CONSTRAINT `rawat_inap_pr_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_6` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_inap` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_inap_pr_ibfk_7` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawat_jl_dr` */

DROP TABLE IF EXISTS `rawat_jl_dr`;

CREATE TABLE `rawat_jl_dr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `biaya_rawat` (`biaya_rawat`),
  CONSTRAINT `rawat_jl_dr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_dr_ibfk_5` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawat_jl_drpr` */

DROP TABLE IF EXISTS `rawat_jl_drpr`;

CREATE TABLE `rawat_jl_drpr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double DEFAULT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakandr` double DEFAULT NULL,
  `tarif_tindakanpr` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`kd_dokter`,`nip`,`tgl_perawatan`,`jam_rawat`),
  KEY `rawat_jl_drpr_ibfk_2` (`kd_jenis_prw`),
  KEY `rawat_jl_drpr_ibfk_3` (`kd_dokter`),
  KEY `rawat_jl_drpr_ibfk_4` (`nip`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `rawat_jl_drpr_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_3` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_drpr_ibfk_4` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawat_jl_pr` */

DROP TABLE IF EXISTS `rawat_jl_pr`;

CREATE TABLE `rawat_jl_pr` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_jenis_prw` varchar(15) NOT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tgl_perawatan` date NOT NULL,
  `jam_rawat` time NOT NULL,
  `material` double NOT NULL,
  `bhp` double NOT NULL,
  `tarif_tindakanpr` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_rawat` double DEFAULT NULL,
  `stts_bayar` enum('Sudah','Belum') DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_jenis_prw`,`nip`,`tgl_perawatan`,`jam_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `nip` (`nip`),
  KEY `biaya_rawat` (`biaya_rawat`),
  CONSTRAINT `rawat_jl_pr_ibfk_10` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_8` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `rawat_jl_pr_ibfk_9` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rawatjalan` */

DROP TABLE IF EXISTS `rawatjalan`;

CREATE TABLE `rawatjalan` (
  `tgl` datetime NOT NULL,
  `id` int(11) NOT NULL,
  `tnd` int(11) NOT NULL,
  `jm` double NOT NULL,
  `nm_pasien` varchar(30) NOT NULL,
  `kamar` varchar(20) NOT NULL,
  `diagnosa` varchar(50) NOT NULL,
  `jmlh` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`,`tnd`),
  KEY `id` (`id`),
  KEY `tnd` (`tnd`),
  CONSTRAINT `rawatjalan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `reg_periksa` */

DROP TABLE IF EXISTS `reg_periksa`;

CREATE TABLE `reg_periksa` (
  `no_reg` varchar(8) DEFAULT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tgl_registrasi` date DEFAULT NULL,
  `jam_reg` time DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `kd_poli` char(5) DEFAULT NULL,
  `p_jawab` varchar(100) DEFAULT NULL,
  `almt_pj` varchar(200) DEFAULT NULL,
  `hubunganpj` varchar(20) DEFAULT NULL,
  `biaya_reg` double DEFAULT NULL,
  `stts` enum('Belum','Sudah','Batal','Berkas Diterima','Dirujuk','Meninggal','Dirawat','Pulang Paksa') DEFAULT NULL,
  `stts_daftar` enum('-','Lama','Baru') NOT NULL,
  `status_lanjut` enum('Ralan','Ranap') NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `umurdaftar` int(11) DEFAULT NULL,
  `sttsumur` enum('Th','Bl','Hr') DEFAULT NULL,
  `status_bayar` enum('Sudah Bayar','Belum Bayar') NOT NULL,
  `status_poli` enum('Lama','Baru') NOT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_poli` (`kd_poli`),
  KEY `kd_pj` (`kd_pj`),
  KEY `status_lanjut` (`status_lanjut`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `status_bayar` (`status_bayar`),
  CONSTRAINT `reg_periksa_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_6` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `reg_periksa_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rekap_presensi` */

DROP TABLE IF EXISTS `rekap_presensi`;

CREATE TABLE `rekap_presensi` (
  `id` int(10) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_datang` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `jam_pulang` datetime DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') NOT NULL,
  `keterlambatan` varchar(20) NOT NULL,
  `durasi` varchar(20) DEFAULT NULL,
  `keterangan` varchar(100) NOT NULL,
  `photo` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`jam_datang`),
  KEY `id` (`id`),
  CONSTRAINT `rekap_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rekening` */

DROP TABLE IF EXISTS `rekening`;

CREATE TABLE `rekening` (
  `kd_rek` varchar(15) NOT NULL DEFAULT '',
  `nm_rek` varchar(100) DEFAULT NULL,
  `tipe` enum('N','M','R') DEFAULT NULL,
  `balance` enum('D','K') DEFAULT NULL,
  `level` enum('0','1') DEFAULT NULL,
  PRIMARY KEY (`kd_rek`),
  KEY `nm_rek` (`nm_rek`),
  KEY `tipe` (`tipe`),
  KEY `balance` (`balance`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rekeningtahun` */

DROP TABLE IF EXISTS `rekeningtahun`;

CREATE TABLE `rekeningtahun` (
  `thn` year(4) NOT NULL,
  `kd_rek` varchar(15) NOT NULL DEFAULT '',
  `saldo_awal` double NOT NULL,
  PRIMARY KEY (`thn`,`kd_rek`),
  KEY `kd_rek` (`kd_rek`),
  KEY `saldo_awal` (`saldo_awal`),
  CONSTRAINT `rekeningtahun_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `resep_dokter` */

DROP TABLE IF EXISTS `resep_dokter`;

CREATE TABLE `resep_dokter` (
  `no_resep` varchar(14) DEFAULT NULL,
  `kode_brng` varchar(15) DEFAULT NULL,
  `jml` double DEFAULT NULL,
  `aturan_pakai` varchar(150) DEFAULT NULL,
  KEY `no_resep` (`no_resep`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `resep_dokter_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `resep_dokter_racikan` */

DROP TABLE IF EXISTS `resep_dokter_racikan`;

CREATE TABLE `resep_dokter_racikan` (
  `no_resep` varchar(14) NOT NULL,
  `no_racik` varchar(2) NOT NULL,
  `nama_racik` varchar(100) NOT NULL,
  `kd_racik` varchar(3) NOT NULL,
  `jml_dr` int(11) NOT NULL,
  `aturan_pakai` varchar(150) NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  PRIMARY KEY (`no_resep`,`no_racik`),
  KEY `kd_racik` (`kd_racik`),
  CONSTRAINT `resep_dokter_racikan_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_racikan_ibfk_2` FOREIGN KEY (`kd_racik`) REFERENCES `metode_racik` (`kd_racik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `resep_dokter_racikan_detail` */

DROP TABLE IF EXISTS `resep_dokter_racikan_detail`;

CREATE TABLE `resep_dokter_racikan_detail` (
  `no_resep` varchar(14) NOT NULL,
  `no_racik` varchar(2) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `p1` double DEFAULT NULL,
  `p2` double DEFAULT NULL,
  `kandungan` varchar(10) DEFAULT NULL,
  `jml` double DEFAULT NULL,
  PRIMARY KEY (`no_resep`,`no_racik`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `resep_dokter_racikan_detail_ibfk_1` FOREIGN KEY (`no_resep`) REFERENCES `resep_obat` (`no_resep`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_dokter_racikan_detail_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `resep_obat` */

DROP TABLE IF EXISTS `resep_obat`;

CREATE TABLE `resep_obat` (
  `no_resep` varchar(14) NOT NULL DEFAULT '',
  `tgl_perawatan` date DEFAULT NULL,
  `jam` time NOT NULL,
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `kd_dokter` varchar(20) NOT NULL,
  `tgl_peresepan` date DEFAULT NULL,
  `jam_peresepan` time DEFAULT NULL,
  `status` enum('ralan','ranap') DEFAULT NULL,
  PRIMARY KEY (`no_resep`),
  UNIQUE KEY `tgl_perawatan` (`tgl_perawatan`,`jam`,`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `resep_obat_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `resep_obat_ibfk_4` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `resep_pulang` */

DROP TABLE IF EXISTS `resep_pulang`;

CREATE TABLE `resep_pulang` (
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `jml_barang` double NOT NULL,
  `harga` double NOT NULL,
  `total` double NOT NULL,
  `dosis` varchar(20) NOT NULL,
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `kd_bangsal` varchar(5) NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`no_rawat`,`kode_brng`,`tanggal`,`jam`,`no_batch`,`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `resep_pulang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `resep_pulang_ibfk_4` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `resiko_kerja` */

DROP TABLE IF EXISTS `resiko_kerja`;

CREATE TABLE `resiko_kerja` (
  `kode_resiko` varchar(3) NOT NULL,
  `nama_resiko` varchar(200) DEFAULT NULL,
  `indek` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`kode_resiko`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `resume_pasien` */

DROP TABLE IF EXISTS `resume_pasien`;

CREATE TABLE `resume_pasien` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `keluhan_utama` text NOT NULL,
  `jalannya_penyakit` text NOT NULL,
  `pemeriksaan_penunjang` text NOT NULL,
  `hasil_laborat` text NOT NULL,
  `diagnosa_utama` varchar(80) NOT NULL,
  `kd_diagnosa_utama` varchar(10) NOT NULL,
  `diagnosa_sekunder` varchar(80) NOT NULL,
  `kd_diagnosa_sekunder` varchar(10) NOT NULL,
  `diagnosa_sekunder2` varchar(80) NOT NULL,
  `kd_diagnosa_sekunder2` varchar(10) NOT NULL,
  `diagnosa_sekunder3` varchar(80) NOT NULL,
  `kd_diagnosa_sekunder3` varchar(10) NOT NULL,
  `diagnosa_sekunder4` varchar(80) NOT NULL,
  `kd_diagnosa_sekunder4` varchar(10) NOT NULL,
  `prosedur_utama` varchar(80) NOT NULL,
  `kd_prosedur_utama` varchar(8) NOT NULL,
  `prosedur_sekunder` varchar(80) NOT NULL,
  `kd_prosedur_sekunder` varchar(8) NOT NULL,
  `prosedur_sekunder2` varchar(80) NOT NULL,
  `kd_prosedur_sekunder2` varchar(8) NOT NULL,
  `prosedur_sekunder3` varchar(80) NOT NULL,
  `kd_prosedur_sekunder3` varchar(8) NOT NULL,
  `kondisi_pulang` enum('Hidup','Meninggal') NOT NULL,
  `obat_pulang` text NOT NULL,
  PRIMARY KEY (`no_rawat`) USING BTREE,
  KEY `kd_dokter` (`kd_dokter`) USING BTREE,
  CONSTRAINT `resume_pasien_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `resume_pasien_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

/*Table structure for table `retensi_pasien` */

DROP TABLE IF EXISTS `retensi_pasien`;

CREATE TABLE `retensi_pasien` (
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `terakhir_daftar` date DEFAULT NULL,
  `tgl_retensi` date DEFAULT NULL,
  `lokasi_pdf` varchar(500) DEFAULT NULL,
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `retensi_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `returbeli` */

DROP TABLE IF EXISTS `returbeli`;

CREATE TABLE `returbeli` (
  `no_retur_beli` varchar(20) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `kode_suplier` char(5) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_retur_beli`),
  KEY `nip` (`nip`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `returbeli_ibfk_2` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returbeli_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returbeli_ibfk_4` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `returjual` */

DROP TABLE IF EXISTS `returjual`;

CREATE TABLE `returjual` (
  `no_retur_jual` varchar(20) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_retur_jual`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `tgl_retur` (`tgl_retur`),
  CONSTRAINT `returjual_ibfk_6` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returjual_ibfk_7` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returjual_ibfk_8` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `returpasien` */

DROP TABLE IF EXISTS `returpasien`;

CREATE TABLE `returpasien` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `jml` double NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`,`kode_brng`,`no_batch`,`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `returpasien_ibfk_3` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `returpasien_ibfk_4` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `returpiutang` */

DROP TABLE IF EXISTS `returpiutang`;

CREATE TABLE `returpiutang` (
  `no_retur_piutang` varchar(20) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`no_retur_piutang`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `returpiutang_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `returpiutang_ibfk_4` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `returpiutang_ibfk_5` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_barang_medis` */

DROP TABLE IF EXISTS `riwayat_barang_medis`;

CREATE TABLE `riwayat_barang_medis` (
  `kode_brng` varchar(15) DEFAULT NULL,
  `stok_awal` double DEFAULT NULL,
  `masuk` double DEFAULT NULL,
  `keluar` double DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pemberian Obat','Pengadaan','Penerimaan','Piutang','Retur Beli','Retur Jual','Retur Piutang','Mutasi','Opname','Resep Pulang','Retur Pasien','Stok Pasien Ranap','Pengambilan Medis','Penjualan','Stok Keluar','Hibah') DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `petugas` varchar(20) DEFAULT NULL,
  `kd_bangsal` char(5) DEFAULT NULL,
  `status` enum('Simpan','Hapus') DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  KEY `riwayat_barang_medis_ibfk_1` (`kode_brng`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `riwayat_barang_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `riwayat_barang_medis_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_jabatan` */

DROP TABLE IF EXISTS `riwayat_jabatan`;

CREATE TABLE `riwayat_jabatan` (
  `id` int(11) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `tmt_pangkat` date NOT NULL,
  `tmt_pangkat_yad` date NOT NULL,
  `pejabat_penetap` varchar(50) NOT NULL,
  `nomor_sk` varchar(25) NOT NULL,
  `tgl_sk` date NOT NULL,
  `dasar_peraturan` varchar(50) NOT NULL,
  `masa_kerja` int(11) NOT NULL,
  `bln_kerja` int(11) NOT NULL,
  `berkas` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`jabatan`),
  KEY `jnj_jabatan` (`jabatan`),
  CONSTRAINT `riwayat_jabatan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_naik_gaji` */

DROP TABLE IF EXISTS `riwayat_naik_gaji`;

CREATE TABLE `riwayat_naik_gaji` (
  `id` int(11) NOT NULL,
  `pangkatjabatan` varchar(50) NOT NULL,
  `gapok` double NOT NULL,
  `tmt_berkala` date NOT NULL,
  `tmt_berkala_yad` date NOT NULL,
  `no_sk` varchar(25) NOT NULL,
  `tgl_sk` date NOT NULL,
  `masa_kerja` int(11) NOT NULL,
  `bulan_kerja` int(11) NOT NULL,
  `berkas` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`pangkatjabatan`,`gapok`),
  CONSTRAINT `riwayat_naik_gaji_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_pendidikan` */

DROP TABLE IF EXISTS `riwayat_pendidikan`;

CREATE TABLE `riwayat_pendidikan` (
  `id` int(11) NOT NULL,
  `pendidikan` enum('SD','SMP','SMA','SMK','D I','D II','D III','D IV','S1','S2','S3','Post Doctor') NOT NULL,
  `sekolah` varchar(50) NOT NULL,
  `jurusan` varchar(40) NOT NULL,
  `thn_lulus` year(4) NOT NULL,
  `kepala` varchar(50) NOT NULL,
  `pendanaan` enum('Biaya Sendiri','Biaya Instansi Sendiri','Lembaga Swasta Kerjasama','Lembaga Swasta Kompetisi','Lembaga Pemerintah Kerjasama','Lembaga Pemerintah Kompetisi','Lembaga Internasional') NOT NULL,
  `keterangan` varchar(50) NOT NULL,
  `status` varchar(40) NOT NULL,
  `berkas` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`pendidikan`,`sekolah`),
  CONSTRAINT `riwayat_pendidikan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_penelitian` */

DROP TABLE IF EXISTS `riwayat_penelitian`;

CREATE TABLE `riwayat_penelitian` (
  `id` int(11) NOT NULL,
  `jenis_penelitian` varchar(30) NOT NULL,
  `peranan` varchar(30) NOT NULL,
  `judul_penelitian` varchar(60) NOT NULL,
  `judul_jurnal` varchar(60) NOT NULL,
  `tahun` year(4) NOT NULL,
  `biaya_penelitian` double DEFAULT NULL,
  `asal_dana` varchar(30) NOT NULL,
  `berkas` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`judul_penelitian`,`tahun`),
  CONSTRAINT `riwayat_penelitian_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_penghargaan` */

DROP TABLE IF EXISTS `riwayat_penghargaan`;

CREATE TABLE `riwayat_penghargaan` (
  `id` int(11) NOT NULL,
  `jenis` varchar(30) NOT NULL,
  `nama_penghargaan` varchar(60) NOT NULL,
  `tanggal` date NOT NULL,
  `instansi` varchar(40) NOT NULL,
  `pejabat_pemberi` varchar(40) NOT NULL,
  `berkas` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`,`nama_penghargaan`,`tanggal`),
  CONSTRAINT `riwayat_penghargaan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_persalinan_pasien` */

DROP TABLE IF EXISTS `riwayat_persalinan_pasien`;

CREATE TABLE `riwayat_persalinan_pasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `tgl_thn` varchar(12) NOT NULL,
  `tempat_persalinan` varchar(30) DEFAULT NULL,
  `usia_hamil` varchar(20) DEFAULT NULL,
  `jenis_persalinan` varchar(20) DEFAULT NULL,
  `penolong` varchar(30) DEFAULT NULL,
  `penyulit` varchar(40) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `bbpb` varchar(10) DEFAULT NULL,
  `keadaan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`no_rkm_medis`,`tgl_thn`),
  CONSTRAINT `riwayat_persalinan_pasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `riwayat_seminar` */

DROP TABLE IF EXISTS `riwayat_seminar`;

CREATE TABLE `riwayat_seminar` (
  `id` int(11) NOT NULL,
  `tingkat` enum('Local','Regional','Nasional','Internasional') NOT NULL,
  `jenis` enum('WORKSHOP','SIMPOSIUM','SEMINAR','FGD','PELATIHAN','LAINNYA') NOT NULL,
  `nama_seminar` varchar(50) NOT NULL,
  `peranan` varchar(40) NOT NULL,
  `mulai` date NOT NULL,
  `selesai` date NOT NULL,
  `penyelengara` varchar(50) NOT NULL,
  `tempat` varchar(50) NOT NULL,
  `berkas` varchar(500) NOT NULL,
  PRIMARY KEY (`id`,`nama_seminar`,`mulai`),
  KEY `id` (`id`),
  CONSTRAINT `riwayat_seminar_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `roles` */

DROP TABLE IF EXISTS `roles`;

CREATE TABLE `roles` (
  `username` varchar(60) NOT NULL,
  `role` varchar(45) NOT NULL,
  `cap` varchar(20) NOT NULL,
  `module` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rujuk` */

DROP TABLE IF EXISTS `rujuk`;

CREATE TABLE `rujuk` (
  `no_rujuk` varchar(40) NOT NULL,
  `no_rawat` varchar(17) DEFAULT NULL,
  `rujuk_ke` varchar(150) DEFAULT NULL,
  `tgl_rujuk` date DEFAULT NULL,
  `keterangan_diagnosa` text DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `kat_rujuk` enum('-','Bedah','Non Bedah','Kebidanan','Anak') DEFAULT NULL,
  `ambulance` enum('-','AGD','SENDIRI','SWASTA') DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `jam` time DEFAULT NULL,
  KEY `kd_dokter` (`kd_dokter`),
  KEY `no_rawat` (`no_rawat`),
  KEY `rujuk_ke` (`rujuk_ke`),
  CONSTRAINT `rujuk_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rujuk_ibfk_2` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rujuk_masuk` */

DROP TABLE IF EXISTS `rujuk_masuk`;

CREATE TABLE `rujuk_masuk` (
  `no_rawat` varchar(17) NOT NULL DEFAULT '',
  `perujuk` varchar(60) DEFAULT NULL,
  `alamat` varchar(70) NOT NULL,
  `no_rujuk` varchar(40) NOT NULL,
  `jm_perujuk` double NOT NULL,
  `dokter_perujuk` varchar(50) DEFAULT NULL,
  `kd_penyakit` varchar(10) DEFAULT NULL,
  `kategori_rujuk` enum('-','Bedah','Non-Bedah','Kebidanan','Anak') DEFAULT NULL,
  `keterangan` varchar(200) DEFAULT NULL,
  `no_balasan` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`perujuk`),
  KEY `perujuk` (`perujuk`),
  KEY `alamat` (`alamat`),
  KEY `jm_perujuk` (`jm_perujuk`),
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `dokter_perujuk` (`dokter_perujuk`),
  CONSTRAINT `rujuk_masuk_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `rujuk_masuk_ibfk_2` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rujukan_internal_poli` */

DROP TABLE IF EXISTS `rujukan_internal_poli`;

CREATE TABLE `rujukan_internal_poli` (
  `no_rawat` varchar(17) NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `kd_poli` varchar(5) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`kd_dokter`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `kd_poli` (`kd_poli`),
  CONSTRAINT `rujukan_internal_poli_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rujukan_internal_poli_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rujukan_internal_poli_ibfk_3` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `rujukanranap_dokter_rs` */

DROP TABLE IF EXISTS `rujukanranap_dokter_rs`;

CREATE TABLE `rujukanranap_dokter_rs` (
  `tanggal` date NOT NULL,
  `kd_dokter` varchar(20) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `kd_kamar` varchar(15) NOT NULL,
  `jasarujuk` double NOT NULL,
  PRIMARY KEY (`tanggal`,`kd_dokter`,`no_rkm_medis`,`kd_kamar`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_kamar` (`kd_kamar`),
  KEY `rujukanranap_dokter_rs_ibfk_1` (`kd_dokter`),
  CONSTRAINT `rujukanranap_dokter_rs_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `rujukanranap_dokter_rs_ibfk_2` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `rujukanranap_dokter_rs_ibfk_3` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `runtext` */

DROP TABLE IF EXISTS `runtext`;

CREATE TABLE `runtext` (
  `teks` text NOT NULL,
  `aktifkan` enum('Yes','No') NOT NULL,
  `gambar` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `runtextapotek` */

DROP TABLE IF EXISTS `runtextapotek`;

CREATE TABLE `runtextapotek` (
  `teks` text NOT NULL,
  `aktifkan` enum('Yes','No') NOT NULL,
  `gambar` longblob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `saran_kesan_lab` */

DROP TABLE IF EXISTS `saran_kesan_lab`;

CREATE TABLE `saran_kesan_lab` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_periksa` date NOT NULL,
  `jam` time NOT NULL,
  `saran` varchar(2048) DEFAULT NULL,
  `kesan` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`no_rawat`,`tgl_periksa`,`jam`),
  CONSTRAINT `saran_kesan_lab_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `satuan_polri` */

DROP TABLE IF EXISTS `satuan_polri`;

CREATE TABLE `satuan_polri` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_satuan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Table structure for table `satuan_tni` */

DROP TABLE IF EXISTS `satuan_tni`;

CREATE TABLE `satuan_tni` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_satuan` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Table structure for table `set_akte` */

DROP TABLE IF EXISTS `set_akte`;

CREATE TABLE `set_akte` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_akte` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_akun` */

DROP TABLE IF EXISTS `set_akun`;

CREATE TABLE `set_akun` (
  `Pengadaan_Obat` varchar(15) DEFAULT NULL,
  `Pemesanan_Obat` varchar(15) DEFAULT NULL,
  `Kontra_Pemesanan_Obat` varchar(15) DEFAULT NULL,
  `Bayar_Pemesanan_Obat` varchar(15) DEFAULT NULL,
  `Penjualan_Obat` varchar(15) DEFAULT NULL,
  `Piutang_Obat` varchar(15) DEFAULT NULL,
  `Kontra_Piutang_Obat` varchar(15) DEFAULT NULL,
  `Retur_Ke_Suplayer` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Ke_Suplayer` varchar(15) DEFAULT NULL,
  `Retur_Dari_pembeli` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Dari_Pembeli` varchar(15) DEFAULT NULL,
  `Retur_Piutang_Obat` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Piutang_Obat` varchar(15) DEFAULT NULL,
  `Pengadaan_Ipsrs` varchar(15) DEFAULT NULL,
  `Stok_Keluar_Ipsrs` varchar(15) DEFAULT NULL,
  `Kontra_Stok_Keluar_Ipsrs` varchar(15) DEFAULT NULL,
  `Bayar_Piutang_Pasien` varchar(15) DEFAULT NULL,
  `Pengambilan_Utd` varchar(15) DEFAULT NULL,
  `Kontra_Pengambilan_Utd` varchar(15) DEFAULT NULL,
  `Pengambilan_Penunjang_Utd` varchar(15) DEFAULT NULL,
  `Kontra_Pengambilan_Penunjang_Utd` varchar(15) DEFAULT NULL,
  `Penyerahan_Darah` varchar(15) DEFAULT NULL,
  `Stok_Keluar_Medis` varchar(15) NOT NULL,
  `Kontra_Stok_Keluar_Medis` varchar(15) NOT NULL,
  `HPP_Obat_Jual_Bebas` varchar(15) DEFAULT NULL,
  `Persediaan_Obat_Jual_Bebas` varchar(15) DEFAULT NULL,
  `Penerimaan_NonMedis` varchar(15) NOT NULL,
  `Kontra_Penerimaan_NonMedis` varchar(15) NOT NULL,
  `Bayar_Pemesanan_Non_Medis` varchar(15) NOT NULL,
  `Hibah_Obat` varchar(15) NOT NULL,
  `Kontra_Hibah_Obat` varchar(15) NOT NULL,
  `Penerimaan_Toko` varchar(15) DEFAULT NULL,
  `Kontra_Penerimaan_Toko` varchar(15) DEFAULT NULL,
  `Pengadaan_Toko` varchar(15) NOT NULL,
  `Bayar_Pemesanan_Toko` varchar(15) DEFAULT NULL,
  `Penjualan_Toko` varchar(15) DEFAULT NULL,
  `HPP_Barang_Toko` varchar(15) DEFAULT NULL,
  `Persediaan_Barang_Toko` varchar(15) DEFAULT NULL,
  `Piutang_Toko` varchar(15) DEFAULT NULL,
  `Kontra_Piutang_Toko` varchar(15) DEFAULT NULL,
  `Retur_Beli_Toko` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Beli_Toko` varchar(15) DEFAULT NULL,
  `Retur_Beli_Non_Medis` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Beli_Non_Medis` varchar(15) DEFAULT NULL,
  `Retur_Jual_Toko` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Jual_Toko` varchar(15) DEFAULT NULL,
  `Retur_Piutang_Toko` varchar(15) DEFAULT NULL,
  `Kontra_Retur_Piutang_Toko` varchar(15) DEFAULT NULL,
  KEY `Pengadaan_Obat` (`Pengadaan_Obat`),
  KEY `Pemesanan_Obat` (`Pemesanan_Obat`),
  KEY `Kontra_Pemesanan_Obat` (`Kontra_Pemesanan_Obat`),
  KEY `Bayar_Pemesanan_Obat` (`Bayar_Pemesanan_Obat`),
  KEY `Penjualan_Obat` (`Penjualan_Obat`),
  KEY `Piutang_Obat` (`Piutang_Obat`),
  KEY `Kontra_Piutang_Obat` (`Kontra_Piutang_Obat`),
  KEY `Retur_Ke_Suplayer` (`Retur_Ke_Suplayer`),
  KEY `Kontra_Retur_Ke_Suplayer` (`Kontra_Retur_Ke_Suplayer`),
  KEY `Retur_Dari_pembeli` (`Retur_Dari_pembeli`),
  KEY `Kontra_Retur_Dari_Pembeli` (`Kontra_Retur_Dari_Pembeli`),
  KEY `Retur_Piutang_Obat` (`Retur_Piutang_Obat`),
  KEY `Kontra_Retur_Piutang_Obat` (`Kontra_Retur_Piutang_Obat`),
  KEY `Pengadaan_Ipsrs` (`Pengadaan_Ipsrs`),
  KEY `Stok_Keluar_Ipsrs` (`Stok_Keluar_Ipsrs`),
  KEY `Kontra_Stok_Keluar_Ipsrs` (`Kontra_Stok_Keluar_Ipsrs`),
  KEY `Bayar_Piutang_Pasien` (`Bayar_Piutang_Pasien`),
  KEY `Pengambilan_Utd` (`Pengambilan_Utd`),
  KEY `Kontra_Pengambilan_Utd` (`Kontra_Pengambilan_Utd`),
  KEY `Pengambilan_Penunjang_Utd` (`Pengambilan_Penunjang_Utd`),
  KEY `Kontra_Pengambilan_Penunjang_Utd` (`Kontra_Pengambilan_Penunjang_Utd`),
  KEY `Penyerahan_Darah` (`Penyerahan_Darah`),
  KEY `Stok_Keluar_Medis` (`Stok_Keluar_Medis`),
  KEY `Kontra_Stok_Keluar_Medis` (`Kontra_Stok_Keluar_Medis`),
  KEY `HPP_Obat_Jual_Bebas` (`HPP_Obat_Jual_Bebas`),
  KEY `Persediaan_Obat_Jual_Bebas` (`Persediaan_Obat_Jual_Bebas`),
  KEY `Penerimaan_NonMedis` (`Penerimaan_NonMedis`),
  KEY `Kontra_Penerimaan_NonMedis` (`Kontra_Penerimaan_NonMedis`),
  KEY `Bayar_Pemesanan_Non_Medis` (`Bayar_Pemesanan_Non_Medis`),
  KEY `Hibah_Obat` (`Hibah_Obat`),
  KEY `Kontra_Hibah_Obat` (`Kontra_Hibah_Obat`),
  KEY `Bayar_Pemesanan_Toko` (`Bayar_Pemesanan_Toko`),
  KEY `HPP_Barang_Toko` (`HPP_Barang_Toko`),
  KEY `Kontra_Penerimaan_Toko` (`Kontra_Penerimaan_Toko`),
  KEY `Kontra_Piutang_Toko` (`Kontra_Piutang_Toko`),
  KEY `Kontra_Retur_Beli_Non_Medis` (`Kontra_Retur_Beli_Non_Medis`),
  KEY `Kontra_Retur_Beli_Toko` (`Kontra_Retur_Beli_Toko`),
  KEY `Penerimaan_Toko` (`Penerimaan_Toko`),
  KEY `Pengadaan_Toko` (`Pengadaan_Toko`),
  KEY `Penjualan_Toko` (`Penjualan_Toko`),
  KEY `Persediaan_Barang_Toko` (`Persediaan_Barang_Toko`),
  KEY `Piutang_Toko` (`Piutang_Toko`),
  KEY `Retur_Beli_Non_Medis` (`Retur_Beli_Non_Medis`),
  KEY `Retur_Beli_Toko` (`Retur_Beli_Toko`),
  KEY `Kontra_Retur_Jual_Toko` (`Kontra_Retur_Jual_Toko`),
  KEY `Kontra_Retur_Piutang_Toko` (`Kontra_Retur_Piutang_Toko`),
  KEY `Retur_Jual_Toko` (`Retur_Jual_Toko`),
  KEY `Retur_Piutang_Toko` (`Retur_Piutang_Toko`),
  CONSTRAINT `set_akun_ibfk_1` FOREIGN KEY (`Pengadaan_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_10` FOREIGN KEY (`Retur_Dari_pembeli`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_11` FOREIGN KEY (`Kontra_Retur_Dari_Pembeli`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_12` FOREIGN KEY (`Retur_Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_13` FOREIGN KEY (`Kontra_Retur_Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_14` FOREIGN KEY (`Pengadaan_Ipsrs`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_15` FOREIGN KEY (`Stok_Keluar_Ipsrs`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_16` FOREIGN KEY (`Kontra_Stok_Keluar_Ipsrs`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_17` FOREIGN KEY (`Bayar_Piutang_Pasien`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_18` FOREIGN KEY (`Pengambilan_Utd`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_19` FOREIGN KEY (`Kontra_Pengambilan_Utd`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_2` FOREIGN KEY (`Pemesanan_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_20` FOREIGN KEY (`Pengambilan_Penunjang_Utd`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_21` FOREIGN KEY (`Kontra_Pengambilan_Penunjang_Utd`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_22` FOREIGN KEY (`Penyerahan_Darah`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_23` FOREIGN KEY (`Stok_Keluar_Medis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_24` FOREIGN KEY (`Kontra_Stok_Keluar_Medis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_25` FOREIGN KEY (`HPP_Obat_Jual_Bebas`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_26` FOREIGN KEY (`Persediaan_Obat_Jual_Bebas`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_27` FOREIGN KEY (`Penerimaan_NonMedis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_28` FOREIGN KEY (`Kontra_Penerimaan_NonMedis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_29` FOREIGN KEY (`Bayar_Pemesanan_Non_Medis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_3` FOREIGN KEY (`Kontra_Pemesanan_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_30` FOREIGN KEY (`Hibah_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_31` FOREIGN KEY (`Kontra_Hibah_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_32` FOREIGN KEY (`Penerimaan_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_33` FOREIGN KEY (`Kontra_Penerimaan_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_34` FOREIGN KEY (`Pengadaan_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_35` FOREIGN KEY (`Bayar_Pemesanan_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_36` FOREIGN KEY (`Penjualan_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_37` FOREIGN KEY (`HPP_Barang_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_38` FOREIGN KEY (`Persediaan_Barang_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_39` FOREIGN KEY (`Piutang_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_4` FOREIGN KEY (`Bayar_Pemesanan_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_40` FOREIGN KEY (`Kontra_Piutang_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_41` FOREIGN KEY (`Retur_Beli_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_42` FOREIGN KEY (`Kontra_Retur_Beli_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_43` FOREIGN KEY (`Retur_Beli_Non_Medis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_44` FOREIGN KEY (`Kontra_Retur_Beli_Non_Medis`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_45` FOREIGN KEY (`Retur_Jual_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_46` FOREIGN KEY (`Kontra_Retur_Jual_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_47` FOREIGN KEY (`Retur_Piutang_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_48` FOREIGN KEY (`Kontra_Retur_Piutang_Toko`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_5` FOREIGN KEY (`Penjualan_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_6` FOREIGN KEY (`Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_7` FOREIGN KEY (`Kontra_Piutang_Obat`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_8` FOREIGN KEY (`Retur_Ke_Suplayer`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ibfk_9` FOREIGN KEY (`Kontra_Retur_Ke_Suplayer`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_akun_ralan` */

DROP TABLE IF EXISTS `set_akun_ralan`;

CREATE TABLE `set_akun_ralan` (
  `Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Dokter_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Paramedis_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Paramedis_Tindakan_Ralan` varchar(15) DEFAULT NULL,
  `Beban_KSO_Tindakan_Ralan` varchar(15) NOT NULL,
  `Utang_KSO_Tindakan_Ralan` varchar(15) NOT NULL,
  `Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Dokter_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Petugas_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Jasa_Medik_Petugas_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Kso_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `Utang_Kso_Laborat_Ralan` varchar(15) DEFAULT NULL,
  `HPP_Persediaan_Laborat_Rawat_Jalan` varchar(15) DEFAULT NULL,
  `Persediaan_BHP_Laborat_Rawat_Jalan` varchar(15) DEFAULT NULL,
  `Radiologi_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Radiologi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Radiologi_Ralan` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Petugas_Radiologi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Petugas_Radiologi_Ralan` varchar(15) NOT NULL,
  `Beban_Kso_Radiologi_Ralan` varchar(15) NOT NULL,
  `Utang_Kso_Radiologi_Ralan` varchar(15) NOT NULL,
  `HPP_Persediaan_Radiologi_Rawat_Jalan` varchar(15) NOT NULL,
  `Persediaan_BHP_Radiologi_Rawat_Jalan` varchar(15) NOT NULL,
  `Obat_Ralan` varchar(15) DEFAULT NULL,
  `HPP_Obat_Rawat_Jalan` varchar(15) NOT NULL,
  `Persediaan_Obat_Rawat_Jalan` varchar(15) NOT NULL,
  `Registrasi_Ralan` varchar(15) DEFAULT NULL,
  `Operasi_Ralan` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Operasi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Operasi_Ralan` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Paramedis_Operasi_Ralan` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Paramedis_Operasi_Ralan` varchar(15) NOT NULL,
  `HPP_Obat_Operasi_Ralan` varchar(15) NOT NULL,
  `Persediaan_Obat_Kamar_Operasi_Ralan` varchar(15) NOT NULL,
  `Tambahan_Ralan` varchar(15) DEFAULT NULL,
  `Potongan_Ralan` varchar(15) DEFAULT NULL,
  KEY `Tindakan_Ralan` (`Tindakan_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Tindakan_Ralan` (`Beban_Jasa_Medik_Dokter_Tindakan_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Tindakan_Ralan` (`Utang_Jasa_Medik_Dokter_Tindakan_Ralan`),
  KEY `Beban_Jasa_Medik_Paramedis_Tindakan_Ralan` (`Beban_Jasa_Medik_Paramedis_Tindakan_Ralan`),
  KEY `Utang_Jasa_Medik_Paramedis_Tindakan_Ralan` (`Utang_Jasa_Medik_Paramedis_Tindakan_Ralan`),
  KEY `Beban_KSO_Tindakan_Ralan` (`Beban_KSO_Tindakan_Ralan`),
  KEY `Utang_KSO_Tindakan_Ralan` (`Utang_KSO_Tindakan_Ralan`),
  KEY `Laborat_Ralan` (`Laborat_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Laborat_Ralan` (`Beban_Jasa_Medik_Dokter_Laborat_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Laborat_Ralan` (`Utang_Jasa_Medik_Dokter_Laborat_Ralan`),
  KEY `Beban_Jasa_Medik_Petugas_Laborat_Ralan` (`Beban_Jasa_Medik_Petugas_Laborat_Ralan`),
  KEY `Utang_Jasa_Medik_Petugas_Laborat_Ralan` (`Utang_Jasa_Medik_Petugas_Laborat_Ralan`),
  KEY `Beban_Kso_Laborat_Ralan` (`Beban_Kso_Laborat_Ralan`),
  KEY `Utang_Kso_Laborat_Ralan` (`Utang_Kso_Laborat_Ralan`),
  KEY `HPP_Persediaan_Laborat_Rawat_Jalan` (`HPP_Persediaan_Laborat_Rawat_Jalan`),
  KEY `Persediaan_BHP_Laborat_Rawat_Jalan` (`Persediaan_BHP_Laborat_Rawat_Jalan`),
  KEY `Radiologi_Ralan` (`Radiologi_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Radiologi_Ralan` (`Beban_Jasa_Medik_Dokter_Radiologi_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Radiologi_Ralan` (`Utang_Jasa_Medik_Dokter_Radiologi_Ralan`),
  KEY `Beban_Jasa_Medik_Petugas_Radiologi_Ralan` (`Beban_Jasa_Medik_Petugas_Radiologi_Ralan`),
  KEY `Utang_Jasa_Medik_Petugas_Radiologi_Ralan` (`Utang_Jasa_Medik_Petugas_Radiologi_Ralan`),
  KEY `Beban_Kso_Radiologi_Ralan` (`Beban_Kso_Radiologi_Ralan`),
  KEY `Utang_Kso_Radiologi_Ralan` (`Utang_Kso_Radiologi_Ralan`),
  KEY `HPP_Persediaan_Radiologi_Rawat_Jalan` (`HPP_Persediaan_Radiologi_Rawat_Jalan`),
  KEY `Persediaan_BHP_Radiologi_Rawat_Jalan` (`Persediaan_BHP_Radiologi_Rawat_Jalan`),
  KEY `Obat_Ralan` (`Obat_Ralan`),
  KEY `HPP_Obat_Rawat_Jalan` (`HPP_Obat_Rawat_Jalan`),
  KEY `Persediaan_Obat_Rawat_Jalan` (`Persediaan_Obat_Rawat_Jalan`),
  KEY `Registrasi_Ralan` (`Registrasi_Ralan`),
  KEY `Operasi_Ralan` (`Operasi_Ralan`),
  KEY `Beban_Jasa_Medik_Dokter_Operasi_Ralan` (`Beban_Jasa_Medik_Dokter_Operasi_Ralan`),
  KEY `Utang_Jasa_Medik_Dokter_Operasi_Ralan` (`Utang_Jasa_Medik_Dokter_Operasi_Ralan`),
  KEY `Beban_Jasa_Medik_Paramedis_Operasi_Ralan` (`Beban_Jasa_Medik_Paramedis_Operasi_Ralan`),
  KEY `Utang_Jasa_Medik_Paramedis_Operasi_Ralan` (`Utang_Jasa_Medik_Paramedis_Operasi_Ralan`),
  KEY `HPP_Obat_Operasi_Ralan` (`HPP_Obat_Operasi_Ralan`),
  KEY `Persediaan_Obat_Kamar_Operasi_Ralan` (`Persediaan_Obat_Kamar_Operasi_Ralan`),
  KEY `Tambahan_Ralan` (`Tambahan_Ralan`),
  KEY `Potongan_Ralan` (`Potongan_Ralan`),
  CONSTRAINT `set_akun_ralan_ibfk_1` FOREIGN KEY (`Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_10` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_11` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_12` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_13` FOREIGN KEY (`Beban_Kso_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_14` FOREIGN KEY (`Utang_Kso_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_15` FOREIGN KEY (`HPP_Persediaan_Laborat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_16` FOREIGN KEY (`Persediaan_BHP_Laborat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_17` FOREIGN KEY (`Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_18` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_19` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_2` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_20` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_21` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_22` FOREIGN KEY (`Beban_Kso_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_23` FOREIGN KEY (`Utang_Kso_Radiologi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_24` FOREIGN KEY (`HPP_Persediaan_Radiologi_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_25` FOREIGN KEY (`Persediaan_BHP_Radiologi_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_26` FOREIGN KEY (`Obat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_27` FOREIGN KEY (`HPP_Obat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_28` FOREIGN KEY (`Persediaan_Obat_Rawat_Jalan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_29` FOREIGN KEY (`Registrasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_3` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_30` FOREIGN KEY (`Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_31` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_32` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_33` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_34` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_35` FOREIGN KEY (`HPP_Obat_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_36` FOREIGN KEY (`Persediaan_Obat_Kamar_Operasi_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_37` FOREIGN KEY (`Tambahan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_38` FOREIGN KEY (`Potongan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_4` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_5` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_6` FOREIGN KEY (`Beban_KSO_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_7` FOREIGN KEY (`Utang_KSO_Tindakan_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_8` FOREIGN KEY (`Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ralan_ibfk_9` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Laborat_Ralan`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_akun_ranap` */

DROP TABLE IF EXISTS `set_akun_ranap`;

CREATE TABLE `set_akun_ranap` (
  `Suspen_Piutang_Tindakan_Ranap` varchar(15) NOT NULL,
  `Tindakan_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Tindakan_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Tindakan_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Paramedis_Tindakan_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Paramedis_Tindakan_Ranap` varchar(15) NOT NULL,
  `Beban_KSO_Tindakan_Ranap` varchar(15) NOT NULL,
  `Utang_KSO_Tindakan_Ranap` varchar(15) NOT NULL,
  `Suspen_Piutang_Laborat_Ranap` varchar(15) NOT NULL,
  `Laborat_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Laborat_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Laborat_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Petugas_Laborat_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Petugas_Laborat_Ranap` varchar(15) NOT NULL,
  `Beban_Kso_Laborat_Ranap` varchar(15) NOT NULL,
  `Utang_Kso_Laborat_Ranap` varchar(15) NOT NULL,
  `HPP_Persediaan_Laborat_Rawat_inap` varchar(15) NOT NULL,
  `Persediaan_BHP_Laborat_Rawat_Inap` varchar(15) NOT NULL,
  `Suspen_Piutang_Radiologi_Ranap` varchar(15) NOT NULL,
  `Radiologi_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Radiologi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Radiologi_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Petugas_Radiologi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Petugas_Radiologi_Ranap` varchar(15) NOT NULL,
  `Beban_Kso_Radiologi_Ranap` varchar(15) NOT NULL,
  `Utang_Kso_Radiologi_Ranap` varchar(15) NOT NULL,
  `HPP_Persediaan_Radiologi_Rawat_Inap` varchar(15) NOT NULL,
  `Persediaan_BHP_Radiologi_Rawat_Inap` varchar(15) NOT NULL,
  `Suspen_Piutang_Obat_Ranap` varchar(15) NOT NULL,
  `Obat_Ranap` varchar(15) DEFAULT NULL,
  `HPP_Obat_Rawat_Inap` varchar(15) NOT NULL,
  `Persediaan_Obat_Rawat_Inap` varchar(15) NOT NULL,
  `Registrasi_Ranap` varchar(15) DEFAULT NULL,
  `Service_Ranap` varchar(15) DEFAULT NULL,
  `Tambahan_Ranap` varchar(15) DEFAULT NULL,
  `Potongan_Ranap` varchar(15) DEFAULT NULL,
  `Retur_Obat_Ranap` varchar(15) DEFAULT NULL,
  `Resep_Pulang_Ranap` varchar(15) DEFAULT NULL,
  `Kamar_Inap` varchar(15) DEFAULT NULL,
  `Suspen_Piutang_Operasi_Ranap` varchar(15) NOT NULL,
  `Operasi_Ranap` varchar(15) DEFAULT NULL,
  `Beban_Jasa_Medik_Dokter_Operasi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Dokter_Operasi_Ranap` varchar(15) NOT NULL,
  `Beban_Jasa_Medik_Paramedis_Operasi_Ranap` varchar(15) NOT NULL,
  `Utang_Jasa_Medik_Paramedis_Operasi_Ranap` varchar(15) NOT NULL,
  `HPP_Obat_Operasi_Ranap` varchar(15) NOT NULL,
  `Persediaan_Obat_Kamar_Operasi_Ranap` varchar(15) NOT NULL,
  `Harian_Ranap` varchar(15) DEFAULT NULL,
  `Uang_Muka_Ranap` varchar(15) DEFAULT NULL,
  `Piutang_Pasien_Ranap` varchar(15) DEFAULT NULL,
  KEY `Suspen_Piutang_Tindakan_Ranap` (`Suspen_Piutang_Tindakan_Ranap`),
  KEY `Tindakan_Ranap` (`Tindakan_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Tindakan_Ranap` (`Beban_Jasa_Medik_Dokter_Tindakan_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Tindakan_Ranap` (`Utang_Jasa_Medik_Dokter_Tindakan_Ranap`),
  KEY `Beban_Jasa_Medik_Paramedis_Tindakan_Ranap` (`Beban_Jasa_Medik_Paramedis_Tindakan_Ranap`),
  KEY `Utang_Jasa_Medik_Paramedis_Tindakan_Ranap` (`Utang_Jasa_Medik_Paramedis_Tindakan_Ranap`),
  KEY `Beban_KSO_Tindakan_Ranap` (`Beban_KSO_Tindakan_Ranap`),
  KEY `Utang_KSO_Tindakan_Ranap` (`Utang_KSO_Tindakan_Ranap`),
  KEY `Suspen_Piutang_Laborat_Ranap` (`Suspen_Piutang_Laborat_Ranap`),
  KEY `Laborat_Ranap` (`Laborat_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Laborat_Ranap` (`Beban_Jasa_Medik_Dokter_Laborat_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Laborat_Ranap` (`Utang_Jasa_Medik_Dokter_Laborat_Ranap`),
  KEY `Beban_Jasa_Medik_Petugas_Laborat_Ranap` (`Beban_Jasa_Medik_Petugas_Laborat_Ranap`),
  KEY `Utang_Jasa_Medik_Petugas_Laborat_Ranap` (`Utang_Jasa_Medik_Petugas_Laborat_Ranap`),
  KEY `Beban_Kso_Laborat_Ranap` (`Beban_Kso_Laborat_Ranap`),
  KEY `Utang_Kso_Laborat_Ranap` (`Utang_Kso_Laborat_Ranap`),
  KEY `HPP_Persediaan_Laborat_Rawat_inap` (`HPP_Persediaan_Laborat_Rawat_inap`),
  KEY `Persediaan_BHP_Laborat_Rawat_Inap` (`Persediaan_BHP_Laborat_Rawat_Inap`),
  KEY `Suspen_Piutang_Radiologi_Ranap` (`Suspen_Piutang_Radiologi_Ranap`),
  KEY `Radiologi_Ranap` (`Radiologi_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Radiologi_Ranap` (`Beban_Jasa_Medik_Dokter_Radiologi_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Radiologi_Ranap` (`Utang_Jasa_Medik_Dokter_Radiologi_Ranap`),
  KEY `Beban_Jasa_Medik_Petugas_Radiologi_Ranap` (`Beban_Jasa_Medik_Petugas_Radiologi_Ranap`),
  KEY `Utang_Jasa_Medik_Petugas_Radiologi_Ranap` (`Utang_Jasa_Medik_Petugas_Radiologi_Ranap`),
  KEY `Beban_Kso_Radiologi_Ranap` (`Beban_Kso_Radiologi_Ranap`),
  KEY `Utang_Kso_Radiologi_Ranap` (`Utang_Kso_Radiologi_Ranap`),
  KEY `HPP_Persediaan_Radiologi_Rawat_Inap` (`HPP_Persediaan_Radiologi_Rawat_Inap`),
  KEY `Persediaan_BHP_Radiologi_Rawat_Inap` (`Persediaan_BHP_Radiologi_Rawat_Inap`),
  KEY `Obat_Ranap` (`Obat_Ranap`),
  KEY `Registrasi_Ranap` (`Registrasi_Ranap`),
  KEY `Service_Ranap` (`Service_Ranap`),
  KEY `Tambahan_Ranap` (`Tambahan_Ranap`),
  KEY `Potongan_Ranap` (`Potongan_Ranap`),
  KEY `Retur_Obat_Ranap` (`Retur_Obat_Ranap`),
  KEY `Resep_Pulang_Ranap` (`Resep_Pulang_Ranap`),
  KEY `Kamar_Inap` (`Kamar_Inap`),
  KEY `Operasi_Ranap` (`Operasi_Ranap`),
  KEY `Harian_Ranap` (`Harian_Ranap`),
  KEY `Uang_Muka_Ranap` (`Uang_Muka_Ranap`),
  KEY `Piutang_Pasien_Ranap` (`Piutang_Pasien_Ranap`),
  KEY `Suspen_Piutang_Obat_Ranap` (`Suspen_Piutang_Obat_Ranap`),
  KEY `HPP_Obat_Rawat_Inap` (`HPP_Obat_Rawat_Inap`),
  KEY `Persediaan_Obat_Rawat_Inap` (`Persediaan_Obat_Rawat_Inap`),
  KEY `Suspen_Piutang_Operasi_Ranap` (`Suspen_Piutang_Operasi_Ranap`),
  KEY `Beban_Jasa_Medik_Dokter_Operasi_Ranap` (`Beban_Jasa_Medik_Dokter_Operasi_Ranap`),
  KEY `Utang_Jasa_Medik_Dokter_Operasi_Ranap` (`Utang_Jasa_Medik_Dokter_Operasi_Ranap`),
  KEY `Beban_Jasa_Medik_Paramedis_Operasi_Ranap` (`Beban_Jasa_Medik_Paramedis_Operasi_Ranap`),
  KEY `Utang_Jasa_Medik_Paramedis_Operasi_Ranap` (`Utang_Jasa_Medik_Paramedis_Operasi_Ranap`),
  KEY `HPP_Obat_Operasi_Ranap` (`HPP_Obat_Operasi_Ranap`),
  KEY `Persediaan_Obat_Kamar_Operasi_Ranap` (`Persediaan_Obat_Kamar_Operasi_Ranap`),
  CONSTRAINT `set_akun_ranap_ibfk_1` FOREIGN KEY (`Suspen_Piutang_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_10` FOREIGN KEY (`Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_11` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_12` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_13` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_14` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_15` FOREIGN KEY (`Beban_Kso_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_16` FOREIGN KEY (`Utang_Kso_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_17` FOREIGN KEY (`HPP_Persediaan_Laborat_Rawat_inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_18` FOREIGN KEY (`Persediaan_BHP_Laborat_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_19` FOREIGN KEY (`Suspen_Piutang_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_2` FOREIGN KEY (`Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_20` FOREIGN KEY (`Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_21` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_22` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_23` FOREIGN KEY (`Beban_Jasa_Medik_Petugas_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_24` FOREIGN KEY (`Utang_Jasa_Medik_Petugas_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_25` FOREIGN KEY (`Beban_Kso_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_26` FOREIGN KEY (`Utang_Kso_Radiologi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_27` FOREIGN KEY (`HPP_Persediaan_Radiologi_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_28` FOREIGN KEY (`Persediaan_BHP_Radiologi_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_29` FOREIGN KEY (`Obat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_3` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_30` FOREIGN KEY (`Registrasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_31` FOREIGN KEY (`Service_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_32` FOREIGN KEY (`Tambahan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_33` FOREIGN KEY (`Potongan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_34` FOREIGN KEY (`Retur_Obat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_35` FOREIGN KEY (`Resep_Pulang_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_36` FOREIGN KEY (`Kamar_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_37` FOREIGN KEY (`Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_38` FOREIGN KEY (`Harian_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_39` FOREIGN KEY (`Uang_Muka_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_4` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_40` FOREIGN KEY (`Piutang_Pasien_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_41` FOREIGN KEY (`Suspen_Piutang_Obat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_42` FOREIGN KEY (`HPP_Obat_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_43` FOREIGN KEY (`Persediaan_Obat_Rawat_Inap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_44` FOREIGN KEY (`Suspen_Piutang_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_45` FOREIGN KEY (`Beban_Jasa_Medik_Dokter_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_46` FOREIGN KEY (`Utang_Jasa_Medik_Dokter_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_47` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_48` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_49` FOREIGN KEY (`HPP_Obat_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_5` FOREIGN KEY (`Beban_Jasa_Medik_Paramedis_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_50` FOREIGN KEY (`Persediaan_Obat_Kamar_Operasi_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_6` FOREIGN KEY (`Utang_Jasa_Medik_Paramedis_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_7` FOREIGN KEY (`Beban_KSO_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_8` FOREIGN KEY (`Utang_KSO_Tindakan_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `set_akun_ranap_ibfk_9` FOREIGN KEY (`Suspen_Piutang_Laborat_Ranap`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_alamat_pasien` */

DROP TABLE IF EXISTS `set_alamat_pasien`;

CREATE TABLE `set_alamat_pasien` (
  `kelurahan` enum('true','false') DEFAULT NULL,
  `kecamatan` enum('true','false') DEFAULT NULL,
  `kabupaten` enum('true','false') DEFAULT NULL,
  `propinsi` enum('true','false') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_depo_ralan` */

DROP TABLE IF EXISTS `set_depo_ralan`;

CREATE TABLE `set_depo_ralan` (
  `kd_poli` char(5) NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  PRIMARY KEY (`kd_poli`,`kd_bangsal`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `set_depo_ralan_ibfk_1` FOREIGN KEY (`kd_poli`) REFERENCES `poliklinik` (`kd_poli`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_depo_ralan_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_depo_ranap` */

DROP TABLE IF EXISTS `set_depo_ranap`;

CREATE TABLE `set_depo_ranap` (
  `kd_bangsal` char(5) NOT NULL,
  `kd_depo` char(5) NOT NULL,
  PRIMARY KEY (`kd_bangsal`,`kd_depo`),
  KEY `kd_depo` (`kd_depo`),
  CONSTRAINT `set_depo_ranap_ibfk_1` FOREIGN KEY (`kd_depo`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_depo_ranap_ibfk_2` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_embalase` */

DROP TABLE IF EXISTS `set_embalase`;

CREATE TABLE `set_embalase` (
  `embalase_per_obat` double NOT NULL,
  `tuslah_per_obat` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_hadir` */

DROP TABLE IF EXISTS `set_hadir`;

CREATE TABLE `set_hadir` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_harga_kamar` */

DROP TABLE IF EXISTS `set_harga_kamar`;

CREATE TABLE `set_harga_kamar` (
  `kd_kamar` varchar(15) NOT NULL,
  `kd_pj` char(3) NOT NULL,
  `tarif` double NOT NULL,
  PRIMARY KEY (`kd_kamar`,`kd_pj`),
  KEY `kd_pj` (`kd_pj`),
  KEY `tarif` (`tarif`),
  CONSTRAINT `set_harga_kamar_ibfk_1` FOREIGN KEY (`kd_kamar`) REFERENCES `kamar` (`kd_kamar`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_harga_kamar_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_harga_obat` */

DROP TABLE IF EXISTS `set_harga_obat`;

CREATE TABLE `set_harga_obat` (
  `setharga` enum('Umum','Per Jenis','Per Barang') NOT NULL,
  `hargadasar` enum('Harga Beli','Harga Diskon') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_harga_obat_ralan` */

DROP TABLE IF EXISTS `set_harga_obat_ralan`;

CREATE TABLE `set_harga_obat_ralan` (
  `kd_pj` char(3) NOT NULL,
  `hargajual` double NOT NULL,
  PRIMARY KEY (`kd_pj`),
  CONSTRAINT `set_harga_obat_ralan_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_harga_obat_ranap` */

DROP TABLE IF EXISTS `set_harga_obat_ranap`;

CREATE TABLE `set_harga_obat_ranap` (
  `kd_pj` char(3) NOT NULL,
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL DEFAULT 'Kelas 1',
  `hargajual` double NOT NULL,
  PRIMARY KEY (`kd_pj`,`kelas`),
  CONSTRAINT `set_harga_obat_ranap_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_hari_libur` */

DROP TABLE IF EXISTS `set_hari_libur`;

CREATE TABLE `set_hari_libur` (
  `tanggal` date NOT NULL,
  `ktg` varchar(40) NOT NULL,
  PRIMARY KEY (`tanggal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_input_parsial` */

DROP TABLE IF EXISTS `set_input_parsial`;

CREATE TABLE `set_input_parsial` (
  `kd_pj` char(3) NOT NULL,
  PRIMARY KEY (`kd_pj`),
  CONSTRAINT `set_input_parsial_ibfk_1` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_insentif` */

DROP TABLE IF EXISTS `set_insentif`;

CREATE TABLE `set_insentif` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan` double NOT NULL,
  `persen` double NOT NULL,
  `total_insentif` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_jam_minimal` */

DROP TABLE IF EXISTS `set_jam_minimal`;

CREATE TABLE `set_jam_minimal` (
  `lamajam` int(11) NOT NULL,
  `hariawal` enum('Yes','No') NOT NULL,
  `feeperujuk` double NOT NULL,
  `diagnosaakhir` enum('Yes','No') DEFAULT NULL,
  `bayi` int(11) DEFAULT NULL,
  `aktifkan_hapus_data_salah` enum('Yes','No') DEFAULT NULL,
  `kamar_inap_kasir_ralan` enum('Yes','No') DEFAULT NULL,
  `ubah_status_kamar` enum('Yes','No') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_jgmlm` */

DROP TABLE IF EXISTS `set_jgmlm`;

CREATE TABLE `set_jgmlm` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_jgtambah` */

DROP TABLE IF EXISTS `set_jgtambah`;

CREATE TABLE `set_jgtambah` (
  `tnj` double NOT NULL,
  `pendidikan` varchar(80) NOT NULL,
  PRIMARY KEY (`pendidikan`),
  CONSTRAINT `set_jgtambah_ibfk_1` FOREIGN KEY (`pendidikan`) REFERENCES `pendidikan` (`tingkat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_kelengkapan_data_pasien` */

DROP TABLE IF EXISTS `set_kelengkapan_data_pasien`;

CREATE TABLE `set_kelengkapan_data_pasien` (
  `no_ktp` enum('Yes','No') DEFAULT NULL,
  `p_no_ktp` tinyint(4) DEFAULT NULL,
  `tmp_lahir` enum('Yes','No') DEFAULT NULL,
  `p_tmp_lahir` tinyint(4) DEFAULT NULL,
  `nm_ibu` enum('Yes','No') DEFAULT NULL,
  `p_nm_ibu` tinyint(4) DEFAULT NULL,
  `alamat` enum('Yes','No') DEFAULT NULL,
  `p_alamat` tinyint(4) DEFAULT NULL,
  `pekerjaan` enum('Yes','No') DEFAULT NULL,
  `p_pekerjaan` tinyint(4) DEFAULT NULL,
  `no_tlp` enum('Yes','No') DEFAULT NULL,
  `p_no_tlp` tinyint(4) DEFAULT NULL,
  `umur` enum('Yes','No') DEFAULT NULL,
  `p_umur` tinyint(4) DEFAULT NULL,
  `namakeluarga` enum('Yes','No') DEFAULT NULL,
  `p_namakeluarga` tinyint(4) DEFAULT NULL,
  `no_peserta` enum('Yes','No') DEFAULT NULL,
  `p_no_peserta` tinyint(4) DEFAULT NULL,
  `kelurahan` enum('Yes','No') DEFAULT NULL,
  `p_kelurahan` tinyint(4) DEFAULT NULL,
  `kecamatan` enum('Yes','No') DEFAULT NULL,
  `p_kecamatan` tinyint(4) DEFAULT NULL,
  `kabupaten` enum('Yes','No') DEFAULT NULL,
  `p_kabupaten` tinyint(4) DEFAULT NULL,
  `pekerjaanpj` enum('Yes','No') DEFAULT NULL,
  `p_pekerjaanpj` tinyint(4) DEFAULT NULL,
  `alamatpj` enum('Yes','No') DEFAULT NULL,
  `p_alamatpj` tinyint(4) DEFAULT NULL,
  `kelurahanpj` enum('Yes','No') DEFAULT NULL,
  `p_kelurahanpj` tinyint(4) DEFAULT NULL,
  `kecamatanpj` enum('Yes','No') DEFAULT NULL,
  `p_kecamatanpj` tinyint(4) DEFAULT NULL,
  `kabupatenpj` enum('Yes','No') DEFAULT NULL,
  `p_kabupatenpj` tinyint(4) DEFAULT NULL,
  `propinsi` enum('Yes','No') NOT NULL,
  `p_propinsi` tinyint(4) NOT NULL,
  `propinsipj` enum('Yes','No') NOT NULL,
  `p_propinsipj` tinyint(4) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_keterlambatan` */

DROP TABLE IF EXISTS `set_keterlambatan`;

CREATE TABLE `set_keterlambatan` (
  `toleransi` int(11) DEFAULT NULL,
  `terlambat1` int(11) DEFAULT NULL,
  `terlambat2` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_lemburhb` */

DROP TABLE IF EXISTS `set_lemburhb`;

CREATE TABLE `set_lemburhb` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_lemburhr` */

DROP TABLE IF EXISTS `set_lemburhr`;

CREATE TABLE `set_lemburhr` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_lokasi` */

DROP TABLE IF EXISTS `set_lokasi`;

CREATE TABLE `set_lokasi` (
  `kd_bangsal` char(5) NOT NULL,
  `asal_stok` enum('Gunakan Stok Utama Obat','Gunakan Stok Bangsal') NOT NULL,
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `set_lokasi_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_modal_payment` */

DROP TABLE IF EXISTS `set_modal_payment`;

CREATE TABLE `set_modal_payment` (
  `modal_awal` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_no_rkm_medis` */

DROP TABLE IF EXISTS `set_no_rkm_medis`;

CREATE TABLE `set_no_rkm_medis` (
  `no_rkm_medis` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_nota` */

DROP TABLE IF EXISTS `set_nota`;

CREATE TABLE `set_nota` (
  `notaralan` varchar(11) NOT NULL,
  `kwitansiralan` varchar(11) NOT NULL,
  `nota1ranap` varchar(11) NOT NULL,
  `nota2ranap` varchar(11) NOT NULL,
  `kwitansiranap` varchar(11) NOT NULL,
  `notaapotek` varchar(11) NOT NULL,
  `notalabrad` varchar(11) NOT NULL,
  `notatoko` varchar(11) NOT NULL,
  `cetaknotasimpanralan` enum('Yes','No') NOT NULL,
  `cetaknotasimpanranap` enum('Yes','No') NOT NULL,
  `rinciandokterralan` enum('Yes','No') NOT NULL,
  `rinciandokterranap` enum('Yes','No') NOT NULL,
  `centangdokterralan` enum('Yes','No') NOT NULL,
  `centangdokterranap` enum('Yes','No') NOT NULL,
  `tampilkan_administrasi_di_billingranap` enum('Yes','No') NOT NULL,
  `rincianoperasi` enum('Yes','No') DEFAULT NULL,
  `tampilkan_ppnobat_ralan` enum('Yes','No') DEFAULT NULL,
  `tampilkan_ppnobat_ranap` enum('Yes','No') DEFAULT NULL,
  `tampilkan_tombol_nota_ralan` enum('Yes','No') DEFAULT NULL,
  `tampilkan_tombol_nota_ranap` enum('Yes','No') DEFAULT NULL,
  `verifikasi_penjualan_di_kasir` enum('Yes','No') DEFAULT NULL,
  `verifikasi_penyerahan_darah_di_kasir` enum('Yes','No') DEFAULT NULL,
  `cetaknotasimpanpenjualan` enum('Yes','No') DEFAULT NULL,
  `tampilkan_tombol_nota_penjualan` enum('Yes','No') DEFAULT NULL,
  `centangobatralan` enum('Yes','No') DEFAULT NULL,
  `centangobatranap` enum('Yes','No') DEFAULT NULL,
  `cetaknotasimpantoko` enum('Yes','No') NOT NULL,
  `tampilkan_tombol_nota_toko` enum('Yes','No') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_otomatis_tindakan_ralan` */

DROP TABLE IF EXISTS `set_otomatis_tindakan_ralan`;

CREATE TABLE `set_otomatis_tindakan_ralan` (
  `kd_dokter` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_pj` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`kd_dokter`,`kd_jenis_prw`,`kd_pj`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `set_otomatis_tindakan_ralan_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_otomatis_tindakan_ralan_dokterpetugas` */

DROP TABLE IF EXISTS `set_otomatis_tindakan_ralan_dokterpetugas`;

CREATE TABLE `set_otomatis_tindakan_ralan_dokterpetugas` (
  `kd_dokter` varchar(20) NOT NULL,
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_pj` char(3) NOT NULL DEFAULT '',
  PRIMARY KEY (`kd_dokter`,`kd_jenis_prw`,`kd_pj`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `set_otomatis_tindakan_ralan_dokterpetugas_ibfk_1` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_dokterpetugas_ibfk_2` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_dokterpetugas_ibfk_3` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_otomatis_tindakan_ralan_petugas` */

DROP TABLE IF EXISTS `set_otomatis_tindakan_ralan_petugas`;

CREATE TABLE `set_otomatis_tindakan_ralan_petugas` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `kd_pj` char(3) NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`,`kd_pj`),
  KEY `kd_pj` (`kd_pj`),
  CONSTRAINT `set_otomatis_tindakan_ralan_petugas_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_otomatis_tindakan_ralan_petugas_ibfk_2` FOREIGN KEY (`kd_pj`) REFERENCES `penjab` (`kd_pj`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_pjlab` */

DROP TABLE IF EXISTS `set_pjlab`;

CREATE TABLE `set_pjlab` (
  `kd_dokterlab` varchar(20) NOT NULL,
  `kd_dokterrad` varchar(20) NOT NULL,
  `kd_dokterhemodialisa` varchar(20) NOT NULL,
  `kd_dokterutd` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kd_dokterlab`,`kd_dokterrad`,`kd_dokterhemodialisa`),
  KEY `kd_dokterrad` (`kd_dokterrad`),
  KEY `kd_dokterhemodialisa` (`kd_dokterhemodialisa`),
  KEY `kd_dokterutd` (`kd_dokterutd`),
  KEY `kd_dokterlab` (`kd_dokterlab`),
  CONSTRAINT `set_pjlab_ibfk_1` FOREIGN KEY (`kd_dokterlab`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_pjlab_ibfk_2` FOREIGN KEY (`kd_dokterrad`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_pjlab_ibfk_3` FOREIGN KEY (`kd_dokterhemodialisa`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `set_pjlab_ibfk_4` FOREIGN KEY (`kd_dokterutd`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_resume` */

DROP TABLE IF EXISTS `set_resume`;

CREATE TABLE `set_resume` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_resume` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_service_ranap` */

DROP TABLE IF EXISTS `set_service_ranap`;

CREATE TABLE `set_service_ranap` (
  `nama_service` varchar(100) NOT NULL DEFAULT '',
  `besar` double DEFAULT NULL,
  `laborat` enum('Yes','No') DEFAULT NULL,
  `radiologi` enum('Yes','No') DEFAULT NULL,
  `operasi` enum('Yes','No') DEFAULT NULL,
  `obat` enum('Yes','No') DEFAULT NULL,
  `ranap_dokter` enum('Yes','No') DEFAULT NULL,
  `ranap_paramedis` enum('Yes','No') DEFAULT NULL,
  `ralan_dokter` enum('Yes','No') DEFAULT NULL,
  `ralan_paramedis` enum('Yes','No') DEFAULT NULL,
  `tambahan` enum('Yes','No') DEFAULT NULL,
  `potongan` enum('Yes','No') DEFAULT NULL,
  `kamar` enum('Yes','No') DEFAULT NULL,
  `registrasi` enum('Yes','No') DEFAULT NULL,
  `harian` enum('Yes','No') DEFAULT NULL,
  `retur_Obat` enum('Yes','No') DEFAULT NULL,
  `resep_Pulang` enum('Yes','No') DEFAULT NULL,
  PRIMARY KEY (`nama_service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_service_ranap_piutang` */

DROP TABLE IF EXISTS `set_service_ranap_piutang`;

CREATE TABLE `set_service_ranap_piutang` (
  `nama_service` varchar(100) NOT NULL DEFAULT '',
  `besar` double DEFAULT NULL,
  `laborat` enum('Yes','No') DEFAULT NULL,
  `radiologi` enum('Yes','No') DEFAULT NULL,
  `operasi` enum('Yes','No') DEFAULT NULL,
  `obat` enum('Yes','No') DEFAULT NULL,
  `ranap_dokter` enum('Yes','No') DEFAULT NULL,
  `ranap_paramedis` enum('Yes','No') DEFAULT NULL,
  `ralan_dokter` enum('Yes','No') DEFAULT NULL,
  `ralan_paramedis` enum('Yes','No') DEFAULT NULL,
  `tambahan` enum('Yes','No') DEFAULT NULL,
  `potongan` enum('Yes','No') DEFAULT NULL,
  `kamar` enum('Yes','No') DEFAULT NULL,
  `registrasi` enum('Yes','No') DEFAULT NULL,
  `harian` enum('Yes','No') DEFAULT NULL,
  `retur_Obat` enum('Yes','No') DEFAULT NULL,
  `resep_Pulang` enum('Yes','No') DEFAULT NULL,
  PRIMARY KEY (`nama_service`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_tahun` */

DROP TABLE IF EXISTS `set_tahun`;

CREATE TABLE `set_tahun` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(2) NOT NULL,
  `jmlhr` int(11) NOT NULL,
  `jmllbr` int(11) NOT NULL,
  `normal` int(11) NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_tarif` */

DROP TABLE IF EXISTS `set_tarif`;

CREATE TABLE `set_tarif` (
  `poli_ralan` enum('Yes','No') NOT NULL,
  `cara_bayar_ralan` enum('Yes','No') NOT NULL,
  `ruang_ranap` enum('Yes','No') NOT NULL,
  `cara_bayar_ranap` enum('Yes','No') NOT NULL,
  `cara_bayar_lab` enum('Yes','No') NOT NULL,
  `cara_bayar_radiologi` enum('Yes','No') NOT NULL,
  `cara_bayar_operasi` enum('Yes','No') DEFAULT NULL,
  `kelas_ranap` enum('Yes','No') NOT NULL,
  `kelas_lab` enum('Yes','No') NOT NULL,
  `kelas_radiologi` enum('Yes','No') NOT NULL,
  `kelas_operasi` enum('Yes','No') NOT NULL,
  KEY `poli_ralan` (`poli_ralan`,`cara_bayar_ralan`,`ruang_ranap`,`cara_bayar_ranap`,`cara_bayar_lab`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_tarif_online` */

DROP TABLE IF EXISTS `set_tarif_online`;

CREATE TABLE `set_tarif_online` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  PRIMARY KEY (`kd_jenis_prw`),
  CONSTRAINT `set_tarif_online_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_tni_polri` */

DROP TABLE IF EXISTS `set_tni_polri`;

CREATE TABLE `set_tni_polri` (
  `tampilkan_tni_polri` enum('Yes','No') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_tnjanak` */

DROP TABLE IF EXISTS `set_tnjanak`;

CREATE TABLE `set_tnjanak` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_tnjnikah` */

DROP TABLE IF EXISTS `set_tnjnikah`;

CREATE TABLE `set_tnjnikah` (
  `tnj` double NOT NULL,
  PRIMARY KEY (`tnj`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_tuslah` */

DROP TABLE IF EXISTS `set_tuslah`;

CREATE TABLE `set_tuslah` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_tuslah` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_urut_no_rkm_medis` */

DROP TABLE IF EXISTS `set_urut_no_rkm_medis`;

CREATE TABLE `set_urut_no_rkm_medis` (
  `urutan` enum('Straight','Middle','Terminal') NOT NULL,
  `tahun` enum('Yes','No') NOT NULL,
  `bulan` enum('Yes','No') NOT NULL,
  `posisi_tahun_bulan` enum('Depan','Belakang') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `set_validasi_catatan` */

DROP TABLE IF EXISTS `set_validasi_catatan`;

CREATE TABLE `set_validasi_catatan` (
  `tampilkan_catatan` enum('Yes','No') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_validasi_registrasi` */

DROP TABLE IF EXISTS `set_validasi_registrasi`;

CREATE TABLE `set_validasi_registrasi` (
  `wajib_closing_kasir` enum('Yes','No') DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `set_warung` */

DROP TABLE IF EXISTS `set_warung`;

CREATE TABLE `set_warung` (
  `tahun` year(4) NOT NULL,
  `bulan` tinyint(4) NOT NULL,
  `pendapatan_warung` double NOT NULL,
  `persen_rs` double NOT NULL,
  `bagian_rs` double NOT NULL,
  `persen_kry` double NOT NULL,
  `bagian_kry` double NOT NULL,
  PRIMARY KEY (`tahun`,`bulan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `setpenjualan` */

DROP TABLE IF EXISTS `setpenjualan`;

CREATE TABLE `setpenjualan` (
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL,
  `kdjns` char(4) NOT NULL,
  PRIMARY KEY (`kdjns`),
  KEY `kdjns` (`kdjns`),
  CONSTRAINT `setpenjualan_ibfk_1` FOREIGN KEY (`kdjns`) REFERENCES `jenis` (`kdjns`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `setpenjualanperbarang` */

DROP TABLE IF EXISTS `setpenjualanperbarang`;

CREATE TABLE `setpenjualanperbarang` (
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL,
  `kode_brng` varchar(15) NOT NULL,
  PRIMARY KEY (`kode_brng`),
  CONSTRAINT `setpenjualanperbarang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `setpenjualanumum` */

DROP TABLE IF EXISTS `setpenjualanumum`;

CREATE TABLE `setpenjualanumum` (
  `ralan` double DEFAULT NULL,
  `kelas1` double DEFAULT NULL,
  `kelas2` double DEFAULT NULL,
  `kelas3` double DEFAULT NULL,
  `utama` double DEFAULT NULL,
  `vip` double DEFAULT NULL,
  `vvip` double DEFAULT NULL,
  `beliluar` double DEFAULT NULL,
  `jualbebas` double DEFAULT NULL,
  `karyawan` double DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `setsms` */

DROP TABLE IF EXISTS `setsms`;

CREATE TABLE `setsms` (
  `kode_sms` varchar(200) NOT NULL DEFAULT '',
  `sintax_balasan` text DEFAULT NULL,
  PRIMARY KEY (`kode_sms`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `setting` */

DROP TABLE IF EXISTS `setting`;

CREATE TABLE `setting` (
  `nama_instansi` varchar(60) NOT NULL DEFAULT '',
  `alamat_instansi` varchar(150) DEFAULT NULL,
  `kabupaten` varchar(30) DEFAULT NULL,
  `propinsi` varchar(30) DEFAULT NULL,
  `kontak` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `aktifkan` enum('Yes','No') NOT NULL,
  `kode_ppk` varchar(15) DEFAULT NULL,
  `kode_ppkinhealth` varchar(15) DEFAULT NULL,
  `kode_ppkkemenkes` varchar(15) DEFAULT NULL,
  `wallpaper` longblob DEFAULT NULL,
  `logo` longblob NOT NULL,
  PRIMARY KEY (`nama_instansi`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sidikjari` */

DROP TABLE IF EXISTS `sidikjari`;

CREATE TABLE `sidikjari` (
  `id` int(11) NOT NULL,
  `sidikjari` text NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `sidikjari_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sidikjaripasien` */

DROP TABLE IF EXISTS `sidikjaripasien`;

CREATE TABLE `sidikjaripasien` (
  `no_rkm_medis` varchar(15) NOT NULL,
  `sidikjari` text NOT NULL,
  PRIMARY KEY (`no_rkm_medis`),
  CONSTRAINT `sidikjaripasien_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `siranap_ketersediaan_kamar` */

DROP TABLE IF EXISTS `siranap_ketersediaan_kamar`;

CREATE TABLE `siranap_ketersediaan_kamar` (
  `kode_ruang_siranap` enum('0000 Umum','0001 Anak','0002 Anak (Luka Bakar)','0003 Penyakit Dalam','0004 Kebidanan','0005 Kandungan','0006 Bedah','0007 Kanker','0008 Mata','0009 THT','0010 Paru','0011 Jantung','0012 Orthopedi','0013 Kulit dan Kelamin','0014 Saraf','0015 Jiwa','0016 Infeksi','0017 Luka Bakar','0018 NAPZA','0019 Isolasi Air Borne','0020 Isolasi TB MDR','0021 Kulit dan Kelamin','0022 Isolasi Imunitas menurun','0023 Isolasi Radioaktif','0024 ICU/RICU','0025 NICU','0026 PICU','0027 CVCU/ICCU','0029 HCU','0030 Kedokteran Nuklir') NOT NULL,
  `kelas_ruang_siranap` enum('0001 Super VIP','0002 VIP','0003 Kelas 1','0004 Kelas 2','0005 Kelas 3','0006 Intermediate','0007 Isolasi','0008 Rawat Khusus','0009 Stroke Care Unit') NOT NULL,
  `kd_bangsal` char(5) NOT NULL DEFAULT '',
  `kelas` enum('Kelas 1','Kelas 2','Kelas 3','Kelas Utama','Kelas VIP','Kelas VVIP') NOT NULL DEFAULT 'Kelas 1',
  `kapasitas` int(11) DEFAULT NULL,
  `tersedia` int(11) DEFAULT NULL,
  `tersediapria` int(11) DEFAULT NULL,
  `tersediawanita` int(11) DEFAULT NULL,
  `menunggu` int(11) DEFAULT NULL,
  PRIMARY KEY (`kode_ruang_siranap`,`kelas_ruang_siranap`,`kd_bangsal`,`kelas`),
  KEY `kd_bangsal` (`kd_bangsal`),
  KEY `kapasitas` (`kapasitas`),
  KEY `tersedia` (`tersedia`),
  KEY `tersediapria` (`tersediapria`),
  KEY `tersediawanita` (`tersediawanita`),
  KEY `tersediapriawanita` (`menunggu`),
  CONSTRAINT `siranap_ketersediaan_kamar_ibfk_1` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sisrute_rujukan_keluar` */

DROP TABLE IF EXISTS `sisrute_rujukan_keluar`;

CREATE TABLE `sisrute_rujukan_keluar` (
  `no_rawat` varchar(17) NOT NULL,
  `no_rujuk` varchar(40) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `nm_pasien` varchar(40) NOT NULL,
  `no_ktp` varchar(20) NOT NULL,
  `no_peserta` varchar(25) NOT NULL,
  `jk` enum('L','P') NOT NULL,
  `tgl_lahir` date NOT NULL,
  `tmp_lahir` varchar(15) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `no_tlp` varchar(40) NOT NULL,
  `jns_rujukan` enum('1. Rawat Jalan','2. Rawat Darurat/Inap','3. Parsial') NOT NULL,
  `tgl_rujuk` datetime NOT NULL,
  `kd_faskes_tujuan` varchar(12) NOT NULL,
  `nm_faskes_tujuan` varchar(200) NOT NULL,
  `kd_alasan` varchar(5) NOT NULL,
  `alasan_rujuk` varchar(150) NOT NULL,
  `alasan_lainnya` varchar(50) NOT NULL,
  `kd_diagnosa` varchar(10) NOT NULL,
  `diagnosa_rujuk` text NOT NULL,
  `nik_dokter` varchar(20) NOT NULL,
  `dokter_perujuk` varchar(50) NOT NULL,
  `nik_petugas` varchar(20) NOT NULL,
  `petugas_entry` varchar(50) NOT NULL,
  `anamnesis_pemeriksaan` text NOT NULL,
  `kesadaran` enum('1. Sadar','2. Tidak Sadar') NOT NULL,
  `tekanan_darah` varchar(7) NOT NULL,
  `nadi` varchar(3) NOT NULL,
  `suhu` varchar(5) NOT NULL,
  `respirasi` varchar(3) NOT NULL,
  `keadaan_umum` text NOT NULL,
  `tingkat_nyeri` enum('0. Tidak Nyeri','1. Ringan','2. Sedang','3. Berat') NOT NULL,
  `alergi` varchar(50) NOT NULL,
  `laboratorium` text NOT NULL,
  `radiologi` text NOT NULL,
  `terapitindakan` text NOT NULL,
  PRIMARY KEY (`no_rawat`),
  CONSTRAINT `sisrute_rujukan_keluar_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `skdp_bpjs` */

DROP TABLE IF EXISTS `skdp_bpjs`;

CREATE TABLE `skdp_bpjs` (
  `tahun` year(4) NOT NULL,
  `no_rkm_medis` varchar(15) DEFAULT NULL,
  `diagnosa` varchar(50) NOT NULL,
  `terapi` varchar(50) NOT NULL,
  `alasan1` varchar(50) DEFAULT NULL,
  `alasan2` varchar(50) DEFAULT NULL,
  `rtl1` varchar(50) DEFAULT NULL,
  `rtl2` varchar(50) DEFAULT NULL,
  `tanggal_datang` date DEFAULT NULL,
  `tanggal_rujukan` date NOT NULL,
  `no_antrian` varchar(6) NOT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `status` enum('Menunggu','Sudah Periksa','Batal Periksa') NOT NULL,
  PRIMARY KEY (`tahun`,`no_antrian`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `skdp_bpjs_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON UPDATE CASCADE,
  CONSTRAINT `skdp_bpjs_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `skrining_rawat_jalan` */

DROP TABLE IF EXISTS `skrining_rawat_jalan`;

CREATE TABLE `skrining_rawat_jalan` (
  `tanggal` date NOT NULL,
  `jam` time NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `geriatri` enum('Ya','Tidak') DEFAULT NULL,
  `kesadaran` enum('Sadar penuh','Tampak mengantuk/gelisah bicara tidak jelas','Tidak sadar','Batuk > 2 minggu') DEFAULT NULL,
  `pernapasan` enum('Nafas normal','Tampak sesak','Tidak bernafas') DEFAULT NULL,
  `nyeri_dada` enum('Tidak ada','Ada (Tingkat sedang)','Nyeri dada kiri tembus punggung') DEFAULT NULL,
  `skala_nyeri` enum('Tidak sakit','Sedikit sakit','Agak mengganggu','Mengganggu aktivitas','Sangat mengganggu','Tak tertahankan') DEFAULT NULL,
  `keputusan` enum('Sesuai antrian','IGD') DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`tanggal`,`jam`,`no_rkm_medis`),
  KEY `nip` (`nip`),
  KEY `no_rkm_medis` (`no_rkm_medis`),
  CONSTRAINT `skrining_rawat_jalan_ibfk_1` FOREIGN KEY (`no_rkm_medis`) REFERENCES `pasien` (`no_rkm_medis`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `skrining_rawat_jalan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sms` */

DROP TABLE IF EXISTS `sms`;

CREATE TABLE `sms` (
  `id_pesan` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sms_masuk` varchar(255) DEFAULT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `pdu_pesan` varchar(255) DEFAULT NULL,
  `encoding` varchar(20) DEFAULT NULL,
  `id_gateway` varchar(20) DEFAULT NULL,
  `tgl_sms` datetime DEFAULT NULL,
  PRIMARY KEY (`id_pesan`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `sms_autolist` */

DROP TABLE IF EXISTS `sms_autolist`;

CREATE TABLE `sms_autolist` (
  `phoneNumber` varchar(15) NOT NULL DEFAULT '',
  `id` int(11) NOT NULL DEFAULT 0,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`phoneNumber`,`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_autoresponder` */

DROP TABLE IF EXISTS `sms_autoresponder`;

CREATE TABLE `sms_autoresponder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` text DEFAULT NULL,
  `interv` int(11) DEFAULT NULL,
  `idgroup` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_data` */

DROP TABLE IF EXISTS `sms_data`;

CREATE TABLE `sms_data` (
  `keyword` varchar(20) NOT NULL DEFAULT '',
  `key` varchar(100) NOT NULL DEFAULT '',
  `field1` varchar(100) DEFAULT NULL,
  `field2` varchar(100) DEFAULT NULL,
  `field3` varchar(100) DEFAULT NULL,
  `field4` varchar(100) DEFAULT NULL,
  `field5` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`keyword`,`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_group` */

DROP TABLE IF EXISTS `sms_group`;

CREATE TABLE `sms_group` (
  `idgroup` int(11) NOT NULL AUTO_INCREMENT,
  `group` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idgroup`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_inbox` */

DROP TABLE IF EXISTS `sms_inbox`;

CREATE TABLE `sms_inbox` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` text DEFAULT NULL,
  `sender` varchar(20) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `flagRead` int(11) DEFAULT NULL,
  `flagReply` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_keyword` */

DROP TABLE IF EXISTS `sms_keyword`;

CREATE TABLE `sms_keyword` (
  `keyword` varchar(100) NOT NULL DEFAULT '',
  `template` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`keyword`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_message` */

DROP TABLE IF EXISTS `sms_message`;

CREATE TABLE `sms_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text DEFAULT NULL,
  `pubdate` datetime DEFAULT NULL,
  `status` int(11) NOT NULL,
  `idgroup` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_phonebook` */

DROP TABLE IF EXISTS `sms_phonebook`;

CREATE TABLE `sms_phonebook` (
  `noTelp` varchar(50) NOT NULL DEFAULT '',
  `nama` varchar(50) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `idgroup` int(11) DEFAULT NULL,
  `dateJoin` date DEFAULT NULL,
  PRIMARY KEY (`noTelp`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `sms_sentmsg` */

DROP TABLE IF EXISTS `sms_sentmsg`;

CREATE TABLE `sms_sentmsg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `msg` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

/*Table structure for table `spesialis` */

DROP TABLE IF EXISTS `spesialis`;

CREATE TABLE `spesialis` (
  `kd_sps` char(5) NOT NULL DEFAULT '',
  `nm_sps` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`kd_sps`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `stok_obat_pasien` */

DROP TABLE IF EXISTS `stok_obat_pasien`;

CREATE TABLE `stok_obat_pasien` (
  `tanggal` date NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL,
  `jumlah` double NOT NULL,
  `kd_bangsal` char(5) NOT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`tanggal`,`no_rawat`,`kode_brng`,`no_batch`,`no_faktur`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kd_bangsal` (`kd_bangsal`),
  CONSTRAINT `stok_obat_pasien_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stok_obat_pasien_ibfk_3` FOREIGN KEY (`kd_bangsal`) REFERENCES `bangsal` (`kd_bangsal`) ON UPDATE CASCADE,
  CONSTRAINT `stok_obat_pasien_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `stts_kerja` */

DROP TABLE IF EXISTS `stts_kerja`;

CREATE TABLE `stts_kerja` (
  `stts` char(3) NOT NULL,
  `ktg` varchar(20) NOT NULL,
  `indek` tinyint(4) NOT NULL,
  PRIMARY KEY (`stts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `stts_wp` */

DROP TABLE IF EXISTS `stts_wp`;

CREATE TABLE `stts_wp` (
  `stts` char(5) NOT NULL,
  `ktg` varchar(50) NOT NULL,
  PRIMARY KEY (`stts`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `subrekening` */

DROP TABLE IF EXISTS `subrekening`;

CREATE TABLE `subrekening` (
  `kd_rek` varchar(15) NOT NULL,
  `kd_rek2` varchar(15) NOT NULL,
  PRIMARY KEY (`kd_rek2`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `subrekening_ibfk_1` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `subrekening_ibfk_2` FOREIGN KEY (`kd_rek2`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `suku_bangsa` */

DROP TABLE IF EXISTS `suku_bangsa`;

CREATE TABLE `suku_bangsa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nama_suku_bangsa` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama_suku_bangsa` (`nama_suku_bangsa`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;

/*Table structure for table `surat_balas` */

DROP TABLE IF EXISTS `surat_balas`;

CREATE TABLE `surat_balas` (
  `kd` varchar(5) NOT NULL,
  `balas` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_hamil` */

DROP TABLE IF EXISTS `surat_hamil`;

CREATE TABLE `surat_hamil` (
  `no_surat` varchar(20) NOT NULL,
  `no_rawat` varchar(17) NOT NULL,
  `tanggalperiksa` date NOT NULL,
  `hasilperiksa` enum('tidak ditemukan tanda-tanda kehamilan','ditemukan tanda-tanda kehamilan') NOT NULL,
  PRIMARY KEY (`no_surat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `surat_hamil_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_indeks` */

DROP TABLE IF EXISTS `surat_indeks`;

CREATE TABLE `surat_indeks` (
  `kd` varchar(5) NOT NULL,
  `indeks` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_keluar` */

DROP TABLE IF EXISTS `surat_keluar`;

CREATE TABLE `surat_keluar` (
  `no_urut` varchar(15) NOT NULL,
  `no_surat` varchar(50) NOT NULL,
  `tujuan` varchar(300) NOT NULL,
  `tgl_surat` date NOT NULL,
  `perihal` varchar(300) NOT NULL,
  `tgl_kirim` date NOT NULL,
  `kd_lemari` varchar(5) NOT NULL,
  `kd_rak` varchar(5) NOT NULL,
  `kd_map` varchar(5) NOT NULL,
  `kd_ruang` varchar(5) NOT NULL,
  `kd_sifat` varchar(5) NOT NULL,
  `lampiran` varchar(300) NOT NULL,
  `tembusan` varchar(300) NOT NULL,
  `tgl_deadline_balas` date NOT NULL,
  `kd_balas` varchar(5) NOT NULL,
  `keterangan` varchar(300) NOT NULL,
  `kd_status` varchar(5) NOT NULL,
  `kd_klasifikasi` varchar(5) NOT NULL,
  `file_url` varchar(500) NOT NULL,
  PRIMARY KEY (`no_urut`),
  KEY `kd_lemari` (`kd_lemari`),
  KEY `kd_rak` (`kd_rak`),
  KEY `kd_map` (`kd_map`),
  KEY `kd_ruang` (`kd_ruang`),
  KEY `kd_sifat` (`kd_sifat`),
  KEY `kd_balas` (`kd_balas`),
  KEY `kd_status` (`kd_status`),
  KEY `kd_klasifikasi` (`kd_klasifikasi`),
  CONSTRAINT `surat_keluar_ibfk_1` FOREIGN KEY (`kd_lemari`) REFERENCES `surat_lemari` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_10` FOREIGN KEY (`kd_rak`) REFERENCES `surat_rak` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_11` FOREIGN KEY (`kd_map`) REFERENCES `surat_map` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_12` FOREIGN KEY (`kd_ruang`) REFERENCES `surat_ruang` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_13` FOREIGN KEY (`kd_sifat`) REFERENCES `surat_sifat` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_14` FOREIGN KEY (`kd_balas`) REFERENCES `surat_balas` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_15` FOREIGN KEY (`kd_status`) REFERENCES `surat_status` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_16` FOREIGN KEY (`kd_klasifikasi`) REFERENCES `surat_klasifikasi` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_2` FOREIGN KEY (`kd_rak`) REFERENCES `surat_rak` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_3` FOREIGN KEY (`kd_map`) REFERENCES `surat_map` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_4` FOREIGN KEY (`kd_ruang`) REFERENCES `surat_ruang` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_5` FOREIGN KEY (`kd_sifat`) REFERENCES `surat_sifat` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_6` FOREIGN KEY (`kd_balas`) REFERENCES `surat_balas` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_7` FOREIGN KEY (`kd_status`) REFERENCES `surat_status` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_8` FOREIGN KEY (`kd_klasifikasi`) REFERENCES `surat_klasifikasi` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_ibfk_9` FOREIGN KEY (`kd_lemari`) REFERENCES `surat_lemari` (`kd`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_keluar_disposisi` */

DROP TABLE IF EXISTS `surat_keluar_disposisi`;

CREATE TABLE `surat_keluar_disposisi` (
  `no_disposisi` varchar(15) NOT NULL,
  `kd_indeks` varchar(5) NOT NULL,
  `no_urut` varchar(15) NOT NULL,
  `tgl_selesai` date NOT NULL,
  `isi` varchar(300) NOT NULL,
  `diteruskan` varchar(300) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kepada` varchar(100) NOT NULL,
  `pengesahan` enum('true','false') NOT NULL,
  `harap` varchar(300) NOT NULL,
  `catatan` varchar(300) NOT NULL,
  PRIMARY KEY (`no_disposisi`),
  KEY `kd_indeks` (`kd_indeks`),
  KEY `no_urut` (`no_urut`),
  CONSTRAINT `surat_keluar_disposisi_ibfk_1` FOREIGN KEY (`kd_indeks`) REFERENCES `surat_indeks` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_disposisi_ibfk_2` FOREIGN KEY (`no_urut`) REFERENCES `surat_keluar` (`no_urut`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_keluar_kendali` */

DROP TABLE IF EXISTS `surat_keluar_kendali`;

CREATE TABLE `surat_keluar_kendali` (
  `no_kendali` varchar(15) NOT NULL,
  `kd_indeks` varchar(5) NOT NULL,
  `no_urut` varchar(5) NOT NULL,
  `tgl_selesai` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kepada` varchar(100) NOT NULL,
  PRIMARY KEY (`no_kendali`),
  KEY `no_surat` (`no_urut`),
  KEY `kd_indeks` (`kd_indeks`),
  CONSTRAINT `surat_keluar_kendali_ibfk_1` FOREIGN KEY (`kd_indeks`) REFERENCES `surat_indeks` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_keluar_kendali_ibfk_2` FOREIGN KEY (`no_urut`) REFERENCES `surat_keluar` (`no_urut`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_keluar_set_nomor` */

DROP TABLE IF EXISTS `surat_keluar_set_nomor`;

CREATE TABLE `surat_keluar_set_nomor` (
  `id_no_surat` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_surat` varchar(100) NOT NULL,
  `digit_1` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_2` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_3` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_4` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_5` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_6` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_7` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_8` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_9` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_10` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_11` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_12` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_13` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_14` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  `digit_15` enum('No Urut Bulanan','No Urut Tahunan','Kode Klasifikasi Surat','Kode Sub Klasifikasi Surat','Tanggal Angka','Tanggal Romawi','Bulan Angka','Bulan Romawi','Tahun','Pemisah (-)','Pemisah (/)','Pemisah (.)','') DEFAULT NULL,
  PRIMARY KEY (`id_no_surat`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `surat_keterangan_covid` */

DROP TABLE IF EXISTS `surat_keterangan_covid`;

CREATE TABLE `surat_keterangan_covid` (
  `no_surat` varchar(17) NOT NULL,
  `no_rawat` varchar(17) DEFAULT NULL,
  `kd_dokter` varchar(20) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `igm` enum('REAKTIF','NON REAKTIF') DEFAULT NULL,
  `igg` enum('REAKTIF','NON REAKTIF') DEFAULT NULL,
  `sehat` enum('X','V') DEFAULT NULL,
  `tidaksehat` enum('X','V') DEFAULT NULL,
  `berlakumulai` date DEFAULT NULL,
  `berlakuselsai` date DEFAULT NULL,
  PRIMARY KEY (`no_surat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`kd_dokter`),
  KEY `nip` (`nip`),
  CONSTRAINT `surat_keterangan_covid_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surat_keterangan_covid_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surat_keterangan_covid_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_klasifikasi` */

DROP TABLE IF EXISTS `surat_klasifikasi`;

CREATE TABLE `surat_klasifikasi` (
  `kd` varchar(5) NOT NULL,
  `klasifikasi` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_lemari` */

DROP TABLE IF EXISTS `surat_lemari`;

CREATE TABLE `surat_lemari` (
  `kd` varchar(5) NOT NULL,
  `lemari` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_map` */

DROP TABLE IF EXISTS `surat_map`;

CREATE TABLE `surat_map` (
  `kd` varchar(5) NOT NULL,
  `map` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_masuk` */

DROP TABLE IF EXISTS `surat_masuk`;

CREATE TABLE `surat_masuk` (
  `no_urut` varchar(15) NOT NULL,
  `no_surat` varchar(50) NOT NULL,
  `asal` varchar(300) NOT NULL,
  `tujuan` varchar(300) NOT NULL,
  `tgl_surat` date NOT NULL,
  `perihal` varchar(300) NOT NULL,
  `tgl_terima` date NOT NULL,
  `kd_lemari` varchar(5) NOT NULL,
  `kd_rak` varchar(5) NOT NULL,
  `kd_map` varchar(5) NOT NULL,
  `kd_ruang` varchar(5) NOT NULL,
  `kd_sifat` varchar(5) NOT NULL,
  `lampiran` varchar(300) NOT NULL,
  `tembusan` varchar(300) NOT NULL,
  `tgl_deadline_balas` date NOT NULL,
  `kd_balas` varchar(5) NOT NULL,
  `keterangan` varchar(300) NOT NULL,
  `kd_status` varchar(5) NOT NULL,
  `kd_klasifikasi` varchar(5) NOT NULL,
  `file_url` varchar(500) NOT NULL,
  PRIMARY KEY (`no_urut`),
  KEY `kd_lemari` (`kd_lemari`),
  KEY `kd_rak` (`kd_rak`),
  KEY `kd_map` (`kd_map`),
  KEY `kd_ruang` (`kd_ruang`),
  KEY `kd_sifat` (`kd_sifat`),
  KEY `kd_balas` (`kd_balas`),
  KEY `kd_status` (`kd_status`),
  KEY `kd_klasifikasi` (`kd_klasifikasi`),
  CONSTRAINT `surat_masuk_ibfk_1` FOREIGN KEY (`kd_lemari`) REFERENCES `surat_lemari` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_2` FOREIGN KEY (`kd_rak`) REFERENCES `surat_rak` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_3` FOREIGN KEY (`kd_map`) REFERENCES `surat_map` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_4` FOREIGN KEY (`kd_ruang`) REFERENCES `surat_ruang` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_5` FOREIGN KEY (`kd_sifat`) REFERENCES `surat_sifat` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_6` FOREIGN KEY (`kd_balas`) REFERENCES `surat_balas` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_7` FOREIGN KEY (`kd_status`) REFERENCES `surat_status` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_ibfk_8` FOREIGN KEY (`kd_klasifikasi`) REFERENCES `surat_klasifikasi` (`kd`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_masuk_disposisi` */

DROP TABLE IF EXISTS `surat_masuk_disposisi`;

CREATE TABLE `surat_masuk_disposisi` (
  `no_disposisi` varchar(15) NOT NULL,
  `kd_indeks` varchar(5) NOT NULL,
  `no_urut` varchar(15) NOT NULL,
  `tgl_selesai` date NOT NULL,
  `isi` varchar(300) NOT NULL,
  `diteruskan` varchar(300) NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kepada` varchar(100) NOT NULL,
  `pengesahan` enum('true','false') NOT NULL,
  `harap` varchar(300) NOT NULL,
  `catatan` varchar(300) NOT NULL,
  PRIMARY KEY (`no_disposisi`),
  KEY `kd_indeks` (`kd_indeks`),
  KEY `no_urut` (`no_urut`),
  CONSTRAINT `surat_masuk_disposisi_ibfk_1` FOREIGN KEY (`kd_indeks`) REFERENCES `surat_indeks` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_disposisi_ibfk_2` FOREIGN KEY (`no_urut`) REFERENCES `surat_masuk` (`no_urut`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_masuk_kendali` */

DROP TABLE IF EXISTS `surat_masuk_kendali`;

CREATE TABLE `surat_masuk_kendali` (
  `no_kendali` varchar(15) NOT NULL,
  `kd_indeks` varchar(5) NOT NULL,
  `no_urut` varchar(5) NOT NULL,
  `tgl_selesai` date NOT NULL,
  `tgl_kembali` date NOT NULL,
  `kepada` varchar(100) NOT NULL,
  `pengesahan` enum('true','false') NOT NULL,
  PRIMARY KEY (`no_kendali`),
  KEY `no_surat` (`no_urut`),
  KEY `kd_indeks` (`kd_indeks`),
  CONSTRAINT `surat_masuk_kendali_ibfk_1` FOREIGN KEY (`kd_indeks`) REFERENCES `surat_indeks` (`kd`) ON UPDATE CASCADE,
  CONSTRAINT `surat_masuk_kendali_ibfk_2` FOREIGN KEY (`no_urut`) REFERENCES `surat_masuk` (`no_urut`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_pemesanan_medis` */

DROP TABLE IF EXISTS `surat_pemesanan_medis`;

CREATE TABLE `surat_pemesanan_medis` (
  `no_pemesanan` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double DEFAULT NULL,
  `status` enum('Proses Pesan','Sudah Datang') DEFAULT NULL,
  PRIMARY KEY (`no_pemesanan`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `surat_pemesanan_medis_ibfk_2` (`nip`),
  CONSTRAINT `surat_pemesanan_medis_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `datasuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surat_pemesanan_medis_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_pemesanan_non_medis` */

DROP TABLE IF EXISTS `surat_pemesanan_non_medis`;

CREATE TABLE `surat_pemesanan_non_medis` (
  `no_pemesanan` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `subtotal` double NOT NULL,
  `potongan` double NOT NULL,
  `total` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double DEFAULT NULL,
  `status` enum('Proses Pesan','Sudah Datang') DEFAULT NULL,
  PRIMARY KEY (`no_pemesanan`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  CONSTRAINT `surat_pemesanan_non_medis_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `ipsrssuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surat_pemesanan_non_medis_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_rak` */

DROP TABLE IF EXISTS `surat_rak`;

CREATE TABLE `surat_rak` (
  `kd` varchar(5) NOT NULL,
  `rak` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_ruang` */

DROP TABLE IF EXISTS `surat_ruang`;

CREATE TABLE `surat_ruang` (
  `kd` varchar(5) NOT NULL,
  `ruang` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_sifat` */

DROP TABLE IF EXISTS `surat_sifat`;

CREATE TABLE `surat_sifat` (
  `kd` varchar(5) NOT NULL,
  `sifat` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_skbn` */

DROP TABLE IF EXISTS `surat_skbn`;

CREATE TABLE `surat_skbn` (
  `no_surat` varchar(25) NOT NULL,
  `no_rawat` varchar(17) DEFAULT '',
  `tanggalsurat` date DEFAULT NULL,
  `kategori` enum('UMUM','POLRI','TNI') DEFAULT 'UMUM',
  `kd_dokter` varchar(20) DEFAULT '',
  `keperluan` varchar(50) DEFAULT '',
  `opiat` enum('NEGATIF','POSITIF') DEFAULT 'NEGATIF',
  `ganja` enum('NEGATIF','POSITIF') DEFAULT 'NEGATIF',
  `amphetamin` enum('NEGATIF','POSITIF') DEFAULT 'NEGATIF',
  `methamphetamin` enum('NEGATIF','POSITIF') DEFAULT 'NEGATIF',
  `benzodiazepin` enum('NEGATIF','POSITIF') DEFAULT 'NEGATIF',
  `cocain` enum('NEGATIF','POSITIF') DEFAULT 'NEGATIF',
  PRIMARY KEY (`no_surat`),
  KEY `no_rawat` (`no_rawat`),
  KEY `kd_dokter` (`kd_dokter`),
  CONSTRAINT `surat_skbn_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `surat_skbn_ibfk_2` FOREIGN KEY (`kd_dokter`) REFERENCES `dokter` (`kd_dokter`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_status` */

DROP TABLE IF EXISTS `surat_status`;

CREATE TABLE `surat_status` (
  `kd` varchar(5) NOT NULL,
  `status` varchar(50) NOT NULL,
  PRIMARY KEY (`kd`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `surat_sub_klasifikasi` */

DROP TABLE IF EXISTS `surat_sub_klasifikasi`;

CREATE TABLE `surat_sub_klasifikasi` (
  `kd` varchar(10) NOT NULL,
  `kd_klasifikasi` varchar(5) NOT NULL,
  `sub_klasifikasi` varchar(50) NOT NULL,
  `no_bulanan` int(11) DEFAULT NULL,
  `no_tahunan` int(11) DEFAULT NULL,
  `bulan` int(11) NOT NULL,
  `tahun` int(11) NOT NULL,
  PRIMARY KEY (`kd`),
  KEY `surat_sub_klasifikasi_ibfk_1` (`kd_klasifikasi`),
  CONSTRAINT `surat_sub_klasifikasi_ibfk_1` FOREIGN KEY (`kd_klasifikasi`) REFERENCES `surat_klasifikasi` (`kd`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `suratsakit` */

DROP TABLE IF EXISTS `suratsakit`;

CREATE TABLE `suratsakit` (
  `no_surat` varchar(17) NOT NULL,
  `no_rawat` varchar(17) DEFAULT NULL,
  `tanggalawal` date DEFAULT NULL,
  `tanggalakhir` date DEFAULT NULL,
  `lamasakit` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_surat`),
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `suratsakit_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `survei` */

DROP TABLE IF EXISTS `survei`;

CREATE TABLE `survei` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `tagihan_obat_langsung` */

DROP TABLE IF EXISTS `tagihan_obat_langsung`;

CREATE TABLE `tagihan_obat_langsung` (
  `no_rawat` varchar(17) NOT NULL,
  `besar_tagihan` double NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  CONSTRAINT `tagihan_obat_langsung_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tagihan_sadewa` */

DROP TABLE IF EXISTS `tagihan_sadewa`;

CREATE TABLE `tagihan_sadewa` (
  `no_nota` varchar(17) NOT NULL,
  `no_rkm_medis` varchar(15) NOT NULL,
  `nama_pasien` varchar(60) NOT NULL,
  `alamat` varchar(200) NOT NULL,
  `tgl_bayar` datetime NOT NULL,
  `jenis_bayar` enum('Pelunasan','Deposit','Cicilan','Uang Muka') NOT NULL,
  `jumlah_tagihan` double NOT NULL,
  `jumlah_bayar` double NOT NULL,
  `status` enum('Sudah','Belum') NOT NULL,
  `petugas` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_nota`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tambahan_biaya` */

DROP TABLE IF EXISTS `tambahan_biaya`;

CREATE TABLE `tambahan_biaya` (
  `no_rawat` varchar(17) NOT NULL,
  `nama_biaya` varchar(60) NOT NULL,
  `besar_biaya` double NOT NULL,
  PRIMARY KEY (`no_rawat`,`nama_biaya`),
  CONSTRAINT `tambahan_biaya_ibfk_1` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tambahanpotongan` */

DROP TABLE IF EXISTS `tambahanpotongan`;

CREATE TABLE `tambahanpotongan` (
  `indexins` char(4) NOT NULL,
  `potongan` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tambahjaga` */

DROP TABLE IF EXISTS `tambahjaga`;

CREATE TABLE `tambahjaga` (
  `tgl` date NOT NULL,
  `id` int(11) NOT NULL,
  `jml` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`),
  KEY `id` (`id`),
  CONSTRAINT `tambahjaga_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tampbeli1` */

DROP TABLE IF EXISTS `tampbeli1`;

CREATE TABLE `tampbeli1` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `satuan_stok` varchar(10) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `jumlah_stok` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampbeli1_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tampjual1` */

DROP TABLE IF EXISTS `tampjual1`;

CREATE TABLE `tampjual1` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double NOT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampjual1_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tampjurnal` */

DROP TABLE IF EXISTS `tampjurnal`;

CREATE TABLE `tampjurnal` (
  `kd_rek` char(15) NOT NULL,
  `nm_rek` varchar(100) DEFAULT NULL,
  `debet` double DEFAULT NULL,
  `kredit` double DEFAULT NULL,
  PRIMARY KEY (`kd_rek`),
  KEY `nm_rek` (`nm_rek`),
  KEY `debet` (`debet`),
  KEY `kredit` (`kredit`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tamppiutang` */

DROP TABLE IF EXISTS `tamppiutang`;

CREATE TABLE `tamppiutang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(50) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `petugas` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `aturan_pakai` varchar(150) NOT NULL,
  PRIMARY KEY (`kode_brng`,`no_batch`,`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tamppiutang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tampreturbeli` */

DROP TABLE IF EXISTS `tampreturbeli`;

CREATE TABLE `tampreturbeli` (
  `no_faktur` varchar(20) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jml_beli` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `jml_retur2` double DEFAULT NULL,
  `kadaluarsa` varchar(14) NOT NULL,
  `petugas` varchar(20) NOT NULL,
  PRIMARY KEY (`no_faktur`,`kode_brng`),
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampreturbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tampreturjual` */

DROP TABLE IF EXISTS `tampreturjual`;

CREATE TABLE `tampreturjual` (
  `nota_jual` varchar(20) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `jml_jual` double DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `petugas` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`nota_jual`,`kode_brng`,`no_batch`,`no_faktur`),
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampreturjual_ibfk_3` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tampreturpiutang` */

DROP TABLE IF EXISTS `tampreturpiutang`;

CREATE TABLE `tampreturpiutang` (
  `nota_piutang` varchar(20) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `nama_brng` varchar(100) DEFAULT NULL,
  `jml_piutang` double DEFAULT NULL,
  `h_piutang` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `petugas` varchar(20) DEFAULT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`nota_piutang`,`kode_brng`,`no_batch`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tampreturpiutang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `template_laboratorium` */

DROP TABLE IF EXISTS `template_laboratorium`;

CREATE TABLE `template_laboratorium` (
  `kd_jenis_prw` varchar(15) NOT NULL,
  `id_template` int(11) NOT NULL AUTO_INCREMENT,
  `Pemeriksaan` varchar(200) NOT NULL,
  `satuan` varchar(20) NOT NULL,
  `nilai_rujukan_ld` varchar(60) NOT NULL,
  `nilai_rujukan_la` varchar(60) NOT NULL,
  `nilai_rujukan_pd` varchar(60) NOT NULL,
  `nilai_rujukan_pa` varchar(60) NOT NULL,
  `bagian_rs` double NOT NULL,
  `bhp` double NOT NULL,
  `bagian_perujuk` double NOT NULL,
  `bagian_dokter` double NOT NULL,
  `bagian_laborat` double NOT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_item` double NOT NULL,
  `urut` int(4) DEFAULT NULL,
  PRIMARY KEY (`id_template`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  KEY `Pemeriksaan` (`Pemeriksaan`),
  KEY `satuan` (`satuan`),
  KEY `nilai_rujukan_ld` (`nilai_rujukan_ld`),
  KEY `nilai_rujukan_la` (`nilai_rujukan_la`),
  KEY `nilai_rujukan_pd` (`nilai_rujukan_pd`),
  KEY `nilai_rujukan_pa` (`nilai_rujukan_pa`),
  KEY `bagian_rs` (`bagian_rs`),
  KEY `bhp` (`bhp`),
  KEY `bagian_perujuk` (`bagian_perujuk`),
  KEY `bagian_dokter` (`bagian_dokter`),
  KEY `bagian_laborat` (`bagian_laborat`),
  KEY `kso` (`kso`),
  KEY `menejemen` (`menejemen`),
  KEY `biaya_item` (`biaya_item`),
  KEY `urut` (`urut`),
  CONSTRAINT `template_laboratorium_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_lab` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1335 DEFAULT CHARSET=latin1;

/*Table structure for table `template_utd` */

DROP TABLE IF EXISTS `template_utd`;

CREATE TABLE `template_utd` (
  `kd_jenis_prw` varchar(15) DEFAULT NULL,
  `id_template` int(11) NOT NULL AUTO_INCREMENT,
  `pemeriksaan` varchar(200) DEFAULT NULL,
  `nilai_rujukan` varchar(30) NOT NULL,
  `bagian_rs` double DEFAULT NULL,
  `bhp` double DEFAULT NULL,
  `bagian_perujuk` double DEFAULT NULL,
  `bagian_dokter` double DEFAULT NULL,
  `petugas_utd` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `menejemen` double DEFAULT NULL,
  `biaya_item` double DEFAULT NULL,
  `urut` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id_template`),
  KEY `kd_jenis_prw` (`kd_jenis_prw`),
  CONSTRAINT `template_utd_ibfk_1` FOREIGN KEY (`kd_jenis_prw`) REFERENCES `jns_perawatan_utd` (`kd_jenis_prw`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary` */

DROP TABLE IF EXISTS `temporary`;

CREATE TABLE `temporary` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary2` */

DROP TABLE IF EXISTS `temporary2`;

CREATE TABLE `temporary2` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(100) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  `temp38` varchar(100) NOT NULL,
  `temp39` varchar(100) NOT NULL,
  `temp40` varchar(100) NOT NULL,
  `temp41` varchar(100) NOT NULL,
  `temp42` varchar(100) NOT NULL,
  `temp43` varchar(100) NOT NULL,
  `temp44` varchar(100) NOT NULL,
  `temp45` varchar(100) NOT NULL,
  `temp46` varchar(100) NOT NULL,
  `temp47` varchar(100) NOT NULL,
  `temp48` varchar(100) NOT NULL,
  `temp49` varchar(100) NOT NULL,
  `temp50` varchar(100) NOT NULL,
  `temp51` varchar(100) NOT NULL,
  `temp52` varchar(100) NOT NULL,
  `temp53` varchar(100) NOT NULL,
  `temp54` varchar(100) NOT NULL,
  `temp55` varchar(100) NOT NULL,
  `temp56` varchar(100) NOT NULL,
  `temp57` varchar(100) NOT NULL,
  `temp58` varchar(100) NOT NULL,
  `temp59` varchar(100) NOT NULL,
  `temp60` varchar(100) NOT NULL,
  `temp61` varchar(100) NOT NULL,
  `temp62` varchar(100) NOT NULL,
  `temp63` varchar(100) NOT NULL,
  `temp64` varchar(100) NOT NULL,
  `temp65` varchar(100) NOT NULL,
  `temp66` varchar(100) NOT NULL,
  `temp67` varchar(100) NOT NULL,
  `temp68` varchar(100) NOT NULL,
  `temp69` varchar(100) NOT NULL,
  `temp70` varchar(100) NOT NULL,
  `temp71` varchar(100) NOT NULL,
  `temp72` varchar(100) NOT NULL,
  `temp73` varchar(100) NOT NULL,
  `temp74` varchar(100) NOT NULL,
  `temp75` varchar(100) NOT NULL,
  `temp76` varchar(100) NOT NULL,
  `temp77` varchar(100) NOT NULL,
  `temp78` varchar(100) NOT NULL,
  `temp79` varchar(100) NOT NULL,
  `temp80` varchar(100) NOT NULL,
  `temp81` varchar(100) NOT NULL,
  `temp82` varchar(100) NOT NULL,
  `temp83` varchar(100) NOT NULL,
  `temp84` varchar(100) NOT NULL,
  `temp85` varchar(100) NOT NULL,
  `temp86` varchar(100) NOT NULL,
  `temp87` varchar(100) NOT NULL,
  `temp88` varchar(100) NOT NULL,
  `temp89` varchar(100) NOT NULL,
  `temp90` varchar(100) NOT NULL,
  `temp91` varchar(100) NOT NULL,
  `temp92` varchar(100) NOT NULL,
  `temp93` varchar(100) NOT NULL,
  `temp94` varchar(100) NOT NULL,
  `temp95` varchar(100) NOT NULL,
  `temp96` varchar(100) NOT NULL,
  `temp97` varchar(100) NOT NULL,
  `temp98` varchar(100) NOT NULL,
  `temp99` varchar(100) NOT NULL,
  `temp100` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_bayar_ralan` */

DROP TABLE IF EXISTS `temporary_bayar_ralan`;

CREATE TABLE `temporary_bayar_ralan` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(200) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=93746 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_bayar_ranap` */

DROP TABLE IF EXISTS `temporary_bayar_ranap`;

CREATE TABLE `temporary_bayar_ranap` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(100) NOT NULL,
  `temp2` varchar(200) NOT NULL,
  `temp3` varchar(100) NOT NULL,
  `temp4` varchar(100) NOT NULL,
  `temp5` varchar(100) NOT NULL,
  `temp6` varchar(100) NOT NULL,
  `temp7` varchar(100) NOT NULL,
  `temp8` varchar(100) NOT NULL,
  `temp9` varchar(100) NOT NULL,
  `temp10` varchar(100) NOT NULL,
  `temp11` varchar(100) NOT NULL,
  `temp12` varchar(100) NOT NULL,
  `temp13` varchar(100) NOT NULL,
  `temp14` varchar(100) NOT NULL,
  `temp15` varchar(100) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=137 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_booking_registrasi` */

DROP TABLE IF EXISTS `temporary_booking_registrasi`;

CREATE TABLE `temporary_booking_registrasi` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_gizi` */

DROP TABLE IF EXISTS `temporary_gizi`;

CREATE TABLE `temporary_gizi` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=44 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_grafik` */

DROP TABLE IF EXISTS `temporary_grafik`;

CREATE TABLE `temporary_grafik` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_lab` */

DROP TABLE IF EXISTS `temporary_lab`;

CREATE TABLE `temporary_lab` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_lama_pelayanan_radiologi` */

DROP TABLE IF EXISTS `temporary_lama_pelayanan_radiologi`;

CREATE TABLE `temporary_lama_pelayanan_radiologi` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_payment` */

DROP TABLE IF EXISTS `temporary_payment`;

CREATE TABLE `temporary_payment` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_permintaan_lab` */

DROP TABLE IF EXISTS `temporary_permintaan_lab`;

CREATE TABLE `temporary_permintaan_lab` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_permintaan_radiologi` */

DROP TABLE IF EXISTS `temporary_permintaan_radiologi`;

CREATE TABLE `temporary_permintaan_radiologi` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_presensi` */

DROP TABLE IF EXISTS `temporary_presensi`;

CREATE TABLE `temporary_presensi` (
  `id` int(11) NOT NULL,
  `shift` enum('Pagi','Pagi2','Pagi3','Pagi4','Pagi5','Pagi6','Pagi7','Pagi8','Pagi9','Pagi10','Siang','Siang2','Siang3','Siang4','Siang5','Siang6','Siang7','Siang8','Siang9','Siang10','Malam','Malam2','Malam3','Malam4','Malam5','Malam6','Malam7','Malam8','Malam9','Malam10','Midle Pagi1','Midle Pagi2','Midle Pagi3','Midle Pagi4','Midle Pagi5','Midle Pagi6','Midle Pagi7','Midle Pagi8','Midle Pagi9','Midle Pagi10','Midle Siang1','Midle Siang2','Midle Siang3','Midle Siang4','Midle Siang5','Midle Siang6','Midle Siang7','Midle Siang8','Midle Siang9','Midle Siang10','Midle Malam1','Midle Malam2','Midle Malam3','Midle Malam4','Midle Malam5','Midle Malam6','Midle Malam7','Midle Malam8','Midle Malam9','Midle Malam10') NOT NULL,
  `jam_datang` datetime DEFAULT NULL,
  `jam_pulang` datetime DEFAULT NULL,
  `status` enum('Tepat Waktu','Terlambat Toleransi','Terlambat I','Terlambat II','Tepat Waktu & PSW','Terlambat Toleransi & PSW','Terlambat I & PSW','Terlambat II & PSW') NOT NULL,
  `keterlambatan` varchar(20) NOT NULL,
  `durasi` varchar(20) DEFAULT NULL,
  `photo` varchar(500) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `temporary_presensi_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_radiologi` */

DROP TABLE IF EXISTS `temporary_radiologi`;

CREATE TABLE `temporary_radiologi` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_resep` */

DROP TABLE IF EXISTS `temporary_resep`;

CREATE TABLE `temporary_resep` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=158 DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_resume` */

DROP TABLE IF EXISTS `temporary_resume`;

CREATE TABLE `temporary_resume` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_sensus_harian` */

DROP TABLE IF EXISTS `temporary_sensus_harian`;

CREATE TABLE `temporary_sensus_harian` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_surveilens_penyakit` */

DROP TABLE IF EXISTS `temporary_surveilens_penyakit`;

CREATE TABLE `temporary_surveilens_penyakit` (
  `kd_penyakit` varchar(10) NOT NULL,
  `kd_penyakit2` varchar(10) NOT NULL,
  KEY `kd_penyakit` (`kd_penyakit`),
  KEY `kd_penyakit2` (`kd_penyakit2`),
  CONSTRAINT `temporary_surveilens_penyakit_ibfk_1` FOREIGN KEY (`kd_penyakit`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `temporary_surveilens_penyakit_ibfk_2` FOREIGN KEY (`kd_penyakit2`) REFERENCES `penyakit` (`kd_penyakit`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_tambahan_potongan` */

DROP TABLE IF EXISTS `temporary_tambahan_potongan`;

CREATE TABLE `temporary_tambahan_potongan` (
  `no_rawat` varchar(17) NOT NULL,
  `nama_tambahan` varchar(100) NOT NULL,
  `biaya` double NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`no_rawat`,`nama_tambahan`,`status`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `temporary_toko` */

DROP TABLE IF EXISTS `temporary_toko`;

CREATE TABLE `temporary_toko` (
  `no` int(100) NOT NULL AUTO_INCREMENT,
  `temp1` varchar(1000) NOT NULL,
  `temp2` varchar(1000) NOT NULL,
  `temp3` varchar(1000) NOT NULL,
  `temp4` varchar(1000) NOT NULL,
  `temp5` varchar(1000) NOT NULL,
  `temp6` varchar(1000) NOT NULL,
  `temp7` varchar(1000) NOT NULL,
  `temp8` varchar(1000) NOT NULL,
  `temp9` varchar(1000) NOT NULL,
  `temp10` varchar(1000) NOT NULL,
  `temp11` varchar(1000) NOT NULL,
  `temp12` varchar(1000) NOT NULL,
  `temp13` varchar(1000) NOT NULL,
  `temp14` varchar(1000) NOT NULL,
  `temp15` varchar(1000) NOT NULL,
  `temp16` varchar(100) NOT NULL,
  `temp17` varchar(100) NOT NULL,
  `temp18` varchar(100) NOT NULL,
  `temp19` varchar(100) NOT NULL,
  `temp20` varchar(100) NOT NULL,
  `temp21` varchar(100) NOT NULL,
  `temp22` varchar(100) NOT NULL,
  `temp23` varchar(100) NOT NULL,
  `temp24` varchar(100) NOT NULL,
  `temp25` varchar(100) NOT NULL,
  `temp26` varchar(100) NOT NULL,
  `temp27` varchar(100) NOT NULL,
  `temp28` varchar(100) NOT NULL,
  `temp29` varchar(100) NOT NULL,
  `temp30` varchar(100) NOT NULL,
  `temp31` varchar(100) NOT NULL,
  `temp32` varchar(100) NOT NULL,
  `temp33` varchar(100) NOT NULL,
  `temp34` varchar(100) NOT NULL,
  `temp35` varchar(100) NOT NULL,
  `temp36` varchar(100) NOT NULL,
  `temp37` varchar(100) NOT NULL,
  PRIMARY KEY (`no`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Table structure for table `temppanggilnorawat` */

DROP TABLE IF EXISTS `temppanggilnorawat`;

CREATE TABLE `temppanggilnorawat` (
  `no_rawat` varchar(17) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `temppanggilrm` */

DROP TABLE IF EXISTS `temppanggilrm`;

CREATE TABLE `temppanggilrm` (
  `no_rkm_medis` varchar(15) NOT NULL,
  PRIMARY KEY (`no_rkm_medis`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `tindakan` */

DROP TABLE IF EXISTS `tindakan`;

CREATE TABLE `tindakan` (
  `tgl` datetime NOT NULL,
  `id` int(11) NOT NULL,
  `tnd` int(11) NOT NULL,
  `jm` double NOT NULL,
  `nm_pasien` varchar(30) NOT NULL,
  `kamar` varchar(20) NOT NULL,
  `diagnosa` varchar(50) NOT NULL,
  `jmlh` int(11) NOT NULL,
  PRIMARY KEY (`tgl`,`id`,`tnd`,`nm_pasien`),
  KEY `id` (`id`),
  KEY `tnd` (`tnd`),
  CONSTRAINT `tindakan_ibfk_1` FOREIGN KEY (`id`) REFERENCES `pegawai` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_bayar_pemesanan` */

DROP TABLE IF EXISTS `toko_bayar_pemesanan`;

CREATE TABLE `toko_bayar_pemesanan` (
  `tgl_bayar` date DEFAULT NULL,
  `no_faktur` varchar(20) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `besar_bayar` double DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  `nama_bayar` varchar(50) DEFAULT NULL,
  `no_bukti` varchar(20) DEFAULT NULL,
  KEY `tgl_bayar` (`tgl_bayar`),
  KEY `no_faktur` (`no_faktur`),
  KEY `nip` (`nip`),
  KEY `nama_bayar` (`nama_bayar`),
  CONSTRAINT `toko_bayar_pemesanan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `tokopemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_bayar_pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_bayar_pemesanan_ibfk_3` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_bayar_piutang` */

DROP TABLE IF EXISTS `toko_bayar_piutang`;

CREATE TABLE `toko_bayar_piutang` (
  `tgl_bayar` date NOT NULL,
  `no_member` varchar(10) NOT NULL,
  `besar_cicilan` double NOT NULL,
  `catatan` varchar(100) NOT NULL,
  `nota_piutang` varchar(15) NOT NULL,
  `kd_rek` varchar(15) NOT NULL,
  `kd_rek_kontra` varchar(15) NOT NULL,
  PRIMARY KEY (`tgl_bayar`,`no_member`,`nota_piutang`,`kd_rek`,`kd_rek_kontra`),
  KEY `no_member` (`no_member`),
  KEY `kd_rek` (`kd_rek`),
  KEY `kd_rek_kontra` (`kd_rek_kontra`),
  KEY `nota_piutang` (`nota_piutang`),
  CONSTRAINT `toko_bayar_piutang_ibfk_1` FOREIGN KEY (`no_member`) REFERENCES `tokomember` (`no_member`) ON UPDATE CASCADE,
  CONSTRAINT `toko_bayar_piutang_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `toko_bayar_piutang_ibfk_3` FOREIGN KEY (`kd_rek_kontra`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `toko_bayar_piutang_ibfk_4` FOREIGN KEY (`nota_piutang`) REFERENCES `tokopiutang` (`nota_piutang`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_beli` */

DROP TABLE IF EXISTS `toko_detail_beli`;

CREATE TABLE `toko_detail_beli` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(10) DEFAULT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `jumlah` (`jumlah`),
  KEY `harga` (`harga`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `no_faktur` (`no_faktur`),
  CONSTRAINT `toko_detail_beli_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `tokopembelian` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_beli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_beli_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_jual` */

DROP TABLE IF EXISTS `toko_detail_jual`;

CREATE TABLE `toko_detail_jual` (
  `nota_jual` varchar(15) NOT NULL,
  `kode_brng` varchar(10) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `tambahan` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `nota_jual` (`nota_jual`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  CONSTRAINT `toko_detail_jual_ibfk_1` FOREIGN KEY (`nota_jual`) REFERENCES `tokopenjualan` (`nota_jual`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_jual_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_jual_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_pengajuan_barang` */

DROP TABLE IF EXISTS `toko_detail_pengajuan_barang`;

CREATE TABLE `toko_detail_pengajuan_barang` (
  `no_pengajuan` varchar(20) NOT NULL,
  `kode_brng` varchar(10) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pengajuan` double DEFAULT NULL,
  `total` double NOT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `no_pengajuan` (`no_pengajuan`),
  CONSTRAINT `toko_detail_pengajuan_barang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_pengajuan_barang_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_pengajuan_barang_ibfk_3` FOREIGN KEY (`no_pengajuan`) REFERENCES `toko_pengajuan_barang` (`no_pengajuan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_pesan` */

DROP TABLE IF EXISTS `toko_detail_pesan`;

CREATE TABLE `toko_detail_pesan` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(10) DEFAULT NULL,
  `kode_sat` char(4) NOT NULL,
  `jumlah` double NOT NULL,
  `harga` double NOT NULL,
  `subtotal` double NOT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  KEY `no_faktur` (`no_faktur`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  CONSTRAINT `toko_detail_pesan_ibfk_1` FOREIGN KEY (`no_faktur`) REFERENCES `tokopemesanan` (`no_faktur`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_pesan_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_pesan_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_piutang` */

DROP TABLE IF EXISTS `toko_detail_piutang`;

CREATE TABLE `toko_detail_piutang` (
  `nota_piutang` varchar(15) DEFAULT NULL,
  `kode_brng` varchar(10) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double DEFAULT NULL,
  `bsr_dis` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `nota_piutang` (`nota_piutang`),
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  CONSTRAINT `toko_detail_piutang_ibfk_1` FOREIGN KEY (`nota_piutang`) REFERENCES `tokopiutang` (`nota_piutang`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_piutang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_piutang_ibfk_3` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_returbeli` */

DROP TABLE IF EXISTS `toko_detail_returbeli`;

CREATE TABLE `toko_detail_returbeli` (
  `no_retur_beli` varchar(15) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  `kode_brng` varchar(10) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_beli` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_retur_beli` (`no_retur_beli`),
  CONSTRAINT `toko_detail_returbeli_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_returbeli_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_returbeli_ibfk_3` FOREIGN KEY (`no_retur_beli`) REFERENCES `tokoreturbeli` (`no_retur_beli`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_returjual` */

DROP TABLE IF EXISTS `toko_detail_returjual`;

CREATE TABLE `toko_detail_returjual` (
  `no_retur_jual` varchar(15) NOT NULL,
  `nota_jual` varchar(15) NOT NULL,
  `kode_brng` varchar(10) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_jual` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_retur_jual` (`no_retur_jual`),
  CONSTRAINT `toko_detail_returjual_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_returjual_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_returjual_ibfk_3` FOREIGN KEY (`no_retur_jual`) REFERENCES `tokoreturjual` (`no_retur_jual`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_returpiutang` */

DROP TABLE IF EXISTS `toko_detail_returpiutang`;

CREATE TABLE `toko_detail_returpiutang` (
  `no_retur_piutang` varchar(15) NOT NULL,
  `nota_piutang` varchar(15) NOT NULL,
  `kode_brng` varchar(10) NOT NULL DEFAULT '',
  `kode_sat` char(4) DEFAULT NULL,
  `h_piutang` double DEFAULT NULL,
  `h_retur` double DEFAULT NULL,
  `jml_retur` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  KEY `kode_sat` (`kode_sat`),
  KEY `kode_brng` (`kode_brng`),
  KEY `no_retur_piutang` (`no_retur_piutang`),
  CONSTRAINT `toko_detail_returpiutang_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_returpiutang_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_returpiutang_ibfk_3` FOREIGN KEY (`no_retur_piutang`) REFERENCES `tokoreturpiutang` (`no_retur_piutang`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_detail_surat_pemesanan` */

DROP TABLE IF EXISTS `toko_detail_surat_pemesanan`;

CREATE TABLE `toko_detail_surat_pemesanan` (
  `no_pemesanan` varchar(20) NOT NULL,
  `kode_brng` varchar(10) DEFAULT NULL,
  `kode_sat` char(4) DEFAULT NULL,
  `jumlah` double DEFAULT NULL,
  `h_pesan` double DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `dis` double NOT NULL,
  `besardis` double NOT NULL,
  `total` double NOT NULL,
  KEY `kode_brng` (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `jumlah` (`jumlah`),
  KEY `h_pesan` (`h_pesan`),
  KEY `subtotal` (`subtotal`),
  KEY `dis` (`dis`),
  KEY `besardis` (`besardis`),
  KEY `total` (`total`),
  KEY `no_pemesanan` (`no_pemesanan`),
  CONSTRAINT `toko_detail_surat_pemesanan_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_surat_pemesanan_ibfk_2` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `toko_detail_surat_pemesanan_ibfk_3` FOREIGN KEY (`no_pemesanan`) REFERENCES `toko_surat_pemesanan` (`no_pemesanan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_pengajuan_barang` */

DROP TABLE IF EXISTS `toko_pengajuan_barang`;

CREATE TABLE `toko_pengajuan_barang` (
  `no_pengajuan` varchar(20) NOT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `status` enum('Proses Pengajuan','Disetujui','Ditolak') DEFAULT NULL,
  `keterangan` varchar(150) DEFAULT NULL,
  PRIMARY KEY (`no_pengajuan`),
  KEY `nip` (`nip`),
  CONSTRAINT `toko_pengajuan_barang_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_riwayat_barang` */

DROP TABLE IF EXISTS `toko_riwayat_barang`;

CREATE TABLE `toko_riwayat_barang` (
  `kode_brng` varchar(10) DEFAULT NULL,
  `stok_awal` double DEFAULT NULL,
  `masuk` double DEFAULT NULL,
  `keluar` double DEFAULT NULL,
  `stok_akhir` double NOT NULL,
  `posisi` enum('Pengadaan','Penerimaan','Piutang','Retur Beli','Retur Jual','Retur Piutang','Opname','Penjualan','Stok Keluar') DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `jam` time DEFAULT NULL,
  `petugas` varchar(20) DEFAULT NULL,
  `status` enum('Simpan','Hapus') DEFAULT NULL,
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `toko_riwayat_barang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `toko_surat_pemesanan` */

DROP TABLE IF EXISTS `toko_surat_pemesanan`;

CREATE TABLE `toko_surat_pemesanan` (
  `no_pemesanan` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tanggal` date DEFAULT NULL,
  `subtotal` double NOT NULL,
  `potongan` double NOT NULL,
  `total` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double DEFAULT NULL,
  `status` enum('Proses Pesan','Sudah Datang') DEFAULT NULL,
  PRIMARY KEY (`no_pemesanan`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  CONSTRAINT `toko_surat_pemesanan_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `tokosuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `toko_surat_pemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `pegawai` (`nik`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokobarang` */

DROP TABLE IF EXISTS `tokobarang`;

CREATE TABLE `tokobarang` (
  `kode_brng` varchar(10) NOT NULL,
  `nama_brng` varchar(80) NOT NULL,
  `kode_sat` char(4) NOT NULL,
  `jenis` char(5) DEFAULT NULL,
  `stok` double NOT NULL,
  `dasar` double NOT NULL,
  `h_beli` double NOT NULL,
  `distributor` double NOT NULL,
  `grosir` double NOT NULL,
  `retail` double NOT NULL,
  `status` enum('0','1') NOT NULL,
  PRIMARY KEY (`kode_brng`),
  KEY `kode_sat` (`kode_sat`),
  KEY `nama_brng` (`nama_brng`),
  KEY `jenis` (`jenis`),
  CONSTRAINT `tokobarang_ibfk_1` FOREIGN KEY (`kode_sat`) REFERENCES `kodesatuan` (`kode_sat`) ON UPDATE CASCADE,
  CONSTRAINT `tokobarang_ibfk_2` FOREIGN KEY (`jenis`) REFERENCES `tokojenisbarang` (`kd_jenis`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokojenisbarang` */

DROP TABLE IF EXISTS `tokojenisbarang`;

CREATE TABLE `tokojenisbarang` (
  `kd_jenis` char(5) NOT NULL,
  `nm_jenis` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`kd_jenis`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokomember` */

DROP TABLE IF EXISTS `tokomember`;

CREATE TABLE `tokomember` (
  `no_member` varchar(10) NOT NULL,
  `nama` varchar(50) DEFAULT NULL,
  `jk` enum('L','P') DEFAULT NULL,
  `tmp_lahir` varchar(20) DEFAULT NULL,
  `tgl_lahir` date DEFAULT NULL,
  `alamat` varchar(60) DEFAULT NULL,
  `no_telp` varchar(40) DEFAULT NULL,
  `email` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`no_member`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokoopname` */

DROP TABLE IF EXISTS `tokoopname`;

CREATE TABLE `tokoopname` (
  `kode_brng` varchar(10) NOT NULL,
  `dasar` double DEFAULT NULL,
  `tanggal` date NOT NULL,
  `stok` int(11) NOT NULL,
  `real` int(11) NOT NULL,
  `selisih` int(11) NOT NULL,
  `nomihilang` double NOT NULL,
  `keterangan` varchar(60) NOT NULL,
  PRIMARY KEY (`kode_brng`,`tanggal`),
  KEY `stok` (`stok`),
  KEY `real` (`real`),
  KEY `selisih` (`selisih`),
  KEY `nomihilang` (`nomihilang`),
  KEY `keterangan` (`keterangan`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `tokoopname_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `tokobarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokopembelian` */

DROP TABLE IF EXISTS `tokopembelian`;

CREATE TABLE `tokopembelian` (
  `no_faktur` varchar(20) NOT NULL,
  `kode_suplier` char(5) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `tgl_beli` date NOT NULL,
  `subtotal` double NOT NULL,
  `potongan` double NOT NULL,
  `total` double NOT NULL,
  `ppn` double DEFAULT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  KEY `tgl_beli` (`tgl_beli`),
  KEY `subtotal` (`subtotal`),
  KEY `potongan` (`potongan`),
  KEY `total` (`total`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `tokopembelian_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokopembelian_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `akun_bayar` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokopembelian_ibfk_3` FOREIGN KEY (`kode_suplier`) REFERENCES `tokosuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokopemesanan` */

DROP TABLE IF EXISTS `tokopemesanan`;

CREATE TABLE `tokopemesanan` (
  `no_faktur` varchar(20) NOT NULL,
  `no_order` varchar(20) NOT NULL,
  `kode_suplier` char(5) DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  `tgl_pesan` date DEFAULT NULL,
  `tgl_faktur` date DEFAULT NULL,
  `tgl_tempo` date DEFAULT NULL,
  `total1` double NOT NULL,
  `potongan` double NOT NULL,
  `total2` double NOT NULL,
  `ppn` double NOT NULL,
  `meterai` double DEFAULT NULL,
  `tagihan` double NOT NULL,
  `status` enum('Sudah Dibayar','Belum Dibayar','Belum Lunas') DEFAULT NULL,
  PRIMARY KEY (`no_faktur`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  CONSTRAINT `tokopemesanan_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `tokosuplier` (`kode_suplier`) ON UPDATE CASCADE,
  CONSTRAINT `tokopemesanan_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokopenjualan` */

DROP TABLE IF EXISTS `tokopenjualan`;

CREATE TABLE `tokopenjualan` (
  `nota_jual` varchar(15) NOT NULL,
  `tgl_jual` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_member` varchar(10) DEFAULT NULL,
  `nm_member` varchar(50) DEFAULT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  `jns_jual` enum('Distributor','Grosir','Retail') DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `ppn` double NOT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `total` double NOT NULL,
  `nama_bayar` varchar(50) NOT NULL,
  PRIMARY KEY (`nota_jual`),
  KEY `no_member` (`no_member`),
  KEY `kd_rek` (`kd_rek`),
  KEY `nip` (`nip`),
  KEY `nama_bayar` (`nama_bayar`),
  CONSTRAINT `tokopenjualan_ibfk_1` FOREIGN KEY (`no_member`) REFERENCES `tokomember` (`no_member`) ON UPDATE CASCADE,
  CONSTRAINT `tokopenjualan_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON UPDATE CASCADE,
  CONSTRAINT `tokopenjualan_ibfk_3` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokopenjualan_ibfk_4` FOREIGN KEY (`nama_bayar`) REFERENCES `akun_bayar` (`nama_bayar`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokopiutang` */

DROP TABLE IF EXISTS `tokopiutang`;

CREATE TABLE `tokopiutang` (
  `nota_piutang` varchar(15) NOT NULL,
  `tgl_piutang` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_member` varchar(15) DEFAULT NULL,
  `nm_member` varchar(50) DEFAULT NULL,
  `catatan` varchar(40) DEFAULT NULL,
  `jns_jual` enum('Distributor','Grosir','Retail') DEFAULT NULL,
  `ongkir` double DEFAULT NULL,
  `uangmuka` double DEFAULT NULL,
  `sisapiutang` double NOT NULL,
  `tgltempo` date NOT NULL,
  PRIMARY KEY (`nota_piutang`),
  KEY `nip` (`nip`),
  KEY `no_member` (`no_member`),
  CONSTRAINT `tokopiutang_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokopiutang_ibfk_2` FOREIGN KEY (`no_member`) REFERENCES `tokomember` (`no_member`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokoreturbeli` */

DROP TABLE IF EXISTS `tokoreturbeli`;

CREATE TABLE `tokoreturbeli` (
  `no_retur_beli` varchar(15) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `kode_suplier` char(5) NOT NULL,
  `catatan` varchar(40) NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_retur_beli`),
  KEY `kode_suplier` (`kode_suplier`),
  KEY `nip` (`nip`),
  CONSTRAINT `tokoreturbeli_ibfk_1` FOREIGN KEY (`kode_suplier`) REFERENCES `tokosuplier` (`kode_suplier`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokoreturbeli_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokoreturjual` */

DROP TABLE IF EXISTS `tokoreturjual`;

CREATE TABLE `tokoreturjual` (
  `no_retur_jual` varchar(15) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_member` varchar(10) NOT NULL,
  `catatan` varchar(40) NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_retur_jual`),
  KEY `no_member` (`no_member`),
  KEY `nip` (`nip`),
  CONSTRAINT `tokoreturjual_ibfk_1` FOREIGN KEY (`no_member`) REFERENCES `tokomember` (`no_member`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokoreturjual_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokoreturpiutang` */

DROP TABLE IF EXISTS `tokoreturpiutang`;

CREATE TABLE `tokoreturpiutang` (
  `no_retur_piutang` varchar(15) NOT NULL,
  `tgl_retur` date DEFAULT NULL,
  `nip` char(20) DEFAULT NULL,
  `no_member` varchar(10) NOT NULL,
  `catatan` varchar(40) NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`no_retur_piutang`),
  KEY `no_member` (`no_member`),
  KEY `nip` (`nip`),
  CONSTRAINT `tokoreturpiutang_ibfk_1` FOREIGN KEY (`no_member`) REFERENCES `tokomember` (`no_member`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `tokoreturpiutang_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tokosetharga` */

DROP TABLE IF EXISTS `tokosetharga`;

CREATE TABLE `tokosetharga` (
  `distributor` double NOT NULL,
  `grosir` double NOT NULL,
  `retail` double NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

/*Table structure for table `tokosuplier` */

DROP TABLE IF EXISTS `tokosuplier`;

CREATE TABLE `tokosuplier` (
  `kode_suplier` char(5) NOT NULL,
  `nama_suplier` varchar(50) DEFAULT NULL,
  `alamat` varchar(50) DEFAULT NULL,
  `kota` varchar(20) DEFAULT NULL,
  `no_telp` varchar(13) DEFAULT NULL,
  `nama_bank` varchar(30) DEFAULT NULL,
  `rekening` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`kode_suplier`),
  KEY `nama_suplier` (`nama_suplier`),
  KEY `alamat` (`alamat`),
  KEY `kota` (`kota`),
  KEY `no_telp` (`no_telp`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `tracker` */

DROP TABLE IF EXISTS `tracker`;

CREATE TABLE `tracker` (
  `nip` varchar(20) NOT NULL,
  `tgl_login` date NOT NULL,
  `jam_login` time NOT NULL,
  PRIMARY KEY (`nip`,`tgl_login`,`jam_login`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `trackersql` */

DROP TABLE IF EXISTS `trackersql`;

CREATE TABLE `trackersql` (
  `tanggal` datetime NOT NULL,
  `sqle` text NOT NULL,
  `usere` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `ubah_penjab` */

DROP TABLE IF EXISTS `ubah_penjab`;

CREATE TABLE `ubah_penjab` (
  `no_rawat` varchar(17) NOT NULL,
  `tgl_ubah` datetime NOT NULL,
  `kd_pj1` char(3) NOT NULL,
  `kd_pj2` char(3) NOT NULL,
  KEY `no_rawat` (`no_rawat`),
  KEY `tgl_ubah` (`tgl_ubah`),
  KEY `kd_pj1` (`kd_pj1`),
  KEY `kd_pj2` (`kd_pj2`),
  CONSTRAINT `ubah_penjab_ibfk_4` FOREIGN KEY (`no_rawat`) REFERENCES `reg_periksa` (`no_rawat`) ON UPDATE CASCADE,
  CONSTRAINT `ubah_penjab_ibfk_5` FOREIGN KEY (`kd_pj1`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE,
  CONSTRAINT `ubah_penjab_ibfk_6` FOREIGN KEY (`kd_pj2`) REFERENCES `penjab` (`kd_pj`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id_user` varchar(700) NOT NULL,
  `password` text NOT NULL,
  `penyakit` enum('true','false') NOT NULL,
  `obat_penyakit` enum('true','false') NOT NULL,
  `dokter` enum('true','false') NOT NULL,
  `jadwal_praktek` enum('true','false') NOT NULL,
  `petugas` enum('true','false') NOT NULL,
  `pasien` enum('true','false') NOT NULL,
  `registrasi` enum('true','false') NOT NULL,
  `tindakan_ralan` enum('true','false') NOT NULL,
  `kamar_inap` enum('true','false') NOT NULL,
  `tindakan_ranap` enum('true','false') NOT NULL,
  `operasi` enum('true','false') NOT NULL,
  `rujukan_keluar` enum('true','false') NOT NULL,
  `rujukan_masuk` enum('true','false') NOT NULL,
  `beri_obat` enum('true','false') NOT NULL,
  `resep_pulang` enum('true','false') NOT NULL,
  `pasien_meninggal` enum('true','false') NOT NULL,
  `diet_pasien` enum('true','false') NOT NULL,
  `kelahiran_bayi` enum('true','false') NOT NULL,
  `periksa_lab` enum('true','false') NOT NULL,
  `periksa_radiologi` enum('true','false') NOT NULL,
  `kasir_ralan` enum('true','false') NOT NULL,
  `deposit_pasien` enum('true','false') NOT NULL,
  `piutang_pasien` enum('true','false') NOT NULL,
  `peminjaman_berkas` enum('true','false') NOT NULL,
  `barcode` enum('true','false') NOT NULL,
  `presensi_harian` enum('true','false') NOT NULL,
  `presensi_bulanan` enum('true','false') NOT NULL,
  `pegawai_admin` enum('true','false') NOT NULL,
  `pegawai_user` enum('true','false') NOT NULL,
  `suplier` enum('true','false') NOT NULL,
  `satuan_barang` enum('true','false') NOT NULL,
  `konversi_satuan` enum('true','false') NOT NULL,
  `jenis_barang` enum('true','false') NOT NULL,
  `obat` enum('true','false') NOT NULL,
  `stok_opname_obat` enum('true','false') NOT NULL,
  `stok_obat_pasien` enum('true','false') NOT NULL,
  `pengadaan_obat` enum('true','false') NOT NULL,
  `pemesanan_obat` enum('true','false') NOT NULL,
  `penjualan_obat` enum('true','false') NOT NULL,
  `piutang_obat` enum('true','false') NOT NULL,
  `retur_ke_suplier` enum('true','false') NOT NULL,
  `retur_dari_pembeli` enum('true','false') NOT NULL,
  `retur_obat_ranap` enum('true','false') NOT NULL,
  `retur_piutang_pasien` enum('true','false') NOT NULL,
  `keuntungan_penjualan` enum('true','false') NOT NULL,
  `keuntungan_beri_obat` enum('true','false') NOT NULL,
  `sirkulasi_obat` enum('true','false') NOT NULL,
  `ipsrs_barang` enum('true','false') NOT NULL,
  `ipsrs_pengadaan_barang` enum('true','false') NOT NULL,
  `ipsrs_stok_keluar` enum('true','false') NOT NULL,
  `ipsrs_rekap_pengadaan` enum('true','false') NOT NULL,
  `ipsrs_rekap_stok_keluar` enum('true','false') NOT NULL,
  `ipsrs_pengeluaran_harian` enum('true','false') NOT NULL,
  `inventaris_jenis` enum('true','false') NOT NULL,
  `inventaris_kategori` enum('true','false') NOT NULL,
  `inventaris_merk` enum('true','false') NOT NULL,
  `inventaris_ruang` enum('true','false') NOT NULL,
  `inventaris_produsen` enum('true','false') NOT NULL,
  `inventaris_koleksi` enum('true','false') NOT NULL,
  `inventaris_inventaris` enum('true','false') NOT NULL,
  `inventaris_sirkulasi` enum('true','false') NOT NULL,
  `parkir_jenis` enum('true','false') NOT NULL,
  `parkir_in` enum('true','false') NOT NULL,
  `parkir_out` enum('true','false') NOT NULL,
  `parkir_rekap_harian` enum('true','false') NOT NULL,
  `parkir_rekap_bulanan` enum('true','false') NOT NULL,
  `informasi_kamar` enum('true','false') NOT NULL,
  `harian_tindakan_poli` enum('true','false') NOT NULL,
  `obat_per_poli` enum('true','false') NOT NULL,
  `obat_per_kamar` enum('true','false') NOT NULL,
  `obat_per_dokter_ralan` enum('true','false') NOT NULL,
  `obat_per_dokter_ranap` enum('true','false') NOT NULL,
  `harian_dokter` enum('true','false') NOT NULL,
  `bulanan_dokter` enum('true','false') NOT NULL,
  `harian_paramedis` enum('true','false') NOT NULL,
  `bulanan_paramedis` enum('true','false') NOT NULL,
  `pembayaran_ralan` enum('true','false') NOT NULL,
  `pembayaran_ranap` enum('true','false') NOT NULL,
  `rekap_pembayaran_ralan` enum('true','false') NOT NULL,
  `rekap_pembayaran_ranap` enum('true','false') NOT NULL,
  `tagihan_masuk` enum('true','false') NOT NULL,
  `tambahan_biaya` enum('true','false') NOT NULL,
  `potongan_biaya` enum('true','false') NOT NULL,
  `resep_obat` enum('true','false') NOT NULL,
  `resume_pasien` enum('true','false') NOT NULL,
  `penyakit_ralan` enum('true','false') NOT NULL,
  `penyakit_ranap` enum('true','false') NOT NULL,
  `kamar` enum('true','false') NOT NULL,
  `tarif_ralan` enum('true','false') NOT NULL,
  `tarif_ranap` enum('true','false') NOT NULL,
  `tarif_lab` enum('true','false') NOT NULL,
  `tarif_radiologi` enum('true','false') NOT NULL,
  `tarif_operasi` enum('true','false') NOT NULL,
  `akun_rekening` enum('true','false') NOT NULL,
  `rekening_tahun` enum('true','false') NOT NULL,
  `posting_jurnal` enum('true','false') NOT NULL,
  `buku_besar` enum('true','false') NOT NULL,
  `cashflow` enum('true','false') NOT NULL,
  `keuangan` enum('true','false') NOT NULL,
  `pengeluaran` enum('true','false') NOT NULL,
  `setup_pjlab` enum('true','false') NOT NULL,
  `setup_otolokasi` enum('true','false') NOT NULL,
  `setup_jam_kamin` enum('true','false') NOT NULL,
  `setup_embalase` enum('true','false') NOT NULL,
  `tracer_login` enum('true','false') NOT NULL,
  `display` enum('true','false') NOT NULL,
  `set_harga_obat` enum('true','false') NOT NULL,
  `set_penggunaan_tarif` enum('true','false') NOT NULL,
  `set_oto_ralan` enum('true','false') NOT NULL,
  `biaya_harian` enum('true','false') NOT NULL,
  `biaya_masuk_sekali` enum('true','false') NOT NULL,
  `set_no_rm` enum('true','false') NOT NULL,
  `billing_ralan` enum('true','false') NOT NULL,
  `billing_ranap` enum('true','false') NOT NULL,
  `jm_ranap_dokter` enum('true','false') NOT NULL,
  `igd` enum('true','false') NOT NULL,
  `barcoderalan` enum('true','false') NOT NULL,
  `barcoderanap` enum('true','false') NOT NULL,
  `set_harga_obat_ralan` enum('true','false') NOT NULL,
  `set_harga_obat_ranap` enum('true','false') NOT NULL,
  `penyakit_pd3i` enum('true','false') NOT NULL,
  `surveilans_pd3i` enum('true','false') NOT NULL,
  `surveilans_ralan` enum('true','false') NOT NULL,
  `diagnosa_pasien` enum('true','false') NOT NULL,
  `surveilans_ranap` enum('true','false') NOT NULL,
  `pny_takmenular_ranap` enum('true','false') NOT NULL,
  `pny_takmenular_ralan` enum('true','false') NOT NULL,
  `kunjungan_ralan` enum('true','false') NOT NULL,
  `rl32` enum('true','false') NOT NULL,
  `rl33` enum('true','false') NOT NULL,
  `rl37` enum('true','false') NOT NULL,
  `rl38` enum('true','false') NOT NULL,
  `harian_tindakan_dokter` enum('true','false') NOT NULL,
  `sms` enum('true','false') NOT NULL,
  `sidikjari` enum('true','false') NOT NULL,
  `jam_masuk` enum('true','false') NOT NULL,
  `jadwal_pegawai` enum('true','false') NOT NULL,
  `parkir_barcode` enum('true','false') NOT NULL,
  `set_nota` enum('true','false') NOT NULL,
  `dpjp_ranap` enum('true','false') NOT NULL,
  `mutasi_barang` enum('true','false') NOT NULL,
  `rl34` enum('true','false') DEFAULT NULL,
  `rl36` enum('true','false') NOT NULL,
  `fee_visit_dokter` enum('true','false') DEFAULT NULL,
  `fee_bacaan_ekg` enum('true','false') DEFAULT NULL,
  `fee_rujukan_rontgen` enum('true','false') DEFAULT NULL,
  `fee_rujukan_ranap` enum('true','false') DEFAULT NULL,
  `fee_ralan` enum('true','false') DEFAULT NULL,
  `akun_bayar` enum('true','false') DEFAULT NULL,
  `bayar_pemesanan_obat` enum('true','false') DEFAULT NULL,
  `obat_per_dokter_peresep` enum('true','false') DEFAULT NULL,
  `ipsrs_jenis_barang` enum('true','false') DEFAULT NULL,
  `pemasukan_lain` enum('true','false') DEFAULT NULL,
  `pengaturan_rekening` enum('true','false') DEFAULT NULL,
  `closing_kasir` enum('true','false') DEFAULT NULL,
  `keterlambatan_presensi` enum('true','false') DEFAULT NULL,
  `set_harga_kamar` enum('true','false') DEFAULT NULL,
  `rekap_per_shift` enum('true','false') DEFAULT NULL,
  `bpjs_cek_nik` enum('true','false') DEFAULT NULL,
  `bpjs_cek_kartu` enum('true','false') DEFAULT NULL,
  `bpjs_cek_riwayat` enum('true','false') DEFAULT NULL,
  `obat_per_cara_bayar` enum('true','false') DEFAULT NULL,
  `kunjungan_ranap` enum('true','false') DEFAULT NULL,
  `bayar_piutang` enum('true','false') DEFAULT NULL,
  `payment_point` enum('true','false') DEFAULT NULL,
  `bpjs_cek_nomor_rujukan` enum('true','false') DEFAULT NULL,
  `icd9` enum('true','false') DEFAULT NULL,
  `darurat_stok` enum('true','false') DEFAULT NULL,
  `retensi_rm` enum('true','false') DEFAULT NULL,
  `temporary_presensi` enum('true','false') DEFAULT NULL,
  `jurnal_harian` enum('true','false') DEFAULT NULL,
  `sirkulasi_obat2` enum('true','false') DEFAULT NULL,
  `edit_registrasi` enum('true','false') DEFAULT NULL,
  `bpjs_referensi_diagnosa` enum('true','false') DEFAULT NULL,
  `bpjs_referensi_poli` enum('true','false') DEFAULT NULL,
  `industrifarmasi` enum('true','false') DEFAULT NULL,
  `harian_js` enum('true','false') DEFAULT NULL,
  `bulanan_js` enum('true','false') DEFAULT NULL,
  `harian_paket_bhp` enum('true','false') DEFAULT NULL,
  `bulanan_paket_bhp` enum('true','false') DEFAULT NULL,
  `piutang_pasien2` enum('true','false') DEFAULT NULL,
  `bpjs_referensi_faskes` enum('true','false') DEFAULT NULL,
  `bpjs_sep` enum('true','false') DEFAULT NULL,
  `pengambilan_utd` enum('true','false') DEFAULT NULL,
  `tarif_utd` enum('true','false') DEFAULT NULL,
  `pengambilan_utd2` enum('true','false') DEFAULT NULL,
  `utd_medis_rusak` enum('true','false') DEFAULT NULL,
  `pengambilan_penunjang_utd` enum('true','false') DEFAULT NULL,
  `pengambilan_penunjang_utd2` enum('true','false') DEFAULT NULL,
  `utd_penunjang_rusak` enum('true','false') DEFAULT NULL,
  `suplier_penunjang` enum('true','false') DEFAULT NULL,
  `utd_donor` enum('true','false') DEFAULT NULL,
  `bpjs_monitoring_klaim` enum('true','false') DEFAULT NULL,
  `utd_cekal_darah` enum('true','false') DEFAULT NULL,
  `utd_komponen_darah` enum('true','false') DEFAULT NULL,
  `utd_stok_darah` enum('true','false') DEFAULT NULL,
  `utd_pemisahan_darah` enum('true','false') DEFAULT NULL,
  `harian_kamar` enum('true','false') DEFAULT NULL,
  `rincian_piutang_pasien` enum('true','false') DEFAULT NULL,
  `keuntungan_beri_obat_nonpiutang` enum('true','false') DEFAULT NULL,
  `reklasifikasi_ralan` enum('true','false') DEFAULT NULL,
  `reklasifikasi_ranap` enum('true','false') DEFAULT NULL,
  `utd_penyerahan_darah` enum('true','false') DEFAULT NULL,
  `hutang_obat` enum('true','false') DEFAULT NULL,
  `riwayat_obat_alkes_bhp` enum('true','false') DEFAULT NULL,
  `sensus_harian_poli` enum('true','false') DEFAULT NULL,
  `rl4a` enum('true','false') DEFAULT NULL,
  `aplicare_referensi_kamar` enum('true','false') DEFAULT NULL,
  `aplicare_ketersediaan_kamar` enum('true','false') DEFAULT NULL,
  `inacbg_klaim_baru_otomatis` enum('true','false') DEFAULT NULL,
  `inacbg_klaim_baru_manual` enum('true','false') DEFAULT NULL,
  `inacbg_coder_nik` enum('true','false') DEFAULT NULL,
  `mutasi_berkas` enum('true','false') DEFAULT NULL,
  `akun_piutang` enum('true','false') DEFAULT NULL,
  `harian_kso` enum('true','false') DEFAULT NULL,
  `bulanan_kso` enum('true','false') DEFAULT NULL,
  `harian_menejemen` enum('true','false') DEFAULT NULL,
  `bulanan_menejemen` enum('true','false') DEFAULT NULL,
  `inhealth_cek_eligibilitas` enum('true','false') DEFAULT NULL,
  `inhealth_referensi_jenpel_ruang_rawat` enum('true','false') DEFAULT NULL,
  `inhealth_referensi_poli` enum('true','false') DEFAULT NULL,
  `inhealth_referensi_faskes` enum('true','false') DEFAULT NULL,
  `inhealth_sjp` enum('true','false') DEFAULT NULL,
  `piutang_ralan` enum('true','false') DEFAULT NULL,
  `piutang_ranap` enum('true','false') DEFAULT NULL,
  `detail_piutang_penjab` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_ralan` enum('true','false') DEFAULT NULL,
  `catatan_pasien` enum('true','false') DEFAULT NULL,
  `rl4b` enum('true','false') DEFAULT NULL,
  `rl4asebab` enum('true','false') DEFAULT NULL,
  `rl4bsebab` enum('true','false') DEFAULT NULL,
  `data_HAIs` enum('true','false') DEFAULT NULL,
  `harian_HAIs` enum('true','false') DEFAULT NULL,
  `bulanan_HAIs` enum('true','false') DEFAULT NULL,
  `hitung_bor` enum('true','false') DEFAULT NULL,
  `perusahaan_pasien` enum('true','false') DEFAULT NULL,
  `resep_dokter` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_apotek` enum('true','false') DEFAULT NULL,
  `hitung_alos` enum('true','false') DEFAULT NULL,
  `detail_tindakan` enum('true','false') DEFAULT NULL,
  `rujukan_poli_internal` enum('true','false') DEFAULT NULL,
  `rekap_poli_anak` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_poli` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_perdokter` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_perpekerjaan` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_perpendidikan` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_pertahun` enum('true','false') DEFAULT NULL,
  `berkas_digital_perawatan` enum('true','false') DEFAULT NULL,
  `penyakit_menular_ranap` enum('true','false') DEFAULT NULL,
  `penyakit_menular_ralan` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_perbulan` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_demografi` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusdaftartahun` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusdaftartahun2` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusdaftarbulan` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusdaftarbulan2` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusdaftartanggal` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusdaftartanggal2` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusbataltahun` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusbatalbulan` enum('true','false') DEFAULT NULL,
  `pcare_cek_penyakit` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_statusbataltanggal` enum('true','false') DEFAULT NULL,
  `kategori_barang` enum('true','false') DEFAULT NULL,
  `golongan_barang` enum('true','false') DEFAULT NULL,
  `pemberian_obat_pertanggal` enum('true','false') DEFAULT NULL,
  `penjualan_obat_pertanggal` enum('true','false') DEFAULT NULL,
  `pcare_cek_kesadaran` enum('true','false') DEFAULT NULL,
  `pembatalan_periksa_dokter` enum('true','false') DEFAULT NULL,
  `pembayaran_per_unit` enum('true','false') DEFAULT NULL,
  `rekap_pembayaran_per_unit` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_percarabayar` enum('true','false') DEFAULT NULL,
  `ipsrs_pengadaan_pertanggal` enum('true','false') DEFAULT NULL,
  `ipsrs_stokkeluar_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_ranaptahun` enum('true','false') DEFAULT NULL,
  `pcare_cek_rujukan` enum('true','false') DEFAULT NULL,
  `grafik_lab_ralantahun` enum('true','false') DEFAULT NULL,
  `grafik_rad_ralantahun` enum('true','false') DEFAULT NULL,
  `cek_entry_ralan` enum('true','false') DEFAULT NULL,
  `inacbg_klaim_baru_manual2` enum('true','false') DEFAULT NULL,
  `permintaan_medis` enum('true','false') DEFAULT NULL,
  `rekap_permintaan_medis` enum('true','false') DEFAULT NULL,
  `surat_pemesanan_medis` enum('true','false') DEFAULT NULL,
  `permintaan_non_medis` enum('true','false') DEFAULT NULL,
  `rekap_permintaan_non_medis` enum('true','false') DEFAULT NULL,
  `surat_pemesanan_non_medis` enum('true','false') DEFAULT NULL,
  `grafik_per_perujuk` enum('true','false') NOT NULL,
  `bpjs_cek_prosedur` enum('true','false') DEFAULT NULL,
  `bpjs_cek_kelas_rawat` enum('true','false') DEFAULT NULL,
  `bpjs_cek_dokter` enum('true','false') DEFAULT NULL,
  `bpjs_cek_spesialistik` enum('true','false') DEFAULT NULL,
  `bpjs_cek_ruangrawat` enum('true','false') DEFAULT NULL,
  `bpjs_cek_carakeluar` enum('true','false') DEFAULT NULL,
  `bpjs_cek_pasca_pulang` enum('true','false') DEFAULT NULL,
  `detail_tindakan_okvk` enum('true','false') DEFAULT NULL,
  `billing_parsial` enum('true','false') DEFAULT NULL,
  `bpjs_cek_nomor_rujukan_rs` enum('true','false') DEFAULT NULL,
  `bpjs_cek_rujukan_kartu_pcare` enum('true','false') DEFAULT NULL,
  `bpjs_cek_rujukan_kartu_rs` enum('true','false') DEFAULT NULL,
  `akses_depo_obat` enum('true','false') DEFAULT NULL,
  `bpjs_rujukan_keluar` enum('true','false') DEFAULT NULL,
  `grafik_lab_ralanbulan` enum('true','false') DEFAULT NULL,
  `pengeluaran_stok_apotek` enum('true','false') DEFAULT NULL,
  `grafik_rad_ralanbulan` enum('true','false') DEFAULT NULL,
  `detailjmdokter2` enum('true','false') DEFAULT NULL,
  `pengaduan_pasien` enum('true','false') DEFAULT NULL,
  `grafik_lab_ralanhari` enum('true','false') DEFAULT NULL,
  `grafik_rad_ralanhari` enum('true','false') DEFAULT NULL,
  `sensus_harian_ralan` enum('true','false') DEFAULT NULL,
  `metode_racik` enum('true','false') DEFAULT NULL,
  `pembayaran_akun_bayar` enum('true','false') DEFAULT NULL,
  `pengguna_obat_resep` enum('true','false') DEFAULT NULL,
  `rekap_pemesanan` enum('true','false') DEFAULT NULL,
  `master_berkas_pegawai` enum('true','false') DEFAULT NULL,
  `berkas_kepegawaian` enum('true','false') DEFAULT NULL,
  `riwayat_jabatan` enum('true','false') DEFAULT NULL,
  `riwayat_pendidikan` enum('true','false') DEFAULT NULL,
  `riwayat_naik_gaji` enum('true','false') DEFAULT NULL,
  `kegiatan_ilmiah` enum('true','false') DEFAULT NULL,
  `riwayat_penghargaan` enum('true','false') DEFAULT NULL,
  `riwayat_penelitian` enum('true','false') DEFAULT NULL,
  `penerimaan_non_medis` enum('true','false') DEFAULT NULL,
  `bayar_pesan_non_medis` enum('true','false') DEFAULT NULL,
  `hutang_barang_non_medis` enum('true','false') DEFAULT NULL,
  `rekap_pemesanan_non_medis` enum('true','false') DEFAULT NULL,
  `insiden_keselamatan` enum('true','false') DEFAULT NULL,
  `insiden_keselamatan_pasien` enum('true','false') DEFAULT NULL,
  `grafik_ikp_pertahun` enum('true','false') DEFAULT NULL,
  `grafik_ikp_perbulan` enum('true','false') DEFAULT NULL,
  `grafik_ikp_pertanggal` enum('true','false') DEFAULT NULL,
  `riwayat_data_batch` enum('true','false') DEFAULT NULL,
  `grafik_ikp_jenis` enum('true','false') DEFAULT NULL,
  `grafik_ikp_dampak` enum('true','false') DEFAULT NULL,
  `piutang_akun_piutang` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_per_agama` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_per_umur` enum('true','false') DEFAULT NULL,
  `suku_bangsa` enum('true','false') DEFAULT NULL,
  `bahasa_pasien` enum('true','false') DEFAULT NULL,
  `golongan_tni` enum('true','false') DEFAULT NULL,
  `satuan_tni` enum('true','false') DEFAULT NULL,
  `jabatan_tni` enum('true','false') DEFAULT NULL,
  `pangkat_tni` enum('true','false') DEFAULT NULL,
  `golongan_polri` enum('true','false') DEFAULT NULL,
  `satuan_polri` enum('true','false') DEFAULT NULL,
  `jabatan_polri` enum('true','false') DEFAULT NULL,
  `pangkat_polri` enum('true','false') DEFAULT NULL,
  `cacat_fisik` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_suku` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_bahasa` enum('true','false') DEFAULT NULL,
  `booking_operasi` enum('true','false') DEFAULT NULL,
  `mapping_poli_bpjs` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_per_cacat` enum('true','false') DEFAULT NULL,
  `barang_cssd` enum('true','false') DEFAULT NULL,
  `skdp_bpjs` enum('true','false') DEFAULT NULL,
  `booking_registrasi` enum('true','false') DEFAULT NULL,
  `bpjs_cek_propinsi` enum('true','false') DEFAULT NULL,
  `bpjs_cek_kabupaten` enum('true','false') DEFAULT NULL,
  `bpjs_cek_kecamatan` enum('true','false') DEFAULT NULL,
  `bpjs_cek_dokterdpjp` enum('true','false') DEFAULT NULL,
  `bpjs_cek_riwayat_rujukanrs` enum('true','false') DEFAULT NULL,
  `bpjs_cek_tanggal_rujukan` enum('true','false') DEFAULT NULL,
  `permintaan_lab` enum('true','false') DEFAULT NULL,
  `permintaan_radiologi` enum('true','false') DEFAULT NULL,
  `surat_indeks` enum('true','false') DEFAULT NULL,
  `surat_map` enum('true','false') DEFAULT NULL,
  `surat_almari` enum('true','false') DEFAULT NULL,
  `surat_rak` enum('true','false') DEFAULT NULL,
  `surat_ruang` enum('true','false') DEFAULT NULL,
  `surat_klasifikasi` enum('true','false') DEFAULT NULL,
  `surat_status` enum('true','false') DEFAULT NULL,
  `surat_sifat` enum('true','false') DEFAULT NULL,
  `surat_balas` enum('true','false') NOT NULL,
  `surat_masuk` enum('true','false') DEFAULT NULL,
  `pcare_cek_dokter` enum('true','false') DEFAULT NULL,
  `pcare_cek_poli` enum('true','false') DEFAULT NULL,
  `pcare_cek_provider` enum('true','false') DEFAULT NULL,
  `pcare_cek_statuspulang` enum('true','false') DEFAULT NULL,
  `pcare_cek_spesialis` enum('true','false') DEFAULT NULL,
  `pcare_cek_subspesialis` enum('true','false') DEFAULT NULL,
  `pcare_cek_sarana` enum('true','false') DEFAULT NULL,
  `pcare_cek_khusus` enum('true','false') DEFAULT NULL,
  `pcare_cek_obat` enum('true','false') DEFAULT NULL,
  `pcare_cek_tindakan` enum('true','false') DEFAULT NULL,
  `pcare_cek_faskessubspesialis` enum('true','false') DEFAULT NULL,
  `pcare_cek_faskesalihrawat` enum('true','false') DEFAULT NULL,
  `pcare_cek_faskesthalasemia` enum('true','false') DEFAULT NULL,
  `pcare_mapping_obat` enum('true','false') DEFAULT NULL,
  `pcare_mapping_tindakan` enum('true','false') DEFAULT NULL,
  `pcare_club_prolanis` enum('true','false') DEFAULT NULL,
  `pcare_mapping_poli` enum('true','false') DEFAULT NULL,
  `pcare_kegiatan_kelompok` enum('true','false') DEFAULT NULL,
  `pcare_mapping_tindakan_ranap` enum('true','false') DEFAULT NULL,
  `pcare_peserta_kegiatan_kelompok` enum('true','false') DEFAULT NULL,
  `sirkulasi_obat3` enum('true','false') DEFAULT NULL,
  `bridging_pcare_daftar` enum('true','false') DEFAULT NULL,
  `pcare_mapping_dokter` enum('true','false') DEFAULT NULL,
  `ranap_per_ruang` enum('true','false') DEFAULT NULL,
  `penyakit_ranap_cara_bayar` enum('true','false') DEFAULT NULL,
  `anggota_militer_dirawat` enum('true','false') DEFAULT NULL,
  `set_input_parsial` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_radiologi` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_lab` enum('true','false') DEFAULT NULL,
  `bpjs_cek_sep` enum('true','false') DEFAULT NULL,
  `catatan_perawatan` enum('true','false') DEFAULT NULL,
  `surat_keluar` enum('true','false') DEFAULT NULL,
  `kegiatan_farmasi` enum('true','false') DEFAULT NULL,
  `stok_opname_logistik` enum('true','false') DEFAULT NULL,
  `sirkulasi_non_medis` enum('true','false') DEFAULT NULL,
  `rekap_lab_pertahun` enum('true','false') DEFAULT NULL,
  `perujuk_lab_pertahun` enum('true','false') DEFAULT NULL,
  `rekap_radiologi_pertahun` enum('true','false') DEFAULT NULL,
  `perujuk_radiologi_pertahun` enum('true','false') DEFAULT NULL,
  `jumlah_porsi_diet` enum('true','false') DEFAULT NULL,
  `jumlah_macam_diet` enum('true','false') DEFAULT NULL,
  `payment_point2` enum('true','false') DEFAULT NULL,
  `pembayaran_akun_bayar2` enum('true','false') DEFAULT NULL,
  `hapus_nota_salah` enum('true','false') DEFAULT NULL,
  `pengkajian_askep` enum('true','false') DEFAULT NULL,
  `hais_perbangsal` enum('true','false') DEFAULT NULL,
  `ppn_obat` enum('true','false') DEFAULT NULL,
  `saldo_akun_perbulan` enum('true','false') DEFAULT NULL,
  `display_apotek` enum('true','false') DEFAULT NULL,
  `sisrute_referensi_faskes` enum('true','false') DEFAULT NULL,
  `sisrute_referensi_alasanrujuk` enum('true','false') DEFAULT NULL,
  `sisrute_referensi_diagnosa` enum('true','false') DEFAULT NULL,
  `sisrute_rujukan_masuk` enum('true','false') DEFAULT NULL,
  `sisrute_rujukan_keluar` enum('true','false') DEFAULT NULL,
  `bpjs_cek_skdp` enum('true','false') DEFAULT NULL,
  `data_batch` enum('true','false') DEFAULT NULL,
  `kunjungan_permintaan_lab` enum('true','false') DEFAULT NULL,
  `kunjungan_permintaan_lab2` enum('true','false') DEFAULT NULL,
  `kunjungan_permintaan_radiologi` enum('true','false') DEFAULT NULL,
  `kunjungan_permintaan_radiologi2` enum('true','false') DEFAULT NULL,
  `pcare_pemberian_obat` enum('true','false') DEFAULT NULL,
  `pcare_pemberian_tindakan` enum('true','false') NOT NULL,
  `pembayaran_akun_bayar3` enum('true','false') DEFAULT NULL,
  `password_asuransi` enum('true','false') DEFAULT NULL,
  `kemenkes_sitt` enum('true','false') NOT NULL,
  `siranap_ketersediaan_kamar` enum('true','false') DEFAULT NULL,
  `grafik_tb_periodelaporan` enum('true','false') DEFAULT NULL,
  `grafik_tb_rujukan` enum('true','false') DEFAULT NULL,
  `grafik_tb_riwayat` enum('true','false') DEFAULT NULL,
  `grafik_tb_tipediagnosis` enum('true','false') DEFAULT NULL,
  `grafik_tb_statushiv` enum('true','false') DEFAULT NULL,
  `grafik_tb_skoringanak` enum('true','false') DEFAULT NULL,
  `grafik_tb_konfirmasiskoring5` enum('true','false') DEFAULT NULL,
  `grafik_tb_konfirmasiskoring6` enum('true','false') DEFAULT NULL,
  `grafik_tb_sumberobat` enum('true','false') DEFAULT NULL,
  `grafik_tb_hasilakhirpengobatan` enum('true','false') DEFAULT NULL,
  `grafik_tb_hasilteshiv` enum('true','false') NOT NULL,
  `kadaluarsa_batch` enum('true','false') NOT NULL,
  `sisa_stok` enum('true','false') DEFAULT NULL,
  `obat_per_resep` enum('true','false') DEFAULT NULL,
  `pemakaian_air_pdam` enum('true','false') DEFAULT NULL,
  `limbah_b3_medis` enum('true','false') DEFAULT NULL,
  `grafik_air_pdam_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_air_pdam_perbulan` enum('true','false') DEFAULT NULL,
  `grafik_limbahb3_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_limbahb3_perbulan` enum('true','false') DEFAULT NULL,
  `limbah_domestik` enum('true','false') DEFAULT NULL,
  `grafik_limbahdomestik_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_limbahdomestik_perbulan` enum('true','false') DEFAULT NULL,
  `mutu_air_limbah` enum('true','false') DEFAULT NULL,
  `pest_control` enum('true','false') DEFAULT NULL,
  `ruang_perpustakaan` enum('true','false') DEFAULT NULL,
  `kategori_perpustakaan` enum('true','false') DEFAULT NULL,
  `jenis_perpustakaan` enum('true','false') DEFAULT NULL,
  `pengarang_perpustakaan` enum('true','false') DEFAULT NULL,
  `penerbit_perpustakaan` enum('true','false') DEFAULT NULL,
  `koleksi_perpustakaan` enum('true','false') DEFAULT NULL,
  `inventaris_perpustakaan` enum('true','false') DEFAULT NULL,
  `set_peminjaman_perpustakaan` enum('true','false') DEFAULT NULL,
  `denda_perpustakaan` enum('true','false') DEFAULT NULL,
  `anggota_perpustakaan` enum('true','false') DEFAULT NULL,
  `peminjaman_perpustakaan` enum('true','false') DEFAULT NULL,
  `bayar_denda_perpustakaan` enum('true','false') DEFAULT NULL,
  `ebook_perpustakaan` enum('true','false') DEFAULT NULL,
  `jenis_cidera_k3rs` enum('true','false') DEFAULT NULL,
  `penyebab_k3rs` enum('true','false') DEFAULT NULL,
  `jenis_luka_k3rs` enum('true','false') DEFAULT NULL,
  `lokasi_kejadian_k3rs` enum('true','false') DEFAULT NULL,
  `dampak_cidera_k3rs` enum('true','false') DEFAULT NULL,
  `jenis_pekerjaan_k3rs` enum('true','false') DEFAULT NULL,
  `bagian_tubuh_k3rs` enum('true','false') DEFAULT NULL,
  `peristiwa_k3rs` enum('true','false') DEFAULT NULL,
  `grafik_k3_pertahun` enum('true','false') DEFAULT NULL,
  `grafik_k3_perbulan` enum('true','false') DEFAULT NULL,
  `grafik_k3_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_k3_perjeniscidera` enum('true','false') DEFAULT NULL,
  `grafik_k3_perpenyebab` enum('true','false') DEFAULT NULL,
  `grafik_k3_perjenisluka` enum('true','false') DEFAULT NULL,
  `grafik_k3_lokasikejadian` enum('true','false') DEFAULT NULL,
  `grafik_k3_dampakcidera` enum('true','false') DEFAULT NULL,
  `grafik_k3_perjenispekerjaan` enum('true','false') DEFAULT NULL,
  `grafik_k3_perbagiantubuh` enum('true','false') DEFAULT NULL,
  `jenis_cidera_k3rstahun` enum('true','false') DEFAULT NULL,
  `penyebab_k3rstahun` enum('true','false') DEFAULT NULL,
  `jenis_luka_k3rstahun` enum('true','false') DEFAULT NULL,
  `lokasi_kejadian_k3rstahun` enum('true','false') DEFAULT NULL,
  `dampak_cidera_k3rstahun` enum('true','false') DEFAULT NULL,
  `jenis_pekerjaan_k3rstahun` enum('true','false') DEFAULT NULL,
  `bagian_tubuh_k3rstahun` enum('true','false') DEFAULT NULL,
  `sekrining_rawat_jalan` enum('true','false') DEFAULT NULL,
  `bpjs_histori_pelayanan` enum('true','false') DEFAULT NULL,
  `rekap_mutasi_berkas` enum('true','false') DEFAULT NULL,
  `skrining_ralan_pernapasan_pertahun` enum('true','false') DEFAULT NULL,
  `pengajuan_barang_medis` enum('true','false') DEFAULT NULL,
  `pengajuan_barang_nonmedis` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_ranapbulan` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_ranaptanggal` enum('true','false') DEFAULT NULL,
  `grafik_kunjungan_ranap_peruang` enum('true','false') DEFAULT NULL,
  `kunjungan_bangsal_pertahun` enum('true','false') DEFAULT NULL,
  `grafik_jenjang_jabatanpegawai` enum('true','false') DEFAULT NULL,
  `grafik_bidangpegawai` enum('true','false') DEFAULT NULL,
  `grafik_departemenpegawai` enum('true','false') DEFAULT NULL,
  `grafik_pendidikanpegawai` enum('true','false') DEFAULT NULL,
  `grafik_sttswppegawai` enum('true','false') DEFAULT NULL,
  `grafik_sttskerjapegawai` enum('true','false') DEFAULT NULL,
  `grafik_sttspulangranap` enum('true','false') DEFAULT NULL,
  `kip_pasien_ranap` enum('true','false') DEFAULT NULL,
  `kip_pasien_ralan` enum('true','false') DEFAULT NULL,
  `bpjs_mapping_dokterdpjp` enum('true','false') DEFAULT NULL,
  `data_triase_igd` enum('true','false') DEFAULT NULL,
  `master_triase_skala1` enum('true','false') DEFAULT NULL,
  `master_triase_skala2` enum('true','false') DEFAULT NULL,
  `master_triase_skala3` enum('true','false') DEFAULT NULL,
  `master_triase_skala4` enum('true','false') DEFAULT NULL,
  `master_triase_skala5` enum('true','false') DEFAULT NULL,
  `master_triase_pemeriksaan` enum('true','false') DEFAULT NULL,
  `master_triase_macamkasus` enum('true','false') DEFAULT NULL,
  `rekap_permintaan_diet` enum('true','false') DEFAULT NULL,
  `daftar_pasien_ranap` enum('true','false') DEFAULT NULL,
  `daftar_pasien_ranaptni` enum('true','false') DEFAULT NULL,
  `pengajuan_asetinventaris` enum('true','false') DEFAULT NULL,
  `item_apotek_jenis` enum('true','false') DEFAULT NULL,
  `item_apotek_kategori` enum('true','false') DEFAULT NULL,
  `item_apotek_golongan` enum('true','false') DEFAULT NULL,
  `item_apotek_industrifarmasi` enum('true','false') DEFAULT NULL,
  `10_obat_terbanyak_poli` enum('true','false') DEFAULT NULL,
  `grafik_pengajuan_aset_urgensi` enum('true','false') DEFAULT NULL,
  `grafik_pengajuan_aset_status` enum('true','false') DEFAULT NULL,
  `grafik_pengajuan_aset_departemen` enum('true','false') DEFAULT NULL,
  `rekap_pengajuan_aset_departemen` enum('true','false') DEFAULT NULL,
  `grafik_kelompok_jabatanpegawai` enum('true','false') DEFAULT NULL,
  `grafik_resiko_kerjapegawai` enum('true','false') DEFAULT NULL,
  `grafik_emergency_indexpegawai` enum('true','false') DEFAULT NULL,
  `grafik_inventaris_ruang` enum('true','false') DEFAULT NULL,
  `harian_HAIs2` enum('true','false') DEFAULT NULL,
  `grafik_inventaris_jenis` enum('true','false') DEFAULT NULL,
  `data_resume_pasien` enum('true','false') DEFAULT NULL,
  `perkiraan_biaya_ranap` enum('true','false') DEFAULT NULL,
  `rekap_obat_poli` enum('true','false') DEFAULT NULL,
  `rekap_obat_pasien` enum('true','false') DEFAULT NULL,
  `permintaan_perbaikan_inventaris` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_pasienbangsal` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_pasienbulan` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_laju_vap` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_laju_iad` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_laju_pleb` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_laju_isk` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_laju_ilo` enum('true','false') DEFAULT NULL,
  `grafik_HAIs_laju_hap` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_poli` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_dokter` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_tindakan_ralan` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_tindakan_ranap` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_tindakan_radiologi` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_tindakan_laborat` enum('true','false') DEFAULT NULL,
  `inhealth_mapping_tindakan_operasi` enum('true','false') DEFAULT NULL,
  `hibah_obat_bhp` enum('true','false') DEFAULT NULL,
  `asal_hibah` enum('true','false') DEFAULT NULL,
  `asuhan_gizi` enum('true','false') DEFAULT NULL,
  `inhealth_kirim_tagihan` enum('true','false') DEFAULT NULL,
  `sirkulasi_obat4` enum('true','false') DEFAULT NULL,
  `sirkulasi_obat5` enum('true','false') DEFAULT NULL,
  `sirkulasi_non_medis2` enum('true','false') DEFAULT NULL,
  `monitoring_asuhan_gizi` enum('true','false') DEFAULT NULL,
  `penerimaan_obat_perbulan` enum('true','false') DEFAULT NULL,
  `rekap_kunjungan` enum('true','false') DEFAULT NULL,
  `surat_sakit` enum('true','false') DEFAULT NULL,
  `penilaian_awal_keperawatan_ralan` enum('true','false') DEFAULT NULL,
  `permintaan_diet` enum('true','false') DEFAULT NULL,
  `master_masalah_keperawatan` enum('true','false') DEFAULT NULL,
  `pengajuan_cuti` enum('true','false') DEFAULT NULL,
  `kedatangan_pasien` enum('true','false') DEFAULT NULL,
  `utd_pendonor` enum('true','false') DEFAULT NULL,
  `toko_suplier` enum('true','false') DEFAULT NULL,
  `toko_jenis` enum('true','false') DEFAULT NULL,
  `toko_set_harga` enum('true','false') DEFAULT NULL,
  `toko_barang` enum('true','false') DEFAULT NULL,
  `penagihan_piutang_pasien` enum('true','false') DEFAULT NULL,
  `akun_penagihan_piutang` enum('true','false') DEFAULT NULL,
  `stok_opname_toko` enum('true','false') DEFAULT NULL,
  `toko_riwayat_barang` enum('true','false') DEFAULT NULL,
  `toko_surat_pemesanan` enum('true','false') DEFAULT NULL,
  `toko_pengajuan_barang` enum('true','false') DEFAULT NULL,
  `toko_penerimaan_barang` enum('true','false') DEFAULT NULL,
  `toko_pengadaan_barang` enum('true','false') DEFAULT NULL,
  `toko_hutang` enum('true','false') DEFAULT NULL,
  `toko_bayar_pemesanan` enum('true','false') DEFAULT NULL,
  `toko_member` enum('true','false') DEFAULT NULL,
  `toko_penjualan` enum('true','false') DEFAULT NULL,
  `registrasi_poli_per_tanggal` enum('true','false') DEFAULT NULL,
  `toko_piutang` enum('true','false') DEFAULT NULL,
  `toko_retur_beli` enum('true','false') DEFAULT NULL,
  `ipsrs_returbeli` enum('true','false') DEFAULT NULL,
  `ipsrs_riwayat_barang` enum('true','false') DEFAULT NULL,
  `pasien_corona` enum('true','false') DEFAULT NULL,
  `toko_pendapatan_harian` enum('true','false') DEFAULT NULL,
  `diagnosa_pasien_corona` enum('true','false') DEFAULT NULL,
  `perawatan_pasien_corona` enum('true','false') DEFAULT NULL,
  `penilaian_awal_keperawatan_gigi` enum('true','false') DEFAULT NULL,
  `master_masalah_keperawatan_gigi` enum('true','false') DEFAULT NULL,
  `toko_bayar_piutang` enum('true','false') DEFAULT NULL,
  `toko_piutang_harian` enum('true','false') DEFAULT NULL,
  `toko_penjualan_harian` enum('true','false') DEFAULT NULL,
  `deteksi_corona` enum('true','false') DEFAULT NULL,
  `penilaian_awal_keperawatan_kebidanan` enum('true','false') DEFAULT NULL,
  `pengumuman_epasien` enum('true','false') DEFAULT NULL,
  `surat_hamil` enum('true','false') DEFAULT NULL,
  `set_tarif_online` enum('true','false') DEFAULT NULL,
  `booking_periksa` enum('true','false') DEFAULT NULL,
  `toko_sirkulasi` enum('true','false') DEFAULT NULL,
  `toko_retur_jual` enum('true','false') DEFAULT NULL,
  `toko_retur_piutang` enum('true','false') DEFAULT NULL,
  `toko_sirkulasi2` enum('true','false') DEFAULT NULL,
  `toko_keuntungan_barang` enum('true','false') DEFAULT NULL,
  `zis_pengeluaran_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_penghasilan_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_ukuran_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_dinding_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_lantai_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_atap_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_kepemilikan_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_kamar_mandi_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_dapur_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_kursi_rumah_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_kategori_phbs_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_elektronik_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_ternak_penerima_dankes` enum('true','false') DEFAULT NULL,
  `zis_jenis_simpanan_penerima_dankes` enum('true','false') DEFAULT NULL,
  `penilaian_awal_keperawatan_anak` enum('true','false') DEFAULT NULL,
  `zis_kategori_asnaf_penerima_dankes` enum('true','false') DEFAULT NULL,
  `master_masalah_keperawatan_anak` enum('true','false') DEFAULT NULL,
  `master_imunisasi` enum('true','false') DEFAULT NULL,
  `zis_patologis_penerima_dankes` enum('true','false') DEFAULT NULL,
  `pcare_cek_kartu` enum('true','false') DEFAULT NULL,
  `surat_bebas_narkoba` enum('true','false') DEFAULT NULL,
  `surat_keterangan_covid` enum('true','false') DEFAULT NULL,
  `pemakaian_air_tanah` enum('true','false') DEFAULT NULL,
  `grafik_air_tanah_pertanggal` enum('true','false') DEFAULT NULL,
  `grafik_air_tanah_perbulan` enum('true','false') DEFAULT NULL,
  `lama_pelayanan_poli` enum('true','false') DEFAULT NULL,
  `hemodialisa` enum('true','false') DEFAULT NULL,
  `laporan_tahunan_irj` enum('true','false') DEFAULT NULL,
  `grafik_harian_hemodialisa` enum('true','false') DEFAULT NULL,
  `grafik_bulanan_hemodialisa` enum('true','false') DEFAULT NULL,
  `grafik_tahunan_hemodialisa` enum('true','false') DEFAULT NULL,
  `grafik_bulanan_meninggal` enum('true','false') DEFAULT NULL,
  `perbaikan_inventaris` enum('true','false') DEFAULT NULL,
  `data_klasifikasi` enum('true','false') DEFAULT NULL,
  `laporan_harian_klasifikasi` enum('true','false') DEFAULT NULL,
  `laporan_bulanan_klasifikasi` enum('true','false') DEFAULT NULL,
  `sisa_stok2` enum('true','false') DEFAULT NULL,
  `pembayaran_ralan_rsud` enum('true','false') DEFAULT NULL,
  `pembayaran_ralan_rsud2` enum('true','false') DEFAULT NULL,
  `pembayaran_ralan_rsud3` enum('true','false') DEFAULT NULL,
  `penyiapan_rm` enum('true','false') DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`,`role`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `utd_cekal_darah` */

DROP TABLE IF EXISTS `utd_cekal_darah`;

CREATE TABLE `utd_cekal_darah` (
  `no_donor` varchar(15) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `petugas_pemusnahan` varchar(20) DEFAULT NULL,
  `keterangan` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`no_donor`),
  KEY `petugas_pemusnahan` (`petugas_pemusnahan`),
  CONSTRAINT `utd_cekal_darah_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_cekal_darah_ibfk_2` FOREIGN KEY (`petugas_pemusnahan`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_detail_pemisahan_komponen` */

DROP TABLE IF EXISTS `utd_detail_pemisahan_komponen`;

CREATE TABLE `utd_detail_pemisahan_komponen` (
  `no_donor` varchar(15) DEFAULT NULL,
  `no_kantong` varchar(15) NOT NULL,
  `kode_komponen` varchar(5) DEFAULT NULL,
  `tanggal_kadaluarsa` date DEFAULT NULL,
  PRIMARY KEY (`no_kantong`),
  KEY `no_donor` (`no_donor`),
  CONSTRAINT `utd_detail_pemisahan_komponen_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_pemisahan_komponen` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_donor` */

DROP TABLE IF EXISTS `utd_donor`;

CREATE TABLE `utd_donor` (
  `no_donor` varchar(15) NOT NULL,
  `no_pendonor` varchar(15) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `tensi` varchar(7) DEFAULT NULL,
  `no_bag` int(11) DEFAULT NULL,
  `jenis_bag` enum('SB','DB','TB','QB') DEFAULT NULL,
  `jenis_donor` enum('DB','DP','DS') DEFAULT NULL,
  `tempat_aftap` enum('Dalam Gedung','Luar Gedung') DEFAULT NULL,
  `petugas_aftap` varchar(20) DEFAULT NULL,
  `hbsag` enum('Negatif','Positif') DEFAULT NULL,
  `hcv` enum('Negatif','Positif') DEFAULT NULL,
  `hiv` enum('Negatif','Positif') DEFAULT NULL,
  `spilis` enum('Negatif','Positif') DEFAULT NULL,
  `malaria` enum('Negatif','Positif') DEFAULT NULL,
  `petugas_u_saring` varchar(20) DEFAULT NULL,
  `status` enum('Aman','Cekal') DEFAULT NULL,
  PRIMARY KEY (`no_donor`),
  KEY `petugas_aftap` (`petugas_aftap`),
  KEY `petugas_u_saring` (`petugas_u_saring`),
  KEY `no_pendonor` (`no_pendonor`),
  CONSTRAINT `utd_donor_ibfk_1` FOREIGN KEY (`petugas_aftap`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_2` FOREIGN KEY (`petugas_u_saring`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_donor_ibfk_3` FOREIGN KEY (`no_pendonor`) REFERENCES `utd_pendonor` (`no_pendonor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_komponen_darah` */

DROP TABLE IF EXISTS `utd_komponen_darah`;

CREATE TABLE `utd_komponen_darah` (
  `kode` varchar(5) NOT NULL,
  `nama` varchar(70) DEFAULT NULL,
  `lama` smallint(6) DEFAULT NULL,
  `jasa_sarana` double DEFAULT NULL,
  `paket_bhp` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `manajemen` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `pembatalan` double DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_medis_rusak` */

DROP TABLE IF EXISTS `utd_medis_rusak`;

CREATE TABLE `utd_medis_rusak` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `hargabeli` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`nip`,`tanggal`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_medis_rusak_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_medis_rusak_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_pemisahan_komponen` */

DROP TABLE IF EXISTS `utd_pemisahan_komponen`;

CREATE TABLE `utd_pemisahan_komponen` (
  `no_donor` varchar(15) NOT NULL,
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `nip` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`no_donor`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_pemisahan_komponen_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_pemisahan_komponen_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_pendonor` */

DROP TABLE IF EXISTS `utd_pendonor`;

CREATE TABLE `utd_pendonor` (
  `no_pendonor` varchar(15) NOT NULL,
  `nama` varchar(40) NOT NULL,
  `no_ktp` varchar(20) NOT NULL,
  `jk` enum('L','P') NOT NULL,
  `tmp_lahir` varchar(15) NOT NULL,
  `tgl_lahir` date NOT NULL,
  `alamat` varchar(100) NOT NULL,
  `kd_kel` int(11) NOT NULL,
  `kd_kec` int(11) NOT NULL,
  `kd_kab` int(11) NOT NULL,
  `kd_prop` int(11) NOT NULL,
  `golongan_darah` enum('A','AB','B','O') NOT NULL,
  `resus` enum('(-)','(+)') NOT NULL,
  `no_telp` varchar(40) NOT NULL,
  PRIMARY KEY (`no_pendonor`),
  KEY `kd_kel` (`kd_kel`),
  KEY `kd_kec` (`kd_kec`),
  KEY `kd_kab` (`kd_kab`),
  KEY `kd_prop` (`kd_prop`),
  CONSTRAINT `utd_pendonor_ibfk_1` FOREIGN KEY (`kd_kel`) REFERENCES `kelurahan` (`kd_kel`) ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_2` FOREIGN KEY (`kd_kec`) REFERENCES `kecamatan` (`kd_kec`) ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_3` FOREIGN KEY (`kd_kab`) REFERENCES `kabupaten` (`kd_kab`) ON UPDATE CASCADE,
  CONSTRAINT `utd_pendonor_ibfk_4` FOREIGN KEY (`kd_prop`) REFERENCES `propinsi` (`kd_prop`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_pengambilan_medis` */

DROP TABLE IF EXISTS `utd_pengambilan_medis`;

CREATE TABLE `utd_pengambilan_medis` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `hargabeli` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `kd_bangsal_dr` char(5) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  `no_batch` varchar(20) NOT NULL,
  `no_faktur` varchar(20) NOT NULL,
  PRIMARY KEY (`kode_brng`,`tanggal`,`no_batch`,`no_faktur`),
  KEY `kd_bangsal_dr` (`kd_bangsal_dr`),
  KEY `jml` (`jml`),
  KEY `total` (`total`),
  KEY `hargabeli` (`hargabeli`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_pengambilan_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_pengambilan_medis_ibfk_2` FOREIGN KEY (`kd_bangsal_dr`) REFERENCES `bangsal` (`kd_bangsal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_pengambilan_penunjang` */

DROP TABLE IF EXISTS `utd_pengambilan_penunjang`;

CREATE TABLE `utd_pengambilan_penunjang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`nip`,`tanggal`),
  KEY `kode_brng` (`kode_brng`),
  KEY `nip` (`nip`),
  KEY `jml` (`jml`),
  KEY `total` (`total`),
  CONSTRAINT `utd_pengambilan_penunjang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_pengambilan_penunjang_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penggunaan_medis_donor` */

DROP TABLE IF EXISTS `utd_penggunaan_medis_donor`;

CREATE TABLE `utd_penggunaan_medis_donor` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_medis_donor_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_medis_donor_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penggunaan_medis_pemisahan_komponen` */

DROP TABLE IF EXISTS `utd_penggunaan_medis_pemisahan_komponen`;

CREATE TABLE `utd_penggunaan_medis_pemisahan_komponen` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_medis_pemisahan_komponen_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_medis_pemisahan_komponen_ibfk_3` FOREIGN KEY (`no_donor`) REFERENCES `utd_pemisahan_komponen` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penggunaan_medis_penyerahan_darah` */

DROP TABLE IF EXISTS `utd_penggunaan_medis_penyerahan_darah`;

CREATE TABLE `utd_penggunaan_medis_penyerahan_darah` (
  `no_penyerahan` varchar(17) NOT NULL,
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_medis_penyerahan_darah_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_medis_penyerahan_darah_ibfk_2` FOREIGN KEY (`no_penyerahan`) REFERENCES `utd_penyerahan_darah` (`no_penyerahan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penggunaan_penunjang_donor` */

DROP TABLE IF EXISTS `utd_penggunaan_penunjang_donor`;

CREATE TABLE `utd_penggunaan_penunjang_donor` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_penunjang_donor_ibfk_1` FOREIGN KEY (`no_donor`) REFERENCES `utd_donor` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_penunjang_donor_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penggunaan_penunjang_pemisahan_komponen` */

DROP TABLE IF EXISTS `utd_penggunaan_penunjang_pemisahan_komponen`;

CREATE TABLE `utd_penggunaan_penunjang_pemisahan_komponen` (
  `no_donor` varchar(15) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_donor`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_penunjang_pemisahan_komponen_ibfk_2` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_penunjang_pemisahan_komponen_ibfk_3` FOREIGN KEY (`no_donor`) REFERENCES `utd_pemisahan_komponen` (`no_donor`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penggunaan_penunjang_penyerahan_darah` */

DROP TABLE IF EXISTS `utd_penggunaan_penunjang_penyerahan_darah`;

CREATE TABLE `utd_penggunaan_penunjang_penyerahan_darah` (
  `no_penyerahan` varchar(17) NOT NULL DEFAULT '',
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`,`kode_brng`),
  KEY `kode_brng` (`kode_brng`),
  CONSTRAINT `utd_penggunaan_penunjang_penyerahan_darah_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penggunaan_penunjang_penyerahan_darah_ibfk_2` FOREIGN KEY (`no_penyerahan`) REFERENCES `utd_penyerahan_darah` (`no_penyerahan`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penunjang_rusak` */

DROP TABLE IF EXISTS `utd_penunjang_rusak`;

CREATE TABLE `utd_penunjang_rusak` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `jml` double DEFAULT NULL,
  `harga` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  `nip` varchar(20) NOT NULL DEFAULT '',
  `tanggal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `keterangan` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`kode_brng`,`nip`,`tanggal`),
  KEY `nip` (`nip`),
  CONSTRAINT `utd_penunjang_rusak_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penunjang_rusak_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penyerahan_darah` */

DROP TABLE IF EXISTS `utd_penyerahan_darah`;

CREATE TABLE `utd_penyerahan_darah` (
  `no_penyerahan` varchar(17) NOT NULL DEFAULT '',
  `tanggal` date DEFAULT NULL,
  `dinas` enum('Pagi','Siang','Sore','Malam') DEFAULT NULL,
  `nip_cross` varchar(20) DEFAULT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  `status` enum('Belum Dibayar','Sudah Dibayar') DEFAULT NULL,
  `kd_rek` varchar(15) DEFAULT NULL,
  `pengambil_darah` varchar(70) DEFAULT NULL,
  `alamat_pengambil_darah` varchar(120) DEFAULT NULL,
  `nip_pj` varchar(20) DEFAULT NULL,
  `besarppn` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`),
  KEY `nip` (`nip_cross`),
  KEY `kd_rek` (`kd_rek`),
  CONSTRAINT `utd_penyerahan_darah_ibfk_1` FOREIGN KEY (`nip_cross`) REFERENCES `petugas` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penyerahan_darah_ibfk_2` FOREIGN KEY (`kd_rek`) REFERENCES `rekening` (`kd_rek`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_penyerahan_darah_detail` */

DROP TABLE IF EXISTS `utd_penyerahan_darah_detail`;

CREATE TABLE `utd_penyerahan_darah_detail` (
  `no_penyerahan` varchar(17) NOT NULL DEFAULT '',
  `no_kantong` varchar(20) NOT NULL DEFAULT '',
  `jasa_sarana` double DEFAULT NULL,
  `paket_bhp` double DEFAULT NULL,
  `kso` double DEFAULT NULL,
  `manajemen` double DEFAULT NULL,
  `total` double DEFAULT NULL,
  PRIMARY KEY (`no_penyerahan`,`no_kantong`),
  KEY `no_kantong` (`no_kantong`),
  CONSTRAINT `utd_penyerahan_darah_detail_ibfk_1` FOREIGN KEY (`no_penyerahan`) REFERENCES `utd_penyerahan_darah` (`no_penyerahan`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `utd_penyerahan_darah_detail_ibfk_2` FOREIGN KEY (`no_kantong`) REFERENCES `utd_stok_darah` (`no_kantong`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_stok_darah` */

DROP TABLE IF EXISTS `utd_stok_darah`;

CREATE TABLE `utd_stok_darah` (
  `no_kantong` varchar(20) NOT NULL DEFAULT '',
  `kode_komponen` varchar(5) DEFAULT NULL,
  `golongan_darah` enum('A','AB','B','O') DEFAULT NULL,
  `resus` enum('(-)','(+)') DEFAULT NULL,
  `tanggal_aftap` date DEFAULT NULL,
  `tanggal_kadaluarsa` date DEFAULT NULL,
  `asal_darah` enum('Hibah','Beli','Produksi Sendiri') DEFAULT NULL,
  `status` enum('Ada','Diambil','Dimusnahkan') DEFAULT NULL,
  PRIMARY KEY (`no_kantong`),
  KEY `kode_komponen` (`kode_komponen`),
  CONSTRAINT `utd_stok_darah_ibfk_1` FOREIGN KEY (`kode_komponen`) REFERENCES `utd_komponen_darah` (`kode`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_stok_medis` */

DROP TABLE IF EXISTS `utd_stok_medis`;

CREATE TABLE `utd_stok_medis` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `stok` double DEFAULT NULL,
  `hargaterakhir` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  CONSTRAINT `utd_stok_medis_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `databarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `utd_stok_penunjang` */

DROP TABLE IF EXISTS `utd_stok_penunjang`;

CREATE TABLE `utd_stok_penunjang` (
  `kode_brng` varchar(15) NOT NULL DEFAULT '',
  `stok` double DEFAULT NULL,
  `hargaterakhir` double DEFAULT NULL,
  PRIMARY KEY (`kode_brng`),
  CONSTRAINT `utd_stok_penunjang_ibfk_1` FOREIGN KEY (`kode_brng`) REFERENCES `ipsrsbarang` (`kode_brng`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_atap_rumah_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_atap_rumah_penerima_dankes`;

CREATE TABLE `zis_keterangan_atap_rumah_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_dapur_rumah_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_dapur_rumah_penerima_dankes`;

CREATE TABLE `zis_keterangan_dapur_rumah_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_dinding_rumah_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_dinding_rumah_penerima_dankes`;

CREATE TABLE `zis_keterangan_dinding_rumah_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_elektronik_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_elektronik_penerima_dankes`;

CREATE TABLE `zis_keterangan_elektronik_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_jenis_simpanan_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_jenis_simpanan_penerima_dankes`;

CREATE TABLE `zis_keterangan_jenis_simpanan_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_kamar_mandi_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_kamar_mandi_penerima_dankes`;

CREATE TABLE `zis_keterangan_kamar_mandi_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_kategori_asnaf_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_kategori_asnaf_penerima_dankes`;

CREATE TABLE `zis_keterangan_kategori_asnaf_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_kategori_phbs_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_kategori_phbs_penerima_dankes`;

CREATE TABLE `zis_keterangan_kategori_phbs_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_kursi_rumah_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_kursi_rumah_penerima_dankes`;

CREATE TABLE `zis_keterangan_kursi_rumah_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_lantai_rumah_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_lantai_rumah_penerima_dankes`;

CREATE TABLE `zis_keterangan_lantai_rumah_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_patologis_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_patologis_penerima_dankes`;

CREATE TABLE `zis_keterangan_patologis_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_pengeluaran_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_pengeluaran_penerima_dankes`;

CREATE TABLE `zis_keterangan_pengeluaran_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_penghasilan_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_penghasilan_penerima_dankes`;

CREATE TABLE `zis_keterangan_penghasilan_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_ternak_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_ternak_penerima_dankes`;

CREATE TABLE `zis_keterangan_ternak_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Table structure for table `zis_keterangan_ukuran_rumah_penerima_dankes` */

DROP TABLE IF EXISTS `zis_keterangan_ukuran_rumah_penerima_dankes`;

CREATE TABLE `zis_keterangan_ukuran_rumah_penerima_dankes` (
  `kode` char(3) NOT NULL,
  `keterangan` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`kode`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
