-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Oct 08, 2025 at 12:27 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `visermart`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `email_verified_at`, `image`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@site.com', 'admin', NULL, '67737918433731735620888.png', '$2y$12$drjO157FMKemOowJqA4iJOI3bKGLv66lPpVVl.bnrg6fSukE1bnAi', 'lQmvW8av4uC0T1SkBqzE66iolxYnktTrtKjg07lubzzcHKEJrfbk3UfCPr6d', NULL, '2024-12-30 22:54:48');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT '0',
  `click_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `applied_coupons`
--

CREATE TABLE `applied_coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `coupon_id` int UNSIGNED NOT NULL DEFAULT '0',
  `order_id` int UNSIGNED NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attributes`
--

CREATE TABLE `attributes` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = text, 2 = color, 3= image',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attribute_product`
--

CREATE TABLE `attribute_product` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL,
  `attribute_id` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attribute_values`
--

CREATE TABLE `attribute_values` (
  `id` bigint UNSIGNED NOT NULL,
  `attribute_id` int UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `attribute_value_product`
--

CREATE TABLE `attribute_value_product` (
  `product_id` int UNSIGNED NOT NULL,
  `attribute_value_id` int UNSIGNED NOT NULL DEFAULT '0',
  `media_id` int UNSIGNED DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `session_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int UNSIGNED NOT NULL DEFAULT '0',
  `product_variant_id` int UNSIGNED DEFAULT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `parent_id` bigint UNSIGNED DEFAULT NULL,
  `position` int UNSIGNED DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `feature_in_banner` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category_coupon`
--

CREATE TABLE `category_coupon` (
  `id` bigint UNSIGNED NOT NULL,
  `coupon_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `category_product`
--

CREATE TABLE `category_product` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `category_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `coupon_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `coupon_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=fixed, 2=percent',
  `coupon_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `minimum_spend` decimal(28,8) DEFAULT NULL,
  `maximum_spend` decimal(28,8) DEFAULT NULL,
  `usage_limit_per_coupon` int DEFAULT NULL,
  `usage_limit_per_user` int DEFAULT NULL,
  `exclude_sale_items` tinyint NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `expired_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_product`
--

CREATE TABLE `coupon_product` (
  `id` bigint UNSIGNED NOT NULL,
  `coupon_id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `order_id` int UNSIGNED NOT NULL DEFAULT '0',
  `method_code` int UNSIGNED NOT NULL DEFAULT '0',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `method_currency` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `final_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `detail` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `btc_amount` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_wallet` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payment_try` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT '0',
  `is_web` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'This will be 1 if the request is from NextJs application',
  `admin_feedback` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `success_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_cron` int DEFAULT '0',
  `success_route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `success_route_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `failed_route` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `failed_route_params` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `device_tokens`
--

CREATE TABLE `device_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `is_app` tinyint(1) NOT NULL DEFAULT '0',
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `digital_files`
--

CREATE TABLE `digital_files` (
  `id` bigint UNSIGNED NOT NULL,
  `fileable_id` int UNSIGNED NOT NULL,
  `fileable_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `extensions`
--

CREATE TABLE `extensions` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `shortcode` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'object',
  `support` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'help section',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=>enable, 2=>disable',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `extensions`
--

INSERT INTO `extensions` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `created_at`, `updated_at`) VALUES
(1, 'tawk-chat', 'Tawk.to', 'Key location is shown bellow', 'tawky_big.png', '<script>\r\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n                        (function(){\r\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\n                        s1.async=true;\r\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\r\n                        s1.charset=\"UTF-8\";\r\n                        s1.setAttribute(\"crossorigin\",\"*\");\r\n                        s0.parentNode.insertBefore(s1,s0);\r\n                        })();\r\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}', 'twak.png', 0, '2019-10-18 23:16:05', '2023-05-17 03:45:00'),
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'Key location is shown bellow', 'recaptcha3.png', '\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\n<div class=\"g-recaptcha\" data-sitekey=\"{{site_key}}\" data-callback=\"verifyCaptcha\"></div>\n<div id=\"g-recaptcha-error\"></div>', '{\"site_key\":{\"title\":\"Site Key\",\"value\":\"6LdPC88fAAAAADQlUf_DV6Hrvgm-pZuLJFSLDOWV\"},\"secret_key\":{\"title\":\"Secret Key\",\"value\":\"6LdPC88fAAAAAG5SVaRYDnV2NpCrptLg2XLYKRKB\"}}', 'recaptcha.png', 0, '2019-10-18 23:16:05', '2025-04-21 13:44:46'),
(3, 'custom-captcha', 'Custom Captcha', 'Just put any random string', 'customcaptcha.png', NULL, '{\"random_key\":{\"title\":\"Random String\",\"value\":\"SecureString\"}}', 'na', 0, '2019-10-18 23:16:05', '2024-11-12 08:08:04'),
(4, 'google-analytics', 'Google Analytics', 'Key location is shown bellow', 'google_analytics.png', '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{measurement_id}}\"></script>\n                <script>\n                  window.dataLayer = window.dataLayer || [];\n                  function gtag(){dataLayer.push(arguments);}\n                  gtag(\"js\", new Date());\n                \n                  gtag(\"config\", \"{{measurement_id}}\");\n                </script>', '{\"measurement_id\":{\"title\":\"Measurement ID\",\"value\":\"------\"}}', 'ganalytics.png', 0, NULL, '2023-05-17 03:44:52');

-- --------------------------------------------------------

--
-- Table structure for table `forms`
--

CREATE TABLE `forms` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `form_data` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `frontends`
--

