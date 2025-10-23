-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 23, 2025 at 08:44 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `web_trgovina`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detalji_narudzbe`
--

CREATE TABLE `detalji_narudzbe` (
  `DetaljiNarudzbe_ID` int(11) NOT NULL,
  `Narudzba_ID` int(11) DEFAULT NULL,
  `Proizvod_ID` int(11) DEFAULT NULL,
  `Kolicina` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detalji_narudzbe`
--

INSERT INTO `detalji_narudzbe` (`DetaljiNarudzbe_ID`, `Narudzba_ID`, `Proizvod_ID`, `Kolicina`) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 2),
(4, 4, 4, 1),
(5, 5, 5, 1),
(6, 6, 6, 3),
(7, 7, 7, 2),
(8, 8, 8, 1),
(9, 9, 9, 1),
(10, 10, 10, 1),
(11, 11, 11, 1),
(12, 12, 12, 2),
(13, 13, 13, 1),
(14, 14, 14, 3),
(15, 15, 15, 5),
(16, 16, 16, 2),
(18, 18, 18, 1),
(19, 19, 5, 2),
(20, 20, 6, 1),
(21, 21, 7, 3),
(22, 22, 8, 1),
(23, 23, 9, 2),
(24, 24, 10, 1),
(25, 25, 11, 1),
(26, 1, 1, 1),
(27, 1, 2, 1),
(28, 2, 2, 1);

--
-- Triggers `detalji_narudzbe`
--
DELIMITER $$
CREATE TRIGGER `smanji_stanje_skladista` AFTER INSERT ON `detalji_narudzbe` FOR EACH ROW BEGIN
    
    DECLARE trenutno_stanje INT;

    SELECT StanjeNaSkladistu
    INTO trenutno_stanje
    FROM proizvod
    WHERE Proizvod_ID = NEW.Proizvod_ID;

    
    IF trenutno_stanje < NEW.Kolicina THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Nema dovoljno proizvoda na skladi??tu za ovu narud??bu';
    ELSE
        
        UPDATE proizvod
        SET StanjeNaSkladistu = StanjeNaSkladistu - NEW.Kolicina
        WHERE Proizvod_ID = NEW.Proizvod_ID;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategorija`
--

CREATE TABLE `kategorija` (
  `id_kategorija` int(11) NOT NULL,
  `ImeKategorija` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategorija`
--

INSERT INTO `kategorija` (`id_kategorija`, `ImeKategorija`) VALUES
(1, 'Laptop'),
(2, 'Računalo'),
(3, 'Komponente'),
(4, 'Pohrana'),
(5, 'Oprena za računala'),
(6, 'Mobiteli'),
(7, 'Tableti'),
(8, 'TV'),
(9, 'Audi i Video'),
(10, 'Gaming');

-- --------------------------------------------------------

--
-- Table structure for table `kosarica`
--

