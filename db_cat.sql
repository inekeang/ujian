-- phpMyAdmin SQL Dump
-- version 4.0.9
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2016 at 11:49 AM
-- Server version: 5.6.14
-- PHP Version: 5.5.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db_cat`
--

-- --------------------------------------------------------

--
-- Table structure for table `m_admin`
--

CREATE TABLE IF NOT EXISTS `m_admin` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `level` enum('admin','guru','siswa') NOT NULL,
  `kon_id` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

--
-- Dumping data for table `m_admin`
--

INSERT INTO `m_admin` (`id`, `username`, `password`, `level`, `kon_id`) VALUES
(1, 'ineke', '200ceb26807d6bf99fd6f4f0d1ca54d4', 'admin', 0),
(2, 'guru1', '21232f297a57a5a743894a0e4a801fc3', 'guru', 1),
(3, 'guru2', '21232f297a57a5a743894a0e4a801fc3', 'guru', 2),
(4, 'guru4', '21232f297a57a5a743894a0e4a801fc3', 'guru', 4),
(5, 'guru5', '21232f297a57a5a743894a0e4a801fc3', 'guru', 5),
(6, 'siswa1', '013f0f67779f3b1686c604db150d12ea', 'siswa', 1),
(7, 'siswa2', '331633a246a4e1ceefc9539a71fcd124', 'siswa', 2),
(8, 'siswa3', 'df8e1ec27c47f2b8223d984f87aa571e', 'siswa', 3),
(9, 'siswa4', 'be92aac38633896eb7b6781816b17c37', 'siswa', 4),
(10, 'siswa5', '829e85a9946f9d4621e7e8f544fefd54', 'siswa', 5),
(11, 'siswa6', '1061ecee1b8274545fb8c1a3da9c62ff', 'siswa', 6),
(12, 'siswa7', '0d1fd5ead0ba645b05b8c61c0d72cf46', 'siswa', 7);

-- --------------------------------------------------------

--
-- Table structure for table `m_guru`
--

CREATE TABLE IF NOT EXISTS `m_guru` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `m_guru`
--

INSERT INTO `m_guru` (`id`, `nama`) VALUES
(1, 'Dr. Susilo Bambang Yudhoyono'),
(2, 'Ir. Joko Widodo'),
(4, 'Dr. Abdulrahman Wahid'),
(5, 'Ir. Baharudin Jusuf Habibie');

--
-- Triggers `m_guru`
--
DROP TRIGGER IF EXISTS `hapus_guru`;
DELIMITER //
CREATE TRIGGER `hapus_guru` AFTER DELETE ON `m_guru`
 FOR EACH ROW BEGIN
DELETE FROM m_admin WHERE m_admin.level = 'guru' AND m_admin.kon_id = OLD.id;
DELETE FROM m_soal WHERE m_soal.id_guru = OLD.id;
DELETE FROM tr_guru_mapel WHERE tr_guru_mapel.id_guru = OLD.id;
DELETE FROM tr_guru_tes WHERE tr_guru_tes.id_guru = OLD.id;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_mapel`
--

CREATE TABLE IF NOT EXISTS `m_mapel` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `m_mapel`
--

INSERT INTO `m_mapel` (`id`, `nama`) VALUES
(1, 'Bahasa Indonesia'),
(2, 'Bahasa Inggris'),
(3, 'Matematika'),
(4, 'IPA');

--
-- Triggers `m_mapel`
--
DROP TRIGGER IF EXISTS `hapus_mapel`;
DELIMITER //
CREATE TRIGGER `hapus_mapel` AFTER DELETE ON `m_mapel`
 FOR EACH ROW BEGIN
