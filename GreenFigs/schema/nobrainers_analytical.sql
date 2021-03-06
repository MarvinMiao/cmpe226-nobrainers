-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 15, 2017 at 02:36 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nobrainers`
--

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE TABLE `calendar` (
  `calendarkey` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `date` varchar(10) DEFAULT NULL,
  `month` varchar(10) DEFAULT NULL,
  `quarter` varchar(10) DEFAULT NULL,
  `dayofweek` varchar(10) DEFAULT NULL,
  `year` varchar(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `calendar`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customerkey` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `customerid` int DEFAULT NULL UNIQUE,
  `customerfirstname` varchar(20) DEFAULT NULL,
  `customerlastname` varchar(20) DEFAULT NULL,
  `customeremail` varchar(100) DEFAULT NULL,
  `customerpassword` varchar(100) DEFAULT NULL,
  `customeraptnum` int DEFAULT NULL,
  `customerstreet` varchar(100) DEFAULT NULL,
  `customercity` varchar(20) DEFAULT NULL,
  `customerstate` varchar(10) DEFAULT NULL,
  `customercountry` varchar(20) DEFAULT NULL,
  `customerzip` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `customer`
--
-- --------------------------------------------------------

--
-- Table structure for table `farmer`
--

CREATE TABLE `farmer` (
  `farmerkey` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `farmerid` int DEFAULT NULL UNIQUE,
  `farmerfirstname` varchar(20) DEFAULT NULL,
  `farmerlastname` varchar(20) DEFAULT NULL,
  `farmeremail` varchar(50) DEFAULT NULL,
  `farmerpassword` varchar(50) DEFAULT NULL,
  `farmeraptnum` int DEFAULT NULL,
  `farmerstreet` varchar(50) DEFAULT NULL,
  `farmercity` varchar(20) DEFAULT NULL,
  `farmerstate` varchar(20) DEFAULT NULL,
  `farmercountry` varchar(20) DEFAULT NULL,
  `farmerzip` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `farmer`
--
-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `productkey` int NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `productid` varchar(10) DEFAULT NULL UNIQUE,
  `productname` varchar(20) DEFAULT NULL,
  `productprice` decimal(10,2) DEFAULT NULL,
  `productcategory` varchar(20) DEFAULT NULL,
  `productcertification` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `product`
--

-- --------------------------------------------------------

--
-- Table structure for table `recipe`
--

CREATE TABLE `recipe` (
  `calendarkey` int DEFAULT NULL,
  `customerkey` int DEFAULT NULL,
  `rtid` varchar(100) NOT NULL,
  `timeofday` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `recipe`
--


-- --------------------------------------------------------

--
-- Table structure for table `sales`
--

CREATE TABLE `sales` (
  `calendarkey` int DEFAULT NULL,
  `farmerkey` int DEFAULT NULL,
  `customerkey` int DEFAULT NULL,
  `productkey` int NOT NULL,
  `tid` varchar(100) NOT NULL,
  `timeofday` varchar(11) DEFAULT NULL,
  `revenue` varchar(10) DEFAULT NULL,
  `unitssold` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `sales`
--

--
-- Indexes for dumped tables
--
-- Indexes for table `recipe`
--
ALTER TABLE `recipe`
  ADD PRIMARY KEY (`rtid`),
  ADD KEY `calendarkey` (`calendarkey`),
  ADD KEY `customerkey` (`customerkey`);

--
-- Indexes for table `sales`
--
ALTER TABLE `sales`
  ADD PRIMARY KEY (`productkey`,`tid`),
  ADD KEY `calendarkey` (`calendarkey`),
  ADD KEY `farmerkey` (`farmerkey`),
  ADD KEY `customerkey` (`customerkey`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `recipe`
--
ALTER TABLE `recipe`
  ADD CONSTRAINT `recipe_ibfk_1` FOREIGN KEY (`calendarkey`) REFERENCES `calendar` (`calendarkey`),
  ADD CONSTRAINT `recipe_ibfk_2` FOREIGN KEY (`customerkey`) REFERENCES `customer` (`customerkey`);

--
-- Constraints for table `sales`
--
ALTER TABLE `sales`
  ADD CONSTRAINT `sales_ibfk_1` FOREIGN KEY (`calendarkey`) REFERENCES `calendar` (`calendarkey`),
  ADD CONSTRAINT `sales_ibfk_2` FOREIGN KEY (`farmerkey`) REFERENCES `farmer` (`farmerkey`),
  ADD CONSTRAINT `sales_ibfk_3` FOREIGN KEY (`customerkey`) REFERENCES `customer` (`customerkey`),
  ADD CONSTRAINT `sales_ibfk_4` FOREIGN KEY (`productkey`) REFERENCES `product` (`productkey`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
