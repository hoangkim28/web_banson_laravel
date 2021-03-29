-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 29, 2021 at 08:04 AM
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
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `province_id` bigint(20) UNSIGNED NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `ward_id` bigint(20) UNSIGNED NOT NULL,
  `address` varchar(100) COLLATE utf8_vietnamese_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `attributes`
--

INSERT INTO `attributes` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'Kích thước', '2021-03-29 05:49:56', '2021-03-29 05:49:56'),
(2, 'Bản màu', '2021-03-29 05:49:56', '2021-03-29 05:49:56');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `attribute_value_product_attribute`
--

CREATE TABLE `attribute_value_product_attribute` (
  `attribute_value_id` bigint(20) UNSIGNED NOT NULL,
  `product_attribute_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `bills`
--

CREATE TABLE `bills` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `full_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address1` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address2` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `comment` int(11) DEFAULT NULL,
  `payment_method` int(11) DEFAULT NULL,
  `subtotal` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `bill_details`
--

CREATE TABLE `bill_details` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL,
  `product_price` int(11) NOT NULL,
  `product_attribute_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `website` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `parent_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `category_attributes`
--

CREATE TABLE `category_attributes` (
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `attribute_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'Người dùng', 'Người dùng', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(3, 'roles', 'roles', 'Phân Quyền', 'Phân Quyền', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(4, 'categories', 'categories', 'Danh mục sản phẩm', 'Danh mục sản phẩm', 'voyager-categories', 'App\\Models\\Category', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":\"name\",\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(12, 'brands', 'brands', 'Thương hiệu', 'Thương hiệu', 'voyager-company', 'App\\Models\\Brand', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(17, 'order_statuses', 'order-statuses', 'Order Status', 'Order Statuses', 'voyager-info-circled', 'App\\Models\\OrderStatus', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(19, 'order', 'order', 'Order', 'Orders', NULL, 'App\\Models\\Order', NULL, 'App\\Http\\Controllers\\Admin\\OrderController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(20, 'orders', 'orders', 'Đơn hàng', 'Đơn hàng', 'voyager-basket', 'App\\Models\\Order', NULL, 'App\\Http\\Controllers\\Admin\\OrderController', NULL, 1, 1, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"phone\",\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(23, 'payment_methods', 'payment-methods', 'Payment Method', 'Payment Methods', 'voyager-code', 'App\\Models\\PaymentMethod', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(25, 'product_attribute', 'product-attribute', 'Product Attribute', 'Product Attributes', NULL, 'App\\Models\\ProductAttribute', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(27, 'products', 'products', 'Sản phẩm', 'Sản phẩm', 'voyager-data', 'App\\Models\\Product', NULL, 'App\\Http\\Controllers\\Admin\\ProductController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(38, 'attributes', 'attributes', 'Thuộc tính sản phẩm', 'Thuộc tính sản phẩm', NULL, 'App\\Models\\Attribute', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(39, 'attribute_values', 'attribute-values', 'Giá trị của thuộc tính', 'Giá trị của các thuộc tính', NULL, 'App\\Models\\AttributeValue', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(40, 'customers', 'customers', 'Khách hàng', 'Khách hàng', 'voyager-people', 'App\\Models\\Customer', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46'),
(41, 'bills', 'bills', 'Hóa đơn', 'Hóa đơn', 'voyager-bar-chart', 'App\\Models\\Bill', NULL, 'App\\Http\\Controllers\\Admin\\BillController', NULL, 1, 1, '{\"order_column\":\"updated_at\",\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":\"phone\",\"scope\":null}', '2021-03-29 05:56:46', '2021-03-29 05:56:46');

-- --------------------------------------------------------

--
-- Table structure for table `districts`
--

CREATE TABLE `districts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gso_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `province_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `inventories`
--

CREATE TABLE `inventories` (
  `id` bigint(20) NOT NULL,
  `notes` varchar(500) COLLATE utf8_vietnamese_ci DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` date NOT NULL,
  `updated_at` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory_details`
--

CREATE TABLE `inventory_details` (
  `id` bigint(20) NOT NULL,
  `inventory_id` bigint(20) NOT NULL,
  `product_attribute_id` bigint(20) UNSIGNED NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_vietnamese_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2021-03-29 05:56:04', '2021-03-29 05:56:04');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Trang chủ', '', '_self', 'voyager-boat', '#000000', NULL, 1, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.dashboard', 'null'),
(2, 1, 'Phương tiện', '', '_self', 'voyager-images', '#000000', NULL, 5, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.media.index', 'null'),
(3, 1, 'Người dùng', '', '_self', 'voyager-person', '#000000', 20, 2, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.users.index', 'null'),
(4, 1, 'Quyền - Nhóm quyền', '', '_self', 'voyager-lock', '#000000', 20, 1, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.roles.index', 'null'),
(5, 1, 'Công cụ', '', '_self', 'voyager-tools', '#000000', NULL, 7, '2021-03-29 05:59:05', '2021-03-29 05:59:05', NULL, ''),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.bread.index', NULL),
(10, 1, 'Cài đặt hệ thống', '', '_self', 'voyager-settings', '#000000', 5, 8, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.settings.index', 'null'),
(11, 1, 'Danh mục sản phẩm', '', '_self', 'voyager-categories', '#000000', 19, 1, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.categories.index', 'null'),
(14, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 5, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.hooks', NULL),
(16, 1, 'Thương hiệu', '', '_self', 'voyager-company', '#000000', 19, 2, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.brands.index', 'null'),
(19, 1, 'Sản phẩm', '', '_self', 'voyager-helm', '#000000', NULL, 3, '2021-03-29 05:59:05', '2021-03-29 05:59:05', NULL, ''),
(20, 1, 'Người dùng', '', '_self', 'voyager-github', '#000000', NULL, 4, '2021-03-29 05:59:05', '2021-03-29 05:59:05', NULL, ''),
(21, 1, 'Trạng thái đơn hàng', '', '_self', 'voyager-info-circled', '#000000', 5, 6, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.order-statuses.index', 'null'),
(23, 1, 'Danh sách Đơn hàng', '', '_self', 'voyager-basket', '#000000', 24, 1, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.orders.index', 'null'),
(24, 1, 'Đơn hàng', '', '_self', 'voyager-bag', '#000000', NULL, 2, '2021-03-29 05:59:05', '2021-03-29 05:59:05', NULL, ''),
(26, 1, 'P.Thức Thanh toán', '', '_self', 'voyager-code', '#000000', 5, 7, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.payment-methods.index', 'null'),
(34, 1, 'Sản phẩm', '', '_self', 'voyager-data', '#000000', 19, 3, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.products.index', 'null'),
(46, 1, 'Thuộc tính sản phẩm', '', '_self', 'voyager-wand', '#000000', 48, 2, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.attributes.index', 'null'),
(47, 1, 'Giá trị của các thuộc tính', '', '_self', 'voyager-wand', '#000000', 48, 1, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.attribute-values.index', 'null'),
(48, 1, 'Thuộc tính Sản phẩm', '', '_self', 'voyager-params', '#000000', NULL, 6, '2021-03-29 05:59:05', '2021-03-29 05:59:05', NULL, ''),
(49, 1, 'Khách hàng', '', '_self', 'voyager-people', NULL, 20, 3, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.customers.index', NULL),
(50, 1, 'Hóa đơn', '', '_self', 'voyager-bar-chart', NULL, 24, 2, '2021-03-29 05:59:05', '2021-03-29 05:59:05', 'voyager.bills.index', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
  `payment_method` tinyint(3) UNSIGNED DEFAULT NULL,
  `order_status` tinyint(3) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `subtotal` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tax` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `total` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
  `product_attribute_id` int(11) DEFAULT NULL,
  `product_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_sku` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(7) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `order_statuses`
--

CREATE TABLE `order_statuses` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `payment_methods`
--

CREATE TABLE `payment_methods` (
  `id` tinyint(3) UNSIGNED NOT NULL,
  `code` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(2, 'browse_bread', NULL, '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(3, 'browse_database', NULL, '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(4, 'browse_media', NULL, '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(5, 'browse_compass', NULL, '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(6, 'browse_menus', 'menus', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(7, 'read_menus', 'menus', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(8, 'edit_menus', 'menus', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(9, 'add_menus', 'menus', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(10, 'delete_menus', 'menus', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(11, 'browse_roles', 'roles', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(12, 'read_roles', 'roles', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(13, 'edit_roles', 'roles', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(14, 'add_roles', 'roles', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(15, 'delete_roles', 'roles', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(16, 'browse_users', 'users', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(17, 'read_users', 'users', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(18, 'edit_users', 'users', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(19, 'add_users', 'users', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(20, 'delete_users', 'users', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(21, 'browse_settings', 'settings', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(22, 'read_settings', 'settings', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(23, 'edit_settings', 'settings', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(24, 'add_settings', 'settings', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(25, 'delete_settings', 'settings', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(26, 'browse_categories', 'categories', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(27, 'read_categories', 'categories', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(28, 'edit_categories', 'categories', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(29, 'add_categories', 'categories', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(30, 'delete_categories', 'categories', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(31, 'browse_posts', 'posts', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(32, 'read_posts', 'posts', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(33, 'edit_posts', 'posts', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(34, 'add_posts', 'posts', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(35, 'delete_posts', 'posts', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(41, 'browse_hooks', NULL, '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(47, 'browse_brands', 'brands', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(48, 'read_brands', 'brands', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(49, 'edit_brands', 'brands', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(50, 'add_brands', 'brands', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(51, 'delete_brands', 'brands', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(57, 'browse_order_statuses', 'order_statuses', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(58, 'read_order_statuses', 'order_statuses', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(59, 'edit_order_statuses', 'order_statuses', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(60, 'add_order_statuses', 'order_statuses', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(61, 'delete_order_statuses', 'order_statuses', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(62, 'browse_order', 'order', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(63, 'read_order', 'order', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(64, 'edit_order', 'order', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(65, 'add_order', 'order', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(66, 'delete_order', 'order', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(67, 'browse_orders', 'orders', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(68, 'read_orders', 'orders', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(69, 'edit_orders', 'orders', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(70, 'add_orders', 'orders', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(71, 'delete_orders', 'orders', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(77, 'browse_payment_methods', 'payment_methods', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(78, 'read_payment_methods', 'payment_methods', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(79, 'edit_payment_methods', 'payment_methods', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(80, 'add_payment_methods', 'payment_methods', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(81, 'delete_payment_methods', 'payment_methods', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(87, 'browse_product_attribute', 'product_attribute', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(88, 'read_product_attribute', 'product_attribute', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(89, 'edit_product_attribute', 'product_attribute', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(90, 'add_product_attribute', 'product_attribute', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(91, 'delete_product_attribute', 'product_attribute', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(97, 'browse_products', 'products', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(98, 'read_products', 'products', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(99, 'edit_products', 'products', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(100, 'add_products', 'products', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(101, 'delete_products', 'products', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(152, 'browse_attributes', 'attributes', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(153, 'read_attributes', 'attributes', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(154, 'edit_attributes', 'attributes', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(155, 'add_attributes', 'attributes', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(156, 'delete_attributes', 'attributes', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(157, 'browse_attribute_values', 'attribute_values', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(158, 'read_attribute_values', 'attribute_values', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(159, 'edit_attribute_values', 'attribute_values', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(160, 'add_attribute_values', 'attribute_values', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(161, 'delete_attribute_values', 'attribute_values', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(162, 'browse_customers', 'customers', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(163, 'read_customers', 'customers', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(164, 'edit_customers', 'customers', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(165, 'add_customers', 'customers', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(166, 'delete_customers', 'customers', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(167, 'browse_bills', 'bills', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(168, 'read_bills', 'bills', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(169, 'edit_bills', 'bills', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(170, 'add_bills', 'bills', '2021-03-29 05:59:45', '2021-03-29 05:59:45'),
(171, 'delete_bills', 'bills', '2021-03-29 05:59:45', '2021-03-29 05:59:45');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
  `stock` int(11) DEFAULT 0,
  `category_id` bigint(20) UNSIGNED DEFAULT NULL,
  `brand_id` bigint(20) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `provinces`
--

CREATE TABLE `provinces` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gso_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2021-03-29 06:00:41', '2021-03-29 06:00:41'),
(2, 'user', 'Normal User', '2021-03-29 06:00:41', '2021-03-29 06:00:41'),
(3, 'nv_banhang', 'Nhân viên bán hàng', '2021-03-29 06:00:41', '2021-03-29 06:00:41');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2021-03-29 06:01:11', '2021-03-29 06:01:11'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2021-03-29 06:01:11', '2021-03-29 06:01:11');

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
  `phone` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `birthday` date DEFAULT '2020-01-01'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`, `address`, `phone`, `birthday`) VALUES
(1, 1, 'Quản trị viên', 'admin@admin.com', 'users\\September2020\\fenAYZoIW3NTjPZqCUJJ.png', NULL, '$2y$10$fMMsRD/zRsu8En8g6b44FO0OiLtOokauJ0cMoyy4bqs0QZB6Wnc56', 'IxsKgEV2fwbS1exGzigz63ECIUN0fyl283NkaQ7zokFokeSYZqzQaXAG6iiK', '{\"locale\":\"vi\"}', '2021-03-29 06:01:51', '2021-03-29 06:01:51', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `wards`
--

CREATE TABLE `wards` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gso_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `district_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `address_ward_pk` (`ward_id`) USING BTREE,
  ADD KEY `address_district_pk` (`district_id`) USING BTREE,
  ADD KEY `address_province_pk` (`province_id`) USING BTREE,
  ADD KEY `address_user_pk` (`user_id`) USING BTREE;

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `attributes_name_unique` (`name`) USING BTREE;

--
-- Indexes for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `attribute_values_attribute_id_foreign` (`attribute_id`) USING BTREE;

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
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `order_user_pk` (`user_id`) USING BTREE;

--
-- Indexes for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `orderDetail_order_pk` (`order_id`) USING BTREE,
  ADD KEY `orderDetail_product_pk` (`product_id`) USING BTREE;

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `categories_slug_unique` (`slug`) USING BTREE;

--
-- Indexes for table `category_attributes`
--
ALTER TABLE `category_attributes`
  ADD PRIMARY KEY (`category_id`,`attribute_id`),
  ADD KEY `attribute_id` (`attribute_id`);

--
-- Indexes for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`) USING BTREE;

--
-- Indexes for table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `data_types_name_unique` (`name`) USING BTREE,
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`) USING BTREE;

--
-- Indexes for table `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `districts_province_id_foreign` (`province_id`) USING BTREE;

--
-- Indexes for table `inventories`
--
ALTER TABLE `inventories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `inventory_details`
--
ALTER TABLE `inventory_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inventory_id` (`inventory_id`),
  ADD KEY `product_attribute_id` (`product_attribute_id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `menus_name_unique` (`name`) USING BTREE;

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`) USING BTREE;

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `order_paymentMethod_pk` (`payment_method`) USING BTREE,
  ADD KEY `order_orderstatus_pk` (`order_status`) USING BTREE,
  ADD KEY `order_belong_to_user` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `order_id_pk` (`order_id`) USING BTREE,
  ADD KEY `order_product_pk` (`product_id`) USING BTREE;

--
-- Indexes for table `order_statuses`
--
ALTER TABLE `order_statuses`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`) USING BTREE;

--
-- Indexes for table `payment_methods`
--
ALTER TABLE `payment_methods`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `permissions_key_index` (`key`) USING BTREE;

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`) USING BTREE,
  ADD KEY `permission_role_permission_id_index` (`permission_id`) USING BTREE,
  ADD KEY `permission_role_role_id_index` (`role_id`) USING BTREE;

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `posts_slug_unique` (`slug`) USING BTREE,
  ADD KEY `category_id` (`category_id`,`brand_id`) USING BTREE,
  ADD KEY `product_brand_foreign` (`brand_id`) USING BTREE;

--
-- Indexes for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `product_attributes_product_id_foreign` (`product_id`) USING BTREE;

--
-- Indexes for table `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `roles_name_unique` (`name`) USING BTREE;

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `settings_key_unique` (`key`) USING BTREE;

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`) USING BTREE;

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `users_email_unique` (`email`) USING BTREE,
  ADD KEY `users_role_id_foreign` (`role_id`) USING BTREE;

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`) USING BTREE,
  ADD KEY `user_roles_user_id_index` (`user_id`) USING BTREE,
  ADD KEY `user_roles_role_id_index` (`role_id`) USING BTREE;

--
-- Indexes for table `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD KEY `wards_district_id_foreign` (`district_id`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `attribute_values`
--
ALTER TABLE `attribute_values`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `bills`
--
ALTER TABLE `bills`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `bill_details`
--
ALTER TABLE `bill_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=295;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `districts`
--
ALTER TABLE `districts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=703;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `order_statuses`
--
ALTER TABLE `order_statuses`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `payment_methods`
--
ALTER TABLE `payment_methods`
  MODIFY `id` tinyint(3) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=172;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `product_attributes`
--
ALTER TABLE `product_attributes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `provinces`
--
ALTER TABLE `provinces`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `wards`
--
ALTER TABLE `wards`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10615;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `address_district_pk` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `address_province_pk` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `address_user_pk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `address_ward_pk` FOREIGN KEY (`ward_id`) REFERENCES `wards` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD CONSTRAINT `attribute_values_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`);

--
-- Constraints for table `attribute_value_product_attribute`
--
ALTER TABLE `attribute_value_product_attribute`
  ADD CONSTRAINT `attribute_value_product_attribute_ibfk_1` FOREIGN KEY (`product_attribute_id`) REFERENCES `product_attributes` (`id`),
  ADD CONSTRAINT `attribute_value_product_attribute_ibfk_2` FOREIGN KEY (`attribute_value_id`) REFERENCES `attribute_values` (`id`);

--
-- Constraints for table `bills`
--
ALTER TABLE `bills`
  ADD CONSTRAINT `order_user_pk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bill_details`
--
ALTER TABLE `bill_details`
  ADD CONSTRAINT `orderDetail_order_pk` FOREIGN KEY (`order_id`) REFERENCES `bills` (`id`),
  ADD CONSTRAINT `orderDetail_product_pk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `category_attributes`
--
ALTER TABLE `category_attributes`
  ADD CONSTRAINT `category_attributes_ibfk_1` FOREIGN KEY (`attribute_id`) REFERENCES `attributes` (`id`),
  ADD CONSTRAINT `category_attributes_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `districts_province_id_foreign` FOREIGN KEY (`province_id`) REFERENCES `provinces` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `inventories`
--
ALTER TABLE `inventories`
  ADD CONSTRAINT `inventories_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `inventory_details`
--
ALTER TABLE `inventory_details`
  ADD CONSTRAINT `inventory_details_ibfk_1` FOREIGN KEY (`inventory_id`) REFERENCES `inventories` (`id`),
  ADD CONSTRAINT `inventory_details_ibfk_2` FOREIGN KEY (`product_attribute_id`) REFERENCES `product_attributes` (`id`);

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `order_belong_to_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `order_orderstatus_pk` FOREIGN KEY (`order_status`) REFERENCES `order_statuses` (`id`),
  ADD CONSTRAINT `order_paymentMethod_pk` FOREIGN KEY (`payment_method`) REFERENCES `payment_methods` (`id`);

--
-- Constraints for table `order_details`
--
ALTER TABLE `order_details`
  ADD CONSTRAINT `order_id_pk` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`),
  ADD CONSTRAINT `order_product_pk` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

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
  ADD CONSTRAINT `product_brand_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`),
  ADD CONSTRAINT `product_cate_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `product_attributes`
--
ALTER TABLE `product_attributes`
  ADD CONSTRAINT `product_attributes_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

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

--
-- Constraints for table `wards`
--
ALTER TABLE `wards`
  ADD CONSTRAINT `wards_district_id_foreign` FOREIGN KEY (`district_id`) REFERENCES `districts` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
