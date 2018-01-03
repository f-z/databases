-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 02, 2016 at 02:39 PM
-- Server version: 5.5.53-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `al_Team1FPr2`
--

-- --------------------------------------------------------

--
-- Table structure for table `Client`
--

CREATE TABLE IF NOT EXISTS `Client` (
  `ClientID` int(11) NOT NULL,
  `Fname` varchar(20) NOT NULL,
  `MI` char(1) DEFAULT NULL,
  `Lname` varchar(20) NOT NULL,
  `Category` varchar(20) NOT NULL,
  `Phone` int(10) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `URL` varchar(20) DEFAULT NULL,
  `Street` varchar(20) NOT NULL,
  `City` varchar(20) NOT NULL,
  `State` varchar(20) NOT NULL,
  `Zip` int(11) NOT NULL,
  `Country` varchar(20) NOT NULL,
	
  PRIMARY KEY (`ClientID`),
  UNIQUE KEY `PartnerID` (`ClientID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `Employee`
--

CREATE TABLE IF NOT EXISTS `Employee` (
  `EmpID` int(11) NOT NULL,
  `FName` varchar(20) NOT NULL,
  `MI` char(1) NOT NULL,
  `LName` varchar(20) NOT NULL,
  `Phone` int(11) NOT NULL,
  `Email` varchar(25) NOT NULL,
  `Street` varchar(35) NOT NULL,
  `City` varchar(20) NOT NULL,
  `State` varchar(15) NOT NULL,
  `Country` varchar(25) NOT NULL,
  PRIMARY KEY (`EmpID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `InstallationSite`
--

CREATE TABLE IF NOT EXISTS `InstallationSite` (
  `SiteID` int(11) NOT NULL,
  `Street` varchar(50) NOT NULL,
  `City` varchar(25) NOT NULL,
  `State` varchar(10) NOT NULL,
  `Zip` int(11) NOT NULL,
  `Country` varchar(30) NOT NULL,
  PRIMARY KEY (`SiteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `OperationFacility`
--

CREATE TABLE IF NOT EXISTS `OperationFacility` (
  `FacID` int(11) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `Type` varchar(15) NOT NULL,
  `Capacity` int(11) NOT NULL,
  `Street` varchar(50) NOT NULL,
  `City` varchar(50) NOT NULL,
  `State` varchar(10) NOT NULL,
  `Zip` int(11) NOT NULL,
  `Country` varchar(25) NOT NULL,
  PRIMARY KEY (`FacID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE IF NOT EXISTS `Product` (
  `ProductID` int(11) NOT NULL,
  `Type` varchar(15) NOT NULL,
  `Name` varchar(25) NOT NULL,
  `Description` varchar(40) NOT NULL,
  `Price` decimal(6,2) NOT NULL,
  `Stock` int(11) NOT NULL,
  PRIMARY KEY (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ProductOrder`
--

CREATE TABLE IF NOT EXISTS `ProductOrder` (
  `LineNumber` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `OrderID` int(11) NOT NULL,
  PRIMARY KEY (`LineNumber`,`ProductID`,`OrderID`),
  KEY `ProductID` (`ProductID`),
  KEY `OrderID` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PurchaseOrder`
--

CREATE TABLE IF NOT EXISTS `PurchaseOrder` (
  `OrderID` int(11) NOT NULL,
  `ClientID` int(11) NOT NULL,
  `ProductID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `OrderDate` date NOT NULL,
  `OrderStatus` varchar(10) NOT NULL,
  `PaymentDate` date NOT NULL,
  PRIMARY KEY (`OrderID`),
  UNIQUE KEY `ClientID_3` (`ClientID`),
  KEY `ClientID` (`ClientID`),
  KEY `ClientID_2` (`ClientID`),
  KEY `ProductID` (`ProductID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Quote`
--

CREATE TABLE IF NOT EXISTS `Quote` (
  `OrderID` int(11) NOT NULL,
  `QuoteDate` date NOT NULL,
  PRIMARY KEY (`OrderID`,`QuoteDate`),
  KEY `OrderID` (`OrderID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Constraints for table `ProductOrder`
--
ALTER TABLE `ProductOrder`
  ADD CONSTRAINT `purchaseID3` FOREIGN KEY (`OrderID`) REFERENCES `PurchaseOrder` (`OrderID`),
  ADD CONSTRAINT `productID2` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`);

--
-- Constraints for table `PurchaseOrder`
--
ALTER TABLE `PurchaseOrder`
  ADD CONSTRAINT `Product` FOREIGN KEY (`ProductID`) REFERENCES `Product` (`ProductID`),
  ADD CONSTRAINT `ClientOrder` FOREIGN KEY (`ClientID`) REFERENCES `Client` (`ClientID`);

--
-- Constraints for table `Quote`
--
ALTER TABLE `Quote`
  ADD CONSTRAINT `purchaseorderid` FOREIGN KEY (`OrderID`) REFERENCES `PurchaseOrder` (`OrderID`);

ALTER TABLE `Client`
  ADD CONSTRAINT `referral` FOREIGN KEY (`ReferredBy`) REFERENCES `Client` (`ClientID`);

--
-- Dumping data for table `Client`
--

INSERT INTO `Client` (`ClientID`, `Fname`, `MI`, `Lname`, `Category`, `Phone`, `Email`, `URL`, `Street`, `City`, `State`, `Zip`, `Country`, `ReferredBy`) VALUES
(124765, 'John', 'T', 'Atkins', 'Residence', 1214564798, 'jtatkins@yahoo.com', NULL, '22 Cranapple Street', 'Lawrence', 'Kansas', 11024, 'United States’, NULL),
(125675, 'Jerry', 'T', 'Johnson', 'Residence', 2147483647, 'jjohns@gmail.com', NULL, '54 Lollipop Lane’, ‘Carver’, 'Oregon', 78951, 'United States', NULL), (325665, 'Pat', 'R', 'Kramer', 'Residence', 2147483647, 'patkramer@hotmail.com', NULL, '65 Bumblebee Lane', 'Prosperity', 'Nevada', 22813, 'United States', NULL),
(789578, 'Perry', 'R', 'Platypus', 'Residence', 2147483647, 'phinandferb@yahoo.com', NULL, '49 Appleseed Lane', 'Seattle', 'Washington', 65234, 'United States', NULL),
(778870, 'Paul', 'R', 'Pharton', 'Commercial', 2147483647, 'pphartnotblart@gmail.com', 'www.tekadvantage.com', '45 Cherry Lane', 'Palo Alto', 'California', 90210, 'United States', NULL),
(624554, ‘Portland’, NULL, ‘General Electric’, ‘Utility’, 8005428818, ‘support@portlandgeneral.com’, ‘portlandgeneral.com’, ’121 SW Salmon Street’, ‘Portland’, ‘Oregon’, 97204, 'United States’, NULL),
(445953, 'Yugi', 'E', 'Moto', 'Commercial', 2147483647, 'heartofthecards@stanford.edu', 'www.cardblitz.net', '99 Chandler Drive', 'Springfield', 'California', 78956, 'United States’, 624554),
(607768, ‘Rochester’, NULL, ‘Public Utilities’, ‘Utility’, 5072801500, ‘mallard@rpu.org’, rpu.org’, ‘4000 E River Rd NE’, ‘Rochester’, ‘Minnesota’, 55906, ‘United States’, NULL),
(454768, ‘John’, ‘A’, ‘Doe’, 'Residence', 5095847299, ‘jadoe@gmail.com', NULL, ’44 South Street', ‘Burlington’, ‘Vermont’, 05009, 'United States', 607768),
(867994, ‘Bob’, ‘C’, ‘Dole’, 'Residence', 8563858009, ‘bobcdole@gmail.com', NULL, ’132 Crescent Park', ‘Concord’, ‘New Hampshire’, 03033, 'United States’, NULL),
(427832, ‘Cynthia’, ‘B’, ‘Lee’, 'Residence', 5938596818, ‘clee@live.com', NULL, ’56 Richmond Street’, ‘Boston’, ‘Massachusetts’, 02115, 'United States’, NULL),
(422393, ‘Claudia’, ‘L’, ‘Scaroni’, 'Residence', 6895847894, ‘cl.saroni@hotmail.com', NULL, ’73 North Lane’, ‘Providence’, ‘Rhode Island’, 02904, 'United States’, NULL);
-- --------------------------------------------------------


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
