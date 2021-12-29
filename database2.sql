-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 29, 2021 at 10:32 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `database2`
--

-- --------------------------------------------------------

--
-- Table structure for table `agent_login`
--

CREATE TABLE `agent_login` (
  `aid` int(10) NOT NULL,
  `aname` varchar(20) NOT NULL,
  `a_email` varchar(20) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `agent_work`
--

CREATE TABLE `agent_work` (
  `agent_work_id` int(10) NOT NULL,
  `aid` int(10) NOT NULL,
  `eid` int(10) NOT NULL,
  `complaintid` int(10) NOT NULL,
  `work_status` enum('Assigned','Closed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `complaints`
--

CREATE TABLE `complaints` (
  `complaintid` int(10) NOT NULL,
  `uid` int(10) NOT NULL,
  `complaintdate` date NOT NULL,
  `complaint` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employee_login`
--

CREATE TABLE `employee_login` (
  `eid` int(10) NOT NULL,
  `ename` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `employee_work`
--

CREATE TABLE `employee_work` (
  `workid` int(10) NOT NULL,
  `eid` int(11) DEFAULT NULL,
  `complaintid` int(11) DEFAULT NULL,
  `complaint_status` enum('completed','inprogress','stuck') NOT NULL,
  `reply` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `uid` int(10) NOT NULL,
  `uname` varchar(20) NOT NULL,
  `email` varchar(20) NOT NULL,
  `password` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `agent_login`
--
ALTER TABLE `agent_login`
  ADD PRIMARY KEY (`aid`),
  ADD UNIQUE KEY `aname` (`aname`);

--
-- Indexes for table `agent_work`
--
ALTER TABLE `agent_work`
  ADD PRIMARY KEY (`agent_work_id`),
  ADD KEY `complaintid` (`complaintid`),
  ADD KEY `aid` (`aid`),
  ADD KEY `eid` (`eid`);

--
-- Indexes for table `complaints`
--
ALTER TABLE `complaints`
  ADD PRIMARY KEY (`complaintid`);

--
-- Indexes for table `employee_login`
--
ALTER TABLE `employee_login`
  ADD PRIMARY KEY (`eid`),
  ADD UNIQUE KEY `ename` (`ename`);

--
-- Indexes for table `employee_work`
--
ALTER TABLE `employee_work`
  ADD PRIMARY KEY (`workid`),
  ADD KEY `indx` (`eid`,`complaintid`),
  ADD KEY `complaintid` (`complaintid`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`uid`),
  ADD UNIQUE KEY `uname` (`uname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `agent_login`
--
ALTER TABLE `agent_login`
  MODIFY `aid` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agent_work`
--
ALTER TABLE `agent_work`
  MODIFY `agent_work_id` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `complaints`
--
ALTER TABLE `complaints`
  MODIFY `complaintid` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_login`
--
ALTER TABLE `employee_login`
  MODIFY `eid` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `employee_work`
--
ALTER TABLE `employee_work`
  MODIFY `workid` int(10) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_details`
--
ALTER TABLE `user_details`
  MODIFY `uid` int(10) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `agent_work`
--
ALTER TABLE `agent_work`
  ADD CONSTRAINT `agent_work_ibfk_1` FOREIGN KEY (`complaintid`) REFERENCES `complaints` (`complaintid`),
  ADD CONSTRAINT `agent_work_ibfk_2` FOREIGN KEY (`aid`) REFERENCES `agent_login` (`aid`),
  ADD CONSTRAINT `agent_work_ibfk_3` FOREIGN KEY (`eid`) REFERENCES `employee_login` (`eid`);

--
-- Constraints for table `complaints`
--
ALTER TABLE `complaints`
  ADD CONSTRAINT `complaints_ibfk_1` FOREIGN KEY (`complaintid`) REFERENCES `user_details` (`uid`);

--
-- Constraints for table `employee_work`
--
ALTER TABLE `employee_work`
  ADD CONSTRAINT `employee_work_ibfk_1` FOREIGN KEY (`complaintid`) REFERENCES `complaints` (`complaintid`),
  ADD CONSTRAINT `employee_work_ibfk_2` FOREIGN KEY (`eid`) REFERENCES `employee_login` (`eid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
