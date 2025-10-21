-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 21, 2025 at 10:51 AM
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
(33, 2, 39, 5, '2025-10-18 14:48:33');

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
(20, '2025_10_01_073148_create_proizvods_table', 2);

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
(1, 'Gotovina'),
(2, 'Kartica'),
(3, 'Pouze??em'),
(4, 'Kreditna kartica'),
(5, 'PayPal'),
(6, 'Gotovina');

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
  `sifra` bigint(30) NOT NULL,
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
(1, 420635866419203, 'Laptop HP Pavilion', '15.6', 995.00, NULL, 1, 10, 'uploads/products/product_1_67e2f5cdb34ef.jpg', 51),
(2, 489472286923658, 'Monitor Dell', '27', 238.00, NULL, 5, 18, 'uploads/products/product_2_682b52dacbb5a.jpeg', 3),
(3, 513933606740020, 'Miš Logitech', 'Bežični miš', 33.00, NULL, 5, 50, 'uploads/products/product_3_682b52d24e5ab.jpeg', 1),
(4, 878750325810476, 'Tipkovnica Corsair', 'Mehanička tipkovnica', 120.00, NULL, 5, 30, 'uploads/products/product_4_682b52cb519f9.jpeg', 2),
(5, 916482860256714, 'Grafička kartica GTX 1650', '4GB GDDR6', 179.99, NULL, 3, 15, 'uploads/products/product_5_682b531491006.jpeg', 4),
(6, 120301646838960, 'SSD Kingston 500GB', 'NVMe PCIe 3.0', 75.99, NULL, 4, 25, 'uploads/products/product_6_682b52f23e66d.jpeg', 8),
(7, 853225904750917, 'RAM Corsair Vengeance 16GB', 'DDR4 3200MHz', 89.99, NULL, 3, 40, 'uploads/products/product_7_682b531a776de.jpeg', 7),
(8, 986384991342014, 'Napajanje Corsair 650W', 'Modularno', 105.99, NULL, 3, 18, 'uploads/products/product_8_682b530d817de.jpeg', 10),
(9, 512679540770866, 'Kučište NZXT H510', 'ATX mid tower', 119.50, NULL, 3, 22, 'uploads/products/product_9_682b53079cbf5.jpeg', 11),
(10, 685032126697331, 'Procesor Ryzen 5 5600X', '6 jezgri, 12 dretvi', 210.00, NULL, 3, 8, 'uploads/products/product_10_67e2fa07645fe.jpg', 5),
(11, 685032126697331, 'Monitor Samsung 24', 'Full HD LED', 155.00, NULL, 5, 17, 'uploads/products/product_11_682b52c31797e.jpeg', 3),
(12, 140652170418473, 'HDD WD Blue 1TB', '7200rpm', 45.50, NULL, 4, 60, 'uploads/products/product_12_682b52e8c33a0.jpeg', 9),
(13, 878077845335664, 'Printer Epson L3150', 'Inkjet, WiFi', 215.00, NULL, 5, 12, 'uploads/products/product_13_682b52bc21a0d.jpeg', 39),
(14, 785804491289448, 'Miš Razer DeathAdder', 'Gaming miš', 59.50, NULL, 5, 35, 'uploads/products/product_14_682b52b3204d2.jpeg', 1),
(15, 988826881917199, 'Ventilator Arctic F12', '120mm hladnjak', 12.00, NULL, 3, 100, 'uploads/products/product_15_682b52ff60908.jpeg', 12),
(16, 293429082709619, 'USB Hub Anker', '4 USB 3.0 priključka', 25.00, NULL, 4, 45, 'uploads/products/product_16_682b52e1dfe9d.jpeg', 18),
(18, 288754726913537, 'Matična ploča ASUS B550', 'Za Ryzen procesore', 144.50, NULL, 3, 14, 'uploads/products/product_18_682b52f92d6cd.jpeg', 6),
(39, 0, 'SSD Crucial BX500', 'Ovo je SSD', 21.10, NULL, 4, 32, 'uploads/products/product_39_683451723d7ed.jpg', 8);

-- --------------------------------------------------------

--
-- Table structure for table `proizvods`
--