DELETE FROM m_soal WHERE m_soal.id_mapel = OLD.id;
DELETE FROM tr_guru_mapel WHERE tr_guru_mapel.id_mapel = OLD.id;
DELETE FROM tr_guru_tes WHERE tr_guru_tes.id_mapel = OLD.id;
DELETE FROM tr_siswa_mapel WHERE tr_siswa_mapel.id_mapel = OLD.id;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_siswa`
--

CREATE TABLE IF NOT EXISTS `m_siswa` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `nama` varchar(100) NOT NULL,
  `nim` varchar(50) NOT NULL,
  `jurusan` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `m_siswa`
--

INSERT INTO `m_siswa` (`id`, `nama`, `nim`, `jurusan`) VALUES
(1, 'Agus Yudhoyono', '12090671', 'Teknik Informatika'),
(2, 'Edi Baskoro Yudhoyono', '12090672', 'Teknik Informatika'),
(3, 'Puan Maharani', '11090673', 'Sistem Informasi'),
(4, 'Kaesang Pangarep', '11090674', 'Sistem Informasi'),
(5, 'Anisa Pohan', '12090675', 'Teknik Informatika'),
(6, 'Gibran Rakabuming Raka', '11090676', 'Sistem Informasi'),
(7, 'Kahiyang Ayu', '12090677', 'Teknik Informatika');

--
-- Triggers `m_siswa`
--
DROP TRIGGER IF EXISTS `hapus_siswa`;
DELIMITER //
CREATE TRIGGER `hapus_siswa` AFTER DELETE ON `m_siswa`
 FOR EACH ROW BEGIN
DELETE FROM tr_ikut_ujian WHERE tr_ikut_ujian.id_user = OLD.id;
DELETE FROM tr_siswa_mapel WHERE tr_siswa_mapel.id_siswa = OLD.id;
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `m_soal`
--

CREATE TABLE IF NOT EXISTS `m_soal` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  `bobot` int(2) NOT NULL,
  `gambar` varchar(150) NOT NULL,
  `soal` longtext NOT NULL,
  `opsi_a` longtext NOT NULL,
  `opsi_b` longtext NOT NULL,
  `opsi_c` longtext NOT NULL,
  `opsi_d` longtext NOT NULL,
  `opsi_e` longtext NOT NULL,
  `jawaban` varchar(5) NOT NULL,
  `tgl_input` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `m_soal`
--

INSERT INTO `m_soal` (`id`, `id_guru`, `id_mapel`, `bobot`, `gambar`, `soal`, `opsi_a`, `opsi_b`, `opsi_c`, `opsi_d`, `opsi_e`, `jawaban`, `tgl_input`) VALUES
(1, 1, 1, 1, '', 'Indonesia menggunakan bahasa resmi bahasa .... ', 'Indonesia', 'Inggris', 'Prancis', 'Portugis', 'Melayu', 'A', '2015-08-27 18:20:22'),
(2, 1, 1, 1, '70thIndonesiaMerdeka.jpg', 'Gambar disamping adalah logo kemerdekaan Indonesia ke.. ', '67', '68', '69', '70', '71', 'D', '2015-08-27 18:21:02'),
(3, 1, 1, 1, '', 'Slogan peringatan HUT RI ke 70 adalah ...', 'Ayo makan.', 'Ayo minum', 'Ayo bermain', 'Ayo kerja', 'Ayo berbelanja', 'D', '2015-08-27 18:21:55'),
(4, 1, 1, 1, '', 'Bahasa Indonesia ditetapkan sebagai bahasa resmi pada tanggal ..', '20 Mei 1927', '28 Oktober 1928', '20 Mei 1928', '28 Mei 1920', '21 Juni 1917', 'B', '2015-08-27 18:23:13'),
(5, 1, 1, 1, '', 'Kalimat minimal terdiri dari pola ..', 'S-P-O', 'S-P-K', 'S-P-O-K', 'S-K', 'S-P', 'E', '2015-08-27 18:24:05'),
(6, 2, 2, 1, '', 'Table = .... (Indonesia)', 'Meja', 'Kursi', 'Lemari', 'Pintu', 'Jendela', 'A', '2015-08-27 18:24:44'),
(7, 2, 2, 1, '', 'Big = ... (indonesia)', 'Tinggi', 'Kurus', 'Panjang', 'Besar', 'Keras', 'D', '2015-08-27 18:25:22'),
(8, 2, 2, 1, '', 'Bola = .... (inggris)', 'ballon', 'ball', 'table', 'book', 'paper', 'B', '2015-08-27 18:25:57'),
(9, 2, 2, 1, '', 'I go to school by ...', 'road', 'field', 'shoes', 'drink', 'bus', 'E', '2015-08-27 18:26:48'),
(10, 2, 2, 1, '', 'Who is USA president now...', 'Ir. Jokowi', 'Angela Merkel', 'Barrack Obama', 'Tony Abbot', 'John F Kennedy', 'C', '2015-08-27 18:27:48'),
(11, 5, 3, 1, '', '2+3 = ...', '1', '2', '3', '4', '5', 'E', '2015-08-27 18:28:12'),
(12, 5, 3, 1, '', '1, 3, ..., ...., 9, 11', '4, 5', '4, 6', '5, 7', '6, 7', '1, 5', 'C', '2015-08-27 18:29:06'),
(13, 5, 3, 1, '', '(2 + 3) * 4 = ....', '20', '21', '22', '23', '24', 'A', '2015-08-27 18:29:34'),
(14, 5, 3, 1, '', '(90 / 10 ) - 5 = ...', '1', '2', '3', '4', '5', 'D', '2015-08-27 18:30:03'),
(15, 5, 3, 1, '', 'Akar dari 81 adalah ...', '7', '8', '9', '10', '11', 'C', '2015-08-27 18:30:27'),
(16, 4, 4, 1, '', 'Benda cair contohnya .. ?', 'es', 'batu', 'sirup', 'meja', 'udara', 'C', '2015-08-27 18:31:02'),
(17, 4, 4, 1, '', 'Perubahan bentuk dari cair menjadi padat disebut ...', 'menyublim', 'membeku', 'menguap', 'menghilang', 'magic', 'B', '2015-08-27 18:31:53'),
(18, 4, 4, 1, '', 'Uap air termasuk jenis benda ... ', 'gas', 'cair', 'padat', 'tidak nampak', 'panas', 'A', '2015-08-27 18:32:39'),
(19, 4, 4, 1, '', 'Yang menemukan hukum Newton adalah ...', 'George Washington', 'Georde Groban', 'George Bush', 'Issac Newton', 'Steven Gerrard', 'D', '2015-08-27 18:33:29'),
(20, 4, 4, 1, 'harga-kaca.jpg', 'Gambar di samping merupakan contoh benda ..', 'padat', 'cair', 'tak nampak', 'gas ', 'ghaib', 'A', '2015-08-27 18:34:18'),
(21, 1, 1, 1, 'images.jpg', 'Gambar di sampig adalah gambar ..', 'roti', 'batu bata', 'batu', 'kerupuk', 'nasi merah', 'B', '2015-08-27 18:46:11'),
(22, 4, 1, 1, '', 'soal', 'jawaban a', 'jawaban b', 'jawaban c', 'jawaban d', 'jawaban e', 'A', '2015-09-05 09:41:24');

-- --------------------------------------------------------

--
-- Table structure for table `tr_guru_mapel`
--

CREATE TABLE IF NOT EXISTS `tr_guru_mapel` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `tr_guru_mapel`
--

INSERT INTO `tr_guru_mapel` (`id`, `id_guru`, `id_mapel`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 4, 4),
(4, 5, 3),
(5, 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tr_guru_tes`
--

