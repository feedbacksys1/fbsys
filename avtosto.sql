-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 13, 2026 at 10:38 AM
-- Server version: 8.0.42
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `avtosto`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_client`
--

CREATE TABLE `app_client` (
  `id` int NOT NULL,
  `last_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_client`
--

INSERT INTO `app_client` (`id`, `last_name`, `first_name`, `middle_name`, `phone`, `email`, `address`, `notes`, `created_at`, `updated_at`, `user_id`) VALUES
(1, 'Тестовый', 'Пользователь', '', '123123', 'user@gmail.com', '', '', '2026-02-06 11:19:21.148410', '2026-02-06 11:19:21.148410', 2),
(2, 'Тестовый', 'Мастер', '', '24957', 'master@gmail.com', '', '', '2026-02-07 09:42:43.072622', '2026-02-07 09:42:43.072622', 3);

-- --------------------------------------------------------

--
-- Table structure for table `app_master_schedule`
--

CREATE TABLE `app_master_schedule` (
  `id` int NOT NULL,
  `planned_date` date NOT NULL,
  `planned_start` time(6) DEFAULT NULL,
  `planned_end` time(6) DEFAULT NULL,
  `is_completed` tinyint(1) NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `master_id` int NOT NULL,
  `work_order_id` int DEFAULT NULL,
  `work_order_item_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_master_schedule`
--

INSERT INTO `app_master_schedule` (`id`, `planned_date`, `planned_start`, `planned_end`, `is_completed`, `notes`, `created_at`, `master_id`, `work_order_id`, `work_order_item_id`) VALUES
(1, '2026-02-07', NULL, NULL, 1, '', '2026-02-07 13:21:31.450767', 3, 2, 2),
(2, '2026-02-07', NULL, NULL, 1, '', '2026-02-07 13:28:59.308798', 3, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_part`
--

CREATE TABLE `app_part` (
  `id` int NOT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_quantity` int UNSIGNED NOT NULL,
  `price` decimal(12,2) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `category_id` int DEFAULT NULL
) ;

--
-- Dumping data for table `app_part`
--

INSERT INTO `app_part` (`id`, `code`, `name`, `unit`, `min_quantity`, `price`, `is_active`, `created_at`, `updated_at`, `category_id`) VALUES
(1, 'PRT-FLT-001', 'Масляный фильтр', 'шт', 1, '800.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 7),
(2, 'PRT-FLT-002', 'Воздушный фильтр', 'шт', 1, '1200.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 7),
(3, 'PRT-SPK-001', 'Свеча зажигания', 'шт', 4, '600.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 8),
(4, 'PRT-BRK-001', 'Тормозные колодки передние', 'комплект', 1, '4500.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 9),
(5, 'PRT-BRK-002', 'Тормозные диски передние', 'комплект', 1, '9500.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 10),
(6, 'PRT-EL-001', 'Аккумулятор 60Ah', 'шт', 1, '18000.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 11),
(7, 'PRT-COOL-001', 'Антифриз G12', 'л', 5, '700.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 5),
(8, 'PRT-TIRE-001', 'Летняя шина 205/55 R16', 'шт', 4, '8500.00', 1, '2026-02-07 14:03:48.000000', '2026-02-07 14:03:48.000000', 6);

-- --------------------------------------------------------

--
-- Table structure for table `app_part_category`
--

CREATE TABLE `app_part_category` (
  `id` int NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `parent_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_part_category`
--

INSERT INTO `app_part_category` (`id`, `name`, `parent_id`) VALUES
(1, 'Двигатель', NULL),
(2, 'Тормозная система', NULL),
(3, 'Подвеска', NULL),
(4, 'Электрика', NULL),
(5, 'Охлаждение', NULL),
(6, 'Шины и колёса', NULL),
(7, 'Фильтры', 1),
(8, 'Свечи зажигания', 1),
(9, 'Тормозные колодки', 2),
(10, 'Тормозные диски', 2),
(11, 'Аккумуляторы', 4);

-- --------------------------------------------------------

--
-- Table structure for table `app_part_movement`
--

CREATE TABLE `app_part_movement` (
  `id` int NOT NULL,
  `movement_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int UNSIGNED NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `document_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by_id` int DEFAULT NULL,
  `part_id` int NOT NULL,
  `work_order_id` int DEFAULT NULL
) ;

