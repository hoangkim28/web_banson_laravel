-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 01, 2021 at 10:34 AM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `v5`
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
                on b.id = bd.bill_id
                inner join product_attributes p
                on bd.product_attribute_id = p.id
                where b.created_at <= cast(toDate as date) 
				AND b.created_at >= cast(fromDate as date)
                group by b.created_at;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Kích thước', '2021-05-12 21:55:00', '2021-05-12 14:55:55'),
(2, 'Bản màu', '2020-08-26 23:55:40', '2020-08-26 23:55:40');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_values`
--

CREATE TABLE `attribute_values` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attribute_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_values`
--

INSERT INTO `attribute_values` (`id`, `name`, `value`, `attribute_id`, `created_at`, `updated_at`) VALUES
(1, 'Thùng 5 lít', '5', 1, '2020-07-15 00:13:37', '2020-07-15 00:13:37'),
(2, 'Thùng 18L', '18', 1, '2020-07-15 00:13:49', '2020-07-15 00:13:49'),
(3, 'Chay sịt 200ml', '200ml', 1, '2020-07-15 00:14:10', '2020-07-15 00:14:10'),
(4, 'Không màu', '0', 2, '2020-08-26 23:57:05', '2020-08-26 23:57:05'),
(5, 'Máy pha màu', '1', 2, '2020-08-26 23:57:56', '2020-08-26 23:57:56'),
(6, 'Thùng 25 Lít', '25', 1, '2020-09-10 17:23:07', '2020-09-10 17:23:16');

-- --------------------------------------------------------

--
-- Table structure for table `attribute_value_product_attribute`
--

