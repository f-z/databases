-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 02, 2016 at 10:01 PM
-- Server version: 5.5.50-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `al_fz20473`
--

-- --------------------------------------------------------

--
-- Table structure for table `Manager`
--

CREATE TABLE IF NOT EXISTS `Manager` (
  `Mg_Name` varchar(15) NOT NULL,
  `Mg_Number` varchar(6) NOT NULL,
  `Mg_Department` varchar(15) NOT NULL,
  PRIMARY KEY (`Mg_Number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Manager`
--

INSERT INTO `Manager` (`Mg_Name`, `Mg_Number`, `Mg_Department`) VALUES
('Adams', '1001', 'Finance'),
('Baker', '1002', 'Finance'),
('Clarke', '1003', 'Marketing'),
('Dexter', '1004', 'Finance'),
('Early', '1005', 'Accounting'),
('Kanter', '1111', 'Finance'),
('Yates', '1112', 'Accounting'),
('Zofakis', '9999', 'MIS');

-- --------------------------------------------------------

--
-- Table structure for table `product_cost`
--

CREATE TABLE IF NOT EXISTS `product_cost` (
  `pc_desc` varchar(20) DEFAULT NULL,
  `pc_code` char(5) NOT NULL,
  `pc_type` varchar(10) NOT NULL,
  `pc_amount` int(11) NOT NULL,
  PRIMARY KEY (`pc_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product_cost`
--

INSERT INTO `product_cost` (`pc_desc`, `pc_code`, `pc_type`, `pc_amount`) VALUES
(NULL, '1001', 'Variable', 30000),
('Depreciation', '1002', 'Fixed', 20000),
('Salaries', '1003', 'Hybrid', 25000),
('Property taxes', '1004', 'Fixed', 38000),
('Direct labor', '1005', 'Variable', 69000),
('Direct materials', '1111', 'Variable', 50000),
('Factory rent', '1112', 'Fixed', 20000);

-- --------------------------------------------------------

--
-- Table structure for table `Project`
--

CREATE TABLE IF NOT EXISTS `Project` (
  `P_Name` varchar(20) DEFAULT NULL,
  `P_Number` varchar(6) NOT NULL,
  `P_Manager` varchar(6) DEFAULT NULL,
  `P_Act_Cost` int(11) DEFAULT NULL,
  `P_Exp_Cost` int(11) DEFAULT NULL,
  PRIMARY KEY (`P_Number`),
  KEY `P_Manager` (`P_Manager`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Project`
--

INSERT INTO `Project` (`P_Name`, `P_Number`, `P_Manager`, `P_Act_Cost`, `P_Exp_Cost`) VALUES
('New billing system', '23760', '1112', 1000, 10000),
('New office lease', '26511', '1112', 5000, 5000),
('Resolve bad debts', '26713', '1111', 2000, 1500),
('Common stock issue', '28765', '1001', 3000, 4000),
('Revise documentation', '34054', '1111', 100, 3000),
('New TV commercial', '85005', '1002', 10000, 8000),
('Entertain new client', '87108', '1112', 5000, 2000),
('New database', '99203', '1112', 2300, 800);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Project`
--
ALTER TABLE `Project`
  ADD CONSTRAINT `Project_ibfk_1` FOREIGN KEY (`P_Manager`) REFERENCES `Manager` (`Mg_Number`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
