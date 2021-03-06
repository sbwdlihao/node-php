
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `db`
--

-- --------------------------------------------------------

--
-- Table structure for table `blockIndex`
--

CREATE TABLE IF NOT EXISTS `blockIndex` (
  `id` int(9) NOT NULL,
  `hash` varchar(64) NOT NULL,
  `flags` int(32) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=63523 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `block_transactions`
--

CREATE TABLE IF NOT EXISTS `block_transactions` (
  `id` int(11) NOT NULL,
  `block_hash` varchar(64) NOT NULL,
  `transaction_hash` varchar(64) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=71382 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `headerIndex`
--

CREATE TABLE IF NOT EXISTS `headerIndex` (
  `height` bigint(20) NOT NULL,
  `work` varchar(64) NOT NULL,
  `id` int(9) NOT NULL,
  `version` varchar(20) NOT NULL,
  `prevBlock` varchar(64) NOT NULL,
  `merkleRoot` varchar(64) NOT NULL,
  `nBits` varchar(11) NOT NULL,
  `nTimestamp` varchar(11) NOT NULL,
  `nNonce` varchar(11) NOT NULL,
  `hash` varchar(64) NOT NULL,
  `lft` int(9) NOT NULL,
  `rgt` int(9) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=379020 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(9) NOT NULL,
  `hash` varchar(64) NOT NULL,
  `transaction` text NOT NULL,
  `nOut` int(9) NOT NULL,
  `valueOut` bigint(32) NOT NULL,
  `valueFee` bigint(32) NOT NULL,
  `version` int(11) NOT NULL,
  `nLockTime` int(11) NOT NULL,
  `isCoinbase` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=71382 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_input`
--

CREATE TABLE IF NOT EXISTS `transaction_input` (
  `id` int(9) NOT NULL,
  `hashPrevOut` varchar(64) CHARACTER SET utf8 NOT NULL,
  `nPrevOut` int(32) NOT NULL,
  `scriptSig` blob NOT NULL,
  `nSequence` int(15) NOT NULL,
  `parent_tx` varchar(64) CHARACTER SET utf8 NOT NULL,
  `nInput` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=90008 DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_output`
--

CREATE TABLE IF NOT EXISTS `transaction_output` (
  `id` int(9) NOT NULL,
  `value` bigint(21) NOT NULL,
  `scriptPubKey` blob NOT NULL,
  `parent_tx` varchar(64) CHARACTER SET utf8mb4 NOT NULL,
  `nOutput` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=75452 DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blockIndex`
--
ALTER TABLE `blockIndex`
ADD PRIMARY KEY (`id`), ADD UNIQUE KEY `hash_2` (`hash`);

--
-- Indexes for table `block_transactions`
--
ALTER TABLE `block_transactions`
ADD PRIMARY KEY (`id`), ADD KEY `idx` (`block_hash`,`transaction_hash`);

--
-- Indexes for table `headerIndex`
--
ALTER TABLE `headerIndex`
ADD PRIMARY KEY (`id`), ADD KEY `coord` (`lft`,`rgt`,`hash`), ADD KEY `hash` (`hash`), ADD KEY `prevBlock` (`prevBlock`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
ADD PRIMARY KEY (`id`), ADD KEY `hash` (`hash`);

--
-- Indexes for table `transaction_input`
--
ALTER TABLE `transaction_input`
ADD PRIMARY KEY (`id`), ADD KEY `parent_tx` (`parent_tx`), ADD KEY `prevout` (`hashPrevOut`,`nPrevOut`);

--
-- Indexes for table `transaction_output`
--
ALTER TABLE `transaction_output`
ADD PRIMARY KEY (`id`), ADD KEY `parent_tx` (`parent_tx`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `blockIndex`
--
ALTER TABLE `blockIndex`
MODIFY `id` int(9) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=63523;
--
-- AUTO_INCREMENT for table `block_transactions`
--
ALTER TABLE `block_transactions`
MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=71382;
--
-- AUTO_INCREMENT for table `headerIndex`
--
ALTER TABLE `headerIndex`
MODIFY `id` int(9) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=379020;
--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
MODIFY `id` int(9) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=71382;
--
-- AUTO_INCREMENT for table `transaction_input`
--
ALTER TABLE `transaction_input`
MODIFY `id` int(9) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=90008;
--
-- AUTO_INCREMENT for table `transaction_output`
--
ALTER TABLE `transaction_output`
MODIFY `id` int(9) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=75452;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;