CREATE TABLE `attribute_value_product_attribute` (
  `attribute_value_id` bigint(20) UNSIGNED NOT NULL,
  `product_attribute_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attribute_value_product_attribute`
--

INSERT INTO `attribute_value_product_attribute` (`attribute_value_id`, `product_attribute_id`) VALUES
(1, 2),
(4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `address1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` int(11) DEFAULT NULL,
  `payment_method` int(11) DEFAULT NULL,
  `subtotal` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `bill_details`
--

CREATE TABLE `bill_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `bill_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_attribute_id` bigint(20) UNSIGNED NOT NULL,
  `attribute_value_id` bigint(20) UNSIGNED NOT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `image`, `website`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Sơn Delux', 'son-delux', 'brands\\August2020\\j3rAbkjKE1ct4KwZb565.png', 'http://website01.vn', 1, '2020-01-29 18:20:00', '2020-08-15 20:42:55'),
(2, 'Sơn Jotun', 'son-jotun', 'brands\\February2020\\4viI80n7b1arJXP2d3D7.png', '', 1, '2020-02-27 00:20:34', '2020-02-27 00:20:34'),
(3, 'Sơn Mykolor', 'son-mykolor', 'brands\\February2020\\du7CkUXX3G6DG6V2SkbK.jpg', '', 1, '2020-02-27 00:21:25', '2020-02-27 00:21:25'),
(4, 'Sơn Nippon', 'son-nippon', 'brands\\August2020\\U6yyAf6J50WLeb9jnxQm.png', 'https://nipponpaint.com.vn/', 1, '2020-05-16 00:42:06', '2020-08-15 20:42:21'),
(5, '1212', '1212', NULL, '1212', 1, '2021-06-01 01:27:17', '2021-06-01 01:27:17');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Sơn nội thất', 'son-noi-that', 1, '2020-01-29 09:08:49', '2020-07-25 20:26:07'),
(2, NULL, 1, 'Sơn ngoại thất', 'son-ngoai-that', 1, '2020-01-29 09:08:49', '2020-07-25 20:26:39'),
(3, 1, 1, 'Sơn chống thấm', 'son-chong-tham', 1, '2020-02-26 07:40:54', '2020-07-25 20:45:03'),
(4, 2, 1, 'Sơn lót trần nhà', 'son-lot-tran-nha', 1, '2020-05-29 00:22:18', '2020-07-22 06:40:41'),
(7, 2, 1, 'Sơn lót kháng kiềm', 'son-lot-khang-kiem', 1, '2020-07-24 07:11:30', '2020-07-24 07:11:30'),
(8, NULL, 1, 'Sơn giữa', 'son-giua', 1, '2020-07-24 07:13:48', '2020-07-24 07:13:48'),
(9, 2, 1, 'Sơn phủ', 'son-phu', 1, '2020-07-24 07:13:58', '2020-07-25 20:44:46'),
(10, 1, 1, 'Bột trét', 'bot-tret', 1, '2020-07-24 07:14:06', '2020-07-25 20:44:32'),
(11, NULL, 1, 'Sơn sấy', 'son-say', 1, '2020-07-24 07:14:19', '2020-07-24 07:14:19'),
(12, 2, 1, 'Sơn vạch đường', 'son-vach-duong', 1, '2020-07-24 07:14:32', '2020-07-25 20:44:20'),
(13, 2, 1, 'Sơn chịu nhiệt', 'son-chiu-nhiet', 1, '2020-07-24 07:14:42', '2020-07-25 20:44:12'),
(14, NULL, 1, 'Sơn dân dụng', 'son-dan-dung', 1, '2020-07-25 20:47:15', '2020-07-25 20:47:15'),
(15, NULL, 1, 'Sơn công nghiệp', 'son-cong-nghiep', 1, '2020-07-25 20:47:24', '2020-07-25 20:47:24');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `birthday` date DEFAULT '2020-01-01',
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(74, 12, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"validation\":{\"rule\":\"required\",\"messages\":{\"required\":\"Vui l\\u00f2ng nh\\u1eadp t\\u00ean.\"}}}', 2),
(75, 12, 'image', 'image', 'Hinh ảnh', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"display\":{\"width\":\"6\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 5),
(76, 12, 'website', 'text', 'Website', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"}}', 4),
(77, 12, 'status', 'checkbox', 'Trạng thái', 1, 1, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"true\",\"display\":{\"width\":\"2\"}}', 6),
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
(150, 20, 'total', 'text', 'Tổng giá trị', 0, 1, 1, 1, 1, 1, '{}', 12),
(151, 1, 'email_verified_at', 'timestamp', 'Email Verified At', 0, 0, 1, 1, 1, 1, '{}', 12),
(152, 1, 'address', 'text', 'Địa chỉ', 0, 1, 1, 1, 1, 1, '{}', 8),
(153, 1, 'phone', 'number', 'Điện thoại', 0, 1, 1, 1, 1, 1, '{}', 7),
(154, 1, 'birthday', 'text', 'Ngày sinh', 0, 1, 1, 1, 1, 1, '{}', 5),
(166, 27, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(168, 27, 'category_id', 'select_dropdown', 'Category Id', 0, 0, 1, 1, 1, 1, '{}', 3),
(169, 27, 'brand_id', 'select_dropdown', 'Brand Id', 0, 0, 1, 1, 1, 1, '{}', 5),
(170, 27, 'name', 'text', 'Tên', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"validation\":{\"rule\":\"required\",\"messages\":{\"required\":\"Vui l\\u00f2ng nh\\u1eadp t\\u00ean s\\u1ea3n ph\\u1ea9m.\"}}}', 6),
(171, 27, 'sku', 'text', 'Sku', 1, 1, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"validation\":{\"rule\":\"required\",\"messages\":{\"required\":\"Vui l\\u00f2ng nh\\u1eadp m\\u00e3 s\\u1ea3n ph\\u1ea9m.\"}}}', 8),
(172, 27, 'seo_title', 'text', 'Seo Title', 0, 0, 1, 1, 1, 1, '{}', 20),
(173, 27, 'excerpt', 'text', 'Giới thiệu', 0, 0, 1, 1, 1, 1, '{}', 19),
(174, 27, 'body', 'rich_text_box', 'Thông tin sản phẩm', 1, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"12\"}}', 15),
(175, 27, 'avatar', 'image', 'Ảnh đại diện', 1, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"6\"},\"validation\":{\"rule\":\"required\",\"messages\":{\"required\":\"Vui l\\u00f2ng th\\u00eam h\\u00ecnh \\u1ea3nh s\\u1ea3n ph\\u1ea9m.\"}}}', 17),
(177, 27, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:products,slug,required\",\"messages\":{\"required\":\"Vui l\\u00f2ng nh\\u1eadp m\\u00e3 s\\u1ea3n ph\\u1ea9m.\"}},\"display\":{\"width\":\"6\"}}', 7),
(178, 27, 'meta_description', 'text_area', 'Meta Description', 0, 0, 1, 1, 1, 1, '{}', 21),
(179, 27, 'meta_keywords', 'text_area', 'Meta Keywords', 0, 0, 1, 1, 1, 1, '{}', 22),
(180, 27, 'status', 'checkbox', 'Trạng thái', 1, 1, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"on\",\"display\":{\"width\":\"3\"}}', 29),
(181, 27, 'featured', 'checkbox', 'Sản phẩm đặc biệt', 1, 0, 1, 1, 1, 1, '{\"on\":\"Hi\\u1ec3n th\\u1ecb\",\"off\":\"\\u1ea8n\",\"checked\":\"on\",\"display\":{\"width\":\"3\"},\"title\":\"\\u0110\\u00e2y l\\u00e0 s\\u1ea3n ph\\u1ea9m \\u0111\\u1eb7t bi\\u1ec7t\"}', 25),
(186, 27, 'sold', 'number', 'Đã bán', 0, 1, 1, 0, 0, 1, '{\"display\":{\"width\":\"2\"}}', 14),
(187, 27, 'view', 'number', 'Lượt xem', 0, 1, 1, 0, 0, 1, '{\"display\":{\"width\":\"2\"}}', 16),
(188, 27, 'date_lastview', 'timestamp', 'Date Lastview', 1, 0, 0, 0, 0, 1, '{}', 23),
(189, 27, 'date_available', 'timestamp', 'Ngày hiện thị', 1, 0, 1, 1, 1, 1, '{\"display\":{\"width\":\"3\"},\"validation\":{\"rule\":\"required\",\"messages\":{\"required\":\"Vui l\\u00f2ng ng\\u00e0y s\\u1ea3n ph\\u1ea9m s\\u1ebd hi\\u1ec3n th\\u1ecb.\"}}}', 24),
(190, 27, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 1, '{}', 26),
(191, 27, 'updated_at', 'timestamp', 'Updated At', 0, 0, 1, 0, 0, 1, '{}', 28),
(193, 27, 'product_hasone_brand_relationship', 'relationship', 'Thương hiệu', 0, 0, 0, 1, 1, 1, '{\"display\":{\"width\":\"4\"},\"model\":\"App\\\\Models\\\\Brand\",\"table\":\"brands\",\"type\":\"belongsTo\",\"column\":\"brand_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 4),
(194, 27, 'product_hasone_category_relationship', 'relationship', 'Danh mục', 0, 1, 0, 1, 1, 1, '{\"display\":{\"width\":\"4\"},\"model\":\"App\\\\Models\\\\Category\",\"table\":\"categories\",\"type\":\"belongsTo\",\"column\":\"category_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(254, 38, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(255, 38, 'name', 'text', 'Tên thuộc tính', 1, 1, 1, 1, 1, 1, '{\"width\":\"4\"}', 2),
(256, 38, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 1, '{}', 3),
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
(271, 40, 'password', 'password', 'Password', 1, 0, 0, 0, 0, 0, '{}', 5),
(272, 40, 'address', 'text', 'Địa chỉ', 0, 1, 1, 1, 1, 1, '{}', 6),
(273, 40, 'phone', 'number', 'Điện thoại', 0, 1, 1, 1, 1, 1, '{}', 7),
(274, 40, 'birthday', 'date', 'Ngày sinh', 0, 1, 1, 1, 1, 1, '{}', 8),
(275, 40, 'user_id', 'number', 'User Id', 0, 0, 1, 1, 1, 1, '{}', 9),
(276, 40, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 1, '{}', 10),
(277, 40, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 11),
(278, 40, 'customer_belongsto_user_relationship', 'relationship', 'User ID', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"attribute_value_product_attribute\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(279, 41, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(280, 41, 'full_name', 'text', 'Khách hàng', 0, 1, 1, 1, 1, 1, '{}', 2),
(281, 41, 'email', 'text', 'Email', 0, 1, 1, 1, 1, 1, '{\"type\":\"email\"}', 5),
(282, 41, 'phone', 'number', 'Điện thoại', 0, 1, 1, 1, 1, 1, '{}', 6),
(283, 41, 'address1', 'text', 'Địa chỉ 1', 0, 0, 1, 1, 1, 1, '{}', 7),
(284, 41, 'address2', 'text', 'Địa chỉ 2', 0, 0, 1, 1, 1, 1, '{}', 8),
(285, 41, 'comment', 'text', 'Ghi chú', 0, 0, 1, 1, 1, 1, '{}', 9),
(286, 41, 'payment_method', 'text', 'Phương thức thanh toán', 0, 0, 0, 0, 0, 0, '{}', 10),
(288, 41, 'subtotal', 'text', 'Trước thuế', 0, 0, 1, 1, 1, 1, '{}', 12),
(290, 41, 'total', 'number', 'Tổng', 0, 1, 1, 1, 1, 1, '{}', 14),
(291, 41, 'created_at', 'timestamp', 'Ngày tạo', 0, 1, 1, 1, 0, 1, '{}', 15),
(292, 41, 'updated_at', 'timestamp', 'Ngày cập nhật', 0, 0, 0, 0, 0, 0, '{}', 16),
(294, 41, 'user_id', 'text', 'User Id', 0, 0, 0, 0, 0, 0, '{}', 4),
(295, 41, 'bill_belongsto_user_relationship', 'relationship', 'User Id', 0, 0, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"attribute_value_product_attribute\",\"pivot\":\"0\",\"taggable\":\"0\"}', 3),
(296, 41, 'bill_belongsto_payment_method_relationship', 'relationship', 'Phương thức thanh toán', 0, 0, 0, 0, 0, 1, '{\"display\":{\"width\":\"3\"},\"model\":\"App\\\\Models\\\\PaymentMethod\",\"table\":\"payment_methods\",\"type\":\"belongsTo\",\"column\":\"payment_method\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"attribute_value_product_attribute\",\"pivot\":\"0\",\"taggable\":\"0\"}', 17);

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
(1, 'users', 'users', 'Người dùng', 'Người dùng', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 02:08:49', '2020-05-20 00:45:02'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(3, 'roles', 'roles', 'Phân Quyền', 'Phân Quyền', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 02:08:49', '2020-05-20 00:44:34'),
(4, 'categories', 'categories', 'Danh mục sản phẩm', 'Danh mục sản phẩm', 'voyager-categories', 'App\\Models\\Category', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":\"name\",\"scope\":null}', '2020-01-29 02:08:49', '2020-08-15 15:17:25'),
(12, 'brands', 'brands', 'Thương hiệu', 'Thương hiệu', 'voyager-company', 'App\\Models\\Brand', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 11:16:17', '2021-06-01 01:27:14'),
(17, 'order_statuses', 'order-statuses', 'Order Status', 'Order Statuses', 'voyager-info-circled', 'App\\Models\\OrderStatus', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 17:00:44', '2020-01-29 17:01:54'),
(19, 'order', 'order', 'Order', 'Orders', NULL, 'App\\Models\\Order', NULL, 'App\\Http\\Controllers\\Admin\\OrderController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-01-29 17:04:33', '2020-01-29 17:04:33'),
(20, 'orders', 'orders', 'Đơn hàng', 'Đơn hàng', 'voyager-basket', 'App\\Models\\Order', NULL, 'App\\Http\\Controllers\\Admin\\OrderController', NULL, 1, 1, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"phone\",\"scope\":null}', '2020-01-29 17:05:19', '2021-06-01 00:13:22'),
(23, 'payment_methods', 'payment-methods', 'Payment Method', 'Payment Methods', 'voyager-code', 'App\\Models\\PaymentMethod', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 18:10:13', '2020-01-29 18:15:16'),
(25, 'product_attribute', 'product-attribute', 'Product Attribute', 'Product Attributes', NULL, 'App\\Models\\ProductAttribute', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-05-29 16:50:59', '2020-05-29 16:50:59'),
(27, 'products', 'products', 'Sản phẩm', 'Sản phẩm', 'voyager-data', 'App\\Models\\Product', NULL, 'App\\Http\\Controllers\\Admin\\ProductController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-05-31 12:26:32', '2021-06-01 01:24:25'),
(38, 'attributes', 'attributes', 'Thuộc tính sản phẩm', 'Thuộc tính sản phẩm', NULL, 'App\\Models\\Attribute', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-07-07 14:22:28', '2021-05-12 14:56:42'),
(39, 'attribute_values', 'attribute-values', 'Giá trị của thuộc tính', 'Giá trị của các thuộc tính', NULL, 'App\\Models\\AttributeValue', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-07-07 14:23:22', '2020-07-09 13:50:51'),
(40, 'customers', 'customers', 'Khách hàng', 'Khách hàng', 'voyager-people', 'App\\Models\\Customer', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-11-04 13:54:53', '2021-05-12 14:55:29'),
(41, 'bills', 'bills', 'Hóa đơn', 'Hóa đơn', 'voyager-bar-chart', 'App\\Models\\Bill', NULL, 'App\\Http\\Controllers\\Admin\\BillController', NULL, 1, 1, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"phone\",\"scope\":null}', '2020-11-12 22:40:16', '2021-06-01 00:13:30');

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
(1, 'admin', '2020-01-29 02:08:49', '2020-01-29 02:08:49');

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
(1, 1, 'Trang chủ', '', '_self', 'voyager-boat', '#000000', NULL, 1, '2020-01-29 02:08:49', '2020-04-18 21:49:24', 'voyager.dashboard', 'null'),
(2, 1, 'Phương tiện', '', '_self', 'voyager-images', '#000000', NULL, 5, '2020-01-29 02:08:49', '2020-11-12 22:40:55', 'voyager.media.index', 'null'),
(3, 1, 'Người dùng', '', '_self', 'voyager-person', '#000000', 20, 2, '2020-01-29 02:08:49', '2020-04-18 19:23:51', 'voyager.users.index', 'null'),
(4, 1, 'Quyền - Nhóm quyền', '', '_self', 'voyager-lock', '#000000', 20, 1, '2020-01-29 02:08:49', '2020-04-18 19:23:41', 'voyager.roles.index', 'null'),
(5, 1, 'Công cụ', '', '_self', 'voyager-tools', '#000000', NULL, 7, '2020-01-29 02:08:49', '2020-11-12 22:40:55', NULL, ''),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2020-01-29 02:08:49', '2020-01-29 09:50:12', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2020-01-29 02:08:49', '2020-05-31 12:26:50', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2020-01-29 02:08:49', '2020-11-12 22:40:50', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2020-01-29 02:08:49', '2020-11-12 22:40:50', 'voyager.bread.index', NULL),
(10, 1, 'Cài đặt hệ thống', '', '_self', 'voyager-settings', '#000000', 5, 8, '2020-01-29 02:08:49', '2020-11-12 22:40:50', 'voyager.settings.index', 'null'),
(11, 1, 'Danh mục sản phẩm', '', '_self', 'voyager-categories', '#000000', 19, 1, '2020-01-29 02:08:49', '2020-04-18 19:22:42', 'voyager.categories.index', 'null'),
(14, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 5, '2020-01-29 02:08:50', '2020-11-12 22:40:50', 'voyager.hooks', NULL),
(16, 1, 'Thương hiệu', '', '_self', 'voyager-company', '#000000', 19, 2, '2020-01-29 11:16:18', '2020-05-29 13:06:23', 'voyager.brands.index', 'null'),
(19, 1, 'Sản phẩm', '', '_self', 'voyager-helm', '#000000', NULL, 3, '2020-01-29 11:34:54', '2021-05-02 13:37:12', NULL, ''),
(20, 1, 'Người dùng', '', '_self', 'voyager-github', '#000000', NULL, 4, '2020-01-29 16:14:26', '2020-11-12 22:40:55', NULL, ''),
(21, 1, 'Trạng thái đơn hàng', '', '_self', 'voyager-info-circled', '#000000', 5, 6, '2020-01-29 17:00:44', '2020-11-12 22:40:50', 'voyager.order-statuses.index', 'null'),
(23, 1, 'Danh sách Đơn hàng', '', '_self', 'voyager-basket', '#000000', 24, 1, '2020-01-29 17:05:19', '2020-11-12 22:41:20', 'voyager.orders.index', 'null'),
(24, 1, 'Đơn hàng', '', '_self', 'voyager-bag', '#000000', NULL, 2, '2020-01-29 17:06:29', '2021-05-02 13:37:12', NULL, ''),
(26, 1, 'P.Thức Thanh toán', '', '_self', 'voyager-code', '#000000', 5, 7, '2020-01-29 18:10:13', '2020-11-12 22:40:50', 'voyager.payment-methods.index', 'null'),
(34, 1, 'Sản phẩm', '', '_self', 'voyager-data', '#000000', 19, 3, '2020-05-31 12:26:32', '2020-06-18 15:52:18', 'voyager.products.index', 'null'),
(46, 1, 'Thuộc tính sản phẩm', '', '_self', 'voyager-wand', '#000000', 48, 2, '2020-07-07 14:22:28', '2020-07-07 14:30:59', 'voyager.attributes.index', 'null'),
(47, 1, 'Giá trị của các thuộc tính', '', '_self', 'voyager-wand', '#000000', 48, 1, '2020-07-07 14:23:23', '2020-07-07 14:30:52', 'voyager.attribute-values.index', 'null'),
(48, 1, 'Thuộc tính Sản phẩm', '', '_self', 'voyager-params', '#000000', NULL, 6, '2020-07-07 14:27:56', '2020-11-12 22:40:55', NULL, ''),
(49, 1, 'Khách hàng', '', '_self', 'voyager-people', NULL, 20, 3, '2020-11-04 13:54:53', '2020-11-04 13:55:16', 'voyager.customers.index', NULL),
(50, 1, 'Hóa đơn', '', '_self', 'voyager-bar-chart', NULL, 24, 2, '2020-11-12 22:40:17', '2021-05-02 13:37:19', 'voyager.bills.index', NULL);

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
(6, '2016_02_15_204651_create_categories_table', 1),
(7, '2016_05_19_173453_create_menu_table', 1),
(8, '2016_10_21_190000_create_roles_table', 1),
(9, '2016_10_21_190000_create_settings_table', 1),
(10, '2016_11_30_135954_create_permission_table', 1),
(11, '2016_11_30_141208_create_permission_role_table', 1),
(12, '2016_12_26_201236_data_types__add__server_side', 1),
(13, '2017_01_13_000000_add_route_to_menu_items_table', 1),
(14, '2017_01_14_005015_create_translations_table', 1),
(15, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
(16, '2017_03_06_000000_add_controller_to_data_types_table', 1),
(17, '2017_04_21_000000_add_order_to_data_rows_table', 1),
(18, '2017_06_26_000000_create_shopping_cart_table', 1),
(19, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
(20, '2017_08_05_000000_add_group_to_settings_table', 1),
(21, '2017_11_26_013050_add_user_role_relationship', 1),
(22, '2017_11_26_015000_create_user_roles_table', 1),
(23, '2018_03_11_000000_add_user_settings', 1),
(24, '2018_03_14_000000_add_details_to_data_types_table', 1),
(25, '2018_03_16_000000_make_settings_value_nullable', 1),
(26, '2021_05_24_000000_create_order_statuses_table', 1),
(27, '2021_05_24_000000_create_payment_methods_table', 1),
(28, '2021_05_24_000002_create_brands_table', 1),
(29, '2021_05_24_000002_create_customers_table', 1),
(30, '2021_05_24_000002_create_products_table', 1),
(31, '2021_05_24_000003_create_attributes_table', 1),
(32, '2021_05_24_000003_create_product_attributes_table', 1),
(33, '2021_05_24_000005_create_attribute_values_table', 1),
(34, '2021_05_24_000005_create_bills_table', 1),
(35, '2021_05_24_000006_create_attribute_value_product_attribute_table', 1),
(36, '2021_05_24_000011_create_bill_details_table', 1),
(37, '2021_05_24_000012_create_orders_table', 1),
(38, '2021_05_24_000013_create_order_details_table', 1),
(39, '2021_05_31_031243_create_address_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` int(10) UNSIGNED DEFAULT NULL,
  `order_status` int(10) UNSIGNED DEFAULT NULL,
  `subtotal` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `full_name`, `address1`, `address2`, `phone`, `email`, `comment`, `payment_method`, `order_status`, `subtotal`, `total`, `created_at`, `updated_at`) VALUES
(1, 1, 'Quản trị viên', '123123', '12312', 355640750, 'admin@admin.com', NULL, NULL, 1, '138000', '138000', '2021-06-01 00:51:49', '2021-06-01 00:51:49');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_attribute_id` bigint(20) UNSIGNED DEFAULT NULL,
  `attribute_value_id` bigint(20) UNSIGNED DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `quantity`, `product_price`, `product_attribute_id`, `attribute_value_id`, `product_name`, `product_sku`, `color`) VALUES
(1, 1, 1, 2, 69000, 2, 1, 'Sơn Nippon Tilac', 'son-nippon-tilac', '#002A55');

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
(1, 'Đơn hàng mới', '2020-01-29 17:02:00', '2020-04-18 19:29:38'),
(2, 'Đang tiến hành', '2020-01-29 17:02:00', '2020-04-18 19:29:25'),
(3, 'Đã hủy', '2020-01-29 17:02:00', '2020-04-18 19:29:13'),
(4, 'Hoàn thành', '2020-01-29 17:03:00', '2020-04-18 19:29:04');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `author_id` bigint(20) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `password_resets`
--

INSERT INTO `password_resets` (`email`, `token`, `created_at`) VALUES
('kthoang28@gmail.com', '$2y$10$nN.jYBP148o1WUv4nsioJeCN4z1L2wbcVb3zKOS9FQKwq1aIZiyEW', '2020-11-17 14:24:55');

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
(1, 'COD', 'Cash on delivery', '2020-02-11 17:29:51', '2020-02-11 17:29:51'),
(2, 'ATM', 'Chuyển Khoản', '2020-02-11 17:30:00', '2020-04-18 19:30:07'),
(3, 'CONTRACT', 'Contract', '2020-02-11 17:30:00', '2020-04-18 19:30:29');

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
(1, 'browse_admin', NULL, '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(2, 'browse_bread', NULL, '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(3, 'browse_database', NULL, '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(4, 'browse_media', NULL, '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(5, 'browse_compass', NULL, '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(6, 'browse_menus', 'menus', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(7, 'read_menus', 'menus', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(8, 'edit_menus', 'menus', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(9, 'add_menus', 'menus', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(10, 'delete_menus', 'menus', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(11, 'browse_roles', 'roles', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(12, 'read_roles', 'roles', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(13, 'edit_roles', 'roles', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(14, 'add_roles', 'roles', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(15, 'delete_roles', 'roles', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(16, 'browse_users', 'users', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(17, 'read_users', 'users', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(18, 'edit_users', 'users', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(19, 'add_users', 'users', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(20, 'delete_users', 'users', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(21, 'browse_settings', 'settings', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(22, 'read_settings', 'settings', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(23, 'edit_settings', 'settings', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(24, 'add_settings', 'settings', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(25, 'delete_settings', 'settings', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(26, 'browse_categories', 'categories', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(27, 'read_categories', 'categories', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(28, 'edit_categories', 'categories', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(29, 'add_categories', 'categories', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(30, 'delete_categories', 'categories', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(31, 'browse_posts', 'posts', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(32, 'read_posts', 'posts', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(33, 'edit_posts', 'posts', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(34, 'add_posts', 'posts', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(35, 'delete_posts', 'posts', '2020-01-29 02:08:49', '2020-01-29 02:08:49'),
(41, 'browse_hooks', NULL, '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(47, 'browse_brands', 'brands', '2020-01-29 11:16:17', '2020-01-29 11:16:17'),
(48, 'read_brands', 'brands', '2020-01-29 11:16:17', '2020-01-29 11:16:17'),
(49, 'edit_brands', 'brands', '2020-01-29 11:16:17', '2020-01-29 11:16:17'),
(50, 'add_brands', 'brands', '2020-01-29 11:16:17', '2020-01-29 11:16:17'),
(51, 'delete_brands', 'brands', '2020-01-29 11:16:17', '2020-01-29 11:16:17'),
(57, 'browse_order_statuses', 'order_statuses', '2020-01-29 17:00:44', '2020-01-29 17:00:44'),
(58, 'read_order_statuses', 'order_statuses', '2020-01-29 17:00:44', '2020-01-29 17:00:44'),
(59, 'edit_order_statuses', 'order_statuses', '2020-01-29 17:00:44', '2020-01-29 17:00:44'),
(60, 'add_order_statuses', 'order_statuses', '2020-01-29 17:00:44', '2020-01-29 17:00:44'),
(61, 'delete_order_statuses', 'order_statuses', '2020-01-29 17:00:44', '2020-01-29 17:00:44'),
(62, 'browse_order', 'order', '2020-01-29 17:04:33', '2020-01-29 17:04:33'),
(63, 'read_order', 'order', '2020-01-29 17:04:33', '2020-01-29 17:04:33'),
(64, 'edit_order', 'order', '2020-01-29 17:04:33', '2020-01-29 17:04:33'),
(65, 'add_order', 'order', '2020-01-29 17:04:33', '2020-01-29 17:04:33'),
(66, 'delete_order', 'order', '2020-01-29 17:04:33', '2020-01-29 17:04:33'),
(67, 'browse_orders', 'orders', '2020-01-29 17:05:19', '2020-01-29 17:05:19'),
(68, 'read_orders', 'orders', '2020-01-29 17:05:19', '2020-01-29 17:05:19'),
(69, 'edit_orders', 'orders', '2020-01-29 17:05:19', '2020-01-29 17:05:19'),
(70, 'add_orders', 'orders', '2020-01-29 17:05:19', '2020-01-29 17:05:19'),
(71, 'delete_orders', 'orders', '2020-01-29 17:05:19', '2020-01-29 17:05:19'),
(77, 'browse_payment_methods', 'payment_methods', '2020-01-29 18:10:13', '2020-01-29 18:10:13'),
(78, 'read_payment_methods', 'payment_methods', '2020-01-29 18:10:13', '2020-01-29 18:10:13'),
(79, 'edit_payment_methods', 'payment_methods', '2020-01-29 18:10:13', '2020-01-29 18:10:13'),
(80, 'add_payment_methods', 'payment_methods', '2020-01-29 18:10:13', '2020-01-29 18:10:13'),
(81, 'delete_payment_methods', 'payment_methods', '2020-01-29 18:10:13', '2020-01-29 18:10:13'),
(87, 'browse_product_attribute', 'product_attribute', '2020-05-29 16:51:00', '2020-05-29 16:51:00'),
(88, 'read_product_attribute', 'product_attribute', '2020-05-29 16:51:00', '2020-05-29 16:51:00'),
(89, 'edit_product_attribute', 'product_attribute', '2020-05-29 16:51:00', '2020-05-29 16:51:00'),
(90, 'add_product_attribute', 'product_attribute', '2020-05-29 16:51:00', '2020-05-29 16:51:00'),
(91, 'delete_product_attribute', 'product_attribute', '2020-05-29 16:51:00', '2020-05-29 16:51:00'),
(97, 'browse_products', 'products', '2020-05-31 12:26:32', '2020-05-31 12:26:32'),
(98, 'read_products', 'products', '2020-05-31 12:26:32', '2020-05-31 12:26:32'),
(99, 'edit_products', 'products', '2020-05-31 12:26:32', '2020-05-31 12:26:32'),
(100, 'add_products', 'products', '2020-05-31 12:26:32', '2020-05-31 12:26:32'),
(101, 'delete_products', 'products', '2020-05-31 12:26:32', '2020-05-31 12:26:32'),
(152, 'browse_attributes', 'attributes', '2020-07-07 14:22:28', '2020-07-07 14:22:28'),
(153, 'read_attributes', 'attributes', '2020-07-07 14:22:28', '2020-07-07 14:22:28'),
(154, 'edit_attributes', 'attributes', '2020-07-07 14:22:28', '2020-07-07 14:22:28'),
(155, 'add_attributes', 'attributes', '2020-07-07 14:22:28', '2020-07-07 14:22:28'),
(156, 'delete_attributes', 'attributes', '2020-07-07 14:22:28', '2020-07-07 14:22:28'),
(157, 'browse_attribute_values', 'attribute_values', '2020-07-07 14:23:23', '2020-07-07 14:23:23'),
(158, 'read_attribute_values', 'attribute_values', '2020-07-07 14:23:23', '2020-07-07 14:23:23'),
(159, 'edit_attribute_values', 'attribute_values', '2020-07-07 14:23:23', '2020-07-07 14:23:23'),
(160, 'add_attribute_values', 'attribute_values', '2020-07-07 14:23:23', '2020-07-07 14:23:23'),
(161, 'delete_attribute_values', 'attribute_values', '2020-07-07 14:23:23', '2020-07-07 14:23:23'),
(162, 'browse_customers', 'customers', '2020-11-04 13:54:53', '2020-11-04 13:54:53'),
(163, 'read_customers', 'customers', '2020-11-04 13:54:53', '2020-11-04 13:54:53'),
(164, 'edit_customers', 'customers', '2020-11-04 13:54:53', '2020-11-04 13:54:53'),
(165, 'add_customers', 'customers', '2020-11-04 13:54:53', '2020-11-04 13:54:53'),
(166, 'delete_customers', 'customers', '2020-11-04 13:54:53', '2020-11-04 13:54:53'),
(167, 'browse_bills', 'bills', '2020-11-12 22:40:16', '2020-11-12 22:40:16'),
(168, 'read_bills', 'bills', '2020-11-12 22:40:16', '2020-11-12 22:40:16'),
(169, 'edit_bills', 'bills', '2020-11-12 22:40:16', '2020-11-12 22:40:16'),
(170, 'add_bills', 'bills', '2020-11-12 22:40:16', '2020-11-12 22:40:16'),
(171, 'delete_bills', 'bills', '2020-11-12 22:40:16', '2020-11-12 22:40:16');

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
  `id` bigint(20) UNSIGNED NOT NULL,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `featured` tinyint(4) NOT NULL DEFAULT 0,
  `sold` int(11) DEFAULT 0,
  `view` int(11) DEFAULT NULL,
  `date_lastview` datetime NOT NULL,
  `date_available` datetime NOT NULL,
  `stock` int(11) DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `category_id`, `brand_id`, `name`, `sku`, `seo_title`, `excerpt`, `body`, `avatar`, `slug`, `meta_description`, `meta_keywords`, `featured`, `sold`, `view`, `date_lastview`, `date_available`, `stock`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Sơn Nippon Tilac', 'son-nippon-tilac', 'Sơn Nippon Tilac', 'Sơn Nippon Tilac', '<div class=\"product-page-detail__right__information\" style=\"box-sizing: border-box; margin-top: 30px; margin-bottom: 30px; color: #000000; font-family: averta-400; font-size: 16px;\">\r\n<div class=\"field field-field-product-infomation field-label-above\" style=\"box-sizing: border-box;\">\r\n<div class=\"field-item\" style=\"box-sizing: border-box; margin-top: 10px;\">\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 15px;\">TILAC l&agrave; loại sơn dầu gốc Alkyd, một th&agrave;nh phần, c&oacute; độ bền cao. TILAC được sử dụng l&agrave;m lớp sơn phủ cho c&aacute;c bề mặt gỗ v&agrave; kim loại, nội v&agrave; ngoại thất.</p>\r\n</div>\r\n</div>\r\n</div>\r\n<div class=\"row product-page-detail__right__video\" style=\"box-sizing: border-box; display: flex; flex-wrap: wrap; margin-right: -15px; margin-left: -15px; color: #000000; font-family: averta-400; font-size: 16px;\">\r\n<div class=\"col-md-12 product-page-detail__right__video-full video\" style=\"box-sizing: border-box; position: relative; width: 845px; min-height: 1px; padding-right: 15px; padding-left: 15px; flex: 0 0 100%; max-width: 100%;\">\r\n<div class=\"field field-field-feature field-label-hidden field-item\" style=\"box-sizing: border-box;\">\r\n<p style=\"box-sizing: border-box; margin: 0px 0px 15px;\"><span style=\"box-sizing: border-box; font-family: averta-600;\">Đặc điểm:</span><br style=\"box-sizing: border-box;\" />- Kinh tế v&agrave; dễ sử dụng<br style=\"box-sizing: border-box;\" />- C&oacute; đặc t&iacute;nh chống ăn m&ograve;n, hiệu quả cao hơn khi kết hợp với lớp sơn l&oacute;t<br style=\"box-sizing: border-box;\" />- M&agrave;ng sơn c&oacute; độ bền cao<br style=\"box-sizing: border-box;\" />- Độ b&aacute;m d&iacute;nh rất tốt tr&ecirc;n nhiều bề mặt<br style=\"box-sizing: border-box;\" />- M&agrave;ng sơn phẳng mịn<br style=\"box-sizing: border-box;\" />- Thời gian kh&ocirc; ngắn hơn so với c&aacute;c loại sơn tương tự kh&aacute;c</p>\r\n</div>\r\n</div>\r\n</div>', 'products\\June2021\\lqlAMGNPC6OJQSdOpmUe.jpg', 'son-nippon-tilac', 'Sơn Nippon Tilac', 'Sơn Nippon Tilac', 1, 7, NULL, '2021-06-01 08:34:09', '2021-06-01 08:34:09', 11, 1, '2021-06-01 00:01:29', '2021-06-01 01:34:09');

-- --------------------------------------------------------

--
-- Table structure for table `product_attributes`
--

CREATE TABLE `product_attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` int(11) DEFAULT NULL,
  `sale_price` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `default` tinyint(4) NOT NULL DEFAULT 0,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `product_attributes`
--

INSERT INTO `product_attributes` (`id`, `quantity`, `price`, `sale_price`, `default`, `product_id`, `created_at`, `updated_at`) VALUES
(2, 11, 69000, NULL, 0, 1, '2021-06-01 00:01:50', '2021-06-01 00:51:49');

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
(1, 'admin', 'Administrator', '2020-01-29 02:08:49', '2020-01-29 02:08:49');

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
(3, 'site.logo', 'Site Logo', 'images/logo-icon.png', '', 'image', 3, 'Site'),
(4, 'admin.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Admin'),
(5, 'admin.bg_image', 'Admin Background Image', 'settings\\July2020\\gN6N8Qa6WtpG7mCRunHq.jpg', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Sơn Thành Tánh', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Trang quản lý Sơn Thành Tánh.', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 4, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', 'settings\\May2021\\iR3LUG7lFCubhZRFvjHn.png', '', 'image', 3, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '297935773963-34gq1evcmrhnodon1vu5itbt87b3d9ht.apps.googleusercontent.com', '', 'text', 1, 'Admin'),
(13, 'site.admin_email', 'Admin email', 'tanhb1401087@student.ctu.edu.vn', NULL, 'text', 6, 'Site');

-- --------------------------------------------------------

--
-- Table structure for table `shopping_cart`
--

CREATE TABLE `shopping_cart` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `instance` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2020-01-29 02:08:50', '2020-01-29 02:08:50'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2020-01-29 02:08:50', '2020-01-29 02:08:50');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `birthday` date NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `birthday`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`) VALUES
(1, 1, 'Quản trị viên', '2021-01-01', 'admin@admin.com', 'users\\September2020\\fenAYZoIW3NTjPZqCUJJ.png', NULL, '$2y$10$fMMsRD/zRsu8En8g6b44FO0OiLtOokauJ0cMoyy4bqs0QZB6Wnc56', 'xDQHlii51kj6vkYa52yALVeyhea6KbyjSd5NgQBjQvgCL3UPMtriIQzJMBLc', '{\"locale\":\"vi\"}', '2020-01-29 02:08:49', '2020-11-05 16:26:34');

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
(1, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`),
  ADD KEY `address_user_id_foreign` (`user_id`);

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
  ADD PRIMARY KEY (`attribute_value_id`,`product_attribute_id`),
  ADD KEY `product_attribute_id` (`product_attribute_id`);

--
-- Indexes for table `bills`
--
ALTER TABLE `bills`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bills_user_id_foreign` (`user_id`);

--
-- Indexes for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `bill_details_bill_id_foreign` (`bill_id`),
  ADD KEY `bill_details_product_id_foreign` (`product_id`),
  ADD KEY `bill_details_product_attribute_id_foreign` (`product_attribute_id`),
  ADD KEY `bill_details_attribute_value_id_foreign` (`attribute_value_id`);

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
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_payment_method_foreign` (`payment_method`),
  ADD KEY `orders_order_status_foreign` (`order_status`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_details_order_id_foreign` (`order_id`),
  ADD KEY `order_details_product_id_foreign` (`product_id`),
  ADD KEY `order_details_product_attribute_id_foreign` (`product_attribute_id`),
  ADD KEY `order_details_attribute_value_id_foreign` (`attribute_value_id`);

--
-- Indexes for table `order_statuses`
--
ALTER TABLE `order_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

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
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

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
-- Indexes for table `shopping_cart`
--
ALTER TABLE `shopping_cart`
  ADD PRIMARY KEY (`id`,`instance`);

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
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attribute_values`
--
ALTER TABLE `attribute_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `bill_details`
--
ALTER TABLE `bill_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=297;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD CONSTRAINT `attribute_values_attribute_id_foreign` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`);

--
-- Constraints for table `attribute_value_product_attribute`
--
ALTER TABLE `attribute_value_product_attribute`
  ADD CONSTRAINT `attr_val` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `attr_val2` FOREIGN KEY (`product_attribute_id`) REFERENCES `product_attributes` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `bills_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD CONSTRAINT `bill_details_attribute_value_id_foreign` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`),
  ADD CONSTRAINT `bill_details_bill_id_foreign` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`id`),
  ADD CONSTRAINT `bill_details_product_attribute_id_foreign` FOREIGN KEY (`product_attribute_id`) REFERENCES `product_attributes` (`id`),
  ADD CONSTRAINT `bill_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `customers`
--
ALTER TABLE `customers`
  ADD CONSTRAINT `customers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_order_status_foreign` FOREIGN KEY (`order_status`) REFERENCES `order_statuses` (`id`),
  ADD CONSTRAINT `orders_payment_method_foreign` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`id`),
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_details_attribute_value_id_foreign` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`),
  ADD CONSTRAINT `order_details_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_details_product_attribute_id_foreign` FOREIGN KEY (`product_attribute_id`) REFERENCES `product_attributes` (`id`),
  ADD CONSTRAINT `order_details_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `product_attributes_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

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