--
-- Dumping data for table `app_part_movement`
--

INSERT INTO `app_part_movement` (`id`, `movement_type`, `quantity`, `unit_price`, `document_number`, `created_at`, `notes`, `created_by_id`, `part_id`, `work_order_id`) VALUES
(1, 'incoming', 10, '40000.00', 'D1', '2026-02-07 13:31:19.166897', '', 1, 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_payment`
--

CREATE TABLE `app_payment` (
  `id` int NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `payment_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_date` datetime(6) NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_by_id` int DEFAULT NULL,
  `work_order_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_repair_request`
--

CREATE TABLE `app_repair_request` (
  `id` int NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `contact_phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin_comment` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `client_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  `vehicle_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_repair_request`
--

INSERT INTO `app_repair_request` (`id`, `description`, `contact_phone`, `status`, `admin_comment`, `created_at`, `updated_at`, `client_id`, `user_id`, `vehicle_id`) VALUES
(1, 'Слишком длинный тормозной путь у машины. Думаю проблема в тормозной жидкости, нужна диагностика', '345345', 'accepted', '', '2026-02-06 11:19:56.595731', '2026-02-06 11:33:14.662460', 1, 2, NULL),
(2, 'Машину клонит влево при езде', '24564256', 'accepted', '', '2026-02-07 13:15:15.365703', '2026-02-07 13:21:11.088386', 1, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_user`
--

CREATE TABLE `app_user` (
  `id` int NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_user`
--

INSERT INTO `app_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `date_joined`, `role`, `phone`, `is_active`) VALUES
(1, 'pbkdf2_sha256$1200000$b25kDAker7b6zjJE670Cww$HDLzDLN6jTwgpWIG96Lf/Psi+AWcfltvD0q68o5VjkI=', '2026-02-07 13:30:14.997491', 1, 'admin', '', '', 'admin@gmail.com', 1, '2026-02-05 10:17:24.888576', 'viewer', '', 1),
(2, 'pbkdf2_sha256$1200000$HdH0h1PaHjdELakbp6ggPC$PV/4RkGZ3kWFMz/WBhI6MswMxZmy11fNoSa8Phaoqv4=', '2026-02-07 13:14:52.847368', 0, 'user', 'Пользователь', 'Тестовый', 'user@gmail.com', 0, '2026-02-06 11:19:20.540666', 'client', '', 1),
(3, 'pbkdf2_sha256$1200000$hQBvIIhYNL5woSMocf0XNH$CXKHwumsDHlBmJluLKbqhzDl94wmp5SE+V3E4f6SmA8=', '2026-02-07 13:24:55.679156', 0, 'master', 'Мастер', 'Тестовый', 'master@gmail.com', 0, '2026-02-07 09:42:42.074356', 'master', '', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_user_groups`
--

CREATE TABLE `app_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_user_user_permissions`
--

CREATE TABLE `app_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_vehicle`
--

CREATE TABLE `app_vehicle` (
  `id` int NOT NULL,
  `brand` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  `year` int UNSIGNED DEFAULT NULL,
  `mileage` int UNSIGNED DEFAULT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `client_id` int NOT NULL
) ;

--
-- Dumping data for table `app_vehicle`
--

INSERT INTO `app_vehicle` (`id`, `brand`, `model`, `year`, `mileage`, `notes`, `created_at`, `updated_at`, `client_id`) VALUES
(1, 'Ford', 'Fusion', 2019, 50000, '', '2026-02-06 11:27:46.213286', '2026-02-06 11:27:46.213286', 1),
(2, 'Toyota', 'Camry', 2016, 90000, '', '2026-02-06 11:28:06.102501', '2026-02-06 11:28:06.102501', 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_work_order`
--

CREATE TABLE `app_work_order` (
  `id` int NOT NULL,
  `number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceptance_date` date DEFAULT NULL,
  `completion_date` date DEFAULT NULL,
  `mileage` int UNSIGNED DEFAULT NULL,
  `complaint` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `diagnosis` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `work_cost` decimal(12,2) NOT NULL,
  `parts_cost` decimal(12,2) NOT NULL,
  `total_cost` decimal(12,2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `client_id` int NOT NULL,
  `created_by_id` int DEFAULT NULL,
  `vehicle_id` int NOT NULL,
  `repair_request_id` int DEFAULT NULL,
  `is_paid` tinyint(1) NOT NULL,
  `parts_written_off` tinyint(1) NOT NULL
) ;

--
-- Dumping data for table `app_work_order`
--

INSERT INTO `app_work_order` (`id`, `number`, `status`, `acceptance_date`, `completion_date`, `mileage`, `complaint`, `diagnosis`, `work_cost`, `parts_cost`, `total_cost`, `created_at`, `updated_at`, `notes`, `client_id`, `created_by_id`, `vehicle_id`, `repair_request_id`, `is_paid`, `parts_written_off`) VALUES
(1, '000001', 'completed', '2026-02-07', '2026-02-07', 50000, 'Слишком длинный тормозной путь у машины. Думаю проблема в тормозной жидкости, нужна диагностика', '', '1800.00', '13000.00', '14800.00', '2026-02-06 11:33:14.656108', '2026-02-07 13:30:03.025760', '', 1, 1, 1, 1, 0, 0),
(2, '000002', 'completed', '2026-02-07', '2026-02-07', 90000, 'Машину клонит влево при езде', '', '2400.00', '0.00', '2400.00', '2026-02-07 13:21:11.075173', '2026-02-07 13:26:40.258910', '', 1, 1, 2, 2, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `app_work_order_item`
--

CREATE TABLE `app_work_order_item` (
  `id` int NOT NULL,
  `quantity` int UNSIGNED NOT NULL,
  `unit_price` decimal(10,2) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `notes` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `master_id` int DEFAULT NULL,
  `work_order_id` int NOT NULL,
  `work_type_id` int NOT NULL
) ;

--
-- Dumping data for table `app_work_order_item`
--

INSERT INTO `app_work_order_item` (`id`, `quantity`, `unit_price`, `amount`, `notes`, `master_id`, `work_order_id`, `work_type_id`) VALUES
(1, 1, '1800.00', '1800.00', '', 3, 1, 6),
(2, 1, '2400.00', '2400.00', '', 3, 2, 8);

-- --------------------------------------------------------

--
-- Table structure for table `app_work_order_part`
--

CREATE TABLE `app_work_order_part` (
  `id` int NOT NULL,
  `quantity` int UNSIGNED NOT NULL,
  `unit_price` decimal(12,2) NOT NULL,
  `amount` decimal(12,2) NOT NULL,
  `part_id` int NOT NULL,
  `work_order_id` int NOT NULL
) ;

--
-- Dumping data for table `app_work_order_part`
--

INSERT INTO `app_work_order_part` (`id`, `quantity`, `unit_price`, `amount`, `part_id`, `work_order_id`) VALUES
(1, 1, '13000.00', '13000.00', 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `app_work_type`
--

CREATE TABLE `app_work_type` (
  `id` int NOT NULL,
  `name` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_work_type`
--

INSERT INTO `app_work_type` (`id`, `name`, `code`, `price`, `description`, `is_active`) VALUES
(1, 'Замена тормозных колодок', 'SRV-BRK-001', '3500.00', 'Снятие изношенных и установка новых тормозных колодок, проверка состояния тормозных дисков.', 1),
(2, 'Замена моторного масла и масляного фильтра', 'SRV-ENG-002', '2500.00', 'Слив отработанного масла, замена масляного фильтра и залив нового моторного масла.', 1),
(3, 'Компьютерная диагностика автомобиля', 'SRV-DIAG-003', '2000.00', 'Сканирование электронных систем автомобиля, выявление ошибок и неисправностей.', 1),
(4, 'Замена воздушного фильтра', 'SRV-ENG-004', '1200.00', 'Демонтаж старого и установка нового воздушного фильтра двигателя.', 1),
(5, 'Замена свечей зажигания', 'SRV-ENG-005', '2200.00', 'Замена свечей зажигания для стабильной работы двигателя и улучшения запуска.', 1),
(6, 'Замена тормозной жидкости', 'SRV-BRK-006', '3000.00', 'Полная замена тормозной жидкости с прокачкой тормозной системы.', 1),
(7, 'Шиномонтаж (4 колеса)', 'SRV-TIRE-007', '4000.00', 'Снятие и установка шин, балансировка четырех колес.', 1),
(8, 'Регулировка развала-схождения', 'SRV-SUSP-008', '4500.00', 'Настройка углов установки колес для улучшения управляемости и снижения износа шин.', 1),
(9, 'Замена аккумулятора', 'SRV-EL-009', '1800.00', 'Демонтаж старого и установка нового аккумулятора с проверкой напряжения.', 1),
(10, 'Промывка системы охлаждения', 'SRV-COOL-010', '3500.00', 'Очистка системы охлаждения двигателя и замена охлаждающей жидкости.', 1);

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 3, 'add_permission'),
(6, 'Can change permission', 3, 'change_permission'),
(7, 'Can delete permission', 3, 'delete_permission'),
(8, 'Can view permission', 3, 'view_permission'),
(9, 'Can add group', 2, 'add_group'),
(10, 'Can change group', 2, 'change_group'),
(11, 'Can delete group', 2, 'delete_group'),
(12, 'Can view group', 2, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add Клиент', 6, 'add_client'),
(22, 'Can change Клиент', 6, 'change_client'),
(23, 'Can delete Клиент', 6, 'delete_client'),
(24, 'Can view Клиент', 6, 'view_client'),
(25, 'Can add Вид работ', 17, 'add_worktype'),
(26, 'Can change Вид работ', 17, 'change_worktype'),
(27, 'Can delete Вид работ', 17, 'delete_worktype'),
(28, 'Can view Вид работ', 17, 'view_worktype'),
(29, 'Can add Пользователь', 12, 'add_user'),
(30, 'Can change Пользователь', 12, 'change_user'),
(31, 'Can delete Пользователь', 12, 'delete_user'),
(32, 'Can view Пользователь', 12, 'view_user'),
(33, 'Can add Категория запчастей', 9, 'add_partcategory'),
(34, 'Can change Категория запчастей', 9, 'change_partcategory'),
(35, 'Can delete Категория запчастей', 9, 'delete_partcategory'),
(36, 'Can view Категория запчастей', 9, 'view_partcategory'),
(37, 'Can add Запчасть', 8, 'add_part'),
(38, 'Can change Запчасть', 8, 'change_part'),
(39, 'Can delete Запчасть', 8, 'delete_part'),
(40, 'Can view Запчасть', 8, 'view_part'),
(41, 'Can add Автомобиль', 13, 'add_vehicle'),
(42, 'Can change Автомобиль', 13, 'change_vehicle'),
(43, 'Can delete Автомобиль', 13, 'delete_vehicle'),
(44, 'Can view Автомобиль', 13, 'view_vehicle'),
(45, 'Can add Заказ-наряд', 14, 'add_workorder'),
(46, 'Can change Заказ-наряд', 14, 'change_workorder'),
(47, 'Can delete Заказ-наряд', 14, 'delete_workorder'),
(48, 'Can view Заказ-наряд', 14, 'view_workorder'),
(49, 'Can add Оплата', 11, 'add_payment'),
(50, 'Can change Оплата', 11, 'change_payment'),
(51, 'Can delete Оплата', 11, 'delete_payment'),
(52, 'Can view Оплата', 11, 'view_payment'),
(53, 'Can add Движение запчастей', 10, 'add_partmovement'),
(54, 'Can change Движение запчастей', 10, 'change_partmovement'),
(55, 'Can delete Движение запчастей', 10, 'delete_partmovement'),
(56, 'Can view Движение запчастей', 10, 'view_partmovement'),
(57, 'Can add Позиция работ', 15, 'add_workorderitem'),
(58, 'Can change Позиция работ', 15, 'change_workorderitem'),
(59, 'Can delete Позиция работ', 15, 'delete_workorderitem'),
(60, 'Can view Позиция работ', 15, 'view_workorderitem'),
(61, 'Can add План мастера', 7, 'add_masterschedule'),
(62, 'Can change План мастера', 7, 'change_masterschedule'),
(63, 'Can delete План мастера', 7, 'delete_masterschedule'),
(64, 'Can view План мастера', 7, 'view_masterschedule'),
(65, 'Can add Запчасть по заказ-наряду', 16, 'add_workorderpart'),
(66, 'Can change Запчасть по заказ-наряду', 16, 'change_workorderpart'),
(67, 'Can delete Запчасть по заказ-наряду', 16, 'delete_workorderpart'),
(68, 'Can view Запчасть по заказ-наряду', 16, 'view_workorderpart'),
(69, 'Can add Заявка на ремонт', 18, 'add_repairrequest'),
(70, 'Can change Заявка на ремонт', 18, 'change_repairrequest'),
(71, 'Can delete Заявка на ремонт', 18, 'delete_repairrequest'),
(72, 'Can view Заявка на ремонт', 18, 'view_repairrequest');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint UNSIGNED NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL
) ;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int NOT NULL,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(6, 'app', 'client'),
(7, 'app', 'masterschedule'),
(8, 'app', 'part'),
(9, 'app', 'partcategory'),
(10, 'app', 'partmovement'),
(11, 'app', 'payment'),
(18, 'app', 'repairrequest'),
(12, 'app', 'user'),
(13, 'app', 'vehicle'),
(14, 'app', 'workorder'),
(15, 'app', 'workorderitem'),
(16, 'app', 'workorderpart'),
(17, 'app', 'worktype'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2026-02-05 10:15:42.177485'),
(2, 'contenttypes', '0002_remove_content_type_name', '2026-02-05 10:15:43.317863'),
(3, 'auth', '0001_initial', '2026-02-05 10:15:46.294716'),
(4, 'auth', '0002_alter_permission_name_max_length', '2026-02-05 10:15:46.873567'),
(5, 'auth', '0003_alter_user_email_max_length', '2026-02-05 10:15:46.907029'),
(6, 'auth', '0004_alter_user_username_opts', '2026-02-05 10:15:46.935778'),
(7, 'auth', '0005_alter_user_last_login_null', '2026-02-05 10:15:46.975434'),
(8, 'auth', '0006_require_contenttypes_0002', '2026-02-05 10:15:47.013127'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2026-02-05 10:15:47.044982'),
(10, 'auth', '0008_alter_user_username_max_length', '2026-02-05 10:15:47.092119'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2026-02-05 10:15:47.117900'),
(12, 'auth', '0010_alter_group_name_max_length', '2026-02-05 10:15:47.220072'),
(13, 'auth', '0011_update_proxy_permissions', '2026-02-05 10:15:47.249732'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2026-02-05 10:15:47.305516'),
(15, 'app', '0001_initial', '2026-02-05 10:16:07.324166'),
(16, 'admin', '0001_initial', '2026-02-05 10:16:08.866611'),
(17, 'admin', '0002_logentry_remove_auto_add', '2026-02-05 10:16:08.921815'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-05 10:16:08.959848'),
(19, 'sessions', '0001_initial', '2026-02-05 10:16:09.414977'),
(20, 'app', '0002_client_user_alter_masterschedule_master_and_more', '2026-02-05 10:29:21.870752'),
(21, 'app', '0003_alter_client_id_alter_masterschedule_id_and_more', '2026-02-06 10:15:27.984997'),
(22, 'app', '0004_remove_vehicle_vin_and_state_number', '2026-02-06 11:27:20.207848'),
(23, 'app', '0005_workorder_repair_request', '2026-02-06 11:32:33.505431'),
(24, 'app', '0006_workorder_is_paid', '2026-02-07 09:48:26.263461'),
(25, 'app', '0007_workorder_parts_written_off', '2026-02-07 13:33:10.121819');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_client`
--
ALTER TABLE `app_client`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `app_master_schedule`
--
ALTER TABLE `app_master_schedule`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `work_order_item_id` (`work_order_item_id`),
  ADD KEY `app_master_schedule_master_id_b6dd6087_fk` (`master_id`),
  ADD KEY `app_master_schedule_work_order_id_93189a78_fk` (`work_order_id`);

--
-- Indexes for table `app_part`
--
ALTER TABLE `app_part`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_part_code_9c109a38_uniq` (`code`),
  ADD KEY `app_part_category_id_c3cdb7d6_fk` (`category_id`);

--
-- Indexes for table `app_part_category`
--
ALTER TABLE `app_part_category`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_part_category_parent_id_76fde6a2_fk` (`parent_id`);

--
-- Indexes for table `app_part_movement`
--
ALTER TABLE `app_part_movement`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_part_movement_part_id_2874903c_fk` (`part_id`),
  ADD KEY `app_part_movement_created_by_id_ae764629_fk` (`created_by_id`),
  ADD KEY `app_part_movement_work_order_id_ddbeae1a_fk` (`work_order_id`);

--
-- Indexes for table `app_payment`
--
ALTER TABLE `app_payment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_payment_created_by_id_f283b5c0_fk` (`created_by_id`),
  ADD KEY `app_payment_work_order_id_9605ccb1_fk` (`work_order_id`);

--
-- Indexes for table `app_repair_request`
--
ALTER TABLE `app_repair_request`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_repair_request_client_id_9af45684_fk_app_client_id` (`client_id`),
  ADD KEY `app_repair_request_user_id_e5d58a87_fk_app_user_id` (`user_id`),
  ADD KEY `app_repair_request_vehicle_id_e5944f4d_fk_app_vehicle_id` (`vehicle_id`);

--
-- Indexes for table `app_user`
--
ALTER TABLE `app_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `app_user_groups`
--
ALTER TABLE `app_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_user_groups_user_id_group_id_73b8e940_uniq` (`user_id`,`group_id`),
  ADD KEY `app_user_groups_group_id_e774d92c_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `app_user_user_permissions`
--
ALTER TABLE `app_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `app_user_user_permissions_user_id_permission_id_7c8316ce_uniq` (`user_id`,`permission_id`),
  ADD KEY `app_user_user_permis_permission_id_4ef8e133_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `app_vehicle`
--
ALTER TABLE `app_vehicle`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_vehicle_client_id_3c44fc5d_fk` (`client_id`);

--
-- Indexes for table `app_work_order`
--
ALTER TABLE `app_work_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `number` (`number`),
  ADD KEY `app_work_order_client_id_05f35ab1_fk` (`client_id`),
  ADD KEY `app_work_order_created_by_id_b436b3cf_fk` (`created_by_id`),
  ADD KEY `app_work_order_vehicle_id_711aa286_fk` (`vehicle_id`),
  ADD KEY `app_work_order_repair_request_id_05ce2c13_fk_app_repai` (`repair_request_id`);

--
-- Indexes for table `app_work_order_item`
--
ALTER TABLE `app_work_order_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_work_order_item_master_id_411b4108_fk` (`master_id`),
  ADD KEY `app_work_order_item_work_order_id_1137fb79_fk` (`work_order_id`),
  ADD KEY `app_work_order_item_work_type_id_0fa77579_fk` (`work_type_id`);

--
-- Indexes for table `app_work_order_part`
--
ALTER TABLE `app_work_order_part`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_work_order_part_part_id_ac79e42a_fk` (`part_id`),
  ADD KEY `app_work_order_part_work_order_id_00bcab20_fk` (`work_order_id`);

--
-- Indexes for table `app_work_type`
--
ALTER TABLE `app_work_type`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `app_client`
--
ALTER TABLE `app_client`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_master_schedule`
--
ALTER TABLE `app_master_schedule`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_part`
--
ALTER TABLE `app_part`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_part_category`
--
ALTER TABLE `app_part_category`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `app_part_movement`
--
ALTER TABLE `app_part_movement`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_payment`
--
ALTER TABLE `app_payment`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_repair_request`
--
ALTER TABLE `app_repair_request`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_user`
--
ALTER TABLE `app_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `app_user_groups`
--
ALTER TABLE `app_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_user_user_permissions`
--
ALTER TABLE `app_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_vehicle`
--
ALTER TABLE `app_vehicle`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_work_order`
--
ALTER TABLE `app_work_order`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_work_order_item`
--
ALTER TABLE `app_work_order_item`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_work_order_part`
--
ALTER TABLE `app_work_order_part`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `app_work_type`
--
ALTER TABLE `app_work_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_client`
--
ALTER TABLE `app_client`
  ADD CONSTRAINT `app_client_user_id_df70f6f4_fk` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`);

--
-- Constraints for table `app_master_schedule`
--
ALTER TABLE `app_master_schedule`
  ADD CONSTRAINT `app_master_schedule_master_id_b6dd6087_fk` FOREIGN KEY (`master_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `app_master_schedule_work_order_id_93189a78_fk` FOREIGN KEY (`work_order_id`) REFERENCES `app_work_order` (`id`),
  ADD CONSTRAINT `app_master_schedule_work_order_item_id_61ef61ac_fk` FOREIGN KEY (`work_order_item_id`) REFERENCES `app_work_order_item` (`id`);

--
-- Constraints for table `app_part`
--
ALTER TABLE `app_part`
  ADD CONSTRAINT `app_part_category_id_c3cdb7d6_fk` FOREIGN KEY (`category_id`) REFERENCES `app_part_category` (`id`);

--
-- Constraints for table `app_part_category`
--
ALTER TABLE `app_part_category`
  ADD CONSTRAINT `app_part_category_parent_id_76fde6a2_fk` FOREIGN KEY (`parent_id`) REFERENCES `app_part_category` (`id`);

--
-- Constraints for table `app_part_movement`
--
ALTER TABLE `app_part_movement`
  ADD CONSTRAINT `app_part_movement_created_by_id_ae764629_fk` FOREIGN KEY (`created_by_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `app_part_movement_part_id_2874903c_fk` FOREIGN KEY (`part_id`) REFERENCES `app_part` (`id`),
  ADD CONSTRAINT `app_part_movement_work_order_id_ddbeae1a_fk` FOREIGN KEY (`work_order_id`) REFERENCES `app_work_order` (`id`);

--
-- Constraints for table `app_payment`
--
ALTER TABLE `app_payment`
  ADD CONSTRAINT `app_payment_created_by_id_f283b5c0_fk` FOREIGN KEY (`created_by_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `app_payment_work_order_id_9605ccb1_fk` FOREIGN KEY (`work_order_id`) REFERENCES `app_work_order` (`id`);

--
-- Constraints for table `app_repair_request`
--
ALTER TABLE `app_repair_request`
  ADD CONSTRAINT `app_repair_request_client_id_9af45684_fk_app_client_id` FOREIGN KEY (`client_id`) REFERENCES `app_client` (`id`),
  ADD CONSTRAINT `app_repair_request_user_id_e5d58a87_fk_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `app_repair_request_vehicle_id_e5944f4d_fk_app_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `app_vehicle` (`id`);

--
-- Constraints for table `app_user_groups`
--
ALTER TABLE `app_user_groups`
  ADD CONSTRAINT `app_user_groups_group_id_e774d92c_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `app_user_groups_user_id_e6f878f6_fk` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`);

--
-- Constraints for table `app_user_user_permissions`
--
ALTER TABLE `app_user_user_permissions`
  ADD CONSTRAINT `app_user_user_permis_permission_id_4ef8e133_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `app_user_user_permissions_user_id_24780b52_fk` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`);

--
-- Constraints for table `app_vehicle`
--
ALTER TABLE `app_vehicle`
  ADD CONSTRAINT `app_vehicle_client_id_3c44fc5d_fk` FOREIGN KEY (`client_id`) REFERENCES `app_client` (`id`);

--
-- Constraints for table `app_work_order`
--
ALTER TABLE `app_work_order`
  ADD CONSTRAINT `app_work_order_client_id_05f35ab1_fk` FOREIGN KEY (`client_id`) REFERENCES `app_client` (`id`),
  ADD CONSTRAINT `app_work_order_created_by_id_b436b3cf_fk` FOREIGN KEY (`created_by_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `app_work_order_repair_request_id_05ce2c13_fk_app_repai` FOREIGN KEY (`repair_request_id`) REFERENCES `app_repair_request` (`id`),
  ADD CONSTRAINT `app_work_order_vehicle_id_711aa286_fk` FOREIGN KEY (`vehicle_id`) REFERENCES `app_vehicle` (`id`);

--
-- Constraints for table `app_work_order_item`
--
ALTER TABLE `app_work_order_item`
  ADD CONSTRAINT `app_work_order_item_master_id_411b4108_fk` FOREIGN KEY (`master_id`) REFERENCES `app_user` (`id`),
  ADD CONSTRAINT `app_work_order_item_work_order_id_1137fb79_fk` FOREIGN KEY (`work_order_id`) REFERENCES `app_work_order` (`id`),
  ADD CONSTRAINT `app_work_order_item_work_type_id_0fa77579_fk` FOREIGN KEY (`work_type_id`) REFERENCES `app_work_type` (`id`);

--
-- Constraints for table `app_work_order_part`
--
ALTER TABLE `app_work_order_part`
  ADD CONSTRAINT `app_work_order_part_part_id_ac79e42a_fk` FOREIGN KEY (`part_id`) REFERENCES `app_part` (`id`),
  ADD CONSTRAINT `app_work_order_part_work_order_id_00bcab20_fk` FOREIGN KEY (`work_order_id`) REFERENCES `app_work_order` (`id`);

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk` FOREIGN KEY (`user_id`) REFERENCES `app_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