CREATE TABLE `frontends` (
  `id` bigint UNSIGNED NOT NULL,
  `tempname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_keys` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `data_values` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `seo_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `frontends`
--

INSERT INTO `frontends` (`id`, `tempname`, `slug`, `data_keys`, `data_values`, `seo_content`, `created_at`, `updated_at`) VALUES
(1, NULL, '', 'seo.data', '{\"seo_image\":\"1\",\"keywords\":[\"ViserMart\",\"online shopping platform\",\"e-commerce solution\",\"shopping cart system\",\"customizable e-commerce platform\",\"secure payment gateway\",\"e-commerce script\",\"Envato marketplace\",\"Laravel e-commerce\",\"modern online store\"],\"description\":\"Build your dream e-commerce store with ViserMart, a feature-packed platform offering, secure payments, and customizable designs to scale your business effortlessly.\",\"social_title\":\"ViserMart - Ultimate Online Shopping Platform for Seamless E-Commerce Solutions\",\"social_description\":\"Discover ViserMart, the all-in-one online shopping platform for creating modern e-commerce websites. Packed with powerful features, secure payment gateways, and customizable themes to elevate your online store.\",\"image\":\"6800abc16dabe1744874433.png\"}', NULL, '2020-07-04 23:42:52', '2025-04-17 07:20:35'),
(2, NULL, '', 'header_three.content', '{\"status\":\"on\",\"background_color\":null,\"group\":{\"category_widget\":{\"name\":\"Categories\",\"status\":\"on\",\"background_color\":null},\"links\":{\"1\":{\"name\":\"Home\",\"url\":\"\\/\"},\"5\":{\"name\":\"Products\",\"url\":\"products\"},\"2\":{\"name\":\"About Us\",\"url\":\"about-us\"},\"7\":{\"name\":\"All Categories\",\"url\":\"categories\"},\"8\":{\"name\":\"Contact\",\"url\":\"contact\"}},\"widgets\":[{\"name\":\"Compare Widget\",\"key\":\"compare\",\"background_color\":null},{\"name\":\"Wishlist Widget\",\"key\":\"wishlist\",\"background_color\":null},{\"name\":\"Notifications Widget\",\"key\":\"notifications\",\"background_color\":null},{\"name\":\"User Auth Widget\",\"key\":\"user_auth\",\"background_color\":null},{\"name\":\"Language Widget\",\"key\":\"language\",\"background_color\":null},{\"name\":\"Cart Widget\",\"key\":\"cart\",\"status\":\"on\",\"background_color\":null}]}}', NULL, '2020-07-04 23:42:52', '2024-12-26 05:11:21'),
(3, 'basic', '', 'header_two.content', '{\"status\":\"on\",\"group\":{\"logo_widget\":{\"name\":\"logo\",\"status\":\"on\"},\"search_widget\":{\"name\":\"logo\",\"status\":\"on\"},\"widgets\":[{\"name\":\"Language Widget\",\"key\":\"language\"},{\"name\":\"User Auth Widget\",\"key\":\"user_auth\"},{\"name\":\"Compare Widget\",\"key\":\"compare\",\"status\":\"on\"},{\"name\":\"Wishlist Widget\",\"key\":\"wishlist\",\"status\":\"on\"},{\"name\":\"Cart Widget\",\"key\":\"cart\"},{\"name\":\"Notifications Widget\",\"key\":\"notifications\",\"status\":\"on\"}]}}', NULL, '2020-11-12 04:07:30', '2024-12-04 00:20:08'),
(4, NULL, NULL, 'cookie.data', '{\"short_desc\":\"We may use cookies or any other tracking technologies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the Site and improve your experience.\",\"description\":\"<h5 class=\\\"mb-2\\\">What information do we collect?<\\/h5>\\r\\n<p class=\\\"mb-5\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/p>\\r\\n\\r\\n<h5 class=\\\"mb-2\\\">How do we protect your information?<\\/h5>\\r\\n<p class=\\\"mb-5\\\">All provided delicate\\/credit data is sent through Stripe.\\r\\nAfter an exchange, your private data (credit cards, social security numbers, financials, and so on) won\'t be put away on\\r\\nour workers.\\r\\n<\\/p>\\r\\n\\r\\n<h5 class=\\\"mb-2\\\">Do we disclose any information to outside parties?<\\/h5>\\r\\n<p class=\\\"mb-5\\\">\\r\\n\\tWe don\'t sell, exchange, or in any case move to outside gatherings by and by recognizable data. This does exclude\\r\\n\\tconfided in outsiders who help us in working our site, leading our business, or adjusting you, since those gatherings\\r\\n\\tconsent to keep this data private. We may likewise deliver your data when we accept discharge is suitable to follow the\\r\\n\\tlaw, implement our site strategies, or ensure our own or others\' rights, property, or wellbeing.\\r\\n<\\/p>\\r\\n\\r\\n<h5 class=\\\"mb-2\\\">\\r\\n\\tChildren\'s Online Privacy Protection Act Compliance\\r\\n<\\/h5>\\r\\n\\r\\n<p class=\\\"mb-5\\\">We are consistent with the prerequisites of COPPA (Children\'s Online Privacy Protection Act), we don\'t gather any data from anybody under 13 years old. Our site, items, and administrations are completely coordinated to individuals who are in any event 13 years of age or more established.<\\/p>\\r\\n\\r\\n<h5 class=\\\"mb-2\\\">Changes to our Privacy Policy<\\/h5>\\r\\n<p class=\\\"mb-5\\\">If we decide to change our privacy policy, we will post those changes on this page.<\\/p>\\r\\n\\r\\n<h5 class=\\\"mb-2\\\">How long we retain your information?<\\/h5>\\r\\n\\r\\n<p class=\\\"mb-5\\\">\\r\\n\\tAt the point when you register for our site, we cycle and keep your information we have about you however long you don\'t erase the record or withdraw yourself (subject to laws and guidelines).\\r\\n<\\/p>\\r\\n\\r\\n<h5 class=\\\"mb-2\\\">What we don\\u2019t do with your data<\\/h5>\\r\\n<p>\\r\\n\\tWe don\'t and will never share, unveil, sell, or in any case give your information to different organizations for the\\r\\n\\tpromoting of their items or administrations.\\r\\n<\\/p>\",\"status\":1}', NULL, '2020-07-04 23:42:52', '2024-12-04 06:52:50'),
(5, 'basic', 'privacy-policy', 'policy_pages.element', '{\"title\":\"Privacy Policy\",\"details\":\"<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">What information do we collect?<\\/h5>\\n\\t<p>\\n\\t\\tWe gather data from you when you register on our site, submit a request, buy any services, react to an overview, or\\n\\t\\tround out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be\\n\\t\\tapproached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.\\n\\t<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">How do we protect your information?<\\/h5>\\n\\t<p>\\n\\t\\tAll provided delicate\\/credit data is sent through Stripe.\\n\\t\\tAfter an exchange, your private data (credit cards, social security numbers, financials, and so on) won\'t be put away on\\n\\t\\tour workers.\\n\\t<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Do we disclose any information to outside parties?<\\/h5>\\n\\t<p>We don\'t sell, exchange, or in any case move to outside gatherings by and by recognizable data. This does exclude\\n\\tconfided in outsiders who help us in working our site, leading our business, or adjusting you, since those gatherings\\n\\tconsent to keep this data private. We may likewise deliver your data when we accept discharge is suitable to follow the\\n\\tlaw, implement our site strategies, or ensure our own or others\' rights, property, or wellbeing.<\\/p>\\n<\\/div>\\n\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Children\'s Online Privacy Protection Act Compliance<\\/h5>\\n\\t<p>We are consistent with the prerequisites of COPPA (Children\'s Online Privacy Protection Act), we don\'t gather any data\\n\\tfrom anybody under 13 years old. Our site, items, and administrations are completely coordinated to individuals who are\\n\\tin any event 13 years of age or more established.<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Changes to our Privacy Policy<\\/h5>\\n\\t<p>If we decide to change our privacy policy, we will post those changes on this page.<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">How long we retain your information?<\\/h5>\\n\\t<p>At the point when you register for our site, we cycle and keep your information we have about you however long you don\'t\\n\\terase the record or withdraw yourself (subject to laws and guidelines).<\\/p>\\n<\\/div>\\n\\n<div>\\n\\t<h5 class=\\\"mb-2\\\">What we don\\u2019t do with your data<\\/h5>\\n\\t<p>\\n\\t\\tWe don\'t and will never share, unveil, sell, or in any case give your information to different organizations for the\\n\\t\\tpromoting of their items or administrations.\\n\\t<\\/p>\\n<\\/div>\"}', NULL, '2021-06-09 08:50:42', '2024-12-04 06:51:12'),
(6, 'basic', 'terms-and-conditions', 'policy_pages.element', '{\"title\":\"Terms and Conditions\",\"details\":\"<div class=\\\"mb-5\\\">\\n\\t<h4 class=\\\"mb-2\\\">Terms and Conditions<\\/h4>\\n\\t<p>\\n\\t\\tWelcome to ViserMart! Please read these Terms and Conditions carefully before using our platform. By accessing\\n\\t\\tor\\n\\t\\tusing our services, you agree to be bound by these terms. If you do not agree, you may not access or use our\\n\\t\\tplatform.\\n\\t<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">General Terms<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Eligibility<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>You must be at least [minimum age, e.g., 13] years old to use this platform.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Account Responsibility<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>You are responsible for maintaining the confidentiality of your account and password and for all\\n\\t\\t\\t\\t\\tactivities under your account.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Modification of Terms<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>We reserve the right to update these Terms and Conditions at any time. Changes will be posted on\\n\\t\\t\\t\\t\\tthis page, and your continued use of the platform constitutes acceptance of those changes.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Use of the Platform<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Prohibited Activities<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>You agree not to use the platform for any unlawful purpose.<\\/li>\\n\\t\\t\\t\\t<li>Interfere with or disrupt the functionality of the platform.<\\/li>\\n\\t\\t\\t\\t<li>Upload malicious software or viruses.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>License<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>We grant you a limited, non-exclusive, and non-transferable license to use the platform solely for\\n\\t\\t\\t\\t\\tits intended purpose.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Orders and Payments<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Order Acceptance<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>We reserve the right to accept or reject any order placed on the platform.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Pricing and Payments<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>All prices displayed are inclusive\\/exclusive of applicable taxes.<\\/li>\\n\\t\\t\\t\\t<li>Payment must be completed through the methods provided at checkout.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Cancellations and Refunds<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>Cancellation requests must comply with our cancellation policy.<\\/li>\\n\\t\\t\\t\\t<li>Refunds will be processed as per the refund policy provided on our platform.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Promotions and Offers<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Coupons<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>Coupons are discount codes that customers can apply during checkout to receive discounts on their\\n\\t\\t\\t\\t\\tpurchases.<\\/li>\\n\\t\\t\\t\\t<li>Coupons are subject to their respective terms and conditions and cannot be combined unless\\n\\t\\t\\t\\t\\texplicitly stated.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\t<strong>Offers<\\/strong>\\n\\t\\t\\t<ul>\\n\\t\\t\\t\\t<li>Offers are special promotions that provide discounts automatically without requiring customers to\\n\\t\\t\\t\\t\\tinput a code.<\\/li>\\n\\t\\t\\t\\t<li>Offers are applied to specified products and are visible on the product page and cart.<\\/li>\\n\\t\\t\\t<\\/ul>\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Limitation of Liability<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\tWe are not liable for any indirect, incidental, or consequential damages arising from the use of the\\n\\t\\t\\tplatform.\\n\\t\\t<\\/li>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\tOur total liability is limited to the amount you paid for our services in the past [e.g., 12 months].\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Termination<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\tWe reserve the right to terminate or suspend your account if you violate these terms or engage in prohibited\\n\\t\\t\\tactivities.\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Privacy<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\tYour privacy is important to us. Please refer to our <a href=\\\"policy\\/privacy-policy\\\">Privacy Policy<\\/a> for\\n\\t\\t\\tdetailed information on how we handle your data.\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div>\\n\\t<h5 class=\\\"mb-2\\\">Governing Law<\\/h5>\\n\\t<ul>\\n\\t\\t<li style=\\\"list-style:disc;margin-left:2rem;\\\">\\n\\t\\t\\tThese Terms and Conditions are governed by and construed in accordance with the laws of US.\\n\\t\\t<\\/li>\\n\\t<\\/ul>\\n<\\/div>\"}', NULL, '2021-06-09 08:51:18', '2024-12-04 06:51:48'),
(7, NULL, NULL, 'maintenance.data', '{\"description\":\"<h2 class=\\\"text-center mb-3\\\">THE SITE IS UNDER MAINTENANCE<\\/h2>\\r\\n<h5 class=\\\"text-center\\\">We\'re just tuning up a few things.<\\/h5>\\r\\n<p class=\\\"text-center\\\">We apologize for the inconvenience but Front is currently undergoing planned maintenance. Thanks for your patience.<\\/p>\",\"image\":\"66f7cd8e217fb1727516046.png\"}', NULL, '2020-07-04 23:42:52', '2024-11-17 00:46:51'),
(8, 'basic', NULL, 'contact_page.content', '{\"address_heading\":\"We\'d Love to Hear From You\",\"form_heading\":\"Leave Us a Message\",\"description\":\"We appreciate feedback and interaction of any sort so please feel free to get in touch.\"}', NULL, '2022-11-22 10:40:36', '2024-03-21 11:28:01'),
(9, 'basic', '', 'faq_page.content', '{\"page_title\":\"Frequently Asked Questions\",\"description\":\"<b>1. How can I place an order?\\u00a0<\\/b><div>Browse our products, select the item you want, choose the quantity, and click \\\"Add to Cart.\\\" Once you\\u2019re ready to purchase, proceed to checkout, enter your shipping and payment information, and confirm your order.\\u00a0<\\/div><div><br \\/><\\/div><div><b>\\u00a02. What payment methods do you accept?\\u00a0<\\/b><\\/div><div>We accept all major credit and debit cards, PayPal, Stripe, 2checkout, and more.\\u00a0<\\/div><div><br \\/><\\/div><div><b>\\u00a03. How can I track my order?\\u00a0<\\/b><\\/div><div>You can track your order from our track you order page by order number.\\u00a0<\\/div><div><br \\/><\\/div><div><b>\\u00a04. What is your return policy?\\u00a0<\\/b><\\/div><div>We offer a 30-day return policy for most items. If you\'re not satisfied with your purchase, you can return it for a full refund or exchange, as long as the item is in its original condition. Certain items, such as perishable goods or custom products, may not be eligible for return.\\u00a0<\\/div><div><br \\/><\\/div><div><b>5. How long will it take to receive my order?\\u00a0<\\/b><\\/div><div>Standard shipping usually takes 5-7 business days, but we offer expedited shipping options at checkout if you need your order sooner. Delivery times may vary depending on your location and the selected shipping method.\\u00a0<\\/div><div><br \\/><\\/div><div><b>6. Can I change or cancel my order after placing it?\\u00a0<\\/b><\\/div><div>You can cancel or make changes to your order within a limited time frame after it\\u2019s placed. Please contact our customer service team as soon as possible if you need to make changes.\\u00a0<\\/div><div><br \\/><\\/div><div><b>7. Do you ship internationally?<\\/b><\\/div><div>Yes, we offer international shipping to select countries. Shipping fees and delivery times vary based on the destination. Please check our Shipping Policy page for more details.\\u00a0<\\/div><div><br \\/><\\/div><div><b>8. How do I apply a discount code to my order?\\u00a0<\\/b><\\/div><div>You can enter your discount code at checkout in the \\\"Promo Code\\\" field. Once applied, the discount will be reflected in your order total.\\u00a0<\\/div><div><br \\/><\\/div><div><b>9. Is my payment information secure?<\\/b><\\/div><div>Yes, we use secure encryption technology to protect your payment information and ensure a safe shopping experience. We do not store credit card details on our servers.\\u00a0<\\/div><div><br \\/><\\/div><div><b>10. What should I do if I receive a damaged or incorrect item?<\\/b><\\/div><div>If you receive a damaged or incorrect item, please get in touch with our customer service within 48 hours of receiving the order. We\\u2019ll arrange for a replacement or a refund as soon as possible.\\u00a0<\\/div><div><br \\/><\\/div><div><b>11. Can I create a wishlist?<\\/b><\\/div><div>Click the product page\'s heart icon to add items to your wishlist.\\u00a0<\\/div><div><br \\/><\\/div><div><b>12. What should I do if I forget my password?<\\/b><\\/div><div>If you forget your password, click \\\"Forgot Password\\\" on the login page. You\\u2019ll receive an email with instructions on how to reset it.\\u00a0<\\/div><div><br \\/><\\/div><div><b>13. How can I contact customer support?\\u00a0<\\/b><\\/div><div>You can reach our customer support team via the contact form on our website or from the support menu for registered users. Our support team is available from.<br \\/><br \\/><b><i>Please note that these are dummy content for Visermart Script and should be customized according to your specific policies and offerings.<\\/i><\\/b><\\/div>\"}', NULL, '2022-11-22 11:22:50', '2024-11-10 06:44:16'),
(10, 'basic', '', 'footer.content', '{\"has_image\":\"1\",\"contact_heading\":\"Contact Us\",\"cell_number\":\"+ (001) 001 001\",\"email\":\"test@site.com\",\"contact_address\":\"Visermart, House 666, Road #5555\",\"footer_note\":\"Visermart brings you tons of products in over 20+ different categories, including men\'s fashion, women\'s fashion, baby fashion, and more.\",\"copyright_text\":\"\\u00a9 {year} {site_name} All Rights Reserved.\",\"logo\":\"67715a0cd06bf1735481868.png\",\"payment_methods\":\"637cd4514c0c21669125201.png\"}', NULL, '2022-11-22 11:23:21', '2024-12-29 08:17:48'),
(11, 'basic', '', 'forgot_password_page.content', '{\"has_image\":\"1\",\"title\":\"Forgot your password?\",\"description\":\"No worries! Just enter the email address or username associated with your account, and we\'ll send you a code to reset your password.\",\"image\":\"66f7ccef688611727515887.png\"}', NULL, '2022-11-22 11:23:38', '2024-11-10 07:10:05'),
(12, 'basic', NULL, 'login_page.content', '{\"has_image\":\"1\",\"title\":\"Welcome Back\",\"description\":\"Hello! Welcome back\",\"image\":\"66f7cd2b8c4621727515947.png\"}', NULL, '2022-11-22 11:23:58', '2024-09-28 03:32:27'),
(13, 'basic', '', 'register_page.content', '{\"has_image\":\"1\",\"title\":\"Join us and unlock exclusive deals and seamless shopping!\",\"description\":\"Welcome to Visermart\",\"image\":\"660256dc91c6c1711429340.png\"}', NULL, '2022-11-22 11:26:15', '2024-10-21 06:54:30'),
(14, 'basic', '', 'reset_password_page.content', '{\"has_image\":\"1\",\"title\":\"Reset Password\",\"description\":\"Your account is verified successfully. Now you can change your password. Please enter a strong password and don\'t share it with anyone.\",\"image\":\"66f7ce1109b5f1727516177.png\"}', NULL, '2022-11-22 11:26:43', '2024-11-10 23:58:53'),
(15, 'basic', NULL, 'subscribe.content', '{\"text\":\"Subscribe to our newsletter to get the latest news, updates, and special offers\"}', NULL, '2022-12-08 04:05:30', '2022-12-08 04:05:30'),
(16, 'basic', '', 'social_icon.element', '{\"title\":\"Twitter\",\"social_icon\":\"<i class=\\\"fa-brands fa-x-twitter\\\"><\\/i>\",\"url\":\"https:\\/\\/www.twitter.com\\/visermart\"}', NULL, '2022-12-08 07:26:02', '2024-11-11 06:15:39'),
(17, 'basic', '', 'social_icon.element', '{\"title\":\"Instagram\",\"social_icon\":\"<i class=\\\"fab fa-instagram\\\"><\\/i>\",\"url\":\"https:\\/\\/www.instagram.com\\/visermart\"}', NULL, '2022-12-08 07:26:19', '2024-11-11 06:15:45'),
(18, 'basic', '', 'social_icon.element', '{\"title\":\"Linked In\",\"social_icon\":\"<i class=\\\"fab fa-linkedin-in\\\"><\\/i>\",\"url\":\"https:\\/\\/www.linkedin.com\\/visermart\"}', NULL, '2022-12-08 07:26:43', '2024-11-11 06:15:52'),
(19, 'basic', '', 'about_us.content', '{\"has_image\":\"1\",\"heading\":\"WHO WE ARE\",\"subheading\":\"Happy Shopping With Visermart\",\"banner_heading\":\"We believe we can all make a stylish.\",\"description\":\"<p class=\\\"sm-text\\\">Visermart is a web-based commercial center with online business stores in\\n    USA. Moving. Valentine\'s Day Sale , Visermart Flash ...You\'ve visited this page ordinarily.\\n    So be content with Visermart<\\/p>\\n<ul class=\\\"list--check align-items-start\\\">\\n    <li class=\\\"sm-text\\\">Various Kinds Of Product<\\/li>\\n    <li class=\\\"sm-text\\\">Large customer reach.<\\/li>\\n    <li class=\\\"sm-text\\\">Universal standard.<\\/li>\\n    <li class=\\\"sm-text\\\">Easy to use the checkout<\\/li>\\n<\\/ul>\",\"banner_image\":\"6723853527b291730381109.png\",\"image\":\"672607bcbd2991730545596.png\"}', NULL, '2023-05-21 08:00:35', '2024-11-02 18:06:36'),
(20, 'basic', NULL, 'contact_page.element', '{\"title\":\"Office Address\",\"value\":\"4517 Washington Ave. Manchester, Kentucky 39495 Main town USA.\",\"icon\":\"<i class=\\\"las la-map-marker\\\"><\\/i>\"}', NULL, '2024-02-14 09:00:02', '2024-02-14 09:00:02'),
(21, 'basic', '', 'contact_page.element', '{\"title\":\"Mobile\",\"value\":\"0182646854 +9574651651\",\"icon\":\"<i class=\\\"las la-mobile-alt\\\"><\\/i>\"}', NULL, '2024-02-14 09:06:29', '2024-11-13 06:05:27'),
(22, 'basic', NULL, 'contact_page.element', '{\"title\":\"Email\",\"value\":\"support@visermart.com\",\"icon\":\"<i class=\\\"las la-envelope\\\"><\\/i>\"}', NULL, '2024-02-14 09:07:31', '2024-02-14 09:07:32'),
(23, 'basic', '', 'newsletter.content', '{\"heading\":\"SIGN UP FOR OUR NEWSLETTER\",\"description\":\"Receive our latest updates about our products and promotions.\"}', NULL, '2024-02-14 13:31:18', '2024-11-13 06:04:41'),
(24, 'basic', '', 'counter.element', '{\"has_image\":\"1\",\"title\":\"AWARD WINS\",\"counter_value\":\"10\",\"image\":\"6723b5ce44f031730393550.png\"}', NULL, '2024-03-25 08:44:38', '2024-10-31 23:52:30'),
(25, 'basic', '', 'counter.element', '{\"has_image\":\"1\",\"title\":\"YEARS OF EXPERIENCES\",\"counter_value\":\"15\",\"image\":\"6723b5c7866d01730393543.png\"}', NULL, '2024-03-25 08:44:26', '2024-10-31 23:52:23'),
(26, 'basic', '', 'counter.element', '{\"has_image\":\"1\",\"title\":\"TOTAL PRODUCTS\",\"counter_value\":\"450\",\"image\":\"6723b5c0e27e71730393536.png\"}', NULL, '2024-03-25 08:44:10', '2024-10-31 23:52:16'),
(27, 'basic', '', 'counter.element', '{\"has_image\":\"1\",\"title\":\"TOTAL VISITORS\",\"counter_value\":\"8000\",\"image\":\"6723b5b59e7641730393525.png\"}', NULL, '2024-03-25 08:43:54', '2024-10-31 23:52:05'),
(28, 'basic', '', 'quote.content', '{\"has_image\":\"1\",\"quote\":\"Visermart Is popular shopping platform for you dolor sit asectetur adipiscing elit, sed do eiusmod tempor incididunt ut laboreolore magna aliquaenenatis tellus in. metus vulputate eu scelerisque felis. Vel pretium lectus qua . Arpis massa. jnghd sping world class provicer and finicing world\",\"name\":\"Esther Howard\",\"designation\":\"CEO, Visermart\",\"image\":\"6723b205530861730392581.png\"}', NULL, '2024-03-25 09:02:50', '2024-10-31 23:36:21'),
(29, 'basic', '', 'feature.content', '{\"has_image\":\"1\",\"heading\":\"FEATURES\",\"subheading\":\"Your Easy Shopping\",\"description\":\"Make your life easy buy getting our exclusive products\",\"image\":\"6723b902c14761730394370.png\"}', NULL, '2024-03-25 09:16:15', '2024-11-01 00:06:10'),
(30, 'basic', '', 'feature.element', '{\"title\":\"Fast Delivery\",\"description\":\"Swift shipping ensures your orders arrive on time, every time.\",\"icon\":\"<i class=\\\"fas fa-truck\\\"><\\/i>\"}', NULL, '2024-03-25 09:17:37', '2025-02-25 01:19:39'),
(31, 'basic', '', 'feature.element', '{\"title\":\"Return Products\",\"description\":\"Hassle-free returns with a simple and quick refund process.\",\"icon\":\"<i class=\\\"fab fa-product-hunt\\\"><\\/i>\"}', NULL, '2024-03-25 09:18:19', '2025-02-25 01:19:21'),
(32, 'basic', '', 'feature.element', '{\"title\":\"Help Center\",\"description\":\"24\\/7 support to assist with orders, payments, and inquiries.\",\"icon\":\"<i class=\\\"fas fa-hands-helping\\\"><\\/i>\"}', NULL, '2024-03-25 09:18:46', '2025-02-25 01:19:10'),
(33, 'basic', '', 'feature.element', '{\"title\":\"Safe Payment\",\"description\":\"Secure transactions with trusted payment methods for worry-free shopping.\",\"icon\":\"<i class=\\\"fas fa-shopping-cart\\\"><\\/i>\"}', NULL, '2024-03-25 09:19:18', '2025-02-25 01:18:56'),
(34, 'basic', NULL, 'top_selling_products.content', '{\"title\":\"Top Selling Products\"}', NULL, '2024-09-19 02:31:23', '2024-09-19 02:31:23'),
(35, 'basic', '', 'services.element', '{\"has_image\":\"1\",\"title\":\"Secure Payment\",\"subtitle\":\"All Cards Accepted\",\"image\":\"6739fca46ea611731853476.png\"}', NULL, '2024-09-19 02:45:17', '2024-11-17 08:24:36'),
(36, 'basic', '', 'services.element', '{\"has_image\":\"1\",\"title\":\"Free Shipping\",\"subtitle\":\"On All Order\",\"image\":\"6739fcbe2422c1731853502.png\"}', NULL, '2024-09-19 02:45:36', '2024-11-17 08:25:02'),
(37, 'basic', '', 'services.element', '{\"has_image\":\"1\",\"title\":\"Online Support\",\"subtitle\":\"Technical 24\\/7\",\"image\":\"6739f654a40241731851860.png\"}', NULL, '2024-09-19 02:45:52', '2024-11-17 07:57:40'),
(38, 'basic', '', 'services.element', '{\"has_image\":\"1\",\"title\":\"Big Savings\",\"subtitle\":\"Weekend Sales\",\"image\":\"6739f65c524471731851868.png\"}', NULL, '2024-09-19 02:46:28', '2024-11-17 07:57:48'),
(39, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67178e93dc25b1729597075.png\"}', NULL, '2024-10-22 02:42:56', '2024-10-22 05:37:56'),
(40, 'basic', '', 'featured_brands.content', '{\"title\":\"Top Brands\"}', NULL, '2024-10-22 03:28:20', '2024-11-10 01:02:55'),
(41, 'basic', '', 'banner.content', '{\"has_image\":\"1\",\"fixed_banner_link\":\"#\",\"fixed_banner\":\"673099d36f6e71731238355.png\"}', NULL, '2024-10-22 03:40:13', '2024-11-10 05:32:35'),
(42, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67178fb2b43d91729597362.png\"}', NULL, '2024-10-22 04:10:18', '2024-10-22 05:42:42'),
(43, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67179c9cb10841729600668.png\"}', NULL, '2024-10-22 04:10:32', '2024-10-22 06:37:48'),
(44, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67179af0746a01729600240.png\"}', NULL, '2024-10-22 04:10:42', '2024-10-22 06:30:40'),
(45, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67189f3d37d841729666877.png\"}', NULL, '2024-10-23 01:01:17', '2024-10-23 01:01:18'),
(46, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67189f48992c11729666888.png\"}', NULL, '2024-10-23 01:01:28', '2024-10-23 01:01:28'),
(47, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"67189fe766ad21729667047.png\"}', NULL, '2024-10-23 01:04:07', '2024-10-23 01:04:07'),
(48, 'basic', '', 'banner.element', '{\"has_image\":\"1\",\"link\":\"#\",\"slider\":\"6718b8ecbd6a11729673452.png\"}', NULL, '2024-10-23 02:48:18', '2024-10-23 02:50:52'),
(49, NULL, NULL, 'footer_menu.content', '[{\"title\":\"Terms & Policies\",\"links\":[{\"name\":\"Cookie Policy\",\"url\":\"cookie-policy\"},{\"name\":\"Return Policy\",\"url\":\"policy\\/return-policy\"},{\"name\":\"Privacy Policy\",\"url\":\"policy\\/privacy-policy\"},{\"name\":\"Terms and Conditions\",\"url\":\"policy\\/terms-and-conditions\"}]},{\"title\":\"Site Links\",\"links\":[{\"name\":\"Home\",\"url\":\"\\/\"},{\"name\":\"Contact\",\"url\":\"contact\"},{\"name\":\"Offers\",\"url\":\"offers\"},{\"name\":\"About Us\",\"url\":\"about-us\"}]},{\"title\":\"Useful Links\",\"links\":[{\"name\":\"Sign Up\",\"url\":\"user\\/register\"},{\"name\":\"Login\",\"url\":\"user\\/login\"},{\"name\":\"Track Order\",\"url\":\"track-order\"},{\"name\":\"FAQ\",\"url\":\"faq\"}]},{\"title\":\"Other Links\",\"links\":[{\"name\":\"Products\",\"url\":\"products\"},{\"name\":\"All Categories\",\"url\":\"categories\"},{\"name\":\"All Brands\",\"url\":\"brands\"},{\"name\":\"Wishlist\",\"url\":\"wishlist\"}]},{\"title\":\"Top Categories\",\"links\":[{\"name\":\"Women\'s Fashion\",\"url\":\"products\\/womens-fashion\"},{\"name\":\"Men\'s Fashion\",\"url\":\"products\\/mens-fashion\"},{\"name\":\"Ethnic Wear\",\"url\":\"products\\/ethnic-wear\"},{\"name\":\"Shoes\",\"url\":\"products\\/shoes\"}]},{\"title\":\"Trending\",\"links\":[{\"name\":\"Automobile Accessories\",\"url\":\"products\\/automobile-accessories\"},{\"name\":\"Haircare\",\"url\":\"products\\/haircare\"},{\"name\":\"Fragrances\",\"url\":\"products\\/fragrances\"},{\"name\":\"Shirts\",\"url\":\"products\\/shirts\"}]}]', NULL, '2020-07-04 23:42:52', '2024-12-04 07:15:41'),
(50, 'basic', '', 'profile_complete_page.content', '{\"title\":\"Complete Your Profile\",\"description\":\"Welcome! You\'re almost ready to enjoy a fully personalized shopping experience. Completing your profile helps us serve you better by tailoring recommendations, streamlining checkout, and ensuring faster support.\"}', NULL, '2024-11-10 07:29:28', '2024-11-10 07:31:33'),
(51, 'basic', '', 'auth_pages_bg.content', '{\"has_image\":\"1\",\"image\":\"676295a0936801734514080.png\"}', NULL, '2024-11-10 08:10:18', '2024-12-18 03:28:00'),
(52, 'basic', '', 'order_confirmation.content', '{\"title\":\"CONGRATULATIONS!\",\"description\":\"Your order has been placed successfully\"}', NULL, '2024-11-11 07:19:00', '2024-11-11 07:20:33'),
(53, NULL, '', 'header_one.content', '{\"status\":\"on\",\"language_option\":\"on\",\"user_option\":\"on\",\"links_position\":\"left\",\"links\":{\"2\":{\"name\":\"Cookie Policy\",\"url\":\"cookie-policy\"},\"1\":{\"name\":\"Track Order\",\"url\":\"track-order\"}}}', NULL, '2024-11-11 07:48:44', '2024-12-04 00:19:43'),
(54, 'basic', '', 'featured_categories.content', '{\"title\":\"Categories\"}', NULL, '2024-11-18 05:13:32', '2024-11-18 05:13:32'),
(55, 'basic', 'return-policy', 'policy_pages.element', '{\"title\":\"Return Policy\",\"details\":\"<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Return Window<\\/h5>\\n\\t<p>\\n\\t\\tClearly specify the timeframe within which customers can initiate a return. Common periods include 30, 60, or 90 days\\n\\t\\tfrom the date of purchase or delivery.\\n\\t\\tConsider offering extended return windows for specific holidays or promotional periods.\\n\\t<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Eligibility Criteria<\\/h5>\\n\\t<p>\\n\\t\\tDefine the conditions under which items are eligible for return. These may include:\\n\\t<\\/p>\\n\\n\\t<ul>\\n\\t\\t<li>Unopened, unused, and undamaged products<\\/li>\\n\\t\\t<li>Items with original packaging and tags<\\/li>\\n\\t\\t<li>Products purchased directly from your online store (not third-party sellers)<\\/li>\\n\\t<\\/ul>\\n\\t<p>Exclusions for certain product categories like personalized items, perishable goods, or intimate apparel.<\\/p>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Return Process<\\/h5>\\n\\t<p>Provide clear instructions on how to initiate a return, such as:<\\/p>\\n\\t<ul>\\n\\t\\t<li>Contacting customer support<\\/li>\\n\\t\\t<li>Printing a prepaid shipping label<\\/li>\\n\\t\\t<li>Packing the item securely<\\/li>\\n\\t\\t<li>Including a return form or order number<\\/li>\\n\\t\\t<li>Specify the return address and any required documentation.<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Refund or Exchange Options:<\\/h5>\\n\\t<p>Clearly outline the available options:<\\/p>\\n\\t<ul>\\n\\t\\t<li>Full refund: A complete refund to the original payment method.<\\/li>\\n\\t\\t<li>Store credit: A credit to be used for future purchases.<\\/li>\\n\\t\\t<li>Exchange: Replacing the returned item with a new one.<\\/li>\\n\\t\\t<li>Specify any processing time for refunds or exchanges.<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Shipping Costs:<\\/h5>\\n\\t<p>Determine who is responsible for return shipping costs:<\\/p>\\n\\n\\t<ul>\\n\\t\\t<li>Customer-paid: The customer covers the cost of shipping the item back to the retailer.<\\/li>\\n\\t\\t<li>Seller-paid: The retailer provides a prepaid shipping label or reimburses the customer for shipping costs.<\\/li>\\n\\t\\t<li>Shared costs: A combination of both, where the customer pays a portion of the shipping cost.<\\/li>\\n\\t<\\/ul>\\n<\\/div>\\n\\n<div class=\\\"mb-5\\\">\\n\\t<h5 class=\\\"mb-2\\\">Damaged or Defective Items:<\\/h5>\\n\\t<p>Explain the process for returning damaged or defective items.\\n\\tProvide a clear return address and any necessary documentation.\\n\\tOffer a hassle-free return and replacement or refund.<\\/p>\\n<\\/div>\\n\\n<div>\\n\\t<h5 class=\\\"mb-2\\\">Contact Information:<\\/h5>\\n\\t<p>\\n\\t\\tProvide easy-to-find contact information for customer support, such as email address, phone number, or live chat.\\n\\t<\\/p>\\n<\\/div>\"}', NULL, '2024-11-25 02:31:40', '2024-12-04 06:52:26'),
(56, 'basic', '', 'headers.order.content', '[\"header_one\",\"header_two\",\"header_three\"]', NULL, NULL, '2024-12-04 00:19:05'),
(57, 'basic', '', 'guest_checkout.content', '{\"description_in_checkout_form\":\"Complete your information for a smooth checkout\",\"shipping_info_recipient_info_title\":\"Recipient\'s Info\",\"shipping_info_recipient_info_description\":\"Please provide the recipient\\u2019s details to ensure smooth delivery. Make sure the information is accurate, as it will be used for shipping and contact purposes.\",\"description_in_shipping_info_title\":\"Shipping Address\",\"description_in_shipping_info_description\":\"Enter the shipping address where you want your order to be delivered. Double-check the details to avoid any delivery issues.\"}', NULL, '2025-02-26 05:00:25', '2025-04-12 10:55:09'),
(58, 'basic', '', 'recent_viewed.content', '{\"title\":\"Recently Viewed Products\"}', NULL, '2025-02-27 04:01:43', '2025-04-08 12:21:49');

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint UNSIGNED NOT NULL,
  `form_id` int UNSIGNED NOT NULL DEFAULT '0',
  `code` int DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `alias` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NULL',
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1=>enable, 2=>disable',
  `gateway_parameters` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `supported_currencies` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `crypto` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: fiat currency, 1: crypto currency',
  `extra` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `form_id`, `code`, `name`, `alias`, `image`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `created_at`, `updated_at`) VALUES
(1, 0, 101, 'Paypal', 'Paypal', '663a38d7b455d1715091671.png', 1, '{\"paypal_email\":{\"title\":\"PayPal Email\",\"global\":true,\"value\":\"sb-owud61543012@business.example.com\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:21:11'),
(2, 0, 102, 'Perfect Money', 'PerfectMoney', '663a3920e30a31715091744.png', 1, '{\"passphrase\":{\"title\":\"ALTERNATE PASSPHRASE\",\"global\":true,\"value\":\"hR26aw02Q1eEeUPSIfuwNypXX\"},\"wallet_id\":{\"title\":\"PM Wallet\",\"global\":false,\"value\":\"\"}}', '{\"USD\":\"$\",\"EUR\":\"\\u20ac\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:22:24'),
(3, 0, 103, 'Stripe Hosted', 'Stripe', '663a39861cb9d1715091846.png', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_XXXXXXXXXXXXXXXXXXXX\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_XXXXXXXXXXXXXXXXXXXX\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:24:06'),
(4, 0, 104, 'Skrill', 'Skrill', '663a39494c4a91715091785.png', 1, '{\"pay_to_email\":{\"title\":\"Skrill Email\",\"global\":true,\"value\":\"merchant@skrill.com\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"---\"}}', '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JOD\":\"JOD\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"KWD\":\"KWD\",\"MAD\":\"MAD\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"OMR\":\"OMR\",\"PLN\":\"PLN\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"SAR\":\"SAR\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TND\":\"TND\",\"TRY\":\"TRY\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\",\"COP\":\"COP\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:23:05'),
(5, 0, 105, 'PayTM', 'Paytm', '663a390f601191715091727.png', 1, '{\"MID\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"DIY12386817555501617\"},\"merchant_key\":{\"title\":\"Merchant Key\",\"global\":true,\"value\":\"bKMfNxPPf_QdZppa\"},\"WEBSITE\":{\"title\":\"Paytm Website\",\"global\":true,\"value\":\"DIYtestingweb\"},\"INDUSTRY_TYPE_ID\":{\"title\":\"Industry Type\",\"global\":true,\"value\":\"Retail\"},\"CHANNEL_ID\":{\"title\":\"CHANNEL ID\",\"global\":true,\"value\":\"WEB\"},\"transaction_url\":{\"title\":\"Transaction URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/oltp-web\\/processTransaction\"},\"transaction_status_url\":{\"title\":\"Transaction STATUS URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/paytmchecksum\\/paytmCallback.jsp\"}}', '{\"AUD\":\"AUD\",\"ARS\":\"ARS\",\"BDT\":\"BDT\",\"BRL\":\"BRL\",\"BGN\":\"BGN\",\"CAD\":\"CAD\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"HRK\":\"HRK\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EGP\":\"EGP\",\"EUR\":\"EUR\",\"GEL\":\"GEL\",\"GHS\":\"GHS\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"KES\":\"KES\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"MAD\":\"MAD\",\"NPR\":\"NPR\",\"NZD\":\"NZD\",\"NGN\":\"NGN\",\"NOK\":\"NOK\",\"PKR\":\"PKR\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"ZAR\":\"ZAR\",\"KRW\":\"KRW\",\"LKR\":\"LKR\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"UGX\":\"UGX\",\"UAH\":\"UAH\",\"AED\":\"AED\",\"GBP\":\"GBP\",\"USD\":\"USD\",\"VND\":\"VND\",\"XOF\":\"XOF\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:22:07'),
(6, 0, 106, 'Payeer', 'Payeer', '663a38c9e2e931715091657.png', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"866989763\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"7575\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"RUB\":\"RUB\"}', 0, '{\"status\":{\"title\": \"Status URL\",\"value\":\"ipn.Payeer\"}}', NULL, '2019-09-14 07:14:22', '2024-05-07 02:20:57'),
(7, 0, 107, 'PayStack', 'Paystack', '663a38fc814e91715091708.png', 1, '{\"public_key\":{\"title\":\"Public key\",\"global\":true,\"value\":\"pk_test_cd330608eb47970889bca397ced55c1dd5ad3783\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"sk_test_8a0b1f199362d7acc9c390bff72c4e81f74e2ac3\"}}', '{\"USD\":\"USD\",\"NGN\":\"NGN\",\"GHS\":\"GHS\",\"KES\":\"KES\",\"ZAR\":\"ZAR\",\"XOF\":\"XOF\"}', 0, '{\"callback\":{\"title\": \"Callback URL\",\"value\":\"ipn.Paystack\"},\"webhook\":{\"title\": \"Webhook URL\",\"value\":\"ipn.Paystack\"}}\r\n', NULL, '2019-09-14 07:14:22', '2024-05-07 02:21:48'),
(9, 0, 109, 'Flutterwave', 'Flutterwave', '663a36c2c34d61715091138.png', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------------\"},\"encryption_key\":{\"title\":\"Encryption Key\",\"global\":true,\"value\":\"------------------\"}}', '{\"BIF\":\"BIF\",\"CAD\":\"CAD\",\"CDF\":\"CDF\",\"CVE\":\"CVE\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"GHS\":\"GHS\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"KES\":\"KES\",\"LRD\":\"LRD\",\"MWK\":\"MWK\",\"MZN\":\"MZN\",\"NGN\":\"NGN\",\"RWF\":\"RWF\",\"SLL\":\"SLL\",\"STD\":\"STD\",\"TZS\":\"TZS\",\"UGX\":\"UGX\",\"USD\":\"USD\",\"XAF\":\"XAF\",\"XOF\":\"XOF\",\"ZMK\":\"ZMK\",\"ZMW\":\"ZMW\",\"ZWD\":\"ZWD\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:12:18'),
(10, 0, 110, 'RazorPay', 'Razorpay', '663a393a527831715091770.png', 1, '{\"key_id\":{\"title\":\"Key Id\",\"global\":true,\"value\":\"rzp_test_kiOtejPbRZU90E\"},\"key_secret\":{\"title\":\"Key Secret \",\"global\":true,\"value\":\"osRDebzEqbsE1kbyQJ4y0re7\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:22:50'),
(11, 0, 111, 'Stripe Storefront', 'StripeJs', '663a3995417171715091861.png', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_XXXXXXXXXXXXXXXXXXXX\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_XXXXXXXXXXXXXXXXXXXX\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:24:21'),
(12, 0, 112, 'Instamojo', 'Instamojo', '663a384d54a111715091533.png', 1, '{\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_2241633c3bc44a3de84a3b33969\"},\"auth_token\":{\"title\":\"Auth Token\",\"global\":true,\"value\":\"test_279f083f7bebefd35217feef22d\"},\"salt\":{\"title\":\"Salt\",\"global\":true,\"value\":\"19d38908eeff4f58b2ddda2c6d86ca25\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:18:53'),
(13, 0, 501, 'Blockchain', 'Blockchain', '663a35efd0c311715090927.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"55529946-05ca-48ff-8710-f279d86b1cc5\"},\"xpub_code\":{\"title\":\"XPUB CODE\",\"global\":true,\"value\":\"xpub6CKQ3xxWyBoFAF83izZCSFUorptEU9AF8TezhtWeMU5oefjX3sFSBw62Lr9iHXPkXmDQJJiHZeTRtD9Vzt8grAYRhvbz4nEvBu3QKELVzFK\"}}', '{\"BTC\":\"BTC\"}', 1, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:08:47'),
(15, 0, 503, 'CoinPayments', 'Coinpayments', '663a36a8d8e1d1715091112.png', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"---------------------\"},\"private_key\":{\"title\":\"Private Key\",\"global\":true,\"value\":\"---------------------\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"---------------------\"}}', '{\"BTC\":\"Bitcoin\",\"BTC.LN\":\"Bitcoin (Lightning Network)\",\"LTC\":\"Litecoin\",\"CPS\":\"CPS Coin\",\"VLX\":\"Velas\",\"APL\":\"Apollo\",\"AYA\":\"Aryacoin\",\"BAD\":\"Badcoin\",\"BCD\":\"Bitcoin Diamond\",\"BCH\":\"Bitcoin Cash\",\"BCN\":\"Bytecoin\",\"BEAM\":\"BEAM\",\"BITB\":\"Bean Cash\",\"BLK\":\"BlackCoin\",\"BSV\":\"Bitcoin SV\",\"BTAD\":\"Bitcoin Adult\",\"BTG\":\"Bitcoin Gold\",\"BTT\":\"BitTorrent\",\"CLOAK\":\"CloakCoin\",\"CLUB\":\"ClubCoin\",\"CRW\":\"Crown\",\"CRYP\":\"CrypticCoin\",\"CRYT\":\"CryTrExCoin\",\"CURE\":\"CureCoin\",\"DASH\":\"DASH\",\"DCR\":\"Decred\",\"DEV\":\"DeviantCoin\",\"DGB\":\"DigiByte\",\"DOGE\":\"Dogecoin\",\"EBST\":\"eBoost\",\"EOS\":\"EOS\",\"ETC\":\"Ether Classic\",\"ETH\":\"Ethereum\",\"ETN\":\"Electroneum\",\"EUNO\":\"EUNO\",\"EXP\":\"EXP\",\"Expanse\":\"Expanse\",\"FLASH\":\"FLASH\",\"GAME\":\"GameCredits\",\"GLC\":\"Goldcoin\",\"GRS\":\"Groestlcoin\",\"KMD\":\"Komodo\",\"LOKI\":\"LOKI\",\"LSK\":\"LSK\",\"MAID\":\"MaidSafeCoin\",\"MUE\":\"MonetaryUnit\",\"NAV\":\"NAV Coin\",\"NEO\":\"NEO\",\"NMC\":\"Namecoin\",\"NVST\":\"NVO Token\",\"NXT\":\"NXT\",\"OMNI\":\"OMNI\",\"PINK\":\"PinkCoin\",\"PIVX\":\"PIVX\",\"POT\":\"PotCoin\",\"PPC\":\"Peercoin\",\"PROC\":\"ProCurrency\",\"PURA\":\"PURA\",\"QTUM\":\"QTUM\",\"RES\":\"Resistance\",\"RVN\":\"Ravencoin\",\"RVR\":\"RevolutionVR\",\"SBD\":\"Steem Dollars\",\"SMART\":\"SmartCash\",\"SOXAX\":\"SOXAX\",\"STEEM\":\"STEEM\",\"STRAT\":\"STRAT\",\"SYS\":\"Syscoin\",\"TPAY\":\"TokenPay\",\"TRIGGERS\":\"Triggers\",\"TRX\":\" TRON\",\"UBQ\":\"Ubiq\",\"UNIT\":\"UniversalCurrency\",\"USDT.BEP20\":\"Tether USD (BSC Chain)\",\"USDT.ERC20\":\"Tether USD (ERC20)\",\"USDT.TRC20\":\"Tether USD (Tron/TRC20)\",\"VTC\":\"Vertcoin\",\"WAVES\":\"Waves\",\"XCP\":\"Counterparty\",\"XEM\":\"NEM\",\"XMR\":\"Monero\",\"XSN\":\"Stakenet\",\"XSR\":\"SucreCoin\",\"XVG\":\"VERGE\",\"XZC\":\"ZCoin\",\"ZEC\":\"ZCash\",\"ZEN\":\"Horizen\"}', 1, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:11:52'),
(16, 0, 504, 'CoinPayments Fiat', 'CoinpaymentsFiat', '663a36b7b841a1715091127.png', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"6515561\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:12:07'),
(17, 0, 505, 'Coingate', 'Coingate', '663a368e753381715091086.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"6354mwVCEw5kHzRJ6thbGo-N\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:11:26'),
(18, 0, 506, 'Coinbase Commerce', 'CoinbaseCommerce', '663a367e46ae51715091070.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"c47cd7df-d8e8-424b-a20a\"},\"secret\":{\"title\":\"Webhook Shared Secret\",\"global\":true,\"value\":\"55871878-2c32-4f64-ab66\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"JPY\":\"JPY\",\"GBP\":\"GBP\",\"AUD\":\"AUD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CNY\":\"CNY\",\"SEK\":\"SEK\",\"NZD\":\"NZD\",\"MXN\":\"MXN\",\"SGD\":\"SGD\",\"HKD\":\"HKD\",\"NOK\":\"NOK\",\"KRW\":\"KRW\",\"TRY\":\"TRY\",\"RUB\":\"RUB\",\"INR\":\"INR\",\"BRL\":\"BRL\",\"ZAR\":\"ZAR\",\"AED\":\"AED\",\"AFN\":\"AFN\",\"ALL\":\"ALL\",\"AMD\":\"AMD\",\"ANG\":\"ANG\",\"AOA\":\"AOA\",\"ARS\":\"ARS\",\"AWG\":\"AWG\",\"AZN\":\"AZN\",\"BAM\":\"BAM\",\"BBD\":\"BBD\",\"BDT\":\"BDT\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"BIF\":\"BIF\",\"BMD\":\"BMD\",\"BND\":\"BND\",\"BOB\":\"BOB\",\"BSD\":\"BSD\",\"BTN\":\"BTN\",\"BWP\":\"BWP\",\"BYN\":\"BYN\",\"BZD\":\"BZD\",\"CDF\":\"CDF\",\"CLF\":\"CLF\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"CRC\":\"CRC\",\"CUC\":\"CUC\",\"CUP\":\"CUP\",\"CVE\":\"CVE\",\"CZK\":\"CZK\",\"DJF\":\"DJF\",\"DKK\":\"DKK\",\"DOP\":\"DOP\",\"DZD\":\"DZD\",\"EGP\":\"EGP\",\"ERN\":\"ERN\",\"ETB\":\"ETB\",\"FJD\":\"FJD\",\"FKP\":\"FKP\",\"GEL\":\"GEL\",\"GGP\":\"GGP\",\"GHS\":\"GHS\",\"GIP\":\"GIP\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"GTQ\":\"GTQ\",\"GYD\":\"GYD\",\"HNL\":\"HNL\",\"HRK\":\"HRK\",\"HTG\":\"HTG\",\"HUF\":\"HUF\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"IMP\":\"IMP\",\"IQD\":\"IQD\",\"IRR\":\"IRR\",\"ISK\":\"ISK\",\"JEP\":\"JEP\",\"JMD\":\"JMD\",\"JOD\":\"JOD\",\"KES\":\"KES\",\"KGS\":\"KGS\",\"KHR\":\"KHR\",\"KMF\":\"KMF\",\"KPW\":\"KPW\",\"KWD\":\"KWD\",\"KYD\":\"KYD\",\"KZT\":\"KZT\",\"LAK\":\"LAK\",\"LBP\":\"LBP\",\"LKR\":\"LKR\",\"LRD\":\"LRD\",\"LSL\":\"LSL\",\"LYD\":\"LYD\",\"MAD\":\"MAD\",\"MDL\":\"MDL\",\"MGA\":\"MGA\",\"MKD\":\"MKD\",\"MMK\":\"MMK\",\"MNT\":\"MNT\",\"MOP\":\"MOP\",\"MRO\":\"MRO\",\"MUR\":\"MUR\",\"MVR\":\"MVR\",\"MWK\":\"MWK\",\"MYR\":\"MYR\",\"MZN\":\"MZN\",\"NAD\":\"NAD\",\"NGN\":\"NGN\",\"NIO\":\"NIO\",\"NPR\":\"NPR\",\"OMR\":\"OMR\",\"PAB\":\"PAB\",\"PEN\":\"PEN\",\"PGK\":\"PGK\",\"PHP\":\"PHP\",\"PKR\":\"PKR\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"RWF\":\"RWF\",\"SAR\":\"SAR\",\"SBD\":\"SBD\",\"SCR\":\"SCR\",\"SDG\":\"SDG\",\"SHP\":\"SHP\",\"SLL\":\"SLL\",\"SOS\":\"SOS\",\"SRD\":\"SRD\",\"SSP\":\"SSP\",\"STD\":\"STD\",\"SVC\":\"SVC\",\"SYP\":\"SYP\",\"SZL\":\"SZL\",\"THB\":\"THB\",\"TJS\":\"TJS\",\"TMT\":\"TMT\",\"TND\":\"TND\",\"TOP\":\"TOP\",\"TTD\":\"TTD\",\"TWD\":\"TWD\",\"TZS\":\"TZS\",\"UAH\":\"UAH\",\"UGX\":\"UGX\",\"UYU\":\"UYU\",\"UZS\":\"UZS\",\"VEF\":\"VEF\",\"VND\":\"VND\",\"VUV\":\"VUV\",\"WST\":\"WST\",\"XAF\":\"XAF\",\"XAG\":\"XAG\",\"XAU\":\"XAU\",\"XCD\":\"XCD\",\"XDR\":\"XDR\",\"XOF\":\"XOF\",\"XPD\":\"XPD\",\"XPF\":\"XPF\",\"XPT\":\"XPT\",\"YER\":\"YER\",\"ZMW\":\"ZMW\",\"ZWL\":\"ZWL\"}\r\n\r\n', 0, '{\"endpoint\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.CoinbaseCommerce\"}}', NULL, '2019-09-14 07:14:22', '2024-05-07 02:11:10'),
(24, 0, 113, 'Paypal Express', 'PaypalSdk', '663a38ed101a61715091693.png', 1, '{\"clientId\":{\"title\":\"Paypal Client ID\",\"global\":true,\"value\":\"Ae0-tixtSV7DvLwIh3Bmu7JvHrjh5EfGdXr_cEklKAVjjezRZ747BxKILiBdzlKKyp-W8W_T7CKH1Ken\"},\"clientSecret\":{\"title\":\"Client Secret\",\"global\":true,\"value\":\"EOhbvHZgFNO21soQJT1L9Q00M3rK6PIEsdiTgXRBt2gtGtxwRer5JvKnVUGNU5oE63fFnjnYY7hq3HBA\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:21:33'),
(25, 0, 114, 'Stripe Checkout', 'StripeV3', '663a39afb519f1715091887.png', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_XXXXXXXXXXXXXXXXXXXX\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_XXXXXXXXXXXXXXXXXXXX\"},\"end_point\":{\"title\":\"End Point Secret\",\"global\":true,\"value\":\"whsec_XXXXXXXXXXXXXXXXXXXX\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, '{\"webhook\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.StripeV3\"}}', NULL, '2019-09-14 07:14:22', '2024-05-07 02:24:47'),
(27, 0, 115, 'Mollie', 'Mollie', '663a387ec69371715091582.png', 1, '{\"mollie_email\":{\"title\":\"Mollie Email \",\"global\":true,\"value\":\"vi@gmail.com\"},\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_cucfwKTWfft9s337qsVfn5CC4vNkrn\"}}', '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, '2019-09-14 07:14:22', '2024-05-07 02:19:42'),
(30, 0, 116, 'Cashmaal', 'Cashmaal', '663a361b16bd11715090971.png', 1, '{\"web_id\":{\"title\":\"Web Id\",\"global\":true,\"value\":\"3748\"},\"ipn_key\":{\"title\":\"IPN Key\",\"global\":true,\"value\":\"546254628759524554647987\"}}', '{\"PKR\":\"PKR\",\"USD\":\"USD\"}', 0, '{\"webhook\":{\"title\": \"IPN URL\",\"value\":\"ipn.Cashmaal\"}}', NULL, NULL, '2024-05-07 02:09:31'),
(36, 0, 119, 'Mercado Pago', 'MercadoPago', '663a386c714a91715091564.png', 1, '{\"access_token\":{\"title\":\"Access Token\",\"global\":true,\"value\":\"APP_USR-7924565816849832-082312-21941521997fab717db925cf1ea2c190-1071840315\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\",\"ARS\":\"ARS\",\"BRL\":\"BRL\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"MXN\":\"MXN\",\"PEN\":\"PEN\",\"UYU\":\"UYU\",\"VEF\":\"VEF\",\"BOB\":\"BOB\"}', 0, NULL, NULL, NULL, '2024-05-07 02:19:24'),
(37, 0, 120, 'Authorize.net', 'Authorize', '663a35b9ca5991715090873.png', 1, '{\"login_id\":{\"title\":\"Login ID\",\"global\":true,\"value\":\"59e4P9DBcZv\"},\"transaction_key\":{\"title\":\"Transaction Key\",\"global\":true,\"value\":\"47x47TJyLw2E7DbR\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2024-05-07 02:07:53'),
(46, 0, 121, 'NMI', 'NMI', '663a3897754cf1715091607.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"2F822Rw39fx762MaV7Yy86jXGTC7sCDy\"}}', '{\"AED\":\"AED\",\"ARS\":\"ARS\",\"AUD\":\"AUD\",\"BOB\":\"BOB\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"RUB\":\"RUB\",\"SEC\":\"SEC\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, NULL, '2024-05-07 02:20:07'),
(50, 0, 507, 'BTCPay', 'BTCPay', '663a35cd25a8d1715090893.png', 1, '{\"store_id\":{\"title\":\"Store Id\",\"global\":true,\"value\":\"HsqFVTXSeUFJu7caoYZc3CTnP8g5LErVdHhEXPVTheHf\"},\"api_key\":{\"title\":\"Api Key\",\"global\":true,\"value\":\"4436bd706f99efae69305e7c4eff4780de1335ce\"},\"server_name\":{\"title\":\"Server Name\",\"global\":true,\"value\":\"https:\\/\\/testnet.demo.btcpayserver.org\"},\"secret_code\":{\"title\":\"Secret Code\",\"global\":true,\"value\":\"SUCdqPn9CDkY7RmJHfpQVHP2Lf2\"}}', '{\"BTC\":\"Bitcoin\",\"LTC\":\"Litecoin\"}', 1, '{\"webhook\":{\"title\": \"IPN URL\",\"value\":\"ipn.BTCPay\"}}', NULL, NULL, '2024-05-07 02:08:13'),
(51, 0, 508, 'Now payments hosted', 'NowPaymentsHosted', '663a38b8d57a81715091640.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"--------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"------------\"}}', '{\"BTG\":\"BTG\",\"ETH\":\"ETH\",\"XMR\":\"XMR\",\"ZEC\":\"ZEC\",\"XVG\":\"XVG\",\"ADA\":\"ADA\",\"LTC\":\"LTC\",\"BCH\":\"BCH\",\"QTUM\":\"QTUM\",\"DASH\":\"DASH\",\"XLM\":\"XLM\",\"XRP\":\"XRP\",\"XEM\":\"XEM\",\"DGB\":\"DGB\",\"LSK\":\"LSK\",\"DOGE\":\"DOGE\",\"TRX\":\"TRX\",\"KMD\":\"KMD\",\"REP\":\"REP\",\"BAT\":\"BAT\",\"ARK\":\"ARK\",\"WAVES\":\"WAVES\",\"BNB\":\"BNB\",\"XZC\":\"XZC\",\"NANO\":\"NANO\",\"TUSD\":\"TUSD\",\"VET\":\"VET\",\"ZEN\":\"ZEN\",\"GRS\":\"GRS\",\"FUN\":\"FUN\",\"NEO\":\"NEO\",\"GAS\":\"GAS\",\"PAX\":\"PAX\",\"USDC\":\"USDC\",\"ONT\":\"ONT\",\"XTZ\":\"XTZ\",\"LINK\":\"LINK\",\"RVN\":\"RVN\",\"BNBMAINNET\":\"BNBMAINNET\",\"ZIL\":\"ZIL\",\"BCD\":\"BCD\",\"USDT\":\"USDT\",\"USDTERC20\":\"USDTERC20\",\"CRO\":\"CRO\",\"DAI\":\"DAI\",\"HT\":\"HT\",\"WABI\":\"WABI\",\"BUSD\":\"BUSD\",\"ALGO\":\"ALGO\",\"USDTTRC20\":\"USDTTRC20\",\"GT\":\"GT\",\"STPT\":\"STPT\",\"AVA\":\"AVA\",\"SXP\":\"SXP\",\"UNI\":\"UNI\",\"OKB\":\"OKB\",\"BTC\":\"BTC\"}', 1, '', NULL, NULL, '2024-05-07 02:20:40'),
(52, 0, 509, 'Now payments checkout', 'NowPaymentsCheckout', '663a38a59d2541715091621.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"---------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\"}', 1, '', NULL, NULL, '2024-05-07 02:20:21'),
(53, 0, 122, '2Checkout', 'TwoCheckout', '663a39b8e64b91715091896.png', 1, '{\"merchant_code\":{\"title\":\"Merchant Code\",\"global\":true,\"value\":\"253248016872\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"eQM)ID@&vG84u!O*g[p+\"}}', '{\"AFN\": \"AFN\",\"ALL\": \"ALL\",\"DZD\": \"DZD\",\"ARS\": \"ARS\",\"AUD\": \"AUD\",\"AZN\": \"AZN\",\"BSD\": \"BSD\",\"BDT\": \"BDT\",\"BBD\": \"BBD\",\"BZD\": \"BZD\",\"BMD\": \"BMD\",\"BOB\": \"BOB\",\"BWP\": \"BWP\",\"BRL\": \"BRL\",\"GBP\": \"GBP\",\"BND\": \"BND\",\"BGN\": \"BGN\",\"CAD\": \"CAD\",\"CLP\": \"CLP\",\"CNY\": \"CNY\",\"COP\": \"COP\",\"CRC\": \"CRC\",\"HRK\": \"HRK\",\"CZK\": \"CZK\",\"DKK\": \"DKK\",\"DOP\": \"DOP\",\"XCD\": \"XCD\",\"EGP\": \"EGP\",\"EUR\": \"EUR\",\"FJD\": \"FJD\",\"GTQ\": \"GTQ\",\"HKD\": \"HKD\",\"HNL\": \"HNL\",\"HUF\": \"HUF\",\"INR\": \"INR\",\"IDR\": \"IDR\",\"ILS\": \"ILS\",\"JMD\": \"JMD\",\"JPY\": \"JPY\",\"KZT\": \"KZT\",\"KES\": \"KES\",\"LAK\": \"LAK\",\"MMK\": \"MMK\",\"LBP\": \"LBP\",\"LRD\": \"LRD\",\"MOP\": \"MOP\",\"MYR\": \"MYR\",\"MVR\": \"MVR\",\"MRO\": \"MRO\",\"MUR\": \"MUR\",\"MXN\": \"MXN\",\"MAD\": \"MAD\",\"NPR\": \"NPR\",\"TWD\": \"TWD\",\"NZD\": \"NZD\",\"NIO\": \"NIO\",\"NOK\": \"NOK\",\"PKR\": \"PKR\",\"PGK\": \"PGK\",\"PEN\": \"PEN\",\"PHP\": \"PHP\",\"PLN\": \"PLN\",\"QAR\": \"QAR\",\"RON\": \"RON\",\"RUB\": \"RUB\",\"WST\": \"WST\",\"SAR\": \"SAR\",\"SCR\": \"SCR\",\"SGD\": \"SGD\",\"SBD\": \"SBD\",\"ZAR\": \"ZAR\",\"KRW\": \"KRW\",\"LKR\": \"LKR\",\"SEK\": \"SEK\",\"CHF\": \"CHF\",\"SYP\": \"SYP\",\"THB\": \"THB\",\"TOP\": \"TOP\",\"TTD\": \"TTD\",\"TRY\": \"TRY\",\"UAH\": \"UAH\",\"AED\": \"AED\",\"USD\": \"USD\",\"VUV\": \"VUV\",\"VND\": \"VND\",\"XOF\": \"XOF\",\"YER\": \"YER\"}', 0, '{\"approved_url\":{\"title\": \"Approved URL\",\"value\":\"ipn.TwoCheckout\"}}', NULL, NULL, '2024-05-07 02:24:56'),
(54, 0, 123, 'Checkout', 'Checkout', '663a3628733351715090984.png', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"------\"},\"public_key\":{\"title\":\"PUBLIC KEY\",\"global\":true,\"value\":\"------\"},\"processing_channel_id\":{\"title\":\"PROCESSING CHANNEL\",\"global\":true,\"value\":\"------\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"AUD\":\"AUD\",\"CAN\":\"CAN\",\"CHF\":\"CHF\",\"SGD\":\"SGD\",\"JPY\":\"JPY\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, '2024-05-07 02:09:44'),
(56, 0, 510, 'Binance', 'Binance', '663a35db4fd621715090907.png', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"tsu3tjiq0oqfbtmlbevoeraxhfbp3brejnm9txhjxcp4to29ujvakvfl1ibsn3ja\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"jzngq4t04ltw8d4iqpi7admfl8tvnpehxnmi34id1zvfaenbwwvsvw7llw3zdko8\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"231129033\"}}', '{\"BTC\":\"Bitcoin\",\"USD\":\"USD\",\"BNB\":\"BNB\"}', 1, '{\"cron\":{\"title\": \"Cron Job URL\",\"value\":\"ipn.Binance\"}}', NULL, NULL, '2024-05-07 02:08:27'),
(57, 0, 124, 'SslCommerz', 'SslCommerz', '663a397a70c571715091834.png', 1, '{\"store_id\":{\"title\":\"Store ID\",\"global\":true,\"value\":\"---------\"},\"store_password\":{\"title\":\"Store Password\",\"global\":true,\"value\":\"----------\"}}', '{\"BDT\":\"BDT\",\"USD\":\"USD\",\"EUR\":\"EUR\",\"SGD\":\"SGD\",\"INR\":\"INR\",\"MYR\":\"MYR\"}', 0, NULL, NULL, NULL, '2024-05-07 02:23:54'),
(58, 0, 125, 'Aamarpay', 'Aamarpay', '663a34d5d1dfc1715090645.png', 1, '{\"store_id\":{\"title\":\"Store ID\",\"global\":true,\"value\":\"---------\"},\"signature_key\":{\"title\":\"Signature Key\",\"global\":true,\"value\":\"----------\"}}', '{\"BDT\":\"BDT\"}', 0, NULL, NULL, NULL, '2024-05-07 02:04:05'),
(59, 0, 126, 'bKash', 'BKash', '67e1432683b5a1742816038.png', 1, '{\"username\":{\"title\":\"Username\",\"global\":true,\"value\":\"*****************\"},\"password\":{\"title\":\"Password\",\"global\":true,\"value\":\"*****************\"},\"app_key\":{\"title\":\"App Key\",\"global\":true,\"value\":\"*****************\"},\"app_secret\":{\"title\":\"App Secret\",\"global\":true,\"value\":\"*****************\"}}', '{\"BDT\":\"BDT\"}', 0, NULL, NULL, NULL, '2025-04-21 13:46:15');

-- --------------------------------------------------------

--
-- Table structure for table `gateway_currencies`
--

CREATE TABLE `gateway_currencies` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_code` int DEFAULT NULL,
  `gateway_alias` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `max_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `percent_charge` decimal(5,2) NOT NULL DEFAULT '0.00',
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `rate` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `gateway_parameter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint UNSIGNED NOT NULL,
  `site_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_wishlist` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `product_compare` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `product_review` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `product_review_auto_approval` tinyint(1) NOT NULL DEFAULT '1',
  `cur_text` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_from_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_template` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sms_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_from` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_template` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `preloader_title` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_color` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secondary_color` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'email configuration',
  `sms_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `firebase_config` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `global_shortcodes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `ev` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'email verification, 0 - dont check, 1 - check',
  `en` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'email notification, 0 - dont send, 1 - send',
  `sv` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'mobile verication, 0 - dont check, 1 - check',
  `sn` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'sms notification, 0 - dont send, 1 - send',
  `pn` tinyint(1) NOT NULL DEFAULT '1',
  `force_ssl` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance_mode` tinyint(1) NOT NULL DEFAULT '0',
  `secure_password` tinyint(1) NOT NULL DEFAULT '0',
  `agree` tinyint(1) NOT NULL DEFAULT '0',
  `multi_language` tinyint(1) NOT NULL DEFAULT '1',
  `registration` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Off	, 1: On',
  `guest_checkout` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `cod` tinyint(1) NOT NULL DEFAULT '0',
  `recently_viewed_items` int NOT NULL DEFAULT '0',
  `recently_viewed_days` int NOT NULL DEFAULT '0',
  `active_template` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `socialite_credentials` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `system_customized` tinyint(1) NOT NULL DEFAULT '0',
  `available_version` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `paginate_number` int NOT NULL DEFAULT '0',
  `currency_format` tinyint UNSIGNED NOT NULL DEFAULT '1' COMMENT '1=>Both\\r\\n2=>Text Only\\r\\n3=>Symbol Only''',
  `config_progress` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `homepage_layout` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscriber_module` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `site_name`, `product_wishlist`, `product_compare`, `product_review`, `product_review_auto_approval`, `cur_text`, `cur_sym`, `email_from`, `email_from_name`, `email_template`, `sms_template`, `sms_from`, `push_title`, `push_template`, `preloader_title`, `base_color`, `secondary_color`, `mail_config`, `sms_config`, `firebase_config`, `global_shortcodes`, `ev`, `en`, `sv`, `sn`, `pn`, `force_ssl`, `maintenance_mode`, `secure_password`, `agree`, `multi_language`, `registration`, `guest_checkout`, `cod`, `recently_viewed_items`, `recently_viewed_days`, `active_template`, `socialite_credentials`, `system_customized`, `available_version`, `paginate_number`, `currency_format`, `config_progress`, `homepage_layout`, `subscriber_module`, `created_at`, `updated_at`) VALUES
(1, 'Visermart', 1, 1, 1, 0, 'USD', '$', 'info@viserlab.com', NULL, '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n  <!--[if !mso]><!-->\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n  <!--<![endif]-->\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n  <title></title>\n  <style type=\"text/css\">\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\n.ExternalClass { width: 100%; background-color: #ffffff; }\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\nhtml { width: 100%; }\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\ntable table table { table-layout: auto; }\n.yshortcuts a { border-bottom: none !important; }\nimg:hover { opacity: 0.9 !important; }\na { color: #0087ff; text-decoration: none; }\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\n.btn-link a { color:#FFFFFF !important;}\n\n@media only screen and (max-width: 480px) {\nbody { width: auto !important; }\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\n/* image */\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\n}\n</style>\n\n\n\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n    <tbody><tr>\n      <td height=\"50\"></td>\n    </tr>\n    <tr>\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\n          <tbody><tr>\n            <td align=\"center\" width=\"600\">\n              <!--header-->\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n                <tbody><tr>\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n                      <tbody><tr>\n                        <td height=\"20\"></td>\n                      </tr>\n                      <tr>\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\n                      </tr>\n                      <tr>\n                        <td height=\"20\"></td>\n                      </tr>\n                    </tbody></table>\n                  </td>\n                </tr>\n              </tbody></table>\n              <!--end header-->\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n                <tbody><tr>\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n                      <tbody><tr>\n                        <td height=\"35\"></td>\n                      </tr>\n                      <!--logo-->\n                      <tr>\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\n                          <a href=\"#\">\n                            <img style=\"display:block; line-height:0px; font-size:0px; border:0px;\" src=\"https://script.viserlab.com/apps/cdn/demo-logo.png\" width=\"220\" alt=\"img\">\n                          </a>\n                        </td>\n                      </tr>\n                      <!--end logo-->\n                      <tr>\n                        <td height=\"40\"></td>\n                      </tr>\n                      <!--headline-->\n                      <tr>\n                        <td align=\"center\" style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 22px;color:#414a51;font-weight: bold;\">Hello {{fullname}} ({{username}})</td>\n                      </tr>\n                      <!--end headline-->\n                      <tr>\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\n                            <tbody><tr>\n                              <td height=\"20\" style=\" border-bottom:3px solid #0087ff;\"></td>\n                            </tr>\n                          </tbody></table>\n                        </td>\n                      </tr>\n                      <tr>\n                        <td height=\"20\"></td>\n                      </tr>\n                      <!--content-->\n                      <tr>\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">{{message}}</td>\n                      </tr>\n                      <!--end content-->\n                      <tr>\n                        <td height=\"40\"></td>\n                      </tr>\n              \n                    </tbody></table>\n                  </td>\n                </tr>\n                <tr>\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\n                      <tbody><tr>\n                        <td height=\"10\"></td>\n                      </tr>\n                      <!--preference-->\n                      <tr>\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\n                          © 2024 <a href=\"#\">{{site_name}}</a>&nbsp;. All Rights Reserved. \n                        </td>\n                      </tr>\n                      <!--end preference-->\n                      <tr>\n                        <td height=\"10\"></td>\n                      </tr>\n                    </tbody></table>\n                  </td>\n                </tr>\n              </tbody></table>\n            </td>\n          </tr>\n        </tbody></table>\n      </td>\n    </tr>\n    <tr>\n      <td height=\"60\"></td>\n    </tr>\n  </tbody></table>', 'hi {{fullname}} ({{username}}), {{message}}', 'ViserAdmin', NULL, NULL, 'Visermart', 'f3532b', 'ebebeb', '{\"name\":\"php\"}', '{\"name\":\"nexmo\",\"clickatell\":{\"api_key\":\"----------------\"},\"infobip\":{\"username\":\"------------8888888\",\"password\":\"-----------------\"},\"message_bird\":{\"api_key\":\"-------------------\"},\"nexmo\":{\"api_key\":\"----------------------\",\"api_secret\":\"----------------------\"},\"sms_broadcast\":{\"username\":\"----------------------\",\"password\":\"-----------------------------\"},\"twilio\":{\"account_sid\":\"-----------------------\",\"auth_token\":\"---------------------------\",\"from\":\"----------------------\"},\"text_magic\":{\"username\":\"-----------------------\",\"apiv2_key\":\"-------------------------------\"},\"custom\":{\"method\":\"get\",\"url\":\"https:\\/\\/hostname\\/demo-api-v1\",\"headers\":{\"name\":[\"api_key\"],\"value\":[\"test_api 555\"]},\"body\":{\"name\":[\"from_number\"],\"value\":[\"5657545757\"]}}}', NULL, '{\n    \"site_name\":\"Name of your site\",\n    \"site_currency\":\"Currency of your site\",\n    \"currency_symbol\":\"Symbol of currency\"\n}', 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 12, 7, 'basic', '{\"google\":{\"client_id\":\"XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX\",\"client_secret\":\"GOCSPX-XXXXXXXXXXXXXXXXXXXXXXXXXXXXX\",\"status\":1},\"facebook\":{\"client_id\":\"8941354654163\",\"client_secret\":\"SDFASDF8413512\",\"status\":0},\"linkedin\":{\"client_id\":\"657846531351\",\"client_secret\":\"5746152\",\"status\":0}}', 0, '2.2', 20, 2, NULL, 'sidebar_menu', 1, NULL, '2025-04-22 06:23:25');

-- --------------------------------------------------------

--
-- Table structure for table `guests`
--

CREATE TABLE `guests` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dial_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `session_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `image`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', '67076f5911ee81728540505.png', 1, '2023-06-15 06:02:55', '2024-10-10 00:08:26');

-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE `media` (
  `id` bigint UNSIGNED NOT NULL,
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_product`
--

CREATE TABLE `media_product` (
  `product_id` bigint UNSIGNED NOT NULL,
  `media_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `media_product_variant`
--

CREATE TABLE `media_product_variant` (
  `product_variant_id` bigint UNSIGNED NOT NULL,
  `media_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_logs`
--

CREATE TABLE `notification_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `sender` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sent_to` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `notification_type` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_read` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification_templates`
--

CREATE TABLE `notification_templates` (
  `id` bigint UNSIGNED NOT NULL,
  `act` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `sms_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `push_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `shortcodes` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `email_status` tinyint(1) NOT NULL DEFAULT '1',
  `email_sent_from_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_sent_from_address` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_status` tinyint(1) NOT NULL DEFAULT '1',
  `sms_sent_from` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `push_status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notification_templates`
--

INSERT INTO `notification_templates` (`id`, `act`, `name`, `subject`, `push_title`, `email_body`, `sms_body`, `push_body`, `shortcodes`, `email_status`, `email_sent_from_name`, `email_sent_from_address`, `sms_status`, `sms_sent_from`, `push_status`, `created_at`, `updated_at`) VALUES
(3, 'PAYMENT_COMPLETE', 'Payment - Automated - Successful', 'Payment Completed Successfully', NULL, '<div>Your payment of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>has been completed Successfully.<span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Payment:<br></span></div><div><br></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#000000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Received : {{method_amount}} {{method_currency}}<br></div><div>Paid via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', '{{amount}} {{site_currency}} Payment successfully by {{method_name}}', '{{amount}} {{site_currency}} Payment successfully by {{method_name}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"post_balance\":\"Balance of the user after this transaction\"}', 1, NULL, NULL, 1, NULL, 0, '2021-11-03 12:00:00', '2024-09-15 01:33:11'),
(4, 'PAYMENT_APPROVE', 'Payment - Manual - Approved', 'Your Payment is Approved', NULL, '<div style=\"font-family: Montserrat, sans-serif;\">Your payment request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}</span>&nbsp;has been approved.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\">Details of your Payment:</span></div><div style=\"font-family: Montserrat, sans-serif;\">Amount : {{amount}} {{site_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number : {{trx}}</div>', 'Admin approve Your {{amount}} {{site_currency}} payment request by {{method_name}} transaction : {{trx}}', 'Admin approve Your {{amount}} {{site_currency}} payment request by {{method_name}} transaction : {{trx}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:40:36'),
(5, 'PAYMENT_REJECT', 'Payment - Manual - Rejected', 'Your Payment Request is Rejected', NULL, '<div style=\"font-family: Montserrat, sans-serif;\">Your payment request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span><span style=\"color: rgb(33, 37, 41); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\">has been rejected.</span></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div style=\"font-family: Montserrat, sans-serif;\">Received : {{method_amount}} {{method_currency}}<br></div><div style=\"font-family: Montserrat, sans-serif;\">Paid via :&nbsp; {{method_name}}</div><div style=\"font-family: Montserrat, sans-serif;\">Charge: {{charge}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Transaction Number was : {{trx}}</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">if you have any queries, feel free to contact us.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><span style=\"color: rgb(33, 37, 41); font-family: Montserrat, sans-serif;\">{{rejection_message}}</span><br>', 'Admin Rejected Your {{amount}} {{site_currency}} payment request by {{method_name}}\r\n\r\n{{rejection_message}}', NULL, '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\",\"rejection_message\":\"Rejection message by the admin\"}', 1, NULL, NULL, 1, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:41:13'),
(6, 'PAYMENT_REQUEST', 'Payment - Manual - Requested', 'Payment Request Submitted Successfully', NULL, '<div>Your payment request of&nbsp;<span style=\"font-weight: bolder;\">{{amount}} {{site_currency}}</span>&nbsp;is via&nbsp;&nbsp;<span style=\"font-weight: bolder;\">{{method_name}}&nbsp;</span>submitted successfully<span style=\"font-weight: bolder;\">&nbsp;.<br></span></div><div><span style=\"font-weight: bolder;\"><br></span></div><div><span style=\"font-weight: bolder;\">Details of your Payment:</span></div><div>Amount : {{amount}} {{site_currency}}</div><div>Charge:&nbsp;<font color=\"#FF0000\">{{charge}} {{site_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{site_currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}}<br></div><div>Pay via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', '{{amount}} {{site_currency}} payment request via {{method_name}} has been submitted. Charge: {{charge}} . Trx: {{trx}}', '{{amount}} {{site_currency}} payment request via {{method_name}} has been submitted. Charge: {{charge}} . Trx: {{trx}}', '{\"trx\":\"Transaction number for the deposit\",\"amount\":\"Amount inserted by the user\",\"charge\":\"Gateway charge set by the admin\",\"rate\":\"Conversion rate between base currency and method currency\",\"method_name\":\"Name of the deposit method\",\"method_currency\":\"Currency of the deposit method\",\"method_amount\":\"Amount after conversion between base currency and method currency\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:42:53'),
(7, 'PASS_RESET_CODE', 'Password - Reset - Code', 'Password Reset', NULL, '<div style=\"font-family: Montserrat, sans-serif;\">We have received a request to reset the password for your account on&nbsp;<span style=\"font-weight: bolder;\">{{time}} .<br></span></div><div style=\"font-family: Montserrat, sans-serif;\">Requested From IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>.</div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><br style=\"font-family: Montserrat, sans-serif;\"><div style=\"font-family: Montserrat, sans-serif;\"><div>Your account recovery code is:&nbsp;&nbsp;&nbsp;<font size=\"6\"><span style=\"font-weight: bolder;\">{{code}}</span></font></div><div><br></div></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\"><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><div><font size=\"4\" color=\"#CC0000\"><br></font></div>', 'Your account recovery code is: {{code}}', 'Your account recovery code is: {{code}}', '{\"code\":\"Verification code for password reset\",\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-11-14 06:48:38'),
(8, 'PASS_RESET_DONE', 'Password - Reset - Confirmation', 'You have reset your password', NULL, '<p style=\"font-family: Montserrat, sans-serif;\">You have successfully reset your password.</p><p style=\"font-family: Montserrat, sans-serif;\">You changed from&nbsp; IP:&nbsp;<span style=\"font-weight: bolder;\">{{ip}}</span>&nbsp;using&nbsp;<span style=\"font-weight: bolder;\">{{browser}}</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{operating_system}}&nbsp;</span>&nbsp;on&nbsp;<span style=\"font-weight: bolder;\">{{time}}</span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><br></span></p><p style=\"font-family: Montserrat, sans-serif;\"><span style=\"font-weight: bolder;\"><font color=\"#ff0000\">If you did not change that, please contact us as soon as possible.</font></span></p>', 'Your password has been changed successfully', NULL, '{\"ip\":\"IP address of the user\",\"browser\":\"Browser of the user\",\"operating_system\":\"Operating system of the user\",\"time\":\"Time of the request\"}', 1, NULL, NULL, 1, NULL, 0, '2021-11-03 12:00:00', '2022-04-05 03:46:35'),
(9, 'ADMIN_SUPPORT_REPLY', 'Support - Reply', 'Reply Support Ticket', NULL, '<div><p><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\">A member from our support team has replied to the following ticket:</span></span></p><p><span style=\"font-weight: bolder;\"><span data-mce-style=\"font-size: 11pt;\" style=\"font-size: 11pt;\"><span style=\"font-weight: bolder;\"><br></span></span></span></p><p><span style=\"font-weight: bolder;\">[Ticket#{{ticket_id}}] {{ticket_subject}}<br><br>Click here to reply:&nbsp; {{link}}</span></p><p>----------------------------------------------</p><p>Here is the reply :<br></p><p>{{reply}}<br></p></div><div><br style=\"font-family: Montserrat, sans-serif;\"></div>', 'Your Ticket#{{ticket_id}} :  {{ticket_subject}} has been replied.', NULL, '{\"ticket_id\":\"ID of the support ticket\",\"ticket_subject\":\"Subject  of the support ticket\",\"reply\":\"Reply made by the admin\",\"link\":\"URL to view the support ticket\"}', 1, NULL, NULL, 1, NULL, 0, '2021-11-03 12:00:00', '2022-03-20 20:47:51'),
(10, 'EVER_CODE', 'Verification - Email', 'Please verify your email address', NULL, '<br><div><div style=\"font-family: Montserrat, sans-serif;\">Thanks For joining us.<br></div><div style=\"font-family: Montserrat, sans-serif;\">Please use the below code to verify your email address.<br></div><div style=\"font-family: Montserrat, sans-serif;\"><br></div><div style=\"font-family: Montserrat, sans-serif;\">Your email verification code is:<font size=\"6\"><span style=\"font-weight: bolder;\">&nbsp;{{code}}</span></font></div></div>', '---', NULL, '{\"code\":\"Email verification code\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2022-04-03 02:32:07'),
(11, 'SVER_CODE', 'Verification - SMS', 'Verify Your Mobile Number', NULL, '---', 'Your phone verification code is: {{code}}', NULL, '{\"code\":\"SMS Verification Code\"}', 0, NULL, NULL, 1, NULL, 0, '2021-11-03 12:00:00', '2022-03-20 19:24:37'),
(15, 'DEFAULT', 'Default Template', '{{subject}}', NULL, '{{message}}', '{{message}}', '{{message}}', '{\"subject\":\"Subject\",\"message\":\"Message\"}', 1, NULL, NULL, 1, NULL, 0, '2019-09-14 13:14:22', '2024-10-03 04:38:20'),
(18, 'ORDER_ON_PROCESSING_CONFIRMATION', 'Send Order On Processing Alert', 'Order On Processing Alert', NULL, 'Greetings from {{site_name}} Your Order is on processed now get ready to receive your products.\r\n\r\nYour Order ID: {{order_id}}', 'Greetings from {{site_name}}\r\nYour Order is on processed now get ready to receive your products.\r\n\r\nYour Order ID: {{order_id}}', 'Greetings from {{site_name}}\r\n{{order_id}} order is on processed now get ready to receive your products.', '{\"order_id\":\"Order ID\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:46:40'),
(19, 'ORDER_DISPATCHED_CONFIRMATION', 'Send Order Dispatched Alert', 'Order Dispatched Alert', NULL, 'Greetings from {{site_name}}\r\nYour Order has been dispatched please receive your products.\r\n\r\nYour Order ID: {{order_id}}', 'Greetings from {{site_name}}\r\nYour Order has been dispatched please receive your products.\r\n\r\nYour Order ID: {{order_id}}', 'Greetings from {{site_name}}\r\n{{order_id}} order has been dispatched please receive your products.', '{\"order_id\":\"Order ID\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:46:09'),
(20, 'ORDER_CANCELLATION_CONFIRMATION', 'Send Cancellation Alert', 'Cancellation Alert', NULL, 'Greetings from {{site_name}}. We are sorry to say that we couldn\'<span style=\"color: rgb(33, 37, 41); font-size: 1rem;\">t accept your order now.&nbsp; <br>Your order has been canceled.<br><br>Your Order ID: {{order_id}}</span>', 'Greetings from {{site_name}}. \r\n\r\nYour order will be canceled.....\r\n\r\nYour Order ID: {{order_id}}', '{{order_id}} order has been canceled by {{site_name}}', '{\"order_id\":\"Order ID\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:44:13'),
(22, 'ORDER_DELIVERY_CONFIRMATION', 'Send Order Delivery Confirmation', 'Order Delivery Confirmation', NULL, 'Greetings from {{site_name}}\r\nYour order has been delivered. Thanks for your purchase from us.\r\nOrder Id :{{order_id}}', 'Greetings from {{site_name}}\r\nYour order has been delivered. Thanks for your purchase from us.\r\nOrder Id :{{order_id}}', '{{order_id}} order has been delivered from {{site_name}}.', '{\"trx\":\"Transaction Number\", \"order_id\":\"Order Track Number\",\"charge\":\"Charge Amount\"}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-03 04:45:30'),
(23, 'WELCOME_MESSAGE', 'Welcome Message To A Customer', 'Welcome Message', NULL, 'Hello {{fullname}}, Welcome to {{site_name}}!', 'Hello {{user_name}} Welcome to {{site_name}}!', NULL, '{\"fullname\":\"fullname\"}', 1, NULL, NULL, 1, NULL, 0, '2021-11-03 12:00:00', '2024-10-10 03:12:23'),
(24, 'DOWNLOAD_DIGITAL_PRODUCT', 'Digital Product is Ready on Download', 'Your digital product is now available on download', NULL, 'Thank you for your purchase!&nbsp;<span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\">We are excited to inform you that your digital product is now available to download.&nbsp;</span><div><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\">Please log in to your account on our website to access and download your product at your convenience.&nbsp;</span></div><div><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\"><br></span></div><div><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\">If you need any assistance, feel free to contact us.&nbsp;</span></div><div><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\"><br></span></div><div><span style=\"color: var(--bs-card-color); background-color: var(--bs-card-bg); font-size: 1rem; text-align: var(--bs-body-text-align);\">&nbsp; Thank you for choosing us!</span></div>', 'Thank you for your purchase! We are excited to inform you that your digital product is now downloadable. \r\nPlease log in to your account on our website to access and download your product at your convenience. \r\n\r\nIf you need any assistance, feel free to contact us. \r\n\r\n Thank you for choosing us, and we hope you enjoy your new digital product!', 'Thank you for your purchase! The product is now downloadable. Please log in to your account on our website to access and download.', '{}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 12:00:00', '2024-10-01 04:36:15'),
(25, 'REVIEW_APPROVE', 'Approved Review', 'Your Review is Approved', 'Your Review is Approved', '<div style=\"font-family: Montserrat, sans-serif;\"><div>Your review submission has been approved.</div><div>Product Name:{{product_name}}.</div></div>', 'Your review submission has been approved.\r\nProduct Name:{{product_name}}.', 'Your review submission has been approved.\r\nProduct Name:{{product_name}}.', '{\"product_name\":\"Review Product Name\"}', 1, 'Your Review is Approved', 'Your Review is Approved', 0, 'Your Review is Approved', 0, '2021-11-03 06:00:00', '2025-02-13 07:50:41'),
(26, 'REVIEW_REJECT', 'Rejected Review', 'Your Review is Rejected', 'Your Review is Rejected', '<div style=\"\"><div>Your review submission has been rejected.</div><div>Product Name:{{product_name}}.</div><div>Rejection Reason: {{rejected_reason}}</div></div>', 'Your review submission has been rejected.\r\nProduct Name:{{product_name}}.\r\nRejection Reason: {{rejected_reason}}', 'Your review submission has been rejected.\r\nProduct Name:{{product_name}}.\r\nRejection Reason: {{rejected_reason}}', '{\"product_name\":\"Review Product Name\",\"rejected_reason\":\"Reviewe Rejected Reason\"}', 1, NULL, NULL, 0, 'Your Review is Rejected', 0, '2021-11-03 06:00:00', '2025-02-13 07:47:00'),
(27, 'ORDER_PLACED', 'Order Placed Confirmation', 'Order placed successfully', NULL, '<p data-start=\"62\" data-end=\"78\">Dear Customer,</p><p data-start=\"80\" data-end=\"196\">Great news! Your order has been successfully placed and is now being processed. You’ll receive your products soon.</p><p data-start=\"198\" data-end=\"238\"><strong data-start=\"198\" data-end=\"215\">Order Number:</strong> <strong data-start=\"216\" data-end=\"236\">{{order_number}}</strong></p><p data-start=\"240\" data-end=\"347\"><a data-start=\"243\" data-end=\"291\" rel=\"noopener\">View your order details: {{order_details_url}}</a><br data-start=\"291\" data-end=\"294\"><a data-start=\"297\" data-end=\"345\" rel=\"noopener\">Track your order status:&nbsp;{{order_track_url}}</a></p><p data-start=\"349\" data-end=\"392\">Thank you for choosing <strong data-start=\"372\" data-end=\"389\">{{site_name}}</strong>!</p><p data-start=\"394\" data-end=\"432\" data-is-only-node=\"\" data-is-last-node=\"\">Best regards,<br data-start=\"407\" data-end=\"410\"><strong data-start=\"410\" data-end=\"432\" data-is-last-node=\"\">{{site_name}} Team</strong></p>', 'Your order has been successfully placed!\nOrder Number: {{order_number}}\nView Order Details  : {{order_details_url}}', 'Your order has been successfully placed!\n\nOrder Number: {{order_number}}\n\nView Order Details  : {{order_details_url}}\n Track Your Order :{{order_track_url}}\n\nThank you for choosing {{site_name}}!', '{\n\"order_number\":\"Order Number\",\n\"order_details_url\":\"Order Details Url\",\n\"order_track_url\":\"Order Tracking Url\"\n}', 1, NULL, NULL, 0, NULL, 0, '2021-11-03 06:00:00', '2025-03-25 00:51:07');

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `id` bigint UNSIGNED NOT NULL,
  `unique_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1=fixed, 2=percent',
  `amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `starts_from` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `show_banner` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `show_countdown` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0=disabled, 1=enabled',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `order_number` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `guest_id` int UNSIGNED DEFAULT NULL,
  `shipping_address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `shipping_method_id` int UNSIGNED NOT NULL DEFAULT '0',
  `shipping_charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `subtotal` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `total_amount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `is_cod` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `payment_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0=Not Paid ,1 = Paid',
  `status` tinyint NOT NULL DEFAULT '0' COMMENT '0 = pending, 1 = processing, 2=dispatched, 3=delivered, 4= canceled_by_admin, 9 = returned',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` bigint UNSIGNED NOT NULL,
  `order_id` int UNSIGNED NOT NULL DEFAULT '0',
  `product_id` int UNSIGNED NOT NULL DEFAULT '0',
  `product_variant_id` int UNSIGNED NOT NULL DEFAULT '0',
  `quantity` int UNSIGNED NOT NULL DEFAULT '0',
  `price` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `discount` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'template name',
  `secs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `seo_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `page_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `slug`, `tempname`, `secs`, `seo_content`, `page_name`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'Home', '/', 'templates.basic.', '[\"recent_viewed\",\"banner_4\",\"featured_categories\",\"collection_7\",\"offer_1\",\"collection_1\",\"collection_2\",\"collection_6\",\"collection_3\",\"collection_4\",\"collection_5\",\"featured_brands\",\"services\"]', NULL, 'home', 1, '2023-12-02 00:31:53', '2025-04-08 11:32:56'),
(2, 'About Us', 'about-us', 'templates.basic.', '[\"about_us\",\"quote\",\"feature\",\"counter\",\"services\"]', NULL, 'about', 1, '2023-12-02 00:31:53', '2025-04-09 11:33:20'),
(6, 'All Categories', 'categories', 'templates.basic.', NULL, NULL, NULL, 1, '2023-12-02 00:31:53', '2024-10-24 03:02:21'),
(7, 'All Brands', 'brands', 'templates.basic.', NULL, NULL, NULL, 1, '2023-12-02 00:31:53', '2024-09-27 01:23:33'),
(8, 'Contact', 'contact', 'templates.basic.', NULL, NULL, NULL, 1, '2023-12-02 00:31:53', '2024-09-27 01:28:16'),
(10, 'Offer', 'offers', 'templates.basic.', NULL, NULL, NULL, 1, '2023-12-02 00:31:53', '2024-09-27 01:28:16'),
(11, 'FAQ', 'faq', 'templates.basic.', NULL, NULL, NULL, 1, '2023-12-02 00:31:53', '2024-09-27 01:28:16');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `token` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `brand_id` int UNSIGNED DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `regular_price` decimal(28,8) DEFAULT NULL,
  `sale_price` decimal(28,8) DEFAULT NULL,
  `offer_id` int UNSIGNED NOT NULL DEFAULT '0',
  `sale_starts_from` timestamp NULL DEFAULT NULL,
  `sale_ends_at` timestamp NULL DEFAULT NULL,
  `main_image_id` int UNSIGNED DEFAULT '0',
  `video_link` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `summary` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `product_type_id` int UNSIGNED NOT NULL DEFAULT '0',
  `specification` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `extra_descriptions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `track_inventory` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `show_stock` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `in_stock` int UNSIGNED DEFAULT '0',
  `alert_quantity` int UNSIGNED NOT NULL DEFAULT '0',
  `product_type` tinyint UNSIGNED NOT NULL DEFAULT '1',
  `is_published` tinyint(1) NOT NULL DEFAULT '0',
  `is_downloadable` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `delivery_type` tinyint(1) DEFAULT NULL COMMENT '1 = Instant Download, 2 = Download After Sale',
  `meta_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `meta_keywords` text CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `show_in_products_page` tinyint UNSIGNED NOT NULL DEFAULT '0' COMMENT '1 = Show in products page, 0 = Hide from products page',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_collections`
--

CREATE TABLE `product_collections` (
  `id` bigint NOT NULL,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unique_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `banner_position` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_ids` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `product_id` int UNSIGNED NOT NULL DEFAULT '0',
  `review` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `rating` int NOT NULL DEFAULT '0',
  `reject_reason` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `is_viewed` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_review_images`
--

CREATE TABLE `product_review_images` (
  `id` bigint NOT NULL,
  `product_review_id` int DEFAULT NULL,
  `product_review_reply_id` int DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_review_replies`
--

CREATE TABLE `product_review_replies` (
  `id` bigint NOT NULL,
  `product_review_id` int DEFAULT NULL,
  `admin_id` int DEFAULT NULL,
  `comment` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_types`
--

CREATE TABLE `product_types` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `specifications` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `product_variants`
--

CREATE TABLE `product_variants` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL DEFAULT '0',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sku` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `manage_stock` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `track_inventory` tinyint UNSIGNED DEFAULT '0',
  `show_stock` tinyint UNSIGNED DEFAULT '0',
  `in_stock` int UNSIGNED DEFAULT '0',
  `alert_quantity` int UNSIGNED NOT NULL DEFAULT '0',
  `attribute_values` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'An array of attribute value',
  `regular_price` decimal(28,8) DEFAULT NULL,
  `sale_price` decimal(28,8) DEFAULT NULL,
  `sale_starts_from` timestamp NULL DEFAULT NULL,
  `sale_ends_at` timestamp NULL DEFAULT NULL,
  `main_image_id` int UNSIGNED NOT NULL DEFAULT '0',
  `is_published` tinyint NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotional_banners`
--

CREATE TABLE `promotional_banners` (
  `id` bigint NOT NULL,
  `type` tinyint NOT NULL DEFAULT '0' COMMENT '1 => single image banner,\r\n2 => double iamge banner\r\n3 => triple mage banner',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `unique_key` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `promotional_banner_images`
--

CREATE TABLE `promotional_banner_images` (
  `id` bigint NOT NULL,
  `promotional_banner_id` int UNSIGNED NOT NULL DEFAULT '0',
  `link` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_addresses`
--

CREATE TABLE `shipping_addresses` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `label` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `shipping_methods`
--

CREATE TABLE `shipping_methods` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `charge` decimal(28,8) NOT NULL DEFAULT '0.00000000',
  `shipping_time` tinyint(1) NOT NULL DEFAULT '0' COMMENT 'in days',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stock_logs`
--

CREATE TABLE `stock_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` int UNSIGNED NOT NULL DEFAULT '0',
  `product_variant_id` int UNSIGNED NOT NULL DEFAULT '0',
  `order_id` int UNSIGNED DEFAULT NULL,
  `change_quantity` int NOT NULL DEFAULT '0',
  `post_quantity` int NOT NULL DEFAULT '0',
  `remark` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` bigint UNSIGNED NOT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_attachments`
--

CREATE TABLE `support_attachments` (
  `id` bigint UNSIGNED NOT NULL,
  `support_message_id` int UNSIGNED NOT NULL DEFAULT '0',
  `attachment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` bigint UNSIGNED NOT NULL,
  `support_ticket_id` int UNSIGNED NOT NULL DEFAULT '0',
  `admin_id` int UNSIGNED NOT NULL DEFAULT '0',
  `message` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int DEFAULT '0',
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: Open, 1: Answered, 2: Replied, 3: Closed',
  `priority` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1 = Low, 2 = medium, 3 = heigh',
  `last_reply` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `update_logs`
--

CREATE TABLE `update_logs` (
  `id` bigint UNSIGNED NOT NULL,
  `version` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `update_log` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `firstname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dial_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `state` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0: banned, 1: active',
  `ev` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0: mobile unverified, 1: mobile verified',
  `profile_complete` tinyint(1) NOT NULL DEFAULT '0',
  `ver_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ban_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_logins`
--

CREATE TABLE `user_logins` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `user_ip` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_notifications`
--

CREATE TABLE `user_notifications` (
  `id` bigint NOT NULL,
  `user_id` int UNSIGNED NOT NULL DEFAULT '0',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `click_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_read` tinyint UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `variant_media`
--

CREATE TABLE `variant_media` (
  `variant_id` bigint UNSIGNED NOT NULL,
  `media_id` bigint UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wishlists`
--

CREATE TABLE `wishlists` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` int UNSIGNED DEFAULT '0',
  `session_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `product_id` int NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `applied_coupons`
--
ALTER TABLE `applied_coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attributes`
--
ALTER TABLE `attributes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attribute_product`
--
ALTER TABLE `attribute_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `attribute_id` (`attribute_id`);

--
-- Indexes for table `attribute_values`
--
ALTER TABLE `attribute_values`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attribute_value_product`
--
ALTER TABLE `attribute_value_product`
  ADD KEY `attribute_value_id` (`attribute_value_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `category_coupon`
--
ALTER TABLE `category_coupon`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupons_categories_coupon_id_foreign` (`coupon_id`),
  ADD KEY `coupons_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `category_product`
--
ALTER TABLE `category_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `products_categories_product_id_foreign` (`product_id`),
  ADD KEY `products_categories_category_id_foreign` (`category_id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupon_code` (`coupon_code`);

--
-- Indexes for table `coupon_product`
--
ALTER TABLE `coupon_product`
  ADD PRIMARY KEY (`id`),
  ADD KEY `coupons_products_coupon_id_foreign` (`coupon_id`),
  ADD KEY `coupons_products_product_id_foreign` (`product_id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `device_tokens`
--
ALTER TABLE `device_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `digital_files`
--
ALTER TABLE `digital_files`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extensions`
--
ALTER TABLE `extensions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `forms`
--
ALTER TABLE `forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `frontends`
--
ALTER TABLE `frontends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media`
--
ALTER TABLE `media`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `media_product`
--
ALTER TABLE `media_product`
  ADD PRIMARY KEY (`product_id`,`media_id`),
  ADD KEY `product_media_media_id_foreign` (`media_id`);

--
-- Indexes for table `media_product_variant`
--
ALTER TABLE `media_product_variant`
  ADD KEY `media_product_variant_media_id_foreign` (`media_id`),
  ADD KEY `media_product_variant_product_variant_id_foreign` (`product_variant_id`);

--
-- Indexes for table `notification_logs`
--
ALTER TABLE `notification_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notification_templates`
--
ALTER TABLE `notification_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `orders_order_number_unique` (`order_number`),
  ADD KEY `guest_id` (`guest_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `products_brand_id_index` (`brand_id`);

--
-- Indexes for table `product_collections`
--
ALTER TABLE `product_collections`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_review_images`
--
ALTER TABLE `product_review_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_review_replies`
--
ALTER TABLE `product_review_replies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_types`
--
ALTER TABLE `product_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `main_image_id` (`main_image_id`);

--
-- Indexes for table `promotional_banners`
--
ALTER TABLE `promotional_banners`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `promotional_banner_images`
--
ALTER TABLE `promotional_banner_images`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shipping_methods`
--
ALTER TABLE `shipping_methods`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `stock_logs`
--
ALTER TABLE `stock_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `product_variant_id` (`product_variant_id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_attachments`
--
ALTER TABLE `support_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `update_logs`
--
ALTER TABLE `update_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- Indexes for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_notifications`
--
ALTER TABLE `user_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `variant_media`
--
ALTER TABLE `variant_media`
  ADD PRIMARY KEY (`variant_id`,`media_id`);

--
-- Indexes for table `wishlists`
--
ALTER TABLE `wishlists`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applied_coupons`
--
ALTER TABLE `applied_coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attributes`
--
ALTER TABLE `attributes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attribute_product`
--
ALTER TABLE `attribute_product`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `attribute_values`
--
ALTER TABLE `attribute_values`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_coupon`
--
ALTER TABLE `category_coupon`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `category_product`
--
ALTER TABLE `category_product`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_product`
--
ALTER TABLE `coupon_product`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `device_tokens`
--
ALTER TABLE `device_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `digital_files`
--
ALTER TABLE `digital_files`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `extensions`
--
ALTER TABLE `extensions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `forms`
--
ALTER TABLE `forms`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `frontends`
--
ALTER TABLE `frontends`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `guests`
--
ALTER TABLE `guests`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `media`
--
ALTER TABLE `media`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_logs`
--
ALTER TABLE `notification_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification_templates`
--
ALTER TABLE `notification_templates`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_collections`
--
ALTER TABLE `product_collections`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_review_images`
--
ALTER TABLE `product_review_images`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_review_replies`
--
ALTER TABLE `product_review_replies`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_types`
--
ALTER TABLE `product_types`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `product_variants`
--
ALTER TABLE `product_variants`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotional_banners`
--
ALTER TABLE `promotional_banners`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `promotional_banner_images`
--
ALTER TABLE `promotional_banner_images`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipping_addresses`
--
ALTER TABLE `shipping_addresses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `shipping_methods`
--
ALTER TABLE `shipping_methods`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stock_logs`
--
ALTER TABLE `stock_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_attachments`
--
ALTER TABLE `support_attachments`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `update_logs`
--
ALTER TABLE `update_logs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_logins`
--
ALTER TABLE `user_logins`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_notifications`
--
ALTER TABLE `user_notifications`
  MODIFY `id` bigint NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wishlists`
--
ALTER TABLE `wishlists`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `category_coupon`
--
ALTER TABLE `category_coupon`
  ADD CONSTRAINT `coupons_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coupons_categories_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category_product`
--
ALTER TABLE `category_product`
  ADD CONSTRAINT `products_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_categories_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `coupon_product`
--
ALTER TABLE `coupon_product`
  ADD CONSTRAINT `coupons_products_coupon_id_foreign` FOREIGN KEY (`coupon_id`) REFERENCES `coupons` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `coupons_products_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `media_product`
--
ALTER TABLE `media_product`
  ADD CONSTRAINT `product_media_media_id_foreign` FOREIGN KEY (`media_id`) REFERENCES `media` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `product_media_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
