-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: Feb 15, 2023 at 05:41 AM
-- Server version: 5.7.39
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_online-app`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Category 1', 'category-1', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, NULL, 1, 'Category 2', 'category-2', '2023-02-03 07:04:07', '2023-02-03 07:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `rate` double DEFAULT NULL,
  `symbol` varchar(5) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `full_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `short_name` varchar(3) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `rate`, `symbol`, `full_name`, `short_name`, `country`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4100, '៛', 'Khmer Riel', 'KHR', 'Cambodia', '2023-02-08 05:02:00', '2023-02-07 22:02:28', NULL),
(2, 2.95, '%', 'Visa Card Fee', 'fee', 'World Wide', '2023-02-08 04:40:56', '2023-02-08 04:40:56', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_name`, `contact`, `address`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Electro Shop', '069356444', 'មកទិញដល់កន្លែង', '2023-02-05 05:57:09', '2023-02-05 05:57:09', NULL),
(2, 'dfbcxbcxb', 'cxvcbxcbxc', 'xcbcxbcxbcxbx', '2023-02-08 07:15:23', '2023-02-08 07:15:58', '2023-02-08 07:15:58');

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
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `browse` tinyint(1) NOT NULL DEFAULT '1',
  `read` tinyint(1) NOT NULL DEFAULT '1',
  `edit` tinyint(1) NOT NULL DEFAULT '1',
  `add` tinyint(1) NOT NULL DEFAULT '1',
  `delete` tinyint(1) NOT NULL DEFAULT '1',
  `details` text COLLATE utf8mb4_unicode_ci,
  `order` int(11) NOT NULL DEFAULT '1'
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
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}', 2),
(24, 4, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{\"default\":1}', 3),
(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 4),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\"}}', 5),
(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, NULL, 6),
(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(29, 5, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(30, 5, 'author_id', 'text', 'Author', 1, 0, 1, 1, 0, 1, NULL, 2),
(31, 5, 'category_id', 'text', 'Category', 1, 0, 1, 1, 1, 0, NULL, 3),
(32, 5, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 4),
(33, 5, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 5),
(34, 5, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 6),
(35, 5, 'image', 'image', 'Post Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 7),
(36, 5, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}', 8),
(37, 5, 'meta_description', 'text_area', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 9),
(38, 5, 'meta_keywords', 'text_area', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 10),
(39, 5, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}', 11),
(40, 5, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 12),
(41, 5, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 13),
(42, 5, 'seo_title', 'text', 'SEO Title', 0, 1, 1, 1, 1, 1, NULL, 14),
(43, 5, 'featured', 'checkbox', 'Featured', 1, 1, 1, 1, 1, 1, NULL, 15),
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
(56, 9, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(57, 11, 'id', 'text', 'Id', 1, 1, 1, 0, 0, 0, '{}', 1),
(58, 11, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 4),
(59, 11, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 5),
(60, 9, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, '{}', 7),
(61, 9, 'product_code', 'text', 'Product Code', 0, 1, 1, 1, 1, 1, '{}', 2),
(62, 9, 'product_name', 'text', 'Product Name', 0, 1, 1, 1, 1, 1, '{}', 3),
(63, 9, 'product_type', 'text', 'Product Type', 0, 1, 1, 1, 1, 1, '{}', 5),
(64, 9, 'product_image', 'image', 'Product Image', 0, 1, 1, 1, 1, 1, '{}', 6),
(65, 9, 'updated_at', 'timestamp', 'Updated At', 0, 0, 1, 0, 0, 0, '{}', 8),
(66, 9, 'deleted_at', 'timestamp', 'Deleted At', 0, 0, 1, 0, 0, 0, '{}', 9),
(67, 11, 'type_name', 'text', 'Type Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(68, 11, 'type_description', 'text', 'Type Description', 0, 1, 1, 1, 1, 1, '{}', 3),
(69, 11, 'deleted_at', 'timestamp', 'Deleted At', 0, 1, 1, 0, 0, 0, '{}', 6),
(70, 9, 'product_belongsto_products_type_relationship', 'relationship', 'Product Type', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\ProductsType\",\"table\":\"products_types\",\"type\":\"belongsTo\",\"column\":\"product_type\",\"key\":\"id\",\"label\":\"type_name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 4),
(71, 12, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(72, 12, 'customer_name', 'text', 'Customer Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(73, 12, 'contact', 'text', 'Contact', 0, 1, 1, 1, 1, 1, '{}', 3),
(74, 12, 'address', 'text', 'Address', 0, 1, 1, 1, 1, 1, '{}', 4),
(75, 12, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 5),
(76, 12, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6),
(77, 12, 'deleted_at', 'timestamp', 'Deleted At', 0, 1, 1, 1, 1, 1, '{}', 7),
(78, 13, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(79, 13, 'supplier_name', 'text', 'Supplier Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(80, 13, 'contact', 'text', 'Contact', 0, 1, 1, 1, 1, 1, '{}', 3),
(81, 13, 'address', 'text', 'Address', 0, 1, 1, 1, 1, 1, '{}', 4),
(82, 13, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 5),
(83, 13, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6),
(84, 13, 'deleted_at', 'timestamp', 'Deleted At', 0, 1, 1, 1, 1, 1, '{}', 7),
(85, 14, 'id', 'text', 'Id', 1, 1, 1, 0, 0, 0, '{}', 1),
(87, 14, 'total_qty', 'text', 'Total Qty', 0, 1, 1, 1, 1, 1, '{}', 3),
(89, 14, 'seller_id', 'text', 'Seller Id', 0, 1, 1, 1, 1, 1, '{}', 7),
(90, 14, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 1, '{}', 9),
(91, 14, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 10),
(92, 14, 'deleted_at', 'timestamp', 'Deleted At', 0, 0, 1, 0, 0, 1, '{}', 11),
(93, 15, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(94, 15, 'rate', 'text', 'Rate', 0, 1, 1, 1, 1, 1, '{}', 2),
(95, 15, 'symbol', 'text', 'Symbol', 0, 1, 1, 1, 1, 1, '{}', 3),
(96, 15, 'full_name', 'text', 'Full Name', 0, 1, 1, 1, 1, 1, '{}', 4),
(97, 15, 'short_name', 'text', 'Short Name', 0, 1, 1, 1, 1, 1, '{}', 5),
(98, 15, 'country', 'text', 'Country', 0, 1, 1, 1, 1, 1, '{}', 6),
(99, 15, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
(100, 15, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(101, 15, 'deleted_at', 'timestamp', 'Deleted At', 0, 1, 1, 1, 1, 1, '{}', 9),
(102, 16, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(103, 16, 'product_id', 'text', 'Product Id', 1, 1, 1, 1, 1, 1, '{}', 4),
(104, 16, 'sale_price', 'text', 'Sale Price', 0, 1, 1, 1, 1, 1, '{}', 5),
(105, 16, 'cost', 'text', 'Cost', 0, 1, 1, 1, 1, 1, '{}', 6),
(106, 16, 'total_qty', 'text', 'Total Qty', 0, 1, 1, 1, 0, 1, '{}', 7),
(107, 16, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 1, '{}', 8),
(108, 16, 'updated_at', 'timestamp', 'Updated At', 0, 0, 1, 0, 0, 0, '{}', 9),
(109, 16, 'deleted_at', 'timestamp', 'Deleted At', 0, 0, 1, 0, 0, 1, '{}', 10),
(110, 16, 'product_stock_belongsto_product_relationship', 'relationship', 'Product Name', 0, 1, 1, 1, 1, 1, '{\"scope\":\"active\",\"model\":\"App\\\\Models\\\\Product\",\"table\":\"products\",\"type\":\"belongsTo\",\"column\":\"product_id\",\"key\":\"id\",\"label\":\"product_name\",\"pivot_table\":\"products\",\"pivot\":\"0\",\"taggable\":\"on\"}', 3),
(111, 16, 'product_stock_hasone_product_relationship', 'relationship', 'Product Code', 0, 1, 1, 0, 0, 1, '{\"model\":\"App\\\\Models\\\\Product\",\"table\":\"products\",\"type\":\"belongsTo\",\"column\":\"product_id\",\"key\":\"id\",\"label\":\"product_code\",\"pivot_table\":\"products\",\"pivot\":\"0\",\"taggable\":\"on\"}', 2),
(112, 14, 'sale_date', 'text', 'Sale Date', 0, 1, 1, 1, 1, 1, '{}', 2),
(113, 14, 'customer_id', 'text', 'Customer Id', 1, 1, 1, 1, 1, 1, '{}', 5),
(114, 14, 'amount', 'text', 'Amount', 0, 0, 1, 1, 1, 1, '{}', 8),
(115, 14, 'delivery_fee', 'text', 'Delivery Fee', 0, 0, 1, 1, 1, 1, '{}', 12),
(116, 14, 'discount', 'text', 'Discount', 0, 0, 1, 1, 1, 1, '{}', 13),
(117, 14, 'forwarder_fee', 'text', 'Forwarder Fee', 0, 0, 1, 1, 1, 1, '{}', 14),
(118, 14, 'net_amount', 'text', 'Net Amount', 0, 1, 1, 1, 1, 1, '{}', 15),
(119, 14, 'balance', 'text', 'Balance', 0, 1, 1, 1, 1, 1, '{}', 16),
(120, 22, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(121, 22, 'supplier_id', 'text', 'Supplier Id', 0, 1, 1, 1, 1, 1, '{}', 3),
(122, 22, 'total_qty', 'text', 'Total Qty', 0, 1, 1, 1, 1, 1, '{}', 4),
(123, 22, 'freight_fee', 'text', 'Freight Fee', 0, 0, 1, 1, 1, 1, '{}', 5),
(124, 22, 'discount', 'text', 'Discount', 0, 0, 1, 1, 1, 1, '{}', 6),
(125, 22, 'amount', 'text', 'Amount', 0, 0, 1, 1, 1, 1, '{}', 7),
(126, 22, 'visa_fee', 'text', 'Visa Fee', 0, 1, 1, 1, 1, 1, '{}', 8),
(127, 22, 'other_fee', 'text', 'Other Fee', 0, 0, 1, 1, 1, 1, '{}', 9),
(128, 22, 'forwarder_fee', 'text', 'Forwarder Fee', 0, 0, 1, 1, 1, 1, '{}', 10),
(129, 22, 'net_amount', 'text', 'Net Amount', 0, 1, 1, 1, 1, 1, '{}', 11),
(130, 22, 'purchaser', 'text', 'Purchaser', 0, 1, 1, 1, 1, 1, '{}', 12),
(131, 22, 'purchase_date', 'text', 'Purchase Date', 0, 1, 1, 1, 1, 1, '{}', 13),
(132, 22, 'balance', 'text', 'Balance', 0, 0, 1, 1, 1, 1, '{}', 14),
(133, 22, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 1, 0, 1, '{}', 15),
(134, 22, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 16),
(135, 22, 'deleted_at', 'timestamp', 'Deleted At', 0, 0, 1, 1, 1, 1, '{}', 17),
(136, 22, 'purchase_belongsto_supplier_relationship', 'relationship', 'Suppliers', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\Supplier\",\"table\":\"suppliers\",\"type\":\"belongsTo\",\"column\":\"supplier_id\",\"key\":\"id\",\"label\":\"supplier_name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(137, 14, 'sale_belongsto_customer_relationship', 'relationship', 'Customer', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\Customer\",\"table\":\"customers\",\"type\":\"belongsTo\",\"column\":\"customer_id\",\"key\":\"id\",\"label\":\"customer_name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 4),
(138, 14, 'sale_belongsto_user_relationship', 'relationship', 'Seller', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"seller_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 6);

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
  `generate_permissions` tinyint(1) NOT NULL DEFAULT '0',
  `server_side` tinyint(4) NOT NULL DEFAULT '0',
  `details` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, 'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController', '', 1, 0, NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', '', '', 1, 0, NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(9, 'products', 'products', 'Product', 'Products', NULL, 'App\\Models\\Product', NULL, NULL, NULL, 1, 0, '{\"order_column\":\"id\",\"order_display_column\":\"id\",\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-02-05 03:10:13', '2023-02-07 22:24:49'),
(11, 'products_types', 'products-types', 'Products Type', 'Products Types', NULL, 'App\\Models\\ProductsType', NULL, NULL, NULL, 1, 0, '{\"order_column\":\"id\",\"order_display_column\":\"id\",\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-02-05 03:30:38', '2023-02-05 05:12:10'),
(12, 'customers', 'customers', 'Customer', 'Customers', NULL, 'App\\Models\\Customer', NULL, NULL, NULL, 1, 0, '{\"order_column\":\"id\",\"order_display_column\":\"id\",\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-02-05 05:56:13', '2023-02-05 05:56:13'),
(13, 'suppliers', 'suppliers', 'Supplier', 'Suppliers', NULL, 'App\\Models\\Supplier', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-02-05 06:02:17', '2023-02-05 06:02:17'),
(14, 'sales', 'sales', 'Sale', 'Sales', NULL, 'App\\Models\\Sale', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-02-05 06:16:30', '2023-02-08 19:43:27'),
(15, 'currencies', 'currencies', 'Currency', 'Currencies', NULL, 'App\\Models\\Currency', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-02-05 06:20:40', '2023-02-05 06:20:40'),
(16, 'product_stocks', 'product-stocks', 'Product Stock', 'Product Stocks', NULL, 'App\\Models\\ProductStock', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-02-07 22:51:30', '2023-02-08 00:16:31'),
(22, 'purchases', 'purchases', 'Purchase', 'Purchases', NULL, 'App\\Models\\Purchase', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-02-08 04:22:56', '2023-02-08 05:08:57');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hold_sales`
--

CREATE TABLE `hold_sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `customer_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_contact` varchar(225) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `delivery_fee` double DEFAULT NULL,
  `total_discount` double DEFAULT NULL,
  `delivery_expense` double DEFAULT NULL,
  `seller` int(11) DEFAULT NULL,
  `sale_date` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hold_sale_records`
--

CREATE TABLE `hold_sale_records` (
  `id` int(11) UNSIGNED NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

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
(1, 'admin', '2023-02-03 07:04:07', '2023-02-03 07:04:07');

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
  `parameters` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 5, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 3, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 2, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 9, '2023-02-03 07:04:07', '2023-02-03 07:04:07', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 10, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 11, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 12, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 13, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 14, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.settings.index', NULL),
(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, NULL, 8, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.categories.index', NULL),
(12, 1, 'Posts', '', '_self', 'voyager-news', NULL, NULL, 6, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.posts.index', NULL),
(13, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, NULL, 7, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.pages.index', NULL),
(17, 1, 'Products', '', '_self', NULL, NULL, NULL, 15, '2023-02-05 03:10:13', '2023-02-05 03:10:13', 'voyager.products.index', NULL),
(19, 1, 'Products Types', '', '_self', NULL, NULL, NULL, 17, '2023-02-05 03:30:38', '2023-02-05 03:30:38', 'voyager.products-types.index', NULL),
(20, 1, 'Customers', '', '_self', NULL, NULL, NULL, 18, '2023-02-05 05:56:14', '2023-02-05 05:56:14', 'voyager.customers.index', NULL),
(21, 1, 'Suppliers', '', '_self', NULL, NULL, NULL, 19, '2023-02-05 06:02:18', '2023-02-05 06:02:18', 'voyager.suppliers.index', NULL),
(22, 1, 'Sales', '', '_blank', NULL, '#000000', NULL, 20, '2023-02-05 06:16:30', '2023-02-08 01:31:14', 'voyager.sales.index', 'null'),
(23, 1, 'Currencies', '', '_self', NULL, NULL, NULL, 21, '2023-02-05 06:20:40', '2023-02-05 06:20:40', 'voyager.currencies.index', NULL),
(24, 1, 'Product Stocks', '', '_self', NULL, NULL, NULL, 22, '2023-02-07 22:51:30', '2023-02-07 22:51:30', 'voyager.product-stocks.index', NULL),
(28, 1, 'Purchases', '', '_self', NULL, NULL, NULL, 23, '2023-02-08 04:22:56', '2023-02-08 04:22:56', 'voyager.purchases.index', NULL);

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
(27, '2019_08_19_000000_create_failed_jobs_table', 1),
(28, '2019_12_14_000001_create_personal_access_tokens_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('ACTIVE','INACTIVE') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 'Hello World', 'Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.', '<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', 'pages/page1.jpg', 'hello-world', 'Yar Meta Description', 'Keyword1, Keyword2', 'ACTIVE', '2023-02-03 07:04:07', '2023-02-03 07:04:07');

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
(1, 'browse_admin', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 'browse_bread', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(3, 'browse_database', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(4, 'browse_media', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(5, 'browse_compass', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(6, 'browse_menus', 'menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(7, 'read_menus', 'menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(8, 'edit_menus', 'menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(9, 'add_menus', 'menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(10, 'delete_menus', 'menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(11, 'browse_roles', 'roles', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(12, 'read_roles', 'roles', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(13, 'edit_roles', 'roles', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(14, 'add_roles', 'roles', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(15, 'delete_roles', 'roles', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(16, 'browse_users', 'users', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(17, 'read_users', 'users', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(18, 'edit_users', 'users', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(19, 'add_users', 'users', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(20, 'delete_users', 'users', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(21, 'browse_settings', 'settings', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(22, 'read_settings', 'settings', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(23, 'edit_settings', 'settings', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(24, 'add_settings', 'settings', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(25, 'delete_settings', 'settings', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(26, 'browse_categories', 'categories', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(27, 'read_categories', 'categories', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(28, 'edit_categories', 'categories', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(29, 'add_categories', 'categories', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(30, 'delete_categories', 'categories', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(31, 'browse_posts', 'posts', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(32, 'read_posts', 'posts', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(33, 'edit_posts', 'posts', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(34, 'add_posts', 'posts', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(35, 'delete_posts', 'posts', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(36, 'browse_pages', 'pages', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(37, 'read_pages', 'pages', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(38, 'edit_pages', 'pages', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(39, 'add_pages', 'pages', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(40, 'delete_pages', 'pages', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(46, 'browse_products', 'products', '2023-02-05 03:10:13', '2023-02-05 03:10:13'),
(47, 'read_products', 'products', '2023-02-05 03:10:13', '2023-02-05 03:10:13'),
(48, 'edit_products', 'products', '2023-02-05 03:10:13', '2023-02-05 03:10:13'),
(49, 'add_products', 'products', '2023-02-05 03:10:13', '2023-02-05 03:10:13'),
(50, 'delete_products', 'products', '2023-02-05 03:10:13', '2023-02-05 03:10:13'),
(51, 'browse_products_type', 'products_type', '2023-02-05 03:28:15', '2023-02-05 03:28:15'),
(52, 'read_products_type', 'products_type', '2023-02-05 03:28:15', '2023-02-05 03:28:15'),
(53, 'edit_products_type', 'products_type', '2023-02-05 03:28:15', '2023-02-05 03:28:15'),
(54, 'add_products_type', 'products_type', '2023-02-05 03:28:15', '2023-02-05 03:28:15'),
(55, 'delete_products_type', 'products_type', '2023-02-05 03:28:15', '2023-02-05 03:28:15'),
(56, 'browse_products_types', 'products_types', '2023-02-05 03:30:38', '2023-02-05 03:30:38'),
(57, 'read_products_types', 'products_types', '2023-02-05 03:30:38', '2023-02-05 03:30:38'),
(58, 'edit_products_types', 'products_types', '2023-02-05 03:30:38', '2023-02-05 03:30:38'),
(59, 'add_products_types', 'products_types', '2023-02-05 03:30:38', '2023-02-05 03:30:38'),
(60, 'delete_products_types', 'products_types', '2023-02-05 03:30:38', '2023-02-05 03:30:38'),
(61, 'browse_customers', 'customers', '2023-02-05 05:56:14', '2023-02-05 05:56:14'),
(62, 'read_customers', 'customers', '2023-02-05 05:56:14', '2023-02-05 05:56:14'),
(63, 'edit_customers', 'customers', '2023-02-05 05:56:14', '2023-02-05 05:56:14'),
(64, 'add_customers', 'customers', '2023-02-05 05:56:14', '2023-02-05 05:56:14'),
(65, 'delete_customers', 'customers', '2023-02-05 05:56:14', '2023-02-05 05:56:14'),
(66, 'browse_suppliers', 'suppliers', '2023-02-05 06:02:17', '2023-02-05 06:02:17'),
(67, 'read_suppliers', 'suppliers', '2023-02-05 06:02:17', '2023-02-05 06:02:17'),
(68, 'edit_suppliers', 'suppliers', '2023-02-05 06:02:17', '2023-02-05 06:02:17'),
(69, 'add_suppliers', 'suppliers', '2023-02-05 06:02:18', '2023-02-05 06:02:18'),
(70, 'delete_suppliers', 'suppliers', '2023-02-05 06:02:18', '2023-02-05 06:02:18'),
(71, 'browse_sales', 'sales', '2023-02-05 06:16:30', '2023-02-05 06:16:30'),
(72, 'read_sales', 'sales', '2023-02-05 06:16:30', '2023-02-05 06:16:30'),
(73, 'edit_sales', 'sales', '2023-02-05 06:16:30', '2023-02-05 06:16:30'),
(74, 'add_sales', 'sales', '2023-02-05 06:16:30', '2023-02-05 06:16:30'),
(75, 'delete_sales', 'sales', '2023-02-05 06:16:30', '2023-02-05 06:16:30'),
(76, 'browse_currencies', 'currencies', '2023-02-05 06:20:40', '2023-02-05 06:20:40'),
(77, 'read_currencies', 'currencies', '2023-02-05 06:20:40', '2023-02-05 06:20:40'),
(78, 'edit_currencies', 'currencies', '2023-02-05 06:20:40', '2023-02-05 06:20:40'),
(79, 'add_currencies', 'currencies', '2023-02-05 06:20:40', '2023-02-05 06:20:40'),
(80, 'delete_currencies', 'currencies', '2023-02-05 06:20:40', '2023-02-05 06:20:40'),
(81, 'browse_product_stocks', 'product_stocks', '2023-02-07 22:51:30', '2023-02-07 22:51:30'),
(82, 'read_product_stocks', 'product_stocks', '2023-02-07 22:51:30', '2023-02-07 22:51:30'),
(83, 'edit_product_stocks', 'product_stocks', '2023-02-07 22:51:30', '2023-02-07 22:51:30'),
(84, 'add_product_stocks', 'product_stocks', '2023-02-07 22:51:30', '2023-02-07 22:51:30'),
(85, 'delete_product_stocks', 'product_stocks', '2023-02-07 22:51:30', '2023-02-07 22:51:30'),
(101, 'browse_purchases', 'purchases', '2023-02-08 04:22:56', '2023-02-08 04:22:56'),
(102, 'read_purchases', 'purchases', '2023-02-08 04:22:56', '2023-02-08 04:22:56'),
(103, 'edit_purchases', 'purchases', '2023-02-08 04:22:56', '2023-02-08 04:22:56'),
(104, 'add_purchases', 'purchases', '2023-02-08 04:22:56', '2023-02-08 04:22:56'),
(105, 'delete_purchases', 'purchases', '2023-02-08 04:22:56', '2023-02-08 04:22:56');

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
(101, 1),
(102, 1),
(103, 1),
(104, 1),
(105, 1);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seo_title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `excerpt` text COLLATE utf8mb4_unicode_ci,
  `body` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `meta_description` text COLLATE utf8mb4_unicode_ci,
  `meta_keywords` text COLLATE utf8mb4_unicode_ci,
  `status` enum('PUBLISHED','DRAFT','PENDING') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `author_id`, `category_id`, `title`, `seo_title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `created_at`, `updated_at`) VALUES
(1, 0, NULL, 'Lorem Ipsum Post', NULL, 'This is the excerpt for the Lorem Ipsum Post', '<p>This is the body of the lorem ipsum post</p>', 'posts/post1.jpg', 'lorem-ipsum-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 0, NULL, 'My Sample Post', NULL, 'This is the excerpt for the sample Post', '<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>', 'posts/post2.jpg', 'my-sample-post', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(3, 0, NULL, 'Latest Post', NULL, 'This is the excerpt for the latest post', '<p>This is the body for the latest post</p>', 'posts/post3.jpg', 'latest-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(4, 0, NULL, 'Yarr Post', NULL, 'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.', '<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>', 'posts/post4.jpg', 'yarr-post', 'this be a meta descript', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-02-03 07:04:07', '2023-02-03 07:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_code` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_type` int(11) DEFAULT NULL,
  `product_image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_code`, `product_name`, `product_type`, `product_image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'XA585', 'Headlight with Computer', 1, 'products/February2023/CWS8HQqecG3SX7yxRUgn.jpg', NULL, '2023-02-05 05:46:17', NULL),
(2, 'BK-1718', 'Headlight Double T6 Led Light', 1, 'products/February2023/L1I3RTEAyhUS7sXVdkL6.jpg', NULL, '2023-02-05 05:46:28', NULL),
(3, 'Zoom Headlight', 'Zoom Headlight Battery AA', 1, 'products/February2023/j2i0kFnwjtnfHLOMF905.jpg', NULL, '2023-02-07 22:14:13', NULL),
(4, '7588', 'Headlight with horn', 1, 'products/February2023/vhComHt3czMkszWWj9x4.jpg', NULL, '2023-02-07 22:15:38', NULL),
(5, 'G69', 'GUB Headlight Double Len', 1, 'products/February2023/c8JQK4IwXle7F3Nw9tDg.jpg', NULL, '2023-02-07 22:17:07', NULL),
(6, 'Headlight with phone holder', '3 lens Headlight with phone holder', 1, 'products/February2023/Gr3BgOWEUGxjZ6goe0P0.jpg', NULL, '2023-02-07 22:21:20', NULL),
(7, 'Sensor Headlight', 'Sensor Headlight', 1, 'products/February2023/iKkSSB4b929Zqf3Ag6RU.jpg', '2023-02-09 07:11:07', '2023-02-09 07:11:07', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products_types`
--

CREATE TABLE `products_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `type_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_types`
--

INSERT INTO `products_types` (`id`, `type_name`, `type_description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Light', NULL, '2023-02-05 05:13:36', '2023-02-05 05:13:36', NULL),
(3, 'Bag', NULL, '2023-02-05 05:14:27', '2023-02-05 05:14:27', NULL),
(4, 'Spare Part', NULL, '2023-02-05 05:14:54', '2023-02-05 05:14:54', NULL),
(5, 'Accessories', NULL, '2023-02-05 05:15:33', '2023-02-05 05:15:33', NULL),
(6, 'we', NULL, NULL, NULL, NULL),
(7, 're', 'gd', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `product_stocks`
--

CREATE TABLE `product_stocks` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) NOT NULL,
  `sale_price` double DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `total_qty` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_stocks`
--

INSERT INTO `product_stocks` (`id`, `product_id`, `sale_price`, `cost`, `total_qty`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 14, 6.5, -1, '2023-02-07 23:01:31', '2023-02-07 23:01:31', NULL),
(3, 2, 13, 6.5, 0, '2023-02-07 23:11:27', '2023-02-07 23:11:27', NULL),
(4, 3, 10, 4.9, -1, '2023-02-07 23:18:09', '2023-02-07 23:18:09', NULL),
(5, 4, 6, 1.7, 0, '2023-02-07 23:28:13', '2023-02-07 23:28:13', NULL),
(8, 6, 12, 4.9, 0, '2023-02-08 00:10:06', '2023-02-08 00:10:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `purchases`
--

CREATE TABLE `purchases` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier_id` int(11) DEFAULT NULL,
  `total_qty` int(11) DEFAULT NULL,
  `freight_fee` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `visa_fee` double DEFAULT NULL,
  `other_fee` double DEFAULT NULL,
  `forwarder_fee` double DEFAULT NULL,
  `net_amount` double DEFAULT NULL,
  `purchaser` int(11) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `balance` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchases`
--

INSERT INTO `purchases` (`id`, `supplier_id`, `total_qty`, `freight_fee`, `discount`, `amount`, `visa_fee`, `other_fee`, `forwarder_fee`, `net_amount`, `purchaser`, `purchase_date`, `balance`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 1, 100, 0, 0, 650, 19.175, 0, 0, 669.175, 1, '2023-02-08', 0, NULL, '2023-02-08 22:59:18', NULL),
(4, 1, 10, 0, 0, 65, 1.9175000000000002, 0, 0, 66.9175, 1, '2023-02-08', 0, NULL, NULL, NULL),
(5, 2, 1, 0, 0, 4.9, 0.14455, 0, 0, 5.04455, 1, '2023-02-08', 0, NULL, NULL, NULL);

--
-- Triggers `purchases`
--
DELIMITER $$
CREATE TRIGGER `afterUpdatePurchaseDeleted` AFTER UPDATE ON `purchases` FOR EACH ROW BEGIN
    IF ISNULL(new.deleted_at)  THEN
    	UPDATE purchase_records
        SET purchase_records.deleted_at = NULL
        WHERE purchase_records.po_code = new.id;
    ELSE
    	UPDATE purchase_records 
        SET purchase_records.deleted_at = new.deleted_at
        WHERE purchase_records.po_code = new.id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_records`
--

CREATE TABLE `purchase_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `po_code` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `sale_price` double DEFAULT NULL,
  `cost_amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `purchase_records`
--

INSERT INTO `purchase_records` (`id`, `po_code`, `product_id`, `quantity`, `cost`, `sale_price`, `cost_amount`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 3, 1, 100, 6.5, 14, 650, NULL, NULL, NULL),
(2, 4, 2, 10, 6.5, 13, 65, NULL, NULL, NULL),
(3, 5, 3, 1, 4.9, 10, 4.9, NULL, NULL, NULL);

--
-- Triggers `purchase_records`
--
DELIMITER $$
CREATE TRIGGER `afterInsertPurchase` AFTER INSERT ON `purchase_records` FOR EACH ROW BEGIN
	UPDATE product_stocks
    SET product_stocks.total_qty = product_stocks.total_qty + new.quantity
    WHERE product_stocks.product_id = new.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `afterUpdatePurchase` AFTER UPDATE ON `purchase_records` FOR EACH ROW BEGIN
	IF ISNULL(new.deleted_at) THEN
    	UPDATE product_stocks
        SET product_stocks.total_qty =product_stocks.total_qty + new.quantity
        WHERE product_stocks.product_id = new.product_id;
    ELSE
    	UPDATE product_stocks
        SET product_stocks.total_qty = product_stocks.total_qty - new.quantity
        WHERE product_stocks.product_id = new.product_id; 
    END IF;
END
$$
DELIMITER ;

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
(1, 'admin', 'Administrator', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 'user', 'Normal User', '2023-02-03 07:04:07', '2023-02-03 07:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_date` date DEFAULT NULL,
  `customer_id` int(11) NOT NULL,
  `total_qty` double DEFAULT NULL,
  `amount` double DEFAULT NULL,
  `seller_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `delivery_fee` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `forwarder_fee` double DEFAULT NULL,
  `net_amount` double DEFAULT NULL,
  `balance` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `sale_date`, `customer_id`, `total_qty`, `amount`, `seller_id`, `created_at`, `updated_at`, `deleted_at`, `delivery_fee`, `discount`, `forwarder_fee`, `net_amount`, `balance`) VALUES
(2, '2023-02-08', 1, NULL, 26, 1, NULL, '2023-02-08 20:59:12', NULL, 2, 0, 1.5, 24.5, 0),
(3, '2023-02-08', 1, NULL, 14, 1, NULL, '2023-02-08 20:58:38', NULL, 0, 0, 0, 14, 0),
(4, '2023-02-09', 2, NULL, 24, 1, '2023-02-09 05:50:42', NULL, NULL, 0, 0, 0, 24, 0);

--
-- Triggers `sales`
--
DELIMITER $$
CREATE TRIGGER `afterUpdateDeletedAt` AFTER UPDATE ON `sales` FOR EACH ROW BEGIN
    IF ISNULL(new.deleted_at)  THEN
    	UPDATE sale_records 
        SET sale_records.deleted_at = NULL
        WHERE sale_records.sale_id = new.id;
    ELSE
    	UPDATE sale_records 
        SET sale_records.deleted_at = new.deleted_at
        WHERE sale_records.sale_id = new.id;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `sale_records`
--

CREATE TABLE `sale_records` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` double DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `discount` double NOT NULL,
  `amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_records`
--

INSERT INTO `sale_records` (`id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `discount`, `amount`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 2, 1, 1, 14, 0, 14, NULL, NULL, NULL),
(2, 2, 3, 1, 10, 0, 10, NULL, NULL, NULL),
(3, 3, 1, 1, 14, 0, 14, NULL, NULL, NULL),
(4, 4, 1, 1, 14, 0, 14, NULL, NULL, NULL),
(5, 4, 3, 1, 10, 0, 10, NULL, NULL, NULL);

--
-- Triggers `sale_records`
--
DELIMITER $$
CREATE TRIGGER `afterInsertSaleRecord` AFTER INSERT ON `sale_records` FOR EACH ROW BEGIN
	UPDATE product_stocks
    SET product_stocks.total_qty = product_stocks.total_qty - new.quantity
    WHERE product_stocks.product_id = new.product_id;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `afterUpdateDeletedAtQTY` AFTER UPDATE ON `sale_records` FOR EACH ROW BEGIN
	IF ISNULL(new.deleted_at) THEN
    	UPDATE product_stocks
        SET product_stocks.total_qty =product_stocks.total_qty - new.quantity
        WHERE product_stocks.product_id = new.product_id;
    ELSE
    	UPDATE product_stocks
        SET product_stocks.total_qty = product_stocks.total_qty + new.quantity
        WHERE product_stocks.product_id = new.product_id; 
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT '1',
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', '', '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Voyager', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '', '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `contact` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`id`, `supplier_name`, `contact`, `address`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Alibaba', 'China App', 'China', '2023-02-07 22:04:38', '2023-02-07 22:04:38', NULL),
(2, 'HN Bike Shop', 'HN', 'Borey Bunly street 371', '2023-02-07 22:05:32', '2023-02-07 22:05:32', NULL),
(3, 'VPM Bike Shop', 'VPM', 'Street 77BT', '2023-02-07 22:06:27', '2023-02-07 22:06:27', NULL);

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
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2023-02-03 07:04:07', '2023-02-03 07:04:07');

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
  `settings` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`) VALUES
(1, 1, 'Admin', 'admin@admin.com', 'users/default.png', NULL, '$2y$10$OZh6sNdjQ9La7OZduDwMjeHU4lyQU75p7MvafJkTbWF8x664n1Cfq', 'bbEd9GIe4M3DkOM9HLcHWUPIw5dwJxd3AcBDxnDa6KDO2Y57LqnC7wP6umUd', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `hold_sales`
--
ALTER TABLE `hold_sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hold_sale_records`
--
ALTER TABLE `hold_sale_records`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `posts_slug_unique` (`slug`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products_types`
--
ALTER TABLE `products_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_stocks`
--
ALTER TABLE `product_stocks`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `product_stocks_product_id_unique` (`product_id`);

--
-- Indexes for table `purchases`
--
ALTER TABLE `purchases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `purchase_records`
--
ALTER TABLE `purchase_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sale_records`
--
ALTER TABLE `sale_records`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
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
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=139;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hold_sales`
--
ALTER TABLE `hold_sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hold_sale_records`
--
ALTER TABLE `hold_sale_records`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=106;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products_types`
--
ALTER TABLE `products_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `product_stocks`
--
ALTER TABLE `product_stocks`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `purchase_records`
--
ALTER TABLE `purchase_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sale_records`
--
ALTER TABLE `sale_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