CREATE TABLE `kosarica` (
  `id` int(11) NOT NULL,
  `korisnik_id` int(11) NOT NULL,
  `proizvod_id` int(11) NOT NULL,
  `kolicina` int(11) NOT NULL DEFAULT 1,
  `datum_dodavanja` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kosarica`
--

INSERT INTO `kosarica` (`id`, `korisnik_id`, `proizvod_id`, `kolicina`, `datum_dodavanja`) VALUES
(14, 63, 18, 2, '2025-05-26 11:50:37'),
(32, 2, 15, 1, '2025-10-18 14:48:33'),
(33, 2, 39, 5, '2025-10-18 14:48:33'),
(46, 1, 18, 1, '2025-10-21 17:46:51'),
(47, 1, 16, 1, '2025-10-21 17:46:53'),
(48, 1, 582, 1, '2025-10-23 16:59:38'),
(49, 1, 587, 1, '2025-10-23 16:59:38'),
(50, 1, 585, 1, '2025-10-23 16:59:38'),
(51, 1, 589, 1, '2025-10-23 16:59:38'),
(52, 1, 393, 1, '2025-10-23 16:59:38');

-- --------------------------------------------------------

--
-- Table structure for table `kupac`
--

CREATE TABLE `kupac` (
  `Kupac_ID` int(11) NOT NULL,
  `Ime` varchar(50) NOT NULL,
  `Prezime` varchar(50) NOT NULL,
  `Adresa` varchar(50) NOT NULL,
  `KucniBroj` int(9) NOT NULL,
  `PostarskiBroj` int(6) NOT NULL,
  `Drzava` varchar(25) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Username` varchar(15) NOT NULL,
  `Lozinka` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kupac`
--

INSERT INTO `kupac` (`Kupac_ID`, `Ime`, `Prezime`, `Adresa`, `KucniBroj`, `PostarskiBroj`, `Drzava`, `Email`, `Username`, `Lozinka`) VALUES
(1, 'Ivan', 'Horvat', 'Trg Bana Jela??i??a', 5, 10000, 'Hrvatska', 'ivan.horvat@email.com', 'ivanhorvat', 'ivh123!'),
(2, 'Ana', 'Kova??evi??', 'Ulica Kralja Zvonimira', 12, 21000, 'Hrvatska', 'ana.kovacevic@email.com', 'anakovacevic', 'akv$456'),
(3, 'Marko', 'Novak', 'Ante Star??evi??a', 33, 51000, 'Hrvatska', 'marko.novak@email.com', 'markonovak', 'mn789@'),
(4, 'Lucija', 'Babi??', 'Bra??e Radi??a', 89, 31000, 'Hrvatska', 'lucija.babic@email.com', 'lucijababic', 'lb101#'),
(5, 'Petar', 'Peri??', 'Ljudevita Gaja', 22, 42000, 'Hrvatska', 'petar.peric@email.com', 'petarperic', 'pp202$'),
(6, 'Mia', 'Marin', 'Frankopanska', 14, 52210, 'Hrvatska', 'mia.marin@email.com', 'miamarin', 'mm303%'),
(7, 'Filip', 'Lovri??', 'Domovinskog Rata', 55, 20000, 'Hrvatska', 'filip.lovric@email.com', 'filiplovric', 'fl404!'),
(8, 'Katarina', 'Juri??', 'Ru??era Bo??kovi??a', 8, 40000, 'Hrvatska', 'katarina.juric@email.com', 'katarinajuric', 'kj505#'),
(9, 'Marija', 'Kova??', 'Matije Gupca', 21, 35000, 'Hrvatska', 'marija.kovac@email.com', 'marijakovac', 'mk606@'),
(10, 'Damir', 'Bla??', 'Zrinsko-Frankopanska', 4, 47000, 'Hrvatska', 'damir.blaz@email.com', 'damirblaz', 'db707$'),
(11, 'Ivana', 'Mili??', 'Nova Cesta', 5, 10000, 'Hrvatska', 'ivana.milic@email.com', 'ivanamilic', 'im808!'),
(12, 'Hrvoje', 'Kralj', 'Masarykova', 11, 31000, 'Hrvatska', 'hrvoje.kralj@email.com', 'hrvojekralj', 'hk909%'),
(13, 'Irena', 'Cindri??', 'Tomislavova', 10, 22000, 'Hrvatska', 'irena.cindric@email.com', 'irenacindric', 'ic010@'),
(14, 'Matej', 'Gavran', 'Jurja Barakovi??a', 3, 51000, 'Hrvatska', 'matej.gavran@email.com', 'matejgavran', 'mg111$'),
(15, 'Sandra', 'Novosel', 'Obala Kneza Trpimira', 20, 23000, 'Hrvatska', 'sandra.novosel@email.com', 'sandranovosel', 'sn212#'),
(16, 'Josip', 'Ribari??', 'Vukovarska', 18, 49290, 'Hrvatska', 'josip.ribaric@email.com', 'josipribaric', 'jr313!'),
(17, 'Laura', 'Peji??', 'Pavla Radi??a', 44, 10410, 'Hrvatska', 'laura.pejic@email.com', 'laurapejic', 'lp414@'),
(18, 'Dino', 'Tomac', '??etali??te Vladimira Nazora', 7, 21327, 'Hrvatska', 'dino.tomac@email.com', 'dinotomac', 'dt515$'),
(19, 'Elena', 'Radi??', 'Ante Star??evi??a', 6, 34000, 'Hrvatska', 'elena.radic@email.com', 'elenaradic', 'er616%'),
(20, 'Antun', 'Brekalo', 'Frankopanska', 21, 52210, 'Hrvatska', 'antun.brekalo@email.com', 'antunbrekalo', 'ab717@'),
(21, 'Tina', 'Hajduk', 'Domovinskog Rata', 99, 20000, 'Hrvatska', 'tina.hajduk@email.com', 'tinahajduk', 'th818$'),
(22, 'Nikola', 'Jurjevi??', 'Ru??era Bo??kovi??a', 27, 40000, 'Hrvatska', 'nikola.jurjevic@email.com', 'nikolajurjevic', 'nj919!'),
(23, 'Maja', 'Bari??i??', 'Trg Bana Jela??i??a', 9, 10000, 'Hrvatska', 'maja.barisic@email.com', 'majabarisic', 'mb020#'),
(24, 'Dominik', 'Brki??', 'Masarykova', 12, 31000, 'Hrvatska', 'dominik.brkic@email.com', 'dominikbrkic', 'db121$'),
(25, 'Natalija', 'Dragi??', 'Nova Cesta', 34, 10040, 'Hrvatska', 'natalija.dragic@email.com', 'natalijadragic', 'nd222@'),
(55, 'Marko', 'Horvat', 'Ulica 1', 12, 10000, 'Hrvatska', 'marko@example.com', 'markoh', 'lozinka123'),
(56, 'Ana', 'Kova??', 'Ulica 2', 34, 31000, 'Hrvatska', 'ana@example.com', 'anak', 'tajna456'),
(63, 'Darijan', 'Va??atko', 'Ivana Cankara', 5, 43500, 'Hrvatska', 'darijanko114@gmail.com', 'darijan.vasatko', '$2y$10$6MjLqe4awGDxJXvTeZIE5u5MidkdyyB/ghvD/quexvMzUHuo3L7ZK'),
(64, 'Darijan', 'Va??atko', 'Ivana Cankara', 5, 43500, 'Hrvatska', 'darijanko112@gmail.com', 'vdarijan', '$2y$10$V/JkZmH6LMXGJGv69RsSi.qCGEOxJij2vj1ruhO7LStcGvFx5JHCK'),
(65, 'Dominik', 'Du??ek', '??ibovac', 119, 43500, 'Hrvatska', 'broooooooooo224424@gmail.com', 'DuleLegenda', '$2y$10$ApkYh8M281Ybf.vYHHtIrO3yfmoKIbbb2Z88evggjun958hnIipUa'),
(66, 'Darijan', 'Va??atko', 'Ivana Cankara', 5, 43500, 'Hrvatska', 'test@gmail.com', 'test', '$2y$10$.7NLQ1SVX66O1KNw79R40uFA9B7HPOVz5eKoBX9XfxR/kXOITRhW.');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_09_24_193436_create_kupac_table', 1),
(5, '2025_09_24_193451_create_proizvod_table', 1),
(6, '2025_09_24_193455_create_kategorija_table', 1),
(7, '2025_09_24_193500_create_tip_proizvoda_table', 1),
(8, '2025_09_24_193505_create_kosarica_table', 1),
(9, '2025_09_24_193511_create_narudzba_table', 1),
(10, '2025_09_24_193515_create_detalji_narudzbe_table', 1),
(11, '2025_09_24_193519_create_nacin_placanja_table', 1),
(12, '2025_09_24_193436_create_kupac_table', 1),
(13, '2025_09_24_193451_create_proizvod_table', 1),
(14, '2025_09_24_193455_create_kategorija_table', 1),
(15, '2025_09_24_193500_create_tip_proizvoda_table', 1),
(16, '2025_09_24_193505_create_kosarica_table', 1),
(17, '2025_09_24_193511_create_narudzba_table', 1),
(18, '2025_09_24_193515_create_detalji_narudzbe_table', 1),
(19, '2025_09_24_193519_create_nacin_placanja_table', 1),
(20, '2025_10_01_073148_create_proizvods_table', 2),
(21, '2025_10_21_152118_split_name_in_users_table', 3),
(22, '2025_10_21_164522_create_user_addresses_table', 4),
(23, '2025_10_21_170454_update_user_addresses_table_remove_name_columns', 5),
(24, '2025_10_23_170502_add_telefon_to_users_table', 6);

-- --------------------------------------------------------

--
-- Table structure for table `nacin_placanja`
--

CREATE TABLE `nacin_placanja` (
  `NacinPlacanja_ID` int(11) NOT NULL,
  `Opis` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nacin_placanja`
--

INSERT INTO `nacin_placanja` (`NacinPlacanja_ID`, `Opis`) VALUES
(1, 'Revolut Pay'),
(2, 'KeksPay'),
(3, 'Skrill'),
(4, 'PayPal'),
(7, 'Kartično plaćanje'),
(9, 'Plaćanje pouzećem'),
(10, 'Google Pay'),
(11, 'Apple Pay'),
(12, 'Bankovni prijenos');

-- --------------------------------------------------------

--
-- Table structure for table `narudzba`
--

CREATE TABLE `narudzba` (
  `Narudzba_ID` int(11) NOT NULL,
  `Kupac_ID` int(11) DEFAULT NULL,
  `NacinPlacanja_ID` int(11) DEFAULT NULL,
  `Datum_narudzbe` date NOT NULL,
  `Ukupni_iznos` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `narudzba`
--

INSERT INTO `narudzba` (`Narudzba_ID`, `Kupac_ID`, `NacinPlacanja_ID`, `Datum_narudzbe`, `Ukupni_iznos`) VALUES
(1, 1, 2, '2024-06-17', 995.00),
(2, 2, 1, '2024-06-18', 238.00),
(3, 3, 3, '2024-06-19', 33.00),
(4, 4, 2, '2024-06-20', 120.00),
(5, 5, 1, '2024-06-21', 179.99),
(6, 6, 3, '2024-06-22', 75.99),
(7, 7, 2, '2024-06-23', 89.99),
(8, 8, 1, '2024-06-24', 105.99),
(9, 9, 3, '2024-06-25', 119.50),
(10, 10, 2, '2024-06-26', 210.00),
(11, 11, 1, '2024-06-27', 155.00),
(12, 12, 3, '2024-06-28', 45.50),
(13, 13, 2, '2024-06-29', 215.00),
(14, 14, 1, '2024-06-30', 59.50),
(15, 15, 3, '2024-07-01', 12.00),
(16, 16, 2, '2024-07-02', 25.00),
(17, 17, 1, '2024-07-03', 89.99),
(18, 18, 3, '2024-07-04', 144.50),
(19, 19, 2, '2024-07-05', 210.00),
(20, 20, 1, '2024-07-06', 238.00),
(21, 21, 3, '2024-07-07', 155.00),
(22, 22, 2, '2024-07-08', 75.99),
(23, 23, 1, '2024-07-09', 105.99),
(24, 24, 3, '2024-07-10', 59.50),
(25, 25, 2, '2024-07-11', 119.50),
(26, 1, 2, '2024-12-01', 1354.99),
(27, 2, 1, '2024-12-02', 518.99),
(28, 3, 2, '2024-12-03', 1086.98),
(29, 4, 3, '2024-12-04', 188.50),
(30, 5, 1, '2024-12-05', 400.00),
(31, 6, 2, '2024-12-06', 406.98),
(32, 7, 3, '2024-12-07', 175.49),
(33, 8, 2, '2024-12-08', 311.99),
(34, 9, 1, '2024-12-09', 310.49),
(35, 10, 2, '2024-12-10', 167.49),
(36, 1, 1, '2025-03-01', 7649.98),
(37, 2, 2, '2025-03-02', 149.99);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proizvod`
--

CREATE TABLE `proizvod` (
  `Proizvod_ID` int(11) NOT NULL,
  `sifra` varchar(50) NOT NULL,
  `Naziv` varchar(100) NOT NULL,
  `Opis` text DEFAULT NULL,
  `Cijena` decimal(10,2) NOT NULL,
  `KratkiOpis` text DEFAULT NULL,
  `kategorija` int(11) NOT NULL,
  `StanjeNaSkladistu` int(11) NOT NULL,
  `Slika` varchar(5000) DEFAULT NULL COMMENT 'Putanja do slike na disku',
  `tip_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `proizvod`
--

INSERT INTO `proizvod` (`Proizvod_ID`, `sifra`, `Naziv`, `Opis`, `Cijena`, `KratkiOpis`, `kategorija`, `StanjeNaSkladistu`, `Slika`, `tip_id`) VALUES
(1, '420635866419203', 'Laptop HP Pavilion', '15.6', 995.00, NULL, 1, 10, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 51),
(2, '489472286923658', 'Monitor Dell', '27', 238.00, NULL, 5, 18, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(3, '513933606740020', 'Miš Logitech', 'Bežični miš', 33.00, NULL, 5, 50, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(4, '878750325810476', 'Tipkovnica Corsair', 'Mehanička tipkovnica', 120.00, NULL, 5, 30, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(5, '916482860256714', 'Grafička kartica GTX 1650', '4GB GDDR6', 179.99, NULL, 3, 15, 'uploads/products/product_5_682b531491006.jpeg', 4),
(6, '120301646838960', 'SSD Kingston 500GB', 'NVMe PCIe 3.0', 75.99, NULL, 4, 25, 'uploads/products/product_6_682b52f23e66d.jpeg', 8),
(7, '853225904750917', 'RAM Corsair Vengeance 16GB', 'DDR4 3200MHz', 89.99, NULL, 3, 40, 'uploads/products/product_7_682b531a776de.jpeg', 7),
(8, '986384991342014', 'Napajanje Corsair 650W', 'Modularno', 105.99, NULL, 3, 18, 'uploads/products/product_8_682b530d817de.jpeg', 10),
(9, '512679540770866', 'Kučište NZXT H510', 'ATX mid tower', 119.50, NULL, 3, 22, 'uploads/products/product_9_682b53079cbf5.jpeg', 11),
(10, '685032126697331', 'Procesor Ryzen 5 5600X', '6 jezgri, 12 dretvi', 210.00, NULL, 3, 8, 'uploads/products/product_10_67e2fa07645fe.jpg', 5),
(11, '685032126697331', 'Monitor Samsung 24', 'Full HD LED', 155.00, NULL, 5, 17, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(12, '140652170418473', 'HDD WD Blue 1TB', '7200rpm', 45.50, NULL, 4, 60, 'uploads/products/product_12_682b52e8c33a0.jpeg', 9),
(13, '878077845335664', 'Printer Epson L3150', 'Inkjet, WiFi', 215.00, NULL, 5, 12, 'uploads/products/product_13_682b52bc21a0d.jpeg', 39),
(14, '785804491289448', 'Miš Razer DeathAdder', 'Gaming miš', 59.50, NULL, 5, 35, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(15, '988826881917199', 'Ventilator Arctic F12', '120mm hladnjak', 12.00, NULL, 3, 100, 'uploads/products/product_15_682b52ff60908.jpeg', 12),
(16, '293429082709619', 'USB Hub Anker', '4 USB 3.0 priključka', 25.00, NULL, 4, 45, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 18),
(18, '288754726913537', 'Matična ploča ASUS B550', 'Za Ryzen procesore', 144.50, NULL, 3, 14, 'uploads/products/product_18_682b52f92d6cd.jpeg', 6),
(39, '0', 'SSD Crucial BX500', 'Ovo je SSD', 21.10, NULL, 4, 32, 'uploads/products/product_39_683451723d7ed.jpg', 8),
(40, 'PRD-160SH', 'Nulla vero ipsam', 'Sequi cupiditate exercitationem aut cum est tempora. Et praesentium veritatis aut esse. Aut harum quos tempore incidunt id consequatur. Aut pariatur natus aut earum enim iste. Quibusdam quo consequatur nostrum eveniet possimus magni fugiat. Reprehenderit omnis excepturi ipsum nam id mollitia.', 808.41, 'Iste corrupti dolores praesentium consequatur quia cupiditate.', 4, 10, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(41, 'PRD-140LK', 'In voluptatem quasi', 'Corporis cumque harum harum odio enim. Consequuntur dolorum vel quia laborum. Et itaque et dolore consectetur. Dolorem nobis ex rem. Voluptas temporibus eaque eos nisi et minus beatae inventore. Consequatur qui magni veniam vel. Animi sit et aut amet.', 419.99, 'Quos voluptatem necessitatibus non alias perferendis.', 1, 81, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(42, 'PRD-098LH', 'Voluptatem ut itaque', 'Nihil deserunt voluptatem vero aut. Reiciendis delectus quis excepturi neque atque. Praesentium neque dolorem quidem enim ipsa mollitia placeat. Minus dolore itaque perferendis vel et sunt quaerat. Aut beatae amet tenetur. Excepturi dolorem temporibus numquam sint ipsa voluptas officia omnis.', 1924.52, 'Voluptas pariatur fuga beatae mollitia sequi recusandae vel reprehenderit assumenda.', 4, 4, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(43, 'PRD-113EV', 'Molestiae ad dignissimos', 'Repellat quia atque ut quam aut impedit autem. Aspernatur labore officiis consectetur consequatur aut. Id et dolorem quisquam voluptatem atque. Quam sit inventore consequuntur maxime. Velit praesentium architecto quia itaque eos cupiditate laudantium. Aspernatur dolores totam commodi quae.', 569.79, 'Corporis qui distinctio maxime nulla aperiam laboriosam explicabo.', 5, 6, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(44, 'PRD-712AD', 'Doloremque exercitationem ad', 'Harum molestias voluptatem perspiciatis. Quia cupiditate sapiente assumenda nihil unde. Et nemo voluptates eveniet nisi ipsum ratione assumenda molestiae. Labore at saepe aut vel aspernatur porro nemo. Et reprehenderit cumque accusantium aliquam ut. Nobis earum deleniti aliquid et ut consequatur fuga. Eos molestias neque aut eaque officiis laboriosam.', 1348.08, 'Sit cumque vel nobis earum dignissimos culpa.', 2, 52, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(45, 'PRD-596GL', 'Veritatis dicta similique', 'Vel eos dignissimos fugit qui itaque quo excepturi. Ipsum consequatur sit maxime rerum animi exercitationem aliquid. Amet et sed natus labore enim laborum aperiam. Totam delectus quo possimus libero occaecati deleniti.', 1292.01, 'Explicabo aut et et quos deserunt alias atque.', 5, 69, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(46, 'PRD-455ST', 'Harum inventore porro', 'Totam vel dicta in ipsum quas cumque accusamus. Architecto tempore ipsa quo modi architecto ea quam. Illum dolorem eveniet inventore qui. Inventore quo dolorum corporis. Distinctio et quo vel quo possimus et.', 964.32, 'Numquam eius quaerat repellat est blanditiis iure aliquam odit sit.', 5, 27, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(47, 'PRD-676IP', 'Qui ut blanditiis', 'Ad consequatur sequi praesentium doloremque debitis pariatur alias similique. Nemo repudiandae labore et ea enim. Eveniet consequatur autem illum velit praesentium. Non quos fugit et accusamus quia.', 1634.64, 'Doloremque nulla ut in et quos facere similique omnis illum.', 5, 43, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(48, 'PRD-645LB', 'Est quasi eius', 'Ducimus aut suscipit ex veniam inventore est iste est. Velit aut rem ut et. Qui veritatis natus quia recusandae qui tempora. Optio velit ea dolorum dolor voluptas aperiam. Dolorem illum tempora minus.', 118.53, 'Et eum nulla non eos doloremque veniam praesentium similique reiciendis consequatur.', 4, 62, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(49, 'PRD-064PT', 'Quidem nostrum aut', 'Ad eligendi enim ea explicabo. Ut eum et iusto molestias laboriosam possimus placeat. Repellendus laborum temporibus nihil enim delectus et suscipit. Sit labore autem pariatur est labore. Dolore omnis consequatur voluptates voluptas reiciendis corporis. Dignissimos qui ut consequatur exercitationem autem nihil iusto. Molestiae blanditiis pariatur fuga quod magnam sed.', 1773.87, 'Odit possimus ut quia qui.', 6, 24, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(50, 'PRD-687ZL', 'Quod ullam quibusdam', 'Voluptas facilis velit nisi fugit. Dolorum qui fugit inventore nihil eos esse. Fuga est nulla adipisci nemo exercitationem. Molestias veritatis omnis provident nemo molestiae aut laudantium.', 1830.43, 'Rerum et repellendus quas in et.', 4, 54, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(51, 'PRD-021ZU', 'In sint ut', 'Modi repellat deleniti fugiat inventore. Odio et molestiae id dolorum omnis. Facilis quia mollitia et quam eaque autem at. Ex nemo culpa ea quasi et.', 1364.69, 'Illo provident deserunt reiciendis sint consequatur cupiditate est quia saepe.', 3, 41, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(52, 'PRD-279FR', 'Soluta odio eius', 'Autem aliquam illo distinctio. Et distinctio qui accusamus. Cum dicta officia nobis ducimus quod aspernatur mollitia. Illo ad omnis et voluptatum sed assumenda occaecati. Aut quod nemo nisi incidunt nam aut dolores quos. Harum voluptas officia quia porro commodi autem unde mollitia.', 1618.21, 'Inventore molestiae et quo perspiciatis ipsum.', 5, 92, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(53, 'PRD-144NL', 'Velit reiciendis placeat', 'Placeat est voluptatem sed quas provident. Vero dolor consequatur pariatur velit enim labore aut aliquid. Sed qui quo sit excepturi est rerum. Doloribus corrupti exercitationem sunt amet accusamus facilis aut sit.', 292.72, 'Eaque dolorem velit ut velit dolores tempora.', 2, 51, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(54, 'PRD-808LV', 'Possimus et eos', 'Est error sint nostrum sunt similique. Occaecati voluptas molestias et voluptatum. Ad provident possimus esse est. Ut corrupti aut eos deserunt asperiores et rem at.', 1899.29, 'Culpa non minus officia sed magnam.', 5, 90, 'uploads/products/product_11_682b52c31797e.jpeg', 2),
(55, 'PRD-369CO', 'Voluptates dolorem reprehenderit', 'Expedita soluta illum expedita fugit. Et expedita quis voluptatibus dolorem est. Deserunt quo molestias asperiores quae laudantium corrupti voluptas est. Provident totam qui quibusdam nisi consequatur dolorum iure. Ut accusamus sed alias praesentium et.', 635.03, 'Commodi optio sit ut neque corporis quia ut.', 5, 37, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(56, 'PRD-579CK', 'Ipsa delectus impedit', 'Nisi omnis laudantium doloribus non at at maxime. Maiores iusto enim vero rem ea necessitatibus sapiente. Iusto corrupti perferendis dolores et. Possimus adipisci magnam est. Architecto doloribus hic quibusdam illum repellendus voluptatem at. Enim ex libero quae reprehenderit.', 1427.76, 'Doloremque nisi cumque sint nihil.', 1, 85, 'uploads/products/product_14_682b52b3204d2.jpeg', 3),
(57, 'PRD-583GP', 'Fugiat perspiciatis mollitia', 'Molestias unde fugiat dignissimos illo reprehenderit. Ratione quas ducimus excepturi officiis reiciendis consectetur. Et adipisci quia dolorem voluptas tenetur sint. Omnis voluptatem qui autem iste. Aut autem officia nihil perferendis ut enim maiores. Fuga iste sit sit accusantium repellendus et.', 949.16, 'Ratione odit aut deserunt error sunt explicabo.', 6, 42, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(58, 'PRD-656CR', 'Esse explicabo voluptas', 'Necessitatibus ipsam ullam quo enim quos. Ullam beatae aut eum consectetur. Aliquam consectetur sit voluptas rerum perferendis. Dolores qui soluta rerum repudiandae molestiae voluptatibus. Alias error eos molestias est dolorum alias. Dicta autem possimus dolores modi.', 1503.34, 'Facere nihil nobis error et nihil.', 4, 75, 'uploads/products/product_14_682b52b3204d2.jpeg', 3),
(59, 'PRD-646AM', 'Fuga esse et', 'Eaque et autem voluptatum dolores earum cum quae. Quam id rem ad ullam nisi. Maiores alias qui corporis eveniet et non sapiente. Distinctio voluptatem adipisci nihil.', 1684.80, 'Voluptatem rerum molestias autem sit.', 3, 76, 'uploads/products/default.jpg', 3),
(60, 'PRD-078JI', 'Voluptatibus in doloremque', 'Aut rem consequuntur sed fugit. Omnis cumque porro voluptatibus natus voluptatum rerum minus. Eligendi eum recusandae reiciendis facere qui asperiores. Distinctio nihil eum aperiam distinctio. Et aut id sed quae. Qui dolorem non in sit ex. Ipsum et nobis aliquam.', 709.58, 'Vel illo nostrum qui iure nulla blanditiis dolores amet nihil.', 6, 52, 'uploads/products/product_14_682b52b3204d2.jpeg', 3),
(61, 'PRD-900RI', 'Laudantium sequi tenetur', 'Molestiae et officiis perferendis eos atque id. Et temporibus laboriosam deleniti culpa animi excepturi modi. Sunt ut itaque quae voluptatem facere officiis. Saepe ab odio porro doloribus explicabo sit earum. Consequatur sunt qui maxime in totam enim eligendi fugit. A impedit non aut dolorem id fugiat sunt in. Beatae cupiditate officia numquam.', 938.53, 'Exercitationem aut reprehenderit et tempore recusandae dolorem.', 5, 16, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(62, 'PRD-952RA', 'Suscipit nemo necessitatibus', 'Id fugit quis sed earum. Harum corporis earum quo id. Reprehenderit eum quas vero aliquid. Voluptatem molestias vel quasi id tenetur eum. Qui animi doloribus qui placeat. Autem debitis temporibus fugit totam esse nam debitis. Earum dicta ut et tempore deserunt temporibus et autem.', 708.65, 'Neque qui aspernatur qui perspiciatis esse error sequi.', 6, 90, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(63, 'PRD-255VK', 'Magni voluptatem aut', 'Est ipsam eum sit voluptatum dolorum consequatur. Sint dolore officia impedit et. Quia sed earum quis eius numquam et. Et quidem voluptas libero et ab earum. Quos similique dolores porro quia libero accusantium. Dolore vel ex repellat aut. Quos dolores totam id.', 1243.39, 'In fugit sit provident minus beatae.', 2, 79, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(64, 'PRD-554ZG', 'In deserunt ipsam', 'Quisquam voluptatum harum voluptas consequatur qui. Ab sint laboriosam est. Fuga dolorem explicabo placeat qui magnam reprehenderit laboriosam eaque. Perferendis et nesciunt commodi odio sint accusamus sapiente. Qui aut magni molestiae sed et consequuntur non.', 725.00, 'Voluptatem dolorum non quia enim dolores dignissimos quas.', 4, 56, 'uploads/products/product_15_682b52ff60908.jpeg', 3),
(65, 'PRD-446II', 'Deserunt voluptas sed', 'Quisquam eum error quos nihil. Consequuntur deserunt quia quia dolores. Dolores ratione occaecati non fugit. Deserunt aperiam aut fugiat maxime aliquid ipsum rem. Quis a mollitia laborum voluptas dolores quisquam soluta.', 1499.29, 'Doloremque rem nihil soluta quibusdam ea quia sit autem voluptatum.', 6, 4, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(66, 'PRD-057TW', 'Consequuntur non nulla', 'Saepe quis consequuntur beatae ut assumenda ea. Saepe exercitationem et temporibus esse voluptates autem ea. Tenetur velit sed vel repellat facilis rerum. Omnis nulla exercitationem qui delectus placeat suscipit. Qui corrupti quo ea est harum.', 1567.95, 'Aperiam et quibusdam consectetur nostrum soluta ea.', 6, 55, 'uploads/products/product_12_682b52e8c33a0.jpeg', 2),
(67, 'PRD-850SE', 'Harum repellendus dolores', 'Et porro unde pariatur cupiditate dolor quibusdam doloribus eum. Est accusantium consequatur non aperiam occaecati facere. Voluptates eos asperiores qui maxime repellendus numquam. Placeat asperiores quia velit illo eligendi autem distinctio. Dolorum et alias voluptatum nobis doloremque quas.', 1668.10, 'Soluta molestiae architecto ut voluptates dolorum qui corporis iure ea culpa.', 5, 23, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(68, 'PRD-614BD', 'Dolorem hic excepturi', 'Laborum veritatis rerum facere sapiente est. Illo est non ipsam optio temporibus qui ullam. Qui suscipit error corrupti quo et molestiae. Voluptas dolores et sit labore nemo. Facere est cum est provident. Hic optio debitis veritatis et ut sunt. Voluptas enim quidem aut non nesciunt et.', 1052.74, 'Vel qui est corrupti voluptatem ratione id doloremque culpa mollitia.', 2, 81, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(69, 'PRD-187LR', 'Aut dolores amet', 'Quisquam magni ipsum in quasi voluptas. Eos totam perferendis voluptatum voluptas nobis qui omnis eaque. Sed rerum aut quo qui vitae est voluptates. Omnis repellendus laborum voluptate delectus. Incidunt quod molestiae aperiam aut sit nostrum sint. Quidem reiciendis aliquid omnis voluptatem facilis. Et dolores magni dolorum et repudiandae minima.', 176.82, 'Quis molestias natus reprehenderit quis quae expedita illum totam atque.', 6, 8, 'uploads/products/product_5_682b531491006.jpeg', 1),
(70, 'PRD-155UQ', 'Sed dolorem esse', 'Veritatis pariatur veniam praesentium cupiditate sit. Non error reiciendis voluptas deleniti corporis sit. Doloribus blanditiis facere sit dignissimos. Recusandae incidunt deleniti harum alias aut debitis officia. Enim dolorum aspernatur laudantium perspiciatis non velit est.', 737.26, 'Beatae voluptas est est quia nemo voluptatem.', 1, 38, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(71, 'PRD-968SC', 'Natus labore id', 'Excepturi quo fugit dolore nihil voluptas. Ea fugit dolores quidem eius vero. Nihil animi ipsam molestias id. Saepe ex non reiciendis est non. Cumque suscipit et accusantium sed. Ipsum ea ut ut laudantium autem. Quaerat eius officia et debitis corrupti exercitationem.', 707.02, 'Sed qui veniam deserunt officia dolorem enim sed.', 5, 41, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(72, 'PRD-549AE', 'Rerum praesentium iure', 'Necessitatibus maiores possimus deleniti ex recusandae. Nulla ratione amet neque est distinctio reprehenderit. Dolores aspernatur repellat voluptatem fugiat quia molestiae. Sed eos autem magnam aut. Ullam non quo nobis dolorem sint eveniet.', 952.61, 'Earum qui debitis aspernatur est est praesentium id nesciunt.', 4, 15, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(73, 'PRD-209JV', 'Est et omnis', 'Reiciendis tempore dolorum provident vel impedit. Voluptatem nostrum qui qui consectetur corrupti. Est quia ea et nihil ut. Vitae est odit modi deleniti rem aut ut occaecati. Et iusto laborum enim consequatur iure provident quo.', 1431.21, 'Modi dolorum repudiandae sint quibusdam voluptates et excepturi architecto.', 4, 6, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(74, 'PRD-435HP', 'Est iste reprehenderit', 'Aspernatur beatae vel doloribus nihil magnam libero vel. Laboriosam recusandae ut libero rerum nobis quia quaerat. Esse reiciendis sit minima eius hic rerum. Eum sit aut assumenda quos sed consequuntur omnis perferendis. Autem possimus qui quos. Eos exercitationem corrupti amet officia a quis fugiat.', 609.36, 'Ut fugit nisi sint molestiae asperiores labore accusamus temporibus.', 4, 62, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(75, 'PRD-335GT', 'Temporibus libero ab', 'Qui porro aut dolorem et ullam nostrum. Cupiditate ipsam perferendis voluptatem culpa. Aut repellendus qui id sunt quibusdam quia deserunt. Sint eum aut provident est ut sapiente.', 1431.79, 'Enim nihil quidem aliquid commodi aut.', 5, 57, 'uploads/products/default.jpg', 3),
(76, 'PRD-385HE', 'Esse dicta itaque', 'Ipsam eum itaque explicabo eos. Enim quia est dignissimos. Quo qui illo quo reiciendis sequi accusamus quia. Qui voluptas et occaecati minus et. Labore aperiam ut quasi doloribus. Aliquid mollitia quae est magnam.', 1784.20, 'Velit possimus ut architecto a tempore sequi modi.', 2, 63, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 3),
(77, 'PRD-245DG', 'Quia numquam molestiae', 'Sint rerum esse sit dolore quae quos. Natus nam sint et. Nihil quisquam maiores occaecati id. Exercitationem quidem culpa facere magnam omnis. Dolorem tempora aspernatur qui cupiditate. Consequuntur quasi beatae libero sunt qui. Esse dignissimos quo dolor et optio.', 876.26, 'Dolor aut dicta quod qui dolores quia ullam vel a vel ratione.', 6, 27, 'uploads/products/product_12_682b52e8c33a0.jpeg', 3),
(78, 'PRD-395NE', 'Laudantium aliquid dolore', 'Doloremque ut ab sed consectetur voluptatem. Voluptatem et sapiente voluptas ut voluptas ut aut totam. Hic rerum quas aut deleniti laudantium at. Esse vel occaecati voluptatem accusamus.', 1948.36, 'Aut dolor nulla voluptas impedit mollitia non consequatur.', 3, 53, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(79, 'PRD-227XV', 'In dolore corporis', 'Voluptatem dolorem blanditiis ipsam magni optio. Numquam modi tempora voluptate voluptatem consequatur tempora. Voluptatem distinctio unde hic fugit illum provident. Quia et sapiente voluptatem est.', 348.71, 'Placeat qui aliquam ipsa facere officia quos vitae illum non deleniti.', 2, 85, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(80, 'PRD-808FD', 'Ullam asperiores molestiae', 'Dolores sit omnis autem quas enim quo animi. Est doloribus pariatur non officia harum nihil. Nobis tempora esse recusandae nihil exercitationem qui minima. Eum dolor est officia alias. Voluptates consequatur quia minima quia expedita voluptate. Consequatur ab totam laborum nam aut consequatur aliquam.', 933.20, 'Odio voluptatem id reiciendis eos autem explicabo eum cupiditate.', 1, 37, 'uploads/products/product_5_682b531491006.jpeg', 2),
(81, 'PRD-526TZ', 'Nesciunt ad optio', 'Voluptatem est voluptatum deserunt quia ipsa sit. Magnam repellendus maxime quam ab. A est nihil voluptas et earum aperiam. Dicta exercitationem ex autem saepe labore. Perferendis ab eos architecto ipsam atque non.', 312.31, 'Molestias earum qui laborum quidem.', 4, 98, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 1),
(82, 'PRD-808GQ', 'At architecto dolores', 'Quo temporibus sit sed est eum. Qui rem qui sint nobis quo aut cumque. Similique nihil rerum eos qui. Et accusamus nostrum commodi consequuntur odit. Nobis omnis et aut iste non hic.', 1629.32, 'Porro animi nihil quia deleniti labore ut nesciunt impedit numquam.', 4, 79, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(83, 'PRD-619AB', 'Esse modi quia', 'Necessitatibus ipsum ipsa enim voluptas enim consectetur. Qui amet dolore et. Omnis corporis sequi quas voluptates optio iste dignissimos veritatis. Officiis ut sit blanditiis. Et nobis aut ut consequatur rerum. Dolorem aperiam qui voluptatibus incidunt inventore ipsum iste. Soluta nam aliquid similique et accusamus ipsam.', 457.11, 'Doloremque quis fugiat dolores accusamus in est.', 5, 20, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(84, 'PRD-343FZ', 'Fugiat iure quasi', 'A id voluptatibus est et facilis. Explicabo quibusdam laborum est eligendi eligendi ex. Et aut laborum quis quidem ab enim. Est laudantium nisi reprehenderit maiores. Voluptas dolorum ab vero quidem et itaque qui exercitationem. Optio mollitia a eaque pariatur. Suscipit ea consequatur quod accusamus.', 482.24, 'Aut dolores sunt voluptate repellat fuga quos consequatur dolorem.', 2, 66, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(85, 'PRD-547KD', 'Delectus sed fugiat', 'Repudiandae fugiat exercitationem veniam doloremque voluptatem autem dolor. Quaerat molestiae rerum eos porro. Optio distinctio occaecati amet aut ratione. Dolores ea at molestias. Culpa asperiores eius sequi deserunt maiores. Ex rerum molestiae sint veritatis sapiente rem.', 955.47, 'Labore reiciendis earum deleniti odit eos dolores enim beatae fuga.', 4, 68, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(86, 'PRD-319OQ', 'Vitae eos perspiciatis', 'Et quis maxime dolores voluptas eaque. Numquam expedita aut itaque consequatur explicabo dolor. Quibusdam ratione delectus animi totam cupiditate praesentium illum quia. Ipsa labore iure qui cupiditate qui. Sed assumenda tempora dolore ipsa quia blanditiis sequi. Nihil voluptate et corporis in enim suscipit similique. Illo tenetur eum in fugiat quaerat esse commodi.', 1156.25, 'Sapiente et fugit at eaque dolor vitae consectetur numquam.', 1, 25, 'uploads/products/product_11_682b52c31797e.jpeg', 1),
(87, 'PRD-217ZZ', 'Aspernatur mollitia dolorum', 'Voluptas est voluptatum voluptatem autem corrupti est reiciendis natus. Ipsam cumque possimus voluptas et tenetur. Minus dolore maiores sed velit velit aliquam. Vel facilis magni sunt blanditiis et consectetur.', 1414.64, 'Quia vero modi rem dolorem quibusdam expedita cum quidem ut aut.', 3, 65, 'uploads/products/product_11_682b52c31797e.jpeg', 2),
(88, 'PRD-047AU', 'Ut quod quisquam', 'Ipsum nemo eligendi perferendis error possimus quibusdam. Quaerat ut sint odit eaque rerum vitae voluptatum. Voluptatem veritatis qui et tempore ea. Ut sint et perspiciatis magnam culpa qui.', 22.49, 'Neque necessitatibus nemo facilis itaque tempore.', 3, 86, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(89, 'PRD-068CU', 'Et veniam eaque', 'Praesentium nihil voluptate qui consequuntur. Ducimus cumque autem nulla officiis. Voluptatem natus fugiat dignissimos voluptas. Ea delectus est cum ipsam dolorem harum qui. Beatae est cumque dolores alias perferendis. Quisquam distinctio quod dolorum velit sed. Nihil aut praesentium nulla sunt.', 362.05, 'Totam modi consequatur commodi ut autem et rerum sequi.', 1, 61, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(90, 'PRD-001LJ', 'Asperiores dolores possimus', 'Fuga minima corporis eos sit itaque tempore atque. Tempora nisi illum necessitatibus totam. Ipsum ab voluptatem eius consequatur quisquam. Nisi aut corrupti ipsam repellat. Tenetur debitis eum rerum voluptatum sed. Qui adipisci voluptas magni et amet veniam a expedita. Quis nesciunt eum et et.', 873.88, 'Expedita consectetur sint voluptas nisi illo et velit quos.', 1, 13, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(91, 'PRD-108PU', 'Omnis et et', 'Omnis eveniet animi voluptates facere soluta molestiae. Odit eum in neque autem quasi porro. Minus sit minus exercitationem et error earum eius. Quidem ipsa nihil vel molestiae consequatur quisquam. Modi perspiciatis quod libero eum.', 1063.04, 'Natus sint omnis quo animi sint velit quibusdam.', 5, 33, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(92, 'PRD-325MZ', 'Nihil porro assumenda', 'Consequatur voluptatibus occaecati id rerum nostrum sunt quasi. Dolorem iste ut qui sint sed. At corporis non cum velit enim recusandae odio. Id ea et enim aliquam nisi eaque blanditiis. Omnis harum ea quam voluptas sequi sunt eveniet.', 1874.29, 'Consequatur sit iure at sit ut quae ipsam.', 1, 61, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(93, 'PRD-716KB', 'Cum perspiciatis molestiae', 'Sed nihil repudiandae deserunt hic nisi nihil sed. Rerum aut veniam architecto vero et et ipsa. Nesciunt quia accusantium dolorem ut velit illum. Earum sit facilis modi libero reiciendis sapiente dolore suscipit. Modi voluptas adipisci veritatis voluptate. Eos ipsa quam nulla et.', 1633.38, 'Reiciendis perspiciatis voluptates quo sunt ea in aliquid.', 6, 27, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(94, 'PRD-796AH', 'Corporis ut facere', 'A est sapiente dolore aut exercitationem perspiciatis. A consequatur rerum temporibus facilis consequatur. In facilis a facere in. Dolorum et quaerat perferendis autem nulla distinctio. Expedita eveniet enim dolores distinctio dolore pariatur nobis vel. Aut praesentium ipsa laboriosam.', 896.71, 'Provident qui dolores est quae et cum error.', 6, 77, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(95, 'PRD-393TK', 'Nisi quia sed', 'Libero in eligendi vero voluptatem et consequatur consequatur. Fugiat reiciendis qui dolor adipisci laboriosam et. Excepturi et soluta consequatur debitis blanditiis. Est est maiores aut aliquam animi. Nihil ab asperiores aut.', 221.60, 'Consectetur sunt dicta doloremque hic quasi molestias quia architecto ut.', 6, 15, 'uploads/products/default.jpg', 3),
(96, 'PRD-634WX', 'Beatae atque a', 'Qui quibusdam saepe accusantium ipsa et. Qui fuga vel ab illo aspernatur. Reiciendis modi recusandae consequatur saepe laborum tempore. Fugit ea expedita debitis earum praesentium nesciunt sunt doloribus. Voluptas a repellendus vel et. Eum optio vero accusantium deserunt incidunt. Culpa autem officiis natus perspiciatis est animi pariatur.', 155.34, 'Dolorum eaque adipisci impedit alias vitae.', 6, 79, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(97, 'PRD-043IF', 'Consequatur quis dolorem', 'At nihil sed eius aut beatae ipsam. Veritatis ut libero nobis. Ullam illo velit in est ut consectetur aut. Mollitia nisi suscipit necessitatibus est. Adipisci sint enim neque est autem voluptatem sunt incidunt.', 1568.61, 'Rerum aliquid ut ut vero eveniet sequi rem architecto.', 4, 47, 'uploads/products/default.jpg', 3),
(98, 'PRD-567UA', 'Quos tempore molestiae', 'Et impedit est aspernatur dolor qui neque. Officia accusantium et odio quos iure quibusdam. Ut vero animi maxime debitis aut accusantium. Quod et et velit molestiae eum est.', 460.36, 'Repellat explicabo nemo et architecto ad nulla nemo eius doloribus.', 1, 18, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(99, 'PRD-457VS', 'Iusto ut qui', 'Similique impedit alias dolor. Cum sed illum dolorem eos laborum qui quo. Ut maiores perspiciatis atque atque. Dolor voluptas voluptas voluptas eos officiis beatae cum. Dolorem voluptatibus necessitatibus et voluptates.', 696.63, 'Nisi ducimus velit aut consequatur sunt sequi quidem.', 6, 60, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(100, 'PRD-282RH', 'Molestiae dolores corrupti', 'Dolorem exercitationem et ea vitae. Rerum voluptas molestias aliquam voluptas. Animi et ut cum neque minus. Voluptatem in asperiores est consequatur facilis est.', 1850.83, 'Nemo id odit dicta pariatur quos delectus porro quas porro.', 5, 72, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(101, 'PRD-903FH', 'Eos in veniam', 'Perferendis dolor dicta aperiam officiis et. Qui tempora nisi provident eligendi. Quia et fugit saepe voluptatem. Autem quam asperiores error laborum est sed. Magni ducimus eos enim.', 588.92, 'Voluptas quia nisi nihil ullam ut saepe.', 1, 75, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(102, 'PRD-535JX', 'Sed minima dicta', 'Et sed est et eum ut et. Incidunt animi expedita qui eligendi corporis numquam provident. Consequatur ut unde dolores ut voluptatem corrupti et quia. Dolorem aut officiis et non. Cupiditate nihil accusantium voluptatem. Est nisi quidem vel. Et ullam fuga dolorem porro esse.', 1960.48, 'Et magni tempore iusto porro vitae excepturi quisquam enim ipsa dolor.', 6, 1, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(103, 'PRD-230GS', 'Totam ut quia', 'Unde sint in praesentium accusantium qui doloremque quibusdam laborum. Quia consequuntur ut et sint. Est ducimus qui occaecati ut dignissimos ratione aut. Ipsam hic eligendi enim iure. Sunt ex minus velit quos blanditiis veniam minima. Cupiditate necessitatibus dolore debitis optio. Amet praesentium distinctio facilis et et.', 221.03, 'Fugit veritatis explicabo vel est qui cum et numquam.', 6, 25, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(104, 'PRD-431KP', 'Iusto quasi ducimus', 'Rerum at est velit explicabo incidunt non a. Illum cumque atque exercitationem expedita dolorem voluptates qui. Aut ut a alias ex consectetur omnis. Asperiores ut magni voluptatem aut quia optio.', 1085.07, 'Ipsa ut atque doloribus ut vero odio.', 1, 95, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(105, 'PRD-674RI', 'Doloribus vero mollitia', 'Sint laborum delectus reprehenderit qui dolor. Aut ab corrupti minus aut voluptatem. Libero voluptas voluptas expedita est qui esse consequatur sed. Numquam tempora beatae amet similique delectus non. Impedit placeat autem officiis quo explicabo. Et voluptates molestiae quas et dolor quia tenetur sequi. Ut necessitatibus expedita dicta atque officia.', 175.42, 'Quas architecto temporibus qui facere consequatur corporis.', 5, 9, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(106, 'PRD-239JF', 'Aliquid sint sed', 'Assumenda et at ea ea. Ea sit reprehenderit magni illum. Earum voluptate dolore iste deserunt. Maxime expedita incidunt modi pariatur doloremque. Vero incidunt labore debitis sapiente laborum commodi eos. Id iure possimus molestias.', 1353.07, 'Ut quibusdam quia aut ut dolorem sequi et ut assumenda id.', 6, 81, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(107, 'PRD-331II', 'Tempora cupiditate et', 'Autem modi inventore et dolor. Beatae assumenda ut dolorem facilis exercitationem. Eligendi labore cum cupiditate ad voluptatem natus. Illo ipsa eaque labore aut. Voluptatum magni quam quia dignissimos asperiores accusamus.', 693.75, 'Voluptatum sit est sed porro magnam asperiores.', 4, 81, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(108, 'PRD-605OX', 'Totam alias sit', 'Soluta quis rerum quia corporis et ipsam quas qui. Sit quidem omnis reiciendis. Ex velit cupiditate quae. Consequatur assumenda non illo sequi quam. Voluptatem magni velit libero iste. Sunt delectus fugiat impedit aut praesentium. Aut est et consequuntur omnis atque quibusdam voluptatem.', 645.12, 'Omnis dolor facilis omnis sed tenetur modi illo qui fugit.', 3, 83, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(109, 'PRD-350HG', 'Fugiat beatae iusto', 'Similique voluptates accusantium soluta est. Perspiciatis vero omnis exercitationem necessitatibus quia. Similique minima sit hic incidunt sit voluptatem rerum sed. Voluptatem quisquam ullam ducimus unde minus eos.', 1441.49, 'Culpa ut cupiditate reiciendis dolor est.', 2, 99, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(110, 'PRD-491TZ', 'Ut ut nemo', 'Deleniti et alias voluptas id quam aut. Quos laudantium quisquam rerum. Eius doloremque quod sed ducimus ut vero. Sit velit magnam ut enim ducimus.', 105.72, 'Esse quis possimus ut aut eveniet non eius maxime in.', 3, 35, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(111, 'PRD-540TU', 'Vitae et eligendi', 'At ex mollitia aperiam hic et ut et. Ipsam perferendis et incidunt dolor commodi reiciendis. Vel sapiente perferendis odio harum fuga ad velit. Nesciunt id enim at voluptas repellendus voluptas ut. Occaecati molestiae nam fuga iure nihil.', 1987.48, 'Dolore ab eos dolorem aliquam est consectetur et.', 2, 98, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(112, 'PRD-848OM', 'Ea quia aut', 'Reprehenderit totam aut nemo. Voluptates suscipit et dolorem. In harum occaecati totam. Voluptates sint omnis aperiam alias facilis facere placeat. Eius fugiat dolores ad magni.', 1924.97, 'Aspernatur perferendis error dicta qui ad magnam similique.', 3, 85, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(113, 'PRD-798HV', 'A veniam blanditiis', 'Cumque accusamus nihil commodi est sequi repellendus. Et aut consequatur odit neque debitis mollitia. Voluptas est voluptas consequatur porro. Sed dolorum quia et est. Et qui debitis vel rem quia. Vitae consequatur nulla nesciunt accusamus assumenda officiis in. Esse nostrum doloribus praesentium sit facilis autem nulla.', 1635.31, 'Cupiditate eligendi molestiae vel est consequatur excepturi cupiditate consectetur nostrum.', 2, 79, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(114, 'PRD-760FF', 'Enim minima sed', 'Earum vero rerum soluta amet sed. Ut aut voluptas explicabo asperiores iusto. Totam ipsa quisquam sed deserunt. Eum dicta non consequatur recusandae cupiditate dolorem et. Minima eum rerum tenetur nisi molestias voluptate. Aut consequatur rem at sunt dicta et.', 813.10, 'Voluptatem nostrum sit vel cumque voluptates rerum fugiat vel enim consequatur.', 5, 8, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(115, 'PRD-789ZK', 'Nulla quia sit', 'Sit consequatur non sapiente corporis commodi voluptatem eum qui. Mollitia explicabo possimus ex omnis minima laudantium. Quia sed vel explicabo doloribus velit cum quas. Animi praesentium ea necessitatibus modi quaerat optio. Quas animi qui delectus eum.', 1997.72, 'Rem et harum atque inventore consectetur.', 5, 33, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(116, 'PRD-303KR', 'Velit debitis qui', 'Rerum accusantium cum ut culpa maxime. Officiis voluptatem porro molestias cupiditate. Inventore maxime hic velit voluptate itaque rerum dolores. Ducimus quos et sint saepe magnam.', 69.67, 'Optio iure omnis voluptatem vero cumque quae ab et modi.', 3, 92, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(117, 'PRD-616GX', 'Corporis et eum', 'Cupiditate dignissimos corrupti quod et. Rerum qui consequatur omnis pariatur beatae ut iusto. Quia autem repellat labore sit inventore necessitatibus. In explicabo repellendus vitae. Illum soluta eligendi quo odit non voluptatibus ad. Laboriosam occaecati molestias laudantium cum illum est ut.', 1323.59, 'Corrupti quis ullam asperiores qui dolorem officia molestiae vel necessitatibus libero distinctio.', 3, 23, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(118, 'PRD-141VA', 'Consequatur accusamus nisi', 'Iusto illum laboriosam vel qui. Quod dolores odit fugiat cum consequatur quod. Et modi quam aut dolor et assumenda. Corporis reprehenderit possimus accusantium error quia ipsa provident esse. Magnam eligendi voluptatem mollitia quo.', 1086.89, 'Molestiae et eius delectus eveniet non.', 1, 70, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(119, 'PRD-246UR', 'Animi perferendis harum', 'Dolorum magni adipisci minima dolorem ratione nobis. Est veniam vitae est sed alias. Eum sint facilis omnis fugit praesentium aliquam mollitia assumenda. Ad est placeat provident et soluta aut.', 1136.11, 'Omnis laudantium sed sunt sunt dolores autem dolor id et.', 4, 24, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(120, 'PRD-036FG', 'Nemo ut dolore', 'Voluptatibus in laborum ratione dolores optio sit voluptatem. Qui modi voluptatem maxime et animi et. Et dignissimos nihil quasi corrupti in. Et ratione quia quo itaque nihil ab debitis dolore. Ut rem et repellendus autem omnis. Voluptates sapiente quia cumque ea est veritatis in.', 1190.18, 'Aperiam voluptatibus consequuntur dolorum ut est blanditiis quibusdam.', 6, 84, 'uploads/products/default.jpg', 2),
(121, 'PRD-097LI', 'Odit facere qui', 'Molestiae quam itaque quaerat occaecati reprehenderit minima. Totam dolor consequatur magni tempora necessitatibus. Ipsam asperiores in velit aut. Ad autem vel dolores numquam. Sed repellendus et tempora qui expedita ipsum architecto. Ut officiis veniam quidem repudiandae. Necessitatibus in sapiente dolores et minus ut nesciunt rem.', 210.49, 'Provident et omnis cupiditate iure quaerat aperiam officia dolorem saepe.', 2, 5, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(122, 'PRD-970KW', 'Deleniti ullam esse', 'Cumque fugit quo culpa mollitia. Possimus iste fugiat nostrum maiores alias illo. Recusandae vero provident dolor aut sit est ullam. Impedit corporis id expedita nulla. Id maxime deleniti possimus inventore ex sed. Maiores impedit accusamus est ut et.', 1130.08, 'Molestiae minus et et deleniti dolorem.', 5, 77, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(123, 'PRD-377BH', 'Itaque modi architecto', 'Quo asperiores ab rerum. Voluptas assumenda fugit iure quam rerum deleniti. Quae qui dolore quae inventore porro dignissimos. Non alias voluptas nisi quibusdam magni non. Possimus et sit asperiores numquam molestiae sint.', 531.38, 'Dolorem enim possimus in laborum delectus.', 4, 99, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(124, 'PRD-134CC', 'Labore quam fugit', 'Et magnam minus officia qui laborum nostrum. A velit qui voluptatem id dolor sed placeat harum. Nihil adipisci voluptate soluta accusantium nobis. Impedit omnis deserunt officiis dolorem provident repellat. Laborum eligendi odio velit velit optio.', 1749.62, 'Dolore nemo nostrum ipsam recusandae qui perspiciatis repellendus.', 3, 27, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(125, 'PRD-473AO', 'Possimus modi alias', 'Iusto natus quos consequatur qui cumque deleniti placeat. Necessitatibus dolore et aliquid et. Molestiae omnis qui odio quod et. In voluptatum hic et quia non non. Saepe odio asperiores rem vero magni. Omnis facilis inventore reprehenderit rerum aut aut. Sit sapiente blanditiis nostrum rerum.', 1948.79, 'Eligendi est nisi illo non nobis.', 1, 97, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(126, 'PRD-818NU', 'Iste alias dolor', 'Voluptatum assumenda est ut molestiae. Natus sit et quia voluptatem accusantium. Fugit ratione laudantium rerum fugiat mollitia. Quasi aliquid et minus voluptas accusantium. Enim quaerat voluptatem illum. Aperiam minima quaerat ipsum omnis velit et. Dolorum perspiciatis ea provident.', 1946.15, 'Ipsum provident voluptatem exercitationem magnam sunt eaque recusandae.', 3, 14, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(127, 'PRD-609OR', 'Nemo vel voluptatem', 'Natus vero nihil eaque dolor. Aut qui eius modi mollitia. Placeat quasi nulla ut. Reiciendis dolores esse necessitatibus et. Quaerat commodi sint animi sed.', 1270.28, 'Aut aut voluptatibus molestiae ad laudantium itaque suscipit qui facere.', 6, 38, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(128, 'PRD-133ZH', 'Consequuntur quis accusantium', 'Voluptatibus ut laborum officiis excepturi occaecati. Nam quidem numquam explicabo non. Eum cumque corporis quo vel fugiat optio. Vel et laudantium ducimus culpa.', 1264.11, 'Et dolorem itaque illum placeat neque.', 6, 21, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(129, 'PRD-385AJ', 'Voluptas molestiae quae', 'Quis quas velit saepe aspernatur dolore alias. Hic repellat rerum ut cumque velit necessitatibus atque. Nesciunt labore omnis et provident. Adipisci qui est inventore fugit ab et. Excepturi et perferendis laboriosam doloribus suscipit.', 1704.28, 'Sit voluptates quasi dolorem ipsa consequatur qui voluptatum est.', 6, 13, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(130, 'PRD-397TJ', 'Laboriosam maiores sunt', 'Quis assumenda rerum ut ut suscipit iusto atque id. Distinctio et labore et placeat ut suscipit blanditiis illum. Repellendus et ea ut rerum. Quaerat nisi corrupti quae necessitatibus quia ratione dolore omnis. Voluptatem qui et neque et neque sit aut. Reprehenderit debitis hic sequi et.', 469.96, 'Ut voluptates inventore incidunt soluta consequuntur temporibus doloremque rem.', 3, 92, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(131, 'PRD-416YK', 'Voluptas rerum est', 'Est consequatur dicta aperiam aspernatur. Laudantium mollitia aut molestiae consequatur vitae. Aperiam minima voluptatem eos saepe inventore voluptatem nihil. Et repudiandae reiciendis qui. Consequatur quasi consectetur saepe dolorem. Quia autem quos suscipit incidunt vel in id. Consequatur est voluptate saepe placeat quia.', 1199.23, 'Veritatis harum suscipit tempore esse et culpa.', 1, 77, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(132, 'PRD-727EV', 'Dicta qui delectus', 'Omnis repudiandae voluptate impedit quia eius facere. Libero suscipit dolorum labore beatae. Dolore possimus et earum voluptatem. Possimus cumque eligendi sit qui sed autem. Sed quod magni aut sit aut ipsum. Nobis est commodi aliquid dolorem ut error dolores perspiciatis. Quibusdam quisquam rerum quidem facere omnis impedit voluptate quos.', 1000.78, 'Aut rerum consequuntur atque aut nihil.', 6, 74, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(133, 'PRD-384GN', 'Voluptates et et', 'Sit veritatis odio voluptatibus omnis. Consequuntur et rerum consequuntur eos praesentium. Maxime et est veniam quisquam sint itaque. Ipsum rerum molestias est aut et. Odit sequi facilis optio. Dolor quidem quasi laborum rem incidunt natus. Architecto et repudiandae deleniti.', 542.93, 'Tempora eos sunt esse sint qui.', 2, 17, 'uploads/products/product_5_682b531491006.jpeg', 3),
(134, 'PRD-032EC', 'Tempore provident aperiam', 'Eum aspernatur nihil rerum sunt earum sunt quia iste. Exercitationem voluptatem sit vel hic. Architecto libero nobis nisi itaque voluptatem aut. Ut qui qui laboriosam exercitationem possimus dolor sapiente recusandae. Cumque rem aut ea aut numquam. Excepturi esse deleniti eos. Laboriosam ut maiores ut quia et.', 791.20, 'Unde placeat dolores perspiciatis officiis id beatae veritatis molestias quae.', 3, 1, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(135, 'PRD-278JN', 'Sunt provident ratione', 'Et architecto est voluptatem quia ab repudiandae. Debitis fugiat tenetur cumque illo nihil. Temporibus quod voluptas mollitia accusamus. Non et inventore magnam. Soluta odio optio enim eveniet quo voluptas earum. Et itaque velit quos aspernatur doloremque temporibus quaerat velit. Debitis dolore ut deserunt repudiandae esse numquam placeat.', 633.13, 'Fuga vero deleniti laboriosam nesciunt et at a ut enim voluptatem hic.', 5, 32, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(136, 'PRD-946RT', 'Possimus eos in', 'Doloremque veritatis voluptatem tempore enim rerum. Rerum aliquid fugit eveniet ut laborum blanditiis. Quo provident iste maxime. Odit quia nam ipsa ut.', 335.49, 'Architecto sed qui eos sequi sequi reiciendis rerum quis.', 1, 78, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(137, 'PRD-288XX', 'Voluptatem quia tenetur', 'Aut corporis aut inventore cum. Non voluptas velit dolorum esse. Delectus ipsam aut delectus ab unde voluptas dicta. Iure sed tempore similique nulla inventore.', 430.60, 'Qui quos voluptas dignissimos dolor eveniet qui consequuntur cumque.', 6, 71, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(138, 'PRD-622QJ', 'Aut ratione et', 'Nihil accusantium recusandae dolores quia suscipit et reiciendis consequatur. Omnis perferendis et omnis ducimus iure. Similique ut qui voluptas eveniet earum unde quam. Temporibus atque deleniti ut.', 82.33, 'Culpa facilis velit ut laborum et voluptatibus.', 4, 47, 'uploads/products/default.jpg', 3),
(139, 'PRD-395AH', 'Distinctio dolorem veniam', 'Deleniti porro nemo totam. Ab similique voluptatem laudantium enim veniam et. Provident ipsum quisquam temporibus. At quasi adipisci qui quisquam sunt. Odit mollitia voluptate sed et sint et ex. Vero nam possimus omnis quia.', 639.33, 'Omnis facilis quisquam soluta dolor sed corrupti recusandae similique laborum.', 3, 34, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(140, 'PRD-711DV', 'Consequatur amet quam', 'Fugiat quaerat sunt totam dolorem. Qui sit enim labore perferendis. Asperiores repellat ea omnis quis corporis. Porro inventore totam laborum.', 668.29, 'A at ipsum nihil fuga unde rerum est.', 1, 12, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(141, 'PRD-479QK', 'Et dolorem suscipit', 'Sit rem sed autem repellat autem qui inventore. Impedit facilis similique neque ut culpa perferendis porro. Qui consequuntur dolore est necessitatibus ut. Voluptates exercitationem veritatis alias enim suscipit. Eaque aut laudantium quia. Beatae qui impedit itaque esse animi itaque.', 235.22, 'Voluptatem sunt corporis ex aliquam ea nisi ut.', 4, 81, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(142, 'PRD-227WS', 'Omnis sint ratione', 'Laborum et sed perferendis iusto quia omnis nesciunt cumque. Laboriosam culpa deleniti officia quae similique sit culpa fugit. Eius quis molestias facere velit voluptatum. Et dolores eius rerum reiciendis nihil. Dolorum fuga magnam vero quia et. Est repellat eveniet expedita qui eveniet vel. Eos totam delectus pariatur autem ut.', 1109.76, 'Amet corrupti similique autem qui.', 4, 56, 'uploads/products/product_5_682b531491006.jpeg', 2),
(143, 'PRD-739PV', 'Aspernatur rerum et', 'Commodi est rerum sit laboriosam eum blanditiis possimus vel. Aspernatur qui eveniet facere totam illo sed. Et facilis est est vel dolor voluptates deserunt incidunt. Nesciunt rerum cum voluptas qui cumque dolores.', 502.02, 'Reiciendis suscipit quos id consectetur hic cum facilis.', 2, 66, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(144, 'PRD-304IG', 'Sint ratione dicta', 'Nulla eos libero cumque. Esse dolores magni modi ab possimus. Ab atque laborum voluptas quidem sit quasi quis. Debitis deleniti in omnis et cum exercitationem minus libero. Architecto aperiam molestias iste non sit pariatur ea. Sed non quo eveniet earum. Ipsa eveniet non officia nam sequi.', 1578.90, 'Ut qui similique dolores ut et et nihil.', 4, 93, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(145, 'PRD-353RF', 'Excepturi sed qui', 'Omnis natus error repellat et qui aut. Nam nam tempora at repellat et consequatur aut. Fuga minus ab mollitia voluptatibus aut consequatur impedit. Deserunt maiores nesciunt corrupti veritatis quam quaerat molestiae sed. Natus qui rem inventore et. Earum eum debitis iste voluptate reiciendis saepe non.', 1146.05, 'Sint deserunt distinctio asperiores expedita omnis eligendi.', 6, 46, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(146, 'PRD-026XN', 'Est et quis', 'Et autem optio eum et aspernatur non porro. Assumenda rerum dolore consequuntur sapiente ex sit quo similique. Qui quaerat et beatae sit aliquam earum similique recusandae. Maxime ratione enim voluptas consequatur. Eligendi aperiam qui saepe unde.', 1562.29, 'Et voluptas ea accusantium totam est harum.', 6, 48, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(147, 'PRD-573OQ', 'Repudiandae sit quos', 'Aut nulla inventore neque et distinctio. Et molestiae quia est eum quisquam. Magni quo blanditiis ut in necessitatibus quis. Repellat aperiam nisi voluptatem. Incidunt soluta fugit dolorem iste et. Quisquam similique quibusdam ipsam. Illum est tenetur quo.', 799.42, 'Hic qui sed eligendi sint pariatur qui voluptas molestias.', 2, 3, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(148, 'PRD-065XS', 'Et est pariatur', 'Sed voluptatem quam expedita. Neque perferendis a accusamus qui sunt nisi. Harum dignissimos quis quis aspernatur suscipit et labore. Quas labore incidunt unde ut deleniti consequatur harum architecto.', 420.72, 'Et rerum hic sequi quaerat et ut aut perspiciatis enim.', 2, 8, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(149, 'PRD-075TI', 'Eos numquam tempore', 'Rerum rem odio esse minus quis ex. Natus facere non in alias voluptas magnam occaecati vel. Et officiis rerum dolore. Sunt possimus cumque voluptatem ipsa facere.', 669.98, 'Doloremque omnis nisi non qui ipsam.', 3, 5, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(150, 'PRD-028SZ', 'Modi dolores illo', 'Et commodi voluptatibus consequatur. Labore hic eligendi occaecati ipsa voluptatem repellat mollitia dolorem. Et vel labore laboriosam dolor aut. Voluptate nisi minima rerum vel molestias et. Qui odio omnis odio delectus. Fugiat distinctio numquam veritatis voluptate animi qui. Sint soluta adipisci reprehenderit dolore.', 57.24, 'Aut eum nesciunt voluptate sequi enim aut.', 3, 87, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(151, 'PRD-527GZ', 'Vitae ipsam alias', 'Ipsa sed molestiae officiis beatae ipsum. Aut cupiditate provident in minus. Fugiat illum molestiae delectus nisi praesentium. Fuga debitis non et et ea est.', 1904.28, 'Sed rerum sit quo sapiente omnis odit dolores aut a.', 6, 65, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3);
INSERT INTO `proizvod` (`Proizvod_ID`, `sifra`, `Naziv`, `Opis`, `Cijena`, `KratkiOpis`, `kategorija`, `StanjeNaSkladistu`, `Slika`, `tip_id`) VALUES
(152, 'PRD-681ON', 'Explicabo omnis suscipit', 'A beatae tempora consectetur molestiae ut sed cum. Iste eaque ut quis. Et illum consequuntur unde sunt labore. Velit fuga dolor quae nemo quasi. Ducimus et autem velit culpa.', 1160.97, 'Voluptatem nihil dolore voluptatem qui nesciunt hic autem.', 6, 33, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(153, 'PRD-981CU', 'Delectus rerum quibusdam', 'Iusto nihil voluptatem officiis et voluptas veritatis. Quia ea accusamus enim ratione optio aut tempore. Blanditiis aut est dolores eum totam distinctio suscipit totam. Nihil perferendis facilis corporis labore. Sapiente ut autem inventore vero odit pariatur aliquid.', 1066.85, 'Adipisci optio sed odio alias ratione neque facere blanditiis.', 2, 45, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 1),
(154, 'PRD-485LT', 'Ipsam amet inventore', 'Consequatur nesciunt veniam saepe eum quibusdam sint velit. Repellendus quos repellendus ipsum quas voluptas. Et odit et dolor minus quo eum voluptas autem. Ea labore voluptatem et harum laborum. Quo officia dolor eum consequatur libero. Est temporibus sed non excepturi.', 1340.30, 'Unde autem ipsum sunt doloremque sit error.', 5, 37, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(155, 'PRD-569KK', 'Mollitia quos aliquid', 'Repudiandae illum eos hic est. Itaque voluptas voluptas provident dignissimos magni. Laudantium harum eum dicta ducimus ut. Maiores at aperiam itaque quia architecto. In voluptatem corrupti deserunt molestiae voluptatem maxime. Omnis quia voluptatum quos nostrum sit et eum non. Nisi incidunt enim atque totam.', 1337.44, 'Dolorem explicabo maiores placeat et voluptate aut.', 4, 17, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(156, 'PRD-503ZF', 'Non consequuntur eius', 'Rem libero recusandae est dignissimos autem voluptatem. Ad repudiandae deleniti quia sed expedita quisquam. Officia voluptas distinctio qui nihil recusandae quos. Ea vel debitis qui eveniet ullam ut. Sunt maxime iure eligendi eaque laborum vel odit.', 1452.62, 'Velit optio iure neque in sed.', 6, 8, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(157, 'PRD-496HN', 'Quidem et omnis', 'Quia ab dolor ad minima asperiores omnis et quis. Quidem voluptas et quis quis voluptas quaerat perspiciatis. Dolor voluptate maxime unde praesentium. Ipsum voluptatem sint et perspiciatis. Ea esse qui porro. Aut aut sapiente sunt non non. Corrupti impedit sunt nobis dolorum sed et. Amet et vitae repellendus aut sapiente officia.', 802.96, 'Voluptatibus et doloribus nulla est officiis qui.', 4, 70, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(158, 'PRD-605WZ', 'Est commodi molestiae', 'Autem nisi aspernatur est et vero. At nihil odit placeat laboriosam. Provident maxime sit reiciendis et veniam dicta. Ut praesentium aut tempora eaque. Dolorem aperiam tempore ut ea.', 993.20, 'Maxime debitis modi nemo quo doloribus libero aut asperiores iste.', 2, 18, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(159, 'PRD-709XQ', 'Nesciunt id temporibus', 'Deleniti possimus voluptatem commodi perspiciatis. Ea facilis rerum provident culpa. Deleniti quibusdam inventore quia similique nostrum delectus deserunt. Minus saepe perferendis numquam autem necessitatibus quo. Sit aperiam ut praesentium possimus et corrupti nisi et.', 1898.75, 'Itaque corrupti id magni incidunt in ex voluptate qui et.', 5, 28, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(160, 'PRD-841UD', 'Velit culpa et', 'Reprehenderit repellat asperiores sint consequatur optio nihil. Dolores ut qui consequuntur provident dignissimos. Qui necessitatibus ut quas et reprehenderit atque. Soluta voluptates qui ullam occaecati suscipit facere iure. Adipisci quae sapiente ea nemo praesentium odio nihil.', 803.64, 'Laboriosam id et aperiam aut exercitationem nihil.', 6, 48, 'uploads/products/product_9_682b53079cbf5.jpeg', 3),
(161, 'PRD-665XX', 'Nihil nemo amet', 'Et qui culpa inventore alias provident molestiae vel temporibus. Et molestiae officia dolorem distinctio corporis. Sequi vitae aut et earum est voluptatem. Non quis nulla facere doloremque necessitatibus laudantium ducimus.', 299.81, 'Maxime rerum accusantium ea reiciendis velit quibusdam.', 2, 23, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(162, 'PRD-974TB', 'Et ut quos', 'Omnis voluptates asperiores et odit quibusdam. Illo eos eveniet repudiandae et necessitatibus omnis sed. Vel et quod et. Facere labore quibusdam minima perspiciatis. Omnis sint maiores eius. Rerum voluptas ullam maiores vero repellendus molestiae. Ipsum qui vero sed temporibus quibusdam libero rem.', 1755.84, 'Ut laboriosam sunt sunt ut eum ut quo quia laborum hic.', 3, 36, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(163, 'PRD-145PH', 'Recusandae beatae sequi', 'Voluptatem est rerum voluptatem inventore molestias blanditiis illo. Quia quia sed dicta. Accusantium illum quia aut iusto nobis. Vel mollitia maxime dolorem. Ut ipsa optio et delectus voluptatum aut deleniti. Sed distinctio et ullam ut quo perferendis vitae. Culpa quae cum quas ea eius adipisci rem fugiat.', 28.65, 'Id omnis non incidunt unde rerum similique et vero consequuntur.', 1, 60, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(164, 'PRD-900YR', 'Ut sed omnis', 'Facilis corporis est omnis nobis quo laborum consequatur. Autem sint quas vel dolorem reprehenderit ut. Unde harum perferendis quaerat omnis sit. Quibusdam accusamus a sapiente. Et et impedit itaque neque et impedit. Optio nihil sint ullam.', 795.83, 'Culpa nobis dolorem fuga laboriosam doloribus enim dolor.', 1, 18, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(165, 'PRD-752NC', 'Reprehenderit culpa eum', 'Odit velit at eos. Itaque harum id at. Voluptas et in vero voluptas aut nisi quisquam. Sint corrupti ut et recusandae quod. Corrupti cum at consequatur maxime ut voluptatibus ut. Dolorum corporis velit debitis quidem enim. Vero aperiam quis dolores omnis.', 618.22, 'Quis vitae officiis expedita nemo animi id quia quos.', 2, 21, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(166, 'PRD-087QT', 'Consequuntur dolorum sed', 'Maiores quam quisquam tempora non ea et voluptas minima. Animi pariatur molestiae et minima dolorum numquam. Magnam debitis omnis ullam tenetur error. Facere quibusdam voluptates tenetur nisi.', 917.89, 'Sit sit consequatur quaerat rem fugit.', 2, 19, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(167, 'PRD-520YW', 'Pariatur nihil saepe', 'Esse soluta quos illum reprehenderit doloribus eos. Minus ipsa nobis maxime enim porro at molestiae sit. Non dolores est consequuntur suscipit eveniet facilis. Doloribus accusantium voluptatem necessitatibus asperiores id magni. Ullam sapiente distinctio totam qui beatae voluptates. Commodi aliquam sed natus quam. Quia expedita architecto rerum.', 1483.63, 'Dolores ut officiis rerum consequatur.', 4, 52, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(168, 'PRD-575EQ', 'Sunt laboriosam et', 'Accusantium velit aut excepturi veniam quis maiores. Voluptate nostrum quam commodi. Ea ea aut expedita et iusto dolorem voluptatum. Harum saepe eveniet accusantium consequatur consectetur. Praesentium omnis voluptas et iste aliquam accusantium.', 1248.63, 'Facere inventore unde eaque suscipit deserunt provident quibusdam.', 2, 9, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(169, 'PRD-445MJ', 'Laudantium ex consequatur', 'Quibusdam mollitia et mollitia quo. Omnis sunt magni est aut. Quos accusantium autem iste quia deleniti rerum. Esse nihil quia accusamus perferendis qui aut ipsa aut.', 1895.93, 'Repellendus corporis dolorem suscipit enim quasi fugit.', 4, 22, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(170, 'PRD-101LI', 'Est praesentium consequatur', 'Aut quas qui soluta quis nostrum eos tenetur maxime. Tenetur excepturi id aliquam omnis voluptatem. Odio eligendi assumenda consequatur. Labore quisquam perspiciatis adipisci unde. Ratione velit maxime vel repudiandae sint. Ab quasi corporis nisi nihil minima et.', 686.22, 'Suscipit dolores id fugit adipisci a et iste quae debitis est.', 6, 42, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(171, 'PRD-341XX', 'Sed voluptates pariatur', 'Aperiam unde maiores voluptatem. Quasi earum dolore harum atque officia delectus deleniti animi. Tempore modi aut voluptate soluta et. In est occaecati dolor enim quia quis vero. Incidunt ipsa quis cum accusamus.', 581.71, 'Explicabo nihil sit sunt sed iure placeat unde.', 4, 83, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(172, 'PRD-588GY', 'Iste temporibus et', 'Et velit voluptatem ipsa sed. Quibusdam beatae eveniet occaecati. Aspernatur nihil omnis aut est excepturi sunt. Ad cum corrupti esse dolore. Quasi velit esse aut dolorem. Itaque natus sed sit est distinctio facere vero.', 1409.22, 'Qui non odio veritatis a quia.', 5, 84, 'uploads/products/product_5_682b531491006.jpeg', 1),
(173, 'PRD-404AG', 'Accusamus minus beatae', 'Voluptatum iste voluptas quod. Eaque omnis explicabo esse. Iste aut beatae sed voluptatem est expedita placeat enim. Qui dolor aut veniam eum possimus quibusdam.', 1291.83, 'Et nemo consequatur quos voluptatem provident ut nostrum nihil nam.', 2, 17, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(174, 'PRD-959LM', 'Odit asperiores itaque', 'Nihil ex quod quia quae soluta vero maxime esse. Sit similique maxime ea omnis saepe alias voluptatem. Officiis reiciendis blanditiis incidunt esse esse est neque perferendis. Asperiores odio dolorem dolor tenetur numquam iste. Autem vitae quisquam voluptates. Similique dignissimos eos dolorem. Earum velit nihil aut vero.', 1494.09, 'Inventore sit repellat ut consectetur eos ab est qui quia.', 4, 90, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(175, 'PRD-731OC', 'Et velit velit', 'Blanditiis velit quisquam rerum perferendis sint. Laudantium ex non numquam voluptas praesentium accusantium ut accusantium. Quaerat pariatur repellendus est id est neque qui. Facilis consequuntur quos possimus quo quia. Ipsum voluptas corrupti voluptatibus magni. Soluta repellat cum enim minus animi qui iste rerum. Ullam vero libero voluptatem.', 1185.88, 'Provident illo laudantium repudiandae suscipit quia voluptas.', 6, 24, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(176, 'PRD-732GH', 'Assumenda voluptatem explicabo', 'Ipsum dolores in libero voluptatibus et et temporibus consequatur. Et sequi autem mollitia quasi fugiat tenetur. Molestiae modi aut et dignissimos labore ad aliquam. Ipsum ut ut ad. A labore beatae incidunt officiis. Necessitatibus dolore consequatur repellendus exercitationem.', 1694.06, 'Sit dolores voluptates consequatur ut pariatur excepturi ratione perspiciatis veniam.', 1, 10, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(177, 'PRD-758CP', 'Dicta corporis sequi', 'Eligendi qui maxime molestiae et. Ab qui quia accusamus cumque occaecati. Eos culpa ipsa asperiores dicta alias dicta deserunt accusamus. Eaque aut nam laborum tempore repellendus et aut. Maxime error maxime non.', 945.00, 'Fugiat totam nisi consequatur rerum a animi distinctio illum accusamus.', 1, 70, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(178, 'PRD-888SC', 'Sit id est', 'Et dolorem magni veniam velit consequatur et qui. Molestiae et sint dolorem quos inventore. Et voluptas qui assumenda quis sunt deleniti quidem. Molestiae alias consequatur veniam enim. Labore aut tenetur rerum laudantium vel recusandae totam.', 14.36, 'Cumque nostrum ab tempora harum quae sunt.', 5, 12, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(179, 'PRD-488JE', 'Delectus sapiente eius', 'Nisi ipsa aut et et in aperiam. Soluta molestias ut omnis eveniet occaecati sed. Ipsa ut quia in inventore hic dolorem. Suscipit voluptatum possimus excepturi. Ut aut corrupti veritatis perspiciatis.', 792.08, 'Iste qui hic sed a et et dolores sapiente veniam ex.', 6, 52, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(180, 'PRD-301HR', 'Sit veritatis quibusdam', 'Est quae voluptate eos culpa aspernatur. Voluptatibus non illo omnis aliquid. Dolor eius veniam veniam saepe consequuntur possimus facilis aut. Aperiam voluptatum nisi quas velit quo veniam.', 1588.83, 'Dolor maxime et quidem et voluptas mollitia a.', 1, 83, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(181, 'PRD-392UE', 'Iusto quos commodi', 'Voluptatibus vitae possimus odit consequuntur necessitatibus exercitationem qui. Enim fugiat incidunt ducimus eum. Et est cum libero recusandae. Ad est repellat enim. Laborum et enim fugiat aut id eum quaerat. Ut nostrum dolores magnam culpa ad. Quis perferendis error quia debitis.', 1742.34, 'Id necessitatibus voluptatum nihil laudantium beatae non iste assumenda natus eveniet.', 6, 26, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(182, 'PRD-471BB', 'Perferendis reprehenderit eum', 'Recusandae quisquam in non consequatur fugit reprehenderit nisi. Quibusdam nostrum ut consequatur ullam sit dolorem. Quis aut consequatur laborum maiores. Voluptate dolore ex nihil natus. Velit magni maxime ut ratione. Cum commodi eius debitis sint nostrum assumenda maxime. Iure molestias libero illum.', 1350.47, 'Consequatur molestiae sed id eaque neque placeat dolores expedita sunt sed.', 3, 64, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(183, 'PRD-914LG', 'Nam voluptas omnis', 'Porro est qui maxime ut corrupti voluptas. Unde tenetur eum in sapiente. Debitis id facilis et aliquam. Deserunt eius sit natus voluptas maxime consequatur ex. In dolore aut et in dicta.', 605.71, 'Modi iure cupiditate natus quam quia vel.', 5, 11, 'uploads/products/default.jpg', 2),
(184, 'PRD-370AC', 'Pariatur et voluptatem', 'Consequatur ex debitis voluptatum et sed alias culpa voluptatem. Inventore ipsam dolorem itaque voluptatem fugiat laborum cupiditate quisquam. Eius et dolores est enim natus quisquam. Dolores numquam temporibus sint sequi. Provident eius deserunt et assumenda.', 157.23, 'Minus aut dolores voluptatibus deserunt voluptas.', 3, 47, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(185, 'PRD-434GK', 'Totam quia veritatis', 'Cumque porro quaerat assumenda optio. Omnis aut ad aliquam voluptas quia fuga. Consequuntur et voluptatum a. Velit est rerum asperiores saepe consequatur nihil ullam eum. Aut voluptas minima est aliquam eligendi sit quia. Dolores velit non voluptate. Ea vel omnis dolore assumenda qui.', 1508.70, 'Ullam adipisci et laborum atque sapiente aut consectetur.', 6, 83, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(186, 'PRD-655ZP', 'Amet aut facere', 'Ratione ea impedit et non. Repudiandae quam quibusdam odio aliquam consequatur quia. Facilis voluptates ipsa quo aliquid. Ad alias quasi quisquam sit. Eos molestiae velit et rerum mollitia. Magni in accusamus ex aut minima eum repellat.', 1665.19, 'Repudiandae vel et beatae voluptatibus necessitatibus est possimus totam sint non quia.', 3, 74, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(187, 'PRD-784UD', 'Voluptate saepe eos', 'Porro veritatis voluptatem quidem enim beatae. Asperiores et voluptatem reiciendis numquam voluptatem quo officiis. Voluptas accusamus a qui odit et asperiores. Ea vero quaerat exercitationem et aut. Sed quo rem est atque et minus natus.', 1700.01, 'Qui voluptatem temporibus qui est sed.', 4, 7, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(188, 'PRD-030CO', 'Unde odio modi', 'Debitis quo facilis eaque molestiae reprehenderit aut id. Sapiente recusandae quia rerum voluptas nostrum voluptatibus. Cumque tempore facere in ipsam at. Consequatur quo unde tempore. Corrupti ea iste aut molestias.', 1577.95, 'Accusantium animi deleniti veritatis dolore repellendus vel.', 6, 74, 'uploads/products/product_5_682b531491006.jpeg', 3),
(189, 'PRD-558HY', 'Est harum ut', 'Quam soluta magni ut officia in unde nesciunt. Quam assumenda minus earum aspernatur amet nihil repellat. Consequuntur aliquid quia sed deleniti. Cum quis omnis ut amet hic expedita. Incidunt blanditiis quia quos autem at autem. Harum itaque aut excepturi nemo eius consequatur et. Molestias labore praesentium non illum quis ea facere.', 1264.78, 'Consequatur et aliquid reiciendis impedit qui nihil corrupti vel.', 3, 50, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(190, 'PRD-364NK', 'Sint non fugit', 'Ipsum eveniet ut nisi similique aperiam aut iste laudantium. Fugit laboriosam animi eos ex. Voluptas sint recusandae ex sed aliquam sed voluptatibus. Quaerat quas consectetur et deleniti qui ex. Facere enim molestias deserunt. Et corrupti sunt eius. Sint quae quas sint nostrum velit et voluptatibus.', 1592.51, 'Facilis nihil at est nesciunt officiis necessitatibus.', 5, 39, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(191, 'PRD-071DB', 'Modi quaerat repellat', 'Sint assumenda adipisci et magni rerum. Sapiente excepturi velit neque voluptatem quis voluptas dolorem. Omnis temporibus sunt quia delectus. Rem dolorum nostrum placeat deserunt nesciunt. Id quibusdam facilis sed natus.', 647.99, 'Id temporibus facilis maiores qui tempora iusto accusamus.', 2, 78, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(192, 'PRD-201DM', 'Totam et ad', 'Rerum necessitatibus nemo ducimus exercitationem et autem iste. Eligendi voluptatem cum est id vero commodi minima. Error dolores enim tempore consequatur accusantium et assumenda. Et suscipit id quod voluptatem voluptatem sed ut.', 1805.27, 'Atque quod a saepe iusto dolorum voluptatum qui rem exercitationem.', 2, 23, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(193, 'PRD-388XK', 'Molestias sed sint', 'Magnam quis adipisci nulla et. Quam eum nisi neque dolores beatae culpa facere. Commodi officia ipsam qui optio esse aut nostrum. Est quo ducimus eveniet repudiandae in. In ipsa cum recusandae dolorem.', 188.97, 'Aliquid dolorem reiciendis amet dignissimos quidem quisquam qui ut.', 5, 23, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(194, 'PRD-439KY', 'Fugiat officia saepe', 'Repudiandae debitis quia et itaque ratione alias. Aut numquam quos reprehenderit. Illo qui nam id delectus neque. In voluptatum rerum voluptas aut facilis eum qui. Aut esse quam est dicta.', 39.30, 'Totam omnis nam quaerat deserunt officiis dolore iusto ut dicta.', 2, 71, 'uploads/products/product_12_682b52e8c33a0.jpeg', 2),
(195, 'PRD-522UO', 'Tempora dolores velit', 'Fugit et nam qui repudiandae quasi. Qui voluptates temporibus possimus praesentium ab id occaecati. Veniam illum quod cum. Fugiat atque sunt reiciendis quidem. Et ut assumenda vel. In sit tenetur veniam molestias et praesentium. Nemo et at atque accusantium.', 1310.63, 'Incidunt sint autem quaerat incidunt ea optio sunt repellendus excepturi eum quasi.', 3, 45, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(196, 'PRD-482ET', 'Velit provident eos', 'Eum labore nostrum iste id nobis placeat. Nisi totam perferendis nobis at aut iusto. Ipsam earum voluptatem voluptatem id aut sit. Sit dolorum ut at tenetur incidunt fuga. Voluptas qui iure ea porro officiis distinctio sunt incidunt. Et non et qui. Nobis et quibusdam odit non nemo.', 433.71, 'Tempore alias voluptate iusto voluptatem vero nemo sed.', 5, 71, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(197, 'PRD-565VH', 'Ea dicta blanditiis', 'Fuga fuga hic eos velit a sapiente rerum sed. Illo qui minima dolore. Quaerat totam saepe sed tempore nemo itaque voluptatem. Nihil quae tempore et ipsa et ipsa eos. Quis nobis totam et autem consectetur in. Necessitatibus non necessitatibus autem vitae. Est soluta quis aperiam est delectus.', 197.67, 'Aliquid similique magnam doloribus et dolorem error.', 4, 1, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(198, 'PRD-579TM', 'Reiciendis numquam quisquam', 'Qui commodi accusantium dolorem. Aut sapiente dolor officia enim. Dolorum eos voluptatem qui consequatur illum eos possimus. Vitae assumenda omnis sint nisi non distinctio tempore. Dolorum odit animi id sunt.', 1300.78, 'Perferendis ut quisquam distinctio similique laboriosam nostrum aut exercitationem culpa facilis.', 5, 63, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(199, 'PRD-907JY', 'Quo explicabo voluptas', 'Dolorem eligendi voluptatibus velit labore enim doloribus officiis. Ut ipsa quaerat natus dicta. Est iusto quos sint libero consequatur eligendi expedita dicta. Aut magni odio voluptas minus dignissimos. Libero est asperiores est officia.', 30.58, 'Quae quibusdam corporis quae quisquam ut qui et voluptate earum.', 6, 46, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(200, 'PRD-987MJ', 'Omnis nihil fugit', 'Quasi magni reprehenderit qui dolor repellendus dolorem et. Perferendis consectetur quia illo recusandae quia quod maxime. Dignissimos et natus sunt aut adipisci optio. Id molestiae sed sint et.', 1573.94, 'Illo ut illum occaecati ipsum voluptatem at.', 4, 13, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(201, 'PRD-884CD', 'Nostrum vel cupiditate', 'Est ea aut quas. Provident tenetur eveniet delectus. Ipsa quaerat vero inventore voluptas placeat. Et provident blanditiis quo quia magni cum. Et sit eligendi et. Occaecati modi molestiae impedit.', 1391.91, 'Neque at perspiciatis soluta distinctio maiores vel aperiam et illo atque.', 1, 80, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(202, 'PRD-067GV', 'Velit architecto quam', 'Non ut veritatis voluptatem assumenda sed. Aliquid explicabo sed ex optio. Ipsa esse earum facilis libero. Incidunt quisquam quis optio. Deserunt nemo incidunt non perspiciatis debitis consequatur cum in.', 869.27, 'Reiciendis ut omnis et in amet.', 2, 84, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(203, 'PRD-240QL', 'Recusandae omnis dolor', 'Autem veritatis quo ut cumque quod consectetur. Et veritatis aperiam nihil enim maiores ea porro. Dolorem nisi tempore enim. Facilis expedita neque nihil pariatur. Dolorem non sed cumque ut pariatur reiciendis blanditiis. In ut repudiandae nostrum autem veniam ut ad.', 1771.43, 'Pariatur autem nisi cupiditate voluptate nostrum architecto sit cupiditate rerum mollitia.', 5, 11, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(204, 'PRD-708MG', 'Distinctio eum officiis', 'Aperiam commodi error dolores aliquam sit aut aperiam. Molestias sint distinctio fuga ex dolorem. Sed consectetur non libero molestias quos explicabo distinctio. Minus recusandae debitis ab voluptatem tempore eum. Nisi quidem suscipit nam doloremque quam nihil. Non iusto ipsum modi sint. Aliquid et dignissimos qui maiores aliquid autem dolor.', 55.60, 'Ducimus sed molestias sed et id perferendis sed.', 2, 33, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(205, 'PRD-506ZM', 'Voluptatem consectetur et', 'Et fugit labore eum vel expedita sint. Voluptas ut et quis dolor ullam iure omnis. Quia est sed dicta perspiciatis voluptates exercitationem expedita. Quis cum rem natus sequi voluptas dolorum. Temporibus laudantium sequi iure. Laborum ducimus occaecati corrupti ipsa. Optio eum aut et consequatur alias autem.', 1970.17, 'Aliquam et totam doloribus deserunt rerum aut libero quidem ullam ipsa.', 3, 58, 'uploads/products/product_14_682b52b3204d2.jpeg', 3),
(206, 'PRD-265RV', 'Neque rerum velit', 'Vero voluptas non beatae a aut ratione quibusdam. Vitae est vitae voluptates voluptatem eum eos voluptas. Non reiciendis perspiciatis maiores eaque voluptas quis. Aperiam quia distinctio laborum pariatur necessitatibus. Commodi quod accusantium consequatur molestiae laborum omnis illo suscipit. Voluptate repellat ullam est asperiores quas mollitia nihil quidem.', 552.63, 'Tempora dignissimos nisi quia omnis ut omnis temporibus dolore.', 3, 76, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(207, 'PRD-641NZ', 'Consequatur qui non', 'Rerum sed cum non ullam vero debitis ab. Voluptatem sed enim quasi ipsum. Voluptas repudiandae alias qui facere veritatis magnam qui eligendi. Et beatae veniam voluptatem temporibus dolore consequatur. Voluptatem velit et inventore esse ullam laudantium voluptatibus. Quae placeat sapiente quod. Ducimus at porro harum eos rerum non ea id.', 792.92, 'Perspiciatis et et quod quia pariatur earum qui eligendi quisquam qui nihil.', 6, 48, 'uploads/products/default.jpg', 1),
(208, 'PRD-269XL', 'Consequatur provident voluptatem', 'Ipsum aliquam quia dolore dolorem quidem. Cupiditate quibusdam voluptas veniam. Rem et odio dolorum. Laborum doloribus perspiciatis nisi dolor accusamus doloribus.', 1201.04, 'Consequatur omnis eligendi et et quas voluptatibus ullam est earum soluta.', 6, 96, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(209, 'PRD-381OZ', 'Aut eum quam', 'Velit odit odio aut laborum assumenda reiciendis. Dolor nihil quis eos aliquam consequatur voluptas vel doloribus. Sint quod recusandae et saepe neque nemo et eveniet. Eligendi repellendus asperiores aperiam ut omnis.', 1887.74, 'Perferendis qui voluptatem exercitationem aut voluptatem.', 2, 32, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(210, 'PRD-317OQ', 'Voluptatem a quis', 'Error reiciendis sint aut impedit voluptate. Assumenda suscipit rerum error ratione quia quia perspiciatis odio. Commodi quas eius sit ratione. Molestiae veritatis voluptatum iste vel nisi. Aspernatur ea recusandae nesciunt tenetur perspiciatis delectus. Officiis aut saepe ipsam alias nam.', 1492.42, 'Sed magnam voluptas cumque dolorem et omnis maiores est quidem quibusdam.', 4, 9, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(211, 'PRD-663US', 'Perferendis iure dolores', 'Odit doloremque nihil numquam quasi harum. Praesentium excepturi ut ut eaque quibusdam et. A eligendi rerum ut aperiam. Pariatur libero alias porro tempore provident et voluptatibus. Et recusandae laborum aut.', 1953.23, 'Officiis laboriosam omnis molestiae modi voluptas eum sit.', 1, 2, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(212, 'PRD-293DK', 'Iure voluptas exercitationem', 'Qui cum accusantium ducimus omnis occaecati at laboriosam. Consectetur earum ut delectus sunt. Quaerat molestiae placeat eveniet impedit. Nisi repudiandae aspernatur sit atque sed et repudiandae. Omnis dolor sit porro.', 955.18, 'Esse voluptatem ullam tempore quae quis id nam sed similique.', 6, 61, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(213, 'PRD-978CV', 'Molestiae quas amet', 'Voluptatum corporis sint in aut sed in. Et rerum ea consequatur molestiae. Ut non distinctio quibusdam voluptatem et. Eaque quos sint quas fuga vel.', 1513.71, 'Unde illo quasi quos vero culpa tempore.', 4, 28, 'uploads/products/default.jpg', 1),
(214, 'PRD-533PI', 'Nam numquam maxime', 'Sit explicabo est quia quia incidunt tempora rerum. Atque est dolor natus aliquam neque harum optio. Officiis at ut voluptatem qui. Ea officiis soluta non necessitatibus et. Maxime et veniam amet repellendus. Alias modi quis quidem excepturi quibusdam. Nulla tempore porro deserunt deleniti.', 582.82, 'Aspernatur adipisci voluptatem explicabo repellendus maiores mollitia dignissimos dolores nostrum.', 4, 8, 'uploads/products/product_5_682b531491006.jpeg', 1),
(215, 'PRD-462XQ', 'Dignissimos numquam sit', 'Dolorem ad omnis quis consequatur est. Sint et quia consectetur non vero eos vitae. Fuga dolorum est ut autem. Sed expedita quos et et sed vel. Et quod ab non fuga officia.', 517.21, 'Accusantium laboriosam quia et occaecati adipisci voluptatem.', 1, 50, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(216, 'PRD-848XK', 'Libero ex et', 'Autem reprehenderit modi earum quasi temporibus. Natus laudantium beatae aut vitae vero vel molestias deleniti. Quidem voluptates earum similique. Iure consequuntur enim ut mollitia. Ex minima excepturi ipsum. Praesentium eos enim et quia minus aspernatur.', 360.50, 'Quas ex eos harum inventore cum dolor.', 6, 69, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(217, 'PRD-886PZ', 'Laboriosam qui consequatur', 'Necessitatibus maiores suscipit similique pariatur autem nulla. Aut nulla dolorum deserunt quo. Quod illum eveniet voluptates placeat numquam quia deserunt. Deleniti qui sapiente fugiat sunt laboriosam.', 739.27, 'Illum ut eum ipsam maxime fuga accusamus quibusdam quia dolorum ex.', 3, 88, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(218, 'PRD-397RY', 'A nesciunt quia', 'Consectetur quia in minus esse voluptas iure nemo. Beatae quia eveniet dolor fugiat maiores repudiandae. Consectetur a dolor vel repellat repellendus. Voluptate quidem porro laboriosam alias qui. Ipsa tenetur rerum officia rem quia harum. Molestiae doloremque exercitationem sed maxime ad nesciunt similique quam. Numquam accusamus voluptatem placeat blanditiis quo dolores.', 1554.08, 'Voluptatem magnam rerum voluptatem eaque temporibus perferendis accusantium at impedit est.', 2, 86, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(219, 'PRD-955MZ', 'In magni consequatur', 'Architecto commodi a esse accusamus. Ullam laboriosam omnis tempora illum nemo. Dolor cupiditate aut occaecati rerum nostrum quia. Sed totam dolores similique ut dolor fuga cumque et. Beatae iusto inventore omnis eius sed recusandae beatae. Natus esse voluptate consequatur incidunt. Vel ut repudiandae asperiores.', 466.49, 'Eaque molestias deleniti laboriosam et sit perspiciatis laudantium labore libero.', 5, 80, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(220, 'PRD-375ZW', 'Ipsa rem sed', 'Placeat eum aut ipsum illo. Nemo veritatis quae ad et. Ipsam quis a quaerat dolorum placeat. Eos similique doloribus minus reiciendis. Quaerat nisi possimus commodi quibusdam adipisci est et. Voluptates error aut nobis minima atque.', 408.69, 'Nam porro tempore doloribus corporis animi voluptas ut.', 6, 72, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(221, 'PRD-261PV', 'Amet doloremque laboriosam', 'Exercitationem distinctio sapiente autem quia est dolorum. Reprehenderit tempora quia voluptas. Corporis in aut iusto quisquam eius. Architecto nobis recusandae enim. Velit sit est eius aut nihil. Ut eligendi quia minima laboriosam omnis sit consequatur. Rerum esse perspiciatis quas illum et praesentium.', 819.30, 'Laboriosam hic sunt voluptatem natus excepturi.', 4, 61, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(222, 'PRD-819DF', 'Nemo soluta enim', 'Animi ea qui eligendi distinctio qui cumque eos. Et beatae voluptatem magnam aut. Esse qui voluptates vero totam consectetur fugit enim. Vitae alias quis asperiores eos quibusdam quam. Sequi dignissimos voluptatem aut voluptatem voluptates aut voluptate. Nulla ea hic et molestiae repellendus et.', 1833.45, 'Excepturi expedita ab quos pariatur soluta officia ut nostrum ex excepturi.', 2, 49, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(223, 'PRD-746YV', 'Ea corrupti consectetur', 'Aut itaque quia sunt exercitationem ullam quia. Voluptatem molestias suscipit sapiente sit. Modi non sed error. Corrupti facilis ullam animi et beatae quibusdam.', 628.27, 'Ad esse ipsa similique necessitatibus maiores eos voluptatibus quo.', 5, 87, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(224, 'PRD-472FZ', 'Sint voluptatum incidunt', 'Id laborum ratione laboriosam. Doloremque consectetur illo quos sint voluptas consectetur iste. Ea quia voluptatibus aut ducimus vel sed. Voluptate quo quibusdam eum quam. Autem odio placeat et temporibus error sit qui corrupti.', 408.78, 'Et nulla qui debitis error officiis suscipit dignissimos explicabo dicta corporis.', 6, 86, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(225, 'PRD-262JU', 'Voluptas distinctio odio', 'Voluptas blanditiis aut iusto odit. Maiores et adipisci voluptas sed iusto corporis. Quaerat et totam voluptatem optio. Totam quo voluptas quo sed dolorem consectetur. Iste accusantium perferendis minima deserunt libero ut et. Nesciunt libero modi placeat ut. Voluptatem laudantium corrupti illum atque ut excepturi pariatur.', 1661.04, 'Eaque minima doloremque et voluptate exercitationem provident nulla.', 6, 30, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(226, 'PRD-261MV', 'Pariatur at sit', 'Cumque voluptatibus occaecati et. Quia est corrupti omnis expedita. Ducimus id adipisci harum iure corporis. Pariatur quia omnis reprehenderit sit ipsum consequatur dolorem. Eius quidem tenetur harum enim at. Doloribus voluptatem corrupti qui veritatis.', 917.04, 'Alias minima itaque ab quis nostrum quidem aspernatur alias eos debitis.', 3, 63, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(227, 'PRD-852ET', 'Hic quis provident', 'Voluptate cupiditate expedita consequatur et. Quisquam nihil omnis quidem sit repudiandae quia. Et dolorem dolores voluptatem optio. Ullam ut aperiam unde quo est.', 344.03, 'Ut a perspiciatis non corrupti odit modi.', 6, 16, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(228, 'PRD-785RY', 'Laboriosam corporis magni', 'Nesciunt nihil ducimus illo quis et et ipsam. Voluptate aliquam ut eligendi sit. Culpa incidunt non error temporibus iusto aut maxime iure. Sed ipsum reprehenderit enim est. Velit in saepe id placeat porro non voluptatem quo. Provident magni ex explicabo magnam excepturi excepturi.', 1467.11, 'Consectetur doloremque amet fugit assumenda aliquam aut.', 6, 6, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(229, 'PRD-110OW', 'Rerum optio qui', 'Provident maxime inventore esse earum est veniam. Dolor dolorum nihil dolor neque soluta aut. Ullam sapiente et quia amet inventore perferendis aut id. Omnis repellat amet consequatur natus nemo libero atque. Vel sint qui et. Voluptas nemo suscipit quae itaque harum adipisci. Aperiam consectetur illo saepe non doloremque.', 117.50, 'Saepe praesentium ut odit ut quaerat aut.', 6, 16, 'uploads/products/default.jpg', 1),
(230, 'PRD-751XY', 'Ut recusandae necessitatibus', 'Perspiciatis fuga at aut quisquam expedita. In at ratione est et est necessitatibus ut. Natus cupiditate dolor dolore et quia ex quas. Quis necessitatibus numquam error cupiditate quae qui non beatae. Iste est deserunt iusto incidunt et assumenda omnis. Architecto est similique unde.', 1206.53, 'Quos quidem corrupti id et tempore voluptatem delectus debitis molestiae.', 3, 70, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(231, 'PRD-736SY', 'Ut quis saepe', 'Error consequuntur magnam animi cupiditate quo aspernatur ut. Aperiam dicta porro omnis accusantium voluptatem aut cum. Aliquam accusantium laudantium non dicta quibusdam sunt. Magni praesentium laborum vero dolorem rerum. Consectetur ex tempora optio. Vel sint a pariatur consequatur delectus ea. Id eum corporis fugiat rem.', 1062.11, 'Dolor error sint nulla modi sunt nihil.', 6, 41, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(232, 'PRD-020SH', 'Eos et eaque', 'Ut reiciendis impedit ducimus ratione. Veritatis in nihil amet minima quos. Dolores pariatur enim alias id impedit impedit dolor. Autem quia consequatur quis et ut dolor repellendus. Iure blanditiis aspernatur est inventore.', 1299.89, 'Sunt repellat quia sapiente voluptas illum.', 2, 49, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(233, 'PRD-590UY', 'Perspiciatis distinctio rerum', 'Soluta explicabo sit vel corrupti quisquam sed reprehenderit. Numquam voluptatibus vel laudantium quia sit inventore. Blanditiis dolorum tempore perspiciatis molestiae. In ex nihil qui eaque eum commodi aspernatur doloremque. Velit nobis a dolore ratione quo. Cupiditate quam consequatur deserunt sit rerum ut assumenda.', 1102.62, 'Natus ut magni quia amet minus suscipit.', 1, 39, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(234, 'PRD-166AP', 'Odit ut rerum', 'Et quam illo qui. Commodi qui porro fuga et. Dolorum atque aut consequatur eos non quam. Dignissimos ipsa et rerum hic magni asperiores. Est mollitia qui iusto temporibus est dolor recusandae.', 799.96, 'Necessitatibus animi quasi nihil quas sapiente.', 4, 6, 'uploads/products/product_5_682b531491006.jpeg', 2),
(235, 'PRD-736PW', 'Velit vitae magnam', 'Laudantium temporibus qui repellat facilis velit rem et. Blanditiis dignissimos excepturi fuga earum omnis atque. Expedita dolores natus aut cum. Laborum delectus officia est debitis accusantium. Quis voluptas iste eum et tempora molestiae. Accusantium vitae aut natus voluptatum sapiente cum. Sint praesentium harum excepturi ut necessitatibus laborum laboriosam architecto.', 527.85, 'Iste similique dolore ullam ut nesciunt sint non.', 4, 46, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(236, 'PRD-732CF', 'Voluptas minima est', 'Inventore perspiciatis similique voluptatem dicta. Odit et esse est quod velit sint hic. Tenetur quia odio reprehenderit pariatur rem. Laborum eum est aut est dolores. Nobis impedit distinctio placeat et ut excepturi.', 660.78, 'Illum eligendi et sint occaecati quam nesciunt ut.', 2, 32, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(237, 'PRD-059BR', 'Aut molestiae laudantium', 'Ipsa tempora ut perferendis cupiditate ut quis corrupti accusamus. Ut eveniet et incidunt laborum et illum odit. Qui qui laboriosam tenetur sint. Ratione explicabo consectetur reiciendis minus sit beatae excepturi.', 976.62, 'Nihil autem molestiae omnis sapiente autem.', 5, 42, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(238, 'PRD-455QH', 'Expedita exercitationem consectetur', 'Et voluptatem quae quae repellat. Vero et hic quia quasi. Aut aut ipsum error iure maxime sit. Fugit amet autem eos. Qui quis facere laborum placeat eos. Quia et quo delectus consequatur non rerum.', 1611.29, 'Dolorem et tempora assumenda sunt voluptatibus saepe repellat eum iste.', 2, 27, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(239, 'PRD-908BK', 'Provident unde fugit', 'Minus et ducimus ut est at sed eligendi. Quo consectetur facere quaerat et. Velit aut nemo numquam ut necessitatibus et. Ea ipsam placeat minima praesentium aut. Sunt aspernatur laborum praesentium et odit. Ducimus dicta animi sit.', 1225.21, 'Sint officiis ipsa modi accusantium explicabo sit vel.', 4, 82, 'uploads/products/product_11_682b52c31797e.jpeg', 2),
(240, 'PRD-643KF', 'Perferendis iusto quisquam', 'Voluptatem vero aut quasi eos omnis est. Consequatur eum debitis qui et modi et ea. Non cum aut iste autem expedita id nam. Inventore commodi ut est dolorem ratione eveniet necessitatibus id. Quisquam modi molestias quisquam aperiam eius ea.', 692.51, 'Fugit eos quo aut ad consequatur pariatur eaque nisi.', 5, 73, 'uploads/products/product_11_682b52c31797e.jpeg', 1),
(241, 'PRD-810EJ', 'Cupiditate suscipit ipsum', 'Dolorem blanditiis praesentium ut qui quia. Sit voluptatibus et sint est autem iste ea sequi. Praesentium facere aut omnis est. Earum culpa saepe molestias atque quia impedit molestiae.', 1491.09, 'Velit dicta dolor odio quaerat occaecati.', 5, 65, 'uploads/products/product_5_682b531491006.jpeg', 2),
(242, 'PRD-988FE', 'Molestias sed id', 'Ratione qui ipsum voluptatibus porro. Voluptate aperiam sapiente aut saepe quod et esse non. Voluptatem dolor rerum facilis tempora deleniti itaque aut. Amet possimus omnis aut soluta impedit hic qui officia. Magni voluptas voluptatem quia dolorem quasi animi. Qui temporibus dolor fugiat et. Iure doloribus sed earum tempore praesentium.', 1238.71, 'Qui repellat quod voluptatem dolor ipsa nemo dolorem eius aut dicta et.', 1, 47, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(243, 'PRD-376CM', 'Accusamus dolor blanditiis', 'Est sunt sed laborum nesciunt voluptate sunt modi. Rerum ipsam minima inventore vero nihil dignissimos ipsam asperiores. Aut impedit expedita atque molestiae aliquam consectetur voluptate. Ipsum in vitae fuga sit. Omnis illum excepturi dolor laboriosam ipsum quas et. Earum maxime autem ab.', 255.75, 'Rerum sunt laborum ut pariatur eos sed qui et quo.', 1, 91, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(244, 'PRD-260VX', 'Non dicta eum', 'Eos accusamus consequuntur maxime assumenda quod. Esse ipsum quia corrupti et amet non. Numquam quasi id nobis quis eos omnis. Illo iste distinctio dicta ut. Soluta suscipit velit similique voluptas.', 991.14, 'Magni deleniti facilis exercitationem nemo consequuntur voluptatem est saepe.', 2, 97, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(245, 'PRD-026GK', 'Consequuntur vitae ducimus', 'Quis eos velit reprehenderit est sed fugiat. Error enim in vel voluptas inventore ducimus. Ut rerum neque consequatur deserunt totam debitis enim. Laudantium ut eligendi eveniet. Sint quo voluptatem et alias reiciendis. Rerum quia consequatur iusto eum commodi doloribus eaque. Fugit enim quibusdam eveniet quia.', 1007.10, 'Id qui deserunt blanditiis ducimus magni.', 4, 3, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(246, 'PRD-697WR', 'Velit porro dolore', 'Perspiciatis ut temporibus accusantium. Omnis ut modi praesentium consequatur aut iusto enim. Similique sint adipisci quia saepe omnis sed. Soluta corrupti quo est corporis. Accusantium quam laboriosam non blanditiis molestias et. Voluptatem mollitia sed harum veritatis neque.', 186.75, 'Distinctio non voluptatem ratione esse dolorem sapiente sunt veniam id dolores.', 4, 12, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(247, 'PRD-089BF', 'Nisi eum porro', 'Eligendi non porro maiores vel rem. Repudiandae distinctio ex quia doloribus sit voluptas quia. Aspernatur est labore quaerat ut voluptas pariatur eum. Neque omnis est vel et. Voluptate officia libero et vel. Beatae magni minima error aspernatur corporis. Repellendus temporibus sequi quisquam deserunt dolor.', 1457.98, 'Qui quasi quia quaerat iste.', 4, 78, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(248, 'PRD-229OK', 'Optio consequatur aut', 'Quo id accusantium ut dolores. Commodi voluptatem et accusamus autem commodi ex. Explicabo aspernatur delectus dolorum dolores corrupti iste. Magnam ducimus ut necessitatibus sed omnis exercitationem. Aut et dolore unde. Nihil non optio a voluptas aperiam et aut.', 1861.72, 'Quia at ea et similique quia quaerat suscipit.', 5, 68, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(249, 'PRD-766NV', 'Perspiciatis fuga asperiores', 'Magnam minima magnam non illo cupiditate sequi soluta. Ea expedita doloribus et quos cumque officia. Ut dicta natus quia qui fuga expedita. Laboriosam non assumenda debitis iure modi. Incidunt aut voluptatum natus quia.', 320.78, 'Quia et molestiae dolores consequatur mollitia ducimus nesciunt.', 1, 4, 'uploads/products/product_5_682b531491006.jpeg', 1),
(250, 'PRD-096TG', 'Incidunt quos fuga', 'Quae totam debitis vel sequi non. Est harum ut et odio libero quis doloribus. Doloribus excepturi dolores voluptatem. Magni voluptas autem tenetur incidunt asperiores repellendus odit. Et reiciendis nobis impedit ipsam rerum. Ut odit molestiae voluptates numquam nihil voluptatem.', 1606.51, 'Porro ab sit suscipit nobis veritatis tempora veritatis et.', 4, 58, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(251, 'PRD-200EQ', 'Quis autem animi', 'Ad velit et quae expedita animi nemo vel. Iste quibusdam minima rerum qui consequatur aut. Omnis culpa qui ea rerum error. Fuga qui dolores ipsa. Molestias ducimus accusantium sequi optio aspernatur in itaque. In nisi iure explicabo. Enim quae voluptatem consectetur reprehenderit dicta maxime dolorem.', 1646.62, 'Assumenda facere cumque doloremque voluptates eveniet.', 5, 4, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(252, 'PRD-390BV', 'Impedit rem vel', 'Et quas id necessitatibus velit rerum velit nemo. Ipsam est eveniet rem repellat. Est omnis sunt ut. Veritatis quos dolorem aut eum. Rerum et non autem quasi nihil eos illo eum. Et quo laboriosam nam odio quia et voluptatum. Architecto architecto libero sequi minima.', 1067.40, 'Excepturi nesciunt vitae asperiores accusantium quo repellendus.', 4, 39, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(253, 'PRD-914NL', 'Error dignissimos quis', 'Velit odit natus et nisi et. Reiciendis assumenda non est reiciendis autem similique commodi dicta. Illo voluptates quas soluta iure vel amet. Id harum harum velit sit. Beatae vero quo fugit repudiandae ab. Inventore aut ipsa quae architecto.', 1295.02, 'Repellendus sed quo sunt nam voluptatum dicta ut quidem possimus.', 4, 49, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(254, 'PRD-323EX', 'Fugit voluptatum sit', 'Quia repudiandae id placeat et ducimus ut. Nesciunt quo consequatur nulla suscipit deleniti minus deleniti. Unde voluptas maiores consequuntur sunt quod sed. Eum at quis est consectetur et.', 984.57, 'Nemo blanditiis voluptatem ducimus numquam optio consequatur harum neque.', 5, 16, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(255, 'PRD-098WH', 'Qui velit explicabo', 'Rerum et et repellendus. Recusandae voluptates autem voluptates ea non vel ea eum. Minima qui necessitatibus reiciendis recusandae incidunt eos natus dolores. Sunt magni nihil rerum quia ut aut. Laborum aliquid soluta molestias reiciendis asperiores. Ea voluptatem et aspernatur modi illo sunt alias. Et aliquid sunt velit sunt.', 1738.41, 'Tenetur eaque maxime non eum ab sit.', 5, 67, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(256, 'PRD-840GN', 'Omnis voluptatem eos', 'Tempora eaque sint quis. Assumenda quibusdam pariatur accusantium. Numquam sint pariatur consequuntur nemo aspernatur. Adipisci ea aut at odio aliquam dolores. Accusamus et quas perspiciatis odio minima illum.', 909.01, 'Sit repudiandae pariatur tempore sit minus.', 4, 73, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(257, 'PRD-343RO', 'Dolorem qui velit', 'Sed ratione dolorem et sed mollitia velit consequuntur. Eaque ipsa ut ea et nobis vitae. Repudiandae voluptas non aut ipsam. Voluptate ut iure dicta. Est quisquam consequatur soluta non. Est eos tempore mollitia eos cumque temporibus.', 335.62, 'Eveniet quos autem rerum repellat dolorem consequatur explicabo.', 3, 90, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(258, 'PRD-697IC', 'Porro rerum natus', 'Qui ex impedit doloremque omnis provident sequi. Dolores delectus eaque veniam. Accusamus nihil qui quia quibusdam at quia. Quas explicabo accusantium esse itaque. Vel commodi dicta amet.', 1352.60, 'Sed et consequatur quae quas officia sit dignissimos.', 6, 91, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(259, 'PRD-869KV', 'Commodi quas placeat', 'Sunt nemo et mollitia dignissimos sequi voluptatem molestias. Nisi omnis ipsam consequatur. Quaerat fugiat quasi ratione blanditiis voluptatem. Quidem quia nostrum sequi consequatur voluptatem nulla. Officia impedit accusamus exercitationem quasi nam.', 441.37, 'Aliquam consequuntur voluptatem neque sed enim dolor sint est.', 6, 55, 'uploads/products/product_9_682b53079cbf5.jpeg', 3),
(260, 'PRD-430SV', 'Eos dolorum dolores', 'Sapiente corrupti maiores sunt et accusantium consequatur. Eveniet qui aut animi dolore. Ad labore hic delectus. Aut dicta voluptas porro voluptatem voluptatum neque omnis. Eum saepe qui ut libero rem aspernatur unde.', 79.60, 'Non iure adipisci aperiam qui nemo dignissimos.', 4, 68, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(261, 'PRD-098UO', 'In molestias eaque', 'Ipsum voluptas occaecati voluptas atque pariatur reiciendis. Atque facilis cumque quia fuga labore. Molestiae cupiditate et quis quas. Eveniet non eum ea qui earum reiciendis error. Et aliquam sunt consequatur cupiditate. Saepe delectus laboriosam facilis modi aut explicabo et iusto. Quis dignissimos minima harum aspernatur ratione et velit.', 1406.61, 'Maxime sunt praesentium quisquam natus nesciunt voluptatibus.', 2, 39, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(262, 'PRD-847UU', 'Quod ut id', 'Quis aut veritatis hic quia nisi est. Provident ut rerum beatae debitis. Deleniti porro quas quidem illo. Distinctio quibusdam qui est vero voluptas quas. Ut laborum eos et harum impedit id. Quae optio accusamus mollitia voluptatum. Possimus laudantium saepe error repellendus ipsum facilis ut.', 1147.64, 'Veniam veniam minus officia sint velit assumenda neque sunt.', 4, 58, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(263, 'PRD-929TE', 'Repudiandae earum veritatis', 'Non enim et rerum. Vel quibusdam recusandae itaque error error dolor tempore. Culpa minima sed non. Harum laudantium ab unde sed vero et. Culpa nihil et consequuntur. Officia odio fugit laudantium est quaerat ratione sed.', 1537.31, 'Dolorem qui magni voluptatem quos amet.', 3, 65, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(264, 'PRD-274VD', 'Explicabo dolore est', 'Molestias dolorem delectus et eum blanditiis quod repudiandae. Porro voluptas aut et. Sapiente quisquam et est placeat. Illum dolore optio enim totam et. Quaerat reiciendis beatae debitis id iste ut ut. Sed nobis vero repellat corrupti repellat harum. Quisquam iste dolor et est id aut provident est.', 974.96, 'Tempore et fugit odit ut animi veniam.', 6, 5, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(265, 'PRD-236BQ', 'Velit vel molestiae', 'Vitae explicabo eligendi dolore. Sit aut est id a. Id debitis ullam nulla aut adipisci odio dolorem. Et et alias tempora minus non.', 1965.31, 'Distinctio officia voluptatibus magni autem vitae nemo.', 2, 33, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(266, 'PRD-683JJ', 'Sunt exercitationem est', 'Sed ut quos consequatur illum ad rem. Eius id aut accusamus cum tempore dolorum. Vitae a autem rem dignissimos totam quae aut aut. Enim perspiciatis id quisquam unde possimus quod. Ut saepe quia quam eum est. Omnis aut laudantium id ea maxime quis. Est ex rerum voluptatem blanditiis incidunt.', 990.17, 'Aperiam sint dolores ea quia voluptas saepe enim dicta.', 5, 41, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(267, 'PRD-681SE', 'Soluta et pariatur', 'In optio molestiae eius rerum nisi sunt. Nostrum hic ex dolore est dicta est. Ipsam mollitia rerum occaecati libero voluptates. Rerum placeat voluptas eveniet itaque. Voluptates distinctio ut ratione labore hic. Aut omnis debitis ducimus quos similique fuga voluptates.', 1539.31, 'Omnis error ut quibusdam ducimus aut reiciendis quo in quo.', 5, 84, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1);
INSERT INTO `proizvod` (`Proizvod_ID`, `sifra`, `Naziv`, `Opis`, `Cijena`, `KratkiOpis`, `kategorija`, `StanjeNaSkladistu`, `Slika`, `tip_id`) VALUES
(268, 'PRD-922EG', 'Numquam quia consequuntur', 'Error illum eligendi delectus et vero. Nulla unde facilis itaque ducimus. Occaecati rerum ut quo aliquid enim aut delectus. Et ea est aut aut provident architecto accusantium.', 434.98, 'Autem earum veritatis explicabo labore aliquid a dolor tenetur id.', 2, 76, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 3),
(269, 'PRD-111YU', 'Atque fugit maiores', 'Neque laudantium impedit molestiae atque. Dolorem ad temporibus quisquam rerum. Fugit quia quia pariatur dolorem ipsum quibusdam non. Accusamus saepe nostrum repellat. Ipsam nostrum deleniti est nulla sequi. Rem saepe autem eveniet quod.', 1404.58, 'Perferendis deleniti beatae consequatur corporis quas repudiandae iusto nulla harum et.', 6, 21, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(270, 'PRD-984ZO', 'Repellat enim animi', 'Saepe nesciunt maxime voluptas quia rerum. Est quae enim maxime provident eos vel. Velit placeat consequatur alias et perspiciatis pariatur repudiandae eum. Suscipit et pariatur cupiditate aliquid sint. Rerum officia et consequatur nostrum. Qui et quos culpa. Quia aut deleniti ut et quod.', 253.89, 'Excepturi aut nisi fugit quidem nihil error.', 1, 25, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(271, 'PRD-870CU', 'Ea et possimus', 'Laboriosam qui necessitatibus quis nesciunt omnis. Vitae aliquam adipisci culpa eligendi id sit. Fugiat qui et fuga cupiditate aspernatur atque dolorem. Odio nulla itaque aut aspernatur quo. Ex magnam vel quasi minus eius consequatur.', 793.75, 'Ducimus dolor architecto et sunt sed qui perspiciatis esse impedit.', 4, 51, 'uploads/products/product_5_682b531491006.jpeg', 2),
(272, 'PRD-005NG', 'Esse vitae velit', 'Omnis sint eligendi corrupti eos. Quia nulla cupiditate rerum laborum veritatis. Enim voluptatem ea praesentium ut in odit pariatur. Quidem nam nostrum et similique ipsum deleniti. Eos id eveniet explicabo et asperiores nobis non.', 1985.55, 'Officia amet sed ut libero qui.', 1, 13, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(273, 'PRD-466UL', 'Dolores enim dolorum', 'Enim dicta sint mollitia placeat. Ut dolor earum assumenda expedita expedita sed illo. Laboriosam porro et quidem ab. Asperiores repellat dolor nobis non. Quidem temporibus minima quibusdam eum.', 504.54, 'Perferendis quaerat exercitationem eum laudantium est.', 2, 90, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(274, 'PRD-714WE', 'Culpa earum assumenda', 'Accusantium ipsum nemo voluptas qui vitae ut iure aperiam. Iste quia beatae asperiores et fugiat omnis. Hic omnis suscipit error nostrum amet placeat aut. Earum accusamus occaecati non perspiciatis fugit aspernatur commodi. Accusantium cum hic deserunt placeat magnam. Facere quibusdam architecto dignissimos nesciunt et.', 730.60, 'Ut reprehenderit blanditiis error tempora sunt maiores exercitationem quia esse.', 4, 93, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(275, 'PRD-050BQ', 'Non eligendi reprehenderit', 'Quisquam hic unde quidem quia. Explicabo eveniet at est reprehenderit perferendis. Ut similique sequi magni nisi dolorem temporibus eligendi. Illo vitae mollitia aut iste rerum totam pariatur. Dicta sit laborum quis rem eum magnam dolor et.', 328.59, 'Voluptatem quae reiciendis aut nemo omnis culpa cumque facilis aut tempore earum.', 6, 2, 'uploads/products/product_12_682b52e8c33a0.jpeg', 3),
(276, 'PRD-205IT', 'Corrupti dolores et', 'Totam voluptates dolorum quos ab et. Pariatur temporibus omnis hic et id a tenetur. Est provident odit minima similique error natus ducimus. Eum architecto quas sed eveniet atque. Maxime asperiores quam libero est tempore rerum. Ullam beatae ex quo qui.', 824.90, 'Et cum qui suscipit consectetur voluptatem totam.', 5, 60, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(277, 'PRD-917ZT', 'Aliquam et accusantium', 'Totam soluta impedit quae quae. Autem voluptates aut at voluptatibus soluta accusantium eius. Possimus minus nisi rerum sit porro. Porro consequatur at officiis. Dolores pariatur quod alias ut aut nobis.', 1594.39, 'Excepturi nulla ut aut sit iusto praesentium maxime eum.', 6, 98, 'uploads/products/product_9_682b53079cbf5.jpeg', 3),
(278, 'PRD-964TF', 'Blanditiis molestiae et', 'Temporibus nulla et quas tenetur harum et consequatur. Consequatur qui possimus illum vel eaque. Tempore dolor facere impedit quos qui nisi minima. Vero harum ut facilis ut voluptatem porro ipsum.', 292.72, 'Ea accusantium non non eveniet quo et temporibus necessitatibus.', 5, 89, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 3),
(279, 'PRD-326QV', 'Hic distinctio dolorem', 'Id earum voluptate sint itaque provident fugit. Corporis sed autem enim. Labore qui ex repellat. Enim eum illum est et dignissimos. Ut sunt alias possimus et.', 1385.89, 'Ea et voluptas accusamus quia tenetur id architecto.', 4, 78, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(280, 'PRD-108HJ', 'Quaerat porro ea', 'Laboriosam occaecati alias vel velit accusamus. Reiciendis temporibus ad dolorem praesentium. Voluptate quis eum possimus et consequatur. Alias aut et et voluptatum.', 150.85, 'Animi deserunt fuga maxime est atque incidunt dolorem numquam.', 5, 32, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(281, 'PRD-954UQ', 'Est sequi aut', 'Nesciunt assumenda qui sed facilis laborum ex. Exercitationem aut eum debitis corrupti eum perspiciatis aut. Unde necessitatibus tempore vitae quo. Vel vel voluptas eum non et. Et ad at quod labore odit impedit. Consequatur inventore laudantium praesentium rerum. Molestiae est sit at repudiandae ad commodi harum.', 1129.54, 'Ut voluptatem ut necessitatibus quia velit illum aperiam reiciendis earum debitis.', 6, 75, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(282, 'PRD-108LG', 'Repudiandae dolores nesciunt', 'Et deleniti voluptates repudiandae quos possimus. Quasi cupiditate sed aut sit. Ab assumenda inventore enim sunt at doloribus at. Eveniet consequatur dolorem est sequi nihil nostrum. Repudiandae et eum vitae eveniet qui. Eos aut qui numquam neque est rerum. Vero voluptatibus cum velit harum.', 1083.49, 'Et sit omnis aut minus sit dolor velit.', 5, 66, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(283, 'PRD-434VK', 'Fugiat deserunt voluptatem', 'Iure quo ut quia aut ut laudantium. Nihil quo excepturi quisquam non. Enim quia veniam sint nihil. Omnis quia ut aut vitae non est inventore. Mollitia dolores iusto molestiae et nulla dolore. Eos officiis doloribus corporis reprehenderit. Nulla distinctio similique perspiciatis quia sunt minima.', 932.66, 'Sint tempore hic numquam ex.', 2, 93, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(284, 'PRD-805WL', 'Velit et tempore', 'Ullam fuga quas dolor sit est explicabo dolor. Deserunt animi nesciunt qui qui repellat adipisci est. Exercitationem beatae excepturi hic incidunt rerum ratione. Adipisci error pariatur laborum perspiciatis. Eos beatae ea non non doloribus. Quis eos quos dolorum qui corrupti eum. Harum sit nobis magnam incidunt nemo repudiandae.', 1750.46, 'Harum quia est quis vel vel autem.', 3, 53, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(285, 'PRD-908YA', 'Ea vitae porro', 'Fugit et vero ea. Eos qui odio ipsam omnis. Neque minima repudiandae sequi distinctio adipisci et. Est praesentium ea placeat hic repellat. Neque consequuntur accusamus sunt.', 559.58, 'Voluptatem nobis earum repellat dolor odio rerum rerum.', 5, 23, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(286, 'PRD-785AC', 'Alias quae asperiores', 'Hic optio magnam exercitationem. Provident aperiam est at in sunt. Molestiae fugit rerum eius rerum perspiciatis. Eos laborum soluta adipisci distinctio sit quia quasi.', 320.35, 'Eos aut sunt fuga ipsum nihil ad aliquam necessitatibus.', 3, 56, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(287, 'PRD-595UI', 'Adipisci alias autem', 'Illum quos quaerat quia omnis. Et qui aut iste rerum dignissimos optio. Voluptates odio rem vero qui reprehenderit molestias qui. Voluptates sed facere alias consequatur ut cumque praesentium.', 1867.49, 'Distinctio nihil assumenda eius quis quos officiis nihil tempora.', 5, 15, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(288, 'PRD-428PL', 'Sit odit odio', 'Dolorem esse voluptates velit expedita ducimus. Qui libero soluta culpa necessitatibus saepe est in. Ea eum dolor id sequi. Tenetur similique asperiores aperiam recusandae ipsa. Qui rerum culpa quaerat ea deleniti. Non officiis saepe voluptas repudiandae.', 1104.37, 'Ullam facilis saepe enim praesentium inventore.', 4, 16, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(289, 'PRD-816MG', 'Culpa repudiandae temporibus', 'Quia aperiam in nihil ex. Voluptatibus velit voluptas quidem voluptas aspernatur unde. Debitis repellat aut voluptatem ut cupiditate rerum. Sit voluptatem aut qui unde laudantium sunt et. Exercitationem est vel quae beatae iusto adipisci voluptatum. Amet alias id quo repellat consequatur ex placeat consectetur.', 1306.34, 'Sed reiciendis qui voluptatibus soluta in velit alias repellat minima.', 3, 1, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(290, 'PRD-553GF', 'Vel laborum inventore', 'Nobis modi et et iste incidunt excepturi. Itaque exercitationem repellendus itaque et. Ea quisquam consequatur qui. Tempora sit est distinctio et modi.', 751.24, 'Aspernatur quam ducimus et fuga est quia aut sit.', 5, 77, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(291, 'PRD-867ZZ', 'Alias at sint', 'Similique nesciunt magnam cum velit eligendi quis. Aut est velit voluptatibus repellendus perspiciatis id. Consectetur ut esse error magni asperiores. Nostrum autem nihil molestiae id laudantium.', 75.46, 'Provident animi ex error et at atque debitis quia.', 3, 43, 'uploads/products/product_18_682b52f92d6cd.jpeg', 1),
(292, 'PRD-177DN', 'Sunt est quibusdam', 'Itaque quis eaque omnis id perspiciatis. Voluptas sit saepe dolorem asperiores. Animi ducimus magni enim mollitia quos assumenda. Sit placeat officia sint est modi corrupti. Dolore porro ut et est quas. Non odit sed natus eos aut et id. Eum nam ullam eum.', 394.53, 'Totam earum eos corporis blanditiis et sed ut enim aliquam.', 6, 8, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(293, 'PRD-507YH', 'Autem repudiandae excepturi', 'Eum voluptates culpa ea veritatis reprehenderit recusandae. Eligendi ut ut qui cum. Ratione ipsum nesciunt voluptatem nam non distinctio. Quos non ut pariatur nihil rem tempora. Temporibus ut vero temporibus vel tempore. Sint magni assumenda architecto alias voluptatem beatae non in. Incidunt consequatur commodi sed.', 167.93, 'Nemo sint ratione cupiditate id iure.', 2, 48, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(294, 'PRD-957QX', 'Aspernatur animi ea', 'Molestias saepe modi qui. Explicabo consectetur ducimus magnam alias et mollitia. Consectetur cupiditate repellendus et. Placeat maxime eos perspiciatis non architecto consequatur magni id. Quis ea eius inventore quidem magni voluptates. Beatae eius repellendus consequatur molestiae inventore. Et quo velit magnam omnis.', 1675.12, 'Quisquam aut consectetur vero quidem.', 2, 8, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(295, 'PRD-115CO', 'Quo rerum deserunt', 'Aut culpa rerum sed voluptates harum. Eum suscipit tenetur fugit ut. Dolorem dolorem est eligendi natus rerum doloribus. Blanditiis dolores quia qui et. Consequatur sequi saepe debitis velit animi animi sed. Doloremque a rerum dolorem cumque. Repellat sed pariatur sequi in.', 644.00, 'Debitis voluptatem eius ut voluptas ut.', 5, 92, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(296, 'PRD-530JH', 'Aut eos aut', 'Inventore vel iure ipsam qui rerum. Incidunt placeat velit voluptatum explicabo. Possimus inventore est esse ut nihil. Quia ipsam voluptatibus facilis vitae sit culpa consequuntur. Pariatur ipsam eum quod occaecati vitae dignissimos. Ut excepturi deleniti ea consectetur distinctio recusandae. Sit molestiae cum dolor sit maxime eum mollitia itaque.', 494.36, 'Voluptatem laborum itaque sed aut non impedit tenetur eligendi quaerat.', 4, 1, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(297, 'PRD-056RR', 'Voluptas odit odio', 'Rerum voluptas laborum sit dolorum. Voluptas labore non eius perferendis occaecati non. Voluptatem aliquam iste reprehenderit cupiditate sed veritatis. Nemo ea quos omnis. Qui est explicabo nobis nobis error. Neque voluptatem ut et reiciendis quisquam neque nemo.', 1851.36, 'Maiores eum enim ea nemo dolorum repellat officiis recusandae ad autem.', 1, 57, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(298, 'PRD-937QZ', 'In qui corporis', 'Rerum praesentium in maxime qui suscipit perspiciatis officia. Laudantium quibusdam beatae quae quo ex ea. Alias accusantium sapiente tempore adipisci eos est. Esse repudiandae ab quisquam quibusdam.', 1550.82, 'Aspernatur fugiat non tempora quam omnis quod suscipit aut.', 1, 41, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(299, 'PRD-999GF', 'Quaerat optio et', 'Qui qui corporis vitae aut eligendi. Omnis ea expedita nulla debitis sit. Optio et expedita illum voluptates facilis ut. Perspiciatis dolorem minus et eaque. At consequatur ut et quod hic. Minima porro qui praesentium at recusandae voluptatem aut. Facere ut perspiciatis tenetur sed sint.', 1920.24, 'Totam cumque quis in praesentium commodi necessitatibus perferendis expedita a laborum quis.', 1, 38, 'uploads/products/product_5_682b531491006.jpeg', 2),
(300, 'PRD-157DR', 'Voluptas dolorum ad', 'Rerum magni delectus nihil esse. Perferendis iste libero voluptas est mollitia itaque autem ullam. Pariatur sint harum ea illo. Quaerat dignissimos perferendis officia. Consequatur vel sed eum sequi doloribus temporibus. Aut officiis mollitia vitae quaerat modi. Aut fugit corporis nisi in debitis.', 1535.45, 'Iste recusandae alias praesentium delectus ratione.', 2, 33, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(301, 'PRD-111XX', 'Nihil perspiciatis laborum', 'Quas veniam exercitationem laboriosam totam. Sit commodi sed saepe pariatur et sunt perferendis. Et eligendi nihil dolorem. Odio non ipsa alias est at sequi. Quod natus odio perferendis. Incidunt numquam aut aut occaecati reiciendis ut nihil quos. Dolores et labore eos fugiat quis in.', 271.70, 'Quis ipsam necessitatibus excepturi vel a impedit doloremque voluptatem dolores dolore.', 1, 16, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(302, 'PRD-698ML', 'Quaerat animi et', 'Fugit adipisci qui ut cumque neque ut nobis. Enim quisquam pariatur eligendi id deleniti. Consectetur omnis qui non omnis ullam tenetur. Alias ipsum est velit dolores recusandae aut nesciunt nemo. Autem explicabo voluptatibus dolor magnam aliquam. Quo quo quis rerum aut eos quidem qui et.', 1144.60, 'Quidem sint nemo ad eos consequatur.', 5, 91, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(303, 'PRD-112QQ', 'Quos et recusandae', 'Dolorem rem amet et autem consequatur aut sint. Ex et itaque recusandae aut. Voluptas non cupiditate quis natus non. Et quia accusantium sequi in est quo. Et voluptates officia est sunt. Aliquam aut dicta qui quia neque ut aperiam. Sint voluptates commodi perspiciatis atque.', 1903.58, 'Doloribus impedit facere mollitia ut a amet.', 6, 10, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(304, 'PRD-556CZ', 'Aut ex laudantium', 'Qui sit officiis aperiam sed. Veritatis ullam amet laboriosam beatae. Distinctio deserunt quo quaerat. Quae aut soluta qui in ipsa at inventore.', 382.86, 'Et consequatur molestiae quis rerum tenetur.', 2, 47, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(305, 'PRD-060PB', 'Minima natus et', 'Quisquam commodi tempore delectus corrupti in exercitationem. Corporis eveniet magnam quos. Fugit dolorum inventore sequi harum totam omnis. Et ut inventore aut et. Commodi perspiciatis culpa voluptates reprehenderit.', 1084.41, 'Magnam blanditiis eligendi quisquam necessitatibus earum et sed.', 2, 70, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(306, 'PRD-898FP', 'Est quas et', 'Mollitia laudantium blanditiis accusantium qui ut. Ab dolorem commodi voluptatem atque suscipit. Deleniti nemo labore tempora enim nihil placeat qui rem. In dignissimos harum porro autem vero qui.', 1374.37, 'Veritatis qui doloribus optio adipisci voluptatem sint quo et.', 4, 45, 'uploads/products/default.jpg', 3),
(307, 'PRD-807FX', 'Deserunt quo maiores', 'Et placeat voluptatem hic ipsum quasi. Inventore ea cumque et. Ipsam quisquam architecto ut assumenda ut delectus. Eum iste at officia. Optio sint aperiam rem dolore est unde accusamus. Quia dolores et qui ut quisquam reiciendis.', 1249.03, 'Et sequi doloremque dolor dolorum nemo.', 3, 63, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(308, 'PRD-847RJ', 'Non voluptatum sunt', 'Soluta veniam suscipit ipsum pariatur voluptatem officia. Cum et enim dolor quod voluptas. Ipsa et sit eum veniam. Ex vero autem eius quis.', 374.76, 'Voluptas a velit aut sit corporis provident facere.', 1, 31, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(309, 'PRD-705OZ', 'Adipisci fugiat esse', 'Quis assumenda placeat dolores repellendus. Rem mollitia et occaecati sit et et veniam. Velit ab voluptatum atque modi. Illo architecto qui voluptatum impedit aut quia porro voluptatibus. Velit similique aut magnam totam illum. Aut et soluta laudantium mollitia nesciunt laudantium id.', 722.70, 'Alias fugiat atque nisi repellat.', 1, 73, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(310, 'PRD-969CZ', 'Ullam vitae rerum', 'Repellat non cumque eos fuga commodi cumque est. Et eaque non neque modi voluptatem. Atque aut ut adipisci ex consequatur rerum. Ut dolores aut aut nemo fuga sunt hic accusantium. Ut amet a deserunt aliquam. Aliquam rerum dolor deserunt reprehenderit quia.', 620.58, 'Voluptas porro nisi dolor voluptatem libero minus vitae voluptatem repellendus.', 3, 34, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(311, 'PRD-466IE', 'Culpa qui eveniet', 'Aut exercitationem illum et. Repellendus maxime ducimus reprehenderit voluptatibus eaque. Non aut facilis at. Consequatur accusantium quidem quia sint exercitationem distinctio et repellendus.', 26.35, 'Rerum delectus alias ratione quibusdam reiciendis voluptatibus.', 5, 62, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(312, 'PRD-222FQ', 'Illum est dolores', 'Quae alias voluptas accusantium et quam perspiciatis. Ea aut autem officiis est dolor vel alias inventore. Voluptate adipisci dolorum ut aspernatur. Ipsum minima iure voluptatem consequuntur ullam. Ea repellendus tempora tempore aperiam hic dolores aut.', 111.15, 'Rem architecto in quibusdam libero magni.', 1, 28, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(313, 'PRD-475BT', 'Et et provident', 'Tenetur molestias quisquam ex dolor temporibus doloremque molestiae quis. Rerum voluptatum qui iure iusto quas sit sit. Consequatur et blanditiis corrupti tenetur suscipit architecto. Aspernatur rem nobis non quia voluptatem. Neque non ut rerum at. Dicta non quaerat aut nulla quis.', 1169.25, 'Tempore fugit fugit consequatur in reiciendis similique eum quibusdam.', 2, 88, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(314, 'PRD-722MH', 'A quod id', 'Harum corporis ut sint excepturi reiciendis alias. Molestiae consequatur vel alias a molestiae. Inventore ea et cumque. Cum quia quo voluptate. Incidunt nisi excepturi enim velit.', 406.11, 'Ex in nulla occaecati ex sint adipisci debitis pariatur dolorem.', 6, 27, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(315, 'PRD-828EO', 'Minus voluptatem rem', 'Praesentium sed corrupti sit cum quibusdam hic. Facere similique fuga facere atque consequuntur. Impedit quo laboriosam et culpa. Molestias harum nam eaque earum. Sint ut in consequuntur amet voluptate.', 1188.60, 'Dolore nam sunt iure earum aut debitis sit rerum rem.', 6, 59, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(316, 'PRD-810OB', 'Vel nulla dolores', 'Doloribus maiores illo quas rerum quidem aliquam autem vero. Quo ut quia ullam quaerat quia laudantium. Eligendi porro fugit maiores. Illum culpa praesentium qui.', 1867.33, 'Delectus delectus temporibus et aspernatur et unde voluptates qui libero id.', 2, 25, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(317, 'PRD-187LY', 'Similique minima veritatis', 'Aut impedit eum et sed aut molestias praesentium. Qui aut sit autem omnis est assumenda dolores nobis. Et tempore praesentium sed eum ea voluptatem ducimus. Nisi iure libero omnis nobis est. Fugiat aperiam fugit corporis facilis commodi. Qui quis qui nam omnis.', 1320.30, 'Dignissimos asperiores odit dolore vero dolor ut quaerat voluptatem praesentium magnam.', 1, 50, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(318, 'PRD-491ZX', 'Cupiditate magnam aut', 'Pariatur temporibus sed rerum minus. Voluptas adipisci accusantium sint sint. Accusamus voluptatem illum veniam est velit reprehenderit non. Pariatur iste animi cumque qui quidem. Eius amet ipsam in ut enim in.', 722.00, 'Illum praesentium perferendis deleniti delectus doloribus dolores iusto ducimus quo beatae placeat.', 4, 4, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(319, 'PRD-869LV', 'Iste qui accusantium', 'Eos sapiente exercitationem velit optio ipsum magnam. Provident mollitia non ad. Reiciendis possimus harum hic magnam tenetur commodi. Amet consequatur est voluptas saepe nulla sit. Unde dolores nobis ut autem autem. Illo repellendus repellendus voluptatum. Et enim doloremque veniam quia.', 1690.83, 'Quia blanditiis eum quia repellendus culpa laboriosam.', 6, 68, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(320, 'PRD-833DU', 'Possimus et qui', 'Maiores voluptatem autem sint vel consequatur. Eius nihil ut voluptate voluptatem dicta. Totam dolor aut ut est non omnis mollitia. Quis officia corporis consequatur minus dignissimos.', 60.40, 'Qui est incidunt occaecati et iste quis qui voluptatem animi suscipit.', 5, 34, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(321, 'PRD-736ZM', 'Molestiae dolorem sint', 'Nisi et illum expedita sed. Sequi dolorum est et cum neque earum quia. Aut in adipisci sit doloremque. Libero aliquam vitae id blanditiis sit. Qui quia adipisci voluptatibus et vel corporis quia necessitatibus.', 1860.81, 'Saepe laboriosam libero temporibus dolor libero minus non voluptas velit dolore.', 2, 17, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(322, 'PRD-770BN', 'Recusandae tempore molestiae', 'Quis fugit quis et sed et. Voluptatem voluptas minus neque dicta sit saepe. Eaque iure quia eveniet ut iure quam. Optio dignissimos enim repellendus alias et dolorem reiciendis. At quo ad aut accusamus. Quam fuga itaque exercitationem.', 95.04, 'Nesciunt doloribus dolore labore id facere.', 5, 33, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(323, 'PRD-168DR', 'Corporis eum amet', 'Eum consequatur veniam sed qui culpa aliquam. Veniam mollitia corrupti natus quae vel. Vel quo voluptates autem qui cupiditate. Ad nam velit nobis libero. Quos distinctio odio cumque ducimus. Rerum aut nostrum fugit. Velit sed labore dolores est est harum ea.', 1793.56, 'Voluptatem consequatur totam et atque eos ea.', 2, 59, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(324, 'PRD-087PO', 'Consequatur eum commodi', 'Eius et velit ullam voluptatem magnam fugit sed. Hic quia corrupti cum est dolor eum. Vitae necessitatibus occaecati eveniet aperiam numquam est. Sit facilis et natus accusamus. Suscipit sit illum perferendis architecto iure.', 1353.55, 'Nobis nihil et sequi deleniti labore doloremque et.', 6, 99, 'uploads/products/product_5_682b531491006.jpeg', 1),
(325, 'PRD-607IC', 'Autem laudantium magnam', 'Eos optio suscipit recusandae facere commodi. Id aut consequatur debitis non. Fuga architecto reiciendis voluptatem et qui alias quasi. Repellat eligendi labore quam. Distinctio deserunt cumque eveniet suscipit impedit error. Minima illum accusantium doloremque impedit. Omnis qui rerum a ut fuga.', 1613.81, 'Nesciunt quo et aut aperiam alias dolor nam.', 2, 18, 'uploads/products/product_11_682b52c31797e.jpeg', 1),
(326, 'PRD-054EK', 'Odit nobis earum', 'Debitis officia architecto eius et. Vero dolorem non laborum qui. Fuga perspiciatis ut quibusdam ut quas ut. Pariatur aut inventore tenetur.', 1872.27, 'Itaque iste aut quis sint debitis voluptates dolore velit.', 6, 40, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(327, 'PRD-364HX', 'Consectetur eaque omnis', 'Quia nesciunt expedita neque voluptatem maiores. Qui reiciendis dolor ut. Molestiae dolorum est repellendus ad repudiandae consequatur error. Suscipit aut nobis eaque consequatur aspernatur quis.', 1297.03, 'Eveniet doloribus exercitationem eos dolore porro facilis inventore eos.', 4, 83, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(328, 'PRD-561ME', 'Laborum et quis', 'Aperiam quo ad dicta non. Accusamus cumque placeat fugiat aut minus repellendus in. Aut beatae facilis dolor molestiae architecto. Qui aut facere blanditiis modi rem enim ad. Harum voluptatem est dolor repellendus quaerat est quas. Dolorum voluptatem natus nihil rerum voluptate. Eius nam explicabo neque omnis excepturi hic.', 1661.63, 'Tempora aut voluptas placeat molestias repellat cumque.', 5, 52, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(329, 'PRD-453RK', 'Minus cupiditate nisi', 'Omnis similique adipisci et aut. Est eum architecto illo. Blanditiis velit reiciendis adipisci voluptas. Occaecati et voluptatem quod ad quisquam harum. Iure reprehenderit velit officiis illum deleniti minima. Beatae velit possimus aut quaerat. Qui omnis laborum nobis sapiente et.', 221.79, 'Et reprehenderit a accusantium quisquam in eligendi.', 4, 96, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(330, 'PRD-820MI', 'Laudantium voluptatibus cupiditate', 'Omnis qui beatae occaecati consequatur culpa. Sit aut illum sequi iure. Libero vero consectetur ea iste. Maxime amet quam dicta atque provident. Necessitatibus aut eligendi rerum quo est autem. Distinctio consequatur autem dolores mollitia sit minus accusantium. Ex debitis et ratione est laborum.', 617.13, 'Impedit fuga animi dolores consectetur distinctio et.', 1, 57, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(331, 'PRD-157ET', 'Saepe aliquam consectetur', 'Aut quod corrupti sed et et. Commodi esse est sequi dignissimos illum. Quis quisquam doloribus repellat possimus inventore adipisci. Doloremque omnis reprehenderit et et deserunt. Eius itaque provident aut nisi fugit explicabo quo.', 1642.97, 'Explicabo et aut enim quia incidunt doloribus qui aut commodi laudantium.', 6, 59, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(332, 'PRD-200LB', 'Ut dolor autem', 'Officia est dolorum facere dolorum qui dolorem iusto. Facere cumque saepe ea sequi consequatur. Eaque facilis id enim nemo ipsam et ipsa. Aperiam non sed sint esse vero eius sit. Ipsum voluptas pariatur vero. Qui quia delectus et quis qui repellendus. Sit velit quae vero repellat odio ad.', 677.84, 'Consequatur quam voluptatem mollitia quas sed molestiae tempore architecto ab accusamus.', 2, 8, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(333, 'PRD-366HB', 'Velit assumenda dolores', 'Perspiciatis molestiae eligendi natus labore rem aliquam aut. Dolorem ratione cupiditate fugit quia ipsum asperiores. Eveniet fugit cumque fuga animi. Dolorem cupiditate necessitatibus harum ut. Voluptatem distinctio nemo a quisquam. Natus distinctio delectus id in assumenda. Molestiae et rerum libero qui dolor distinctio.', 1848.24, 'Molestiae ut molestias laborum aperiam odit nihil.', 3, 15, 'uploads/products/product_5_682b531491006.jpeg', 2),
(334, 'PRD-757DU', 'Et reprehenderit iusto', 'Distinctio quam expedita explicabo et. At est voluptatem aspernatur maiores rerum. Quaerat recusandae consequatur quo quos possimus expedita. Sint qui voluptatem eius quia perspiciatis magnam assumenda.', 1028.69, 'Et ut voluptatem id voluptate blanditiis eveniet est.', 6, 35, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(335, 'PRD-177PP', 'Sapiente sed qui', 'Suscipit rem laboriosam quo est fuga rerum. Fuga qui molestiae quisquam minus eum qui ut et. Tempora quibusdam soluta praesentium qui dignissimos. Sapiente nihil quo sint similique quia.', 293.41, 'Expedita amet consectetur ea et nemo autem.', 6, 55, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(336, 'PRD-743WQ', 'Doloremque deserunt et', 'Sed blanditiis excepturi id sit numquam. Mollitia velit amet officia cupiditate animi voluptatem velit. Qui placeat debitis reiciendis. Ut ex itaque dolores consectetur doloribus et libero.', 1392.51, 'Hic mollitia sit sed dolor ea.', 1, 41, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(337, 'PRD-236OZ', 'Non praesentium consequatur', 'Tempora animi quo minima culpa veniam debitis. Ex necessitatibus cupiditate dolorem consequuntur a. Natus earum provident fugit illo dolorem. Rerum quaerat veritatis qui accusamus recusandae autem. Corporis sunt quia inventore eum perspiciatis. Sed iusto nihil dignissimos molestiae.', 1032.87, 'Voluptatem consequuntur dignissimos ut consequatur dolorem omnis.', 5, 53, 'uploads/products/product_18_682b52f92d6cd.jpeg', 1),
(338, 'PRD-852QS', 'Consequatur rem cumque', 'Et dicta unde nam est. Ut itaque optio et enim minus quis non. Dicta ipsum adipisci numquam quos qui voluptas. Harum laboriosam aspernatur eum et quia quaerat sit. Excepturi amet voluptatibus repudiandae et qui. Accusantium voluptatem voluptatem quidem corporis nobis voluptas.', 1598.20, 'Qui dolor est temporibus quas nesciunt delectus voluptatem pariatur perferendis provident.', 1, 77, 'uploads/products/product_15_682b52ff60908.jpeg', 3),
(339, 'PRD-499UL', 'Est aut quia', 'Vero a earum et excepturi ea aut ea. Ut sed odio ipsa ea. Quam eius repellat veritatis aut vitae. Doloribus iste eum et quis qui.', 564.69, 'Dolorem fugiat molestiae et commodi non adipisci quia sit illum illum neque.', 3, 22, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(340, 'PRD-720CC', 'Quidem dolore doloribus', 'Officiis consequuntur minima ea pariatur quam quae. Sint magnam aut laboriosam asperiores dignissimos ut. Et eos nostrum qui fugiat eligendi eaque beatae. Tempore commodi sit optio commodi voluptas quae. Exercitationem ipsum explicabo nulla placeat voluptas est id. Nostrum autem optio excepturi ut quaerat.', 1940.53, 'Sit non et sit molestiae est dolorem maiores aliquam.', 3, 26, 'uploads/products/product_5_682b531491006.jpeg', 1),
(341, 'PRD-885UV', 'Vero quisquam dolores', 'Dolores dolor ut neque aut autem eum. Aut accusantium praesentium eos facere dolorem. Perferendis nihil animi laborum qui. Voluptas veniam ratione consequatur et aut aspernatur aliquid. Enim officia distinctio voluptatem iusto eos omnis aut explicabo. Eaque nihil commodi tenetur tenetur inventore eius commodi. Unde cumque pariatur eum enim.', 777.46, 'Harum sint nisi delectus temporibus vitae vel alias libero voluptate.', 4, 95, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(342, 'PRD-313YV', 'Est eaque ut', 'Accusamus inventore fugiat voluptatem et. Magni harum molestiae quis. Omnis et sequi autem et est. Ab asperiores minus nihil voluptatibus. Omnis esse ipsum impedit quod qui eos nesciunt id. Rem quia ipsum autem in occaecati repudiandae molestias vitae. Nulla et minus beatae porro eum.', 1784.01, 'Quis id eos expedita quasi similique dignissimos sed aut et ipsum.', 3, 98, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(343, 'PRD-653JF', 'Animi omnis et', 'Voluptatem enim voluptatem aut ut beatae voluptatem. Assumenda aliquam et temporibus rerum eos. Accusantium ipsum et tempore et laborum quae quae recusandae. Impedit qui perspiciatis neque facilis aperiam possimus qui. Fugit ratione voluptatem aut quae delectus incidunt rem iusto.', 1328.52, 'Corporis alias reiciendis ad corrupti itaque ab odit nulla et mollitia.', 5, 51, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 3),
(344, 'PRD-153OI', 'Voluptatem recusandae in', 'Cum aut sed dolores repellendus tenetur non. Sunt ad sed minima voluptatum numquam sequi cum accusantium. Expedita dolor doloremque excepturi animi veritatis. Vero placeat aspernatur iste quia itaque. Optio porro molestiae natus enim provident voluptas.', 1807.29, 'Ut enim excepturi ad ipsum mollitia totam qui quo quasi.', 5, 25, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(345, 'PRD-044TU', 'Occaecati officia voluptatem', 'Non praesentium qui saepe est. Voluptatem rerum voluptatem saepe esse. Et quas nulla laborum quia facilis. Minus totam ducimus dolor incidunt fugiat. Magnam eos maiores rerum doloremque rem. Nihil suscipit optio ut quam cupiditate sed nisi. Distinctio ad non rem culpa minima est.', 558.23, 'A quas harum quod autem asperiores nisi consequuntur magnam voluptatem neque.', 2, 72, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(346, 'PRD-429RT', 'Aut consequatur aut', 'Itaque et architecto amet fugit qui. Ea quia consequuntur adipisci deserunt atque culpa. Necessitatibus quia amet rem. Aut labore hic sint quaerat distinctio. Sequi sed fugiat velit aut. Consequatur esse doloribus fugit earum. Explicabo et inventore voluptatem dignissimos sint odio.', 1518.65, 'Vero ullam ea omnis velit quae eum aut.', 5, 85, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(347, 'PRD-489LQ', 'Ratione at atque', 'Illo sed nemo veniam unde praesentium quos et. Modi suscipit eum dignissimos nihil consequuntur. Excepturi et quia perspiciatis veritatis ut sit provident. Est veritatis atque voluptatem quia voluptas. Illo cum et dicta voluptas impedit. Unde quasi quaerat aspernatur possimus culpa voluptas. Odio hic at nesciunt perspiciatis ea vel.', 993.03, 'Recusandae et quos est eaque rerum.', 6, 14, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(348, 'PRD-643MM', 'Sapiente vero nulla', 'Et ut rem nemo dolores natus vel ea. Ut impedit rerum dolorum fuga. Sunt rerum corrupti veritatis provident quibusdam. Consequatur animi dolores quae laborum. Numquam magni voluptatem aspernatur enim labore accusamus fuga. Quod quidem sit cupiditate sit et est a nam.', 1472.11, 'Porro cum aut culpa facilis ea aut est facilis dolor est.', 5, 61, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(349, 'PRD-273NO', 'Explicabo cumque odit', 'Voluptas quia amet magni optio excepturi. Amet veritatis eveniet veniam sunt vel commodi velit iusto. Est voluptatem non impedit corporis accusamus sequi quia omnis. Omnis aut dicta non nesciunt et dolorum sint numquam.', 558.64, 'Cupiditate aspernatur nam id autem nam officia fuga laborum.', 4, 19, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(350, 'PRD-233LL', 'Velit rerum architecto', 'Non dolores dolorem est dolore. Non incidunt est autem porro deleniti earum ullam. Nisi ipsum deserunt est exercitationem. Facere sit id quis beatae molestias rerum.', 1735.31, 'Doloremque fugit voluptate quos culpa accusantium ut dolor cum.', 6, 19, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(351, 'PRD-547RA', 'Vel inventore quasi', 'Delectus non qui sunt necessitatibus cumque harum itaque. Deleniti delectus voluptatem reprehenderit enim dolores praesentium. Fuga iure dignissimos qui incidunt quia. Veniam ut debitis porro nisi sint minima. Est assumenda nihil officiis quia consequatur. Ratione voluptas aperiam voluptatibus architecto officiis necessitatibus consequatur. Necessitatibus quo consequatur nesciunt officia iure. Iusto beatae distinctio nisi molestias veritatis.', 863.94, 'Et occaecati assumenda natus nobis iure et amet.', 5, 80, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(352, 'PRD-895XW', 'In ut asperiores', 'Consequatur delectus voluptatem dolores ut. Sed repudiandae provident excepturi. Mollitia id non voluptates. Ea tenetur magni sed tenetur perspiciatis optio aut.', 634.20, 'Rerum molestiae architecto eligendi eum voluptatum rerum.', 6, 66, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(353, 'PRD-064ZS', 'Sit voluptas aliquid', 'Ea voluptas rerum ratione rerum ad facilis. Ipsam et aut vel ex magnam omnis fuga. Et iste totam dolor voluptas sit. Nihil magni et molestias iste mollitia a. Aut ipsum quasi deleniti molestias at quam aliquam earum. Quod id exercitationem aut. Atque aspernatur quasi excepturi tempora voluptates.', 348.03, 'Quo consequuntur quis assumenda dolorum omnis recusandae porro.', 5, 57, 'uploads/products/product_11_682b52c31797e.jpeg', 2),
(354, 'PRD-664GU', 'Illo ipsum illo', 'Non sed reprehenderit fugit nam qui est. Aut nisi qui quaerat sint at inventore. Placeat cupiditate voluptatem amet qui. Blanditiis consequuntur ut voluptas optio.', 608.85, 'Neque dicta ipsa esse quos sint iure rerum in modi.', 3, 39, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(355, 'PRD-704BP', 'Est et dolor', 'Qui voluptate molestiae consectetur sed sequi sed aut. Quia porro optio aut. Sunt soluta aut sequi quasi non officia voluptatem. Earum vel nemo voluptatibus omnis. Nulla debitis dolore fugit iure mollitia ut.', 651.96, 'Repellendus delectus dolores necessitatibus architecto quia repellat laudantium similique.', 4, 4, 'uploads/products/default.jpg', 1),
(356, 'PRD-389UJ', 'Consequatur excepturi nihil', 'Tempora rerum et facilis quasi quidem. Ullam molestias vero odit et accusantium. Qui beatae vero officia asperiores nesciunt occaecati velit. Non ullam quaerat illum nulla et veritatis sapiente. Iste eveniet pariatur occaecati atque at iure.', 1986.18, 'Aliquam iure pariatur adipisci animi rerum commodi perspiciatis in.', 4, 88, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(357, 'PRD-131IE', 'Totam voluptate veniam', 'Repellendus dolorum corrupti vel. Aspernatur doloremque ut veritatis et rerum. Est nesciunt possimus voluptate ducimus. Cumque molestias nihil iusto eaque.', 417.43, 'Doloremque sequi quos omnis sed voluptatem qui occaecati nesciunt ut.', 3, 90, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(358, 'PRD-585OW', 'Voluptatem quod sit', 'Blanditiis dolor dolor minima qui. Et ducimus aspernatur perspiciatis ad. Quia vel adipisci vero optio dignissimos. Nobis enim sunt fugit quasi quo voluptatem.', 1687.65, 'Fugiat et laudantium praesentium cumque ullam sit necessitatibus labore.', 5, 47, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(359, 'PRD-601GA', 'Voluptatem aut sapiente', 'Culpa ut esse nihil quibusdam aliquam consequatur. Odio alias possimus tenetur sequi eius quis assumenda. Eum magnam molestiae exercitationem et. Deserunt laborum assumenda cum recusandae. Similique ducimus cupiditate et velit molestiae omnis. Accusantium ipsa ipsum dignissimos neque explicabo.', 1827.38, 'Nihil fuga molestiae debitis cumque quae voluptatem delectus dolorem accusamus voluptatem non.', 5, 63, 'uploads/products/product_11_682b52c31797e.jpeg', 1),
(360, 'PRD-604RY', 'Nulla voluptatibus voluptatem', 'Voluptas exercitationem velit esse possimus modi veritatis quod aperiam. Nisi laborum nemo et numquam. Quis quasi ut sit aliquam enim accusantium molestias maxime. Eveniet saepe maiores et.', 1046.92, 'Nisi eos qui qui ut cupiditate.', 6, 12, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(361, 'PRD-410PE', 'Velit exercitationem voluptatem', 'Et debitis eaque et numquam. Ullam repellat laborum aspernatur illum adipisci. Commodi laudantium dicta et et. Cupiditate sunt doloribus fugiat delectus in inventore. Alias pariatur quo magni dignissimos perferendis. Tempore minus reprehenderit aspernatur adipisci non.', 1887.15, 'Praesentium dolorem rerum earum corrupti vitae eveniet eveniet nisi corrupti.', 4, 1, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(362, 'PRD-220TS', 'Sequi voluptatibus iusto', 'Facilis ad praesentium et voluptatem est voluptatum explicabo. Voluptates tempora optio libero eveniet exercitationem impedit inventore. Harum voluptas blanditiis sit dolorem voluptatem ad. Autem officiis nostrum repellat. Cupiditate sit recusandae rem dolores quos.', 1585.88, 'Aperiam quidem nobis fugit perspiciatis aperiam ea fuga est doloribus.', 2, 44, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(363, 'PRD-381PV', 'Magnam fugiat et', 'Repellat quas rerum voluptate sit quas ut delectus. Nesciunt eius ad expedita quidem. Laborum omnis sunt et natus eum distinctio. Quidem nihil laudantium voluptate mollitia ut. Quo unde doloremque illum minus consequatur.', 902.88, 'Aut sed enim quibusdam enim repudiandae placeat sunt.', 6, 85, 'uploads/products/product_11_682b52c31797e.jpeg', 2),
(364, 'PRD-668SM', 'Nemo expedita ipsa', 'Voluptas quod itaque ut vero id quisquam. Quo quidem rerum ut minima. Voluptas voluptatem sint aliquid. Quos fugiat et nobis.', 1952.31, 'Harum ab quidem unde deserunt ipsa placeat eligendi facilis et repudiandae.', 1, 33, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(365, 'PRD-573KW', 'Aliquam vitae eos', 'Ut cupiditate pariatur cum repellendus. Eveniet et et ipsam fugit. Est nemo aspernatur dolores quia excepturi ad magni voluptatem. Sed expedita optio recusandae qui.', 1208.91, 'Esse esse voluptatem aut non maxime libero fugiat suscipit et.', 3, 12, 'uploads/products/product_5_682b531491006.jpeg', 1),
(366, 'PRD-221XU', 'Et in quae', 'Dolorum voluptas ipsum non sapiente. Molestiae sunt voluptatibus perferendis excepturi explicabo quo perspiciatis. Qui deleniti sit in magnam omnis harum ipsam. Omnis accusantium ut cupiditate id ut vitae molestias porro.', 1165.09, 'Ad error quia id aspernatur a id quod amet incidunt.', 1, 49, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(367, 'PRD-956WM', 'Quam quaerat optio', 'Sint corporis iure est voluptas. Soluta excepturi sunt ut est. Vel impedit in velit molestiae perspiciatis molestias. Soluta voluptas voluptatem repellendus quia.', 1580.38, 'Nam repudiandae ut architecto aliquid tempora nulla sapiente reprehenderit dolores.', 3, 92, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(368, 'PRD-844KT', 'Ea sed ullam', 'Qui in minus corrupti quaerat sed ipsum sapiente. Ipsam provident magni nobis quidem fuga quia sit quidem. Quasi deserunt incidunt voluptatem minus. Doloribus porro repellendus non odit. Qui sapiente fuga quas eum quae voluptatem. Esse similique deserunt aliquam quaerat voluptatibus natus. Voluptatem eveniet rerum placeat id harum quia.', 1933.02, 'Provident doloremque commodi molestiae officia corporis.', 3, 92, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(369, 'PRD-316ZE', 'Dolores quasi iure', 'Qui reiciendis officiis voluptate vitae explicabo dolor hic. Beatae occaecati qui ut et. Qui autem dolores harum ut beatae hic. Officia eos reiciendis praesentium commodi quam quae. Maiores est dolore et maiores dolore quos. Sint quos dolorem dignissimos possimus qui esse odit. Ea magni id pariatur.', 724.88, 'Provident rerum qui modi dolor architecto quaerat deserunt.', 2, 44, 'uploads/products/product_3_682b52d24e5ab.jpeg', 3),
(370, 'PRD-637MX', 'Sed labore beatae', 'Quidem autem voluptate enim laboriosam ducimus sit minus. Repellendus porro enim ipsa corporis hic. Repellat quia dolorum harum et illum. Aspernatur quaerat quaerat voluptas quos velit sit. Minima id dolorum cumque magni dicta impedit et sapiente. Commodi in architecto debitis alias amet.', 484.69, 'Tempora sunt ullam sint voluptatem non ipsa.', 5, 12, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(371, 'PRD-397TO', 'Repudiandae repellendus libero', 'Dolor et quaerat consequuntur eum. Laborum voluptas deserunt fugit corrupti. Sunt at eligendi omnis et et aperiam. Voluptatem perferendis voluptas dicta voluptas labore unde reprehenderit.', 949.06, 'Officia et culpa qui amet aut praesentium quos et veritatis alias.', 5, 46, 'uploads/products/product_12_682b52e8c33a0.jpeg', 2),
(372, 'PRD-641RR', 'Unde in ipsa', 'Consequatur consequatur voluptate consectetur tenetur voluptate. Voluptas voluptas quidem quia quia. Quia et molestiae magnam in reiciendis voluptas. Et totam enim reiciendis sed. Qui dolor nostrum nobis aut magnam.', 1646.50, 'Tempora fugiat facere aut blanditiis ad laudantium quo quasi.', 2, 75, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(373, 'PRD-435CF', 'Saepe esse totam', 'Quis veritatis dolor suscipit beatae distinctio. Ut animi eum dolores a. Ut vitae ipsum enim suscipit natus facere dolores. Quo provident deleniti eos hic omnis vel. Earum quod tenetur amet eaque quia quis.', 295.17, 'Aut itaque et veritatis eos maxime est inventore voluptatem sapiente dolorum.', 5, 52, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(374, 'PRD-920XL', 'Ad et ex', 'Ut dolorem consectetur sed architecto harum unde. Ea nobis in provident numquam ut ut. Harum beatae esse porro fuga maxime voluptatem et ipsa. Nulla et ex harum officia.', 1052.37, 'Modi voluptate cum enim dolore doloribus.', 3, 71, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(375, 'PRD-864MQ', 'Vitae eum id', 'Natus repellendus minus nulla expedita totam sit. Distinctio corporis quidem autem autem ducimus. Commodi sunt non eos voluptatem. Quia minus eaque nam eveniet et. Quis totam dolorum sed eius rerum sit. Est voluptas explicabo beatae.', 710.18, 'Labore praesentium dolores a aut vero architecto esse autem tenetur ut.', 1, 93, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 3),
(376, 'PRD-942FV', 'Sint autem et', 'Doloribus tempora officia voluptatum dolore voluptate nobis sed repellendus. A eius corporis reprehenderit omnis. Et quaerat nostrum reprehenderit mollitia. Voluptatum nobis maiores voluptatem et cumque. Dignissimos et laboriosam explicabo.', 238.13, 'Molestiae quae quo quia accusantium necessitatibus.', 3, 72, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(377, 'PRD-086MK', 'Expedita temporibus sunt', 'Quae voluptatem est aut incidunt ullam sed. A aut voluptatem voluptates non beatae facere non. Voluptatem dolorem provident est aperiam. Sed odio minus voluptate voluptatem.', 1731.31, 'Quia numquam et alias sed suscipit vero sint.', 2, 68, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(378, 'PRD-629GI', 'Quia est nostrum', 'Occaecati nam qui cupiditate sit labore quas aut. Mollitia molestiae placeat autem aut sapiente vero. Rerum laborum cupiditate omnis libero veritatis odit temporibus. Harum quas exercitationem possimus nihil quasi. Ab consectetur quia blanditiis excepturi nemo delectus. Amet deserunt quo quisquam mollitia.', 1214.24, 'Aperiam in neque voluptatum ut molestiae officia sunt quos fugiat voluptatem.', 4, 48, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(379, 'PRD-759ZL', 'Consequatur omnis sint', 'Quaerat voluptatum similique architecto omnis quasi dolor. Sint sit nam suscipit eos. Fuga at dolores accusantium dolor delectus qui. Nemo a est est assumenda. Voluptates voluptatum laborum quam ut expedita quasi eos.', 1293.64, 'Quae non facere quia ut quo molestiae.', 6, 90, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(380, 'PRD-618RZ', 'Distinctio ut similique', 'Deleniti id eum ipsa reprehenderit autem dolorum voluptates. Nisi aut qui nemo libero enim. Optio harum ut quia nesciunt dolores error blanditiis. Accusantium architecto sunt sed eum aspernatur illo. Ad ut porro et ipsa quasi tempora magni. Qui quam reprehenderit animi amet rerum. Vero repellendus qui magnam laudantium autem omnis incidunt non.', 1760.61, 'Repellendus corporis magni et unde eos eos fuga omnis.', 2, 35, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(381, 'PRD-513FS', 'Et et quis', 'Ab eligendi quia dolorem velit unde non accusantium. Odit dolorum voluptas in perferendis magni explicabo. Maiores et asperiores iste maiores fugit ad tempora. Cumque numquam qui recusandae.', 1174.31, 'Deserunt sed impedit aut asperiores repellendus.', 6, 47, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(382, 'PRD-601RR', 'Est fugiat dolores', 'Eos ut quod aut et debitis. Ipsum doloribus et et quia nobis amet. Aut unde repellendus laborum. Est assumenda culpa at nam alias illum.', 742.65, 'Et provident est voluptas rerum consequatur quasi eius est rerum.', 1, 73, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(383, 'PRD-985ET', 'Sit dolorem deleniti', 'Saepe quas adipisci tempora dolorem atque autem autem dolore. Rerum sed odit modi dignissimos exercitationem. Non eaque laborum repudiandae exercitationem. Minus tempora et iure qui. Facilis corrupti est et est cupiditate minus.', 422.97, 'Ut veritatis ut nihil voluptate eum est pariatur ducimus.', 4, 40, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(384, 'PRD-113GP', 'Est doloremque odit', 'Pariatur non quae amet vitae magni iusto. Deleniti iure voluptatibus necessitatibus optio aliquid iusto perferendis. Provident voluptatibus mollitia aspernatur. Molestiae voluptatum dolore rerum nobis labore. Dolor quaerat atque magnam impedit error quo molestiae. Nam repellat quam aspernatur quo dolor consequatur.', 222.99, 'Dolor molestiae est aut enim qui dicta aut ab.', 2, 83, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(385, 'PRD-085HY', 'Quibusdam alias molestias', 'Id qui consequuntur quisquam. Perferendis in eius non necessitatibus ea. Accusamus cumque rem sunt vitae. Libero sed repellat distinctio iure accusantium. Delectus vel ad est aliquid hic laudantium eos. Dolorem saepe atque aliquid repellendus et.', 454.51, 'Commodi nobis sunt reprehenderit est debitis et reiciendis nisi aperiam error.', 4, 82, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(386, 'PRD-128JE', 'Modi recusandae aspernatur', 'Doloribus quaerat mollitia doloremque accusantium tenetur placeat inventore. Voluptatem magni in commodi quia est. Qui officiis non neque voluptatibus laboriosam. Qui et sit iusto facilis qui in soluta.', 417.45, 'Odio nostrum commodi quia nihil est accusamus quo rem illum.', 1, 86, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3);
INSERT INTO `proizvod` (`Proizvod_ID`, `sifra`, `Naziv`, `Opis`, `Cijena`, `KratkiOpis`, `kategorija`, `StanjeNaSkladistu`, `Slika`, `tip_id`) VALUES
(387, 'PRD-263TP', 'Enim nostrum aut', 'Fugit et optio aspernatur harum ex iusto. Quae saepe inventore deserunt sed accusamus quos quas. Eum aut temporibus earum cupiditate aut quidem. Quam suscipit iusto et doloribus. Illum debitis libero qui est.', 810.59, 'Illum reiciendis illum est ipsum veniam voluptatem.', 3, 46, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(388, 'PRD-406PH', 'Laborum iure voluptas', 'Enim quo placeat rerum libero at libero dolorem. Deleniti asperiores et explicabo aut. Aut earum sit eveniet autem. Quo cupiditate vel numquam suscipit ad velit hic temporibus. Architecto quis dignissimos perferendis ipsum.', 1151.86, 'Repellat reprehenderit vel voluptatum qui voluptatibus eum ullam non.', 2, 42, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(389, 'PRD-041LH', 'Quidem enim non', 'Inventore voluptates porro quis alias voluptatem eum doloremque. Incidunt voluptas error omnis molestias impedit facere. Magnam cumque aut quis enim sed explicabo. Tempora optio dignissimos sunt nulla.', 1885.39, 'Qui aut minima libero qui officiis voluptatibus quo eum.', 4, 20, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(390, 'PRD-134MH', 'Vitae unde commodi', 'Id ea eos et asperiores sint magni atque. Autem ea illum ea mollitia voluptas adipisci rem. Aliquam magni incidunt iste et dignissimos. Voluptatum autem odio totam id accusamus aut non. Iusto eum quidem quasi modi rem eaque expedita. Explicabo consequatur animi repellendus excepturi quo.', 1945.88, 'Perferendis temporibus et nemo ullam ratione rerum aut qui nobis.', 1, 99, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(391, 'PRD-656CL', 'Nisi porro delectus', 'Animi ut qui eligendi eum non. Aliquid eveniet officiis est deserunt. Consequuntur explicabo nemo minima. Eum aut sed hic repudiandae excepturi commodi quia incidunt. Quidem sapiente voluptate in nam deleniti adipisci odit velit.', 1033.20, 'Et dolores ducimus dicta pariatur accusantium sit provident qui autem.', 1, 93, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(392, 'PRD-923UY', 'Odit consequatur amet', 'Veritatis mollitia consequatur molestias nisi debitis. Eligendi quod nostrum officiis culpa aliquam. Quidem ad occaecati necessitatibus incidunt. Et quas et ipsum laudantium. Velit voluptatibus assumenda facere quaerat architecto. Qui veritatis ut quae maiores illo non fugit.', 1759.24, 'Aliquid vero quos et expedita qui eligendi autem voluptatibus.', 5, 85, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(393, 'PRD-859XO', 'Autem occaecati et', 'Et dignissimos optio laudantium aut. Dignissimos sed facilis numquam unde at et. Ad saepe soluta placeat asperiores eum minus autem. Unde architecto cum omnis voluptatem quo dolores et. Unde qui perspiciatis dolores. Quis temporibus incidunt et doloremque incidunt in. Explicabo possimus repudiandae adipisci accusantium cupiditate.', 1400.77, 'Sunt incidunt ipsum ea molestias qui cum.', 5, 40, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(394, 'PRD-924BN', 'Possimus excepturi provident', 'Quaerat officiis eum ratione. Ad maxime deleniti eaque distinctio aut. Ratione magnam quae quisquam aut officia nesciunt corporis. Quo non iure sit veritatis nemo molestiae.', 842.31, 'Accusamus cupiditate dolore quia omnis soluta praesentium est non tempore iure.', 5, 33, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(395, 'PRD-544BZ', 'Maiores non dignissimos', 'Sapiente iusto qui optio aperiam molestias. Placeat quo aperiam ea rerum ut. Laudantium rerum non similique autem minima. Et alias velit ut adipisci sit doloribus tenetur. Ut velit in ab deserunt ducimus mollitia. Quia saepe et ipsam id.', 882.71, 'Saepe recusandae possimus aut quia.', 6, 71, 'uploads/products/product_5_682b531491006.jpeg', 3),
(396, 'PRD-416FG', 'Doloremque sint quia', 'Nam occaecati et voluptates molestiae. Cum et rerum in quis quia necessitatibus. Voluptas in qui ex. Est neque consectetur aut sed incidunt corporis recusandae voluptatibus. Neque quis suscipit sit enim omnis vero quo. Est repudiandae molestias ipsa.', 1184.01, 'Qui fugit quia sed quibusdam nihil porro alias et dolore cumque.', 3, 53, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(397, 'PRD-131CO', 'Libero omnis eius', 'Ea doloribus sit quis laborum eos odit. Et repellendus minima molestiae cumque quasi omnis. Reiciendis rerum in sed beatae molestiae quis. Voluptatem error doloremque veritatis et. Modi est modi eos nostrum quo laboriosam magnam. Aspernatur mollitia omnis sit architecto. Repellat rem a quo doloremque autem rem.', 1008.58, 'Voluptatibus id voluptas pariatur eos illum dolor et aspernatur aliquam.', 2, 79, 'uploads/products/product_12_682b52e8c33a0.jpeg', 2),
(398, 'PRD-622TG', 'Nihil itaque et', 'Voluptatem cum sunt iure sed. Ad perferendis nulla repellendus molestias qui eos dolorem. Voluptatum veritatis officiis doloremque vel eum. Eaque corporis neque explicabo. Expedita sed non in aut ut. Animi nihil omnis est et vel dignissimos autem. Quidem est sit vel id voluptatem voluptatem assumenda.', 177.41, 'Ipsum corporis odit dolore alias ut iure omnis.', 2, 93, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(399, 'PRD-537SF', 'Impedit nisi assumenda', 'Veniam placeat quia nesciunt odio consectetur fugiat. Consequatur aut magnam occaecati. Est non ut voluptatibus dignissimos et. Animi et dolorem ut quos. Consequuntur iure explicabo qui. Ut nam et optio maiores id aspernatur sed sequi. Officia repellendus dolorem omnis placeat quae.', 518.22, 'Culpa quis et eos quia iusto amet et.', 2, 99, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(400, 'PRD-353WZ', 'Corporis minus rerum', 'Incidunt officiis est eius illum dolorem ipsum aut. Quaerat nihil repellat nam repellat harum ipsa autem. Mollitia itaque voluptate asperiores voluptatem ducimus aliquam. Voluptas ut quasi aliquam qui id ipsam eius. Sequi aliquid tempora aut non qui culpa. Vel unde quod eligendi dicta. Voluptas officiis eos dolorem autem qui doloremque rerum.', 500.90, 'Commodi odit accusamus dolores sunt.', 6, 85, 'uploads/products/product_5_682b531491006.jpeg', 2),
(401, 'PRD-993NQ', 'Eius accusantium at', 'Eos labore sit quasi qui molestias voluptatibus harum molestiae. Perspiciatis nihil earum voluptatibus et et ipsum. Consectetur aut non non sapiente. Quam fuga expedita placeat qui sint. Et optio molestiae et quia id quia. Necessitatibus fugiat asperiores in a omnis magnam est.', 1292.12, 'Distinctio cupiditate optio delectus rerum et quis.', 5, 7, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(402, 'PRD-464ES', 'Perspiciatis quibusdam blanditiis', 'Et omnis consequatur nostrum quas voluptatum velit molestias. Exercitationem placeat non possimus ullam numquam dolor. Nihil est deserunt quos quis enim qui eos at. Expedita fugit voluptatum et corporis adipisci. Accusamus mollitia perferendis aliquam sapiente illo.', 1788.71, 'Vero ex voluptatem quos id magni ea enim repellat aut deserunt.', 4, 45, 'uploads/products/product_14_682b52b3204d2.jpeg', 3),
(403, 'PRD-381OU', 'Incidunt veniam et', 'Est dignissimos molestiae cupiditate vel voluptatibus ratione molestias eveniet. Maiores quos nulla dolores sit perspiciatis. Modi possimus distinctio neque est adipisci iure aut sed. Labore aperiam est autem voluptatibus. Soluta nihil ut enim dolores incidunt excepturi quo. Error sit sed et praesentium. Odio sunt impedit eaque aut eligendi.', 1720.42, 'Deserunt nobis et temporibus ullam omnis.', 1, 4, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(404, 'PRD-532TV', 'Ullam quam illo', 'Dolorem eos molestiae dolorem error ipsum excepturi. Suscipit et qui error quis veritatis labore ipsa. Natus velit excepturi unde doloremque. Laudantium voluptas aspernatur eaque et sit. Aliquid ea quia voluptas praesentium commodi perferendis unde.', 1883.23, 'Culpa quis tempore dicta non natus.', 6, 69, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(405, 'PRD-109DI', 'Quos ad id', 'Aliquam cupiditate id ex sit aut consectetur aut. Inventore ut consectetur adipisci magnam et occaecati. Qui ad consequatur quo laborum eum. Optio unde facere illum aspernatur. Dolorum sapiente odio quia architecto pariatur. Ex nemo exercitationem ab.', 161.41, 'Distinctio perferendis sunt odit reiciendis suscipit aut fuga.', 1, 74, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(406, 'PRD-390YU', 'Officiis sapiente culpa', 'Neque quis fugit doloremque dolorum nostrum alias eos. Unde in voluptatem eos sequi eligendi ut. Nobis est repellat magnam quia. Odit aliquam minima error et atque. Quae voluptatibus nihil ut aperiam asperiores dolorem. Quaerat est occaecati eveniet sunt. Consequatur nulla numquam modi voluptas sunt.', 772.04, 'Fugit ut mollitia et nostrum enim rerum rem quae eveniet ea.', 2, 4, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(407, 'PRD-000NQ', 'Et corrupti alias', 'Itaque minima sed alias ipsa nihil exercitationem sint quis. Fugit nisi odio harum nihil ea velit. Vel assumenda et quia eos error. Tempore nemo est inventore corrupti quod dolorem. Et quia quaerat repellat in. Numquam quis eos quo explicabo sint. In voluptatem consequuntur aliquid non qui voluptas.', 24.16, 'Consectetur voluptatem omnis est quia dolorem optio corrupti recusandae alias sint.', 6, 90, 'uploads/products/product_12_682b52e8c33a0.jpeg', 2),
(408, 'PRD-799IK', 'Maiores doloribus quas', 'Consequatur rem modi consequatur ut et qui. Incidunt asperiores accusamus enim non. Et quibusdam neque optio ducimus quia totam. Sequi vero provident saepe ipsum nisi velit et. Provident pariatur est neque voluptatem. Ullam voluptatem magni repellendus ut.', 816.04, 'Libero et voluptate tempore et eos eligendi id aliquid ratione.', 2, 5, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(409, 'PRD-220DL', 'Harum doloremque explicabo', 'Velit non dolor vero quae quod doloremque ex. Ea aspernatur modi totam quam illo numquam. Et sit delectus consectetur eos ut beatae sed. Et et saepe voluptatem blanditiis. Fugiat enim quo labore voluptates placeat.', 72.42, 'Sed sunt aut dolor eos sint eos vel et optio.', 6, 85, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(410, 'PRD-016AC', 'Provident ut et', 'Ea commodi qui culpa incidunt at non expedita sed. Est sint ullam reiciendis sequi accusamus. Deleniti quia dolores voluptatum quaerat enim ab. A illo optio ratione modi consequatur in ea. Nihil sapiente voluptatem ex consequatur minima non possimus.', 25.78, 'Qui dolor repellat et tempora quos omnis.', 1, 17, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(411, 'PRD-685FS', 'Qui et aspernatur', 'Asperiores et inventore sequi fuga dolores minima et. Occaecati dolores et sed. Nostrum incidunt atque est eum sunt mollitia. Et omnis dolorum molestiae sequi quisquam eius libero. Facere eos consequatur nihil tempore id qui id. Sunt officiis hic consequuntur maiores placeat. Autem eum dolorem quod at.', 497.56, 'Rerum tempora corrupti vel iure ad sequi occaecati et aut molestiae.', 2, 60, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(412, 'PRD-413TH', 'Laboriosam mollitia quia', 'Ipsum officiis mollitia et tempore. Vel qui accusamus rerum et. Vitae ut vero quae. Laudantium vel ipsam iure alias placeat.', 880.67, 'Ea sint dignissimos qui est ea tempore et quia qui sunt.', 3, 14, 'uploads/products/default.jpg', 1),
(413, 'PRD-596UZ', 'Quia doloribus consequatur', 'Iste et reiciendis distinctio earum. Assumenda et omnis ullam vero vel praesentium. Maiores explicabo ea voluptatem quam impedit quaerat ut. Cum sunt hic cumque in eos debitis temporibus corrupti. Blanditiis possimus consequatur sequi. Explicabo ad sint ab ducimus consequatur.', 253.22, 'Odio quia rem molestias voluptatem quis culpa doloribus labore odio est.', 2, 70, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(414, 'PRD-791DQ', 'Facilis rerum consequatur', 'Veritatis quas et deserunt dolor aspernatur ut. Voluptatem dolore et et consequatur porro doloremque nesciunt quia. Non ad et soluta hic perferendis aliquid voluptatem. Tempore voluptatem tempora cum. Excepturi facere voluptatem et consectetur et ea. Officiis dolor laboriosam tempore neque quae nihil a.', 1156.55, 'Corrupti voluptatem eaque dolorem reprehenderit dolore cum ab.', 2, 78, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(415, 'PRD-405GB', 'Aut adipisci ipsum', 'Quaerat et impedit commodi voluptas sit. Est porro minima laboriosam est similique facilis consequatur. Quod adipisci velit cupiditate dolores. Quo rerum aut atque et est sed eius.', 1666.96, 'Ea officiis consequatur assumenda sunt voluptatem possimus quis ut earum dolore.', 6, 5, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(416, 'PRD-608AH', 'Aperiam deserunt expedita', 'Harum officia sapiente atque alias vel. Repellat non incidunt omnis illo ea incidunt. Facere et non a. Aut libero tempore dicta consequatur iure perspiciatis non.', 571.13, 'Aspernatur excepturi voluptas quisquam eveniet molestias itaque voluptatum dicta.', 3, 63, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(417, 'PRD-705BN', 'Qui voluptas aliquid', 'Et voluptas maiores at quo suscipit dolorum. Ipsam temporibus non et assumenda dolor porro recusandae reiciendis. Id eos ea quis iusto ea quo ullam. Fugit quae culpa nihil quaerat omnis consectetur et.', 872.96, 'Laudantium suscipit ut debitis maxime sed et.', 5, 10, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(418, 'PRD-190KL', 'Natus dolores occaecati', 'Quae commodi maxime sunt error. Ea dolor ut mollitia ut cumque eos velit facilis. Quia porro provident a repellat. Repellendus omnis eligendi error et beatae totam.', 1320.43, 'Dolores omnis delectus est tempore veritatis.', 1, 73, 'uploads/products/product_18_682b52f92d6cd.jpeg', 1),
(419, 'PRD-302XB', 'Quibusdam vel temporibus', 'Voluptatibus est vero laborum. Magni quaerat ipsa quos corporis quibusdam aliquam. Unde id quod velit unde ipsam. Dolores consequuntur et et cupiditate recusandae a velit at. Ipsam corporis et ipsa reprehenderit eum laboriosam. Molestias repellat voluptatem enim odit nobis quisquam esse.', 1323.88, 'Voluptates ut nihil labore eos accusantium.', 3, 38, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(420, 'PRD-224LH', 'Temporibus possimus autem', 'Qui optio vero et nisi. Excepturi porro asperiores harum porro quisquam. Explicabo voluptatem vero officia est cum sint. Minus quaerat molestiae voluptas a at voluptas ut. Iure neque numquam ut sed nobis ipsam.', 807.97, 'Eaque corporis et libero amet voluptates consequatur soluta quis corrupti.', 3, 64, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 1),
(421, 'PRD-689MZ', 'Adipisci autem dolorem', 'Hic atque nihil itaque temporibus saepe. Eveniet temporibus quis dolore. Molestiae id et iusto debitis sint dolores. Suscipit debitis perspiciatis impedit aliquam molestiae sint consequuntur. Placeat facilis laborum odio veniam veniam. Quas voluptatem consequatur eos sed est veniam.', 548.76, 'Ratione aperiam quasi quidem cumque perferendis omnis hic et ut.', 2, 96, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(422, 'PRD-807II', 'Nesciunt corporis qui', 'Possimus alias explicabo doloremque autem dolor quia corporis. Aut dolor est ipsam ut inventore. Nihil illo voluptatibus numquam ut aliquam doloribus nesciunt provident. Et culpa eaque quisquam dolorum.', 891.56, 'Molestiae est corporis et molestiae molestiae velit et necessitatibus excepturi magnam.', 5, 30, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(423, 'PRD-595GR', 'Accusantium ut doloribus', 'Id aliquid ducimus et. Natus eligendi repellat nulla nesciunt fuga qui voluptatem magnam. Praesentium necessitatibus fugit rerum voluptatem non quaerat. Illum rerum cum et. Nostrum officia a inventore dicta dicta. Necessitatibus in voluptatem voluptatem natus aspernatur ea. Qui harum harum et nostrum voluptatibus.', 848.25, 'Mollitia non minima numquam nostrum qui dolores delectus.', 6, 35, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(424, 'PRD-687IW', 'Dolores molestiae consequatur', 'Labore aut optio alias. Nihil est ullam et illo qui. Porro expedita fugiat placeat ut dolorem in similique. Corporis quod rem amet veniam cumque. Odio incidunt aperiam eum praesentium officiis eum consequatur.', 435.84, 'Quos tempore temporibus eos cumque cum accusamus.', 5, 70, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(425, 'PRD-527AO', 'Voluptatem est voluptatibus', 'Molestiae inventore vel voluptatibus explicabo saepe et. Neque natus mollitia qui et molestiae sapiente et. Officiis quae enim ut. Voluptatem consectetur corporis rerum laboriosam.', 1980.15, 'Minus nesciunt sit sapiente quia maiores eaque accusamus numquam.', 4, 21, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(426, 'PRD-582FD', 'Non aperiam minus', 'Provident perferendis quia dolores voluptas repellendus ex aut consequuntur. Pariatur ea placeat omnis et numquam atque. Sed libero dolor illum necessitatibus aut. Est velit impedit architecto eveniet laboriosam dolores architecto. Iure illum consequatur voluptas qui dolor sint quaerat. Odio incidunt quam veniam.', 1485.73, 'Quo similique vel ducimus qui eos ex.', 4, 11, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(427, 'PRD-275ZM', 'Eum earum eum', 'Ea doloremque eos dolor nisi. Nobis quia possimus voluptatibus illum et placeat similique. Hic est est qui vitae aut consequatur. Eligendi praesentium sit cumque veniam provident sint dignissimos labore. Dolor ea quia eaque nostrum repellendus sint explicabo repellendus. Pariatur voluptas et eos.', 1246.62, 'Porro minima eum quibusdam aut aut molestiae.', 4, 90, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(428, 'PRD-902ZB', 'Officia tempora quasi', 'Rem omnis nulla cupiditate iste quod voluptas. Amet odit ducimus sed et nihil earum quia. Sequi nostrum dignissimos ea. Ut quidem nemo maiores ipsum aut dolorem omnis. Dolorum nihil ut velit enim numquam amet eius esse.', 1502.61, 'Rem laudantium minima sint ullam nulla dolorem esse aliquam aut voluptas.', 1, 23, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(429, 'PRD-904AZ', 'Id repellendus excepturi', 'Est et necessitatibus ea voluptate harum magnam. Dolorem officia iure dolor aut est vel. Occaecati enim ut laudantium nesciunt omnis. Dolorum praesentium vel ex est quis voluptatem architecto. Ratione harum rerum aut libero et est.', 606.51, 'Et tenetur culpa iure et eum.', 1, 85, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(430, 'PRD-854ML', 'Sunt est sint', 'Aut debitis explicabo quo autem eos natus. Qui autem ut tempora placeat. Ut ullam facere quaerat tempore. Quam tempore et rerum illo. Omnis neque corporis consequuntur soluta nulla quia ab. Non architecto exercitationem nemo aperiam.', 1116.59, 'Et qui voluptatem et ad nesciunt et reprehenderit quia soluta nisi.', 6, 89, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(431, 'PRD-927KE', 'Qui totam porro', 'Possimus deserunt et omnis iure sapiente modi sunt. Officia doloremque voluptatem repellendus. Possimus doloribus aut quas est deserunt tenetur minus. Facilis dolores enim autem commodi reiciendis.', 1778.07, 'Ipsum voluptas in et quae error vel facere quia rerum voluptas.', 2, 14, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(432, 'PRD-071RT', 'Sunt aliquid et', 'Atque tempora eos quisquam tempora repellendus qui. Totam ut sunt eum sunt non. Nam quia ut aliquid error. Nesciunt eum et quasi qui sint ut. Vel mollitia nostrum error corporis modi ea aut. Quam aut sunt beatae amet molestiae. Qui quae illo voluptatibus corrupti aperiam repellat consequatur.', 1345.29, 'Corrupti magni a sed voluptatibus autem.', 3, 53, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(433, 'PRD-270SD', 'Qui consequatur soluta', 'Accusantium laboriosam consequatur facere iste ut dolorum. Vel et et velit ea vitae. Consequatur quisquam et natus perspiciatis nobis. Nihil accusamus consequuntur est quidem. Quidem occaecati dolorem odio culpa impedit. Maxime magni ex in perspiciatis repellendus.', 467.11, 'Modi asperiores aut dignissimos aliquid delectus autem.', 1, 94, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(434, 'PRD-336VS', 'Qui explicabo aut', 'Molestias et consectetur rerum voluptatum odio non omnis totam. Est dolorem aspernatur et et ut. Iure mollitia nulla sint sed. Labore voluptatem dolor eum modi ea a eum. Quo voluptatum nemo perspiciatis aut aut minima magnam in.', 1341.84, 'Dignissimos enim aliquid sunt sed iure beatae eius mollitia quibusdam delectus.', 6, 10, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(435, 'PRD-580ZO', 'Rerum corrupti et', 'Et voluptas explicabo eum eaque laudantium assumenda ut voluptas. Consequatur non et fugiat aut. Vero tenetur iusto sed nam dolores numquam consequatur quis. Praesentium nemo ducimus magni voluptates fuga vitae nobis.', 848.97, 'Quis delectus culpa nisi inventore commodi est rerum.', 1, 38, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(436, 'PRD-618LA', 'Qui voluptatem cupiditate', 'Asperiores in sapiente non qui quas doloremque. Illum quasi quis ullam aperiam nihil. Rerum soluta natus nostrum. Vel sunt ullam doloribus aliquid neque quae nemo est.', 735.60, 'Non maiores qui id et voluptatum.', 1, 38, 'uploads/products/default.jpg', 2),
(437, 'PRD-493FL', 'Perferendis laborum sed', 'At omnis sint quas dolore sed rerum placeat. Rem et molestias aut tenetur laboriosam reiciendis praesentium. Blanditiis repudiandae ex delectus soluta esse. Error eum voluptas voluptatem aut. Tenetur nam ducimus id. Ratione maxime vel ipsum.', 1635.86, 'Est et quia optio qui nihil libero tempore deleniti.', 5, 13, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(438, 'PRD-925DX', 'Quaerat enim odio', 'Sunt magnam sit dolores similique beatae. Dolor asperiores aliquid aut vel expedita culpa id. Quia dolore aut est voluptatem sit aperiam. Quam eos ad in ipsa numquam. Animi enim et sit sunt est qui voluptatem. Ut quia ipsum eaque et eaque fugiat.', 926.22, 'Est at voluptas pariatur aperiam voluptates consectetur.', 1, 79, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(439, 'PRD-368HA', 'Voluptatem aut id', 'Et quia accusamus atque eum quia molestiae. Eos dolor non necessitatibus ea odit porro temporibus ipsa. Numquam officia quaerat omnis harum. Ipsa quis suscipit ex. Expedita quis laudantium qui minus rerum. Earum minima occaecati voluptates occaecati sequi. Iusto occaecati exercitationem omnis nobis qui atque a.', 1822.30, 'Voluptates consequuntur eius voluptas dignissimos illum sed.', 4, 97, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(440, 'PRD-149BC', 'Ullam odio dicta', 'Libero et maiores tempore voluptas placeat officia. Quam quis ut doloremque non aliquid facilis illum enim. Inventore ducimus enim ut quo et. Officiis dolore culpa enim voluptate fuga. Fugit aut quo deleniti quia. Dolores pariatur officiis incidunt ullam.', 966.59, 'Nesciunt enim dolorem porro et qui est excepturi dolor dolore et.', 5, 93, 'uploads/products/product_5_682b531491006.jpeg', 3),
(441, 'PRD-698ET', 'Aperiam dolores iure', 'Neque enim sed et qui quidem ut alias. Officiis placeat et sit impedit aliquam dolores. Quis culpa aut blanditiis eius. Labore autem mollitia necessitatibus asperiores temporibus et. Cupiditate blanditiis earum quia consequatur quia porro. Aperiam dignissimos inventore excepturi laborum.', 1854.20, 'Quibusdam illum at perferendis quaerat necessitatibus.', 5, 33, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(442, 'PRD-651RD', 'Qui dolorum laudantium', 'Quo ex ut non odio voluptatum. Nulla cumque consequuntur quia aspernatur. Enim excepturi voluptates autem illo. Dicta impedit nihil voluptas. Odit error sed vitae hic cupiditate quos. In ad omnis vel porro dolor officia laudantium. Quidem totam odio earum autem eligendi et eveniet accusamus.', 1167.86, 'Rem sed iusto repudiandae molestiae delectus eligendi ullam in.', 3, 10, 'uploads/products/product_8_682b530d817de.jpeg', 1),
(443, 'PRD-532XM', 'Eligendi enim veniam', 'Ut nihil ipsa velit non dolorem ut incidunt illo. Veniam earum consequuntur beatae repellat. Natus expedita et ut aut iure quisquam adipisci. Ullam ullam praesentium aliquid. Ipsum harum corporis est perspiciatis. Quia facere iure ab maiores esse.', 1604.69, 'Repellendus ex at veniam beatae omnis sequi quo vel laudantium exercitationem.', 1, 22, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 2),
(444, 'PRD-828HU', 'Et tempora ipsa', 'Voluptatem nihil et dolor. Et voluptatem quia assumenda natus. Eius consequatur reiciendis occaecati animi. Omnis ducimus qui qui voluptatibus commodi excepturi distinctio. Quidem reprehenderit rem illo ex velit temporibus dolor placeat.', 632.65, 'In enim est ullam repudiandae at doloribus odit ipsa repellendus.', 2, 46, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(445, 'PRD-506OU', 'Incidunt velit impedit', 'Expedita facere repellat qui fugiat aut velit itaque. Incidunt voluptatem in vitae in blanditiis nihil. Esse soluta expedita deserunt necessitatibus voluptas provident et. Reiciendis aut deleniti quae cupiditate est eligendi. Voluptatem facere ea sunt consequuntur.', 1205.35, 'Exercitationem dicta placeat quod fuga debitis quidem rem quidem autem.', 5, 26, 'uploads/products/default.jpg', 3),
(446, 'PRD-250EG', 'Excepturi voluptatem architecto', 'Placeat illo error hic et officiis amet. Quis molestiae perspiciatis quia voluptas temporibus autem eius est. Corporis nam sequi voluptas id voluptas. Delectus fuga placeat officia quasi quaerat. Corporis aspernatur facere nostrum omnis incidunt id. Magnam sunt esse iure magni possimus quas. Ut est impedit iure.', 1518.02, 'Non voluptas ratione atque autem assumenda perferendis culpa culpa facere sunt.', 3, 73, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(447, 'PRD-635KG', 'Voluptatibus quos corporis', 'Numquam quisquam iusto voluptas numquam quis odio vero. Inventore quae et beatae aperiam sed sunt aliquam sit. Id temporibus dolorum non consectetur architecto quod. Voluptatem voluptatem delectus et quo. Quia consequatur ullam magni nihil.', 1894.32, 'Dignissimos nam sed quia voluptas dicta nulla.', 1, 2, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(448, 'PRD-666QS', 'Illum rem voluptas', 'Id iste molestias in non placeat nulla ex. Modi neque non rem sit dignissimos tenetur. Accusamus sapiente ut id eos voluptatem. Consequatur dicta beatae earum quidem.', 993.86, 'Distinctio eos aut aliquid ipsum illum delectus aut architecto sit incidunt.', 4, 80, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(449, 'PRD-853NH', 'Est officia in', 'Nulla aliquid magni error quia est. Quo ea ducimus eius ratione quo numquam cumque consequatur. Quia repellendus esse adipisci hic et et pariatur velit. Quia excepturi eos est ratione ut. Quos quibusdam corrupti et perspiciatis.', 793.53, 'Consectetur sit illum voluptatem aut eum.', 5, 85, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(450, 'PRD-635RO', 'Sint eaque et', 'Dolores sed autem deserunt dolor ex saepe consequatur quis. Est quia ipsa assumenda in. Sunt quia qui sapiente. Numquam totam vero corporis. Totam aut qui pariatur.', 1946.61, 'Ut quam sed consectetur sit ex saepe velit exercitationem et soluta.', 2, 8, 'uploads/products/default.jpg', 2),
(451, 'PRD-004YR', 'Quia provident ratione', 'Soluta accusantium qui nihil et enim. Praesentium aut facilis voluptatum est explicabo possimus. Voluptate odio saepe quisquam eius odio officiis laborum. Sit laudantium officiis reiciendis reprehenderit incidunt ex. Labore eveniet optio reiciendis ullam. Et laborum dolores quos pariatur ullam sint aliquam. Aut aut aspernatur amet vero.', 467.99, 'At nam odit cupiditate laborum assumenda autem autem.', 3, 85, 'uploads/products/default.jpg', 1),
(452, 'PRD-706ST', 'Dignissimos pariatur culpa', 'Illum neque qui magnam provident. Velit vero enim tenetur fuga officia id odio. Nihil dolorum magnam et est reprehenderit ipsam debitis. Ut voluptatum nam ad enim. Aliquam at cum aut quisquam aspernatur. Reiciendis quos iure harum temporibus.', 672.51, 'Suscipit rerum consequatur modi esse nam ut est.', 4, 32, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(453, 'PRD-478XL', 'Veniam illum cupiditate', 'Quo occaecati alias error iusto. Alias ut vero consequuntur numquam molestiae doloremque. Perspiciatis delectus quidem ut autem dolorem unde aut. Dignissimos sint ut sint dolor soluta et. Aut ipsum voluptas sed assumenda incidunt reprehenderit aut quia. Mollitia earum dignissimos provident iure rerum molestiae est consequuntur. Quia fugit suscipit odit rerum ea similique.', 1175.82, 'Temporibus expedita reiciendis odio perferendis molestiae.', 3, 8, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(454, 'PRD-766FA', 'Assumenda repellat unde', 'Delectus eos sequi tempore. Rerum a quod explicabo quidem. Nesciunt similique odio iusto voluptas iste reprehenderit. Voluptatem nihil et illum natus qui sed. Eveniet ut id aut et earum esse sint accusamus. Adipisci corporis rerum illo accusantium repudiandae alias soluta ex. Consequatur et sit incidunt beatae.', 1506.99, 'Omnis quibusdam et a facere et ducimus quas voluptas assumenda.', 4, 60, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(455, 'PRD-396JH', 'Rerum iste et', 'Nam et voluptatem et. Consequatur quod placeat praesentium vero doloribus qui. Alias distinctio dolorem aut beatae. Placeat ipsam est tenetur mollitia. Quibusdam ducimus facilis iure voluptas est.', 1476.33, 'Nesciunt velit provident omnis vel inventore.', 4, 5, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(456, 'PRD-908BL', 'Reiciendis laborum dolorem', 'Laudantium sed et et est dolorum labore. Consequatur voluptate molestiae ipsum voluptas quia id unde. Facilis quis qui nobis debitis voluptatem dicta laboriosam. Fugiat inventore non inventore voluptates atque. Consequatur dignissimos fugit non aspernatur voluptate. Architecto et repellat molestias et eligendi sit et.', 399.24, 'Explicabo consequatur rerum deleniti qui voluptas voluptatem ea.', 6, 87, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(457, 'PRD-733UU', 'Explicabo molestias quis', 'Possimus ut suscipit modi quaerat doloribus ipsam laudantium. Commodi aut saepe debitis distinctio quam. Dolore delectus nostrum sed qui accusantium repellendus a eligendi. Necessitatibus possimus minus quod quis sint quia. Dolorem quas et velit aperiam occaecati.', 709.48, 'Magni vitae ut quibusdam aut ut nobis sit recusandae blanditiis cupiditate.', 2, 26, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(458, 'PRD-905KN', 'Fuga dicta dolor', 'Mollitia porro similique distinctio voluptate ut accusantium reprehenderit. Dignissimos veritatis beatae voluptatem quis omnis dolore nulla. Totam officia perspiciatis eum explicabo magni minima. Temporibus quam id quaerat qui amet. Sit voluptatibus aperiam tenetur minima autem autem deserunt. Consequatur perferendis fugit eveniet. Porro error ab vitae voluptas labore rerum.', 827.64, 'Quod expedita quaerat reiciendis officia et quis ducimus maiores ad et.', 6, 70, 'uploads/products/product_5_682b531491006.jpeg', 2),
(459, 'PRD-734NB', 'Reiciendis officiis voluptates', 'Excepturi quae sed eveniet in quasi. Fugit quo omnis reiciendis quos deserunt. Earum eos sunt maxime est et dolorem. Recusandae et quia accusantium ex. Esse officia veniam ratione. Est explicabo aut odit animi occaecati eos. Quibusdam eligendi nostrum perspiciatis placeat voluptas dolorem.', 1525.91, 'Qui asperiores quae possimus qui laborum.', 2, 35, 'uploads/products/product_8_682b530d817de.jpeg', 2),
(460, 'PRD-430XP', 'Veniam consequatur dolor', 'Unde veritatis quaerat sit necessitatibus sed. Corporis et maxime eos. Blanditiis eveniet officiis qui a. Quia ipsam vero aut qui illum. A possimus asperiores soluta et. Asperiores cupiditate vitae quam omnis reiciendis vel. Consequuntur ipsa molestiae eum nam esse.', 1489.26, 'Voluptatem nostrum velit atque accusamus qui.', 3, 83, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(461, 'PRD-945RM', 'Dolores minima ullam', 'Magni et magnam sed quia non. Et culpa repellat laudantium ut perferendis et. Nulla non accusantium illum. Dolores provident ad accusamus. Voluptatem maxime error est ipsum. Quisquam autem quia placeat voluptas beatae asperiores.', 707.43, 'Voluptatem minus eius ad dolores ad aut et et.', 5, 68, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(462, 'PRD-783MG', 'Impedit sint perferendis', 'Necessitatibus ad eum adipisci dolore sint. Dolor officia possimus illum officia. Minus aperiam tenetur sequi autem quos et. Delectus totam ducimus sequi rerum. Qui optio aliquid quibusdam tempora dolores placeat officiis. Perspiciatis nisi asperiores ut eligendi.', 575.78, 'Nulla nihil doloribus placeat quia sunt nisi voluptatem tempore inventore.', 4, 75, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(463, 'PRD-935LO', 'Dolor dolorum et', 'Explicabo reprehenderit iusto quas nesciunt et quidem dolore nesciunt. Saepe et rerum laboriosam delectus magnam facilis ut. Omnis libero magnam ratione rerum aut. Aut velit vitae perspiciatis repellat. Facilis est mollitia facilis voluptas distinctio nostrum.', 1497.78, 'Quod placeat et ratione rerum quidem sit nostrum dolor.', 2, 72, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(464, 'PRD-887NQ', 'Expedita ut corrupti', 'Ipsam est voluptatem occaecati placeat cum. Iusto qui non omnis qui est laborum. Reprehenderit reiciendis modi adipisci dolorem dolorum autem ipsum. Error ex nulla exercitationem voluptate. Qui quo rerum ut soluta voluptates unde dolorum. Eius ipsum eligendi voluptas est id. Esse laudantium maiores praesentium atque quo incidunt et a.', 1669.82, 'Odit placeat ut a repellat quia est voluptas molestias corporis.', 3, 45, 'uploads/products/default.jpg', 2),
(465, 'PRD-780CU', 'Eaque magnam quidem', 'Accusamus alias quos temporibus nihil architecto. Repudiandae velit expedita quis qui. Voluptate voluptatem quos non amet aut dolor. Repudiandae ad nobis qui sed. Quibusdam qui vitae rem animi molestias ab.', 287.67, 'Autem vel et amet labore.', 6, 50, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(466, 'PRD-064UR', 'Quam quae aut', 'Et dignissimos rerum beatae. Expedita et asperiores nihil vel ab maiores magnam. Iure aperiam ut aut in ducimus assumenda. Sint voluptatem vel voluptas odit eaque. Iure blanditiis hic sint hic possimus aut eveniet.', 79.75, 'Nam eius optio nihil sunt occaecati voluptas recusandae rem eveniet.', 6, 30, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(467, 'PRD-813RZ', 'Corrupti repellat sit', 'Dolor atque amet ut temporibus dolores nulla. Aliquam adipisci repellendus quia temporibus. Earum quos voluptas dolor et. Enim eius ipsam doloremque. Est est voluptatem reiciendis qui quae assumenda. Quidem repellat tempore ex consequatur rem minus ut. Et aliquid aliquid exercitationem molestias maxime.', 408.62, 'Quas vel itaque atque aut accusamus sed neque debitis nobis magnam.', 3, 82, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(468, 'PRD-892QW', 'Deserunt nam magni', 'Facere praesentium consequatur quibusdam corporis qui doloribus quia unde. Voluptatem doloremque voluptas distinctio eum. Est ut aut enim aut facilis dolorem. Alias magnam dolores laudantium maxime voluptas consequatur voluptatem. Praesentium eius amet accusamus aperiam maxime.', 1524.34, 'Voluptas totam a voluptatem dolores nesciunt sit libero.', 1, 97, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(469, 'PRD-475IW', 'Repudiandae quam in', 'Non optio repudiandae aut suscipit aut. Necessitatibus consequuntur occaecati ipsa debitis. Et porro tempora adipisci magni vel. Non perferendis eaque quia et dolorum nam ipsam ad. Modi vitae perferendis occaecati temporibus sed non recusandae. Sapiente dignissimos qui qui earum et laudantium tempore. Nobis officiis aliquam numquam sed vel.', 1566.43, 'Qui dicta aperiam rem labore ratione repellendus fuga cum.', 4, 51, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(470, 'PRD-053HS', 'Dolorum cupiditate nemo', 'Et nam debitis provident commodi quasi quos. Quo in id ut voluptates. Rerum dignissimos ratione possimus assumenda. Ipsum atque tempora doloremque architecto. Eligendi esse est voluptatem consequatur. Facilis atque quia adipisci iusto.', 1155.32, 'Fugiat at praesentium iusto temporibus minima maiores incidunt vel id.', 3, 12, 'uploads/products/product_2_682b52dacbb5a.jpeg', 1),
(471, 'PRD-343BF', 'Et et nam', 'Sequi dolore tempore minus commodi aut a ut. Eligendi repellat itaque commodi dolorem qui perspiciatis earum sapiente. Sint adipisci et velit repudiandae corrupti. Omnis quasi voluptas suscipit possimus reiciendis voluptas ut. Tempora aut excepturi at voluptas. Officia et non dolor explicabo autem.', 73.58, 'Excepturi veniam voluptate in itaque necessitatibus fuga fugiat quibusdam.', 1, 58, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(472, 'PRD-608JI', 'Ipsam nisi unde', 'Perspiciatis vel unde necessitatibus non sed quidem consequatur. Aut autem laborum ut minima quod consequatur. Et qui recusandae nostrum nihil. Vero assumenda dicta sint modi.', 959.70, 'Iusto sint voluptatem porro quos qui beatae perspiciatis itaque.', 4, 95, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(473, 'PRD-927EU', 'Ut sapiente voluptatem', 'Aut quis nulla odio aut qui. Odit dolores quo et minima repudiandae vel. Aut quasi unde quia molestias id cumque. Explicabo aut aliquam quis et est. Sit laudantium consequatur minus praesentium perferendis est sequi. Quidem soluta tempore qui temporibus.', 58.61, 'Consequatur vel eum alias numquam expedita voluptatem ut.', 6, 92, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(474, 'PRD-135EN', 'Officia voluptatem et', 'Impedit suscipit id enim et error laborum ducimus. Dolorem dolore eum minus aspernatur aut non quia et. Dolor praesentium asperiores eligendi est ullam minima earum cupiditate. Sequi corporis rerum aut. Distinctio blanditiis dolores provident fugiat magnam. Laboriosam eaque qui est odit. Quo possimus eveniet iusto.', 1645.45, 'Alias soluta natus hic dolores et dolorum incidunt.', 3, 46, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(475, 'PRD-976KX', 'Quia accusamus accusamus', 'Debitis rerum aut commodi eligendi porro itaque. Sit et ab laboriosam perspiciatis sed. Accusamus placeat laboriosam et quod modi fugiat eius. Sequi nostrum cumque doloribus voluptatum est quo voluptatem voluptatum. Possimus sed culpa similique itaque sit et aut. Et nulla quam error voluptatum perspiciatis sed ex culpa.', 1684.94, 'Molestias quia vel unde atque nihil ab soluta.', 2, 39, 'uploads/products/product_9_682b53079cbf5.jpeg', 3),
(476, 'PRD-498RA', 'Officia omnis aut', 'Perferendis fugit natus natus itaque labore. Aliquid ut explicabo voluptatem quasi minus minus. Est aliquam accusantium ducimus sed. Suscipit omnis rerum officiis qui. Repellendus ut et aut optio. Eveniet perspiciatis autem aut eos ratione voluptatibus ut.', 777.53, 'Nostrum est consectetur reiciendis ipsam quam.', 3, 89, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(477, 'PRD-834XZ', 'At exercitationem velit', 'Repudiandae facilis est occaecati quas. Atque nulla sed neque dolor ut provident fugit. Doloremque vel eligendi tempore sequi dolor sunt architecto. Saepe debitis odit voluptas ut. Tempore iure ut voluptas hic vero. Esse ex est harum fuga.', 1562.22, 'Qui quod error delectus illo facilis sit saepe dolores.', 3, 70, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(478, 'PRD-591PD', 'Sed optio cumque', 'Aut est modi voluptas distinctio. Ad voluptatibus facilis rerum ea rerum velit. Tenetur autem recusandae rem omnis ratione explicabo aut. In dolorem illo rerum qui nihil vel rerum.', 1303.40, 'Mollitia in fugiat sit soluta quia molestiae sunt voluptatum in.', 1, 13, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(479, 'PRD-828WI', 'Eum dicta vero', 'Earum maxime porro aut voluptatibus sunt dolores. Quia officiis quo id qui. Et impedit ullam aperiam ut in. Vero doloribus quae voluptas sint molestiae. Magnam aspernatur in veniam cumque.', 1738.41, 'Officia sequi rerum eius quis vel mollitia distinctio et.', 6, 8, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(480, 'PRD-686FA', 'Quae fugit deleniti', 'Consequatur porro dignissimos et quis rerum harum itaque in. Alias quos amet autem incidunt et quo ut. Eum sunt et animi sit earum ea officia. Voluptatem qui error suscipit natus.', 1416.59, 'Consequatur totam dolore voluptas quo libero.', 2, 82, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(481, 'PRD-304OD', 'Recusandae magnam voluptatem', 'Quis ut qui asperiores et sit et suscipit. Totam magni velit delectus neque. Quidem qui animi aut maiores doloribus soluta. Quia animi cupiditate dicta. Sunt minus est est non qui.', 1609.18, 'Facere dolores et labore delectus animi qui at.', 6, 12, 'uploads/products/product_13_682b52bc21a0d.jpeg', 3),
(482, 'PRD-586IS', 'Rerum vitae itaque', 'Quaerat et consequatur iure labore. Vero corporis corrupti quaerat nobis et quod consequuntur nihil. Beatae sunt expedita enim voluptas consequatur voluptatem. Possimus expedita rerum magni quasi consequatur. Sed qui voluptatem qui optio in amet in voluptate.', 1972.43, 'Eum porro repudiandae dolores laudantium at.', 5, 65, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(483, 'PRD-768RC', 'Et provident occaecati', 'Cum explicabo occaecati aut est. Animi quia nihil sapiente aliquam. Aperiam ipsa quod beatae ipsam. Accusamus cupiditate voluptate fugit sed quae. Excepturi veniam optio fuga recusandae soluta ut perspiciatis aspernatur. Eaque quis voluptate sed in maiores enim molestias. Ut explicabo numquam sed temporibus.', 404.86, 'Ullam sit recusandae omnis ut velit dicta aperiam dolor.', 5, 91, 'uploads/products/product_9_682b53079cbf5.jpeg', 3),
(484, 'PRD-264WJ', 'Autem vitae et', 'Repudiandae qui ab ducimus et quia. Beatae quod ipsa tempora vitae rem quia. Aut vero qui fuga. Quasi non aut culpa perspiciatis et rerum illo. Temporibus accusantium cum est aperiam quo. Iusto occaecati cumque consequatur voluptas reprehenderit qui. Voluptatibus magnam aliquam corrupti ipsa.', 474.22, 'Laboriosam sit dolores asperiores non qui tempora sunt illo aliquam.', 5, 33, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(485, 'PRD-308MS', 'Ab vel itaque', 'Voluptatum reprehenderit autem vel aut. Iste ut qui dolorem quam qui. Velit illum ratione sit quis nulla voluptatibus. Inventore velit voluptatem ut fuga accusamus.', 533.42, 'Dolore unde omnis ex et fugit sint minima non quod cum.', 5, 90, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(486, 'PRD-907HL', 'Laborum voluptatem sit', 'Dolor quidem et quas nulla rerum. Et deleniti consequatur harum dolorem. Ullam vel laborum aliquam nobis. Eos numquam ut sed in. Voluptatibus aut ad minus. Dolores nesciunt sequi officiis consequatur. Dolorum ut cupiditate saepe suscipit.', 981.27, 'Ipsa dolorum ut qui in temporibus.', 1, 90, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(487, 'PRD-934KV', 'Consequuntur minima sunt', 'Non magni deleniti eius omnis rerum molestiae deserunt et. Doloremque voluptatem id dolor quibusdam. Ut molestiae odio sed odit et. Accusantium aliquid dolor nihil amet aut.', 770.11, 'Totam rerum nulla hic velit magni sit qui.', 6, 54, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(488, 'PRD-052SP', 'Consectetur quo vitae', 'Error nihil et modi autem est. Vitae cumque quaerat autem et. Illum nesciunt assumenda voluptas non culpa ut. Numquam harum quo in rerum earum officiis cumque. Et qui qui eius ipsum. Eligendi quam facere repudiandae quia voluptas. Officiis quidem hic consectetur ea voluptates sunt et.', 588.20, 'Eum et rerum omnis dolore omnis fuga et qui alias.', 2, 70, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(489, 'PRD-188JT', 'Blanditiis ut maxime', 'Maxime dolores velit nihil aut esse ipsum quis. Sequi repellendus optio natus aut. Eum et non eum sed iusto. Ut reiciendis et non dolorem voluptas eum. Unde ducimus voluptas dicta at molestiae porro.', 453.89, 'Molestias eligendi ad rerum asperiores est.', 2, 36, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(490, 'PRD-091EB', 'Et voluptatem odio', 'Sapiente illum eum ipsa praesentium atque. Ut distinctio iusto perferendis doloremque pariatur omnis adipisci. Corporis est beatae fugiat at hic quo. Odio recusandae quam id sit.', 1802.57, 'Est qui voluptates sit velit magnam.', 4, 80, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(491, 'PRD-024DY', 'Omnis soluta eum', 'Doloribus ut neque molestiae et. Sed soluta quos itaque in velit. Reiciendis officiis corrupti omnis provident facilis sed aliquid. Sint tempora similique ullam ut. Quasi laudantium ut quo iste et cumque. Nobis voluptatem ad adipisci dolor. Soluta dolores aut illo illo et eum.', 1003.11, 'Magnam nisi temporibus et ut in maxime et veniam.', 6, 20, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(492, 'PRD-348AS', 'Error facere voluptatem', 'Magnam et repudiandae vero iusto laborum cupiditate. In fuga et corrupti architecto ducimus dolorem nulla. Ipsum repudiandae recusandae et nulla. Eum rerum ut et et. Minima ut iure ut vero voluptas quibusdam. Dolorem quia corrupti harum.', 859.18, 'In modi ut commodi libero dolorem ipsum qui non qui iste.', 3, 35, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(493, 'PRD-428QY', 'Asperiores impedit rerum', 'Perferendis et et tempore quia aliquid quibusdam et voluptas. Tempore qui esse odit minima. Inventore hic rem sit necessitatibus sit. Veniam numquam ut asperiores pariatur quas.', 645.87, 'Sit quas exercitationem officiis voluptas temporibus est odio minus cupiditate.', 6, 52, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(494, 'PRD-004GM', 'Quis repudiandae aut', 'Voluptates ipsa et eveniet officiis iste. Aspernatur asperiores consequatur illum sed. Quos qui architecto et. Aut nam culpa rerum rerum quia ipsum qui.', 643.44, 'Alias eaque nesciunt quis nisi harum non delectus fugit voluptatibus.', 3, 16, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(495, 'PRD-200LW', 'Qui praesentium ratione', 'Facere dolor et debitis placeat. Minus iure non distinctio magni veniam nulla. Similique occaecati harum eum deserunt. Aut ipsa aut animi nihil repudiandae accusamus. Et sit animi voluptatum sit sint. Voluptas necessitatibus dolor vel pariatur aut.', 1804.88, 'Expedita temporibus qui ipsa occaecati consequuntur est in.', 4, 56, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(496, 'PRD-711YX', 'Enim placeat illo', 'Omnis earum quae aut qui quis atque. Quos dicta consequatur est velit magni. Et autem provident velit nulla dolore aut voluptate ea. Hic sint soluta et. Et minima aut officia dicta magni non et.', 510.04, 'Inventore eos debitis cupiditate temporibus et porro ipsa ipsum saepe.', 5, 33, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(497, 'PRD-670HV', 'Placeat doloremque totam', 'Porro dicta quo et quia iure et. Rerum non aut harum nesciunt non. Est nisi occaecati beatae commodi mollitia quam dolorum. Reprehenderit corporis nobis quia dolor enim.', 790.38, 'Cupiditate nihil eos non molestiae saepe natus sed fugit et error rerum.', 3, 36, 'uploads/products/product_12_682b52e8c33a0.jpeg', 2),
(498, 'PRD-275GB', 'Veritatis tenetur consequuntur', 'Et pariatur dolores perspiciatis excepturi et laudantium sunt. Aut quisquam soluta velit necessitatibus accusamus quis id. Reprehenderit quidem quibusdam quibusdam. Non eos saepe magnam inventore neque vel nobis. Quo fugiat nisi et magnam amet.', 1662.53, 'In sequi ullam dolores recusandae at.', 5, 36, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(499, 'PRD-885FS', 'Qui repellendus sit', 'Enim id veniam cumque magni et nulla omnis. Corporis a qui rerum quia totam illum exercitationem. Labore omnis autem neque non est provident fugit voluptatem. Tempora quia hic nobis perspiciatis praesentium quo enim. Molestiae voluptatem ut cupiditate.', 259.11, 'Sit alias accusamus ipsa quos explicabo quisquam alias ex nisi.', 4, 63, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(500, 'PRD-471MB', 'Molestiae accusamus exercitationem', 'Veritatis possimus atque assumenda enim dolorum doloremque. Ex non est voluptatem est adipisci. Itaque dolore in optio facilis. Sed in tenetur id eligendi unde ea. Alias velit consequatur odit labore.', 1632.60, 'Qui voluptatibus et dolorum eius sequi consequatur id sint et.', 6, 6, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(501, 'PRD-069EO', 'Cumque dolorem nobis', 'Non doloribus ea harum omnis animi maiores optio. Similique quia quod quia tempora rerum deleniti quis. Reprehenderit nostrum qui molestiae recusandae suscipit facilis. Vel ea dolore optio quasi laudantium culpa quibusdam. Consequatur praesentium quis neque cumque.', 1819.04, 'Totam aut rerum rerum omnis ut ex sed delectus perferendis.', 2, 62, 'uploads/products/product_12_682b52e8c33a0.jpeg', 1),
(502, 'PRD-257XB', 'Omnis eos quasi', 'Est id ea consectetur dolores. Deleniti rerum ex suscipit distinctio placeat vero. Necessitatibus perferendis et dignissimos. Sed est aut hic rerum. Aut autem enim ut sed rerum in. Ea optio animi nostrum facilis deserunt modi.', 294.63, 'Enim debitis eius cumque non et hic architecto dolore id nobis.', 6, 94, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(503, 'PRD-587GA', 'Et id iste', 'Non laudantium ab qui accusantium perspiciatis non. Ullam necessitatibus itaque id ab saepe dolor. Dignissimos illum aut repellendus. Aliquid illo quam et laboriosam velit.', 291.54, 'Deleniti iusto inventore dolores repudiandae sequi cupiditate ex veritatis est quia.', 3, 61, 'uploads/products/product_6_682b52f23e66d.jpeg', 2),
(504, 'PRD-336AJ', 'Autem est sit', 'Non nostrum fugit quidem repellendus qui nisi corporis. Maxime at beatae rerum. Aperiam consequuntur illo ipsa aperiam. Sit nesciunt sunt ea quia eius quam.', 1549.89, 'Quibusdam minus et eos ut sed laudantium sit et qui.', 6, 87, 'uploads/products/product_5_682b531491006.jpeg', 2);
INSERT INTO `proizvod` (`Proizvod_ID`, `sifra`, `Naziv`, `Opis`, `Cijena`, `KratkiOpis`, `kategorija`, `StanjeNaSkladistu`, `Slika`, `tip_id`) VALUES
(505, 'PRD-544HT', 'Ut est et', 'Est optio eos omnis sapiente accusamus repellat assumenda. Sed et at enim et quibusdam natus sed. Dolorem aliquid pariatur a eos modi pariatur dolorem ipsum. Quo sed ut illum maxime molestiae dignissimos iste. Perspiciatis tempore voluptas non aspernatur. Quaerat voluptatem nihil voluptas rerum possimus magni magnam.', 780.72, 'Dolor adipisci magni vitae quia quas autem nam consequuntur odio excepturi aspernatur.', 6, 84, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(506, 'PRD-085JJ', 'Officia qui qui', 'Ex nobis est cupiditate error. Earum in debitis ullam ad libero at nostrum. Voluptas provident quo quod nesciunt ut. Dolore molestiae incidunt id numquam dolorum. Aperiam nam voluptatem dolor facere optio. Assumenda ut ad ipsa.', 551.34, 'In quidem nobis perspiciatis quidem laboriosam recusandae dolorem.', 4, 99, 'uploads/products/product_10_67e2fa07645fe.jpg', 3),
(507, 'PRD-698BL', 'Aut consectetur provident', 'Ab accusamus exercitationem laborum ex. Accusamus voluptatem excepturi et qui deleniti reiciendis odit. Expedita odit alias nihil repellat cupiditate quo nemo. Vero beatae animi quasi nostrum. Sed inventore et eveniet quisquam. Nihil velit aut nostrum.', 1545.58, 'Ducimus accusantium dolorem rerum odio qui nihil cumque nihil labore.', 6, 23, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(508, 'PRD-306AE', 'Et molestiae velit', 'Vel ipsum facere velit. Autem quibusdam perspiciatis nihil nisi. Quo quisquam delectus natus. Amet cum hic facilis. Quisquam voluptatem omnis dolorem et.', 298.73, 'Impedit sed voluptas minus similique architecto voluptatem minus dolor delectus deserunt.', 6, 99, 'uploads/products/product_14_682b52b3204d2.jpeg', 3),
(509, 'PRD-196KI', 'Odit repellendus voluptatem', 'Est animi illo perferendis earum officiis. Autem sed occaecati nisi beatae voluptatum qui iusto aut. Omnis consectetur animi neque facere qui. Temporibus assumenda repellendus laborum. Nulla minima fugiat corporis cum. Cum quibusdam repellat et sunt. Est quidem maxime architecto earum dolor nihil et.', 880.35, 'Voluptatem hic rerum minima vero.', 2, 45, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(510, 'PRD-255XN', 'Vel ratione vitae', 'Rerum accusantium quo nobis atque enim consequatur. Modi quaerat sapiente fuga. Sit quia similique fugit sint. Harum placeat itaque necessitatibus aut consequatur reprehenderit expedita. Sit qui voluptatem quia quis officia et vitae.', 1989.91, 'Et placeat a illo et id consequuntur at et placeat ipsum.', 2, 95, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(511, 'PRD-428ZU', 'Vitae dolores sit', 'Veritatis incidunt aut esse architecto. Voluptas et nulla nisi. Et molestiae harum aut et quo eos. Quae totam illo recusandae soluta aut qui vitae.', 623.49, 'Reiciendis necessitatibus nobis ratione est placeat velit.', 4, 85, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(512, 'PRD-121MV', 'Distinctio quam soluta', 'Quis tempora autem explicabo deserunt repellendus asperiores. Et perspiciatis aliquid inventore qui perspiciatis. Suscipit quidem quia autem ratione exercitationem. Consectetur voluptatem ab esse.', 36.13, 'Doloremque quis natus quas quae est dolor labore neque laborum.', 4, 28, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(513, 'PRD-244LV', 'Ut itaque minus', 'Voluptatem dolore porro perspiciatis neque totam nulla commodi dolorem. Tenetur modi itaque ut fuga ipsa omnis. Maxime dignissimos veniam error molestiae aut ex sit perferendis. Veniam quo non enim voluptates ut.', 1882.54, 'Asperiores et quis consequuntur similique ut fuga ea.', 4, 83, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(514, 'PRD-535RH', 'Minus non omnis', 'In sed possimus praesentium. Dolores dolorum et aut optio dignissimos. Quae aperiam minus soluta saepe qui id. Velit molestiae minus consequatur itaque. Quo est qui vitae totam.', 664.47, 'Dicta amet aliquid non sit asperiores.', 2, 26, 'uploads/products/product_15_682b52ff60908.jpeg', 2),
(515, 'PRD-875MZ', 'Et eos animi', 'Optio necessitatibus officiis debitis est quisquam amet ea. Tempore omnis voluptas consequatur harum qui commodi tempore. Soluta et quae hic ad ea. Facere qui dignissimos ut fuga. Numquam vero et vel beatae iure eum molestias.', 1282.85, 'Sed temporibus voluptatem architecto fugit earum perspiciatis et.', 4, 4, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(516, 'PRD-595QK', 'Consequuntur quam quis', 'Voluptatem sit et facere blanditiis. Expedita aperiam quas non ad quos ut molestias. Ea quibusdam beatae provident quia temporibus quam repudiandae. Aut dolorum fuga quia ipsa dolores esse quidem inventore. Eveniet quae iure soluta officia magnam ut.', 961.01, 'Asperiores nesciunt doloremque deleniti cupiditate dolores quia iure ad.', 6, 49, 'uploads/products/product_5_682b531491006.jpeg', 1),
(517, 'PRD-526VT', 'Odio quam iusto', 'Dignissimos dolor tempora consequatur et ducimus. Tempore laboriosam non aspernatur et officia et sed accusantium. Quisquam laudantium commodi qui fugit non quis. Voluptas dolorem sint nulla voluptate provident. Sit dolores inventore incidunt praesentium magnam.', 1291.31, 'Dolorum quia aliquam dignissimos ut nisi.', 4, 27, 'uploads/products/product_9_682b53079cbf5.jpeg', 2),
(518, 'PRD-511AO', 'Consequatur qui rerum', 'Provident nam dolorem facere. Cum laudantium consequatur reprehenderit quasi. Repellendus nulla et odio qui adipisci qui laudantium. Libero quam pariatur dolore fugiat perspiciatis perferendis repellat in. Earum corrupti quis fuga exercitationem ratione ut. Quod consequatur sunt perspiciatis consectetur. Quis est occaecati distinctio qui et.', 360.56, 'Similique eligendi sed aut necessitatibus reprehenderit libero voluptatem laborum velit mollitia.', 6, 67, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(519, 'PRD-306YB', 'Exercitationem ab autem', 'Recusandae sed similique ab est. Itaque ut quaerat vero at quisquam aut. Est eligendi reiciendis deserunt nulla eos fuga. Qui a recusandae omnis assumenda. Id asperiores laboriosam id qui modi voluptatem recusandae. Cum eius rerum suscipit aut placeat. Et nihil est et veritatis non qui qui.', 990.24, 'Facilis aut qui ullam repudiandae ratione et.', 4, 21, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(520, 'PRD-050VH', 'Minus repellendus rerum', 'Vel eum labore aut quidem ut. Est accusamus voluptas facilis necessitatibus et ut odit. Suscipit eaque odit rerum quia. Reiciendis tenetur nemo est quis voluptatum est voluptatem. Sit odit sit qui quia quis sed.', 1348.96, 'Voluptatem rerum repudiandae aut qui vitae perspiciatis molestiae maxime.', 4, 100, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(521, 'PRD-108EG', 'Doloremque debitis nisi', 'Incidunt voluptatem hic ipsam dolores fugiat. Voluptatibus dignissimos impedit autem et ab velit. Accusamus et temporibus dolore. Vel iure et commodi alias nemo consequatur sunt. Pariatur eum hic dolores. Sunt qui optio repudiandae vel minima.', 847.00, 'Ea est dignissimos deserunt repudiandae vero quia ut doloremque.', 3, 4, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(522, 'PRD-800PG', 'Maiores praesentium quo', 'Sequi rerum et cum consequatur dolorem minus quibusdam. Est assumenda ratione saepe odio nihil vel molestiae. Adipisci excepturi non veritatis perferendis. Quis velit asperiores et. Tenetur nulla voluptatem et expedita quisquam cum. Error et veritatis a qui a. Veritatis necessitatibus labore id ea soluta.', 962.53, 'Sapiente numquam magni distinctio qui neque rerum corporis consequatur explicabo culpa.', 2, 77, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(523, 'PRD-024LZ', 'Qui eos sit', 'Quod quia ad incidunt nam sed iure. Voluptatem nisi sequi voluptatem nemo. Nostrum nemo amet et dolor illo. Cumque provident vel corporis. Vel aut illo quas deleniti saepe molestias. Et sunt similique ut. Eos consequuntur ab excepturi et ut.', 1438.38, 'Sed ipsum odio possimus optio.', 5, 86, 'uploads/products/product_3_682b52d24e5ab.jpeg', 2),
(524, 'PRD-003RT', 'Qui quod est', 'Quidem sint quas architecto aut fugit pariatur eius libero. Mollitia vel placeat harum quaerat nam occaecati sit dicta. Dolorem quis animi magni omnis aut placeat ex. Voluptatibus iste numquam pariatur commodi.', 829.81, 'Et blanditiis laudantium sunt praesentium at vel repellat accusamus dolorem quas.', 4, 36, 'uploads/products/product_28_67f4d50690e1d.jpg', 3),
(525, 'PRD-769OB', 'Corrupti omnis aspernatur', 'Consectetur nihil ipsam dolore. Est rerum debitis et molestiae dolore necessitatibus totam ut. Libero vitae sed qui quia delectus. In eaque quae sunt quis corrupti vel. Dolorum reprehenderit ratione rem sunt rem ea recusandae voluptatibus. Iste debitis neque repudiandae et veniam consequuntur molestiae.', 1147.93, 'Ea voluptates doloribus provident placeat aut aut deleniti reprehenderit fugiat.', 5, 86, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(526, 'PRD-136DE', 'Non velit aliquam', 'Vitae quas quaerat eaque et. Eveniet dolor dicta officia perspiciatis voluptates. Aperiam sed animi et laudantium in velit. Illo sit possimus quos modi sequi necessitatibus. Aperiam maiores neque architecto fugit ducimus repellat. Harum eum dolor fugit quae ut quia non. Repudiandae hic quod animi.', 572.97, 'Voluptate nostrum sunt ullam rerum pariatur.', 5, 2, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(527, 'PRD-724OW', 'Autem quibusdam aut', 'Earum eveniet cum laboriosam illo. Officia est aut eos consequatur voluptatem ut. Maiores rerum rerum est nobis ex ratione enim. Enim ipsam dolores nisi expedita voluptatem rem dolore tempora.', 1368.13, 'Vel sint quam officiis fugiat nemo aliquam quo nostrum minima.', 3, 77, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(528, 'PRD-813DM', 'Totam dolor tempora', 'Quis qui sint laborum quisquam. Et cumque provident non ex voluptatem amet magni. Quas quia modi aut eum itaque labore beatae aliquid. Veniam inventore repellendus possimus at. Id ut iusto explicabo accusantium laborum. Voluptatem neque quo necessitatibus laboriosam sed totam. Id sint cum soluta.', 706.75, 'Sed voluptate eos omnis quos dicta nulla aut eaque.', 3, 90, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(529, 'PRD-940CY', 'Repellat tempora blanditiis', 'Ea repellat consequatur ratione aut excepturi esse libero. Doloremque nemo recusandae eum explicabo. Vel et quia et doloremque facere corporis. Quas sit tempora molestiae. Et architecto eum culpa quaerat. Qui velit quo eum.', 393.16, 'Dicta odit culpa vel saepe earum consequatur numquam quam qui.', 4, 71, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(530, 'PRD-323OY', 'Et culpa recusandae', 'Repudiandae exercitationem quasi sit repellendus. Et quia doloremque voluptatem architecto molestiae. Numquam omnis dignissimos officia dicta illum inventore eum. Perferendis dolores magni recusandae eaque doloremque incidunt quos. Iusto adipisci maxime reprehenderit vel. Vel repellendus dolor modi aliquid voluptate quos.', 833.98, 'Doloremque numquam facilis est nulla voluptates.', 4, 9, 'uploads/products/default.jpg', 3),
(531, 'PRD-282RJ', 'Vitae deleniti laudantium', 'Minima odit mollitia et autem quo quibusdam vel. Optio eligendi deserunt qui numquam architecto nam. Tempora et ipsam consequatur omnis magni nihil voluptatibus non. Quod laboriosam eaque necessitatibus explicabo quia iste. Modi dignissimos id omnis. Accusamus hic omnis voluptas aut reiciendis vitae. Quidem dolores aut deserunt sint et aperiam.', 1310.65, 'Ea illum debitis earum quos facilis quisquam assumenda vitae.', 5, 1, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(532, 'PRD-166FX', 'Aut distinctio mollitia', 'Nulla eius aut et sapiente. Tempora delectus repudiandae dicta non aut similique rerum. Enim qui suscipit recusandae quia. Ut est et labore aut ipsa. Eos tenetur animi consequatur dicta et delectus nisi expedita. Sed sed non reiciendis dolorum consectetur ut sed. Porro in quia iure sed laboriosam ea sit.', 1758.48, 'Atque totam sint qui odio vitae ex et voluptatibus qui.', 4, 7, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(533, 'PRD-379QK', 'Aperiam id quisquam', 'Est in expedita nam ut autem unde saepe quaerat. Quo molestiae veritatis praesentium facilis debitis. Temporibus explicabo quaerat occaecati est a. Quia corrupti culpa atque qui. Magnam assumenda perferendis modi voluptatem qui repellendus.', 637.56, 'Et sed velit corporis ea qui.', 1, 81, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(534, 'PRD-635YH', 'Laboriosam corporis tempora', 'Rerum quia placeat repellat quis fugiat consequuntur repellat provident. Consequatur aut maxime laudantium amet totam minima. Labore quaerat qui pariatur odit dicta voluptas quia. Enim consequatur velit necessitatibus et sit dolorem ut. Voluptas beatae sed explicabo odio commodi accusamus aspernatur. Quia sed ex rerum.', 1815.78, 'Rem quo corrupti itaque saepe aut corrupti.', 3, 75, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(535, 'PRD-462VO', 'Repudiandae temporibus impedit', 'Corrupti omnis esse et doloremque dignissimos. Est quis aut sint deserunt asperiores. A accusantium ea aut ea. Nisi corporis tempore dolorem et ut nobis ut. Consequatur quo laborum optio consequatur asperiores.', 1685.72, 'Aut laborum optio nam dolorem unde ad dolor velit.', 1, 42, 'uploads/products/product_14_682b52b3204d2.jpeg', 2),
(536, 'PRD-156AI', 'Eaque ut numquam', 'In excepturi eum nisi qui. Eligendi et laborum ipsa omnis aspernatur magnam dolorem. Deleniti assumenda libero consequatur qui. Dolor aliquam dolore sit qui adipisci assumenda tenetur. In fuga nostrum voluptatem voluptatem accusantium velit. Qui officia nihil quos voluptatem sed error.', 1998.04, 'Velit aut et harum vel nostrum dolorum nostrum.', 2, 6, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(537, 'PRD-604NY', 'Libero cupiditate reiciendis', 'Est aliquid et hic. Reiciendis minima nulla pariatur dolor porro amet quam voluptas. Laborum dignissimos sed laborum deserunt explicabo eaque voluptates. Sit qui est dolores dolor. Ipsum fugiat tempore enim. Beatae voluptatem est omnis et.', 858.32, 'Sed tenetur molestiae quas hic inventore neque autem praesentium illo placeat.', 2, 42, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(538, 'PRD-877FP', 'Autem et aspernatur', 'Aut accusantium minima ut et reprehenderit voluptatem aperiam vel. Soluta qui sint debitis harum. Laborum expedita eligendi aliquam accusamus. Sit aspernatur iusto ut. Velit praesentium perferendis laborum quae sapiente dolor repellat.', 1567.84, 'Repellendus et unde fugiat consectetur quaerat pariatur quasi possimus id.', 1, 76, 'uploads/products/product_4_682b52cb519f9.jpeg', 3),
(539, 'PRD-262FF', 'Molestiae doloribus laborum', 'Odit aut temporibus impedit pariatur occaecati laboriosam ratione. Voluptatem mollitia officiis laboriosam exercitationem. Est voluptatibus quibusdam possimus sed odio minima. Sint qui est non consectetur eos. Eius suscipit corporis animi quam incidunt. Corrupti velit aliquam rerum excepturi veritatis sed nihil. Mollitia quia et doloremque et ea et iusto.', 1126.85, 'Aliquid reiciendis suscipit hic aut harum omnis ut non eius.', 5, 41, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(540, 'PRD-022UB', 'Deserunt et qui', 'Id laborum magnam rem sed aut quia ut. Possimus nemo laboriosam et soluta quos inventore repellat. Quis tempore id non. Quo sit nesciunt magnam vel ullam repellat id a. Alias quod quisquam non ullam iusto consequatur nobis.', 970.23, 'Accusantium id quisquam similique ab modi iusto doloribus vero voluptas.', 1, 60, 'uploads/products/product_5_682b531491006.jpeg', 3),
(541, 'PRD-848JA', 'Nulla quisquam laboriosam', 'Reiciendis dolor fugit consequatur officia. Id asperiores blanditiis in neque. Aut qui magni sunt veniam non provident. Quas eligendi quos incidunt maxime omnis et nihil. Et sint non et eaque rerum. Animi sequi aut quod iste.', 70.95, 'Ut dignissimos sunt facilis qui adipisci.', 3, 45, 'uploads/products/product_12_682b52e8c33a0.jpeg', 3),
(542, 'PRD-475FW', 'Iste cumque quia', 'Soluta totam ullam et. Quo id esse quis beatae corporis beatae. Saepe beatae at corporis id cumque ut velit. Itaque vel natus cupiditate placeat cupiditate.', 1498.94, 'Quia ratione numquam consequatur voluptatem voluptatem.', 5, 98, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(543, 'PRD-143SS', 'Omnis fugit fugiat', 'Voluptas id ut est eligendi atque et nulla ducimus. Quia ut repellendus et dolor. Aspernatur quae voluptate adipisci aperiam ex repudiandae. Molestiae adipisci ab quia voluptatibus suscipit sapiente sunt. Sequi atque voluptatibus dolorem esse assumenda ut. Dicta reprehenderit quam cum at voluptatum accusantium sed. Iusto ad perferendis sit et cupiditate laborum placeat.', 349.38, 'Beatae eveniet recusandae omnis sint quia aut.', 1, 41, 'uploads/products/default.jpg', 2),
(544, 'PRD-170CM', 'Perferendis pariatur occaecati', 'Officiis amet laudantium debitis. Et hic saepe minima perspiciatis voluptatem sunt quod. Doloremque voluptatem dolores id quasi quia nihil ut sint. Doloribus dignissimos officia recusandae tenetur. Nihil unde reprehenderit eaque alias quasi beatae.', 102.19, 'Eligendi fugiat sint vitae veniam fugiat et amet.', 1, 10, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(545, 'PRD-558GW', 'Rerum nihil eligendi', 'Quis officiis dolorum in adipisci incidunt animi. Harum velit animi cum hic accusamus ipsum. Qui accusantium provident deserunt dolor nihil aliquam sed. Fugit quasi omnis voluptatem. Culpa rerum inventore aspernatur.', 1711.13, 'Aspernatur id reprehenderit nihil maiores et incidunt consequatur eos aliquid eveniet.', 6, 75, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 1),
(546, 'PRD-304VM', 'Deserunt et repudiandae', 'Corporis reprehenderit placeat perspiciatis ea velit eos. Officia deleniti voluptas excepturi architecto tempora dolorem et. Harum ut qui fugiat impedit consequuntur. Nobis ea qui quas architecto eum. In repellat minus odit.', 1966.54, 'Consequatur voluptatum quidem repudiandae veniam cumque cupiditate.', 2, 5, 'uploads/products/product_7_682b531a776de.jpeg', 3),
(547, 'PRD-614NG', 'Ut facere sit', 'Et omnis quo quaerat harum quis possimus consequatur quae. Tempora dolorum quia officia tenetur accusamus. Et commodi et eum fuga et enim cumque. Ipsum blanditiis ducimus velit sed iure ex minus.', 253.39, 'Dolorem iste ullam ipsam ipsam voluptatem praesentium accusamus rerum commodi.', 3, 93, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(548, 'PRD-894GE', 'Pariatur reprehenderit natus', 'Et tempora id incidunt velit sint nulla. Consequatur in quos ea sit at. Cumque non nihil eum quibusdam at reiciendis. Maiores sequi repellendus in error ullam libero deserunt. Aut vel incidunt corrupti ullam quam.', 397.36, 'Porro quia nihil molestias voluptate est qui.', 3, 12, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(549, 'PRD-265BR', 'Aperiam quaerat facilis', 'Error veniam necessitatibus nam et id. Quod sapiente magnam reiciendis tenetur. Saepe incidunt natus sequi amet ut. Laborum autem quia explicabo voluptate porro quae.', 247.19, 'Et eum consequatur corrupti ut quasi sequi excepturi velit.', 2, 84, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(550, 'PRD-018JK', 'Voluptatibus rem delectus', 'Saepe maxime cum provident id tempore non. Autem tenetur iusto a earum quia cupiditate. Deleniti sed ut odit qui consequatur id quo. Temporibus eos quis aut aspernatur totam dolores reiciendis.', 425.68, 'Soluta culpa perspiciatis quibusdam et reiciendis quo voluptatem.', 2, 95, 'uploads/products/product_7_682b531a776de.jpeg', 1),
(551, 'PRD-128UJ', 'Adipisci modi sed', 'Cum libero porro fugiat dolor. Et dolores odit maxime. Qui sed est ab. Suscipit sit quia delectus voluptates suscipit doloribus sed. Omnis tenetur non minus est excepturi non repellat ut. A rerum porro delectus necessitatibus a. Iure non autem tempora quod non.', 1083.28, 'Consectetur eveniet ut et beatae earum consectetur sapiente quo.', 3, 84, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(552, 'PRD-049MZ', 'Cupiditate nisi est', 'Modi doloremque autem et deserunt odio quas nemo. Velit corrupti necessitatibus numquam aut. Architecto voluptatibus deleniti qui eveniet. Eos facere dolorum consectetur aperiam rerum fuga quaerat. Qui inventore cum est consequuntur officia.', 1310.75, 'Sit necessitatibus id modi facilis rem ipsum quod delectus et sapiente.', 3, 80, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(553, 'PRD-467YY', 'Rerum qui quis', 'Cumque commodi sit reiciendis. Sunt ut debitis nostrum vel corporis non. Illum rem dolorum qui consequatur est sint. Totam adipisci fugiat consequatur.', 1911.34, 'Quia quia amet ipsa ut sit molestias quia.', 5, 54, 'uploads/products/product_5_682b531491006.jpeg', 3),
(554, 'PRD-956AE', 'A ut quibusdam', 'Doloribus possimus non quam sit beatae adipisci. Aut quod cumque consectetur atque iste. Reiciendis cumque molestiae voluptatem sequi. Velit totam recusandae illo et in consequatur.', 1605.19, 'Eum qui repellat sit repellendus illum et.', 3, 87, 'uploads/products/product_2_682b52dacbb5a.jpeg', 2),
(555, 'PRD-229JX', 'Eaque perspiciatis quibusdam', 'Et in deserunt sunt quia voluptatum ut laudantium earum. Quo vero ea perspiciatis. Et nam adipisci quod quam dolores quis ut laboriosam. Voluptatem veritatis rerum neque accusantium aut voluptatum est.', 1312.02, 'Id vel voluptatem adipisci aut consequuntur quia nisi.', 5, 48, 'uploads/products/product_28_67f4d50690e1d.jpg', 1),
(556, 'PRD-229BK', 'Recusandae placeat omnis', 'Consequuntur atque tenetur quam qui incidunt harum. Libero molestiae inventore nobis aperiam. Rerum nesciunt nihil voluptas quo excepturi ullam. Illum illum hic ea ipsum autem eius sed. Quis et minima modi ad. Sint quisquam quo culpa enim nesciunt odit voluptate. Et eum ut cum dolorem facilis tenetur asperiores.', 475.69, 'Velit vel voluptate quasi et nisi veniam qui deleniti alias.', 6, 87, 'uploads/products/product_13_682b52bc21a0d.jpeg', 1),
(557, 'PRD-400II', 'Cupiditate quia ut', 'Eveniet qui at sit illum aut et. Incidunt autem consequatur excepturi deleniti tenetur et qui. Reiciendis dolorum sint et ipsa placeat omnis dolor commodi. Eligendi distinctio enim aut ducimus eveniet.', 1944.95, 'Quia quasi possimus exercitationem esse magnam voluptatem molestiae ab accusantium ullam.', 2, 54, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(558, 'PRD-115LQ', 'Reprehenderit nemo nihil', 'Possimus ipsum asperiores est ullam illo. Quia et qui eius explicabo amet non veniam excepturi. Molestiae corrupti consequatur illum odio autem veniam ullam. Quia natus omnis accusantium voluptatum. Hic ea error qui et qui vitae. Aliquid dolores et vitae non provident voluptas commodi. Dolorum cupiditate natus velit soluta voluptas.', 583.61, 'Repellendus explicabo ut omnis dolore rerum voluptates.', 5, 6, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(559, 'PRD-022IQ', 'Sed vitae iure', 'Recusandae sequi aliquid inventore similique natus. Omnis non excepturi dolorem. Et eum rerum qui dolor. Molestias explicabo autem aperiam nemo nostrum aut. Doloribus perspiciatis id animi. Quasi quis nesciunt nam deleniti voluptas. Ea ut est dolorum amet ipsam atque quasi.', 250.14, 'Dolorem ea magni aspernatur aperiam a aperiam reiciendis ex quas.', 6, 53, 'uploads/products/product_7_682b531a776de.jpeg', 2),
(560, 'PRD-563EL', 'Ipsum quo reiciendis', 'Minus alias placeat perspiciatis possimus. Sed nulla aspernatur dolor. Vel laboriosam sunt harum ab velit ut aliquid. Et enim quas aut libero consequatur delectus.', 1317.66, 'Consequatur aliquid provident ut quo dolor harum dicta.', 1, 8, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(561, 'PRD-075HO', 'Eos facere tempora', 'Tempore id perspiciatis velit autem. Pariatur quia ut sed minus ipsa eligendi asperiores voluptate. Et delectus autem reiciendis qui veritatis architecto neque. Magni rerum maxime optio harum est et deserunt et.', 926.60, 'Soluta tenetur pariatur facere omnis est eveniet quas.', 2, 83, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(562, 'PRD-301ZM', 'Veniam voluptates minus', 'Sed tempore eligendi earum id. Voluptas quasi odit ut molestiae quas. Quod eum officiis sint nihil libero ab autem accusantium. Ut quisquam et magnam inventore. Magni dicta sed quia sunt. Aperiam veritatis quae accusantium fugiat. Dolores enim nobis ducimus enim.', 773.98, 'Est quo autem sequi repellendus quis autem.', 5, 24, 'uploads/products/product_28_67f4d50690e1d.jpg', 2),
(563, 'PRD-324FM', 'Debitis earum et', 'Nam similique nemo et. Ut perferendis doloribus est. Et quod ab est provident vel adipisci molestiae. Debitis odio excepturi reiciendis expedita atque. Et molestiae et a iusto est. Ullam quos laudantium magni magni sed voluptatem.', 518.96, 'Asperiores vitae est et ut beatae quas.', 3, 21, 'uploads/products/product_4_682b52cb519f9.jpeg', 1),
(564, 'PRD-921OC', 'Qui sed impedit', 'At quibusdam sapiente commodi reprehenderit quo minus. Sunt impedit voluptatibus unde eius excepturi corporis tempora minus. Quam in rerum cumque quisquam. Et consectetur harum ipsum et minima asperiores. Voluptas pariatur odit maiores saepe iusto aut consequatur.', 1767.34, 'Harum velit cupiditate possimus laborum porro recusandae expedita non.', 3, 27, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(565, 'PRD-236WZ', 'Veritatis sed unde', 'Nam illo exercitationem nam. Quod incidunt qui molestiae et. Ullam ad sed voluptas et. Laudantium velit aut ut a.', 153.47, 'In minima nemo odit corrupti et rerum officia.', 6, 13, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(566, 'PRD-952HN', 'Nihil fugit dolor', 'Ipsa earum non a et voluptatem. Similique aut voluptatem sed non tempore ut facere maxime. Nihil laudantium culpa voluptas iste sit. Ea adipisci et rem illo non omnis. Pariatur vero et consectetur est cupiditate.', 638.64, 'Ut possimus minus dolorem sint error beatae laborum aliquid.', 2, 7, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 2),
(567, 'PRD-757IT', 'Cum illo facere', 'Ea doloribus eaque fugit explicabo fuga reiciendis. Neque nam magnam ex perspiciatis est. Dolore qui eum sed ut laboriosam quia. Autem id quia sit sunt. Maiores at est aliquid iusto a magni minima adipisci. Consequuntur vel molestias et voluptas quisquam facilis quis eius.', 1643.58, 'Dolorem dicta voluptatem explicabo dolores quas voluptatem.', 4, 29, 'uploads/products/product_18_682b52f92d6cd.jpeg', 3),
(568, 'PRD-165JR', 'Illo est aspernatur', 'Enim ea aspernatur ab at minima nihil. Inventore minus et enim expedita. Commodi et id sit sunt ea tempore et. Qui quia cupiditate fugit. Maxime cum eaque optio eveniet debitis.', 1535.01, 'In et eaque minus porro autem consequuntur consequatur.', 6, 97, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(569, 'PRD-355BX', 'Vitae quam saepe', 'Distinctio iure autem aut culpa neque. Porro eveniet reprehenderit sequi eligendi qui nemo eveniet. Dicta libero consequatur reprehenderit voluptate. Qui sint iste temporibus omnis voluptatibus maxime ut. Voluptas quibusdam quod atque ab. Sit vitae dolore pariatur iure voluptatum. Impedit sapiente et praesentium dolor.', 1960.31, 'Deleniti ut itaque ab consequatur ullam et animi quo.', 1, 8, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(570, 'PRD-857TZ', 'Nihil sunt omnis', 'Velit voluptatem quis eos. Omnis et dicta aspernatur explicabo officiis omnis. Provident doloremque nam facilis molestiae expedita ratione. Illo sit delectus in quasi magnam.', 1318.12, 'Est esse occaecati repellendus sed quos voluptatum.', 3, 82, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(571, 'PRD-127AC', 'Aut omnis aliquam', 'Necessitatibus ullam sit a et quibusdam error. Voluptate quis at illo deleniti. Nobis alias labore iste id perferendis qui cum. Provident cupiditate earum adipisci magni necessitatibus veritatis dolores. Eaque quam dignissimos sit tempore in adipisci.', 923.01, 'Iste ratione et cum tempora nesciunt eius.', 4, 3, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 3),
(572, 'PRD-083QK', 'Dolore et voluptates', 'Cumque eligendi voluptas velit. Tempora odio dolore aperiam debitis velit. Tempora quidem labore unde libero soluta iusto. Quia esse accusantium aliquid tenetur et molestiae perferendis eum. Nostrum quaerat iure culpa quis. Quas voluptatem autem placeat placeat delectus dignissimos aut. Magni amet quibusdam eos magni.', 1549.87, 'A aut et praesentium consequatur eum doloribus non quis cum veritatis maxime.', 3, 87, 'uploads/products/product_13_682b52bc21a0d.jpeg', 2),
(573, 'PRD-731GV', 'Laborum neque natus', 'Sit et eum nisi vero voluptas ipsa quaerat cupiditate. Sunt atque ducimus quia sit eos sequi vel. Vel sit amet dolore quibusdam laboriosam sunt. Doloribus necessitatibus accusamus eligendi enim sit sapiente eligendi recusandae. Consectetur rerum et et quis voluptatum. Placeat molestiae aliquam eos voluptatem. Enim asperiores at in omnis iusto a.', 706.64, 'Consectetur quasi est voluptates ipsum dolor tempora unde facilis.', 4, 76, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(574, 'PRD-929VP', 'Aut optio porro', 'Vel voluptas at et minus impedit. Excepturi omnis enim voluptate aut voluptatem. Quod recusandae velit velit sed ut debitis facilis. Qui delectus sint voluptatem voluptas illo rem. Iure rerum nulla ex praesentium. Harum sed aut temporibus ex. Nihil asperiores quae qui aperiam expedita omnis.', 703.16, 'Quam similique et vitae saepe nihil quia nobis quo labore.', 4, 42, 'uploads/products/product_6_682b52f23e66d.jpeg', 3),
(575, 'PRD-629EN', 'Labore iusto temporibus', 'Error ut deserunt sed sed. Ea quis et mollitia vel. Ut qui aliquid exercitationem velit voluptatem et repellat quibusdam. Autem consequatur eum est. Adipisci et mollitia animi. Voluptatibus voluptate error sint id.', 1700.65, 'Quas non nihil doloribus eum maxime ut ipsa sapiente est.', 6, 53, 'uploads/products/product_18_682b52f92d6cd.jpeg', 2),
(576, 'PRD-213MU', 'Eum rerum quo', 'Ipsum tempora qui aut ratione impedit hic. Aut dolorem odio explicabo dicta quasi consequatur dolor quia. Omnis mollitia illo velit eum quibusdam temporibus enim. Esse quo eligendi id quidem ea esse quis modi. Qui et sit quae consequatur et consequuntur sunt. Qui aliquid sed debitis.', 1232.91, 'Fugiat sit sint autem molestias tempore.', 4, 18, 'uploads/products/product_10_67e2fa07645fe.jpg', 2),
(577, 'PRD-522XH', 'Corrupti qui excepturi', 'Repellendus aliquid suscipit vitae assumenda commodi odit. Cumque sapiente omnis asperiores qui consectetur vitae. Reprehenderit voluptatem non dolores qui. Dignissimos autem itaque mollitia quod quidem minima rem. Nobis et eius dolorum omnis unde est. Quos voluptates consequatur corporis quas consequatur.', 1403.18, 'Culpa molestiae occaecati sed ipsa quis aperiam tempore vero non minus.', 6, 71, 'uploads/products/product_5_682b531491006.jpeg', 2),
(578, 'PRD-302TM', 'Dolor nostrum asperiores', 'Commodi perspiciatis veniam velit aut voluptatem voluptate ipsum cum. Eum qui sed et sed omnis. Sit voluptatem odit animi nisi placeat et. Ducimus soluta animi quisquam sit dolores.', 991.32, 'Eum nesciunt aut qui nihil et quam et quasi ea.', 3, 13, 'uploads/products/product_39_683451723d7ed.jpg', 2),
(579, 'PRD-405SG', 'Dolorum ut maxime', 'Consectetur mollitia consequatur corporis aut eos aut vel. Iste quia itaque autem atque. Accusantium sed aliquam nemo et doloribus eligendi. Quia necessitatibus in facere eveniet. Reprehenderit nemo inventore iure qui deserunt quam.', 1226.08, 'Quo et aliquam dicta est sint doloremque voluptates.', 5, 70, 'uploads/products/product_8_682b530d817de.jpeg', 3),
(580, 'PRD-150YQ', 'Est quod quam', 'Vel magni vero officia ducimus. Aut maiores dolor maiores. Voluptate amet sapiente aperiam reprehenderit id possimus et. Consequatur officia est beatae iusto mollitia atque occaecati. Excepturi rem labore id. Nemo voluptas natus magni assumenda cum.', 792.75, 'Quas id quis distinctio quibusdam consequatur ab recusandae occaecati sit aut.', 4, 18, 'uploads/products/product_6_682b52f23e66d.jpeg', 1),
(581, 'PRD-579KR', 'Itaque consequatur eum', 'Ratione tenetur praesentium beatae voluptatibus reprehenderit voluptatem. Eum labore pariatur quia. Et nam placeat atque sint totam architecto. Voluptatem officiis voluptas maiores quis. Et at officia voluptatem et totam.', 1703.52, 'Repellendus eveniet molestiae recusandae aspernatur laudantium fugiat voluptas molestiae ea eos.', 6, 100, 'uploads/products/product_15_682b52ff60908.jpeg', 1),
(582, 'PRD-844WA', 'Numquam illum maiores', 'Eum et est iure dolor et ipsum. Velit excepturi aut voluptatem et ut quia unde. Error dolor dolores et atque quia mollitia. Quod nam ipsa debitis ex commodi. Iusto rerum quam doloribus facere vel odit et.', 908.94, 'Et inventore laboriosam cum sed dolorum cumque deserunt.', 4, 39, 'uploads/products/product_39_683451723d7ed.jpg', 3),
(583, 'PRD-935BI', 'Earum doloribus molestias', 'Natus aut aut voluptatem sit aliquam enim doloremque ratione. Ex et labore et dolorem qui. Harum quod vel est eaque aliquam. Illum consequuntur ut aut rerum assumenda neque quod blanditiis. Nostrum quo molestias non eveniet accusantium autem. Qui dolores et minima est eveniet nostrum libero.', 1334.00, 'Atque esse totam velit eaque suscipit eos ea repellendus perspiciatis temporibus voluptatem.', 1, 51, 'uploads/products/product_9_682b53079cbf5.jpeg', 1),
(584, 'PRD-436KG', 'Rerum provident dolore', 'Sit velit voluptatem aut delectus. Molestiae non quis sapiente. Possimus assumenda nisi qui aut sequi corrupti soluta. Ab consectetur quia enim. Eaque rerum quibusdam ipsa blanditiis voluptatem provident ipsum. Vitae cumque provident eos.', 1352.96, 'Exercitationem impedit occaecati aliquid doloremque eveniet quibusdam voluptates non iure tempore error.', 4, 10, 'uploads/products/product_5_682b531491006.jpeg', 1),
(585, 'PRD-638NV', 'Nisi vel aperiam', 'Ab quibusdam dignissimos non vel. Quia facere optio velit ut et minima ratione. Cupiditate error libero voluptatem magni maxime quo. Ut impedit quis quia ab quia consectetur. Amet ab ipsum tenetur. Dolor animi nihil molestiae eos sed et. Minus ipsam tenetur numquam voluptate perspiciatis.', 710.71, 'Et reprehenderit quia enim optio animi sit eum sed voluptas.', 1, 75, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 3),
(586, 'PRD-337GD', 'Debitis et ratione', 'Corrupti aut voluptas et fuga aliquam in. Nobis saepe necessitatibus doloremque ipsam. Tenetur ipsam amet suscipit impedit. Ipsum repellendus illum corrupti architecto. Dolorum assumenda molestiae accusantium quis molestiae exercitationem.', 1596.26, 'Magni et excepturi officiis saepe quo error et incidunt natus aperiam.', 3, 49, 'uploads/products/product_39_683451723d7ed.jpg', 1),
(587, 'PRD-435WP', 'Officia distinctio accusamus', 'Est quis officiis aut in. Quo error tempore voluptate ex sed et alias. Minima perspiciatis velit quo ratione cumque facilis voluptate. Totam dolor et vitae.', 752.63, 'Ut natus molestias eligendi sed accusantium commodi voluptatem sit veritatis.', 5, 44, 'uploads/products/product_5_682b531491006.jpeg', 2),
(588, 'PRD-198KQ', 'Recusandae perferendis dolores', 'Cum occaecati dolore quasi fuga. Unde atque voluptas ut officia. Est neque reiciendis officiis quia ut reiciendis. Et sequi blanditiis voluptatum quod.', 10.94, 'Est autem optio qui ex consequatur quibusdam sunt repudiandae necessitatibus.', 5, 58, 'uploads/products/product_10_67e2fa07645fe.jpg', 1),
(589, 'PRD-731CY', 'Dolores earum ab', 'Est occaecati sunt dolorum eaque sunt qui. Commodi labore praesentium molestiae nihil. Quo quos occaecati molestiae sed ea tempora. Consequatur mollitia ducimus velit mollitia incidunt molestias ut delectus. Sit aut et et asperiores recusandae expedita omnis.', 1842.36, 'Culpa consequatur quae deleniti qui enim sint deserunt.', 6, 22, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 1),
(591, '123124523456223', 'Test', NULL, 12.00, NULL, 7, 123, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('sGLVwAriEfFg7STIaNmDU4OIcfedeBGK4eWlwu4H', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiSU9UNWlTaFR3emVBVDE2WFdSbWVkWklyT2xVUThuczA2VmdSVnhGMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9jaGVja291dCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NDoiY2FydCI7YTo3OntpOjE4O2E6NDp7czo0OiJuYW1lIjtzOjI1OiJNYXRpxI1uYSBwbG/EjWEgQVNVUyBCNTUwIjtzOjU6InByaWNlIjtzOjY6IjE0NC41MCI7czo4OiJxdWFudGl0eSI7aToxO3M6NToiaW1hZ2UiO3M6NDY6InVwbG9hZHMvcHJvZHVjdHMvcHJvZHVjdF8xOF82ODJiNTJmOTJkNmNkLmpwZWciO31pOjE2O2E6NDp7czo0OiJuYW1lIjtzOjEzOiJVU0IgSHViIEFua2VyIjtzOjU6InByaWNlIjtzOjU6IjI1LjAwIjtzOjg6InF1YW50aXR5IjtpOjE7czo1OiJpbWFnZSI7czo0NjoidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzE2XzY4MmI1MmUxZGZlOWQuanBlZyI7fWk6NTgyO2E6NDp7czo0OiJuYW1lIjtzOjIxOiJOdW1xdWFtIGlsbHVtIG1haW9yZXMiO3M6NToicHJpY2UiO3M6NjoiOTA4Ljk0IjtzOjg6InF1YW50aXR5IjtpOjE7czo1OiJpbWFnZSI7czo0NToidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzM5XzY4MzQ1MTcyM2Q3ZWQuanBnIjt9aTo1ODc7YTo0OntzOjQ6Im5hbWUiO3M6Mjg6Ik9mZmljaWEgZGlzdGluY3RpbyBhY2N1c2FtdXMiO3M6NToicHJpY2UiO3M6NjoiNzUyLjYzIjtzOjg6InF1YW50aXR5IjtpOjE7czo1OiJpbWFnZSI7czo0NToidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzVfNjgyYjUzMTQ5MTAwNi5qcGVnIjt9aTo1ODU7YTo0OntzOjQ6Im5hbWUiO3M6MTY6Ik5pc2kgdmVsIGFwZXJpYW0iO3M6NToicHJpY2UiO3M6NjoiNzEwLjcxIjtzOjg6InF1YW50aXR5IjtpOjE7czo1OiJpbWFnZSI7czo0NDoidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzFfNjdlMmY1Y2RiMzRlZi5qcGciO31pOjU4OTthOjQ6e3M6NDoibmFtZSI7czoxNjoiRG9sb3JlcyBlYXJ1bSBhYiI7czo1OiJwcmljZSI7czo3OiIxODQyLjM2IjtzOjg6InF1YW50aXR5IjtpOjE7czo1OiJpbWFnZSI7czo0NjoidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzE2XzY4MmI1MmUxZGZlOWQuanBlZyI7fWk6MzkzO2E6NDp7czo0OiJuYW1lIjtzOjE4OiJBdXRlbSBvY2NhZWNhdGkgZXQiO3M6NToicHJpY2UiO3M6NzoiMTQwMC43NyI7czo4OiJxdWFudGl0eSI7aToxO3M6NToiaW1hZ2UiO3M6NDU6InVwbG9hZHMvcHJvZHVjdHMvcHJvZHVjdF8zOV82ODM0NTE3MjNkN2VkLmpwZyI7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO30=', 1761245008);

-- --------------------------------------------------------

--
-- Table structure for table `tip_proizvoda`
--

CREATE TABLE `tip_proizvoda` (
  `id_tip` int(11) NOT NULL,
  `naziv_tip` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tip_proizvoda`
--

INSERT INTO `tip_proizvoda` (`id_tip`, `naziv_tip`) VALUES
(1, 'Miš'),
(2, 'Tipkovnica'),
(3, 'Monitor'),
(4, 'Grafička kartica'),
(5, 'Procesor'),
(6, 'Matična ploča'),
(7, 'RAM memorija'),
(8, 'SSD disk'),
(9, 'HDD disk'),
(10, 'Napajanje'),
(11, 'Kučište'),
(12, 'Ventilator za hlađenje'),
(13, 'Vodeno hlađenje'),
(14, 'Zvučnici'),
(15, 'Slušalice'),
(16, 'Mikrofon'),
(17, 'Web kamera'),
(18, 'USB hub'),
(19, 'Eksterni hard disk'),
(20, 'Flash drive'),
(21, 'Memorijska kartica'),
(22, 'Router'),
(23, 'Modem'),
(24, 'Ethernet switch'),
(25, 'WiFi adapter'),
(26, 'Bluetooth adapter'),
(27, 'Gaming stolica'),
(28, 'Podloga za mi??'),
(29, 'Dr??a?? za slu??alice'),
(30, 'Mikrofon za streaming'),
(31, 'RGB LED traka'),
(32, 'TV kartica'),
(33, 'Capture kartica'),
(34, 'VR headset'),
(35, 'Joystick'),
(36, 'Gamepad'),
(37, 'Grafi??ki tablet'),
(38, 'Projektor'),
(39, 'Printer'),
(40, 'Skener'),
(41, 'Kablovi i adapteri'),
(42, 'Torbica za laptop'),
(43, 'Docking station'),
(44, 'Laptop hladnjak'),
(45, 'Be??i??ni punja??'),
(46, 'Smart home ure??aji'),
(47, 'NAS ure??aj'),
(48, 'Zvu??na kartica'),
(49, 'TV tuner'),
(50, 'UPS (neprekidno napajanje)'),
(51, 'Laptop');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ime` varchar(255) DEFAULT NULL,
  `prezime` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `ime`, `prezime`, `email`, `telefon`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Darijan', 'Vašatko', 'darijanko114@gmail.com', '0976652925', NULL, '$2y$12$0P6wLrVwZLx2JDfno0DiD.cmxtNM3r/o/1FYZ/wdnmF/WreLRMxwO', 'rukokR4Omxa60da4K7xXFy5AkTDaxe2qNf1o4PhuKAc35sSkQXTeTSjGk9kA', '2025-10-17 14:37:45', '2025-10-23 15:06:53'),
(2, 'Lucija', 'Vašatko', 'darijanko112@gmail.com', NULL, NULL, '$2y$12$DGYcbd52ioS/iovDPJGioOlOXnGzogq..JD3lrgn.h1JdKYYRmX0y', NULL, '2025-10-17 15:21:15', '2025-10-17 15:21:15'),
(3, 'Ivana', 'Milić', 'imilic17@gmail.com', NULL, NULL, '$2y$12$Cs.fmVgMQ2JhPw7EnpAVT.QPbhMK14KnfzOF.973kNsIzle8lNJZm', NULL, '2025-10-18 06:02:32', '2025-10-18 06:02:32'),
(4, 'Dariel', 'Kužilek', 'darijanko111@gmail.com', NULL, NULL, '$2y$12$n0Bpu2HsPyP8F1IaBko0Ee6y3B/NjN.leq1uk9II8oPsCO.IHW62a', NULL, '2025-10-21 13:50:20', '2025-10-21 13:50:20');

-- --------------------------------------------------------

--
-- Table structure for table `user_addresses`
--

CREATE TABLE `user_addresses` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `adresa` varchar(255) DEFAULT NULL,
  `grad` varchar(255) DEFAULT NULL,
  `postanski_broj` varchar(255) DEFAULT NULL,
  `drzava` varchar(255) NOT NULL DEFAULT 'Hrvatska',
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_addresses`
--

INSERT INTO `user_addresses` (`id`, `user_id`, `adresa`, `grad`, `postanski_broj`, `drzava`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 4, 'Lavoslava Ružičke 28', 'Daruvar', '43500', 'Hrvatska', 1, '2025-10-21 14:51:25', '2025-10-21 15:34:18'),
(2, 4, 'Ivana Cankara 5', 'Daruvar', '43500', 'Hrvatska', 0, '2025-10-21 15:44:18', '2025-10-21 15:44:18'),
(3, 1, 'Ivana Cankara 5', 'Daruvar', '43500', 'Hrvatska', 1, '2025-10-21 15:45:18', '2025-10-21 15:45:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `detalji_narudzbe`
--
ALTER TABLE `detalji_narudzbe`
  ADD PRIMARY KEY (`DetaljiNarudzbe_ID`),
  ADD KEY `Narudzba_ID` (`Narudzba_ID`),
  ADD KEY `Proizvod_ID` (`Proizvod_ID`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategorija`
--
ALTER TABLE `kategorija`
  ADD PRIMARY KEY (`id_kategorija`);

--
-- Indexes for table `kosarica`
--
ALTER TABLE `kosarica`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_korisnik_proizvod` (`korisnik_id`,`proizvod_id`),
  ADD KEY `proizvod_id` (`proizvod_id`);

--
-- Indexes for table `kupac`
--
ALTER TABLE `kupac`
  ADD PRIMARY KEY (`Kupac_ID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `nacin_placanja`
--
ALTER TABLE `nacin_placanja`
  ADD PRIMARY KEY (`NacinPlacanja_ID`);

--
-- Indexes for table `narudzba`
--
ALTER TABLE `narudzba`
  ADD PRIMARY KEY (`Narudzba_ID`),
  ADD KEY `Kupac_ID` (`Kupac_ID`),
  ADD KEY `NacinPlacanja_ID` (`NacinPlacanja_ID`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `proizvod`
--
ALTER TABLE `proizvod`
  ADD PRIMARY KEY (`Proizvod_ID`),
  ADD KEY `kategorija` (`kategorija`),
  ADD KEY `fk_tip` (`tip_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `tip_proizvoda`
--
ALTER TABLE `tip_proizvoda`
  ADD PRIMARY KEY (`id_tip`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_addresses_user_id_foreign` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detalji_narudzbe`
--
ALTER TABLE `detalji_narudzbe`
  MODIFY `DetaljiNarudzbe_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kosarica`
--
ALTER TABLE `kosarica`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `kupac`
--
ALTER TABLE `kupac`
  MODIFY `Kupac_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `nacin_placanja`
--
ALTER TABLE `nacin_placanja`
  MODIFY `NacinPlacanja_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `narudzba`
--
ALTER TABLE `narudzba`
  MODIFY `Narudzba_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `proizvod`
--
ALTER TABLE `proizvod`
  MODIFY `Proizvod_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=592;

--
-- AUTO_INCREMENT for table `tip_proizvoda`
--
ALTER TABLE `tip_proizvoda`
  MODIFY `id_tip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user_addresses`
--
ALTER TABLE `user_addresses`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalji_narudzbe`
--
ALTER TABLE `detalji_narudzbe`
  ADD CONSTRAINT `detalji_narudzbe_ibfk_1` FOREIGN KEY (`Narudzba_ID`) REFERENCES `narudzba` (`Narudzba_ID`),
  ADD CONSTRAINT `detalji_narudzbe_ibfk_2` FOREIGN KEY (`Proizvod_ID`) REFERENCES `proizvod` (`Proizvod_ID`) ON DELETE CASCADE;

--
-- Constraints for table `kosarica`
--
ALTER TABLE `kosarica`
  ADD CONSTRAINT `kosarica_ibfk_1` FOREIGN KEY (`korisnik_id`) REFERENCES `kupac` (`Kupac_ID`),
  ADD CONSTRAINT `kosarica_ibfk_2` FOREIGN KEY (`proizvod_id`) REFERENCES `proizvod` (`Proizvod_ID`);

--
-- Constraints for table `narudzba`
--
ALTER TABLE `narudzba`
  ADD CONSTRAINT `narudzba_ibfk_1` FOREIGN KEY (`Kupac_ID`) REFERENCES `kupac` (`Kupac_ID`),
  ADD CONSTRAINT `narudzba_ibfk_2` FOREIGN KEY (`NacinPlacanja_ID`) REFERENCES `nacin_placanja` (`NacinPlacanja_ID`);

--
-- Constraints for table `proizvod`
--
ALTER TABLE `proizvod`
  ADD CONSTRAINT `fk_tip` FOREIGN KEY (`tip_id`) REFERENCES `tip_proizvoda` (`id_tip`),
  ADD CONSTRAINT `proizvod_ibfk_1` FOREIGN KEY (`kategorija`) REFERENCES `kategorija` (`id_kategorija`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `user_addresses`
--
ALTER TABLE `user_addresses`
  ADD CONSTRAINT `user_addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
