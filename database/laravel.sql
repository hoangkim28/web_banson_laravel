-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2020 at 10:42 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `laravel`
--

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `image`, `website`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Delux', 'delux', 'brands\\February2020\\fz8CYsZHZTlUAkktqfXh.jpg', 'http://website01.vn', 1, '2020-01-29 18:20:00', '2020-02-24 10:23:06'),
(2, 'Sơn Jotun', 'son-jotun', 'brands\\February2020\\4viI80n7b1arJXP2d3D7.png', NULL, 1, '2020-02-27 00:20:34', '2020-02-27 00:20:34'),
(3, 'Sơn Mykolor', 'son-mykolor', 'brands\\February2020\\du7CkUXX3G6DG6V2SkbK.jpg', NULL, 1, '2020-02-27 00:21:25', '2020-02-27 00:21:25');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Sơn Nội Thất Dulux', 'son-noi-that-dulux', 1, '2020-01-29 09:08:49', '2020-03-11 23:14:24'),
(2, NULL, 1, 'Sơn lót', 'son-lot', 1, '2020-01-29 09:08:49', '2020-02-26 06:46:57'),
(3, NULL, 3, 'Sơn chống thấm', 'category-3', 1, '2020-02-26 07:40:54', '2020-02-26 07:40:54');

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
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, NULL, 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, NULL, 4),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, NULL, 5),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 6),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, NULL, 8),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}', 10),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 11),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, NULL, 12),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 1, 1, 1, 1, 1, 1, NULL, 9),
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 0, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}', 3),
(24, 4, 'order', 'number', 'Order', 1, 0, 0, 1, 1, 1, '{\"default\":1}', 4),
(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 5),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\"}}', 6),
(27, 4, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, '{}', 7),
(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(44, 6, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(45, 6, 'author_id', 'text', 'Author', 1, 0, 0, 0, 0, 0, NULL, 2),
(46, 6, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 3),
(47, 6, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 4),
(48, 6, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 5),
(49, 6, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}', 6),
(50, 6, 'meta_description', 'text', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 7),
(51, 6, 'meta_keywords', 'text', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 8),
(52, 6, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}', 9),
(53, 6, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 0, 0, 0, NULL, 10),
(54, 6, 'updated_at', 'timestamp', 'Updated At', 1, 0, 0, 0, 0, 0, NULL, 11),
(55, 6, 'image', 'image', 'Page Image', 0, 1, 1, 1, 1, 1, NULL, 12),
(56, 11, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(57, 11, 'author_id', 'text', 'Author Id', 1, 0, 0, 0, 0, 1, '{}', 3),
(58, 11, 'category_id', 'text', 'Category Id', 0, 0, 1, 1, 1, 1, '{}', 5),
(60, 11, 'seo_title', 'text', 'Seo Title', 0, 0, 1, 1, 1, 1, '{}', 23),
(61, 11, 'excerpt', 'text_area', 'Excerpt', 0, 0, 1, 1, 1, 1, '{}', 20),
(62, 11, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, '{}', 21),
(64, 11, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:products,slug\"}}', 22),
(65, 11, 'meta_description', 'text_area', 'Meta Description', 0, 0, 1, 1, 1, 1, '{}', 25),
(66, 11, 'meta_keywords', 'text_area', 'Meta Keywords', 0, 0, 1, 1, 1, 1, '{}', 24),
(67, 11, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}', 26),
(68, 11, 'featured', 'checkbox', 'Featured', 1, 0, 1, 1, 1, 1, '{}', 27),
(69, 11, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 1, '{}', 30),
(70, 11, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 31),
(71, 11, 'product_hasone_category_relationship', 'relationship', 'Category', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\Category\",\"table\":\"categories\",\"type\":\"belongsTo\",\"column\":\"category_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 4),
(72, 11, 'product_belongsto_user_relationship', 'relationship', 'Author', 0, 0, 1, 1, 0, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"author_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(73, 12, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(74, 12, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(75, 12, 'image', 'image', 'Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 3),
(76, 12, 'website', 'text', 'Website', 0, 1, 1, 1, 1, 1, '{}', 4),
(77, 12, 'status', 'checkbox', 'Status', 0, 1, 1, 1, 1, 1, '{\"on\":\"Active\",\"off\":\"InActive\",\"checked\":\"true\"}', 5),
(78, 12, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 6),
(79, 12, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
(80, 11, 'product_belongsto_brand_relationship', 'relationship', 'Brand', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\Brand\",\"table\":\"brands\",\"type\":\"belongsTo\",\"column\":\"brand_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 6),
(81, 11, 'brand_id', 'text', 'Brand Id', 0, 0, 1, 1, 1, 1, '{}', 7),
(82, 11, 'vendor_id', 'text', 'Vendor Id', 0, 1, 1, 1, 1, 1, '{}', 9),
(83, 15, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(84, 15, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 2),
(85, 15, 'image', 'image', 'Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 3),
(86, 15, 'website', 'text', 'Website', 0, 1, 1, 1, 1, 1, '{}', 4),
(87, 15, 'address', 'text', 'Address', 0, 1, 1, 1, 1, 1, '{}', 5),
(88, 15, 'phone', 'text', 'Phone', 0, 1, 1, 1, 1, 1, '{}', 6),
(89, 15, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
(90, 15, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(91, 11, 'product_belongsto_vendor_relationship', 'relationship', 'Vendor', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\Vendor\",\"table\":\"vendors\",\"type\":\"belongsTo\",\"column\":\"vendor_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 8),
(92, 11, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 11),
(93, 11, 'price', 'text', 'Price', 0, 1, 1, 1, 1, 1, '{\"default\":0}', 12),
(94, 11, 'cost', 'number', 'Cost', 0, 1, 1, 1, 1, 1, '{\"default\":0}', 16),
(95, 11, 'stock', 'number', 'Stock', 0, 1, 1, 1, 1, 1, '{\"default\":0}', 17),
(96, 11, 'view', 'number', 'View', 0, 1, 1, 1, 1, 1, '{\"default\":0}', 19),
(97, 11, 'date_lastview', 'date', 'Date Lastview', 1, 0, 1, 0, 0, 1, '{}', 28),
(98, 11, 'date_available', 'date', 'Date Available', 1, 0, 1, 1, 1, 1, '{}', 29),
(99, 11, 'sold', 'number', 'Sold', 0, 1, 1, 1, 1, 1, '{\"default\":0}', 18),
(100, 17, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(101, 17, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(102, 17, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 1, 0, 1, '{}', 3),
(103, 17, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(104, 20, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(105, 20, 'user_id', 'text', 'User Id', 0, 0, 0, 0, 0, 1, '{}', 3),
(106, 20, 'full_name', 'text', 'Full Name', 0, 1, 1, 1, 1, 1, '{}', 4),
(107, 20, 'address1', 'text', 'Address1', 1, 1, 1, 1, 1, 1, '{}', 5),
(108, 20, 'address2', 'text', 'Address2', 0, 1, 1, 1, 1, 1, '{}', 6),
(109, 20, 'phone', 'text', 'Phone', 1, 1, 1, 1, 1, 1, '{}', 7),
(110, 20, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{}', 8),
(111, 20, 'comment', 'text', 'Comment', 0, 1, 1, 1, 1, 1, '{}', 9),
(112, 20, 'payment_method', 'text', 'Payment Method', 0, 1, 1, 1, 1, 1, '{}', 10),
(113, 20, 'shipping_method', 'text', 'Shipping Method', 0, 1, 1, 1, 1, 1, '{}', 12),
(114, 20, 'order_status', 'text', 'Order Status', 0, 1, 1, 1, 1, 1, '{}', 14),
(115, 20, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 1, '{}', 16),
(116, 20, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 17),
(117, 20, 'order_belongsto_user_relationship', 'relationship', 'Users', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(118, 20, 'order_belongsto_order_status_relationship', 'relationship', 'Order Status', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\OrderStatus\",\"table\":\"order_statuses\",\"type\":\"belongsTo\",\"column\":\"order_status\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 15),
(119, 21, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(120, 21, 'code', 'text', 'Code', 0, 1, 1, 1, 1, 1, '{}', 2),
(121, 21, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 3),
(122, 21, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, '{}', 4),
(123, 21, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 5),
(124, 20, 'order_belongsto_shipping_status_relationship', 'relationship', 'Shipping Statuses', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\ShippingStatus\",\"table\":\"shipping_statuses\",\"type\":\"belongsTo\",\"column\":\"shipping_method\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 13),
(125, 20, 'order_belongsto_payment_method_relationship', 'relationship', 'payment_methods', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\PaymentMethod\",\"table\":\"payment_methods\",\"type\":\"belongsTo\",\"column\":\"payment_method\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 11),
(126, 23, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(127, 23, 'code', 'text', 'Code', 0, 1, 1, 1, 1, 1, '{}', 2),
(128, 23, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 3),
(129, 23, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 1, 0, 1, '{}', 4),
(130, 23, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 5),
(131, 4, 'category_hasmany_category_relationship', 'relationship', 'Parent', 0, 1, 1, 0, 0, 1, '{\"model\":\"App\\\\Models\\\\Category\",\"table\":\"categories\",\"type\":\"hasMany\",\"column\":\"parent_id\",\"key\":\"name\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(132, 24, 'id', 'number', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(133, 24, 'title', 'text', 'Title', 0, 1, 1, 1, 1, 1, '{}', 2),
(134, 24, 'image', 'image', 'Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 4),
(135, 24, 'url', 'text', 'Url', 1, 1, 1, 1, 1, 1, '{}', 5),
(136, 24, 'showon', 'radio_btn', 'Show on', 0, 1, 1, 1, 1, 1, '{\"0\":\"Home\",\"options\":{\"0\":\"Home\",\"1\":\"Cart\",\"2\":\"Product\"}}', 6),
(137, 24, 'status', 'select_dropdown', 'Status', 0, 1, 1, 1, 1, 1, '{\"options\":{\"0\":\"Active\",\"1\":\"InActive\"}}', 7),
(138, 24, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 8),
(139, 24, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9),
(140, 11, 'promotion', 'select_dropdown', 'Promotion', 1, 1, 1, 1, 1, 1, '{\"0\":\"Kh\\u00f4ng gi\\u1ea3m\",\"options\":{\"0\":\"Kh\\u00f4ng gi\\u1ea3m\",\"1\":\"Gi\\u1ea3m 1%\",\"2\":\"Gi\\u1ea3m 2%\",\"3\":\"Gi\\u1ea3m 3%\",\"4\":\"Gi\\u1ea3m 4%\",\"5\":\"Gi\\u1ea3m 5%\",\"6\":\"Gi\\u1ea3m 6%\",\"7\":\"Gi\\u1ea3m 7%\",\"8\":\"Gi\\u1ea3m 8%\",\"9\":\"Gi\\u1ea3m 9%\",\"10\":\"Gi\\u1ea3m 10%\",\"11\":\"Gi\\u1ea3m 11%\",\"12\":\"Gi\\u1ea3m 12%\",\"13\":\"Gi\\u1ea3m 13%\",\"14\":\"Gi\\u1ea3m 14%\",\"15\":\"Gi\\u1ea3m 15%\",\"16\":\"Gi\\u1ea3m 16%\",\"17\":\"Gi\\u1ea3m 17%\",\"18\":\"Gi\\u1ea3m 18%\",\"19\":\"Gi\\u1ea3m 19%\",\"20\":\"Gi\\u1ea3m 20%\",\"21\":\"Gi\\u1ea3m 21%\",\"22\":\"Gi\\u1ea3m 22%\",\"23\":\"Gi\\u1ea3m 23%\",\"24\":\"Gi\\u1ea3m 24%\",\"25\":\"Gi\\u1ea3m 25%\",\"26\":\"Gi\\u1ea3m 26%\",\"27\":\"Gi\\u1ea3m 27%\",\"28\":\"Gi\\u1ea3m 28%\",\"29\":\"Gi\\u1ea3m 29%\",\"30\":\"Gi\\u1ea3m 30%\",\"31\":\"Gi\\u1ea3m 31%\",\"32\":\"Gi\\u1ea3m 32%\",\"33\":\"Gi\\u1ea3m 33%\",\"34\":\"Gi\\u1ea3m 34%\",\"35\":\"Gi\\u1ea3m 35%\",\"36\":\"Gi\\u1ea3m 36%\",\"37\":\"Gi\\u1ea3m 37%\",\"38\":\"Gi\\u1ea3m 38%\",\"39\":\"Gi\\u1ea3m 39%\",\"40\":\"Gi\\u1ea3m 40%\",\"41\":\"Gi\\u1ea3m 41%\",\"42\":\"Gi\\u1ea3m 42%\",\"43\":\"Gi\\u1ea3m 43%\",\"44\":\"Gi\\u1ea3m 44%\",\"45\":\"Gi\\u1ea3m 45%\",\"46\":\"Gi\\u1ea3m 46%\",\"47\":\"Gi\\u1ea3m 47%\",\"48\":\"Gi\\u1ea3m 48%\",\"49\":\"Gi\\u1ea3m 49%\",\"50\":\"Gi\\u1ea3m 50%\",\"51\":\"Gi\\u1ea3m 51%\",\"52\":\"Gi\\u1ea3m 52%\",\"53\":\"Gi\\u1ea3m 53%\",\"54\":\"Gi\\u1ea3m 54%\",\"55\":\"Gi\\u1ea3m 55%\",\"56\":\"Gi\\u1ea3m 56%\",\"57\":\"Gi\\u1ea3m 57%\",\"58\":\"Gi\\u1ea3m 58%\",\"59\":\"Gi\\u1ea3m 59%\",\"60\":\"Gi\\u1ea3m 60%\",\"61\":\"Gi\\u1ea3m 61%\",\"62\":\"Gi\\u1ea3m 62%\",\"63\":\"Gi\\u1ea3m 63%\",\"64\":\"Gi\\u1ea3m 64%\",\"65\":\"Gi\\u1ea3m 65%\",\"66\":\"Gi\\u1ea3m 66%\",\"67\":\"Gi\\u1ea3m 67%\",\"68\":\"Gi\\u1ea3m 68%\",\"69\":\"Gi\\u1ea3m 69%\",\"70\":\"Gi\\u1ea3m 70%\",\"71\":\"Gi\\u1ea3m 71%\",\"72\":\"Gi\\u1ea3m 72%\",\"73\":\"Gi\\u1ea3m 73%\",\"74\":\"Gi\\u1ea3m 74%\",\"75\":\"Gi\\u1ea3m 75%\",\"76\":\"Gi\\u1ea3m 76%\",\"77\":\"Gi\\u1ea3m 77%\",\"78\":\"Gi\\u1ea3m 78%\",\"79\":\"Gi\\u1ea3m 79%\",\"80\":\"Gi\\u1ea3m 80%\",\"81\":\"Gi\\u1ea3m 81%\",\"82\":\"Gi\\u1ea3m 82%\",\"83\":\"Gi\\u1ea3m 83%\",\"84\":\"Gi\\u1ea3m 84%\",\"85\":\"Gi\\u1ea3m 85%\",\"86\":\"Gi\\u1ea3m 86%\",\"87\":\"Gi\\u1ea3m 87%\",\"88\":\"Gi\\u1ea3m 88%\",\"89\":\"Gi\\u1ea3m 89%\",\"90\":\"Gi\\u1ea3m 90%\",\"91\":\"Gi\\u1ea3m 91%\",\"92\":\"Gi\\u1ea3m 92%\",\"93\":\"Gi\\u1ea3m 93%\",\"94\":\"Gi\\u1ea3m 94%\",\"95\":\"Gi\\u1ea3m 95%\",\"96\":\"Gi\\u1ea3m 96%\",\"97\":\"Gi\\u1ea3m 97%\",\"98\":\"Gi\\u1ea3m 98%\",\"99\":\"Gi\\u1ea3m 99%\"}}', 15),
(141, 11, 'avatar', 'image', 'Avatar', 0, 0, 1, 1, 1, 1, '{}', 13),
(142, 11, 'images', 'multiple_images', 'Images', 1, 0, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 14),
(143, 12, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:brands,slug\"}}', 3),
(144, 11, 'sku', 'text', 'Sku', 1, 1, 1, 1, 1, 1, '{\"validation\":{\"rule\":\"unique:products,sku\"}}', 10),
(145, 4, 'status', 'checkbox', 'Status', 1, 1, 1, 1, 1, 1, '{\"on\":\"Active\",\"off\":\"InActive\",\"checked\":\"true\"}', 6),
(146, 24, 'content', 'text', 'Content', 1, 0, 1, 1, 1, 1, '{}', 3),
(147, 4, 'category_hasmany_product_relationship', 'relationship', 'products', 0, 0, 0, 0, 0, 1, '{\"model\":\"App\\\\Models\\\\Product\",\"table\":\"products\",\"type\":\"hasMany\",\"column\":\"category_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"brands\",\"pivot\":\"0\",\"taggable\":\"0\"}', 9);

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
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, '', '', 1, 0, NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'App\\Models\\Category', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 09:08:49', '2020-03-12 01:30:49'),
(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(11, 'products', 'products', 'Product', 'Products', 'voyager-anchor', 'App\\Models\\Product', 'App\\Policies\\ProductPolicy', NULL, NULL, 1, 0, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 16:14:00', '2020-04-06 22:35:52'),
(12, 'brands', 'brands', 'Brand', 'Brands', 'voyager-company', 'App\\Models\\Brand', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-29 18:16:17', '2020-02-24 09:59:01'),
(15, 'vendors', 'vendors', 'Vendor', 'Vendors', 'voyager-company', 'App\\Models\\Vendor', NULL, NULL, NULL, 1, 0, '{\"order_column\":\"created_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"name\",\"scope\":null}', '2020-01-29 18:33:03', '2020-02-24 09:59:27'),
(17, 'order_statuses', 'order-statuses', 'Order Status', 'Order Statuses', 'voyager-info-circled', 'App\\Models\\OrderStatus', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-30 00:00:44', '2020-01-30 00:01:54'),
(19, 'order', 'order', 'Order', 'Orders', NULL, 'App\\Models\\Order', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-01-30 00:04:33', '2020-01-30 00:04:33'),
(20, 'orders', 'orders', 'Order', 'Orders', NULL, 'App\\Models\\Order', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-30 00:05:19', '2020-01-30 01:13:49'),
(21, 'shipping_statuses', 'shipping-statuses', 'Shipping Status', 'Shipping Statuses', 'voyager-code', 'App\\Models\\ShippingStatus', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-01-30 01:04:30', '2020-01-30 01:04:30'),
(23, 'payment_methods', 'payment-methods', 'Payment Method', 'Payment Methods', 'voyager-code', 'App\\Models\\PaymentMethod', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-01-30 01:10:13', '2020-01-30 01:15:16'),
(24, 'slides', 'slides', 'Slide', 'Slides', NULL, 'App\\Models\\Slide', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-02-12 00:24:31', '2020-03-10 20:54:11');

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
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2020-01-29 09:08:49', '2020-01-29 09:08:49', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 7, '2020-01-29 09:08:49', '2020-02-12 00:24:54', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, 20, 2, '2020-01-29 09:08:49', '2020-01-29 23:14:38', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, 20, 1, '2020-01-29 09:08:49', '2020-01-29 23:14:36', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 8, '2020-01-29 09:08:49', '2020-02-12 00:24:54', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2020-01-29 09:08:49', '2020-01-29 16:50:12', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2020-01-29 09:08:49', '2020-01-29 16:50:12', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2020-01-29 09:08:49', '2020-01-29 16:50:12', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2020-01-29 09:08:49', '2020-01-29 16:50:12', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 9, '2020-01-29 09:08:49', '2020-02-12 00:24:54', 'voyager.settings.index', NULL),
(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, 19, 1, '2020-01-29 09:08:49', '2020-01-29 18:36:34', 'voyager.categories.index', NULL),
(13, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, NULL, 6, '2020-01-29 09:08:49', '2020-02-12 00:24:54', 'voyager.pages.index', NULL),
(14, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 5, '2020-01-29 09:08:50', '2020-01-29 16:50:12', 'voyager.hooks', NULL),
(15, 1, 'Products', '', '_self', 'voyager-anchor', NULL, 19, 4, '2020-01-29 16:14:00', '2020-01-29 18:36:51', 'voyager.products.index', NULL),
(16, 1, 'Brands', '', '_self', 'voyager-company', '#000000', 19, 3, '2020-01-29 18:16:18', '2020-01-29 18:36:51', 'voyager.brands.index', 'null'),
(17, 1, 'Vendors', '/admin/vendors', '_self', 'voyager-company', '#000000', 19, 2, '2020-01-29 18:29:28', '2020-01-29 18:36:34', NULL, ''),
(19, 1, 'Shop Manager', '', '_self', 'voyager-helm', '#000000', NULL, 2, '2020-01-29 18:34:54', '2020-01-29 18:37:44', NULL, ''),
(20, 1, 'User Manager', '', '_self', 'voyager-github', '#000000', NULL, 3, '2020-01-29 23:14:26', '2020-01-29 23:16:23', NULL, ''),
(21, 1, 'Order Statuses', '', '_self', 'voyager-info-circled', NULL, 24, 2, '2020-01-30 00:00:44', '2020-01-30 01:15:29', 'voyager.order-statuses.index', NULL),
(23, 1, 'Orders', '', '_self', 'voyager-basket', '#000000', 24, 1, '2020-01-30 00:05:19', '2020-01-30 00:42:37', 'voyager.orders.index', 'null'),
(24, 1, 'Order Manager', '', '_self', 'voyager-bag', '#000000', NULL, 4, '2020-01-30 00:06:29', '2020-01-30 00:07:55', NULL, ''),
(25, 1, 'Shipping Statuses', '', '_self', 'voyager-code', NULL, 24, 4, '2020-01-30 01:04:30', '2020-01-30 01:15:36', 'voyager.shipping-statuses.index', NULL),
(26, 1, 'Payment Methods', '', '_self', 'voyager-code', NULL, 24, 3, '2020-01-30 01:10:13', '2020-01-30 01:15:35', 'voyager.payment-methods.index', NULL),
(27, 1, 'Slides', '', '_self', 'voyager-photo', '#000000', NULL, 5, '2020-02-12 00:24:31', '2020-02-12 00:25:22', 'voyager.slides.index', 'null');

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
(26, '2018_03_16_000000_make_settings_value_nullable', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `full_name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `address2` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) NOT NULL,
  `email` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_method` tinyint(4) DEFAULT NULL,
  `shipping_method` tinyint(4) DEFAULT NULL,
  `order_status` tinyint(4) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `full_name`, `address1`, `address2`, `phone`, `email`, `comment`, `payment_method`, `shipping_method`, `order_status`, `created_at`, `updated_at`) VALUES
(1, 1, '123', '123', '123', 123, '123', '123', NULL, NULL, 1, '2020-01-30 00:43:00', '2020-01-30 00:48:22');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
(1, 'New', '2020-01-30 00:02:11', '2020-01-30 00:02:11'),
(2, 'Processing', '2020-01-30 00:02:27', '2020-01-30 00:02:27'),
(3, 'Cancel', '2020-01-30 00:02:53', '2020-01-30 00:02:53'),
(4, 'Done', '2020-01-30 00:03:00', '2020-01-30 00:03:00');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
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

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 'Hello World', 'Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.', '<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', 'pages/page1.jpg', 'hello-world', 'Yar Meta Description', 'Keyword1, Keyword2', 'ACTIVE', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(2, 1, '123123', '123123', '<p><strong>ấkHJDGVHẤY&Uacute;G D&Aacute;UD</strong></p>\r\n<p><strong>&Aacute; D</strong></p>\r\n<p><strong>&Aacute;</strong></p>\r\n<p><strong>D </strong></p>\r\n<p><strong>&Aacute;D</strong></p>\r\n<p><strong>&nbsp;&Aacute;</strong></p>\r\n<p><strong>D</strong></p>', 'pages\\March2020\\sMW2f6C6p5r0Amqffxin.jpeg', '123123', '12312', '12312', 'INACTIVE', '2020-03-10 23:26:56', '2020-03-10 23:26:56');

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
(2, 'atm', 'Chuyển Khoản', '2020-02-12 00:30:08', '2020-02-12 00:30:08'),
(3, 'contract', 'Contract', '2020-02-12 00:30:36', '2020-02-12 00:30:36');

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
(36, 'browse_pages', 'pages', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(37, 'read_pages', 'pages', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(38, 'edit_pages', 'pages', '2020-01-29 09:08:49', '2020-01-29 09:08:49'),
(39, 'add_pages', 'pages', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(40, 'delete_pages', 'pages', '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(41, 'browse_hooks', NULL, '2020-01-29 09:08:50', '2020-01-29 09:08:50'),
(42, 'browse_products', 'products', '2020-01-29 16:14:00', '2020-01-29 16:14:00'),
(43, 'read_products', 'products', '2020-01-29 16:14:00', '2020-01-29 16:14:00'),
(44, 'edit_products', 'products', '2020-01-29 16:14:00', '2020-01-29 16:14:00'),
(45, 'add_products', 'products', '2020-01-29 16:14:00', '2020-01-29 16:14:00'),
(46, 'delete_products', 'products', '2020-01-29 16:14:00', '2020-01-29 16:14:00'),
(47, 'browse_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(48, 'read_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(49, 'edit_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(50, 'add_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(51, 'delete_brands', 'brands', '2020-01-29 18:16:17', '2020-01-29 18:16:17'),
(52, 'browse_vendors', 'vendors', '2020-01-29 18:33:03', '2020-01-29 18:33:03'),
(53, 'read_vendors', 'vendors', '2020-01-29 18:33:03', '2020-01-29 18:33:03'),
(54, 'edit_vendors', 'vendors', '2020-01-29 18:33:03', '2020-01-29 18:33:03'),
(55, 'add_vendors', 'vendors', '2020-01-29 18:33:03', '2020-01-29 18:33:03'),
(56, 'delete_vendors', 'vendors', '2020-01-29 18:33:03', '2020-01-29 18:33:03'),
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
(72, 'browse_shipping_statuses', 'shipping_statuses', '2020-01-30 01:04:30', '2020-01-30 01:04:30'),
(73, 'read_shipping_statuses', 'shipping_statuses', '2020-01-30 01:04:30', '2020-01-30 01:04:30'),
(74, 'edit_shipping_statuses', 'shipping_statuses', '2020-01-30 01:04:30', '2020-01-30 01:04:30'),
(75, 'add_shipping_statuses', 'shipping_statuses', '2020-01-30 01:04:30', '2020-01-30 01:04:30'),
(76, 'delete_shipping_statuses', 'shipping_statuses', '2020-01-30 01:04:30', '2020-01-30 01:04:30'),
(77, 'browse_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(78, 'read_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(79, 'edit_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(80, 'add_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(81, 'delete_payment_methods', 'payment_methods', '2020-01-30 01:10:13', '2020-01-30 01:10:13'),
(82, 'browse_slides', 'slides', '2020-02-12 00:24:31', '2020-02-12 00:24:31'),
(83, 'read_slides', 'slides', '2020-02-12 00:24:31', '2020-02-12 00:24:31'),
(84, 'edit_slides', 'slides', '2020-02-12 00:24:31', '2020-02-12 00:24:31'),
(85, 'add_slides', 'slides', '2020-02-12 00:24:31', '2020-02-12 00:24:31'),
(86, 'delete_slides', 'slides', '2020-02-12 00:24:31', '2020-02-12 00:24:31');

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
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
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
(72, 1),
(73, 1),
(74, 1),
(75, 1),
(76, 1),
(77, 1),
(78, 1),
(79, 1),
(80, 1),
(81, 1),
(82, 1),
(83, 1),
(84, 1),
(85, 1),
(86, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `brand_id` int(11) DEFAULT NULL,
  `vendor_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sku` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `price` int(11) DEFAULT NULL,
  `promotion` int(11) NOT NULL DEFAULT 0,
  `cost` int(11) DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `sold` int(11) DEFAULT 0,
  `view` int(11) DEFAULT NULL,
  `date_lastview` datetime NOT NULL,
  `date_available` datetime NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `author_id`, `category_id`, `brand_id`, `vendor_id`, `name`, `sku`, `seo_title`, `excerpt`, `body`, `avatar`, `images`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `price`, `promotion`, `cost`, `stock`, `sold`, `view`, `date_lastview`, `date_available`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 1, NULL, 'Lorem Ipsum Post 04', '45345', NULL, 'This is the excerpt for the Lorem Ipsum Post', '<p>This is the body of the lorem ipsum post</p>', 'products\\February2020\\mzYJuyj50xMXpVdlZyPn.png', '', 'lorem-ipsum-post-04', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 1, 123123, 0, 0, 8, 3, 0, '2020-02-26 14:30:11', '2020-02-26 14:30:11', '2020-01-29 09:08:00', '2020-02-26 07:30:11'),
(2, 1, 3, 1, NULL, 'My Sample Post 23 ghgghs uyuy ád iqywuie  quưyeu ád qưe ád qưe', '27637dghsu', NULL, 'This is the excerpt for the sample Post', '<p>This is the body for the sample post, which includes the body.</p>\r\n<h2>We can use all kinds of format!</h2>\r\n<p>And include a bunch of other stuff.</p>', 'products\\February2020\\sNFo7cuDf1K0jM7TAr4l.png', '', 'my-sample-post-23-ghgghs-uyuy-ad-iqywuie-quuyeu-ad-que-ad-que', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', 'PUBLISHED', 1, 1300000, 55, 0, 4, 2, 0, '2020-04-07 05:19:10', '2020-04-07 05:19:10', '2020-01-29 09:08:00', '2020-04-06 22:19:10'),
(3, 2, 1, 1, NULL, 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng', 'NTD01', 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng', 'Dulux Ambiance 5in1 Superflexx - Siêu Bóng với Công nghệ Superflexx tiên tiến cho màng sơn linh hoạt co giãn gấp 3 lần so với các loại sơn nội thất cao cấp trên thị trường, giúp che phủ các vết rạn nứt nhỏ và bảo vệ màng sơn luôn bền đẹp', '<h1>Giới thiệu sản phẩm</h1>\r\n<p>Dulux Ambiance 5in1 Superflexx - Si&ecirc;u B&oacute;ng với C&ocirc;ng nghệ Superflexx ti&ecirc;n tiến cho m&agrave;ng sơn linh hoạt co gi&atilde;n gấp 3 lần so với c&aacute;c loại sơn nội thất cao cấp tr&ecirc;n thị trường, gi&uacute;p che phủ c&aacute;c vết rạn nứt nhỏ v&agrave; bảo vệ m&agrave;ng sơn lu&ocirc;n bền đẹp</p>\r\n<p>&nbsp;</p>\r\n<h1>Hướng dẫn thi c&ocirc;ng</h1>\r\n<p>Sơn bằng cọ hoặc rul&ocirc; hoặc m&aacute;y phun sơn</p>\r\n<p>&nbsp;</p>\r\n<h1>Th&ocirc;ng Tin Về An To&agrave;n, Sức Khỏe V&agrave; M&ocirc;i Trường</h1>\r\n<p>Hazard warnings</p>\r\n<p>- C&aacute;c xử l&yacute; như: xả nh&aacute;m, đốt m&agrave;ng sơn sẽ tạo bụi v&agrave;/hoặc kh&oacute;i độc. N&ecirc;n xả nh&aacute;m ướt nếu c&oacute; thể. L&agrave;m việc trong khu vực th&ocirc;ng tho&aacute;ng. Sử dụng đồ bảo hộ th&iacute;ch hợp khi thi c&ocirc;ng. - Mang găng tay v&agrave; k&iacute;nh bảo vệ mắt - Tr&aacute;nh h&iacute;t hơi/bụi sơn - Chỉ thi c&ocirc;ng tại khu vực th&ocirc;ng tho&aacute;ng. - Lấy lại lượng sơn c&ograve;n dư tr&ecirc;n cọ hoặc rul&ocirc; c&agrave;ng nhiều c&agrave;ng tốt trước khi rửa. - Tr&aacute;nh thải sơn ra m&ocirc;i trường. - Thu gom tr&agrave;n đổ. - Tr&aacute;nh xa nguồn thực phẩm, nước uống v&agrave; thức ăn động vật - Khi bị d&iacute;nh sơn v&agrave;o mắt, lập tức rửa mắt với nhiều nước sạch v&agrave; đến gặp b&aacute;c sĩ ngay. - Khi bị d&iacute;nh sơn v&agrave;o da, lập tức rửa v&ugrave;ng phơi nhiễm với x&agrave; ph&ograve;ng/ sản phẩm l&agrave;m sạch da ph&ugrave; hợp v&agrave; nước sạch. Kh&ocirc;ng sử dụng dung m&ocirc;i. - Kh&ocirc;ng đổ sơn v&agrave;o cống r&atilde;nh hay nguồn nước. - Th&ocirc;ng tin an to&agrave;n sản phẩm được cung cấp theo y&ecirc;u cầu sử dụng. - Để xa tầm tay trẻ em. - Mang theo th&ugrave;ng sơn hoặc nh&atilde;n sản phẩm khi cần tư vấn y khoa. - Tr&aacute;nh tiếp x&uacute;c với mắt, da hoặc l&ecirc;n quần &aacute;o. - Nếu cảm thấy kh&ocirc;ng khỏe, h&atilde;y gọi cho TRUNG T&Acirc;M CHỐNG ĐỘC hoặc b&aacute;c sĩ. - Thải bỏ sơn v&agrave; th&ugrave;ng chứa ph&ugrave; hợp với c&aacute;c quy định địa phương, khu vực, quốc gia v&agrave; quốc tế.</p>\r\n<p><img src=\"http://sonthanhtanh.com/storage/products/January2020/Screenshot (1).png\" alt=\"\" width=\"949\" height=\"534\" /></p>', 'products\\February2020\\5x9Wix38XTQ3RDe99obl.png', '', 'dulux-ambiance-5in1-superflexx-sieu-bong', 'This is the meta description', 'dulux, Superflexx', 'PUBLISHED', 1, 1600000, 0, 0, 50, 3, 0, '2020-03-12 06:19:47', '2020-03-12 06:19:47', '2020-01-29 09:08:00', '2020-03-11 23:19:47'),
(4, 1, 2, 2, NULL, 'Yarr Post', '12323', NULL, 'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.', '<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\r\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\r\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>', 'products\\February2020\\ZTkBkKDhBsvoBUabTpxV.png', '', 'yarr-post', 'this be a meta descript', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, 12323123, 60, 0, 14, 1, 0, '2020-04-07 05:36:28', '2020-04-07 05:36:28', '2020-01-29 09:08:00', '2020-04-06 22:36:28'),
(5, 1, 1, 1, NULL, '123', 'DEMC04', NULL, '123', '<p>123</p>', 'products\\February2020\\4Vn7XEfJuUnek3UtI9f4.png', '[\"products\\\\February2020\\\\QDAq1fBeHTx0I0XdMafb.png\",\"products\\\\February2020\\\\6JDqEAoUrskgBd7EetQY.jpg\"]', '123', NULL, NULL, 'PUBLISHED', 1, 1, 0, 0, 0, 7, 0, '2020-02-26 15:03:33', '2020-02-26 15:03:33', '2020-02-23 23:52:26', '2020-02-26 08:03:33');

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
(2, 'user', 'Normal User', '2020-01-29 09:08:49', '2020-01-29 09:08:49');

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
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', 'settings\\March2020\\w6MXaAczE13rxZ54spLp.jpg', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Sơn Thành Tánh', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', NULL, '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `shipping_statuses`
--

CREATE TABLE `shipping_statuses` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `shipping_statuses`
--

INSERT INTO `shipping_statuses` (`id`, `code`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Processing', 'Processing', '2020-02-12 00:28:22', '2020-02-12 00:28:22'),
(2, 'done', 'Done', '2020-02-12 00:28:44', '2020-02-12 00:28:44');

-- --------------------------------------------------------

--
-- Table structure for table `slides`
--

CREATE TABLE `slides` (
  `id` int(10) UNSIGNED NOT NULL,
  `title` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `url` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `showon` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slides`
--

INSERT INTO `slides` (`id`, `title`, `content`, `image`, `url`, `showon`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Khuyến mãi dành cho Chất Chống Thấm Dulux WeatherShield', 'Đối tượng áp dụng: Tất cả các nhà thầu đang tham gia chương trình Nhà thầu Chuyên nghiệp Dulux.', 'slides\\March2020\\kP7uOKBfMau66VrQOwOJ.jpg', 'url01', 0, 0, '2020-02-12 01:14:00', '2020-03-11 23:09:50'),
(2, 'Slide 02 jshdahs jhdjah s ajshd jahsj ajshdjqw oiqweiou iosudiasud qwewds]', '', 'slides\\February2020\\9oEjdO3JkA3AB5dAyx9z.jpg', 'url01', 0, 0, '2020-02-12 01:14:00', '2020-02-22 08:51:39'),
(3, 'aghjsdyuáyugui', 'jkdahsjidha úidúyg', 'slides\\March2020\\xijqkAD50Uw1epjM9KX6.jpeg', 'sjdhsdhsjh jsdhsjds', 0, 0, '2020-03-10 21:08:33', '2020-03-10 21:08:33');

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
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `birthday` date DEFAULT '2020-01-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`, `address`, `phone`, `birthday`) VALUES
(1, 1, 'Admin', 'admin@admin.com', 'users\\February2020\\pqLlVihx5BoLMwKR6DZM.jpg', NULL, '$2y$10$yJU6j4Qza.ilngULKbeGqOITjxHlOaEWiNHNnnGOU3rTDtvqnp/1a', 'GdVtRhgYQqQuohKlLm5xEoLPWV9IN9fSxwp1mOv668vl9Z0wYmLAlofodCsh', '{\"locale\":\"en\"}', '2020-01-29 09:08:49', '2020-02-03 00:19:06', NULL, NULL, '2020-01-01'),
(2, 2, 'ajsdhjasj', 'sdjhsjsjdshjdsh@sdjhs.com', 'users/default.png', NULL, '$2y$10$yJU6j4Qza.ilngULKbeGqOITjxHlOaEWiNHNnnGOU3rTDtvqnp/1a', NULL, '{\"locale\":\"en\"}', '2020-01-29 16:55:35', '2020-01-29 20:57:44', NULL, NULL, '2020-01-01'),
(3, 2, 'AJSHDJASJ', 'nguoidung@nguoidung.com', 'users/default.png', NULL, '$2y$10$ThwdsV7OZobVrsne6hmJ8uMMJIR8YZFyILFM2tij2M8X3Ub8PQVxy', NULL, NULL, '2020-03-10 23:31:27', '2020-03-10 23:31:27', NULL, NULL, '2020-01-01');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendors`
--

CREATE TABLE `vendors` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` int(11) DEFAULT NULL,
  `website` int(11) DEFAULT NULL,
  `address` int(11) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

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
  ADD UNIQUE KEY `posts_slug_unique` (`slug`);

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
-- Indexes for table `shipping_statuses`
--
ALTER TABLE `shipping_statuses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `slides`
--
ALTER TABLE `slides`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `vendors`
--
ALTER TABLE `vendors`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=148;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `shipping_statuses`
--
ALTER TABLE `shipping_statuses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `slides`
--
ALTER TABLE `slides`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `vendors`
--
ALTER TABLE `vendors`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

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
