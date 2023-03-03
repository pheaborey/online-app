-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 03, 2023 at 04:21 PM
-- Server version: 10.4.27-MariaDB
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
-- Table structure for table `advertisements`
--

CREATE TABLE `advertisements` (
  `id` int(10) UNSIGNED NOT NULL,
  `ad_date` date DEFAULT NULL,
  `ad_note` varchar(255) DEFAULT NULL,
  `ad_expense` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `advertisements`
--

INSERT INTO `advertisements` (`id`, `ad_date`, `ad_note`, `ad_expense`, `created_at`, `updated_at`) VALUES
(1, '2023-03-02', 'FB', 7.22, '2023-03-03 01:50:00', '2023-03-03 06:23:30');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
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
  `symbol` varchar(5) DEFAULT NULL,
  `full_name` varchar(50) DEFAULT NULL,
  `short_name` varchar(3) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `rate`, `symbol`, `full_name`, `short_name`, `country`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4100, '៛', 'Khmer Riel', 'KHR', 'Cambodia', '2023-02-08 05:02:00', '2023-02-07 22:02:28', NULL),
(2, 2.95, '%', 'Visa Card Fee', 'VCF', 'World Wide', '2023-02-08 04:40:56', '2023-02-08 04:40:56', NULL),
(3, 0, '%', 'Tax VAT', 'VAT', 'Cambodia', '2023-02-20 22:31:00', '2023-03-02 07:59:04', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `id` int(10) UNSIGNED NOT NULL,
  `customer_name` varchar(255) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`id`, `customer_name`, `contact`, `address`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'General Customer', 'N/A', 'N/A', '2023-02-05 05:57:00', '2023-02-25 04:34:03', NULL),