CREATE TABLE `proizvods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
('DNrT7r6C0BK67Kgn9UNhCuBr0vuYGp6ymlfVNbeE', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTVk1cGplSmRZS3pmMDR0UFgycHV0NjZtUGIyT3Qyb0U2a2JjM0NRcSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJjYXJ0IjthOjM6e2k6MTE7YTo0OntzOjQ6Im5hbWUiO3M6MTg6Ik1vbml0b3IgU2Ftc3VuZyAyNCI7czo1OiJwcmljZSI7czo2OiIxNTUuMDAiO3M6ODoicXVhbnRpdHkiO2k6MjtzOjU6ImltYWdlIjtzOjQ2OiJ1cGxvYWRzL3Byb2R1Y3RzL3Byb2R1Y3RfMTFfNjgyYjUyYzMxNzk3ZS5qcGVnIjt9aToxNDthOjQ6e3M6NDoibmFtZSI7czoyMToiTWnFoSBSYXplciBEZWF0aEFkZGVyIjtzOjU6InByaWNlIjtzOjU6IjU5LjUwIjtzOjg6InF1YW50aXR5IjtpOjI7czo1OiJpbWFnZSI7czo0NjoidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzE0XzY4MmI1MmIzMjA0ZDIuanBlZyI7fWk6Mzk7YTo0OntzOjQ6Im5hbWUiO3M6MTc6IlNTRCBDcnVjaWFsIEJYNTAwIjtzOjU6InByaWNlIjtzOjU6IjIxLjEwIjtzOjg6InF1YW50aXR5IjtpOjI7czo1OiJpbWFnZSI7czo0NToidXBsb2Fkcy9wcm9kdWN0cy9wcm9kdWN0XzM5XzY4MzQ1MTcyM2Q3ZWQuanBnIjt9fX0=', 1760800217),
('ZhjolRlXOoOlyr7PgwQYCgxhRaNOgoq7h4NKnKBN', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiY3BrYzUwWmhqYXFDYVFCVUo2OEt0Q2dEYkRKZ0l6aUNWY2x3VU9iNSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJjYXJ0IjthOjA6e319', 1761036204);

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
(1, 'Mi??'),
(2, 'Tipkovnica'),
(3, 'Monitor'),
(4, 'Grafi??ka kartica'),
(5, 'Procesor'),
(6, 'Mati??na plo??a'),
(7, 'RAM memorija'),
(8, 'SSD disk'),
(9, 'HDD disk'),
(10, 'Napajanje'),
(11, 'Ku??i??te'),
(12, 'Ventilator za hla??enje'),
(13, 'Vodeno hla??enje'),
(14, 'Zvu??nici'),
(15, 'Slu??alice'),
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
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Darijan Vašatko', 'darijanko114@gmail.com', NULL, '$2y$12$0P6wLrVwZLx2JDfno0DiD.cmxtNM3r/o/1FYZ/wdnmF/WreLRMxwO', 'rukokR4Omxa60da4K7xXFy5AkTDaxe2qNf1o4PhuKAc35sSkQXTeTSjGk9kA', '2025-10-17 14:37:45', '2025-10-17 14:37:45'),
(2, 'Lucija Vašatko', 'darijanko112@gmail.com', NULL, '$2y$12$DGYcbd52ioS/iovDPJGioOlOXnGzogq..JD3lrgn.h1JdKYYRmX0y', NULL, '2025-10-17 15:21:15', '2025-10-17 15:21:15'),
(3, 'Ivana Milić', 'imilic17@gmail.com', NULL, '$2y$12$Cs.fmVgMQ2JhPw7EnpAVT.QPbhMK14KnfzOF.973kNsIzle8lNJZm', NULL, '2025-10-18 06:02:32', '2025-10-18 06:02:32');

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
-- Indexes for table `proizvods`
--
ALTER TABLE `proizvods`
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- AUTO_INCREMENT for table `kupac`
--
ALTER TABLE `kupac`
  MODIFY `Kupac_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `nacin_placanja`
--
ALTER TABLE `nacin_placanja`
  MODIFY `NacinPlacanja_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `narudzba`
--
ALTER TABLE `narudzba`
  MODIFY `Narudzba_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `proizvod`
--
ALTER TABLE `proizvod`
  MODIFY `Proizvod_ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `proizvods`
--
ALTER TABLE `proizvods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tip_proizvoda`
--
ALTER TABLE `tip_proizvoda`
  MODIFY `id_tip` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
