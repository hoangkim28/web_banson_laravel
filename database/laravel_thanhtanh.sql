-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 17, 2020 at 07:04 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel_thanhtanh`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `GetRevenueDaily` (IN `fromDate` VARCHAR(10), IN `toDate` VARCHAR(10))  BEGIN
	select
                CAST(b.created_at AS DATE) as Date,
                sum(bd.quantity*bd.product_price) as Revenue,
                sum((bd.quantity*bd.product_price)-(bd.quantity * p.sale_price)) as Profit
                from bills b
                inner join bill_details bd
                on b.id = bd.order_id
                inner join product_attributes p
                on bd.product_attribute_id = p.id
                where b.created_at <= cast(toDate as date) 
				AND b.created_at >= cast(fromDate as date)
                group by b.created_at;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Kích thước', NULL, NULL),
(2, 'Bản màu', '2020-08-27 06:55:40', '2020-08-27 06:55:40');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_values`
--

CREATE TABLE `attribute_values` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_values`
--

INSERT INTO `attribute_values` (`id`, `name`, `value`, `attribute_id`, `created_at`, `updated_at`) VALUES
(1, 'Thùng 5 lít', '5', 1, '2020-07-15 07:13:37', '2020-07-15 07:13:37'),
(2, 'Thùng 18L', '18', 1, '2020-07-15 07:13:49', '2020-07-15 07:13:49'),
(3, 'Chay sịt 200ml', '200ml', 1, '2020-07-15 07:14:10', '2020-07-15 07:14:10'),
(4, 'Không màu', '0', 2, '2020-08-27 06:57:05', '2020-08-27 06:57:05'),
(5, 'Máy pha màu', '1', 2, '2020-08-27 06:57:56', '2020-08-27 06:57:56'),
(6, 'Thùng 25 Lít', '25', 1, '2020-09-11 00:23:07', '2020-09-11 00:23:16');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_value_product_attribute`
--