CREATE TABLE IF NOT EXISTS `tr_guru_tes` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_guru` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  `nama_ujian` varchar(200) NOT NULL,
  `jumlah_soal` int(6) NOT NULL,
  `waktu` int(6) NOT NULL,
  `jenis` enum('acak','set') NOT NULL,
  `detil_jenis` varchar(500) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `tr_guru_tes`
--

INSERT INTO `tr_guru_tes` (`id`, `id_guru`, `id_mapel`, `nama_ujian`, `jumlah_soal`, `waktu`, `jenis`, `detil_jenis`) VALUES
(1, 1, 1, 'UTS bahasa indonesia', 6, 1, 'acak', ''),
(2, 2, 2, 'UTS Bahasa Inggris', 5, 1, 'acak', ''),
(3, 1, 1, 'Ujian', 5, 1, 'acak', '');

-- --------------------------------------------------------

--
-- Table structure for table `tr_ikut_ujian`
--

CREATE TABLE IF NOT EXISTS `tr_ikut_ujian` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_tes` int(6) NOT NULL,
  `id_user` int(6) NOT NULL,
  `list_soal` longtext NOT NULL,
  `list_jawaban` longtext NOT NULL,
  `jml_benar` int(6) NOT NULL,
  `nilai` int(6) NOT NULL,
  `nilai_bobot` int(6) NOT NULL,
  `tgl_mulai` datetime NOT NULL,
  `tgl_selesai` datetime NOT NULL,
  `status` enum('Y','N') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `tr_ikut_ujian`
--

INSERT INTO `tr_ikut_ujian` (`id`, `id_tes`, `id_user`, `list_soal`, `list_jawaban`, `jml_benar`, `nilai`, `nilai_bobot`, `tgl_mulai`, `tgl_selesai`, `status`) VALUES
(1, 3, 1, '4,3,5,22,1', '4:,3:,5:,22:,1:', 0, 0, 0, '2015-10-10 11:48:53', '2015-10-10 11:49:53', 'Y');

-- --------------------------------------------------------

--
-- Table structure for table `tr_siswa_mapel`
--

CREATE TABLE IF NOT EXISTS `tr_siswa_mapel` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_siswa` int(6) NOT NULL,
  `id_mapel` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `tr_siswa_mapel`
--

INSERT INTO `tr_siswa_mapel` (`id`, `id_siswa`, `id_mapel`) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 2, 2),
(4, 3, 2),
(5, 3, 3),
(6, 4, 2),
(7, 4, 3),
(8, 5, 3),
(9, 5, 4);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