(2, 'Yuvorak Kov', '087918148', 'ឃ្លាំងរំសេវ', '2023-03-02 14:00:09', NULL, NULL),
(3, 'Sokbe', '0882224568', 'ផ្សារកណ្ដាល', '2023-03-02 15:02:11', NULL, NULL),
(4, 'N/A', '0885068881', 'តាកែវ VET', '2023-03-03 03:13:38', NULL, NULL),
(5, 'Part Raksmey', '0885229934', 'ផ្សារដីហុយ', '2023-03-03 03:17:41', NULL, NULL),
(6, 'Kim Thiyong', '092222151', 'Siem Reap', '2023-03-03 11:23:31', NULL, NULL),
(7, 'RATH SEYMA', '0966777625', 'Prey Veng VET', '2023-03-03 11:25:02', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{}', 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, '{}', 4),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, '{}', 5),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, '{}', 6),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, '{}', 8),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}', 10),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 11),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, '{}', 12),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 0, 1, 1, 1, 1, 1, '{}', 9),
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
(138, 14, 'sale_belongsto_user_relationship', 'relationship', 'Seller', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"seller_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 6),
(139, 1, 'email_verified_at', 'timestamp', 'Email Verified At', 0, 1, 1, 1, 1, 1, '{}', 6),
(140, 1, 'deleted_at', 'timestamp', 'Deleted At', 0, 1, 1, 1, 1, 1, '{}', 12),
(141, 24, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(142, 24, 'ad_date', 'date', 'Ad Date', 0, 1, 1, 1, 1, 1, '{}', 2),
(143, 24, 'ad_note', 'text', 'Ad Note', 0, 1, 1, 1, 1, 1, '{}', 3),
(144, 24, 'ad_expense', 'number', 'Ad Expense', 0, 1, 1, 1, 1, 1, '{}', 4),
(145, 24, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 5),
(146, 24, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6);

-- --------------------------------------------------------

--
-- Table structure for table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `display_name_singular` varchar(255) NOT NULL,
  `display_name_plural` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `policy_name` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2023-02-03 07:04:07', '2023-03-02 21:10:14'),
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
(22, 'purchases', 'purchases', 'Purchase', 'Purchases', NULL, 'App\\Models\\Purchase', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-02-08 04:22:56', '2023-02-08 05:08:57'),
(24, 'advertisements', 'advertisements', 'Advertisement', 'Advertisements', NULL, 'App\\Models\\Advertisement', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-03-03 01:48:07', '2023-03-03 01:48:07'),
(28, 'delivery_expense', 'delivery-expense', 'Delivery Expense', 'Delivery Expenses', NULL, 'App\\Models\\DeliveryExpense', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-03-03 05:32:33', '2023-03-03 05:32:33');

-- --------------------------------------------------------

--
-- Table structure for table `delivery_expenses`
--

CREATE TABLE `delivery_expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `sale_id` int(11) DEFAULT NULL,
  `expense_amount` double DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `delivery_expenses`
--

INSERT INTO `delivery_expenses` (`id`, `sale_id`, `expense_amount`, `note`, `created_at`, `updated_at`, `deleted_at`) VALUES
(12, 7, 1.5, NULL, '2023-03-03 06:08:44', '2023-03-03 06:08:44', NULL),
(13, 6, 1.5, NULL, '2023-03-03 06:08:56', '2023-03-03 06:08:56', NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `hold_carts`
--

CREATE TABLE `hold_carts` (
  `id` int(11) UNSIGNED NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `unit_price` double DEFAULT NULL,
  `cost` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `amount` double NOT NULL,
  `cart_type` varchar(25) NOT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 'shop', '2023-03-02 21:14:33', '2023-03-02 21:18:49');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `parameters` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2023-02-03 07:04:07', '2023-02-03 07:04:07', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, 38, 1, '2023-02-03 07:04:07', '2023-03-02 22:28:29', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, 30, 3, '2023-02-03 07:04:07', '2023-03-02 22:26:03', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, 10, 1, '2023-02-03 07:04:07', '2023-03-02 22:27:25', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 8, '2023-02-03 07:04:07', '2023-03-03 01:39:13', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2023-02-03 07:04:07', '2023-03-02 20:47:25', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2023-02-03 07:04:07', '2023-03-02 22:28:25', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2023-02-03 07:04:07', '2023-03-02 22:28:25', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2023-02-03 07:04:07', '2023-03-02 22:28:25', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 6, '2023-02-03 07:04:07', '2023-03-03 01:39:13', 'voyager.settings.index', NULL),
(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, 38, 4, '2023-02-03 07:04:07', '2023-03-02 22:28:34', 'voyager.categories.index', NULL),
(12, 1, 'Posts', '', '_self', 'voyager-news', NULL, 38, 2, '2023-02-03 07:04:07', '2023-03-02 22:28:30', 'voyager.posts.index', NULL),
(13, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, 38, 3, '2023-02-03 07:04:07', '2023-03-02 22:28:31', 'voyager.pages.index', NULL),
(17, 1, 'Products', '', '_self', 'voyager-data', '#000000', 29, 1, '2023-02-05 03:10:13', '2023-03-02 23:52:27', 'voyager.products.index', 'null'),
(19, 1, 'Products Types', '', '_self', NULL, NULL, 29, 2, '2023-02-05 03:30:38', '2023-03-02 20:47:44', 'voyager.products-types.index', NULL),
(20, 1, 'Customers', '', '_self', NULL, NULL, 30, 1, '2023-02-05 05:56:14', '2023-03-02 20:48:27', 'voyager.customers.index', NULL),
(21, 1, 'Suppliers', '', '_self', NULL, NULL, 30, 2, '2023-02-05 06:02:18', '2023-03-02 20:48:35', 'voyager.suppliers.index', NULL),
(22, 1, 'Sales', '/admin/sales/create', '_self', 'voyager-basket', '#000000', 31, 1, '2023-02-05 06:16:30', '2023-03-02 22:33:52', NULL, ''),
(23, 1, 'Currencies', '', '_self', 'voyager-resize-full', '#000000', 10, 2, '2023-02-05 06:20:40', '2023-03-03 01:39:11', 'voyager.currencies.index', 'null'),
(24, 1, 'Product Stocks', '', '_self', NULL, NULL, 29, 3, '2023-02-07 22:51:30', '2023-03-02 20:47:50', 'voyager.product-stocks.index', NULL),
(28, 1, 'Purchases', '', '_self', NULL, NULL, 31, 2, '2023-02-08 04:22:56', '2023-03-02 20:49:25', 'voyager.purchases.index', NULL),
(29, 1, 'Products', '', '_self', 'voyager-archive', '#000000', NULL, 4, '2023-03-02 20:47:20', '2023-03-02 22:29:28', NULL, ''),
(30, 1, 'Peoples', '', '_self', 'voyager-people', '#000000', NULL, 3, '2023-03-02 20:48:10', '2023-03-02 22:27:40', NULL, ''),
(31, 1, 'POS', '', '_self', 'voyager-basket', '#000000', NULL, 2, '2023-03-02 20:49:12', '2023-03-02 22:32:37', NULL, ''),
(32, 1, 'Repots', '', '_self', 'voyager-pie-graph', '#000000', NULL, 5, '2023-03-02 20:49:44', '2023-03-02 22:29:32', NULL, ''),
(33, 2, 'Dashboard', '', '_self', 'voyager-home', '#000000', NULL, 15, '2023-03-02 21:15:11', '2023-03-02 21:15:11', NULL, ''),
(34, 2, 'People', '', '_self', 'voyager-people', '#000000', NULL, 16, '2023-03-02 21:15:32', '2023-03-02 21:15:32', NULL, ''),
(35, 2, 'Products', '', '_self', 'voyager-archive', '#000000', NULL, 17, '2023-03-02 21:15:46', '2023-03-02 21:15:46', NULL, ''),
(36, 2, 'POS', '', '_self', 'voyager-basket', '#000000', NULL, 18, '2023-03-02 21:16:00', '2023-03-02 21:16:00', NULL, ''),
(37, 2, 'Reports', '', '_self', 'voyager-pie-graph', '#000000', NULL, 19, '2023-03-02 21:16:28', '2023-03-02 21:16:28', NULL, ''),
(38, 1, 'Others', '', '_self', 'voyager-plus', '#000000', NULL, 7, '2023-03-02 22:28:14', '2023-03-03 01:39:13', NULL, ''),
(39, 1, 'Stock Report', '/admin/reports/stocks-report', '_self', 'voyager-bar-chart', '#c378de', 32, 1, '2023-03-02 23:59:21', '2023-03-02 23:59:43', NULL, ''),
(40, 1, 'Sales Report', '/admin/reports/sales-report', '_self', 'voyager-receipt', '#db9129', 32, 2, '2023-03-03 01:39:00', '2023-03-03 01:39:13', NULL, ''),
(41, 1, 'Advertisements', '', '_self', NULL, NULL, 42, 1, '2023-03-03 01:48:07', '2023-03-03 05:21:45', 'voyager.advertisements.index', NULL),
(42, 1, 'Expense', '', '_self', 'voyager-external', '#d92096', NULL, 9, '2023-03-03 05:21:39', '2023-03-03 05:21:45', NULL, '');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
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
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'INACTIVE',
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
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
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
(105, 'delete_purchases', 'purchases', '2023-02-08 04:22:56', '2023-02-08 04:22:56'),
(106, 'browse_advertisements', 'advertisements', '2023-03-03 01:48:07', '2023-03-03 01:48:07'),
(107, 'read_advertisements', 'advertisements', '2023-03-03 01:48:07', '2023-03-03 01:48:07'),
(108, 'edit_advertisements', 'advertisements', '2023-03-03 01:48:07', '2023-03-03 01:48:07'),
(109, 'add_advertisements', 'advertisements', '2023-03-03 01:48:07', '2023-03-03 01:48:07'),
(110, 'delete_advertisements', 'advertisements', '2023-03-03 01:48:07', '2023-03-03 01:48:07'),
(116, 'browse_delivery_expense', 'delivery_expense', '2023-03-03 05:32:33', '2023-03-03 05:32:33'),
(117, 'read_delivery_expense', 'delivery_expense', '2023-03-03 05:32:33', '2023-03-03 05:32:33'),
(118, 'edit_delivery_expense', 'delivery_expense', '2023-03-03 05:32:33', '2023-03-03 05:32:33'),
(119, 'add_delivery_expense', 'delivery_expense', '2023-03-03 05:32:33', '2023-03-03 05:32:33'),
(120, 'delete_delivery_expense', 'delivery_expense', '2023-03-03 05:32:33', '2023-03-03 05:32:33');

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
(1, 2),
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
(46, 2),
(47, 1),
(47, 2),
(48, 1),
(48, 2),
(49, 1),
(49, 2),
(50, 1),
(50, 2),
(51, 1),
(51, 2),
(52, 1),
(52, 2),
(53, 1),
(53, 2),
(54, 1),
(54, 2),
(55, 1),
(55, 2),
(56, 1),
(56, 2),
(57, 1),
(57, 2),
(58, 1),
(58, 2),
(59, 1),
(59, 2),
(60, 1),
(60, 2),
(61, 1),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(64, 1),
(64, 2),
(65, 1),
(65, 2),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(71, 3),
(72, 1),
(72, 2),
(72, 3),
(73, 1),
(73, 2),
(73, 3),
(74, 1),
(74, 2),
(74, 3),
(75, 1),
(75, 2),
(76, 1),
(76, 2),
(77, 1),
(77, 2),
(78, 1),
(78, 2),
(79, 1),
(79, 2),
(80, 1),
(80, 2),
(81, 1),
(81, 2),
(82, 1),
(82, 2),
(83, 1),
(83, 2),
(84, 1),
(84, 2),
(85, 1),
(85, 2),
(101, 1),
(101, 2),
(102, 1),
(102, 2),
(103, 1),
(103, 2),
(104, 1),
(104, 2),
(105, 1),
(105, 2),
(106, 1),
(107, 1),
(108, 1),
(109, 1),
(110, 1),
(116, 1),
(117, 1),
(118, 1),
(119, 1),
(120, 1);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
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
  `title` varchar(255) NOT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
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
  `product_code` varchar(30) DEFAULT NULL,
  `product_name` varchar(255) DEFAULT NULL,
  `product_type` int(11) DEFAULT NULL,
  `product_image` varchar(255) DEFAULT 'no_image.png',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `product_code`, `product_name`, `product_type`, `product_image`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'XA-585', 'Headlight with Computer', 1, 'products/February2023/CWS8HQqecG3SX7yxRUgn.jpg', NULL, '2023-02-05 05:46:17', NULL),
(2, 'BK-1718', 'Headlight Double T6 Led Light', 1, 'products/February2023/L1I3RTEAyhUS7sXVdkL6.jpg', NULL, '2023-02-05 05:46:28', NULL),
(3, 'Zoom Headlight', 'Zoom Headlight Battery AA', 1, 'products/February2023/j2i0kFnwjtnfHLOMF905.jpg', NULL, '2023-02-07 22:14:13', NULL),
(4, '7588', 'Headlight with horn', 1, 'products/February2023/vhComHt3czMkszWWj9x4.jpg', NULL, '2023-02-07 22:15:38', NULL),
(5, 'G69', 'GUB Headlight Double Len', 1, 'products/February2023/c8JQK4IwXle7F3Nw9tDg.jpg', NULL, '2023-02-07 22:17:07', NULL),
(6, 'Headlight with phone holder', 'Headlight 3 lens with phone holder', 1, 'products/February2023/Gr3BgOWEUGxjZ6goe0P0.jpg', NULL, '2023-02-07 22:21:20', NULL),
(7, 'Sensor Headlight', 'Sensor Headlight', 1, 'products/February2023/iKkSSB4b929Zqf3Ag6RU.jpg', NULL, '2023-02-09 07:11:07', NULL),
(8, 'bag', 'Phone Bag for bike', 3, 'products\\February2023\\Cz7MaghidE9GlrtFNd3q.jpg', NULL, '2023-02-24 05:45:00', NULL),
(9, 'FM-PEDAL black', 'FMFXTR PEDAL Red and Black', 2, 'products\\February2023\\uCMVzY8kbucKT2VYbCXL.jpg', NULL, '2023-02-27 22:02:39', NULL),
(10, 'GUB-PEDAL', 'GUB PEDAL 7 Color', 2, 'products\\February2023\\pmK1ZokqUa0qc6zgArwl.jpg', NULL, '2023-02-24 05:43:58', NULL),
(11, 'Arm Crank 3 Speed', 'Arm Crank 3 Speed', 2, 'products\\February2023\\Bz7PJPQalykp30LgcJfM.jpg', NULL, '2023-02-24 20:31:09', NULL),
(12, 'Wall mounted bike', 'Wall mounted bike', 3, 'products\\February2023\\zKwkj3NhZL0kPVGs9l8L.jpg', NULL, '2023-02-24 20:32:06', NULL),
(13, 'Bottom Hub middle hub', 'Bottom Hub middle hub', 2, 'products\\February2023\\pVJK4prbmCRNXDRiHjqG.jpg', '2023-02-24 20:32:51', '2023-02-24 20:32:51', NULL),
(14, 'Brake Pads', 'Brake Pads', 2, 'products\\February2023\\dUeaJtoNJ5Q3Yd4fulH3.jpg', '2023-02-24 20:33:24', '2023-02-24 20:33:24', NULL),
(15, 'Chain Spray', 'Chain Spray', 3, 'products\\February2023\\rJiVgM43ATrzKOMZDEUJ.jpg', '2023-02-24 20:34:10', '2023-02-24 20:34:10', NULL),
(16, 'Disc Brake clipper', 'Disc Brake clipper', 2, 'products\\February2023\\ACIwvQGnfIzDGni74irL.jpg', '2023-02-24 20:34:32', '2023-02-24 20:34:32', NULL),
(17, 'RT56', 'Disc Brake RT56', 2, 'products\\February2023\\1jVPPa6BEMlcEC2lsoXx.jpg', '2023-02-24 20:35:33', '2023-02-24 20:35:33', NULL),
(18, 'Full Mudguard', 'Full Mudguard', 2, 'products\\February2023\\n7zAQQtIjWyvStQlwCJV.jpg', '2023-02-24 20:36:00', '2023-02-24 20:36:00', NULL),
(19, 'Hub Set', 'Hub Set', 2, 'products\\February2023\\xHXNtHe78MJSGDwXYFLM.jpg', '2023-02-24 20:36:33', '2023-02-24 20:36:33', NULL),
(20, 'Oil 120ml', 'Multiple Lubricant Oil 120ml', 3, 'products\\February2023\\bM51qioR4adX0Tc9A3xG.jpg', '2023-02-24 20:37:18', '2023-02-24 20:37:18', NULL),
(21, 'Punch Bag', 'Punch Bag', 3, 'products\\February2023\\6HuI2lKElIkKRurxVZba.jpg', '2023-02-24 20:37:44', '2023-02-24 20:37:44', NULL),
(22, 'Punch Box', 'Punch Box', 3, 'products\\February2023\\08NHM8psCKsN5BoeFjhE.jpg', '2023-02-24 20:38:09', '2023-02-24 20:38:09', NULL),
(23, 'Short Mudguard', 'Short Mudguard', 2, 'products\\February2023\\4Tb5eoNKsn0ouRHP7EkN.jpg', '2023-02-24 20:38:44', '2023-02-24 20:38:44', NULL),
(24, 'Chain 112 link', 'Chain 112 link silver single speed', 2, 'products\\February2023\\LEAhD1YMb3QkkkeROR5R.jpg', '2023-02-24 20:39:31', '2023-02-24 20:39:31', NULL),
(25, 'Crank Single Speed', 'Arm Crank Single Speed', 2, 'products\\February2023\\DZ8ZGekRwnRhNLjNqOjG.jpg', '2023-02-24 20:40:15', '2023-02-24 20:40:15', NULL),
(26, 'Sunshine Cassette', 'Sunshine Cassette 8s and 9s', 2, 'products\\February2023\\4024kywmQkOHoEzYTvxu.jpg', '2023-02-24 20:41:06', '2023-02-24 20:41:06', NULL),
(27, 'Wheel tool', 'Wheel tool', 2, 'products\\February2023\\CJFBCDl9VFgHuUMjBEdo.jpg', '2023-02-24 20:41:42', '2023-02-24 20:41:42', NULL),
(28, 'Bike Cover', 'Bike Cover', 3, 'products\\February2023\\xqBKJipQIEEnuiFjxAHi.jpg', '2023-02-24 20:42:39', '2023-02-24 20:42:39', NULL),
(29, 'cover seat', 'cover seat', 3, 'products\\February2023\\uXlaHle2C9W9nVHtDgjm.jpg', '2023-02-24 20:43:15', '2023-02-24 20:43:15', NULL),
(30, 'Bag Exercise', 'Bag Exercise', 3, 'products\\February2023\\6Xta6YBCIve9Jg2CNtvN.jpg', '2023-02-24 20:43:53', '2023-02-24 20:43:53', NULL),
(31, 'Facial mask Golovejoy', 'Facial mask Golovejoy', 3, 'products\\February2023\\xV9Yqd1mGzJaGFbMBIDk.jpg', '2023-02-24 20:44:49', '2023-02-24 20:44:49', NULL),
(32, 'Adult Helmet', 'Adult Helmet', 3, 'products\\February2023\\NDE2xf7lr7K17cMP7IwQ.jpg', '2023-02-24 20:45:29', '2023-02-24 20:45:29', NULL),
(33, 'Kid Helmet', 'Kid Helmet', 3, 'products\\February2023\\emDNTm1c5eIqqtnGVQMF.jpg', '2023-02-24 20:46:07', '2023-02-24 20:46:07', NULL),
(34, 'Long Glove touchable', 'Long Glove touchable', 3, 'products\\February2023\\Crhz7jvgb8qcLu48JQnF.jpg', '2023-02-24 20:46:31', '2023-02-24 20:46:31', NULL),
(35, 'Helmet with mirror', 'Helmet with mirror', 3, 'products\\February2023\\72Kin0hjweYF7XWclkro.jpg', '2023-02-24 20:47:02', '2023-02-24 20:47:02', NULL),
(36, 'Full Color Sunglass', 'Full Color Sunglass', 3, 'products\\February2023\\UhKL3CWNjirHcdO3iH0o.jpg', '2023-02-24 20:47:45', '2023-02-24 20:47:45', NULL),
(37, 'Short Glove', 'Short Glove', 3, 'products\\February2023\\pNn6kY1QTayolvKtuf6z.jpg', '2023-02-24 20:48:07', '2023-02-24 20:48:07', NULL),
(38, 'Simple Facial Mask', 'Simple Facial Mask', 3, 'products\\February2023\\V1oIAoyx0qwTOJaYw2oy.jpg', '2023-02-24 20:48:45', '2023-02-24 20:48:45', NULL),
(39, 'Taillight with AA battery', 'Taillight with AA battery', 1, 'products\\February2023\\cCCQ0LKL35oJht4Itl8a.jpg', '2023-02-24 20:49:27', '2023-02-24 20:49:27', NULL),
(40, 'Backlight LED 2 colors', 'Backlight LED 2 colors', 1, 'products\\February2023\\HlE05BoSZ0Rzidc9NAIJ.jpg', '2023-02-24 20:50:01', '2023-02-24 20:50:01', NULL),
(41, 'Back light ball style', 'Back light ball style', 1, 'products\\February2023\\eTaUhrlLkVrsy75JLYpc.jpg', '2023-02-24 20:50:29', '2023-02-24 20:50:29', NULL),
(42, 'Mini backlight', 'Mini backlight', 1, 'products\\February2023\\MVlNdHKkk9ZTJ6KKMtwo.jpg', '2023-02-24 20:51:19', '2023-02-24 20:51:19', NULL),
(43, 'Wheel LED AA battery', 'Wheel LED AA battery', 1, 'products\\February2023\\8DyftjTOJRK2sYptfPih.jpg', '2023-02-24 20:52:07', '2023-02-24 20:52:07', NULL),
(44, 'Rear Rack or Back Rack', 'Rear Rack or Back Rack', 2, 'products\\February2023\\w7NhjcQTeEW5ExCdJn5n.jpg', '2023-02-24 20:52:29', '2023-02-24 20:52:29', NULL),
(45, 'Ball mirror', 'Ball mirror', 3, 'products\\February2023\\Gm3UAj9xWTbBsBOEGsSX.jpg', '2023-02-24 20:53:02', '2023-02-24 20:53:02', NULL),
(46, 'Bike bag B-soul', 'Bike bag B-soul', 3, 'products\\February2023\\E8HXsKnoseOPgstv2Nft.jpg', '2023-02-24 21:00:52', '2023-02-24 21:00:52', NULL),
(47, 'brake lever', 'brake lever or brake handle bar', 2, 'products\\February2023\\hom9wa7ZoEemA4zD6jte.jpg', '2023-02-24 21:01:24', '2023-02-24 21:01:24', NULL),
(48, 'Brake line & Speed kit Teflon', 'Brake line & Speed kit Teflon', 2, 'products\\February2023\\gLvcXLbsY7wA93xBJxId.jpg', '2023-02-24 21:03:35', '2023-02-24 21:20:56', NULL),
(49, 'Brake line & Speed kit', 'Brake line & Speed kit Stand less steel', 2, 'products\\February2023\\D9eBLjoICrGblWqgMgJc.jpg', '2023-02-24 21:03:54', '2023-02-24 21:20:41', NULL),
(50, 'Fat Bike Seat', 'Fat Bike Seat', 2, 'products\\February2023\\3CCV3T5nrjC9BqeZ5U9w.jpg', '2023-02-24 21:04:47', '2023-02-24 21:04:47', NULL),
(51, 'Raylight Grips', 'Raylight Grips', 2, 'products\\February2023\\5EHfiYP6jFhtsrVxWDcw.jpg', '2023-02-24 21:05:11', '2023-02-24 21:05:11', NULL),
(52, 'Handlebar 780mm FMFXTR', 'Handlebar 780mm FMFXTR', 2, 'products\\February2023\\cIoREBQ8CbIz0y3DBpVh.jpg', '2023-02-24 21:05:32', '2023-02-24 21:05:32', NULL),
(53, 'Hard Grip', 'Hard Grip', 2, 'products\\February2023\\rlm5eRxmIZNHQ0QJcfDD.jpg', '2023-02-24 21:06:14', '2023-02-24 21:06:14', NULL),
(54, 'Long Stem', 'Long Stem', 2, 'products\\February2023\\iF0b15Q7nsdbR5wpVimh.jpg', '2023-02-24 21:06:39', '2023-02-24 21:06:39', NULL),
(55, 'Low or high Stem', 'Low or high Stem', 2, 'products\\February2023\\hPXqYh3v8mUvJmCUGCFL.jpg', '2023-02-24 21:07:30', '2023-02-24 21:07:30', NULL),
(56, 'Mini computer', 'Mini computer', 3, 'products\\February2023\\13SETt3d8iE98cUIcuok.jpg', '2023-02-24 21:07:53', '2023-02-24 21:07:53', NULL),
(57, 'GUB Phone holder', 'GUB Phone holder', 3, 'products\\February2023\\HdRtUtBjOKlEbJ5Lf98j.jpg', '2023-02-24 21:08:22', '2023-02-24 21:08:22', NULL),
(58, 'Simple Phone Holder', 'Simple Phone Holder', 3, 'products\\February2023\\tyruP95fr0XRhAXwvdc4.jpg', '2023-02-24 21:08:53', '2023-02-24 21:08:53', NULL),
(59, 'Rotatable Stem', 'Rotatable Stem', 2, 'products\\February2023\\G5SU0AlsARmKyP3s9cUJ.jpg', '2023-02-24 21:09:22', '2023-02-24 21:09:22', NULL),
(60, 'Seat post clamp', 'Seat post clamp', 2, 'products\\February2023\\an271OsoqRSsONLm6uv1.jpg', '2023-02-24 21:09:44', '2023-02-24 21:09:44', NULL),
(61, 'Seatpost FMFXTR', 'Seatpost FMFXTR', 2, 'products\\February2023\\jy0HqXKH0y9jEDG99ilb.jpg', '2023-02-24 21:10:14', '2023-02-24 21:10:14', NULL),
(62, 'Short Stem FMFXTR', 'Short Stem FMFXTR', 2, 'products\\February2023\\5I0OkoQcD2w0WHqoT4qJ.jpg', '2023-02-24 21:10:42', '2023-02-24 21:10:42', NULL),
(63, 'Slim Bike Seat Saddle', 'Slim Bike Seat Saddle', 2, 'products\\February2023\\YVYbQ7pzHKymYWnqDKBR.jpg', '2023-02-24 21:11:13', '2023-02-24 21:11:13', NULL),
(64, 'Stem extension', 'Stem extension', 2, 'products\\February2023\\hLKJFkteDBAo3HR48Yyd.jpg', '2023-02-24 21:11:54', '2023-02-24 21:11:54', NULL),
(65, 'TONYON Lock chain 5 digits', 'TONYON Lock chain 5 digits', 3, 'products\\February2023\\3xupnglXQqa2LYqLNLN3.jpg', '2023-02-24 21:12:23', '2023-02-24 21:12:23', NULL),
(66, 'Seatpost Zoom', 'Seatpost Zoom', 2, 'products\\February2023\\KR9NnD8e1OZBcn36r8qA.jpg', '2023-02-24 21:12:48', '2023-02-24 21:12:48', NULL),
(67, '4 digits bike lock', '4 digits bike lock', 3, 'products\\February2023\\FMz7x9GT0DMNccRab9XZ.jpg', '2023-02-24 21:13:39', '2023-02-24 21:13:39', NULL),
(68, '5 digits bike lock', '5 digits bike lock', 3, 'products\\February2023\\gitWyQa4Twtce8L46oUJ.jpg', '2023-02-24 21:14:06', '2023-02-24 21:14:06', NULL),
(69, 'Cassette and Hub remover tools', 'Cassette and Hub remover tools', 3, 'products\\February2023\\xTz0rwkTR14S5opgiOnG.jpg', '2023-02-24 21:14:43', '2023-02-27 21:27:44', NULL),
(70, 'Chain Cleaning Tools', 'Chain Cleaning Tools', 3, 'products\\February2023\\CBdlB4nJvUPoGqDhywLl.jpg', '2023-02-24 21:15:09', '2023-02-24 21:15:09', NULL),
(71, 'Chain Cutting Tools', 'Chain Cutting Tools', 3, 'products\\February2023\\ZmF4RJlrLhha4Ao656Eo.jpg', '2023-02-24 21:15:31', '2023-02-27 21:27:56', NULL),
(72, 'Disc bike lock', 'Disc bike lock', 3, 'products\\February2023\\3Fc8pa8HWNGx2xBoA8Uy.jpg', '2023-02-24 21:16:03', '2023-02-24 21:16:03', NULL),
(73, 'Kickstand', 'Kickstand', 2, 'products\\February2023\\Kvd0T65ck8Bsyne3xmAQ.jpg', '2023-02-24 21:16:21', '2023-02-24 21:16:21', NULL),
(74, 'L-Type Bike Stand', 'L-Type Bike Stand', 3, 'products\\February2023\\S1qFpcuFdj4G7p9OM3TV.jpg', '2023-02-24 21:16:42', '2023-02-24 21:16:42', NULL),
(75, 'Mini multiple tools', 'Mini multiple tools', 3, 'products\\February2023\\y2PCJR0z4BFHuHPhegAQ.jpg', '2023-02-24 21:17:02', '2023-02-24 21:17:02', NULL),
(76, 'water bottle cage', 'water bottle cage', 3, 'products\\February2023\\C1Q2U9IrKf9gbIo3adt2.jpg', '2023-02-24 21:17:38', '2023-02-24 21:17:38', NULL),
(77, 'Extension bottle cage', 'Extension bottle cage', 3, 'products\\February2023\\9Bzk3HqaKCkO5s0FPsAL.jpg', '2023-02-24 21:18:26', '2023-02-24 21:18:26', NULL),
(78, 'plastic water bottle', 'plastic water bottle', 3, 'products\\February2023\\1l5YkZB50AWRnz2wIZhG.jpg', '2023-02-24 21:19:44', '2023-02-24 21:19:44', NULL),
(79, 'AS1010', 'Backlight AS1010', 1, 'products\\February2023\\v7C67lGdstJD40KXQIaQ.jpg', '2023-02-27 21:18:06', '2023-02-27 21:18:06', NULL),
(80, 'SNAIL Single Speed', 'Snail Single Speed Chain Ring', 2, 'products\\February2023\\oR1cgAmliCjS3CRbVHPc.jpg', '2023-02-27 21:19:12', '2023-02-27 21:19:12', NULL),
(81, 'mini handle bar', 'mini handle bar FMFXTR', 2, 'products\\February2023\\kbIfFPuMnQC62Gn0VZrE.jpg', '2023-02-27 21:20:08', '2023-02-27 21:20:08', NULL),
(82, 'FM-PEDAL 7 color', 'FMFXTR PEDAL 7 color', 2, 'products\\February2023\\Aw3ixELo2BlodgVjq79D.jpg', '2023-02-27 22:03:24', '2023-02-27 22:03:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `products_types`
--

CREATE TABLE `products_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `type_description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products_types`
--

INSERT INTO `products_types` (`id`, `type_name`, `type_description`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Light', NULL, '2023-02-05 05:13:36', '2023-02-05 05:13:36', NULL),
(2, 'Spare Part', NULL, '2023-02-05 05:14:54', '2023-02-05 05:14:54', NULL),
(3, 'Accessories', NULL, '2023-02-05 05:15:33', '2023-02-05 05:15:33', NULL);

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
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `product_stocks`
--

INSERT INTO `product_stocks` (`id`, `product_id`, `sale_price`, `cost`, `total_qty`, `created_at`, `updated_at`, `deleted_at`) VALUES
(48, 68, 6, 1.6, 3, '2023-02-28 06:04:04', '2023-03-02 07:11:56', NULL),
(49, 4, 6, 1.9, 6, '2023-02-28 06:04:04', '2023-03-02 07:14:36', NULL),
(50, 32, 9, 3, 7, '2023-02-28 06:04:04', '2023-03-02 07:26:33', NULL),
(51, 8, 8, 2.3, 0, '2023-02-28 06:04:04', '2023-03-03 14:53:32', NULL),
(52, 30, 5, 3.8, 7, '2023-02-28 06:04:04', '2023-03-02 07:30:16', NULL),
(53, 45, 2.5, 0.4, 26, '2023-02-28 06:04:04', '2023-03-02 07:28:36', NULL),
(54, 28, 5, 1.5, 8, '2023-02-28 06:04:04', '2023-03-02 07:43:50', NULL),
(55, 2, 13, 6.3, 3, '2023-02-28 06:04:04', '2023-03-03 14:52:41', NULL),
(56, 13, 6, 1.85, 1, '2023-02-28 06:04:04', '2023-03-02 07:41:27', NULL),
(57, 47, 8, 2.5, 14, '2023-02-28 06:04:04', '2023-03-02 07:25:30', NULL),
(58, 49, 5, 1.8, 3, '2023-02-28 06:04:04', '2023-03-02 07:25:00', NULL),
(59, 48, 7, 2.3, 5, '2023-02-28 06:04:04', '2023-03-02 07:24:42', NULL),
(60, 14, 4, 1, 4, '2023-02-28 06:04:04', '2023-03-02 07:25:49', NULL),
(61, 70, 4, 1.35, 6, '2023-02-28 06:04:04', '2023-03-02 07:09:41', NULL),
(62, 71, 4, 1.9, -6, '2023-02-28 06:04:04', '2023-03-03 14:53:56', NULL),
(63, 29, 5, 0.9, 20, '2023-02-28 06:04:04', '2023-03-02 07:15:25', NULL),
(64, 25, 13, 6.9, 8, '2023-02-28 06:04:04', '2023-03-02 07:19:08', NULL),
(65, 72, 3, 0.9, 30, '2023-02-28 06:04:04', '2023-03-02 07:29:50', NULL),
(66, 16, 2.5, 5, 8, '2023-02-28 06:04:04', '2023-03-02 07:40:16', NULL),
(67, 50, 10, 2.5, 7, '2023-02-28 06:04:04', '2023-03-02 07:51:08', NULL),
(68, 9, 13, 7, 10, '2023-02-28 06:04:04', '2023-03-02 07:22:13', NULL),
(69, 36, 2.5, 0.76, 12, '2023-02-28 06:04:04', '2023-03-02 07:50:20', NULL),
(70, 57, 3, 2.5, 6, '2023-02-28 06:04:04', '2023-03-02 07:48:17', NULL),
(71, 52, 10, 4.7, 7, '2023-02-28 06:04:04', '2023-03-02 07:23:02', NULL),
(72, 35, 13, 6.5, 4, '2023-02-28 06:04:04', '2023-03-02 07:26:51', NULL),
(73, 54, 7, 3, 6, '2023-02-28 06:04:04', '2023-03-02 07:18:35', NULL),
(74, 55, 10, 3.5, 3, '2023-02-28 06:04:04', '2023-03-02 07:49:36', NULL),
(75, 75, 4, 1, 12, '2023-02-28 06:04:04', '2023-03-02 07:52:17', NULL),
(76, 20, 4, 2, 4, '2023-02-28 06:04:04', '2023-03-02 07:27:38', NULL),
(77, 78, 3, 0.8, 7, '2023-02-28 06:04:04', '2023-03-03 14:53:07', NULL),
(78, 21, 18, 9, 3, '2023-02-28 06:04:04', '2023-03-02 07:49:15', NULL),
(79, 59, 10, 5.5, 2, '2023-02-28 06:04:04', '2023-03-02 07:21:44', NULL),
(80, 17, 5, 1.2, 23, '2023-02-28 06:04:04', '2023-03-02 07:23:45', NULL),
(81, 60, 4, 1.8, 3, '2023-02-28 06:04:04', '2023-03-02 07:16:00', NULL),
(82, 61, 9, 4.5, 5, '2023-02-28 06:04:04', '2023-03-02 07:20:22', NULL),
(83, 66, 15, 8.5, 8, '2023-02-28 06:04:04', '2023-03-02 07:19:58', NULL),
(84, 23, 3, 0.6, 13, '2023-02-28 06:04:04', '2023-03-03 14:53:32', NULL),
(85, 62, 6, 2.2, 9, '2023-02-28 06:04:04', '2023-03-02 07:21:19', NULL),
(86, 38, 2, 0.2, 9, '2023-02-28 06:04:04', '2023-03-02 07:12:26', NULL),
(87, 63, 9, 2.8, 1, '2023-02-28 06:04:04', '2023-03-02 07:19:33', NULL),
(88, 26, 10, 6.5, 1, '2023-02-28 06:04:04', '2023-03-02 07:31:16', NULL),
(89, 39, 3, 0.3, 1, '2023-02-28 06:04:04', '2023-03-02 07:44:24', NULL),
(90, 76, 3, 0.8, 2, '2023-02-28 06:04:04', '2023-03-02 07:55:38', NULL),
(91, 43, 3, 1.9, 1, '2023-02-28 06:04:04', '2023-03-02 07:28:04', NULL),
(92, 1, 14, 6.5, -3, '2023-02-28 06:04:04', '2023-03-03 14:53:07', NULL),
(93, 3, 10, 2.25, 12, '2023-02-28 06:04:04', '2023-03-02 07:39:15', NULL),
(94, 82, 15, 9.5, 4, '2023-02-28 06:04:04', '2023-03-02 07:22:44', NULL),
(95, 79, 3, 0.8, 15, '2023-02-28 06:05:20', '2023-03-02 07:43:20', NULL),
(96, 80, 8, 3.2, 9, '2023-02-28 06:05:20', '2023-03-02 07:56:56', NULL),
(97, 81, 8, 2.2, 10, '2023-02-28 06:05:20', '2023-03-02 07:45:11', NULL),
(98, 27, 2, 0.5, 3, '2023-02-28 06:05:20', '2023-03-03 15:13:52', NULL),
(99, 12, 5, 1.1, 36, '2023-02-28 06:05:20', '2023-03-02 07:29:05', NULL),
(100, 65, 7, 3.5, 29, '2023-02-28 06:05:20', '2023-03-02 07:29:26', NULL),
(101, 22, 3, 0.3, 55, '2023-02-28 06:05:20', '2023-03-02 07:10:40', NULL),
(102, 11, 8, 2.6, 10, '2023-02-28 06:05:20', '2023-03-02 07:38:39', NULL),
(103, 18, 3, 0.7, 75, '2023-02-28 06:05:20', '2023-03-03 14:53:32', NULL),
(104, 19, 5, 2.4, 9, '2023-02-28 06:05:20', '2023-03-02 07:41:57', NULL),
(105, 33, 8, 3, 35, '2023-02-28 06:05:20', '2023-03-02 07:13:32', NULL),
(106, 34, 6, 2.5, 33, '2023-02-28 06:05:20', '2023-03-02 07:27:13', NULL),
(107, 44, 5.3, 15, 2, '2023-03-02 13:56:49', '2023-03-02 07:03:20', NULL),
(108, 74, 10, 3.4, -3, '2023-03-02 13:56:49', '2023-03-03 14:54:11', NULL),
(109, 51, 4, 1.7, 67, '2023-03-02 14:37:04', '2023-03-02 07:37:35', NULL),
(110, 58, 3, 1.4, 6, '2023-03-02 14:47:03', '2023-03-03 14:54:11', NULL);

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
  `tax_vat` double NOT NULL DEFAULT 0,
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

INSERT INTO `purchases` (`id`, `supplier_id`, `total_qty`, `freight_fee`, `discount`, `amount`, `visa_fee`, `other_fee`, `forwarder_fee`, `tax_vat`, `net_amount`, `purchaser`, `purchase_date`, `balance`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 4, 353, 0, 0, 0, 0, NULL, 0, 0, 0, 1, '2023-02-27', 0, NULL, NULL, NULL),
(2, 4, 327, 0, 0, 0, 0, NULL, 0, 0, 0, 1, '2023-02-28', 0, NULL, NULL, NULL),
(4, 4, 7, 0, 0, 0, 0, NULL, 0, 0, 0, 1, '2023-02-28', 0, NULL, NULL, NULL),
(5, 4, 67, 0, 0, 0, 0, NULL, 0, 0, 0, 1, '2023-02-28', 0, NULL, NULL, NULL),
(6, 4, 10, 0, 0, 0, 0, NULL, 0, 0, 0, 1, '2023-02-28', 0, NULL, NULL, NULL);

--
-- Triggers `purchases`
--
DELIMITER $$
CREATE TRIGGER `afterUpdatePurchaseDeleted` AFTER UPDATE ON `purchases` FOR EACH ROW BEGIN
    IF ISNULL(new.deleted_at)  THEN
    	UPDATE purchase_records
        SET purchase_records.deleted_at = NULL
        WHERE purchase_records.purchase_id = new.id;
    ELSE
    	UPDATE purchase_records 
        SET purchase_records.deleted_at = new.deleted_at
        WHERE purchase_records.purchase_id = new.id;
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
  `purchase_id` int(11) DEFAULT NULL,
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

INSERT INTO `purchase_records` (`id`, `purchase_id`, `product_id`, `quantity`, `cost`, `sale_price`, `cost_amount`, `created_at`, `updated_at`, `deleted_at`) VALUES
(153, 1, 68, 3, 0, NULL, 0, NULL, NULL, NULL),
(154, 1, 4, 6, 0, NULL, 0, NULL, NULL, NULL),
(155, 1, 32, 7, 0, NULL, 0, NULL, NULL, NULL),
(156, 1, 8, 2, 0, NULL, 0, NULL, NULL, NULL),
(157, 1, 30, 7, 0, NULL, 0, NULL, NULL, NULL),
(158, 1, 45, 26, 0, NULL, 0, NULL, NULL, NULL),
(159, 1, 28, 8, 0, NULL, 0, NULL, NULL, NULL),
(160, 1, 2, 7, 0, NULL, 0, NULL, NULL, NULL),
(161, 1, 13, 1, 0, NULL, 0, NULL, NULL, NULL),
(162, 1, 47, 14, 0, NULL, 0, NULL, NULL, NULL),
(163, 1, 49, 3, 0, NULL, 0, NULL, NULL, NULL),
(164, 1, 48, 5, 0, NULL, 0, NULL, NULL, NULL),
(165, 1, 14, 4, 0, NULL, 0, NULL, NULL, NULL),
(166, 1, 70, 6, 0, NULL, 0, NULL, NULL, NULL),
(167, 1, 71, 2, 0, NULL, 0, NULL, NULL, NULL),
(168, 1, 29, 20, 0, NULL, 0, NULL, NULL, NULL),
(169, 1, 25, 8, 0, NULL, 0, NULL, NULL, NULL),
(170, 1, 72, 30, 0, NULL, 0, NULL, NULL, NULL),
(171, 1, 16, 8, 0, NULL, 0, NULL, NULL, NULL),
(172, 1, 50, 7, 0, NULL, 0, NULL, NULL, NULL),
(173, 1, 9, 10, 0, NULL, 0, NULL, NULL, NULL),
(174, 1, 36, 12, 0, NULL, 0, NULL, NULL, NULL),
(175, 1, 57, 6, 0, NULL, 0, NULL, NULL, NULL),
(176, 1, 52, 7, 0, NULL, 0, NULL, NULL, NULL),
(177, 1, 35, 4, 0, NULL, 0, NULL, NULL, NULL),
(178, 1, 54, 6, 0, NULL, 0, NULL, NULL, NULL),
(179, 1, 55, 3, 0, NULL, 0, NULL, NULL, NULL),
(180, 1, 75, 12, 0, NULL, 0, NULL, NULL, NULL),
(181, 1, 20, 4, 0, NULL, 0, NULL, NULL, NULL),
(182, 1, 78, 12, 0, NULL, 0, NULL, NULL, NULL),
(183, 1, 21, 3, 0, NULL, 0, NULL, NULL, NULL),
(184, 1, 59, 2, 0, NULL, 0, NULL, NULL, NULL),
(185, 1, 17, 23, 0, NULL, 0, NULL, NULL, NULL),
(186, 1, 60, 3, 0, NULL, 0, NULL, NULL, NULL),
(187, 1, 61, 5, 0, NULL, 0, NULL, NULL, NULL),
(188, 1, 66, 8, 0, NULL, 0, NULL, NULL, NULL),
(189, 1, 23, 17, 0, NULL, 0, NULL, NULL, NULL),
(190, 1, 62, 10, 0, NULL, 0, NULL, NULL, NULL),
(191, 1, 38, 9, 0, NULL, 0, NULL, NULL, NULL),
(192, 1, 63, 1, 0, NULL, 0, NULL, NULL, NULL),
(193, 1, 26, 1, 0, NULL, 0, NULL, NULL, NULL),
(194, 1, 39, 1, 0, NULL, 0, NULL, NULL, NULL),
(195, 1, 76, 2, 0, NULL, 0, NULL, NULL, NULL),
(196, 1, 43, 1, 0, NULL, 0, NULL, NULL, NULL),
(197, 1, 1, 1, 0, NULL, 0, NULL, NULL, NULL),
(198, 1, 3, 12, 0, NULL, 0, NULL, NULL, NULL),
(199, 1, 82, 4, 0, NULL, 0, NULL, NULL, NULL),
(200, 2, 79, 15, 0, NULL, 0, NULL, NULL, NULL),
(201, 2, 80, 9, 0, NULL, 0, NULL, NULL, NULL),
(202, 2, 81, 10, 0, NULL, 0, NULL, NULL, NULL),
(203, 2, 27, 6, 0, NULL, 0, NULL, NULL, NULL),
(204, 2, 12, 36, 0, NULL, 0, NULL, NULL, NULL),
(205, 2, 65, 29, 0, NULL, 0, NULL, NULL, NULL),
(206, 2, 22, 55, 0, NULL, 0, NULL, NULL, NULL),
(207, 2, 11, 10, 0, NULL, 0, NULL, NULL, NULL),
(208, 2, 13, 1, 0, NULL, 0, NULL, NULL, NULL),
(209, 2, 18, 79, 0, NULL, 0, NULL, NULL, NULL),
(210, 2, 19, 9, 0, NULL, 0, NULL, NULL, NULL),
(211, 2, 33, 35, 0, NULL, 0, NULL, NULL, NULL),
(212, 2, 34, 33, 0, NULL, 0, NULL, NULL, NULL),
(213, 4, 44, 2, 0, NULL, 0, NULL, NULL, NULL),
(214, 4, 74, 5, 0, NULL, 0, NULL, NULL, NULL),
(215, 5, 51, 67, 0, NULL, 0, NULL, NULL, NULL),
(216, 6, 58, 10, 0, NULL, 0, NULL, NULL, NULL);

--
-- Triggers `purchase_records`
--
DELIMITER $$
CREATE TRIGGER `afterDeletePurchase` AFTER DELETE ON `purchase_records` FOR EACH ROW BEGIN
  UPDATE product_stocks
  SET product_stocks.total_qty = product_stocks.total_qty - old.quantity
  WHERE product_stocks.product_id = old.product_id;
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
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2023-02-03 07:04:07', '2023-02-03 07:04:07'),
(2, 'user', 'Admin User', '2023-02-03 07:04:07', '2023-02-24 05:25:03'),
(3, 'seller', 'Seller', '2023-02-24 05:27:25', '2023-02-24 05:27:25');

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
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `delivery_fee` double DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `cupon` double NOT NULL DEFAULT 0,
  `tax_vat` double NOT NULL DEFAULT 0,
  `total_cost` double NOT NULL,
  `profit` double DEFAULT NULL,
  `forwarder_fee` double DEFAULT NULL,
  `net_amount` double DEFAULT NULL,
  `balance` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sales`
--

INSERT INTO `sales` (`id`, `sale_date`, `customer_id`, `total_qty`, `amount`, `seller_id`, `created_at`, `updated_at`, `deleted_at`, `delivery_fee`, `discount`, `cupon`, `tax_vat`, `total_cost`, `profit`, `forwarder_fee`, `net_amount`, `balance`) VALUES
(1, '2023-03-02', 2, 2, 23, 1, '2023-03-02 14:59:40', NULL, NULL, 1.5, 0, 0, 0, 9.7, 13.5, NULL, 24.5, NULL),
(2, '2023-03-02', 3, 2, 17, 1, '2023-03-02 15:02:43', NULL, NULL, 1, 0, 0, 0, 7.3, 9.7, NULL, 18, NULL),
(3, '2023-03-01', 4, 3, 14, 1, '2023-03-03 03:15:35', NULL, NULL, 2, 0, 0, 0, 3.6, 10.4, NULL, 16, NULL),
(4, '2023-03-01', 5, 1, 4, 1, '2023-03-03 03:18:12', NULL, NULL, 1.5, 0, 0, 0, 1.9, 2.1, NULL, 5.5, NULL),
(5, '2023-03-03', 6, 1, 4, 1, '2023-03-03 11:23:50', NULL, NULL, 2, 0, 0, 0, 1.9, 2.1, NULL, 6, NULL),
(6, '2023-03-03', 7, 2, 13, 1, '2023-03-03 11:25:30', NULL, NULL, 2, 0, 0, 0, 4.8, 8.2, NULL, 15, NULL),
(7, '2023-03-03', 1, 1, 2, 1, '2023-03-03 15:00:50', NULL, NULL, 0, 0, 0, 0, 0.5, 1.5, NULL, 2, NULL);

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
  `cost` double DEFAULT NULL,
  `discount` double NOT NULL,
  `amount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sale_records`
--

INSERT INTO `sale_records` (`id`, `sale_id`, `product_id`, `quantity`, `unit_price`, `cost`, `discount`, `amount`, `created_at`, `updated_at`, `deleted_at`) VALUES
(3, 1, 2, 1, 13, 6.3, 0, 13, NULL, NULL, NULL),
(4, 1, 74, 1, 10, 3.4, 0, 10, NULL, NULL, NULL),
(5, 2, 78, 1, 3, 0.8, 0, 3, NULL, NULL, NULL),
(6, 2, 1, 1, 14, 6.5, 0, 14, NULL, NULL, NULL),
(7, 3, 23, 1, 3, 0.6, 0, 3, NULL, NULL, NULL),
(8, 3, 18, 1, 3, 0.7, 0, 3, NULL, NULL, NULL),
(9, 3, 8, 1, 8, 2.3, 0, 8, NULL, NULL, NULL),
(10, 4, 71, 1, 4, 1.9, 0, 4, NULL, NULL, NULL),
(15, 5, 71, 1, 4, 1.9, 0, 4, NULL, NULL, NULL),
(16, 6, 74, 1, 10, 3.4, 0, 10, NULL, NULL, NULL),
(17, 6, 58, 1, 3, 1.4, 0, 3, NULL, NULL, NULL),
(18, 7, 27, 1, 2, 0.5, 0, 2, NULL, NULL, NULL);

--
-- Triggers `sale_records`
--
DELIMITER $$
CREATE TRIGGER `afterDeleteSaleRecord` BEFORE DELETE ON `sale_records` FOR EACH ROW BEGIN
  UPDATE product_stocks
  SET product_stocks.total_qty = product_stocks.total_qty + old.quantity
  WHERE product_stocks.product_id = old.product_id;
END
$$
DELIMITER ;
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
  `key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Borey POS', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', NULL, '', 'text', 1, 'Admin'),
(11, 'admin.company_name', 'Company Name', 'Borey POS', NULL, 'text', 6, 'Admin'),
(12, 'admin.company_contact', 'Company Contact', '069356444 / 089491516', NULL, 'text', 7, 'Admin'),
(13, 'admin.company_address', 'Company Address', 'Borey New World 2 Tropang theung Market #45 Street 16', NULL, 'text', 8, 'Admin'),
(14, 'admin.company_bank_account', 'Company Bank Account', 'ABA : 000849769 PHEA BOREY / ACLEDA & WING : 069356444 BOREY PHEA', NULL, 'text', 9, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `id` int(10) UNSIGNED NOT NULL,
  `supplier_name` varchar(255) DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
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
(3, 'VPM Bike Shop', 'VPM', 'Street 77BT', '2023-02-07 22:06:27', '2023-02-07 22:06:27', NULL),
(4, 'Stock In Adjustment', '0', '0', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL,
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
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 1, 'Admin', 'admin@admin.com', 'users/default.png', NULL, '$2y$10$OZh6sNdjQ9La7OZduDwMjeHU4lyQU75p7MvafJkTbWF8x664n1Cfq', '3nT4l2BWaWE1aeB4xBoGBCGFvTNTQcr5hnuNr8LEuVxEJyaITPQAc9OAoGPT', NULL, '2023-02-03 07:04:07', '2023-02-03 07:04:07', NULL),
(2, 2, 'Borey Admin', 'boreyadmin@gmail.com', 'users/default.png', NULL, '$2y$10$6N76rPPks.ZlQxXa6PKf7.fPyn1MLJGevIcPqDyyC1N9TxIOhW.Fm', NULL, '{\"locale\":\"en\"}', '2023-02-24 05:29:33', '2023-02-24 05:29:33', NULL),
(3, 3, 'Borey Seller', 'boreyseller@gmail.com', 'users/default.png', NULL, '$2y$10$u2C8xLOZk6Q7OxqMqMCliOTHZbIXDf98YoSaQuifRuj4zQQCMk1xa', NULL, '{\"locale\":\"en\"}', '2023-02-24 05:30:17', '2023-02-24 05:30:17', NULL);

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
-- Indexes for table `advertisements`
--
ALTER TABLE `advertisements`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `delivery_expenses`
--
ALTER TABLE `delivery_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `hold_carts`
--
ALTER TABLE `hold_carts`
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
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT for table `advertisements`
--
ALTER TABLE `advertisements`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=158;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `delivery_expenses`
--
ALTER TABLE `delivery_expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `hold_carts`
--
ALTER TABLE `hold_carts`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

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
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `products_types`
--
ALTER TABLE `products_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `product_stocks`
--
ALTER TABLE `product_stocks`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT for table `purchases`
--
ALTER TABLE `purchases`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `purchase_records`
--
ALTER TABLE `purchase_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=217;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `sales`
--
ALTER TABLE `sales`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sale_records`
--
ALTER TABLE `sale_records`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