CREATE TABLE `attribute_value_product_attribute` (
  `attribute_value_id` int(10) UNSIGNED NOT NULL,
  `product_attribute_id` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_value_product_attribute`
--

INSERT INTO `attribute_value_product_attribute` (`attribute_value_id`, `product_attribute_id`) VALUES
(2, 3),
(1, 4),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 11),
(1, 12),
(1, 13),
(1, 19),
(5, 19),
(1, 21),
(4, 21),
(1, 23),
(5, 23),
(2, 24),
(5, 24),
(1, 25),
(4, 25),
(1, 26),
(4, 26),
(1, 27),
(4, 27),
(6, 28),
(5, 28),
(2, 29),
(5, 29),
(1, 30),
(4, 30),
(1, 31),
(4, 31),
(1, 32),
(5, 32),
(2, 33),
(4, 33),
(1, 34),
(4, 34),
(2, 35),
(5, 35),
(2, 36),
(5, 36),
(1, 37),
(4, 37);

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `address1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` int(11) DEFAULT NULL,
  `payment_method` int(11) DEFAULT NULL,
  `subtotal` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bills`
--

INSERT INTO `bills` (`id`, `user_id`, `full_name`, `email`, `phone`, `address1`, `address2`, `comment`, `payment_method`, `subtotal`, `tax`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 'admin@admin.com', 1211212121, '212', '1212', NULL, NULL, '150,000', '15,000', '165,000', '2020-11-14 23:36:04', '2020-11-14 23:36:04'),
(2, 1, 'Quản trị viên', 'admin@admin.com', 121312312, '312312', '3123123', NULL, NULL, '150,000', '15,000', '165,000', '2020-11-15 23:37:14', '2020-11-15 23:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `bill_details`
--

CREATE TABLE `bill_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_attribute_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bill_details`
--

INSERT INTO `bill_details` (`id`, `order_id`, `product_id`, `quantity`, `product_price`, `product_attribute_id`, `product_name`, `product_sku`, `color`) VALUES
(1, 1, 2, 4, 1111, 37, 'đá', 'ádá', '2'),
(2, 2, 2, 4, 1111, 37, 'đá', 'ádá', '2');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `image`, `website`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Sơn Delux', 'son-delux', 'brands\\August2020\\j3rAbkjKE1ct4KwZb565.png', 'http://website01.vn', 1, '2020-01-30 01:20:00', '2020-08-16 03:42:55'),
(2, 'Sơn Jotun', 'son-jotun', 'brands\\February2020\\4viI80n7b1arJXP2d3D7.png', NULL, 1, '2020-02-27 07:20:34', '2020-02-27 07:20:34'),
(3, 'Sơn Mykolor', 'son-mykolor', 'brands\\February2020\\du7CkUXX3G6DG6V2SkbK.jpg', NULL, 1, '2020-02-27 07:21:25', '2020-02-27 07:21:25'),
(4, 'Sơn Nippon', 'son-nippon', 'brands\\August2020\\U6yyAf6J50WLeb9jnxQm.png', 'https://nipponpaint.com.vn/', 1, '2020-05-16 07:42:06', '2020-08-16 03:42:21');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Sơn nội thất', 'son-noi-that', 1, '2020-01-29 16:08:49', '2020-07-26 03:26:07'),
(2, NULL, 'Sơn ngoại thất', 'son-ngoai-that', 1, '2020-01-29 16:08:49', '2020-07-26 03:26:39'),
(3, 1, 'Sơn chống thấm', 'son-chong-tham', 1, '2020-02-26 14:40:54', '2020-07-26 03:45:03'),
(4, 2, 'Sơn lót trần nhà', 'son-lot-tran-nha', 1, '2020-05-29 07:22:18', '2020-07-22 13:40:41'),
(7, 2, 'Sơn lót kháng kiềm', 'son-lot-khang-kiem', 1, '2020-07-24 14:11:30', '2020-07-24 14:11:30'),
(8, NULL, 'Sơn giữa', 'son-giua', 1, '2020-07-24 14:13:48', '2020-07-24 14:13:48'),
(9, 2, 'Sơn phủ', 'son-phu', 1, '2020-07-24 14:13:58', '2020-07-26 03:44:46'),
(10, 1, 'Bột trét', 'bot-tret', 1, '2020-07-24 14:14:06', '2020-07-26 03:44:32'),
(11, NULL, 'Sơn sấy', 'son-say', 1, '2020-07-24 14:14:19', '2020-07-24 14:14:19'),
(12, 2, 'Sơn vạch đường', 'son-vach-duong', 1, '2020-07-24 14:14:32', '2020-07-26 03:44:20'),
(13, 2, 'Sơn chịu nhiệt', 'son-chiu-nhiet', 1, '2020-07-24 14:14:42', '2020-07-26 03:44:12'),
(14, NULL, 'Sơn dân dụng', 'son-dan-dung', 1, '2020-07-26 03:47:15', '2020-07-26 03:47:15'),
(15, NULL, 'Sơn công nghiệp', 'son-cong-nghiep', 1, '2020-07-26 03:47:24', '2020-07-26 03:47:24');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `birthday` date DEFAULT '2020-01-01',
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `name`, `email`, `password`, `address`, `phone`, `birthday`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 'customertest', 'customertest@thanhtanh.com.vn', '$2y$10$5.PoRyhQ85LHOBOn1U7Gz.8JV80VvYKvQjBfsSQRpbYTNAcDY/RgS', NULL, NULL, '2020-01-01', NULL, '2020-11-10 23:19:25', '2020-11-10 23:19:25'),
(2, 'customertest2', 'customertest2@thanhtanh.com.vn', '$2y$10$.rwXMESwF3RfQTaAehh7gezmU27z71AsdMsmTCmBdHNr8R4MakBye', NULL, NULL, '2020-01-01', NULL, '2020-11-10 23:21:42', '2020-11-10 23:21:42');

-- --------------------------------------------------------

--
-- Table structure for table `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(2, 1, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{}', 4),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{}', 6),
(4, 1, 'password', 'password', 'Mật khẩu', 1, 0, 0, 1, 1, 0, '{}', 9),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, '{}', 10),
(6, 1, 'created_at', 'timestamp', 'Ngày thêm', 0, 0, 1, 0, 0, 0, '{}', 11),
(7, 1, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 0, 0, 0, 0, 0, '{}', 13),
(8, 1, 'avatar', 'image', 'Ảnh đại diện', 0, 0, 1, 1, 1, 1, '{}', 14),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Quyền chính', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Quyền phụ', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 3),
(11, 1, 'settings', 'hidden', 'Cài đặt', 0, 0, 0, 0, 0, 0, '{}', 16),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(17, 3, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{}', 2),
(18, 3, 'created_at', 'timestamp', 'Ngày tạo', 0, 0, 0, 0, 0, 0, '{}', 3),
(19, 3, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 0, 0, 0, 0, 0, '{}', 4),
(20, 3, 'display_name', 'text', 'Tên hiển thị', 1, 1, 1, 1, 1, 1, '{}', 5),
(21, 1, 'role_id', 'text', 'Quyền', 0, 1, 1, 1, 1, 1, '{}', 15),
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(23, 4, 'parent_id', 'select_dropdown', 'Danh mục cha', 0, 0, 1, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- Ch\\u1ecdn danh m\\u1ee5c cha --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"},\"display\":{\"width\":\"3\"}}', 3),
(25, 4, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"}}', 4),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:categories,slug\"},\"display\":{\"width\":\"3\"}}', 5),
(27, 4, 'created_at', 'timestamp', 'Ngày thêm', 0, 1, 1, 0, 0, 0, '{\"format\":\"%Y-%m-%d\"}', 7),
(28, 4, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 0, 0, 0, 0, 0, '{\"format\":\"%Y-%m-%d\"}', 8),
(73, 12, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(74, 12, 'name', 'text', 'Tên', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 2),
(75, 12, 'image', 'image', 'Hinh ảnh', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"display\":{\"width\":\"6\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 5),
(76, 12, 'website', 'text', 'Website', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 4),
(77, 12, 'status', 'checkbox', 'Trạng thái', 0, 1, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"true\",\"display\":{\"width\":\"2\"}}', 6),
(78, 12, 'created_at', 'timestamp', 'Ngày thêm', 0, 1, 1, 0, 0, 1, '{\"format\":\"%Y-%m-%d\"}', 7),
(79, 12, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 0, 0, 0, 0, 0, '{\"format\":\"%Y-%m-%d\"}', 8),
(100, 17, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(101, 17, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(102, 17, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 1, 0, 1, '{}', 3),
(103, 17, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(104, 20, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(105, 20, 'user_id', 'number', 'Khách hàng', 0, 0, 0, 0, 0, 1, '{}', 3),
(106, 20, 'full_name', 'text', 'Họ và tên', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"}}', 4),
(107, 20, 'address1', 'text_area', 'Địa chỉ 1', 1, 0, 1, 1, 1, 1, '{\"display\":{\"row\":\"3\",\"width\":\"3\"}}', 7),
(108, 20, 'address2', 'text_area', 'Địa chỉ 2', 0, 0, 1, 1, 1, 1, '{\"display\":{\"row\":\"3\",\"width\":\"3\"}}', 8),
(109, 20, 'phone', 'number', 'Điện thoại', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"}}', 5),
(110, 20, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"}}', 6),
(111, 20, 'comment', 'text_area', 'Ghi chú', 0, 0, 1, 1, 1, 1, '{\"display\":{\"row\":\"3\",\"width\":\"6\"}}', 9),
(112, 20, 'payment_method', 'text', 'Phương thức thanh toán', 0, 0, 1, 1, 1, 1, '{}', 15),
(114, 20, 'order_status', 'text', 'Trạng thái đơn hàng', 0, 1, 1, 1, 1, 1, '{}', 17),
(115, 20, 'created_at', 'timestamp', 'Ngày thêm', 0, 0, 0, 0, 0, 1, '{\"format\":\"%d-%m-%Y\"}', 18),
(116, 20, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 1, 0, 0, 0, 0, '{\"format\":\"%d-%m-%Y\",\"display\":{\"width\":\"3\",\"class\":\"text-center\"}}', 14),
(117, 20, 'order_belongsto_user_relationship', 'relationship', 'Khách hàng', 0, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"},\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(118, 20, 'order_belongsto_order_status_relationship', 'relationship', 'Trạng thái đơn hàng', 0, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"},\"model\":\"App\\\\Models\\\\OrderStatus\",\"table\":\"order_statuses\",\"type\":\"belongsTo\",\"column\":\"order_status\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 13),
(125, 20, 'order_belongsto_payment_method_relationship', 'relationship', 'Phương thức thanh toán', 0, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"},\"model\":\"App\\\\Models\\\\PaymentMethod\",\"table\":\"payment_methods\",\"type\":\"belongsTo\",\"column\":\"payment_method\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 16),
(126, 23, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(127, 23, 'code', 'text', 'Code', 0, 1, 1, 1, 1, 1, '{}', 2),
(128, 23, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 3),
(129, 23, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 1, 0, 1, '{}', 4),
(130, 23, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 5),
(143, 12, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:brands,slug\"},\"display\":{\"width\":\"6\"}}', 3),
(145, 4, 'status', 'checkbox', 'Trạng thái', 1, 1, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"true\",\"display\":{\"width\":\"2\"}}', 6),
(147, 4, 'category_hasmany_product_relationship', 'relationship', 'Sản phẩm', 0, 0, 0, 0, 0, 1, '{\"model\":\"App\\\\Models\\\\Product\",\"table\":\"products\",\"type\":\"hasMany\",\"column\":\"category_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 9),
(148, 20, 'subtotal', 'text', 'Tổng', 0, 0, 1, 1, 1, 1, '{}', 10),
(149, 20, 'tax', 'text', 'Thuế', 0, 1, 1, 1, 1, 1, '{}', 11),
(150, 20, 'total', 'text', 'Tổng giá trị', 0, 1, 1, 1, 1, 1, '{}', 12),
(151, 1, 'email_verified_at', 'timestamp', 'Email Verified At', 0, 0, 1, 1, 1, 1, '{}', 12),
(152, 1, 'address', 'text', 'Địa chỉ', 0, 1, 1, 1, 1, 1, '{}', 8),
(153, 1, 'phone', 'number', 'Điện thoại', 0, 1, 1, 1, 1, 1, '{}', 7),
(154, 1, 'birthday', 'text', 'Ngày sinh', 0, 1, 1, 1, 1, 1, '{}', 5),
(166, 27, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(168, 27, 'category_id', 'select_dropdown', 'Category Id', 0, 0, 1, 1, 1, 1, '{}', 3),
(169, 27, 'brand_id', 'select_dropdown', 'Brand Id', 0, 0, 1, 1, 1, 1, '{}', 5),
(170, 27, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 6),
(171, 27, 'sku', 'text', 'Sku', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 8),
(172, 27, 'seo_title', 'text', 'Seo Title', 0, 0, 1, 1, 1, 1, '{}', 20),
(173, 27, 'excerpt', 'text', 'Giới thiệu', 0, 0, 1, 1, 1, 1, '{}', 19),
(174, 27, 'body', 'rich_text_box', 'Thông tin sản phẩm', 1, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"12\"}}', 15),
(175, 27, 'avatar', 'image', 'Ảnh đại diện', 1, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 17),
(177, 27, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:products,slug\"},\"display\":{\"width\":\"6\"}}', 7),
(178, 27, 'meta_description', 'text_area', 'Meta Description', 0, 0, 1, 1, 1, 1, '{}', 21),
(179, 27, 'meta_keywords', 'text_area', 'Meta Keywords', 0, 0, 1, 1, 1, 1, '{}', 22),
(180, 27, 'status', 'checkbox', 'Trạng thái', 1, 1, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"on\",\"display\":{\"width\":\"3\"}}', 29),
(181, 27, 'featured', 'checkbox', 'Sản phẩm đặc biệt', 1, 0, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"on\",\"display\":{\"width\":\"3\"},\"title\":\"\\u0110\\u00e2y l\\u00e0 s\\u1ea3n ph\\u1ea9m \\u0111\\u1eb7t bi\\u1ec7t\"}', 25),
(186, 27, 'sold', 'number', 'Đã bán', 0, 1, 1, 0, 0, 1, '{\"display\":{\"width\":\"2\"}}', 14),
(187, 27, 'view', 'number', 'Lượt xem', 0, 1, 1, 0, 0, 1, '{\"display\":{\"width\":\"2\"}}', 16),
(188, 27, 'date_lastview', 'timestamp', 'Date Lastview', 1, 0, 0, 0, 0, 1, '{}', 23),
(189, 27, 'date_available', 'timestamp', 'Ngày hiện thị', 1, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"}}', 24),
(190, 27, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 1, '{}', 26),
(191, 27, 'updated_at', 'timestamp', 'Updated At', 0, 0, 1, 0, 0, 1, '{}', 28),
(193, 27, 'product_hasone_brand_relationship', 'relationship', 'Thương hiệu', 0, 0, 0, 1, 1, 1, '{\"display\":{\"width\":\"4\"},\"model\":\"App\\\\Models\\\\Brand\",\"table\":\"brands\",\"type\":\"belongsTo\",\"column\":\"brand_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 4),
(194, 27, 'product_hasone_category_relationship', 'relationship', 'Danh mục', 0, 1, 0, 1, 1, 1, '{\"display\":{\"width\":\"4\"},\"model\":\"App\\\\Models\\\\Category\",\"table\":\"categories\",\"type\":\"belongsTo\",\"column\":\"category_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(254, 38, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(255, 38, 'name', 'text', 'Tên thuộc tính', 1, 1, 1, 1, 1, 1, '{\"width\":\"4\"}', 2),
(256, 38, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 3),
(257, 38, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(258, 39, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(259, 39, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{}', 4),
(260, 39, 'value', 'text', 'Giá trị', 1, 1, 1, 1, 1, 1, '{}', 5),
(261, 39, 'attribute_id', 'number', 'Thuộc tính', 1, 0, 0, 1, 1, 0, '{}', 3),
(262, 39, 'created_at', 'timestamp', 'Ngày thêm', 0, 1, 0, 0, 0, 1, '{}', 6),
(263, 39, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
(264, 39, 'attribute_value_belongsto_attribute_relationship', 'relationship', 'Thuộc tính cần thêm giá trị', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\Attribute\",\"table\":\"attributes\",\"type\":\"belongsTo\",\"column\":\"attribute_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"attribute_value_product_attribute\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(266, 4, 'category_belongsto_category_relationship', 'relationship', 'Danh mục cha', 0, 1, 0, 0, 0, 0, '{\"model\":\"App\\\\Models\\\\Category\",\"table\":\"categories\",\"type\":\"belongsTo\",\"column\":\"parent_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"attribute_value_product_attribute\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(267, 27, 'stock', 'number', 'Kho', 0, 1, 1, 0, 0, 1, '{}', 22),
(268, 40, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(269, 40, 'name', 'text', 'Tên khách hàng', 0, 1, 1, 1, 1, 1, '{}', 3),
(270, 40, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{\"type\":\"email\"}', 4),
(271, 40, 'password', 'password', 'Password', 1, 1, 1, 1, 1, 1, '{}', 5),
(272, 40, 'address', 'text', 'Địa chỉ', 0, 1, 1, 1, 1, 1, '{}', 6),
(273, 40, 'phone', 'number', 'Điện thoại', 0, 1, 1, 1, 1, 1, '{}', 7),
(274, 40, 'birthday', 'date', 'Ngày sinh', 0, 1, 1, 1, 1, 1, '{}', 8),
(275, 40, 'user_id', 'number', 'User Id', 0, 0, 1, 1, 1, 1, '{}', 9),
(276, 40, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 1, '{}', 10),
(277, 40, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 11),
(278, 40, 'customer_belongsto_user_relationship', 'relationship', 'User ID', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"attribute_value_product_attribute\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(279, 41, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(280, 41, 'full_name', 'text', 'Khách hàng', 0, 1, 1, 1, 1, 1, '{}', 2),
(281, 41, 'email', 'text', 'Email', 0, 1, 1, 1, 1, 1, '{\"type\":\"email\"}', 3),
(282, 41, 'phone', 'number', 'Điện thoại', 0, 1, 1, 1, 1, 1, '{}', 4),
(283, 41, 'address1', 'text', 'Địa chỉ 1', 0, 0, 1, 1, 1, 1, '{}', 5),
(284, 41, 'address2', 'text', 'Địa chỉ 2', 0, 0, 1, 1, 1, 1, '{}', 6),
(285, 41, 'comment', 'text', 'Ghi chú', 0, 0, 1, 1, 1, 1, '{}', 7),
(286, 41, 'payment_method', 'text', 'Phương thức thanh toán', 0, 1, 1, 1, 1, 1, '{}', 8),
(288, 41, 'subtotal', 'text', 'Trước thuế', 0, 0, 1, 1, 1, 1, '{}', 10),
(289, 41, 'tax', 'text', 'Thuế', 0, 0, 1, 1, 1, 1, '{}', 11),
(290, 41, 'total', 'number', 'Tổng', 0, 1, 1, 1, 1, 1, '{}', 12),
(291, 41, 'created_at', 'timestamp', 'Ngày tạo', 0, 1, 1, 1, 0, 1, '{}', 13),
(292, 41, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 0, 0, 0, 0, 0, '{}', 14);

-- --------------------------------------------------------

--
-- Table structure for table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'Người dùng', 'Người dùng', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 09:08:49', '2020-05-20 07:45:02'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(3, 'roles', 'roles', 'Phân Quyền', 'Phân Quyền', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 09:08:49', '2020-05-20 07:44:34'),
(4, 'categories', 'categories', 'Danh mục sản phẩm', 'Danh mục sản phẩm', 'voyager-categories', 'App\\Models\\Category', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":\"name\",\"scope\":null}', '2020-01-29 09:08:49', '2020-08-15 22:17:25'),
(12, 'brands', 'brands', 'Thương hiệu', 'Thương hiệu', 'voyager-company', 'App\\Models\\Brand', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 18:16:17', '2020-08-15 22:17:12'),
(17, 'order_statuses', 'order-statuses', 'Order Status', 'Order Statuses', 'voyager-info-circled', 'App\\Models\\OrderStatus', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-30 00:00:44', '2020-01-30 00:01:54'),
(19, 'order', 'order', 'Order', 'Orders', NULL, 'App\\Models\\Order', NULL, 'App\\Http\\Controllers\\Admin\\OrderController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(20, 'orders', 'orders', 'Đơn hàng', 'Đơn hàng', 'voyager-basket', 'App\\Models\\Order', NULL, 'App\\Http\\Controllers\\Admin\\OrderController', NULL, 1, 1, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"phone\",\"scope\":null}', '2020-01-30 00:05:19', '2020-11-14 02:06:29'),
(23, 'payment_methods', 'payment-methods', 'Payment Method', 'Payment Methods', 'voyager-code', 'App\\Models\\PaymentMethod', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-30 01:10:13', '2020-01-30 01:15:16'),
(25, 'product_attribute', 'product-attribute', 'Product Attribute', 'Product Attributes', NULL, 'App\\Models\\ProductAttribute', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-05-29 23:50:59', '2020-05-29 23:50:59'),
(27, 'products', 'products', 'Sản phẩm', 'Sản phẩm', 'voyager-data', 'App\\Models\\Product', NULL, 'App\\Http\\Controllers\\Admin\\ProductController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-05-31 19:26:32', '2020-09-19 02:39:14'),
(38, 'attributes', 'attributes', 'Thuộc tính sản phẩm', 'Thuộc tính sản phẩm', NULL, 'App\\Models\\Attribute', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-07-07 21:22:28', '2020-07-07 21:22:28'),
(39, 'attribute_values', 'attribute-values', 'Giá trị của thuộc tính', 'Giá trị của các thuộc tính', NULL, 'App\\Models\\AttributeValue', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-07-07 21:23:22', '2020-07-09 20:50:51'),
(40, 'customers', 'customers', 'Khách hàng', 'Khách hàng', 'voyager-people', 'App\\Models\\Customer', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-11-04 20:54:53', '2020-11-04 20:59:13'),
(41, 'bills', 'bills', 'Hóa đơn', 'Hóa đơn', 'voyager-bar-chart', 'App\\Models\\Bill', NULL, 'App\\Http\\Controllers\\Admin\\BillController', NULL, 1, 1, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"phone\",\"scope\":null}', '2020-11-13 05:40:16', '2020-11-13 23:21:27');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2020-01-29 09:08:49', '2020-01-29 09:08:49');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Trang chủ', '', '_self', 'voyager-boat', '#000000', NULL, 1, '2020-01-29 09:08:49', '2020-04-19 04:49:24', 'voyager.dashboard', 'null'),
(2, 1, 'Phương tiện', '', '_self', 'voyager-images', '#000000', NULL, 5, '2020-01-29 09:08:49', '2020-11-13 05:40:55', 'voyager.media.index', 'null'),
(3, 1, 'Người dùng', '', '_self', 'voyager-person', '#000000', 20, 2, '2020-01-29 09:08:49', '2020-04-19 02:23:51', 'voyager.users.index', 'null'),
(4, 1, 'Quyền - Nhóm quyền', '', '_self', 'voyager-lock', '#000000', 20, 1, '2020-01-29 09:08:49', '2020-04-19 02:23:41', 'voyager.roles.index', 'null'),
(5, 1, 'Công cụ', '', '_self', 'voyager-tools', '#000000', NULL, 7, '2020-01-29 09:08:49', '2020-11-13 05:40:55', NULL, ''),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2020-01-29 09:08:49', '2020-01-29 16:50:12', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2020-01-29 09:08:49', '2020-05-31 19:26:50', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2020-01-29 09:08:49', '2020-11-13 05:40:50', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2020-01-29 09:08:49', '2020-11-13 05:40:50', 'voyager.bread.index', NULL),
(10, 1, 'Cài đặt hệ thống', '', '_self', 'voyager-settings', '#000000', 5, 8, '2020-01-29 09:08:49', '2020-11-13 05:40:50', 'voyager.settings.index', 'null'),
(11, 1, 'Danh mục sản phẩm', '', '_self', 'voyager-categories', '#000000', 19, 1, '2020-01-29 09:08:49', '2020-04-19 02:22:42', 'voyager.categories.index', 'null'),
(14, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 5, '2020-01-29 09:08:50', '2020-11-13 05:40:50', 'voyager.hooks', NULL),
(16, 1, 'Thương hiệu', '', '_self', 'voyager-company', '#000000', 19, 2, '2020-01-29 18:16:18', '2020-05-29 20:06:23', 'voyager.brands.index', 'null'),
(19, 1, 'Sản phẩm', '', '_self', 'voyager-helm', '#000000', NULL, 3, '2020-01-29 18:34:54', '2020-11-13 05:40:55', NULL, ''),
(20, 1, 'Người dùng', '', '_self', 'voyager-github', '#000000', NULL, 4, '2020-01-29 23:14:26', '2020-11-13 05:40:55', NULL, ''),
(21, 1, 'Trạng thái đơn hàng', '', '_self', 'voyager-info-circled', '#000000', 5, 6, '2020-01-30 00:00:44', '2020-11-13 05:40:50', 'voyager.order-statuses.index', 'null'),
(23, 1, 'Danh sách Đơn hàng', '', '_self', 'voyager-basket', '#000000', 24, 1, '2020-01-30 00:05:19', '2020-11-13 05:41:20', 'voyager.orders.index', 'null'),
(24, 1, 'Đơn hàng', '', '_self', 'voyager-bag', '#000000', NULL, 2, '2020-01-30 00:06:29', '2020-07-06 23:47:48', NULL, ''),
(26, 1, 'P.Thức Thanh toán', '', '_self', 'voyager-code', '#000000', 5, 7, '2020-01-30 01:10:13', '2020-11-13 05:40:50', 'voyager.payment-methods.index', 'null'),
(34, 1, 'Sản phẩm', '', '_self', 'voyager-data', '#000000', 19, 3, '2020-05-31 19:26:32', '2020-06-18 22:52:18', 'voyager.products.index', 'null'),
(46, 1, 'Thuộc tính sản phẩm', '', '_self', 'voyager-wand', '#000000', 48, 2, '2020-07-07 21:22:28', '2020-07-07 21:30:59', 'voyager.attributes.index', 'null'),
(47, 1, 'Giá trị của các thuộc tính', '', '_self', 'voyager-wand', '#000000', 48, 1, '2020-07-07 21:23:23', '2020-07-07 21:30:52', 'voyager.attribute-values.index', 'null'),
(48, 1, 'Thuộc tính Sản phẩm', '', '_self', 'voyager-params', '#000000', NULL, 6, '2020-07-07 21:27:56', '2020-11-13 05:40:55', NULL, ''),
(49, 1, 'Khách hàng', '', '_self', 'voyager-people', NULL, 20, 3, '2020-11-04 20:54:53', '2020-11-04 20:55:16', 'voyager.customers.index', NULL),
(50, 1, 'Hóa đơn', '', '_self', 'voyager-bar-chart', NULL, 24, 2, '2020-11-13 05:40:17', '2020-11-13 05:40:55', 'voyager.bills.index', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_01_01_000000_add_voyager_user_fields', 1),
(4, '2016_01_01_000000_create_data_types_table', 1),
(5, '2016_01_01_000000_create_pages_table', 1),
(6, '2016_01_01_000000_create_posts_table', 1),
(7, '2016_02_15_204651_create_categories_table', 1),
(8, '2016_05_19_173453_create_menu_table', 1),
(9, '2016_10_21_190000_create_roles_table', 1),
(10, '2016_10_21_190000_create_settings_table', 1),
(11, '2016_11_30_135954_create_permission_table', 1),
(12, '2016_11_30_141208_create_permission_role_table', 1),
(13, '2016_12_26_201236_data_types__add__server_side', 1),
(14, '2017_01_13_000000_add_route_to_menu_items_table', 1),
(15, '2017_01_14_005015_create_translations_table', 1),
(16, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
(17, '2017_03_06_000000_add_controller_to_data_types_table', 1),
(18, '2017_04_11_000000_alter_post_nullable_fields_table', 1),
(19, '2017_04_21_000000_add_order_to_data_rows_table', 1),
(20, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
(21, '2017_08_05_000000_add_group_to_settings_table', 1),
(22, '2017_11_26_013050_add_user_role_relationship', 1),
(23, '2017_11_26_015000_create_user_roles_table', 1),
(24, '2018_03_11_000000_add_user_settings', 1),
(25, '2018_03_14_000000_add_details_to_data_types_table', 1),
(26, '2018_03_16_000000_make_settings_value_nullable', 1),
(27, '2017_06_26_000000_create_shopping_cart_table', 2),
(28, '2019_08_19_000000_create_failed_jobs_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` tinyint(4) DEFAULT NULL,
  `order_status` tinyint(4) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `subtotal` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `full_name`, `address1`, `address2`, `phone`, `email`, `comment`, `payment_method`, `order_status`, `created_at`, `updated_at`, `subtotal`, `tax`, `total`) VALUES
