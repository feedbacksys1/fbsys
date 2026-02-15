-- phpMyAdmin SQL Dump
-- version 5.1.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Feb 15, 2026 at 11:13 AM
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
-- Database: `feedbacksys`
--

-- --------------------------------------------------------

--
-- Table structure for table `app_generalfeedback`
--

CREATE TABLE `app_generalfeedback` (
  `id` bigint NOT NULL,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `status_changed_at` datetime(6) DEFAULT NULL,
  `status_changed_by_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_generalfeedback`
--

INSERT INTO `app_generalfeedback` (`id`, `name`, `email`, `phone`, `topic`, `message`, `status`, `created_at`, `status_changed_at`, `status_changed_by_id`) VALUES
(2, 'Тест', 'test@gmail.com', '349857', 'Тестовая Тема', 'Тестовое сообщение', 'reviewed', '2026-02-12 15:31:29.324986', '2026-02-12 11:53:56.785926', 2);

-- --------------------------------------------------------

--
-- Table structure for table `app_profile`
--

CREATE TABLE `app_profile` (
  `id` bigint NOT NULL,
  `role` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `student_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int NOT NULL,
  `request_type` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_profile`
--

INSERT INTO `app_profile` (`id`, `role`, `student_number`, `user_id`, `request_type`) VALUES
(1, 'student', '12345', 1, ''),
(2, 'teacher', '34234', 3, ''),
(3, 'admin', '', 2, '');

-- --------------------------------------------------------

--
-- Table structure for table `app_requestattachment`
--

CREATE TABLE `app_requestattachment` (
  `id` bigint NOT NULL,
  `file` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `request_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `app_studentrequest`
--

CREATE TABLE `app_studentrequest` (
  `id` bigint NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status_changed_at` datetime(6) DEFAULT NULL,
  `recipient_id` int NOT NULL,
  `sender_id` int NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `topic` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `thread_opened_at` datetime(6) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_studentrequest`
--

INSERT INTO `app_studentrequest` (`id`, `created_at`, `status`, `status_changed_at`, `recipient_id`, `sender_id`, `message`, `topic`, `thread_opened_at`) VALUES
(1, '2026-02-12 13:43:11.978283', 'reviewed', '2026-02-13 09:44:29.925649', 3, 1, 'Тестовое сообщение', 'Тестовая тема', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `app_studentrequestmessage`
--

CREATE TABLE `app_studentrequestmessage` (
  `id` bigint NOT NULL,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `author_id` int NOT NULL,
  `request_id` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add профиль', 7, 'add_profile'),
(26, 'Can change профиль', 7, 'change_profile'),
(27, 'Can delete профиль', 7, 'delete_profile'),
(28, 'Can view профиль', 7, 'view_profile'),
(29, 'Can add обращение обратной связи', 8, 'add_generalfeedback'),
(30, 'Can change обращение обратной связи', 8, 'change_generalfeedback'),
(31, 'Can delete обращение обратной связи', 8, 'delete_generalfeedback'),
(32, 'Can view обращение обратной связи', 8, 'view_generalfeedback'),
(33, 'Can add заявка студента', 9, 'add_studentrequest'),
(34, 'Can change заявка студента', 9, 'change_studentrequest'),
(35, 'Can delete заявка студента', 9, 'delete_studentrequest'),
(36, 'Can view заявка студента', 9, 'view_studentrequest'),
(37, 'Can add вложение заявки', 10, 'add_requestattachment'),
(38, 'Can change вложение заявки', 10, 'change_requestattachment'),
(39, 'Can delete вложение заявки', 10, 'delete_requestattachment'),
(40, 'Can view вложение заявки', 10, 'view_requestattachment'),
(41, 'Can add сообщение в переписке', 11, 'add_studentrequestmessage'),
(42, 'Can change сообщение в переписке', 11, 'change_studentrequestmessage'),
(43, 'Can delete сообщение в переписке', 11, 'delete_studentrequestmessage'),
(44, 'Can view сообщение в переписке', 11, 'view_studentrequestmessage');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int NOT NULL,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$1200000$yWUERsFIeTJnkHLHVmOzk8$qPYeZ9Qt1BImArSGAXIHMdGU/VhvtJ85LlSVrHzBW64=', '2026-02-15 11:11:06.874964', 0, 'test-user', 'Тестовый', 'Пользователь', 'test-user@gmail.com', 0, 1, '2026-02-12 10:56:37.166645'),
(2, 'pbkdf2_sha256$1200000$aCnmRNgNzHHhEUGOBFwS1S$YgLYlhgH/VhQh2SVvdW0Z4QPhENyFUW6c8dRFY0pQDQ=', '2026-02-15 11:09:48.457405', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2026-02-12 11:00:59.755556'),
(3, 'pbkdf2_sha256$1200000$BwaK6pcFevAVNCUl5bJWkn$Mx9qhx0oFzBmZz3ybcm4CEMPAxXHV19t8b4sWqSoZac=', '2026-02-15 11:06:50.101144', 0, 'test-prep', 'Тестовый', 'Преподаватель', 'test-prep@gmail.com', 0, 1, '2026-02-12 11:17:14.487811');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(8, 'app', 'generalfeedback'),
(7, 'app', 'profile'),
(10, 'app', 'requestattachment'),
(9, 'app', 'studentrequest'),
(11, 'app', 'studentrequestmessage'),
(2, 'auth', 'group'),
(3, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

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
(1, 'contenttypes', '0001_initial', '2026-02-12 10:55:28.852964'),
(2, 'auth', '0001_initial', '2026-02-12 10:55:35.027275'),
(3, 'admin', '0001_initial', '2026-02-12 10:55:36.488071'),
(4, 'admin', '0002_logentry_remove_auto_add', '2026-02-12 10:55:36.539564'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2026-02-12 10:55:36.581154'),
(6, 'app', '0001_initial', '2026-02-12 10:55:37.437207'),
(7, 'contenttypes', '0002_remove_content_type_name', '2026-02-12 10:55:38.364956'),
(8, 'auth', '0002_alter_permission_name_max_length', '2026-02-12 10:55:39.033776'),
(9, 'auth', '0003_alter_user_email_max_length', '2026-02-12 10:55:39.164425'),
(10, 'auth', '0004_alter_user_username_opts', '2026-02-12 10:55:39.198348'),
(11, 'auth', '0005_alter_user_last_login_null', '2026-02-12 10:55:39.704334'),
(12, 'auth', '0006_require_contenttypes_0002', '2026-02-12 10:55:39.744020'),
(13, 'auth', '0007_alter_validators_add_error_messages', '2026-02-12 10:55:39.779664'),
(14, 'auth', '0008_alter_user_username_max_length', '2026-02-12 10:55:40.378060'),
(15, 'auth', '0009_alter_user_last_name_max_length', '2026-02-12 10:55:40.998135'),
(16, 'auth', '0010_alter_group_name_max_length', '2026-02-12 10:55:41.111415'),
(17, 'auth', '0011_update_proxy_permissions', '2026-02-12 10:55:41.145091'),
(18, 'auth', '0012_alter_user_first_name_max_length', '2026-02-12 10:55:41.786696'),
(19, 'sessions', '0001_initial', '2026-02-12 10:55:42.120392'),
(20, 'app', '0002_generalfeedback', '2026-02-12 11:25:02.555892'),
(21, 'app', '0003_studentrequest', '2026-02-12 13:29:48.874504'),
(22, 'app', '0004_studentrequest_message_studentrequest_topic', '2026-02-12 13:42:00.518354'),
(23, 'app', '0005_studentrequest_thread_opened_at_alter_profile_role_and_more', '2026-02-13 21:33:50.895799'),
(24, 'app', '0006_profile_request_type', '2026-02-15 11:06:04.450725');

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
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('6j79k3d2r2ptf4m4yzjfo6jbn0nwlnwz', '.eJxVjEEOwiAQAP_C2RBAtoBH730DWWCRqoGktCfj35WkB73OTObFPO5b8Xun1S-JXZhkp18WMD6oDpHuWG-Nx1a3dQl8JPywnc8t0fN6tH-Dgr2MLdmkQGbSKLK0AFYRCBJnhBStyxCAZP6CyaCbpNICXSBtkAxgpMDeH99LOCo:1vqVSd:e40XmH9D7xP7y1uwRkthUcshmRWMwwXnXWSa_XXPBXM', '2026-02-26 12:06:19.375133'),
('rx0m7tl7a2cvdcx7rnl0ib7x9bqwt4sv', '.eJxVjEEOwiAQAP_C2RBAtoBH730DWWCRqoGktCfj35WkB73OTObFPO5b8Xun1S-JXZhkp18WMD6oDpHuWG-Nx1a3dQl8JPywnc8t0fN6tH-Dgr2MLdmkQGbSKLK0AFYRCBJnhBStyxCAZP6CyaCbpNICXSBtkAxgpMDeH99LOCo:1vra1q:5x5_rAQx1k_8vZ_iDXeswHijrAHT9RCYnT7leut0NzM', '2026-03-01 11:11:06.915840');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `app_generalfeedback`
--
ALTER TABLE `app_generalfeedback`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_generalfeedback_status_changed_by_id_b5c61392_fk_auth_user` (`status_changed_by_id`);

--
-- Indexes for table `app_profile`
--
ALTER TABLE `app_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `app_requestattachment`
--
ALTER TABLE `app_requestattachment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_requestattachmen_request_id_bc1b6686_fk_app_stude` (`request_id`);

--
-- Indexes for table `app_studentrequest`
--
ALTER TABLE `app_studentrequest`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_studentrequest_recipient_id_2658f249_fk_auth_user_id` (`recipient_id`),
  ADD KEY `app_studentrequest_sender_id_014629ad_fk_auth_user_id` (`sender_id`);

--
-- Indexes for table `app_studentrequestmessage`
--
ALTER TABLE `app_studentrequestmessage`
  ADD PRIMARY KEY (`id`),
  ADD KEY `app_studentrequestmessage_author_id_9892c079_fk_auth_user_id` (`author_id`),
  ADD KEY `app_studentrequestme_request_id_3676df83_fk_app_stude` (`request_id`);

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
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

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
-- AUTO_INCREMENT for table `app_generalfeedback`
--
ALTER TABLE `app_generalfeedback`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_profile`
--
ALTER TABLE `app_profile`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `app_requestattachment`
--
ALTER TABLE `app_requestattachment`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `app_studentrequest`
--
ALTER TABLE `app_studentrequest`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `app_studentrequestmessage`
--
ALTER TABLE `app_studentrequestmessage`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `app_generalfeedback`
--
ALTER TABLE `app_generalfeedback`
  ADD CONSTRAINT `app_generalfeedback_status_changed_by_id_b5c61392_fk_auth_user` FOREIGN KEY (`status_changed_by_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `app_profile`
--
ALTER TABLE `app_profile`
  ADD CONSTRAINT `app_profile_user_id_87d292a0_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `app_requestattachment`
--
ALTER TABLE `app_requestattachment`
  ADD CONSTRAINT `app_requestattachmen_request_id_bc1b6686_fk_app_stude` FOREIGN KEY (`request_id`) REFERENCES `app_studentrequest` (`id`);

--
-- Constraints for table `app_studentrequest`
--
ALTER TABLE `app_studentrequest`
  ADD CONSTRAINT `app_studentrequest_recipient_id_2658f249_fk_auth_user_id` FOREIGN KEY (`recipient_id`) REFERENCES `auth_user` (`id`),
  ADD CONSTRAINT `app_studentrequest_sender_id_014629ad_fk_auth_user_id` FOREIGN KEY (`sender_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `app_studentrequestmessage`
--
ALTER TABLE `app_studentrequestmessage`
  ADD CONSTRAINT `app_studentrequestme_request_id_3676df83_fk_app_stude` FOREIGN KEY (`request_id`) REFERENCES `app_studentrequest` (`id`),
  ADD CONSTRAINT `app_studentrequestmessage_author_id_9892c079_fk_auth_user_id` FOREIGN KEY (`author_id`) REFERENCES `auth_user` (`id`);

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
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