(1, 1, 'Nguyễn Huỳnh Thành Tánh', 'Địa chỉ 01', 'Địa chỉ 02', 907666448, 'admin@admin.com', NULL, NULL, 4, '2020-08-16 06:48:37', '2020-11-14 07:18:17', '300,000', '30,000', '330,000'),
(2, 1, 'Quản trị viên', 'Địa chỉ 01', '02', 907555484, 'admin@admin.com', NULL, NULL, 4, '2020-08-16 14:34:44', '2020-11-14 09:41:49', '70,000', '7,000', '77,000'),
(3, 1, 'Quản trị viên', 'sdasd', 'hasd', 355640750, 'admin@admin.com', NULL, NULL, 4, '2020-08-25 13:06:30', '2020-11-14 09:43:14', '140,000', '14,000', '154,000'),
(4, 1, 'Quản trị viên', 'Diaj chir', 'Dia chi', 907555444, 'admin@admin.com', NULL, NULL, 4, '2020-09-26 04:45:23', '2020-11-14 09:46:54', '800,000', '80,000', '880,000'),
(5, 1, 'Quản trị viên', '123', '123', 123, 'admin@admin.com', NULL, 1, 4, '2020-11-07 07:06:51', '2020-11-07 07:07:29', '100,000', '10,000', '110,000'),
(6, 1, 'Quản trị viên', '123123', '123123', 123123123, 'admin@admin.com', NULL, NULL, 4, '2020-11-12 02:39:42', '2020-11-15 05:36:33', '150,000', '15,000', '165,000'),
(7, 1, 'Quản trị viên', '212', '1212', 1211212121, 'admin@admin.com', NULL, NULL, 4, '2020-11-12 02:40:01', '2020-11-15 06:34:41', '150,000', '15,000', '165,000'),
(8, 1, 'Quản trị viên', '212', '1212', 1211212121, 'admin@admin.com', NULL, NULL, 1, '2020-11-12 02:41:52', '2020-11-12 02:41:52', '150,000', '15,000', '165,000'),
(9, 1, 'Quản trị viên', '312312', '3123123', 121312312, 'admin@admin.com', NULL, NULL, 4, '2020-11-12 02:42:03', '2020-11-15 06:37:14', '150,000', '15,000', '165,000'),
(10, 1, 'Quản trị viên', '3245654321', '3456543', 34567876, 'admin@admin.com', NULL, NULL, 1, '2020-11-12 02:43:40', '2020-11-12 02:43:40', '111', '11', '122'),
(11, 1, 'Quản trị viên', '123123123', '123123123', 12312312, 'admin@admin.com', NULL, NULL, 1, '2020-11-12 03:36:51', '2020-11-12 03:36:51', '555', '56', '611'),
(12, 1, 'Quản trị viên', '123123123', '123123123', 12312312, 'admin@admin.com', NULL, NULL, 4, '2020-11-12 03:37:59', '2020-11-14 09:48:23', '555', '56', '611');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_attribute_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `quantity`, `product_price`, `product_attribute_id`, `product_name`, `product_sku`, `color`) VALUES
(1, 1, 2, 3, 120000, 8, 'Sơn chống thấm Jotun WaterGuard', '27637dghs3', '#AAD5FF'),
(2, 2, 3, 1, 90000, 9, 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng', 'NTD01', '#55FFAA'),
(3, 4, 11, 1, 1000000, 29, 'Sơn Nippon WeatherGard Plus+', 'nippon-weathergardplus', '#AAFFFF'),
(4, 5, 2, 1, 120000, 8, 'Sơn chống thấm Jotun WaterGuard', '27637dghs3', '#AAFFD5'),
(5, 12, 2, 1, 1111, 35, 'Sơn chống thấm Jotun WaterGuard', '27637dghs3', '#00AAAA'),
(6, 12, 2, 4, 1111, 35, 'Sơn chống thấm Jotun WaterGuard', '27637dghs3', '#FF00FF');

-- --------------------------------------------------------

--
-- Table structure for table `order_statuses`
--

CREATE TABLE `order_statuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_statuses`
--

INSERT INTO `order_statuses` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Đơn hàng mới', '2020-01-30 00:02:00', '2020-04-19 02:29:38'),
(2, 'Đang tiến hành', '2020-01-30 00:02:00', '2020-04-19 02:29:25'),
(3, 'Đã hủy', '2020-01-30 00:02:00', '2020-04-19 02:29:13'),
(4, 'Hoàn thành', '2020-01-30 00:03:00', '2020-04-19 02:29:04');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment_methods`
--

INSERT INTO `payment_methods` (`id`, `code`, `name`, `created_at`, `updated_at`) VALUES
(1, 'COD', 'Cash on delivery', '2020-02-12 00:29:51', '2020-02-12 00:29:51'),
(2, 'ATM', 'Chuyển Khoản', '2020-02-12 00:30:00', '2020-04-19 02:30:07'),
(3, 'CONTRACT', 'Contract', '2020-02-12 00:30:00', '2020-04-19 02:30:29');

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(2, 'browse_bread', NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(3, 'browse_database', NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(4, 'browse_media', NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(5, 'browse_compass', NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(6, 'browse_menus', 'menus', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(7, 'read_menus', 'menus', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(8, 'edit_menus', 'menus', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(9, 'add_menus', 'menus', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(10, 'delete_menus', 'menus', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(11, 'browse_roles', 'roles', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(12, 'read_roles', 'roles', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(13, 'edit_roles', 'roles', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(14, 'add_roles', 'roles', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(15, 'delete_roles', 'roles', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(16, 'browse_users', 'users', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(17, 'read_users', 'users', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(18, 'edit_users', 'users', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(19, 'add_users', 'users', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(20, 'delete_users', 'users', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(21, 'browse_settings', 'settings', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(22, 'read_settings', 'settings', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(23, 'edit_settings', 'settings', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(24, 'add_settings', 'settings', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(25, 'delete_settings', 'settings', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(26, 'browse_categories', 'categories', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(27, 'read_categories', 'categories', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(28, 'edit_categories', 'categories', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(29, 'add_categories', 'categories', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(30, 'delete_categories', 'categories', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(31, 'browse_posts', 'posts', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(32, 'read_posts', 'posts', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(33, 'edit_posts', 'posts', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(34, 'add_posts', 'posts', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(35, 'delete_posts', 'posts', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(41, 'browse_hooks', NULL, '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(47, 'browse_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(48, 'read_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(49, 'edit_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(50, 'add_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(51, 'delete_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(57, 'browse_order_statuses', 'order_statuses', '2020-01-30 00:00:44', '2020-01-30 00:00:44'),
(58, 'read_order_statuses', 'order_statuses', '2020-01-30 00:00:44', '2020-01-30 00:00:44'),
(59, 'edit_order_statuses', 'order_statuses', '2020-01-30 00:00:44', '2020-01-30 00:00:44'),
(60, 'add_order_statuses', 'order_statuses', '2020-01-30 00:00:44', '2020-01-30 00:00:44'),
(61, 'delete_order_statuses', 'order_statuses', '2020-01-30 00:00:44', '2020-01-30 00:00:44'),
(62, 'browse_order', 'order', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(63, 'read_order', 'order', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(64, 'edit_order', 'order', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(65, 'add_order', 'order', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(66, 'delete_order', 'order', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(67, 'browse_orders', 'orders', '2020-01-30 00:05:19', '2020-01-30 00:05:19'),
(68, 'read_orders', 'orders', '2020-01-30 00:05:19', '2020-01-30 00:05:19'),
(69, 'edit_orders', 'orders', '2020-01-30 00:05:19', '2020-01-30 00:05:19'),
(70, 'add_orders', 'orders', '2020-01-30 00:05:19', '2020-01-30 00:05:19'),
(71, 'delete_orders', 'orders', '2020-01-30 00:05:19', '2020-01-30 00:05:19'),
(77, 'browse_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(78, 'read_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(79, 'edit_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(80, 'add_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(81, 'delete_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(87, 'browse_product_attribute', 'product_attribute', '2020-05-29 23:51:00', '2020-05-29 23:51:00'),
(88, 'read_product_attribute', 'product_attribute', '2020-05-29 23:51:00', '2020-05-29 23:51:00'),
(89, 'edit_product_attribute', 'product_attribute', '2020-05-29 23:51:00', '2020-05-29 23:51:00'),
(90, 'add_product_attribute', 'product_attribute', '2020-05-29 23:51:00', '2020-05-29 23:51:00'),
(91, 'delete_product_attribute', 'product_attribute', '2020-05-29 23:51:00', '2020-05-29 23:51:00'),
(97, 'browse_products', 'products', '2020-05-31 19:26:32', '2020-05-31 19:26:32'),
(98, 'read_products', 'products', '2020-05-31 19:26:32', '2020-05-31 19:26:32'),
(99, 'edit_products', 'products', '2020-05-31 19:26:32', '2020-05-31 19:26:32'),
(100, 'add_products', 'products', '2020-05-31 19:26:32', '2020-05-31 19:26:32'),
(101, 'delete_products', 'products', '2020-05-31 19:26:32', '2020-05-31 19:26:32'),
(152, 'browse_attributes', 'attributes', '2020-07-07 21:22:28', '2020-07-07 21:22:28'),
(153, 'read_attributes', 'attributes', '2020-07-07 21:22:28', '2020-07-07 21:22:28'),
(154, 'edit_attributes', 'attributes', '2020-07-07 21:22:28', '2020-07-07 21:22:28'),
(155, 'add_attributes', 'attributes', '2020-07-07 21:22:28', '2020-07-07 21:22:28'),
(156, 'delete_attributes', 'attributes', '2020-07-07 21:22:28', '2020-07-07 21:22:28'),
(157, 'browse_attribute_values', 'attribute_values', '2020-07-07 21:23:23', '2020-07-07 21:23:23'),
(158, 'read_attribute_values', 'attribute_values', '2020-07-07 21:23:23', '2020-07-07 21:23:23'),
(159, 'edit_attribute_values', 'attribute_values', '2020-07-07 21:23:23', '2020-07-07 21:23:23'),
(160, 'add_attribute_values', 'attribute_values', '2020-07-07 21:23:23', '2020-07-07 21:23:23'),
(161, 'delete_attribute_values', 'attribute_values', '2020-07-07 21:23:23', '2020-07-07 21:23:23'),
(162, 'browse_customers', 'customers', '2020-11-04 20:54:53', '2020-11-04 20:54:53'),
(163, 'read_customers', 'customers', '2020-11-04 20:54:53', '2020-11-04 20:54:53'),
(164, 'edit_customers', 'customers', '2020-11-04 20:54:53', '2020-11-04 20:54:53'),
(165, 'add_customers', 'customers', '2020-11-04 20:54:53', '2020-11-04 20:54:53'),
(166, 'delete_customers', 'customers', '2020-11-04 20:54:53', '2020-11-04 20:54:53'),
(167, 'browse_bills', 'bills', '2020-11-13 05:40:16', '2020-11-13 05:40:16'),
(168, 'read_bills', 'bills', '2020-11-13 05:40:16', '2020-11-13 05:40:16'),
(169, 'edit_bills', 'bills', '2020-11-13 05:40:16', '2020-11-13 05:40:16'),
(170, 'add_bills', 'bills', '2020-11-13 05:40:16', '2020-11-13 05:40:16'),
(171, 'delete_bills', 'bills', '2020-11-13 05:40:16', '2020-11-13 05:40:16');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(41, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(87, 1),
(88, 1),
(89, 1),
(90, 1),
(91, 1),
(97, 1),
(98, 1),
(99, 1),
(100, 1),
(101, 1),
(152, 1),
(153, 1),
(154, 1),
(155, 1),
(156, 1),
(157, 1),
(158, 1),
(159, 1),
(160, 1),
(161, 1),
(162, 1),
(163, 1),
(164, 1),
(165, 1),
(166, 1),
(167, 1),
(168, 1),
(169, 1),
(170, 1),
(171, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) DEFAULT NULL,
  `brand_id` int(10) DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` bit(64) NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `sold` int(11) DEFAULT 0,
  `view` int(11) DEFAULT NULL,
  `date_lastview` datetime NOT NULL,
  `date_available` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `stock` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `brand_id`, `name`, `sku`, `seo_title`, `excerpt`, `body`, `avatar`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `sold`, `view`, `date_lastview`, `date_available`, `created_at`, `updated_at`, `stock`) VALUES
(2, 3, 1, 'Sơn chống thấm Jotun WaterGuard', '27637dghs3', NULL, 'Jotun Waterguard là sản phẩm sơn chống thấm gốc nước giúp bảo vệ tường nhà, ngăn chặn sự thấm nước, đặc biệt trong mùa mưa và khi thời tiết có độ ẩm cao, đảm bảo màng sơn được bảo vệ, không bị hư hại, giảm chi phí bảo dưỡng. Sản phẩm có khả năng che phủ vết nứt nhỏ, ngăn chặn nước thâm nhập vào bên trong. Đây là sản phẩm sơn 1 thành phần, không cần pha trộn với xi măng và dễ sử dụng giúp tiết kiệm chi phí thi công. Waterguard có khả năng ngăn chặn sự phát triển của nấm mốc, đảm bảo bề mặt tường luôn sạch và đẹp.', '<p>...</p>', 'products\\September2020\\Qo2Fu31Mwt4k5hYyoguU.jpg', 'son-chong-tham-jotun-waterguard', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', b'0000000000000000000000000000000000000000000000000000000000000001', 0, 13, 338, '2020-11-12 04:10:33', '2020-11-12 04:10:33', '2020-01-29 16:08:00', '2020-11-13 12:16:42', 33),
(3, 3, 1, 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng', 'NTD01', 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng', 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng với Công nghệ Superflexx tiên tiến cho màng sơn linh hoạt co giãn gấp 3 lần so với các loại sơn nội thất cao cấp trên thị trường, giúp che phủ các vết rạn nứt nhỏ và bảo vệ màng sơn luôn bền đẹp', '<h1>Giới thiệu sản phẩm</h1>\r\n<p>Dulux Ambiance 5in1 Superflexx - Si&ecirc;u B&oacute;ng với C&ocirc;ng nghệ Superflexx ti&ecirc;n tiến cho m&agrave;ng sơn linh hoạt co gi&atilde;n gấp 3 lần so với c&aacute;c loại sơn nội thất cao cấp tr&ecirc;n thị trường, gi&uacute;p che phủ c&aacute;c vết rạn nứt nhỏ v&agrave; bảo vệ m&agrave;ng sơn lu&ocirc;n bền đẹp</p>\r\n<p>&nbsp;</p>\r\n<h1>Hướng dẫn thi c&ocirc;ng</h1>\r\n<p>Sơn bằng cọ hoặc rul&ocirc; hoặc m&aacute;y phun sơn</p>\r\n<p>&nbsp;</p>\r\n<h1>Th&ocirc;ng Tin Về An To&agrave;n, Sức Khỏe V&agrave; M&ocirc;i Trường</h1>\r\n<p>Hazard warnings</p>\r\n<p>- C&aacute;c xử l&yacute; như: xả nh&aacute;m, đốt m&agrave;ng sơn sẽ tạo bụi v&agrave;/hoặc kh&oacute;i độc. N&ecirc;n xả nh&aacute;m ướt nếu c&oacute; thể. L&agrave;m việc trong khu vực th&ocirc;ng tho&aacute;ng. Sử dụng đồ bảo hộ th&iacute;ch hợp khi thi c&ocirc;ng. - Mang găng tay v&agrave; k&iacute;nh bảo vệ mắt - Tr&aacute;nh h&iacute;t hơi/bụi sơn - Chỉ thi c&ocirc;ng tại khu vực th&ocirc;ng tho&aacute;ng. - Lấy lại lượng sơn c&ograve;n dư tr&ecirc;n cọ hoặc rul&ocirc; c&agrave;ng nhiều c&agrave;ng tốt trước khi rửa. - Tr&aacute;nh thải sơn ra m&ocirc;i trường. - Thu gom tr&agrave;n đổ. - Tr&aacute;nh xa nguồn thực phẩm, nước uống v&agrave; thức ăn động vật - Khi bị d&iacute;nh sơn v&agrave;o mắt, lập tức rửa mắt với nhiều nước sạch v&agrave; đến gặp b&aacute;c sĩ ngay. - Khi bị d&iacute;nh sơn v&agrave;o da, lập tức rửa v&ugrave;ng phơi nhiễm với x&agrave; ph&ograve;ng/ sản phẩm l&agrave;m sạch da ph&ugrave; hợp v&agrave; nước sạch. Kh&ocirc;ng sử dụng dung m&ocirc;i. - Kh&ocirc;ng đổ sơn v&agrave;o cống r&atilde;nh hay nguồn nước. - Th&ocirc;ng tin an to&agrave;n sản phẩm được cung cấp theo y&ecirc;u cầu sử dụng. - Để xa tầm tay trẻ em. - Mang theo th&ugrave;ng sơn hoặc nh&atilde;n sản phẩm khi cần tư vấn y khoa. - Tr&aacute;nh tiếp x&uacute;c với mắt, da hoặc l&ecirc;n quần &aacute;o. - Nếu cảm thấy kh&ocirc;ng khỏe, h&atilde;y gọi cho TRUNG T&Acirc;M CHỐNG ĐỘC hoặc b&aacute;c sĩ. - Thải bỏ sơn v&agrave; th&ugrave;ng chứa ph&ugrave; hợp với c&aacute;c quy định địa phương, khu vực, quốc gia v&agrave; quốc tế.</p>\r\n<p><img src=\"http://sonthanhtanh.com/storage/products/January2020/Screenshot (1).png\" alt=\"\" width=\"949\" height=\"534\" /></p>', 'products\\September2020\\DOdz2vNMQHC1b2EZLP3y.jpg', 'dulux-ambiance-5in1-superflexx-sieu-bong', 'This is the meta description', 'dulux, Superflexx', b'0000000000000000000000000000000000000000000000000000000000000001', 1, 4, 169, '2020-09-27 07:45:21', '2020-09-27 07:45:21', '2020-01-29 16:08:00', '2020-11-12 04:15:40', 4),
(4, 3, 2, 'Sơn Lót Nội Thất Odour-less Sealer', 'odour-less-sealer', 'Sơn Lót Nội Thất Odour-less Sealer', 'Sơn Nippon ODOUR-LESS SEALER là loại sơn lót nội thất gốc nước rất thân thiện với môi trường, đạt chuẩn Green Label của Singapore, thích hợp sử dụng cho phần xây nề. Được pha chế đặc biệt, ODOUR~LESS SEALER có khả năng ngăn cản hữu hiệu sự xuống cấp của lớp sơn cuối do chất kiềm trong xi măng gây ra.', '<p style=\"box-sizing: border-box; margin: 0px 0px 15px; color: #000000; font-family: averta-400; font-size: 16px;\"><span style=\"box-sizing: border-box; font-family: averta-600;\">Đặc điểm:</span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 15px; color: #000000; font-family: averta-400; font-size: 16px;\">- Chống kiềm h&oacute;a cao<br style=\"box-sizing: border-box;\" />- Chống lại sự&nbsp; phai m&agrave;u của lớp sơn phủ do c&aacute;c h&oacute;a chất trong xi măng g&acirc;y ra.<br style=\"box-sizing: border-box;\" />- Độ b&aacute;m d&iacute;nh tốt.<br style=\"box-sizing: border-box;\" />- Khả năng chống r&ecirc;u v&agrave; nấm cao.<br style=\"box-sizing: border-box;\" />- Kh&ocirc; nhanh, rất thuận tiện để thi c&ocirc;ng lớp kế tiếp.<br style=\"box-sizing: border-box;\" />- Dễ sử dụng</p>', 'products\\September2020\\vHHnuSV0dGdU2YztkSTK.jpg', 'son-lot-noi-that-odour-less-sealer', 'Sơn Lót Nội Thất Odour-less Sealer', 'keyword1, keyword2, keyword3', b'0000000000000000000000000000000000000000000000000000000000000001', 1, 1, 50, '2020-09-30 14:42:04', '2020-09-30 14:42:04', '2020-01-29 16:08:00', '2020-11-12 02:37:44', 6),
(5, 5, 1, 'Sơn Delux 00224 - Chống thấm tuyệt đối', 'DEMC04', NULL, '123', '<p><strong>123</strong></p>', 'products\\February2020\\4Vn7XEfJuUnek3UtI9f4.png', '123', NULL, NULL, b'0000000000000000000000000000000000000000000000000000000000000001', 1, 7, 22, '2020-09-08 09:40:44', '2020-09-08 09:40:44', '2020-02-24 06:52:26', '2020-11-12 02:35:42', 15),
(7, 3, 1, 'Product 5', '27637dghsu4', NULL, 'This is the excerpt for the sample Post', '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>Sơn chống thấm Jotun WaterGuard bảo vệ tường khỏi sự x&acirc;m nhập của nước. Với c&ocirc;n thức chống thấm ti&ecirc;n tiến gi&uacute;p ngăn chặn sự thấm nước, sự ph&aacute;t triển của nấm mốc v&agrave; bảo vệ m&agrave;ng sơn kh&ocirc;ng bị hư hại.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>Sơn chống thấm Jotun WaterGuard l&agrave; sản phẩm sơn chống thấm gốc arcylic biến t&iacute;nh, ph&ugrave; hợp để sơn những bề mặt b&ecirc; t&ocirc;ng v&agrave; tường t&ocirc; vữa ngo&agrave;i trời.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>ƯU ĐIỂM NỔI BẬT:&nbsp;&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Chống thấm tối ưu: tường nh&agrave; được bảo vệ ngăn chặn sự thấm nước, đảm bảo m&agrave;ng sơn lu&ocirc;n đẹp theo thời gian</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Độ đ&agrave;n hồi cao: che phủ vết nứt nhỏ, ngăn nước thấm v&agrave;o tường.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Dễ thi c&ocirc;ng: sản phẩm kh&ocirc;ng cần pha với xi măng v&agrave; dễ sử dụng.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Đ&oacute;ng g&oacute;i: 6kg, 20kg</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>M&Agrave;U SẮC:&nbsp; X&aacute;m đậm v&agrave; x&aacute;m nhạt</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>TH&Agrave;NH PHẦN: Nhựa gốc Acrylic &amp; bột kho&aacute;ng (81-89%), chất phụ gia (3-7%), nước (8-12%).</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>THỜI GIAN KH&Ocirc;: 1-2 giờ</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>ĐỘ PHỦ L&Yacute; THUYẾT: 4-5m2/kg/lớp t&ugrave;y thuộc độ d&agrave;y m&agrave;ng sơn v&agrave; bề mặt tường (đ&aacute;nh gi&aacute; dựa tr&ecirc;n ti&ecirc;u chuẩn JIS K5600:1999).</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>CHUẨN BỊ BỀ MẶT:</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Bề mặt đuợc sơn phải sạch, kh&ocirc; v&agrave; ổn định. M&agrave;ng sơn cũ, chất bẩn, vữa, r&ecirc;u mốc phải được tẩy sạch bằng phương ph&aacute;p th&iacute;ch hợp. D&ugrave;ng h&oacute;a chất tẩy rửa v&agrave; diệt r&ecirc;u mốc th&iacute;ch hợp để rửa sạch c&aacute;c khu vực bị nấm mốc hay rong r&ecirc;u. Bề mặt qu&aacute; kh&ocirc; v&agrave; c&aacute;c bề mặt h&uacute;t nước cần được l&agrave;m ẩm bằng c&aacute;ch lăn rul&ocirc; được l&agrave;m ẩm với nước sạch trước khi thi c&ocirc;ng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Thi c&ocirc;ng 3 lớp đối với c&aacute;c bề mặt c&oacute; vết nứt nhỏ. C&aacute;c khe nứt lớn cần phải đục rộng h&igrave;nh chữ V, l&agrave;m sạch bụi v&agrave; tr&eacute;t lại bằng hỗn hợp 5 c&aacute;t + 3 xi măng thường + 0.8 Jotun WaterGuard&nbsp; &nbsp;&ndash; chất chống thấm trước khi thi c&ocirc;ng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>THI C&Ocirc;NG</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Khuấy đều trước khi sử dụng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Dễ thi c&ocirc;ng, sản phẩm kh&ocirc;ng cần pha với xi măng v&agrave; dễ sử dụng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>Dụng cụ thi c&ocirc;ng:</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Thi c&ocirc;ng lớp 2: 6-8 tiếng sau khi thi c&ocirc;ng lớp 1</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Rửa sạch dụng cụ với nước sạch trước v&agrave; sau khi sử dụng.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>Lưu &yacute;: Kh&ocirc;ng thi c&ocirc;ng khi trời mưa hoặc trong m&ocirc;i trường ẩm ướt để đạt t&iacute;nh thẩm mỹ của bề mặt sau khi ho&agrave;n thiện v&agrave; kết quả chống thấm tốt nhất</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>BẢO QUẢN</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Bảo quản sơn ở nơi kh&ocirc;, m&aacute;t.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Đặt th&ugrave;ng sơn ở vị tr&iacute; thẳng đứng an to&agrave;n v&agrave; đậy chặt nắp.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; D&ugrave;ng ngay sau khi mở nắp</strong></span></span></p>', 'products\\April2020\\J3R3nbodXHmoAe9bt79C.jpg', 'my-sample-post-23-ghgghs-uyuy-ad-iqywuie-quuyeu-ad-que-ad-que-5', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', b'0000000000000000000000000000000000000000000000000000000000000001', 1, 2, 11, '2020-08-30 01:36:51', '2020-08-30 01:36:51', '2020-01-29 16:08:00', '2020-11-12 02:37:01', 50),
(8, 3, 1, 'Product 6', '27637dghsu', NULL, 'This is the excerpt for the sample Post', '<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>Sơn chống thấm Jotun WaterGuard bảo vệ tường khỏi sự x&acirc;m nhập của nước. Với c&ocirc;n thức chống thấm ti&ecirc;n tiến gi&uacute;p ngăn chặn sự thấm nước, sự ph&aacute;t triển của nấm mốc v&agrave; bảo vệ m&agrave;ng sơn kh&ocirc;ng bị hư hại.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>Sơn chống thấm Jotun WaterGuard l&agrave; sản phẩm sơn chống thấm gốc arcylic biến t&iacute;nh, ph&ugrave; hợp để sơn những bề mặt b&ecirc; t&ocirc;ng v&agrave; tường t&ocirc; vữa ngo&agrave;i trời.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>ƯU ĐIỂM NỔI BẬT:&nbsp;&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Chống thấm tối ưu: tường nh&agrave; được bảo vệ ngăn chặn sự thấm nước, đảm bảo m&agrave;ng sơn lu&ocirc;n đẹp theo thời gian</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Độ đ&agrave;n hồi cao: che phủ vết nứt nhỏ, ngăn nước thấm v&agrave;o tường.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Dễ thi c&ocirc;ng: sản phẩm kh&ocirc;ng cần pha với xi măng v&agrave; dễ sử dụng.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Đ&oacute;ng g&oacute;i: 6kg, 20kg</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>M&Agrave;U SẮC:&nbsp; X&aacute;m đậm v&agrave; x&aacute;m nhạt</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>TH&Agrave;NH PHẦN: Nhựa gốc Acrylic &amp; bột kho&aacute;ng (81-89%), chất phụ gia (3-7%), nước (8-12%).</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>THỜI GIAN KH&Ocirc;: 1-2 giờ</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>ĐỘ PHỦ L&Yacute; THUYẾT: 4-5m2/kg/lớp t&ugrave;y thuộc độ d&agrave;y m&agrave;ng sơn v&agrave; bề mặt tường (đ&aacute;nh gi&aacute; dựa tr&ecirc;n ti&ecirc;u chuẩn JIS K5600:1999).</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>CHUẨN BỊ BỀ MẶT:</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Bề mặt đuợc sơn phải sạch, kh&ocirc; v&agrave; ổn định. M&agrave;ng sơn cũ, chất bẩn, vữa, r&ecirc;u mốc phải được tẩy sạch bằng phương ph&aacute;p th&iacute;ch hợp. D&ugrave;ng h&oacute;a chất tẩy rửa v&agrave; diệt r&ecirc;u mốc th&iacute;ch hợp để rửa sạch c&aacute;c khu vực bị nấm mốc hay rong r&ecirc;u. Bề mặt qu&aacute; kh&ocirc; v&agrave; c&aacute;c bề mặt h&uacute;t nước cần được l&agrave;m ẩm bằng c&aacute;ch lăn rul&ocirc; được l&agrave;m ẩm với nước sạch trước khi thi c&ocirc;ng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&ndash; Thi c&ocirc;ng 3 lớp đối với c&aacute;c bề mặt c&oacute; vết nứt nhỏ. C&aacute;c khe nứt lớn cần phải đục rộng h&igrave;nh chữ V, l&agrave;m sạch bụi v&agrave; tr&eacute;t lại bằng hỗn hợp 5 c&aacute;t + 3 xi măng thường + 0.8 Jotun WaterGuard&nbsp; &nbsp;&ndash; chất chống thấm trước khi thi c&ocirc;ng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>THI C&Ocirc;NG</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 16px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Khuấy đều trước khi sử dụng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Dễ thi c&ocirc;ng, sản phẩm kh&ocirc;ng cần pha với xi măng v&agrave; dễ sử dụng</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>Dụng cụ thi c&ocirc;ng:</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Thi c&ocirc;ng lớp 2: 6-8 tiếng sau khi thi c&ocirc;ng lớp 1</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Rửa sạch dụng cụ với nước sạch trước v&agrave; sau khi sử dụng.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>Lưu &yacute;: Kh&ocirc;ng thi c&ocirc;ng khi trời mưa hoặc trong m&ocirc;i trường ẩm ướt để đạt t&iacute;nh thẩm mỹ của bề mặt sau khi ho&agrave;n thiện v&agrave; kết quả chống thấm tốt nhất</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>BẢO QUẢN</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Bảo quản sơn ở nơi kh&ocirc;, m&aacute;t.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; Đặt th&ugrave;ng sơn ở vị tr&iacute; thẳng đứng an to&agrave;n v&agrave; đậy chặt nắp.</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&nbsp;</strong></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 10px; padding: 0px;\"><span style=\"color: #333333; font-family: Open Sans;\"><span style=\"font-size: 13px;\"><strong>&ndash; D&ugrave;ng ngay sau khi mở nắp</strong></span></span></p>', 'products\\November2020\\ilHgXRD6A1XtzuZzXpWO.jpg', 'my-sample-post-23-ghgghs-uyuy-ad-iqywuie-quuyeu-ad-que-ad-que-6', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', b'0000000000000000000000000000000000000000000000000000000000000001', 1, 2, 17, '2020-11-06 04:36:34', '2020-11-06 04:36:34', '2020-01-29 16:08:00', '2020-11-06 04:36:37', 0),
(9, 3, 1, 'Sơn Chống Thấm Dulux Weathershield 20KG', 'son-chong-tham-dulux-weathershield-20kg', 'Sơn Chống Thấm Dulux Weathershield 20KG', 'Chống thấm vượt ,  Độ bám dính, bền vững , Không độc hại, đảm bảo an .', '<div class=\"product-short-description\">\r\n<h2>Sơn Chống Thấm Dulux Weathershield 20KG</h2>\r\n<ul>\r\n<li>Chống thấm vượt trội: M&agrave;ng sơn c&oacute; t&iacute;nh năng chống thấm vượt trội với bề mặt đanh chắc c&oacute; được v&igrave; những cấu tạo từ c&aacute;c hợp chất đặc biệt, được sử dụng l&agrave;m chất chống thấm v&ocirc; c&ugrave;ng hiệu quả.</li>\r\n<li>Độ b&aacute;m d&iacute;nh, bền vững cao: Sơn chống thấm th&iacute;ch hợp cho tường b&ecirc; t&ocirc;ng, nền nh&agrave;, xi măng v&agrave; ch&uacute;ng đều c&oacute; độ bền vững đ&atilde; được thử nghiệm ở c&aacute;c to&agrave; n<span class=\"text_exposed_show\">h&agrave; cao tầng.<br /></span></li>\r\n<li><span class=\"text_exposed_show\">Kh&ocirc;ng độc hại, đảm bảo an to&agrave;n: Kh&ocirc;ng th&ecirc;m ch&igrave;, kh&ocirc;ng th&ecirc;m thủy ng&acirc;n</span></li>\r\n</ul>\r\n<p>Mọi chi tiết xin li&ecirc;n hệ :<a href=\"http://0978148000\">0978148000</a></p>\r\n</div>', 'products\\April2020\\ZH6RdLTIlUT1QXsk2GRh.jpg', 'son-chong-tham-dulux-weathershield-20kg', NULL, 'sơn chống thấm, sơn delux', b'0000000000000000000000000000000000000000000000000000000000000001', 1, 0, 64, '2020-07-23 14:09:16', '2020-07-23 14:09:16', '2020-04-21 13:35:23', '2020-08-02 12:35:44', 0),
(10, 14, 4, 'Sơn Nippon Tilac', 'son-nippon-tilac', 'Sơn Nippon Tilac', 'TILAC là loại sơn dầu gốc Alkyd, một thành phần, có độ bền cao. TILAC được sử dụng làm lớp sơn phủ cho các bề mặt gỗ và kim loại, nội và ngoại thất.', '<ul>\r\n<li><span style=\"box-sizing: border-box; font-weight: normal; font-family: averta-600; color: #000000; font-size: 16px;\">Đặc điểm:</span><br style=\"box-sizing: border-box; color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\" /><span style=\"color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\">- Kinh tế v&agrave; dễ sử dụng<br /></span><span style=\"color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\">- C&oacute; đặc t&iacute;nh chống ăn m&ograve;n, hiệu quả cao hơn khi kết hợp với lớp sơn l&oacute;t</span><br style=\"box-sizing: border-box; color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\" /><span style=\"color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\">- M&agrave;ng sơn c&oacute; độ bền cao</span><br style=\"box-sizing: border-box; color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\" /><span style=\"color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\">- Độ b&aacute;m d&iacute;nh rất tốt tr&ecirc;n nhiều bề mặt</span><br style=\"box-sizing: border-box; color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\" /><span style=\"color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\">- M&agrave;ng sơn phẳng mịn</span><br style=\"box-sizing: border-box; color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\" /><span style=\"color: #000000; font-family: averta-400; font-size: 16px; font-weight: 400;\">- Thời gian kh&ocirc; ngắn hơn so với c&aacute;c loại sơn tương tự kh&aacute;c</span></li>\r\n</ul>', 'products\\September2020\\4EiqXBnF8Lmh7o8VD9Ox.jpg', 'son-nippon-tilac', 'Sơn Nippon Tilac', 'Sơn Nippon Tilac', b'0000000000000000000000000000000000000000000000000000000000000001', 1, 46, 646, '2020-09-25 07:23:56', '2020-09-25 07:23:56', '2020-04-21 13:47:06', '2020-11-07 07:24:03', 22),
(11, 7, 4, 'Sơn Nippon WeatherGard Plus+', 'nippon-weathergardplus', NULL, 'Nippon WEATHERGARD PLUS+ là loại sơn nước ngoại thất cao cấp có độ bền cao, có khả năng chống thấm nước từ bên ngoài và chống bám bụi tuyệt vời', '<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"text-decoration: underline;\"><span style=\"box-sizing: border-box; font-family: averta-600;\">Đặc điểm:</span><span style=\"color: #000000; font-family: averta-600; text-decoration: underline;\"><span style=\"font-size: 18px;\"> 2-3 lớp</span></span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">- L&agrave; loại sơn nước chịu thời tiết tuyệt vời với độ bền m&agrave;u cao.<br style=\"box-sizing: border-box;\" />- Chống b&aacute;m bụi tuyệt vời.<br style=\"box-sizing: border-box;\" />- M&agrave;ng sơn c&oacute; khả năng ngăn chặn sự thấm nước từ b&ecirc;n ngo&agrave;i &amp; chịu ch&ugrave;i rửa tốt.<br style=\"box-sizing: border-box;\" />- Hạn chế dấu vệt nước hữu hiệu.<br style=\"box-sizing: border-box;\" />- Phản xạ phần lớn tia hồng ngoại, l&agrave;m giảm nhiệt độ bề mặt v&agrave; kh&ocirc;ng gian b&ecirc;n trong do&nbsp;đ&oacute; gi&uacute;p tiết kiệm điện năng cho c&aacute;c thiết bị l&agrave;m m&aacute;t như: m&aacute;y điều h&ograve;a nhiệt độ ...<br style=\"box-sizing: border-box;\" />- T&iacute;nh năng chống r&ecirc;u, mốc rất tốt.<br style=\"box-sizing: border-box;\" />- Khả năng chống kiềm h&oacute;a v&agrave; muối h&oacute;a cao.<br style=\"box-sizing: border-box;\" />- Độ b&aacute;m d&iacute;nh rất tốt tr&ecirc;n c&aacute;c bề mặt ổn định.<br style=\"box-sizing: border-box;\" />- Dễ thi c&ocirc;ng v&agrave; m&agrave;ng sơn phẳng mịn.<br style=\"box-sizing: border-box;\" />- H&agrave;m lượng chất hữu cơ bay hơi r&acirc;t thấp (nhỏ hơn 30g/L VOC, đ&aacute;p ứng y&ecirc;u cầu an to&agrave;n về m&ocirc;i trường).<br style=\"box-sizing: border-box;\" />- Kh&ocirc;ng độc hại, kh&ocirc;ng chứa APEO, kh&ocirc;ng chứa ch&igrave;, thủy ng&acirc;n v&agrave; c&aacute;c kim loại nặng.</p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"text-decoration: underline;\"><strong><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">Dữ liệu thi c&ocirc;ng:</span></span></strong></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">- Dụng cụ: D&ugrave;ng cọ qu&eacute;t, con lăn hay s&uacute;ng phun kh&ocirc;ng c&oacute; kh&iacute;.</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">- Pha lo&atilde;ng:&nbsp;Cọ qu&eacute;t, con lăn: tối đa 10%, </span></span><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">Phun kh&ocirc;ng c&oacute; kh&iacute;: tối đa 5%.</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">-Thời gian kh&ocirc;:&nbsp;30 ph&uacute;t ở 30&ordm;C.</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">-&nbsp;Thời gian chuyển tiếp:&nbsp; 2 giờ.</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">-&nbsp;Độ d&agrave;y m&agrave;ng sơn y&ecirc;u cầu:&nbsp;10.0 m2/ L&iacute;t ( Độ d&agrave;y m&agrave;ng sơn kh&ocirc; 40 micron).</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">-&nbsp;Ho&agrave;n thiện:&nbsp;B&oacute;ng mờ.</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"color: #000000; font-family: averta-400;\"><span style=\"font-size: 18px;\">- Đ&oacute;ng g&oacute;i: 1 L&iacute;t, 5 L&iacute;t &amp; 18 L&iacute;t.</span></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\"><span style=\"text-decoration: underline;\"><strong><span style=\"font-family: averta-400;\"><span style=\"font-size: 18px;\">Hệ thống sơn đề nghị</span></span></strong></span></p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>\r\n<table style=\"border-collapse: collapse; width: 100%; height: 58px;\" border=\"1\">\r\n<tbody>\r\n<tr style=\"height: 12px;\">\r\n<td style=\"width: 33.3333%; height: 10px;\"><strong>Loại</strong></td>\r\n<td style=\"width: 33.3333%; height: 10px;\"><strong>T&ecirc;n sản phẩm</strong></td>\r\n<td style=\"width: 33.3333%; height: 10px;\"><strong>Số lớp</strong></td>\r\n</tr>\r\n<tr style=\"height: 12px;\">\r\n<td style=\"width: 33.3333%; height: 12px;\">Bột tr&eacute;t</td>\r\n<td style=\"width: 33.3333%; height: 12px;\">WeatherGard Skimcoat</td>\r\n<td style=\"width: 33.3333%; height: 12px;\">2 - 3 lớp</td>\r\n</tr>\r\n<tr style=\"height: 12px;\">\r\n<td style=\"width: 33.3333%; height: 12px;\">Sơn l&oacute;t</td>\r\n<td style=\"width: 33.3333%; height: 12px;\">WeatherGard Sealer</td>\r\n<td style=\"width: 33.3333%; height: 12px;\">2 lớp</td>\r\n</tr>\r\n<tr style=\"height: 12px;\">\r\n<td style=\"width: 33.3333%; height: 12px;\">Sơn phủ</td>\r\n<td style=\"width: 33.3333%; height: 12px;\">Sơn Nippon WeatherGard Plus+</td>\r\n<td style=\"width: 33.3333%; height: 12px;\">2 lớp</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>\r\n<p style=\"box-sizing: border-box; margin: 0in 0in 0.0001pt; color: #000000; font-family: averta-400; font-size: 18px; text-align: justify;\">&nbsp;</p>', 'products\\September2020\\YtN1RExJd7yjOLFYfoK1.jpg', 'son-nippon-weathergard-plus', NULL, NULL, b'0000000000000000000000000000000000000000000000000000000000000001', 1, 3, 61, '2020-11-06 04:35:28', '2020-11-06 04:35:28', '2020-08-16 01:55:17', '2020-11-06 04:35:28', 69);
INSERT INTO `products` (`id`, `category_id`, `brand_id`, `name`, `sku`, `seo_title`, `excerpt`, `body`, `avatar`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `sold`, `view`, `date_lastview`, `date_available`, `created_at`, `updated_at`, `stock`) VALUES
(12, 15, 4, 'Sơn Chống Cháy Nội Thất Taikalitt S-100 NCB Intumescent', 'taikalitt-s-100-ncb', NULL, 'Là sơn cách nhiệt acrylic intumescent một thành phần, cú khả năng chống cháy tuyệt vời, bề mặt màng sơn đẹp và dễ thi cụng. Được thiết kế cho những kết cấu thép nội thất ở các sân bay, nhà ga, sân vận động, tòa nhà cao tầng hay ở các nhà máy có yêu cầu chống cháy. Sản phẩm đã được chứng nhận bởi CCCF và JSSC', '<p><strong>Đặc T&iacute;nh Vật L&yacute;:</strong></p>\r\n<p>M&agrave;u: Trắng&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n<p>Tỉ trọng: 1.29 kg/l (23&deg;C)</p>\r\n<p>H&agrave;m lượng rắn theo thể t&iacute;ch: 64 &plusmn; 2 %</p>\r\n<p>Độ d&agrave;y m&agrave;ng sơn ti&ecirc;u biểu:</p>\r\n<p>- 0.9 mm (thời gian chống ch&aacute;y&gt;1 giờ)</p>\r\n<p>- 1.25 mm (thời gian chống ch&aacute;y&gt;1.5 giờ)</p>\r\n<p>Độ phủ l&yacute; thuyết: 1.21kg/m2(độ d&agrave;y m&agrave;ng sơn kh&ocirc; 600 micron)</p>\r\n<p>&nbsp;</p>\r\n<p>Kh&ocirc; bề mặt: 3 giờ (23&deg;C)</p>\r\n<p>Kh&ocirc; để xử l&yacute;: 12 giờ (23&deg;C)</p>\r\n<p>Khụ ho&agrave;n to&agrave;n: 28 ng&agrave;y (23&deg;C)</p>\r\n<p>&nbsp;</p>\r\n<p>Chuẩn bị bề mặt&nbsp; &nbsp;&nbsp;</p>\r\n<p>Bề mặt phải được thổi hạt tối thiểu đạt ti&ecirc;u chuẩn Sa2.5, tạo độ nh&aacute;m theo ti&ecirc;u chuẩn Rugotest NO.3 BN9a.</p>\r\n<p>Cần sơn l&oacute;t chống ăn m&ograve;n trước khi sơn NCB-TAIKALITT S-100.</p>\r\n<p>Tất cả c&aacute;c bề mặt cần phải được l&agrave;m sạch, khụ, khụng nhiễm dầu, mỡ, chất kh&ocirc;ng ổn định v&agrave; kh&ocirc;ng c&oacute; c&aacute;c sự nhiễm bẩn kh&aacute;c.</p>\r\n<p>&nbsp;</p>\r\n<p>Hướng dẫn thi c&ocirc;ng&nbsp; &nbsp;&nbsp;</p>\r\n<p>&nbsp;</p>\r\n<p>Khuấy trộn: khuấy đều bằng m&aacute;y trong v&ograve;ng 15 ph&uacute;t trước khi sử dụng&nbsp; &nbsp;&nbsp;</p>\r\n<p>Dung m&ocirc;i pha lo&atilde;ng: 0920 thinner&nbsp; &nbsp;&nbsp;</p>\r\n<p>Phương Ph&aacute;p Thi C&ocirc;ng:</p>\r\n<p>Cọ qu&eacute;t (đề nghị), s&uacute;ng phun c&oacute; kh&iacute; (c&oacute; thể), s&uacute;ng phun kh&ocirc;ng c&oacute; kh&iacute; (đề nghị)</p>\r\n<p>Pha Lo&atilde;ng:</p>\r\n<p>- Cọ qu&eacute;t &amp; con lăn: tối đa 10%</p>\r\n<p>- Phun c&oacute; kh&iacute;: tối đa 15-30%</p>\r\n<p>- Phun kh&ocirc;ng c&oacute; kh&iacute;: tối đa 10%</p>\r\n<p>Phun kh&ocirc;ng c&oacute; kh&iacute;: &Aacute;p suất v&ograve;i phun, 140 &ndash; 180 kg/cm2. K&iacute;ch thước v&ograve;i phun, 0.43 -0.53 mm (0.017-0.021&rdquo;)&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n<p>Phun c&oacute; kh&iacute;: Pha lo&atilde;ng bằng 0920 Thinner đến độ nhớt 17-23 gi&acirc;y (T-4/23&deg;C)&nbsp; &nbsp; &nbsp; &nbsp;&nbsp;</p>\r\n<p>Thời gian sơn lớp kế tiếp:</p>\r\n<p>- Nhiệt độ thi c&ocirc;ng 10&deg;C: Tối thiểu 24 giờ</p>\r\n<p>- Nhiệt độ thi c&ocirc;ng 23&deg;C: Tối thiểu 12 giờ</p>\r\n<p>- Nhiệt độ thi c&ocirc;ng 40&deg;C: Tối thiểu 8 giờ</p>\r\n<p>*&nbsp; &nbsp; Trong trường hợp để l&acirc;u b&ecirc;n ngo&agrave;i trong thời gian d&agrave;i hoặc bị nhiễm bẩn, cần l&agrave;m sạch với nước &aacute;p lực thấp để đảm bảo độ b&aacute;m d&iacute;nh cho lớp sơn kết tiếp</p>\r\n<p>Vệ sinh: l&agrave;m sạch tất cả c&aacute;c dụng cụ ngay sau khi sử dụng bằng 0920 thinner</p>\r\n<p>&nbsp;</p>\r\n<p>Khuyến c&aacute;o an to&agrave;n:</p>\r\n<p>&nbsp;</p>\r\n<p>Cẩn thận khi tiếp x&uacute;c, đọc t&agrave;i liệu An To&agrave;n Sản Phẩm trước khi sử dụng.&nbsp; &nbsp;&nbsp;</p>\r\n<p>Ch&uacute; &yacute; những biểu tượng an to&agrave;n tr&ecirc;n bao b&igrave; trước v&agrave; trong qu&aacute; tr&igrave;nh sử dụng, tu&acirc;n thủ nguy&ecirc;n tắc an to&agrave;n của địa phương v&agrave; quốc gia.</p>\r\n<p>Tr&aacute;nh h&iacute;t, tiếp x&uacute;c trực tiếp với da hay mắt. Trong trường hợp nuốt phải hay tiếp x&uacute;c với da, mắt phải đưa đi đến Trung t&acirc;m y tế ngay lập tức.</p>\r\n<p>Ph&ograve;ng ngừa c&aacute;c rủi ro c&oacute; thể xảy ra như ch&aacute;y, nổ hay &ocirc; nhiễm.&nbsp; &nbsp;&nbsp;</p>\r\n<p>Tr&aacute;nh lửa, chỉ thi c&ocirc;ng trong m&ocirc;i trường th&ocirc;ng tho&aacute;ng. Cải thiện sự th&ocirc;ng gi&oacute; ở những khu vực c&oacute; kh&ocirc;ng gian k&iacute;n.&nbsp; &nbsp;&nbsp;</p>\r\n<p>Khuyến c&aacute;o về thi c&ocirc;ng:</p>\r\n<p>Độ ẩm kh&ocirc;ng kh&iacute;: kh&ocirc;ng thi c&ocirc;ng khi độ ẩm tr&ecirc;n 85%.</p>\r\n<p>Nhiệt độ m&ocirc;i trường: Kh&ocirc;ng thi c&ocirc;ng khi nhiệt độ dưới 5&deg;C hoặc tr&ecirc;n 45&deg;C.</p>\r\n<p>&nbsp;</p>\r\n<p>Nhiệt ộ bề mặt th&eacute;p: Tối thiểu lớn hơn nhiệt độ điểm sương l&agrave; 3&deg;C. Nhiệt độ qu&aacute; cao c&oacute; thể g&acirc;y hư hại m&agrave;ng sơn, do vậy điều kiện thi c&ocirc;ng cần điều chỉnh khi nhiệt độ tr&ecirc;n 50&deg;C, chẳng hạn như việc chuyển đổi thời gian l&agrave;m việc v&agrave;o buổi s&aacute;ng hay chiều tối, che chắn hay chuyển v&agrave;o trong c&ocirc;ng xưởng.</p>\r\n<p>C&aacute;c điều kiện kh&aacute;c: Hạn chế sự nhiễm bẩn từ việc thổi c&aacute;t, từ bụi sơn&hellip; Ngừng thi c&ocirc;ng khi trời c&oacute; mưa, tuyết, sương m&ugrave;, gi&oacute; mạnh hay b&atilde;o, để tr&aacute;nh việc hư hại hay ph&aacute; hủy m&agrave;ng sơn v&agrave; sự tổn thất sơn.</p>\r\n<p>Đ&oacute;ng g&oacute;i: 20 kg/th&ugrave;ng.</p>\r\n<p>Bảo quản: 24 th&aacute;ng ở 23&deg;C, kiểm tra sơn lại sau thời gian n&agrave;y. Bảo quản ở nơi c&oacute; m&aacute;i che, kh&ocirc; r&aacute;o, tr&aacute;nh xa nguồn nhiệt v&agrave; tia lửa. Hạn sử dụng c&oacute; thể ngắn hơn khi nhiệt độ tr&ecirc;n 23&deg;C.</p>\r\n<p>Ch&uacute; &yacute;: Độ phủ thực tế c&oacute; thể phụ thuộc v&agrave;o h&igrave;nh dạng, k&iacute;ch thước, t&igrave;nh trạng bề mặt của vật liệu nền, thời tiết, phương ph&aacute;p thi c&ocirc;ng v&agrave; c&aacute;c yếu tố kh&aacute;c.</p>\r\n<p>Những th&ocirc;ng tin tr&ecirc;n được đưa ra tr&ecirc;n cơ cở kiểm tra trong ph&ograve;ng th&iacute; nghiệm v&agrave; kinh nghiệm thực tế. Tuy nhi&ecirc;n ch&uacute;ng t&ocirc;i kh&ocirc;ng thể biết trước hay kiểm so&aacute;t hầu hết c&aacute;c yếu tố ảnh hưởng đến qu&aacute; tr&igrave;nh thi c&ocirc;ng. Ch&uacute;ng ta chỉ c&oacute; thể đảm bảo chất lượng của sản phẩm.</p>\r\n<p>&nbsp;</p>\r\n<p>Sản phẩm c&oacute; thể chỉ sử dụng bởi những người thi c&ocirc;ng chuy&ecirc;n nghiệp .</p>', 'products\\September2020\\f8QqlIsljGJrlqjwRJ4r.jpg', 'son-chong-chay-noi-that-taikalitt-s-100-ncb-intumescent', NULL, NULL, b'0000000000000000000000000000000000000000000000000000000000000001', 1, 0, 19, '2020-11-17 06:02:44', '2020-11-17 06:02:44', '2020-09-28 07:32:51', '2020-11-17 06:02:44', 10);

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `id` int(10) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `sale_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default` tinyint(4) NOT NULL DEFAULT 0,
  `product_id` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`id`, `quantity`, `price`, `sale_price`, `default`, `product_id`, `created_at`, `updated_at`) VALUES
(3, 5, 140000, NULL, 1, 5, '2020-07-21 23:51:52', '2020-07-21 23:51:52'),
(4, 10, 70000, NULL, 0, 5, '2020-07-21 23:52:22', '2020-07-21 23:52:22'),
(6, 5, 230000, '200000', 1, 9, '2020-07-23 07:09:15', '2020-07-23 07:09:15'),
(7, 5, 150000, '120000', 1, 1, '2020-07-23 07:09:45', '2020-07-23 07:09:45'),
(9, 4, 90000, '70000', 1, 3, '2020-07-23 07:10:41', '2020-08-16 07:34:44'),
(12, 6, 150000, NULL, 1, 4, '2020-07-24 01:43:11', '2020-07-24 01:43:11'),
(19, 50, 150000, '120000', 0, 7, '2020-08-29 18:03:11', '2020-08-29 18:03:11'),
(21, 11, 140000, NULL, 0, 10, '2020-08-29 20:27:57', '2020-08-29 20:27:57'),
(23, 11, 140000, NULL, 0, 10, '2020-08-29 20:28:26', '2020-08-29 20:28:26'),
(29, 49, 1000000, '800000', 1, 11, '2020-09-23 22:40:34', '2020-09-25 21:45:23'),
(33, 20, 999999, NULL, 0, 11, '2020-09-24 19:05:46', '2020-09-24 19:05:46'),
(34, 10, 100000, NULL, 1, 12, '2020-11-05 21:34:57', '2020-11-05 21:34:57'),
(37, 33, 3333, '333', 0, 2, '2020-11-11 20:52:20', '2020-11-11 21:02:05');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(2, 'user', 'Normal User', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(3, 'nv_banhang', 'Nhân viên bán hàng', '2020-05-16 00:36:46', '2020-11-08 09:47:02');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'admin.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Admin'),
(5, 'admin.bg_image', 'Admin Background Image', 'settings\\July2020\\gN6N8Qa6WtpG7mCRunHq.jpg', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Sơn Thành Tánh', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Trang quản lý Sơn Thành Tánh.', '', 'text', 3, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 4, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 2, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '297935773963-34gq1evcmrhnodon1vu5itbt87b3d9ht.apps.googleusercontent.com', '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2020-01-29 09:08:50', '2020-01-29 09:08:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `birthday` date DEFAULT '2020-01-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`, `address`, `phone`, `birthday`) VALUES
(1, 1, 'Quản trị viên', 'admin@admin.com', 'users\\September2020\\fenAYZoIW3NTjPZqCUJJ.png', NULL, '$2y$10$fMMsRD/zRsu8En8g6b44FO0OiLtOokauJ0cMoyy4bqs0QZB6Wnc56', 'IxsKgEV2fwbS1exGzigz63ECIUN0fyl283NkaQ7zokFokeSYZqzQaXAG6iiK', '{\"locale\":\"vi\"}', '2020-01-29 09:08:49', '2020-11-05 23:26:34', NULL, NULL, NULL),
(2, 3, 'ajsdhjasj', 'nhanvienbanghang@thanhtanh.com.vn', 'users/default.png', NULL, '$2y$10$tom1LTa89h9nHDoHZ3gyRum7Z5kmjJmZN3pPREAi7qjgt6CoTff2C', NULL, '{\"locale\":\"vi\"}', '2020-01-29 16:55:35', '2020-11-08 09:49:56', NULL, NULL, NULL),
(3, 2, 'Người dùng', 'nguoidung@nguoidung.com', 'users/default.png', NULL, '$2y$10$ThwdsV7OZobVrsne6hmJ8uMMJIR8YZFyILFM2tij2M8X3Ub8PQVxy', NULL, '{\"locale\":\"vi\"}', '2020-03-10 23:31:27', '2020-06-17 05:28:35', NULL, NULL, NULL),
(4, 2, 'dasd', 'kthoang28@gmail.com', 'users\\September2020\\U3LiRPBx9VTIR3YoEtOp.png', NULL, '$2y$10$TiDbUqp/H2BJprDi9BeRfufO.EAsgkAPMi4Ta5HZLGN7MsFJ7MD4i', 'XgVQHdf5SuZNqQJquRYGir0sZafSKR9BxVSRFkhJVz2PVAM0o2O6r10qEtiN', '{\"locale\":\"vi\"}', '2020-06-19 00:24:07', '2020-09-27 22:33:06', NULL, NULL, NULL),
(5, 2, 'customertest', 'customertest@thanhtanh.com.vn', 'users/default.png', NULL, '$2y$10$tKxySePEheSL9f3bFUOFsOB9ks4S8vYtviO/nmri2RptAUxxrUG7m', NULL, NULL, '2020-11-10 23:19:24', '2020-11-10 23:19:24', NULL, NULL, '2020-01-01'),
(6, 2, 'customertest2', 'customertest2@thanhtanh.com.vn', 'users/default.png', NULL, '$2y$10$On1fceX0pfXkUKAvx3lHz.PYMJK8CrPQYF4MZkGmYD0PAPh20bAGC', NULL, NULL, '2020-11-10 23:21:42', '2020-11-10 23:21:42', NULL, NULL, '2020-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`user_id`, `role_id`) VALUES
(2, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `attributes_name_unique` (`name`);

--
-- Indexes for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD PRIMARY KEY (`id`),
  ADD KEY `attribute_values_attribute_id_foreign` (`attribute_id`);

--
-- Indexes for table `attribute_value_product_attribute`
--
ALTER TABLE `attribute_value_product_attribute`
  ADD KEY `attribute_value_product_attribute_attribute_value_id_foreign` (`attribute_value_id`),
  ADD KEY `attribute_value_product_attribute_product_attribute_id_foreign` (`product_attribute_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `customer_email_unique` (`email`),
  ADD KEY `customer_user_id_index` (`user_id`);

--
-- Indexes for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`);

--
-- Indexes for table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_types_name_unique` (`name`),
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_name_unique` (`name`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_statuses`
--
ALTER TABLE `order_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_key_index` (`key`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `posts_slug_unique` (`slug`);

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_attributes_product_id_foreign` (`product_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_user_id_index` (`user_id`),
  ADD KEY `user_roles_role_id_index` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attribute_values`
--
ALTER TABLE `attribute_values`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bill_details`
--
ALTER TABLE `bill_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=293;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
