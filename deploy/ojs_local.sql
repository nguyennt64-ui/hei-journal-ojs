-- Current Database: `ojs_local`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ojs_local` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `ojs_local`;

--
-- Table structure for table `access_keys`
--

DROP TABLE IF EXISTS `access_keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `access_keys` (
  `access_key_id` bigint NOT NULL AUTO_INCREMENT,
  `context` varchar(40) NOT NULL,
  `key_hash` varchar(40) NOT NULL,
  `user_id` bigint NOT NULL,
  `assoc_id` bigint DEFAULT NULL,
  `expiry_date` datetime NOT NULL,
  PRIMARY KEY (`access_key_id`),
  KEY `access_keys_user_id` (`user_id`),
  KEY `access_keys_hash` (`key_hash`,`user_id`,`context`),
  CONSTRAINT `access_keys_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Access keys are used to provide pseudo-login functionality for security-minimal tasks. Passkeys can be emailed directly to users, who can use them for a limited time in lieu of standard username and password.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `access_keys`
--

LOCK TABLES `access_keys` WRITE;
/*!40000 ALTER TABLE `access_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `access_keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_settings`
--

DROP TABLE IF EXISTS `announcement_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement_settings` (
  `announcement_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `announcement_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`announcement_setting_id`),
  UNIQUE KEY `announcement_settings_unique` (`announcement_id`,`locale`,`setting_name`),
  KEY `announcement_settings_announcement_id` (`announcement_id`),
  CONSTRAINT `announcement_settings_announcement_id_foreign` FOREIGN KEY (`announcement_id`) REFERENCES `announcements` (`announcement_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about announcements, including localized properties like names and contents.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_settings`
--

LOCK TABLES `announcement_settings` WRITE;
/*!40000 ALTER TABLE `announcement_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_type_settings`
--

DROP TABLE IF EXISTS `announcement_type_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement_type_settings` (
  `announcement_type_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`announcement_type_setting_id`),
  UNIQUE KEY `announcement_type_settings_unique` (`type_id`,`locale`,`setting_name`),
  KEY `announcement_type_settings_type_id` (`type_id`),
  CONSTRAINT `announcement_type_settings_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `announcement_types` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about announcement types, including localized properties like their names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_type_settings`
--

LOCK TABLES `announcement_type_settings` WRITE;
/*!40000 ALTER TABLE `announcement_type_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_type_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcement_types`
--

DROP TABLE IF EXISTS `announcement_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcement_types` (
  `type_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  PRIMARY KEY (`type_id`),
  KEY `announcement_types_context_id` (`context_id`),
  CONSTRAINT `announcement_types_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Announcement types allow for announcements to optionally be categorized.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcement_types`
--

LOCK TABLES `announcement_types` WRITE;
/*!40000 ALTER TABLE `announcement_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcement_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcements`
--

DROP TABLE IF EXISTS `announcements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcements` (
  `announcement_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` smallint DEFAULT NULL,
  `assoc_id` bigint NOT NULL,
  `type_id` bigint DEFAULT NULL,
  `date_expire` date DEFAULT NULL,
  `date_posted` datetime NOT NULL,
  PRIMARY KEY (`announcement_id`),
  KEY `announcements_type_id` (`type_id`),
  KEY `announcements_assoc` (`assoc_type`,`assoc_id`),
  CONSTRAINT `announcements_type_id_foreign` FOREIGN KEY (`type_id`) REFERENCES `announcement_types` (`type_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Announcements are messages that can be presented to users e.g. on the homepage.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcements`
--

LOCK TABLES `announcements` WRITE;
/*!40000 ALTER TABLE `announcements` DISABLE KEYS */;
/*!40000 ALTER TABLE `announcements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author_settings`
--

DROP TABLE IF EXISTS `author_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author_settings` (
  `author_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `author_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`author_setting_id`),
  UNIQUE KEY `author_settings_unique` (`author_id`,`locale`,`setting_name`),
  KEY `author_settings_author_id` (`author_id`),
  CONSTRAINT `author_settings_author_id` FOREIGN KEY (`author_id`) REFERENCES `authors` (`author_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COMMENT='More data about authors, including localized properties such as their name and affiliation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author_settings`
--

LOCK TABLES `author_settings` WRITE;
/*!40000 ALTER TABLE `author_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `author_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authors`
--

DROP TABLE IF EXISTS `authors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authors` (
  `author_id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(90) NOT NULL,
  `include_in_browse` smallint NOT NULL DEFAULT '1',
  `publication_id` bigint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `user_group_id` bigint DEFAULT NULL,
  PRIMARY KEY (`author_id`),
  KEY `authors_user_group_id` (`user_group_id`),
  KEY `authors_publication_id` (`publication_id`),
  CONSTRAINT `authors_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE,
  CONSTRAINT `authors_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='The authors of a publication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authors`
--

LOCK TABLES `authors` WRITE;
/*!40000 ALTER TABLE `authors` DISABLE KEYS */;
/*!40000 ALTER TABLE `authors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `category_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `seq` bigint DEFAULT NULL,
  `path` varchar(255) NOT NULL,
  `image` text,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `category_path` (`context_id`,`path`),
  KEY `category_context_id` (`context_id`),
  KEY `category_context_parent_id` (`context_id`,`parent_id`),
  KEY `category_parent_id` (`parent_id`),
  CONSTRAINT `categories_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`category_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='Categories permit the organization of submissions into a heirarchical structure.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,1,NULL,2,'education_leadership_management',NULL),(2,1,NULL,4,'educational_philosophies',NULL),(3,1,NULL,5,'english_teaching_learning',NULL),(4,1,NULL,1,'educational_mobilities',NULL),(5,1,NULL,3,'professional_development',NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_settings`
--

DROP TABLE IF EXISTS `category_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_settings` (
  `category_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`category_setting_id`),
  UNIQUE KEY `category_settings_unique` (`category_id`,`locale`,`setting_name`),
  KEY `category_settings_category_id` (`category_id`),
  CONSTRAINT `category_settings_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb3 COMMENT='More data about categories, including localized properties such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_settings`
--

LOCK TABLES `category_settings` WRITE;
/*!40000 ALTER TABLE `category_settings` DISABLE KEYS */;
INSERT INTO `category_settings` VALUES (1,1,'','sortOption','title-ASC'),(2,1,'en','title','Educational Leadership and Management'),(3,1,'en','description',''),(4,2,'','sortOption','title-ASC'),(5,2,'en','title','Theory and practice in educational philosophies'),(6,2,'en','description',''),(7,3,'','sortOption','title-ASC'),(8,3,'en','title','English language teaching and learning, and educational technologies'),(9,3,'en','description',''),(10,4,'','sortOption','title-ASC'),(11,4,'en','title','Educational mobilities'),(12,4,'en','description',''),(13,5,'','sortOption','title-ASC'),(14,5,'en','title','Foreign language professional development'),(15,5,'en','description','');
/*!40000 ALTER TABLE `category_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citation_settings`
--

DROP TABLE IF EXISTS `citation_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citation_settings` (
  `citation_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `citation_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`citation_setting_id`),
  UNIQUE KEY `citation_settings_unique` (`citation_id`,`locale`,`setting_name`),
  KEY `citation_settings_citation_id` (`citation_id`),
  CONSTRAINT `citation_settings_citation_id` FOREIGN KEY (`citation_id`) REFERENCES `citations` (`citation_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Additional data about citations, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citation_settings`
--

LOCK TABLES `citation_settings` WRITE;
/*!40000 ALTER TABLE `citation_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `citation_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `citations`
--

DROP TABLE IF EXISTS `citations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `citations` (
  `citation_id` bigint NOT NULL AUTO_INCREMENT,
  `publication_id` bigint NOT NULL,
  `raw_citation` text NOT NULL,
  `seq` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`citation_id`),
  UNIQUE KEY `citations_publication_seq` (`publication_id`,`seq`),
  KEY `citations_publication` (`publication_id`),
  CONSTRAINT `citations_publication` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A citation made by an associated publication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `citations`
--

LOCK TABLES `citations` WRITE;
/*!40000 ALTER TABLE `citations` DISABLE KEYS */;
/*!40000 ALTER TABLE `citations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `completed_payments`
--

DROP TABLE IF EXISTS `completed_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `completed_payments` (
  `completed_payment_id` bigint NOT NULL AUTO_INCREMENT,
  `timestamp` datetime NOT NULL,
  `payment_type` bigint NOT NULL,
  `context_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `assoc_id` bigint DEFAULT NULL,
  `amount` double(8,2) NOT NULL,
  `currency_code_alpha` varchar(3) DEFAULT NULL,
  `payment_method_plugin_name` varchar(80) DEFAULT NULL,
  PRIMARY KEY (`completed_payment_id`),
  KEY `completed_payments_context_id` (`context_id`),
  KEY `completed_payments_user_id` (`user_id`),
  CONSTRAINT `completed_payments_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `completed_payments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of completed (fulfilled) payments relating to a payment type such as a subscription payment.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `completed_payments`
--

LOCK TABLES `completed_payments` WRITE;
/*!40000 ALTER TABLE `completed_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `completed_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controlled_vocab_entries`
--

DROP TABLE IF EXISTS `controlled_vocab_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controlled_vocab_entries` (
  `controlled_vocab_entry_id` bigint NOT NULL AUTO_INCREMENT,
  `controlled_vocab_id` bigint NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  PRIMARY KEY (`controlled_vocab_entry_id`),
  KEY `controlled_vocab_entries_controlled_vocab_id` (`controlled_vocab_id`),
  KEY `controlled_vocab_entries_cv_id` (`controlled_vocab_id`,`seq`),
  CONSTRAINT `controlled_vocab_entries_controlled_vocab_id_foreign` FOREIGN KEY (`controlled_vocab_id`) REFERENCES `controlled_vocabs` (`controlled_vocab_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The order that a word or phrase used in a controlled vocabulary should appear. For example, the order of keywords in a publication.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controlled_vocab_entries`
--

LOCK TABLES `controlled_vocab_entries` WRITE;
/*!40000 ALTER TABLE `controlled_vocab_entries` DISABLE KEYS */;
/*!40000 ALTER TABLE `controlled_vocab_entries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controlled_vocab_entry_settings`
--

DROP TABLE IF EXISTS `controlled_vocab_entry_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controlled_vocab_entry_settings` (
  `controlled_vocab_entry_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `controlled_vocab_entry_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`controlled_vocab_entry_setting_id`),
  UNIQUE KEY `c_v_e_s_pkey` (`controlled_vocab_entry_id`,`locale`,`setting_name`),
  KEY `c_v_e_s_entry_id` (`controlled_vocab_entry_id`),
  CONSTRAINT `c_v_e_s_entry_id` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entries` (`controlled_vocab_entry_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about a controlled vocabulary entry, including localized properties such as the actual word or phrase.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controlled_vocab_entry_settings`
--

LOCK TABLES `controlled_vocab_entry_settings` WRITE;
/*!40000 ALTER TABLE `controlled_vocab_entry_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `controlled_vocab_entry_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `controlled_vocabs`
--

DROP TABLE IF EXISTS `controlled_vocabs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `controlled_vocabs` (
  `controlled_vocab_id` bigint NOT NULL AUTO_INCREMENT,
  `symbolic` varchar(64) NOT NULL,
  `assoc_type` bigint NOT NULL DEFAULT '0',
  `assoc_id` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`controlled_vocab_id`),
  UNIQUE KEY `controlled_vocab_symbolic` (`symbolic`,`assoc_type`,`assoc_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Every word or phrase used in a controlled vocabulary. Controlled vocabularies are used for submission metadata like keywords and subjects, reviewer interests, and wherever a similar dictionary of words or phrases is required. Each entry corresponds to a word or phrase like "cellular reproduction" and a type like "submissionKeyword".';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `controlled_vocabs`
--

LOCK TABLES `controlled_vocabs` WRITE;
/*!40000 ALTER TABLE `controlled_vocabs` DISABLE KEYS */;
INSERT INTO `controlled_vocabs` VALUES (1,'interest',0,0),(6,'submissionAgency',1048588,1),(4,'submissionDiscipline',1048588,1),(2,'submissionKeyword',1048588,1),(5,'submissionLanguage',1048588,1),(3,'submissionSubject',1048588,1);
/*!40000 ALTER TABLE `controlled_vocabs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_issue_orders`
--

DROP TABLE IF EXISTS `custom_issue_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_issue_orders` (
  `custom_issue_order_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `journal_id` bigint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`custom_issue_order_id`),
  UNIQUE KEY `custom_issue_orders_unique` (`issue_id`),
  KEY `custom_issue_orders_issue_id` (`issue_id`),
  KEY `custom_issue_orders_journal_id` (`journal_id`),
  CONSTRAINT `custom_issue_orders_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  CONSTRAINT `custom_issue_orders_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Ordering information for the issue list, when custom issue ordering is specified.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_issue_orders`
--

LOCK TABLES `custom_issue_orders` WRITE;
/*!40000 ALTER TABLE `custom_issue_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_issue_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `custom_section_orders`
--

DROP TABLE IF EXISTS `custom_section_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `custom_section_orders` (
  `custom_section_order_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `section_id` bigint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`custom_section_order_id`),
  UNIQUE KEY `custom_section_orders_unique` (`issue_id`,`section_id`),
  KEY `custom_section_orders_issue_id` (`issue_id`),
  KEY `custom_section_orders_section_id` (`section_id`),
  CONSTRAINT `custom_section_orders_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  CONSTRAINT `custom_section_orders_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Ordering information for sections within issues, when issue-specific section ordering is specified.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `custom_section_orders`
--

LOCK TABLES `custom_section_orders` WRITE;
/*!40000 ALTER TABLE `custom_section_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `custom_section_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_object_tombstone_oai_set_objects`
--

DROP TABLE IF EXISTS `data_object_tombstone_oai_set_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_object_tombstone_oai_set_objects` (
  `object_id` bigint NOT NULL AUTO_INCREMENT,
  `tombstone_id` bigint NOT NULL,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  PRIMARY KEY (`object_id`),
  KEY `data_object_tombstone_oai_set_objects_tombstone_id` (`tombstone_id`),
  CONSTRAINT `data_object_tombstone_oai_set_objects_tombstone_id` FOREIGN KEY (`tombstone_id`) REFERENCES `data_object_tombstones` (`tombstone_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between tombstones and other data that can be collected in OAI sets, e.g. sections.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_object_tombstone_oai_set_objects`
--

LOCK TABLES `data_object_tombstone_oai_set_objects` WRITE;
/*!40000 ALTER TABLE `data_object_tombstone_oai_set_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_object_tombstone_oai_set_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_object_tombstone_settings`
--

DROP TABLE IF EXISTS `data_object_tombstone_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_object_tombstone_settings` (
  `tombstone_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tombstone_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`tombstone_setting_id`),
  UNIQUE KEY `data_object_tombstone_settings_unique` (`tombstone_id`,`locale`,`setting_name`),
  KEY `data_object_tombstone_settings_tombstone_id` (`tombstone_id`),
  CONSTRAINT `data_object_tombstone_settings_tombstone_id` FOREIGN KEY (`tombstone_id`) REFERENCES `data_object_tombstones` (`tombstone_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about data object tombstones, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_object_tombstone_settings`
--

LOCK TABLES `data_object_tombstone_settings` WRITE;
/*!40000 ALTER TABLE `data_object_tombstone_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_object_tombstone_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `data_object_tombstones`
--

DROP TABLE IF EXISTS `data_object_tombstones`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_object_tombstones` (
  `tombstone_id` bigint NOT NULL AUTO_INCREMENT,
  `data_object_id` bigint NOT NULL,
  `date_deleted` datetime NOT NULL,
  `set_spec` varchar(255) NOT NULL,
  `set_name` varchar(255) NOT NULL,
  `oai_identifier` varchar(255) NOT NULL,
  PRIMARY KEY (`tombstone_id`),
  KEY `data_object_tombstones_data_object_id` (`data_object_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Entries for published data that has been removed. Usually used in the OAI endpoint.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_object_tombstones`
--

LOCK TABLES `data_object_tombstones` WRITE;
/*!40000 ALTER TABLE `data_object_tombstones` DISABLE KEYS */;
/*!40000 ALTER TABLE `data_object_tombstones` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doi_settings`
--

DROP TABLE IF EXISTS `doi_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doi_settings` (
  `doi_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `doi_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`doi_setting_id`),
  UNIQUE KEY `doi_settings_unique` (`doi_id`,`locale`,`setting_name`),
  KEY `doi_settings_doi_id` (`doi_id`),
  CONSTRAINT `doi_settings_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about DOIs, including the registration agency.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doi_settings`
--

LOCK TABLES `doi_settings` WRITE;
/*!40000 ALTER TABLE `doi_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `doi_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dois`
--

DROP TABLE IF EXISTS `dois`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dois` (
  `doi_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `doi` varchar(255) NOT NULL,
  `status` smallint NOT NULL DEFAULT '1',
  PRIMARY KEY (`doi_id`),
  KEY `dois_context_id` (`context_id`),
  CONSTRAINT `dois_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Stores all DOIs used in the system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dois`
--

LOCK TABLES `dois` WRITE;
/*!40000 ALTER TABLE `dois` DISABLE KEYS */;
/*!40000 ALTER TABLE `dois` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `edit_decisions`
--

DROP TABLE IF EXISTS `edit_decisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `edit_decisions` (
  `edit_decision_id` bigint NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `review_round_id` bigint DEFAULT NULL,
  `stage_id` bigint DEFAULT NULL,
  `round` smallint DEFAULT NULL,
  `editor_id` bigint NOT NULL,
  `decision` smallint NOT NULL COMMENT 'A numeric constant indicating the decision that was taken. Possible values are listed in the Decision class.',
  `date_decided` datetime NOT NULL,
  PRIMARY KEY (`edit_decision_id`),
  KEY `edit_decisions_submission_id` (`submission_id`),
  KEY `edit_decisions_editor_id` (`editor_id`),
  KEY `edit_decisions_review_round_id` (`review_round_id`),
  CONSTRAINT `edit_decisions_editor_id` FOREIGN KEY (`editor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `edit_decisions_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`) ON DELETE CASCADE,
  CONSTRAINT `edit_decisions_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Editorial decisions recorded on a submission, such as decisions to accept or decline the submission, as well as decisions to send for review, send to copyediting, request revisions, and more.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `edit_decisions`
--

LOCK TABLES `edit_decisions` WRITE;
/*!40000 ALTER TABLE `edit_decisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `edit_decisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_log`
--

DROP TABLE IF EXISTS `email_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `sender_id` bigint NOT NULL,
  `date_sent` datetime NOT NULL,
  `event_type` bigint DEFAULT NULL,
  `from_address` varchar(255) DEFAULT NULL,
  `recipients` text,
  `cc_recipients` text,
  `bcc_recipients` text,
  `subject` varchar(255) DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`log_id`),
  KEY `email_log_assoc` (`assoc_type`,`assoc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A record of email messages that are sent in relation to an associated entity, such as a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log`
--

LOCK TABLES `email_log` WRITE;
/*!40000 ALTER TABLE `email_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_log_users`
--

DROP TABLE IF EXISTS `email_log_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_log_users` (
  `email_log_user_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email_log_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`email_log_user_id`),
  UNIQUE KEY `email_log_user_id` (`email_log_id`,`user_id`),
  KEY `email_log_users_email_log_id` (`email_log_id`),
  KEY `email_log_users_user_id` (`user_id`),
  CONSTRAINT `email_log_users_email_log_id_foreign` FOREIGN KEY (`email_log_id`) REFERENCES `email_log` (`log_id`) ON DELETE CASCADE,
  CONSTRAINT `email_log_users_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A record of users associated with an email log entry.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_log_users`
--

LOCK TABLES `email_log_users` WRITE;
/*!40000 ALTER TABLE `email_log_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_log_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates`
--

DROP TABLE IF EXISTS `email_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates` (
  `email_id` bigint NOT NULL AUTO_INCREMENT,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `context_id` bigint NOT NULL,
  `alternate_to` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`email_id`),
  UNIQUE KEY `email_templates_email_key` (`email_key`,`context_id`),
  KEY `email_templates_context_id` (`context_id`),
  KEY `email_templates_alternate_to` (`alternate_to`),
  CONSTRAINT `email_templates_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb3 COMMENT='Custom email templates created by each context, and overrides of the default templates.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates`
--

LOCK TABLES `email_templates` WRITE;
/*!40000 ALTER TABLE `email_templates` DISABLE KEYS */;
INSERT INTO `email_templates` VALUES (1,'COPYEDIT_REQUEST',1,'DISCUSSION_NOTIFICATION_COPYEDITING'),(2,'EDITOR_ASSIGN_SUBMISSION',1,'DISCUSSION_NOTIFICATION_SUBMISSION'),(3,'EDITOR_ASSIGN_REVIEW',1,'DISCUSSION_NOTIFICATION_REVIEW'),(4,'EDITOR_ASSIGN_PRODUCTION',1,'DISCUSSION_NOTIFICATION_PRODUCTION'),(5,'LAYOUT_REQUEST',1,'DISCUSSION_NOTIFICATION_PRODUCTION'),(6,'LAYOUT_COMPLETE',1,'DISCUSSION_NOTIFICATION_PRODUCTION');
/*!40000 ALTER TABLE `email_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates_default_data`
--

DROP TABLE IF EXISTS `email_templates_default_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates_default_data` (
  `email_templates_default_data_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email_key` varchar(255) NOT NULL COMMENT 'Unique identifier for this email.',
  `locale` varchar(14) NOT NULL DEFAULT 'en',
  `name` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `body` text,
  PRIMARY KEY (`email_templates_default_data_id`),
  UNIQUE KEY `email_templates_default_data_unique` (`email_key`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=139 DEFAULT CHARSET=utf8mb3 COMMENT='Default email templates created for every installed locale.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates_default_data`
--

LOCK TABLES `email_templates_default_data` WRITE;
/*!40000 ALTER TABLE `email_templates_default_data` DISABLE KEYS */;
INSERT INTO `email_templates_default_data` VALUES (1,'PASSWORD_RESET_CONFIRM','en','Password Reset Confirm','Password Reset Confirmation','We have received a request to reset your password for the {$siteTitle} web site.<br />\n<br />\nIf you did not make this request, please ignore this email and your password will not be changed. If you wish to reset your password, click on the below URL.<br />\n<br />\nReset my password: {$passwordResetUrl}<br />\n<br />\n{$siteContactName}'),(2,'PASSWORD_RESET_CONFIRM','vi','','XÃ¡c nháº­n Ä‘áº·t láº¡i máº­t kháº©u','ChÃºng tÃ´i Ä‘Ã£ nháº­n Ä‘Æ°á»£c yÃªu cáº§u Ä‘áº·t láº¡i máº­t kháº©u cá»§a báº¡n cho {$siteTitle}.<br />\n<br />\nNáº¿u báº¡n khÃ´ng thá»±c hiá»‡n yÃªu cáº§u nÃ y, vui lÃ²ng bá» qua email nÃ y vÃ  máº­t kháº©u cá»§a báº¡n sáº½ khÃ´ng bá»‹ thay Ä‘á»•i. Náº¿u báº¡n muá»‘n Ä‘áº·t láº¡i máº­t kháº©u cá»§a mÃ¬nh, nháº¥p vÃ o URL bÃªn dÆ°á»›i.<br />\n<br />\nÄáº·t láº¡i máº­t kháº©u cá»§a tÃ´i: {$passwordResetUrl}<br />\n<br />\n{$siteContactName}'),(3,'USER_REGISTER','en','User Created','Journal Registration','{$recipientName}<br />\n<br />\nYou have now been registered as a user with {$journalName}. We have included your username and password in this email, which are needed for all work with this journal through its website. At any point, you can ask to be removed from the journal\'s list of users by contacting me.<br />\n<br />\nUsername: {$recipientUsername}<br />\nPassword: {$password}<br />\n<br />\nThank you,<br />\n{$signature}'),(4,'USER_REGISTER','vi','','ÄÄƒng kÃ½ táº¡p chÃ­','{$recipientName}<br />\n<br />\nBÃ¢y giá» báº¡n Ä‘Ã£ Ä‘Æ°á»£c Ä‘Äƒng kÃ½ lÃ  ngÆ°á»i dÃ¹ng vá»›i {$journalName}. ChÃºng tÃ´i Ä‘Ã£ gá»­i bao gá»“m tÃªn ngÆ°á»i dÃ¹ng vÃ  máº­t kháº©u cá»§a báº¡n trong email nÃ y, Ä‘iá»u nÃ y lÃ  cáº§n thiáº¿t cho táº¥t cáº£ cÃ¡c cÃ´ng viá»‡c vá»›i táº¡p chÃ­ nÃ y thÃ´ng qua trang web. Táº¡i báº¥t ká»³ thá»i Ä‘iá»ƒm nÃ o, báº¡n cÃ³ thá»ƒ yÃªu cáº§u xÃ³a khá»i danh sÃ¡ch ngÆ°á»i dÃ¹ng cá»§a táº¡p chÃ­ báº±ng cÃ¡ch liÃªn há»‡ vá»›i chÃºng tÃ´i.<br />\n<br />\nUsername: {$recipientUsername}<br />\nPassword: {$password}<br />\n<br />\nTrÃ¢n trá»ng,<br />\n{$signature}'),(5,'USER_VALIDATE_CONTEXT','en','Validate Email (Journal Registration)','Validate Your Account','{$recipientName}<br />\n<br />\nYou have created an account with {$journalName}, but before you can start using it, you need to validate your email account. To do this, simply follow the link below:<br />\n<br />\n{$activateUrl}<br />\n<br />\nThank you,<br />\n{$journalSignature}'),(6,'USER_VALIDATE_CONTEXT','vi','XÃ¡c nháº­n email (Ä‘Äƒng kÃ½ táº¡p chÃ­)','XÃ¡c thá»±c tÃ i khoáº£n cá»§a báº¡n','{$recipientName}<br />\n<br />\nBáº¡n Ä‘Ã£ táº¡o má»™t tÃ i khoáº£n vá»›i {$journalName}, nhÆ°ng trÆ°á»›c khi báº¡n cÃ³ thá»ƒ báº¯t Ä‘áº§u sá»­ dá»¥ng nÃ³, báº¡n cáº§n xÃ¡c thá»±c tÃ i khoáº£n email cá»§a mÃ¬nh. Äá»ƒ lÃ m Ä‘iá»u nÃ y, chá»‰ cáº§n truy cáº­p liÃªn káº¿t dÆ°á»›i Ä‘Ã¢y:<br />\n<br />\n{$activateUrl}<br />\n<br />\nTrÃ¢n trá»ng,<br />\n{$journalSignature}'),(7,'USER_VALIDATE_SITE','en','Validate Email (Site)','Validate Your Account','{$recipientName}<br />\n<br />\nYou have created an account with {$siteTitle}, but before you can start using it, you need to validate your email account. To do this, simply follow the link below:<br />\n<br />\n{$activateUrl}<br />\n<br />\nThank you,<br />\n{$siteSignature}'),(8,'USER_VALIDATE_SITE','vi','','Kiá»ƒm tra tÃ i khoáº£n cá»§a báº¡n','{$recipientName}<br />\n<br />\nBáº¡n Ä‘Ã£ táº¡o 1 tÃ i khoáº£n vá»›i {$siteTitle}, nhÆ°ng trÆ°á»›c khi báº¯t Ä‘áº§u sá»­ dá»¥ng, báº¡n cáº§n pháº£i xÃ¡c nháº­n email. Äá»ƒ xÃ¡c nháº­n, hÃ£y click link dÆ°á»›i Ä‘Ã¢y:<br />\n<br />\n{$activateUrl}<br />\n<br />\nCáº£m Æ¡n,<br />\n{$siteSignature}'),(9,'REVIEWER_REGISTER','en','Reviewer Register','Registration as Reviewer with {$journalName}','<p>Dear {$recipientName},</p><p>In light of your expertise, we have registered your name in the reviewer database for {$journalName}. This does not entail any form of commitment on your part, but simply enables us to approach you with a submission to possibly review. On being invited to review, you will have an opportunity to see the title and abstract of the paper in question, and you\'ll always be in a position to accept or decline the invitation. You can also ask at any point to have your name removed from this reviewer list.</p><p>We are providing you with a username and password, which is used in all interactions with the journal through its website. You may wish, for example, to update your profile, including your reviewing interests.</p><p>Username: {$recipientUsername}<br />Password: {$password}</p><p>Thank you,</p>{$signature}'),(10,'REVIEWER_REGISTER','vi','','ÄÄƒng kÃ½ lÃ m NgÆ°á»i pháº£n biá»‡n cho {$journalName}','Dá»±a theo chuyÃªn mÃ´n cá»§a báº¡n, chÃºng tÃ´i Ä‘Ã£ tá»± Ä‘Äƒng kÃ½ tÃªn cá»§a báº¡n trong cÆ¡ sá»Ÿ dá»¯ liá»‡u cá»§a ngÆ°á»i pháº£n biá»‡n cho {$journalName}. Äiá»u nÃ y khÃ´ng Ä‘Ã²i há»i báº¥t ká»³ hÃ¬nh thá»©c cam káº¿t nÃ o tá»« phÃ­a báº¡n, mÃ  chá»‰ cho phÃ©p chÃºng tÃ´i tiáº¿p cáº­n báº¡n vá»›i má»™t bÃ i gá»­i Ä‘á»ƒ báº¡n cÃ³ thá»ƒ nháº­n xÃ©t. Khi Ä‘Æ°á»£c má»i nháº­n xÃ©t, báº¡n sáº½ cÃ³ thá»ƒ xem tiÃªu Ä‘á» vÃ  tÃ³m táº¯t cá»§a bÃ i bÃ¡o Ä‘ang Ä‘á» cáº­p vÃ  báº¡n sáº½ cÃ³ thá»ƒ cháº¥p nháº­n hoáº·c tá»« chá»‘i lá»i má»i. Báº¡n cÅ©ng cÃ³ thá»ƒ yÃªu cáº§u báº¥t cá»© lÃºc nÃ o Ä‘á»ƒ xÃ³a tÃªn cá»§a báº¡n khá»i danh sÃ¡ch pháº£n biá»‡n.<br />\n<br />\nChÃºng tÃ´i Ä‘ang cung cáº¥p cho báº¡n username vÃ  máº­t kháº©u, Ä‘Æ°á»£c sá»­ dá»¥ng trong táº¥t cáº£ cÃ¡c tÆ°Æ¡ng tÃ¡c vá»›i táº¡p chÃ­ thÃ´ng qua trang web. Báº¡n cÃ³ thá»ƒ muá»‘n, vÃ­ dá»¥, Ä‘á»ƒ cáº­p nháº­t há»“ sÆ¡ cá»§a báº¡n, bao gá»“m cáº£ lÄ©nh vá»±c mÃ  báº¡n Ä‘ang quan tÃ¢m.<br />\n<br />\nUsername: {$recipientUsername}<br />\nPassword: {$password}<br />\n<br />\nTrÃ¢n trá»ng,<br />\n{$signature}'),(11,'ISSUE_PUBLISH_NOTIFY','en','Issue Published Notify','Just published: {$issueIdentification} of {$journalName}','<p>Dear {$recipientName},</p><p>We are pleased to announce the publication of <a href=\"{$issueUrl}\">{$issueIdentification}</a> of {$journalName}.  We invite you to read and share this work with your scholarly community.</p><p>Many thanks to our authors, reviewers, and editors for their valuable contributions, and to our readers for your continued interest.</p><p>Thank you,</p>{$signature}'),(12,'ISSUE_PUBLISH_NOTIFY','vi','','Sá»‘ vá»«a Ä‘Æ°á»£c xuáº¥t báº£n: {$issueIdentification}','KÃ­nh gá»­i quÃ½ Ä‘á»™c giáº£:<br />\n<br />\n{$journalName} vá»«a xuáº¥t báº£n sá»‘ má»›i nháº¥t táº¡i {$journalUrl}. ChÃºng tÃ´i kÃ­nh má»i Ä‘á»™c Ä‘á»c tham kháº£o Má»¥c lá»¥c táº¡i Ä‘Ã¢y vÃ  sau Ä‘Ã³ truy cáº­p trang web cá»§a chÃºng tÃ´i Ä‘á»ƒ xem chi tiáº¿t cÃ¡c bÃ i viáº¿t vÃ  cÃ¡c bÃ i báº¡n quan tÃ¢m.<br />\n<br />\nTrÃ¢n trá»ng cáº£m Æ¡n  vÃ  mong tiáº¿p tá»¥c nháº­n Ä‘Æ°á»£c sá»± quan tÃ¢m cá»§a quÃ½ Ä‘á»™c giáº£ vá»›i cÃ¡c áº¥n pháº©m cá»§a chÃºng tÃ´i,<br />\n{$signature}'),(13,'SUBMISSION_ACK','en','Submission Confirmation','Thank you for your submission to {$journalName}','<p>Dear {$recipientName},</p><p>Thank you for your submission to {$journalName}. We have received your submission, {$submissionTitle}, and a member of our editorial team will see it soon. You will be sent an email when an initial decision is made, and we may contact you for further information.</p><p>You can view your submission and track its progress through the editorial process at the following location:</p><p>Submission URL: {$authorSubmissionUrl}</p><p>If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Thank you for considering {$journalName} as a venue for your work.</p>{$journalSignature}'),(14,'SUBMISSION_ACK','vi','','Cáº£m Æ¡n Ä‘Ã£ gá»­i bÃ i','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nCáº£m Æ¡n báº¡n Ä‘Ã£ gá»­i báº£n tháº£o, &quot;{$submissionTitle}&quot; tá»›i {$journalName}. Vá»›i há»‡ thá»‘ng quáº£n lÃ½ táº¡p chÃ­ trá»±c tuyáº¿n mÃ  chÃºng tÃ´i Ä‘ang sá»­ dá»¥ng, báº¡n sáº½ cÃ³ thá»ƒ theo dÃµi tiáº¿n trÃ¬nh cá»§a nÃ³ thÃ´ng qua quy trÃ¬nh biÃªn táº­p báº±ng cÃ¡ch Ä‘Äƒng nháº­p vÃ o trang web cá»§a táº¡p chÃ­:<br />\n<br />\nURL cá»§a bÃ i gá»­i: {$submissionUrl}<br />\nUsername: {$recipientUsername}<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i. Cáº£m Æ¡n báº¡n Ä‘Ã£ coi táº¡p chÃ­ nÃ y lÃ  cÃ´ng bá»‘ nghiÃªn cá»©u cá»§a báº¡n.<br />\n<br />\n{$journalSignature}'),(15,'SUBMISSION_ACK_NOT_USER','en','Submission Confirmation (Other Authors)','Submission confirmation','<p>Dear {$recipientName},</p><p>You have been named as a co-author on a submission to {$journalName}. The submitter, {$submitterName}, provided the following details:</p><p>{$submissionTitle}<br>{$authorsWithAffiliation}</p><p>If any of these details are incorrect, or you do not wish to be named on this submission, please contact me.</p><p>Thank you for considering {$journalName} as a venue for your work.</p><p>Kind regards,</p>{$journalSignature}'),(16,'SUBMISSION_ACK_NOT_USER','vi','','XÃ¡c nháº­n gá»­i bÃ i','Xin chÃ o,<br />\n<br />\n{$submitterName} Ä‘Ã£ ná»™p báº£n tháº£o, &quot;{$submissionTitle}&quot; tá»›i {$journalName}. <br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i. Cáº£m Æ¡n báº¡n Ä‘Ã£ coi táº¡p chÃ­ nÃ y lÃ  cÃ´ng bá»‘ nghiÃªn cá»©u cá»§a báº¡n.<br />\n<br />\n{$journalSignature}'),(17,'EDITOR_ASSIGN','en','Editor Assigned','You have been assigned as an editor on a submission to {$journalName}','<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the editorial process.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>If you find the submission to be relevant for {$journalName}, please forward the submission to the review stage by selecting \"Send to Review\" and then assign reviewers by clicking \"Add Reviewer\".</p><p>If the submission is not appropriate for this journal, please decline the submission.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$journalSignature}'),(18,'EDITOR_ASSIGN','vi','','Báº¡n Ä‘Ã£ Ä‘Æ°á»£c chá»‰ Ä‘á»‹nh lÃ  ngÆ°á»i biÃªn táº­p cho bÃ i gá»­i {$journalName}','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nBÃ i gá»­i, &quot;{$submissionTitle},&quot; cá»§a {$journalName} Ä‘Ã£ Ä‘Æ°á»£c phÃ¢n cÃ´ng cho báº¡n Ä‘á»ƒ xem qua quy trÃ¬nh biÃªn táº­p vá»›i vai trÃ² lÃ  BiÃªn táº­p viÃªn chuyÃªn má»¥c.<br />\n<br />\nURL bÃ i gá»­i: {$submissionUrl}<br />\nUsername: {$recipientUsername}<br />\n<br />\nTrÃ¢n trá»ng.'),(19,'REVIEW_CANCEL','en','Reviewer Unassign','Request for Review Cancelled','<p>Dear {$recipientName},</p><p>Recently, we asked you to review a submission to {$journalName}. We have decided to cancel the request for you to reivew the submission, {$submissionTitle}.</p><p>We apologize any inconvenience this may cause you and hope that we will be able to call on you to assist with this journal\'s review process in the future.</p><p>If you have any questions, please contact me.</p>{$signature}'),(20,'REVIEW_CANCEL','vi','','Há»§y yÃªu cáº§u Ä‘Ã¡nh giÃ¡ bÃ i bÃ¡o','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nTáº¡i thá»i Ä‘iá»ƒm nÃ y, chÃºng tÃ´i Ä‘Ã£ quyáº¿t Ä‘á»‹nh há»§y yÃªu cáº§u cá»§a chÃºng tÃ´i Ä‘á»ƒ báº¡n Ä‘Ã¡nh giÃ¡ bÃ i gá»­i, &quot;{$submissionTitle},&quot; cho {$journalName}. ChÃºng tÃ´i xin lá»—i vÃ¬ báº¥t ká»³ sá»± báº¥t tiá»‡n nÃ o mÃ  Ä‘iá»u nÃ y cÃ³ thá»ƒ gÃ¢y ra cho báº¡n vÃ  hy vá»ng ráº±ng chÃºng tÃ´i sáº½ cÃ³ thá»ƒ nhá» báº¡n há»— trá»£ quÃ¡ trÃ¬nh Ä‘Ã¡nh giÃ¡ cá»§a táº¡p chÃ­ trong tÆ°Æ¡ng lai.<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.'),(21,'REVIEW_REINSTATE','en','Reviewer Reinstate','Can you still review something for {$journalName}?','<p>Dear {$recipientName},</p><p>We recently cancelled our request for you to review a submission, {$submissionTitle}, for {$journalName}. We\'ve reversed that decision and we hope that you are still able to conduct the review.</p><p>If you are able to assist with this submission\'s review, you can <a href=\"{$reviewAssignmentUrl}\">login to the journal</a> to view the submission, upload review files, and submit your review request.</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p>{$signature}'),(22,'REVIEW_REINSTATE','vi','','Báº¡n váº«n cÃ²n Ä‘ang review thÃªm gÃ¬ Ä‘Ã³ cho {$journalName}?','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nChÃºng tÃ´i muá»‘n khÃ´i phá»¥c yÃªu cáº§u cá»§a chÃºng tÃ´i Ä‘á»ƒ báº¡n Ä‘Ã¡nh giÃ¡ bÃ i gá»­i, &quot;{$submissionTitle},&quot; cho {$journalName}. ChÃºng tÃ´i hy vá»ng ráº±ng báº¡n sáº½ cÃ³ thá»ƒ há»— trá»£ quÃ¡ trÃ¬nh Ä‘Ã¡nh giÃ¡ cá»§a táº¡p chÃ­ nÃ y.<br />\n<br />\nNáº¿u báº¡n cÃ³ tháº¯c máº¯c, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.'),(23,'REVIEW_RESEND_REQUEST','en','Resend Review Request to Reviewer','Requesting your review again for {$journalName}','<p>Dear {$recipientName},</p><p>Recently, you declined our request to review a submission, {$submissionTitle}, for {$journalName}. I\'m writing to see if you are able to conduct the review after all.</p><p>We would be grateful if you\'re able to perform this review, but we understand if that is not possible at this time. Either way, please <a href=\"{$reviewAssignmentUrl}\">accept or decline the request</a> by {$responseDueDate}, so that we can find an alternate reviewer.</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p>{$signature}'),(24,'REVIEW_RESEND_REQUEST','vi','','',''),(25,'REVIEW_REQUEST','en','Review Request','Invitation to review','<p>Dear {$recipientName},</p><p>I believe that you would serve as an excellent reviewer for a submission  to {$journalName}. The submission\'s title and abstract are below, and I hope that you will consider undertaking this important task for us.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can view the submission, upload review files, and submit your review by logging into the journal site and following the steps at the link below.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please <a href=\"{$reviewAssignmentUrl}\">accept or decline</a> the review by <b>{$responseDueDate}</b>.</p><p>You may contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$signature}'),(26,'REVIEW_REQUEST','vi','','Má»i review bÃ i bÃ¡o','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nTÃ´i tin ráº±ng báº¡n sáº½ má»™t ngÆ°á»i pháº£n biá»‡n thÃ­ch há»£p cá»§a báº£n tháº£o, &quot;{$submissionTitle},&quot; Ä‘Æ°á»£c gá»­i tá»›i {$journalName}. Báº£n tÃ³m táº¯t cá»§a báº£n tháº£o Ä‘Æ°á»£c chÃ¨n bÃªn dÆ°á»›i vÃ  tÃ´i hy vá»ng ráº±ng báº¡n sáº½ xem xÃ©t thá»±c hiá»‡n quÃ¡ trÃ¬nh quan trá»ng nÃ y cho chÃºng tÃ´i.<br />\n<br />\nVui lÃ²ng Ä‘Äƒng nháº­p vÃ o trang web táº¡p chÃ­ trÆ°á»›c ngÃ y {$responseDueDate} Ä‘á»ƒ cho biáº¿t liá»‡u báº¡n sáº½ thá»±c hiá»‡n Ä‘Ã¡nh giÃ¡ nÃ y hay khÃ´ng, cÅ©ng nhÆ° truy cáº­p vÃ o bÃ i gá»­i vÃ  ghi láº¡i nháº­n xÃ©t vÃ  Ä‘á» xuáº¥t cá»§a báº¡n. Trang web lÃ  {$journalUrl}<br />\n<br />\nThá»i háº¡n cá»§a viá»‡c Ä‘Ã¡nh giÃ¡ lÃ  ngÃ y {$reviewDueDate}.<br />\n<br />\nNáº¿u báº¡n quÃªn username vÃ  máº­t kháº©u Ä‘Äƒng nháº­p vÃ o trang web cá»§a táº¡p chÃ­, báº¡n cÃ³ thá»ƒ sá»­ dá»¥ng liÃªn káº¿t nÃ y Ä‘á»ƒ Ä‘áº·t láº¡i máº­t kháº©u cá»§a mÃ¬nh (sau Ä‘Ã³ sáº½ Ä‘Æ°á»£c gá»­i qua email cho báº¡n cÃ¹ng vá»›i username cá»§a báº¡n).{$passwordLostUrl}<br />\n<br />\nURL bÃ i gá»­i: {$reviewAssignmentUrl}<br />\n<br />\nCáº£m Æ¡n báº¡n Ä‘Ã£ xem xÃ©t yÃªu cáº§u nÃ y.<br />\n<br />\n{$signature}<br />\n<br />\n&quot;{$submissionTitle}&quot;<br />\n<br />\n{$submissionAbstract}'),(27,'REVIEW_REQUEST_SUBSEQUENT','en','Review Request Subsequent','Request to review a revised submission','<p>Dear {$recipientName},</p><p>Thank you for your review of <a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a>. The authors have considered the reviewers\' feedback and have now submitted a revised version of their work. I\'m writing to ask if you would conduct a second round of peer review for this submission.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can <a href=\"{$reviewAssignmentUrl}\">follow the review steps</a> to view the submission, upload review files, and submit your review comments.<p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please <a href=\"{$reviewAssignmentUrl}\">accept or decline</a> the review by <b>{$responseDueDate}</b>.</p><p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$signature}'),(28,'REVIEW_REQUEST_SUBSEQUENT','vi','','YÃªu cáº§u review má»™t bÃ i bÃ¡o Ä‘Æ°á»£c gá»­i láº¡i','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nLiÃªn quan tá»›i báº£n tháº£o &quot;{$submissionTitle},&quot; Ä‘Æ°á»£c xem xÃ©t bá»Ÿi {$journalName}.<br />\n<br />\nSau khi xem xÃ©t phiÃªn báº£n trÆ°á»›c cá»§a báº£n tháº£o, cÃ¡c tÃ¡c giáº£ hiá»‡n Ä‘Ã£ gá»­i phiÃªn báº£n sá»­a chá»¯a bÃ i bÃ¡o cá»§a há». ChÃºng tÃ´i Ä‘Ã¡nh giÃ¡ cao náº¿u báº¡n cÃ³ thá»ƒ giÃºp Ä‘Ã¡nh giÃ¡ báº£n sá»­a chá»¯a nÃ y.<br />\n<br />\nVui lÃ²ng Ä‘Äƒng nháº­p vÃ o trang web táº¡p chÃ­ trÆ°á»›c ngÃ y {$responseDueDate} Ä‘á»ƒ cho biáº¿t liá»‡u báº¡n sáº½ thá»±c hiá»‡n Ä‘Ã¡nh giÃ¡ hay khÃ´ng, cÅ©ng nhÆ° truy cáº­p vÃ o bÃ i gá»­i vÃ  ghi láº¡i Ä‘Ã¡nh giÃ¡ vÃ  Ä‘á» xuáº¥t cá»§a báº¡n. Trang web lÃ  {$journalUrl}<br />\n<br />\nThá»i háº¡n Ä‘Ã¡nh giÃ¡ lÃ  ngÃ y {$reviewDueDate}.<br />\n<br />\nNáº¿u báº¡n khÃ´ng nhá»› username vÃ  máº­t kháº©u cho trang web cá»§a táº¡p chÃ­, báº¡n cÃ³ thá»ƒ sá»­ dá»¥ng liÃªn káº¿t nÃ y Ä‘á»ƒ Ä‘áº·t láº¡i máº­t kháº©u cá»§a mÃ¬nh (sau Ä‘Ã³ sáº½ Ä‘Æ°á»£c gá»­i qua email cho báº¡n cÃ¹ng vá»›i username cá»§a báº¡n). {$passwordLostUrl}<br />\n<br />\nURL bÃ i gá»­i: {$reviewAssignmentUrl}<br />\n<br />\nCáº£m Æ¡n báº¡n Ä‘Ã£ xem xÃ©t yÃªu cáº§u nÃ y.<br />\n<br />\n{$signature}<br />\n<br />\n&quot;{$submissionTitle}&quot;<br />\n<br />\n{$submissionAbstract}'),(29,'REVIEW_RESPONSE_OVERDUE_AUTO','en','Review Response Overdue (Automated)','Will you be able to review this for us?','<p>Dear {$recipientName},</p><p>This email is an automated reminder from {$journalName} in regards to our request for your review of the submission, \"{$submissionTitle}.\"</p><p>You are receiving this email because we have not yet received a confirmation from you indicating whether or not you are able to undertake the review of this submission.</p><p>Please let us know whether or not you are able to undertake this review by using our submission management software to accept or decline this request.</p><p>If you are able to review this submission, your review is due by {$reviewDueDate}. You can follow the review steps to view the submission, upload review files, and submit your review comments.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a></p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please feel free to contact me with any questions about the submission or the review process.</p><p>Thank you for considering this request. Your help is much appreciated.</p><p>Kind regards,</p>{$journalSignature}'),(30,'REVIEW_RESPONSE_OVERDUE_AUTO','vi','','Yá»u cáº§u Ä‘Ã¡nh giÃ¡ bÃ i bÃ¡o','KÃ­nh gá»­i {$recipientName},<br />\nÄÃ¢y lÃ  email Ä‘á»ƒ nháº¯c báº¡n vá» viá»‡c Ä‘Ã¡nh giÃ¡ bÃ i gá»­i, &quot;{$submissionTitle},&quot; cho {$journalName}. ChÃºng tÃ´i hy vá»ng sáº½ cÃ³ pháº£n há»“i cá»§a báº¡n vÃ o ngÃ y {$responseDueDate}, vÃ  email nÃ y Ä‘Ã£ Ä‘Æ°á»£c tá»± Ä‘á»™ng táº¡o vÃ  gá»­i cÃ¹ng vá»›i ngÃ y Ä‘Ã³.\n<br />\nTÃ´i tin ráº±ng báº¡n lÃ  má»™t ngÆ°á»i pháº£n biá»‡n phÃ¹ há»£p cá»§a báº£n tháº£o nÃ y. Báº£n tÃ³m táº¯t cá»§a bÃ i gá»­i Ä‘Æ°á»£c chÃ¨n bÃªn dÆ°á»›i vÃ  tÃ´i hy vá»ng ráº±ng báº¡n sáº½ xem xÃ©t thá»±c hiá»‡n quÃ¡ trÃ¬nh quan trá»ng nÃ y cho chÃºng tÃ´i.<br />\n<br />\nVui lÃ²ng Ä‘Äƒng nháº­p vÃ o trang web táº¡p chÃ­ Ä‘á»ƒ cho biáº¿t liá»‡u báº¡n sáº½ thá»±c hiá»‡n Ä‘Ã¡nh giÃ¡ hay khÃ´ng, cÅ©ng nhÆ° Ä‘á»ƒ truy cáº­p vÃ o bÃ i gá»­i vÃ  ghi láº¡i Ä‘Ã¡nh giÃ¡ vÃ  Ä‘á» xuáº¥t cá»§a báº¡n. Trang web lÃ  {$journalUrl}<br />\n<br />\nThá»i háº¡n pháº£n biá»‡n lÃ  ngÃ y {$reviewDueDate}.<br />\n<br />\nNáº¿u báº¡n quÃªn username vÃ  máº­t kháº©u Ä‘Äƒng nháº­p vÃ o trang web cá»§a táº¡p chÃ­, báº¡n cÃ³ thá»ƒ sá»­ dá»¥ng liÃªn káº¿t nÃ y Ä‘á»ƒ Ä‘áº·t láº¡i máº­t kháº©u cá»§a mÃ¬nh (sau Ä‘Ã³ sáº½ Ä‘Æ°á»£c gá»­i qua email cho báº¡n cÃ¹ng vá»›i username cá»§a báº¡n). {$passwordLostUrl}<br />\n<br />\nURL bÃ i gá»­i: {$reviewAssignmentUrl}<br />\n<br />\nCáº£m Æ¡n báº¡n Ä‘Ã£ xem xÃ©t yÃªu cáº§u nÃ y.<br />\n<br />\n{$journalSignature}<br />\n<br />\n&quot;{$submissionTitle}&quot;<br />\n<br />\n{$submissionAbstract}'),(31,'REVIEW_CONFIRM','en','Review Confirm','Review accepted: {$reviewerName} accepted review assignment for #{$submissionId} {$authorsShort} â€” {$submissionTitle}','<p>Dear {$recipientName},</p><p>{$reviewerName} has accepted the following review:</p><p><a href=\"{$submissionUrl}\">#{$submissionId} {$authorsShort} â€” {$submissionTitle}</a><br /><b>Type:</b> {$reviewMethod}</p><p><b>Review Due:</b> {$reviewDueDate}</p><p>Login to <a href=\"{$submissionUrl}\">view all reviewer assignments</a> for this submission.</p><br><br>â€”<br>This is an automated message from <a href=\"{$journalUrl}\">{$journalName}</a>.'),(32,'REVIEW_CONFIRM','vi','','Äá»“ng Ã½ Ä‘Ã¡nh giÃ¡','KÃ­nh gá»­i BiÃªn táº­p viÃªn,<br />\n<br />\nTÃ´i cÃ³ thá»ƒ vÃ  sáºµn sÃ ng Ä‘Ã¡nh giÃ¡ bÃ i gá»­i, &quot;{$submissionTitle},&quot; cho {$journalName}. Cáº£m Æ¡n báº¡n Ä‘Ã£ nghÄ© Ä‘áº¿n tÃ´i vÃ  tÃ´i dá»± Ä‘á»‹nh hoÃ n thÃ nh báº£n Ä‘Ã¡nh giÃ¡ trÆ°á»›c ngÃ y {$reviewDueDate}.<br />\n<br />\n{$senderName}'),(33,'REVIEW_DECLINE','en','Review Decline','Unable to Review','Editors:<br />\n<br />\nI am afraid that at this time I am unable to review the submission, &quot;{$submissionTitle},&quot; for {$journalName}. Thank you for thinking of me, and another time feel free to call on me.<br />\n<br />\n{$senderName}'),(34,'REVIEW_DECLINE','vi','','KhÃ´ng thá»ƒ nháº­n Ä‘Ã¡nh giÃ¡','KÃ­nh gá»­i biÃªn táº­p viÃªn,<br />\n<br />\nTÃ´i e ráº±ng táº¡i thá»i Ä‘iá»ƒm nÃ y tÃ´i khÃ´ng thá»ƒ Ä‘Ã¡nh giÃ¡ bÃ i gá»­i, &quot;{$submissionTitle},&quot; cho {$journalName}. Cáº£m Æ¡n báº¡n Ä‘Ã£ nghÄ© Ä‘áº¿n  tÃ´i, vÃ  báº¡n cÃ³ thá»ƒ liÃªn há»‡ vá»›i tÃ´i vÃ o thá»i Ä‘iá»ƒm khÃ¡c.<br />\n<br />\n{$senderName}'),(35,'REVIEW_ACK','en','Review Acknowledgement','Thank you for your review','<p>Dear {$recipientName},</p>\n<p>Thank you for completing your review of the submission, {$submissionTitle}, for {$journalName}. We appreciate your time and expertise in contributing to the quality of the work that we publish.</p>\n<p>It has been a pleasure to work with you as a reviewer for {$journalName}, and we hope to have the opportunity to work with you again in the future.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>'),(36,'REVIEW_ACK','vi','','Lá»i cáº£m Æ¡n vá» viá»‡c Ä‘Ã¡nh giÃ¡ bÃ i bÃ¡o','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nCáº£m Æ¡n báº¡n Ä‘Ã£ hoÃ n thÃ nh viá»‡c Ä‘Ã¡nh giÃ¡ bÃ i gá»­i, &quot;{$submissionTitle},&quot; cho {$journalName}. ChÃºng tÃ´i Ä‘Ã¡nh giÃ¡ cao sá»± Ä‘Ã³ng gÃ³p cá»§a báº¡n cho cháº¥t lÆ°á»£ng áº¥n pháº©m mÃ  chÃºng tÃ´i xuáº¥t báº£n.'),(37,'REVIEW_REMIND','en','Review Reminder','A reminder to please complete your review','<p>Dear {$recipientName},</p><p>Just a gentle reminder of our request for your review of the submission, \"{$submissionTitle},\" for {$journalName}. We were expecting to have this review by {$reviewDueDate} and we would be pleased to receive it as soon as you are able to prepare it.</p><p>You can <a href=\"{$reviewAssignmentUrl}\">login to the journal</a> and follow the review steps to view the submission, upload review files, and submit your review comments.</p><p>If you need an extension of the deadline, please contact me. I look forward to hearing from you.</p><p>Thank you in advance and kind regards,</p>{$signature}'),(38,'REVIEW_REMIND','vi','','Nháº¯c viá»‡c hoÃ n thÃ nh review','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nÄÃ¢y lÃ  nháº¯c nhá»Ÿ vá» yÃªu cáº§u cá»§a chÃºng tÃ´i Ä‘á»ƒ báº¡n xem xÃ©t bÃ i gá»­i, &quot;{$submissionTitle},&quot; for {$journalName}. ChÃºng tÃ´i hy vá»ng sáº½ cÃ³ Ä‘Ã¡nh giÃ¡ nÃ y vÃ o ngÃ y {$reviewDueDate}, vÃ  sáº½ ráº¥t vui khi nháº­n Ä‘Æ°á»£c nÃ³ ngay khi báº¡n cÃ³ thá»ƒ gá»­i nÃ³.<br />\n<br />\nNáº¿u báº¡n khÃ´ng cÃ³ username vÃ  máº­t kháº©u cho trang web cá»§a táº¡p chÃ­, báº¡n cÃ³ thá»ƒ sá»­ dá»¥ng liÃªn káº¿t nÃ y Ä‘á»ƒ Ä‘áº·t láº¡i máº­t kháº©u cá»§a mÃ¬nh (sau Ä‘Ã³ sáº½ Ä‘Æ°á»£c gá»­i qua email cho báº¡n cÃ¹ng vá»›i username cá»§a báº¡n). {$passwordLostUrl}<br />\n<br />\nURL bÃ i gá»­i: {$reviewAssignmentUrl}<br />\n<br />\nVui lÃ²ng xÃ¡c nháº­n kháº£ nÄƒng hoÃ n thÃ nh quy trÃ¬nh quan trá»ng nÃ y cho cÃ´ng viá»‡c cá»§a táº¡p chÃ­. ChÃºng tÃ´i mong nháº­n Ä‘Æ°á»£c pháº£n há»“i cá»§a báº¡n.<br />\n<br />\n{$signature}'),(39,'REVIEW_REMIND_AUTO','en','Review Reminder (Automated)','A reminder to please complete your review','<p>Dear {$recipientName}:</p><p>This email is an automated reminder from {$journalName} in regards to our request for your review of the submission, \"{$submissionTitle}.\"</p><p>We were expecting to have this review by {$reviewDueDate} and we would be pleased to receive it as soon as you are able to prepare it.</p><p>Please <a href=\"{$reviewAssignmentUrl}\">login to the journal</a> and follow the review steps to view the submission, upload review files, and submit your review comments.</p><p>If you need an extension of the deadline, please contact me. I look forward to hearing from you.</p><p>Thank you in advance and kind regards,</p>{$journalSignature}'),(40,'REVIEW_REMIND_AUTO','vi','','Nháº¯c viá»‡c hoÃ n thÃ nh review','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nJust a gentle reminder of our request for your review of the submission, &quot;{$submissionTitle},&quot; for {$journalName}. We were hoping to have this review by {$reviewDueDate}, and this email has been automatically generated and sent with the passing of that date. We would still be pleased to receive it as soon as you are able to prepare it.<br />\n<br />\nNáº¿u báº¡n khÃ´ng cÃ³ username vÃ  máº­t kháº©u cho trang web cá»§a táº¡p chÃ­, báº¡n cÃ³ thá»ƒ sá»­ dá»¥ng liÃªn káº¿t nÃ y Ä‘á»ƒ Ä‘áº·t láº¡i máº­t kháº©u cá»§a mÃ¬nh (sau Ä‘Ã³ sáº½ Ä‘Æ°á»£c gá»­i qua email cho báº¡n cÃ¹ng vá»›i username cá»§a báº¡n). {$passwordLostUrl}<br />\n<br />\nURL bÃ i gá»­i: {$reviewAssignmentUrl}<br />\n<br />\nVui lÃ²ng xÃ¡c nháº­n kháº£ nÄƒng hoÃ n thÃ nh quy trÃ¬nh quan trá»ng nÃ y cho cÃ´ng viá»‡c cá»§a táº¡p chÃ­. ChÃºng tÃ´i mong nháº­n Ä‘Æ°á»£c pháº£n há»“i cá»§a báº¡n.<br />\n<br />\n{$journalSignature}'),(41,'REVIEW_COMPLETE','en','Review Completed','Review complete: {$reviewerName} recommends {$reviewRecommendation} for #{$submissionId} {$authorsShort} â€” {$submissionTitle}','<p>Dear {$recipientName},</p><p>{$reviewerName} completed the following review:</p><p><a href=\"{$submissionUrl}\">#{$submissionId} {$authorsShort} â€” {$submissionTitle}</a><br /><b>Recommendation:</b> {$reviewRecommendation}<br /><b>Type:</b> {$reviewMethod}</p><p>Login to <a href=\"{$submissionUrl}\">view all files and comments</a> provided by this reviewer.</p>'),(42,'REVIEW_COMPLETE','vi','','',''),(43,'REVIEW_EDIT','en','Review Edited','Your review assignment has been changed for {$journalName}','<p>Dear {$recipientName},</p><p>An editor has made changes to your review assignment for {$journalName}. Please review the details below and let us know if you have any questions.</p><p><a href=\"{$reviewAssignmentUrl}\">{$submissionTitle}</a><br /><b>Type:</b> {$reviewMethod}<br /><b>Accept or Decline By:</b> {$responseDueDate}<br /><b>Submit Review By:</b> {$reviewDueDate}</p><p>You can login to <a href=\"{$reviewAssignmentUrl}\">complete this review</a> at any time.</p>'),(44,'REVIEW_EDIT','vi','','',''),(45,'EDITOR_DECISION_ACCEPT','en','Submission Accepted','Your submission has been accepted to {$journalName}','<p>Dear {$recipientName},</p><p>I am pleased to inform you that we have decided to accept your submission without further revision. After careful review, we found your submission, {$submissionTitle}, to meet or exceed our expectations. We are excited to publish your piece in {$journalName} and we thank you for choosing our journal as a venue for your work.</p><p>Your submission is now forthcoming in a future issue of {$journalName} and you are welcome to include it in your list of publications. We recognize the hard work that goes into every successful submission and we want to congratulate you on reaching this stage.</p><p>Your submission will now undergo copy editing and formatting to prepare it for publication.</p><p>You will shortly receive further instructions.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p>{$signature}'),(46,'EDITOR_DECISION_ACCEPT','vi','','BÃ i gá»­i cá»§a báº¡n Ä‘Ã£ Ä‘Æ°á»£c cháº¥p nháº­n cho {$journalName}','KÃ­nh gá»­i {$authors},<br />\n<br />\nChÃºng tÃ´i Ä‘Ã£ Ä‘áº¡t Ä‘Æ°á»£c má»™t quyáº¿t Ä‘á»‹nh liÃªn quan Ä‘áº¿n viá»‡c bÃ i gá»­i cá»§a báº¡n  {$journalName}, &quot;{$submissionTitle}&quot;.<br />\n<br />\nQuyáº¿t Ä‘á»‹nh cá»§a chÃºng tÃ´i lÃ : Cháº¥p nháº­n cho Ä‘Äƒng'),(47,'EDITOR_DECISION_SEND_TO_EXTERNAL','en','Sent to Review','Your submission has been sent for review','<p>Dear {$recipientName},</p><p>I am pleased to inform you that an editor has reviewed your submission, {$submissionTitle}, and has decided to send it for peer review. An editor will identify qualified reviewers who will provide feedback on your submission.</p><p>{$reviewTypeDescription} You will hear from us with feedback from the reviewers and information about the next steps.</p><p>Please note that sending the submission to peer review does not guarantee that it will be published. We will consider the reviewers\' recommendations before deciding to accept the submission for publication. You may be asked to make revisions and respond to the reviewers\' comments before a final decision is made.</p><p>If you have any questions, please contact me from your submission dashboard.</p><p>{$signature}</p>'),(48,'EDITOR_DECISION_SEND_TO_EXTERNAL','vi','','Quyáº¿t Ä‘á»‹nh cá»§a Ban biÃªn táº­p','KÃ­nh gá»­i {$authors},<br />\n<br />\nChÃºng tÃ´i Ä‘Ã£ Ä‘áº¡t Ä‘Æ°á»£c má»™t quyáº¿t Ä‘á»‹nh liÃªn quan Ä‘áº¿n viá»‡c bÃ i gá»­i cá»§a báº¡n {$journalName}, &quot;{$submissionTitle}&quot;.<br />\n<br />\nQuyáº¿t Ä‘á»‹nh cá»§a chÃºng tÃ´i lÃ : Gá»­i láº¡i Ä‘á»ƒ xem xÃ©t<br />\n<br />\nURL bÃ i gá»­i: {$submissionUrl}'),(49,'EDITOR_DECISION_SEND_TO_PRODUCTION','en','Sent to Production','Next steps for publishing your submission','<p>Dear {$recipientName},</p><p>I am writing from {$journalName} to let you know that the editing of your submission, {$submissionTitle}, is complete. Your submission will now advance to the production stage, where the final galleys will be prepared for publication. We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p>{$signature}'),(50,'EDITOR_DECISION_SEND_TO_PRODUCTION','vi','','Quyáº¿t Ä‘á»‹nh cá»§a Ban biÃªn táº­p','KÃ­nh gá»­i {$authors},<br />\n<br />\nQuÃ¡ trÃ¬nh biÃªn táº­p báº£n tháº£o cá»§a báº¡n, &quot;{$submissionTitle},&quot; Ä‘Ã£ hoÃ n thÃ nh. ChÃºng tÃ´i Ä‘Ã£ chuyá»ƒn nÃ³ sang giai Ä‘oáº¡n cháº¿ báº£n.<br />\n<br />\nURL bÃ i gá»­i: {$submissionUrl}'),(51,'EDITOR_DECISION_REVISIONS','en','Revisions Requested','Your submission has been reviewed and we encourage you to submit revisions','<p>Dear {$recipientName},</p><p>Your submission {$submissionTitle} has been reviewed and we would like to encourage you to submit revisions that address the reviewers\' comments. An editor will review these revisions and if they address the concerns adequately, your submission may be accepted for publication.</p><p>The reviewers\' comments are included at the bottom of this email. Please respond to each point in the reviewers\' comments and identify what changes you have made. If you find any of the reviewer\'s comments to be unjustified or inappropriate, please explain your perspective.</p><p>When you have completed your revisions, you can upload revised documents along with your response to the reviewers\' comments at your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>. If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>We look forward to receiving your revised submission.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}'),(52,'EDITOR_DECISION_REVISIONS','vi','','Quyáº¿t Ä‘á»‹nh cá»§a Ban biÃªn táº­p','KÃ­nh gá»­i {$authors},<br />\n<br />\nChÃºng tÃ´i Ä‘Ã£ Ä‘áº¡t Ä‘Æ°á»£c má»™t quyáº¿t Ä‘á»‹nh liÃªn quan Ä‘áº¿n viá»‡c bÃ i gá»­i cá»§a báº¡n {$journalName}, &quot;{$submissionTitle}&quot;.<br />\n<br />\nQuyáº¿t Ä‘á»‹nh cá»§a chÃºng tÃ´i lÃ : YÃªu cáº§u sá»­a chá»¯a'),(53,'EDITOR_DECISION_RESUBMIT','en','Resubmit for Review','Your submission has been reviewed - please revise and resubmit','<p>Dear {$recipientName},</p><p>After reviewing your submission, {$submissionTitle}, the reviewers have recommended that your submission cannot be accepted for publication in its current form. However, we would like to encourage you to submit a revised version that addresses the reviewers\' comments. Your revisions will be reviewed by an editor and may be sent out for another round of peer review.</p><p>Please note that resubmitting your work does not guarantee that it will be accepted.</p><p>The reviewers\' comments are included at the bottom of this email. Please respond to each point and identify what changes you have made. If you find any of the reviewer\'s comments inappropriate, please explain your perspective. If you have questions about the recommendations in your review, please include these in your response.</p><p>When you have completed your revisions, you can upload revised documents along with your response to the reviewers\' comments <a href=\"{$authorSubmissionUrl}\">at your submission dashboard</a>. If you have been logged out, you can login again with the username {$recipientUsername}.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>We look forward to receiving your revised submission.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}'),(54,'EDITOR_DECISION_RESUBMIT','vi','','Quyáº¿t Ä‘á»‹nh cá»§a Ban biÃªn táº­p','KÃ­nh gá»­i {$authors},<br />\n<br />\nChÃºng tÃ´i Ä‘Ã£ Ä‘áº¡t Ä‘Æ°á»£c má»™t quyáº¿t Ä‘á»‹nh liÃªn quan Ä‘áº¿n viá»‡c bÃ i gá»­i cá»§a báº¡n {$journalName}, &quot;{$submissionTitle}&quot;.<br />\n<br />\nQuyáº¿t Ä‘á»‹nh cá»§a chÃºng tÃ´i lÃ : Gá»­i láº¡i Ä‘á»ƒ xem xÃ©t'),(55,'EDITOR_DECISION_DECLINE','en','Submission Declined','Your submission has been declined','<p>Dear {$recipientName},</p><p>While we appreciate receiving your submission, we are unable to accept {$submissionTitle} for publication on the basis of the comments from reviewers.</p><p>The reviewers\' comments are included at the bottom of this email.</p><p>Thank you for submitting to {$journalName}. Although it is disappointing to have a submission declined, I hope you find the reviewers\' comments to be constructive and helpful.</p><p>You are now free to submit the work elsewhere if you choose to do so.</p><p>Kind regards,</p>{$signature}<hr><p>The following comments were received from reviewers.</p>{$allReviewerComments}'),(56,'EDITOR_DECISION_DECLINE','vi','','Quyáº¿t Ä‘á»‹nh cá»§a Ban biÃªn táº­p','KÃ­nh gá»­i {$authors},<br />\n<br />\nChÃºng tÃ´i Ä‘Ã£ Ä‘áº¡t Ä‘Æ°á»£c má»™t quyáº¿t Ä‘á»‹nh liÃªn quan Ä‘áº¿n viá»‡c bÃ i gá»­i cá»§a báº¡n {$journalName}, &quot;{$submissionTitle}&quot;.<br />\n<br />\nQuyáº¿t Ä‘á»‹nh cá»§a chÃºng tÃ´i lÃ : Tá»« chá»‘i'),(57,'EDITOR_DECISION_INITIAL_DECLINE','en','Submission Declined (Pre-Review)','Your submission has been declined','<p>Dear {$recipientName},</p><p>Iâ€™m sorry to inform you that, after reviewing your submission, {$submissionTitle}, the editor has found that it does not meet our requirements for publication in {$journalName}.</p><p>I wish you success if you consider submitting your work elsewhere.</p><p>Kind regards,</p>{$signature}'),(58,'EDITOR_DECISION_INITIAL_DECLINE','vi','','Quyáº¿t Ä‘á»‹nh cá»§a ban biÃªn táº­p','\n			KÃ­nh gá»­i {$authors},<br />\n<br />\nChÃºng tÃ´i Ä‘Ã£ Ä‘áº¡t Ä‘Æ°á»£c má»™t quyáº¿t Ä‘á»‹nh liÃªn quan Ä‘áº¿n bÃ i gá»­i cá»§a báº¡n {$journalName}, &quot;{$submissionTitle}&quot;.<br />		\n<br />\nQuyáº¿t Ä‘á»‹nh cá»§a chÃºng tÃ´i lÃ : Tá»« chá»‘i'),(59,'EDITOR_RECOMMENDATION','en','Recommendation Made','Editor Recommendation','<p>Dear {$recipientName},</p><p>After considering the reviewers\' feedback, I would like to make the following recommendation regarding the submission {$submissionTitle}.</p><p>My recommendation is: {$recommendation}.</p><p>Please visit the submission\'s <a href=\"{$submissionUrl}\">editorial workflow</a> to act on this recommendation.</p><p>Please feel free to contact me with any questions.</p><p>Kind regards,</p><p>{$senderName}</p>'),(60,'EDITOR_RECOMMENDATION','vi','','Khuyáº¿n nghá»‹ cá»§a biÃªn táº­p viÃªn','KÃ­nh gá»­i {$editors},<br />\n<br />\nThe recommendation regarding the submission to {$journalName}, &quot;{$submissionTitle}&quot; is: {$recommendation}'),(61,'EDITOR_DECISION_NOTIFY_OTHER_AUTHORS','en','Notify Other Authors','An update regarding your submission','<p>The following email was sent to {$submittingAuthorName} from {$journalName} regarding {$submissionTitle}.</p>\n<p>You are receiving a copy of this notification because you are identified as an author of the submission. Any instructions in the message below are intended for the submitting author, {$submittingAuthorName}, and no action is required of you at this time.</p>\n\n{$messageToSubmittingAuthor}'),(62,'EDITOR_DECISION_NOTIFY_OTHER_AUTHORS','vi','','',''),(63,'EDITOR_DECISION_NOTIFY_REVIEWERS','en','Notify Reviewers of Decision','Thank you for your review','<p>Dear {$recipientName},</p>\n<p>Thank you for completing your review of the submission, {$submissionTitle}, for {$journalName}. We appreciate your time and expertise in contributing to the quality of the work that we publish. We have shared your comments with the authors, along with our other reviewers\' comments and the editor\'s decision.</p>\n<p>Based on the feedback we received, we have notified the authors of the following:</p>\n<p>{$decisionDescription}</p>\n<p>Your recommendation was considered alongside the recommendations of other reviewers before coming to a decision. Occasionally the editor\'s decision may differ from the recommendation made by one or more reviewers. The editor considers many factors, and does not take these decisions lightly. We are grateful for our reviewers\' expertise and suggestions.</p>\n<p>It has been a pleasure to work with you as a reviewer for {$journalName}, and we hope to have the opportunity to work with you again in the future.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>'),(64,'EDITOR_DECISION_NOTIFY_REVIEWERS','vi','','',''),(65,'EDITOR_DECISION_NEW_ROUND','en','New Review Round Initiated','Your submission has been sent for another round of review','<p>Dear {$recipientName},</p>\n<p>Your revised submission, {$submissionTitle}, has been sent for a new round of peer review. \nYou will hear from us with feedback from the reviewers and information about the next steps.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),(66,'EDITOR_DECISION_NEW_ROUND','vi','','',''),(67,'EDITOR_DECISION_REVERT_DECLINE','en','Reinstate Declined Submission','We have reversed the decision to decline your submission','<p>Dear {$recipientName},</p>\n<p>The decision to decline your submission, {$submissionTitle}, has been reversed. \nAn editor will complete the round of review and you will be notified when a \ndecision is made.</p>\n<p>Occasionally, a decision to decline a submission will be recorded accidentally in \nour system and must be reverted. I apologize for any confusion this may have caused.</p>\n<p>We will contact you if we need any further assistance.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),(68,'EDITOR_DECISION_REVERT_DECLINE','vi','','',''),(69,'EDITOR_DECISION_REVERT_INITIAL_DECLINE','en','Reinstate Submission Declined Without Review','We have reversed the decision to decline your submission','<p>Dear {$recipientName},</p>\n<p>The decision to decline your submission, {$submissionTitle}, has been reversed. \nAn editor will look further at your submission before deciding whether to decline \nthe submission or send it for review.</p>\n<p>Occasionally, a decision to decline a submission will be recorded accidentally in \nour system and must be reverted. I apologize for any confusion this may have caused.</p>\n<p>We will contact you if we need any further assistance.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),(70,'EDITOR_DECISION_REVERT_INITIAL_DECLINE','vi','','',''),(71,'EDITOR_DECISION_SKIP_REVIEW','en','Submission Accepted (Without Review)','Your submission has been sent for copyediting','<p>Dear {$recipientName},</p>\n<p>I am pleased to inform you that we have decided to accept your submission without peer review. We found your submission, {$submissionTitle}, to meet our expectations, and we do not require that work of this type undergo peer review. We are excited to publish your piece in {$journalName} and we thank you for choosing our journal as a venue for your work.</p>\nYour submission is now forthcoming in a future issue of {$journalName} and you are welcome to include it in your list of publications. We recognize the hard work that goes into every successful submission and we want to congratulate you on your efforts.</p>\n<p>Your submission will now undergo copy editing and formatting to prepare it for publication. </p>\n<p>You will shortly receive further instructions.</p>\n<p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p>\n<p>Kind regards,</p>\n<p>{$signature}</p>\n'),(72,'EDITOR_DECISION_SKIP_REVIEW','vi','','BÃ i gá»­i cá»§a báº¡n Ä‘Ã£ Ä‘Æ°á»£c gá»­i Ä‘á»ƒ sao chÃ©p',''),(73,'EDITOR_DECISION_BACK_FROM_PRODUCTION','en','Submission Sent Back to Copyediting','Your submission has been sent back to copyediting','<p>Dear {$recipientName},</p><p>Your submission, {$submissionTitle}, has been sent back to the copyediting stage, where it will undergo further copyediting and formatting to prepare it for publication.</p><p>Occasionally, a submission is sent to the production stage before it is ready for the final galleys to be prepared for publication. Your submission is still forthcoming. I apologize for any confusion.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>We will contact you if we need any further assistance.</p><p>Kind regards,</p><p>{$signature}</p>'),(74,'EDITOR_DECISION_BACK_FROM_PRODUCTION','vi','','',''),(75,'EDITOR_DECISION_BACK_FROM_COPYEDITING','en','Submission Sent Back from Copyediting','Your submission has been sent back to review','<p>Dear {$recipientName},</p><p>Your submission, {$submissionTitle}, has been sent back to the review stage. It will undergo further review before it can be accepted for publication.</p><p>Occasionally, a decision to accept a submission will be recorded accidentally in our system and we must send it back to review. I apologize for any confusion this has caused. We will work to complete any further review quickly so that you have a final decision as soon as possible.</p><p>We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p><p>{$signature}</p>'),(76,'EDITOR_DECISION_BACK_FROM_COPYEDITING','vi','','',''),(77,'EDITOR_DECISION_CANCEL_REVIEW_ROUND','en','Review Round Cancelled','A review round for your submission has been cancelled','<p>Dear {$recipientName},</p><p>We recently opened a new review round for your submission, {$submissionTitle}. We are closing this review round now.</p><p>Occasionally, a decision to open a round of review will be recorded accidentally in our system and we must cancel this review round. I apologize for any confusion this may have caused.</p><p>We will contact you if we need any further assistance.</p><p>If you have any questions, please contact me from your <a href=\"{$authorSubmissionUrl}\">submission dashboard</a>.</p><p>Kind regards,</p><p>{$signature}</p>'),(78,'EDITOR_DECISION_CANCEL_REVIEW_ROUND','vi','','',''),(79,'SUBSCRIPTION_NOTIFY','en','Subscription Notify','Subscription Notification','{$recipientName}:<br />\n<br />\nYou have now been registered as a subscriber in our online journal management system for {$journalName}, with the following subscription:<br />\n<br />\n{$subscriptionType}<br />\n<br />\nTo access content that is available only to subscribers, simply log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nOnce you have logged in to the system you can change your profile details and password at any point.<br />\n<br />\nPlease note that if you have an institutional subscription, there is no need for users at your institution to log in, since requests for subscription content will be automatically authenticated by the system.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),(80,'SUBSCRIPTION_NOTIFY','vi','','ThÃ´ng bÃ¡o thuÃª bao','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nBÃ¢y giá» báº¡n Ä‘Ã£ Ä‘Æ°á»£c Ä‘Äƒng kÃ½ nhÆ° má»™t thuÃª bao trong há»‡ thá»‘ng quáº£n lÃ½ táº¡p chÃ­ trá»±c tuyáº¿n cá»§a chÃºng tÃ´i cho {$journalName}, vá»›i Ä‘Äƒng kÃ½ sau:<br />\n<br />\n{$subscriptionType}<br />\n<br />\nÄá»ƒ truy cáº­p ná»™i dung chá»‰ dÃ nh cho ngÆ°á»i thuÃª bao, chá»‰ cáº§n Ä‘Äƒng nháº­p vÃ o há»‡ thá»‘ng báº±ng username cá»§a báº¡n, &quot;{$recipientUsername}&quot;.<br />\n<br />\nKhi báº¡n Ä‘Ã£ Ä‘Äƒng nháº­p vÃ o há»‡ thá»‘ng, báº¡n cÃ³ thá»ƒ thay Ä‘á»•i chi tiáº¿t há»“ sÆ¡ vÃ  máº­t kháº©u cá»§a mÃ¬nh báº¥t cá»© lÃºc nÃ o.<br />\n<br />\nXin lÆ°u Ã½ ráº±ng náº¿u báº¡n cÃ³ thuÃª bao tá»• chá»©c, ngÆ°á»i dÃ¹ng táº¡i tá»• chá»©c cá»§a báº¡n khÃ´ng cáº§n pháº£i Ä‘Äƒng nháº­p, vÃ¬ cÃ¡c yÃªu cáº§u cho ná»™i dung thuÃª bao sáº½ Ä‘Æ°á»£c há»‡ thá»‘ng xÃ¡c thá»±c tá»± Ä‘á»™ng.<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.<br />\n<br />\n{$subscriptionSignature}'),(81,'OPEN_ACCESS_NOTIFY','en','Open Access Notify','Free to read: {$issueIdentification} of {$journalName} is now open access','<p>Dear {$recipientName},</p><p>We are pleased to inform you that <a href=\"{$issueUrl}\">{$issueIdentification}</a> of {$journalName} is now available under open access.  A subscription is no longer required to read this issue.</p><p>Thank you for your continuing interest in our work.</p>{$journalSignature}'),(82,'OPEN_ACCESS_NOTIFY','vi','','Äá»c miá»…n phÃ­: {$issueIdentification} cá»§a {$journalName} hiá»‡n cÃ³ quyá»n truy cáº­p má»Ÿ','KÃ­nh gá»­i  Äá»™c giáº£,<br />\n<br />\n{$journalName} vá»«a cÃ³ sáºµn má»™t sá»‘ cho phÃ©p truy cáº­p má»Ÿ. ChÃºng tÃ´i kÃ­nh má»i báº¡n tham kháº£o má»¥c lá»¥c táº¡i Ä‘Ã¢y vÃ  sau Ä‘Ã³ truy cáº­p trang web cá»§a chÃºng tÃ´i ({$journalUrl}) Ä‘á»ƒ xem chi tiáº¿t cÃ¡c bÃ i viáº¿t mÃ  báº¡n quan tÃ¢m.<br />\n<br />\nCÃ¡m Æ¡n sá»± quan tÃ¢m cá»§a báº¡n vá»›i cÃ¡c áº¥n pháº©m cá»§a chÃºng tÃ´i,<br />\n{$journalSignature}'),(83,'SUBSCRIPTION_BEFORE_EXPIRY','en','Subscription Expires Soon','Notice of Subscription Expiry','{$recipientName}:<br />\n<br />\nYour {$journalName} subscription is about to expire.<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nTo ensure the continuity of your access to this journal, please go to the journal website and renew your subscription. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),(84,'SUBSCRIPTION_BEFORE_EXPIRY','vi','','ThÃ´ng bÃ¡o háº¿t háº¡n thuÃª bao','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nThuÃª bao táº¡i {$journalName} sáº¯p háº¿t háº¡n<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nÄá»ƒ Ä‘áº£m báº£o tÃ­nh liÃªn tá»¥c khi truy cáº­p vÃ o táº¡p chÃ­ nÃ y, vui lÃ²ng truy cáº­p trang web táº¡p chÃ­ vÃ  gia háº¡n thuÃª bao cá»§a báº¡n. Báº¡n cÃ³ thá»ƒ Ä‘Äƒng nháº­p vÃ o há»‡ thá»‘ng báº±ng username cá»§a báº¡n, &quot;{$recipientUsername}&quot;.<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.<br />\n<br />\n{$subscriptionSignature}'),(85,'SUBSCRIPTION_AFTER_EXPIRY','en','Subscription Expired','Subscription Expired','{$recipientName}:<br />\n<br />\nYour {$journalName} subscription has expired.<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nTo renew your subscription, please go to the journal website. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),(86,'SUBSCRIPTION_AFTER_EXPIRY','vi','','ThuÃª bao háº¿t háº¡n','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nThuÃª bao táº¡i {$journalName} Ä‘Ã£ háº¿t háº¡n.<br />\n<br />\n{$subscriptionType}<br />\nNgÃ y háº¿t háº¡n: {$expiryDate}<br />\n<br />\nÄá»ƒ gia háº¡n thuÃª bao cá»§a báº¡n, vui lÃ²ng truy cáº­p trang web táº¡p chÃ­. Báº¡n cÃ³ thá»ƒ Ä‘Äƒng nháº­p vÃ o há»‡ thá»‘ng báº±ng username cá»§a báº¡n,&quot;{$recipientUsername}&quot;.<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.<br />\n<br />\n{$subscriptionSignature}'),(87,'SUBSCRIPTION_AFTER_EXPIRY_LAST','en','Subscription Expired Last','Subscription Expired - Final Reminder','{$recipientName}:<br />\n<br />\nYour {$journalName} subscription has expired.<br />\nPlease note that this is the final reminder that will be emailed to you.<br />\n<br />\n{$subscriptionType}<br />\nExpiry date: {$expiryDate}<br />\n<br />\nTo renew your subscription, please go to the journal website. You are able to log in to the system with your username, &quot;{$recipientUsername}&quot;.<br />\n<br />\nIf you have any questions, please feel free to contact me.<br />\n<br />\n{$subscriptionSignature}'),(88,'SUBSCRIPTION_AFTER_EXPIRY_LAST','vi','','ThuÃª bao Ä‘Ã£ háº¿t háº¡n - Nháº¯c nhá»Ÿ cuá»‘i cÃ¹ng','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nThuÃª bao táº¡i {$journalName} Ä‘Ã£ háº¿t háº¡n.<br />\nXin lÆ°u Ã½ ráº±ng Ä‘Ã¢y lÃ  lá»i nháº¯c cuá»‘i cÃ¹ng sáº½ Ä‘Æ°á»£c gá»­i qua email cho báº¡n.<br />\n<br />\n{$subscriptionType}<br />\nNgÃ y háº¿t háº¡n: {$expiryDate}<br />\n<br />\nÄá»ƒ gia háº¡n thuÃª bao cá»§a báº¡n, vui lÃ²ng truy cáº­p trang web táº¡p chÃ­. Báº¡n cÃ³ thá»ƒ Ä‘Äƒng nháº­p vÃ o há»‡ thá»‘ng báº±ng username cá»§a báº¡n, &quot;{$recipientUsername}&quot;.<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.<br />\n<br />\n{$subscriptionSignature}'),(89,'SUBSCRIPTION_PURCHASE_INDL','en','Purchase Individual Subscription','Subscription Purchase: Individual','An individual subscription has been purchased online for {$journalName} with the following details.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nUser:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),(90,'SUBSCRIPTION_PURCHASE_INDL','vi','','ÄÄƒng kÃ½ mua: CÃ¡ nhÃ¢n','Má»™t thuÃª bao cÃ¡ nhÃ¢n Ä‘Ã£ Ä‘Æ°á»£c mua trá»±c tuyáº¿n vá»›i {$journalName} vá»›i cÃ¡c chi tiáº¿t sau.<br />\n<br />\nKiá»ƒu thuÃª bao:<br />\n{$subscriptionType}<br />\n<br />\nUser:<br />\n{$subscriberDetails}<br />\n<br />\nThÃ´ng tin thÃ nh viÃªn (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$membership}<br />\n<br />\nÄá»ƒ xem hoáº·c chá»‰nh sá»­a Ä‘Äƒng kÃ½ nÃ y, vui lÃ²ng sá»­ dá»¥ng URL sau.<br />\n<br />\nURL thuÃª bao: {$subscriptionUrl}<br />\n'),(91,'SUBSCRIPTION_PURCHASE_INSTL','en','Purchase Institutional Subscription','Subscription Purchase: Institutional','An institutional subscription has been purchased online for {$journalName} with the following details. To activate this subscription, please use the provided Subscription URL and set the subscription status to \'Active\'.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nInstitution:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nDomain (if provided):<br />\n{$domain}<br />\n<br />\nIP Ranges (if provided):<br />\n{$ipRanges}<br />\n<br />\nContact Person:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),(92,'SUBSCRIPTION_PURCHASE_INSTL','vi','','ÄÄƒng kÃ½ mua: Tá»• chá»©c','Má»™t thuÃª bao tá»• chá»©c Ä‘Ã£ Ä‘Æ°á»£c mua trá»±c tuyáº¿n vá»›i {$journalName} vá»›i cÃ¡c chi tiáº¿t sau. Äá»ƒ kÃ­ch hoáº¡t Ä‘Äƒng kÃ½ nÃ y, vui lÃ²ng sá»­ dá»¥ng URL Ä‘Äƒng kÃ½ Ä‘Æ°á»£c cung cáº¥p vÃ  Ä‘áº·t tráº¡ng thÃ¡i Ä‘Äƒng kÃ½ thÃ nh \'KÃ­ch hoáº¡t\'.<br />\n<br />\nKiá»ƒu thuÃª bao:<br />\n{$subscriptionType}<br />\n<br />\nTá»• chá»©c:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nTÃªn miá»n (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$domain}<br />\n<br />\nPháº¡m vi IP (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$ipRanges}<br />\n<br />\nNgÆ°á»i liÃªn há»‡:<br />\n{$subscriberDetails}<br />\n<br />\nThÃ´ng tin thÃ nh viÃªn (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$membership}<br />\n<br />\nÄá»ƒ xem hoáº·c chá»‰nh sá»­a Ä‘Äƒng kÃ½ nÃ y, vui lÃ²ng sá»­ dá»¥ng URL sau.<br />\n<br />\nURL thuÃª bao: {$subscriptionUrl}<br />\n'),(93,'SUBSCRIPTION_RENEW_INDL','en','Renew Individual Subscription','Subscription Renewal: Individual','An individual subscription has been renewed online for {$journalName} with the following details.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nUser:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),(94,'SUBSCRIPTION_RENEW_INDL','vi','','Gia háº¡n thuÃª bao: CÃ¡ nhÃ¢n','Má»™t thuÃª bao cÃ¡ nhÃ¢n Ä‘Ã£ Ä‘Æ°á»£c gia háº¡n trá»±c tuyáº¿n vá»›i {$journalName} vá»›i cÃ¡c chi tiáº¿t sau.<br />\n<br />\nKiá»ƒu thuÃª bao:<br />\n{$subscriptionType}<br />\n<br />\nUser:<br />\n{$subscriberDetails}<br />\n<br />\nThÃ´ng tin thÃ nh viÃªn (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$membership}<br />\n<br />\nÄá»ƒ xem hoáº·c chá»‰nh sá»­a Ä‘Äƒng kÃ½ nÃ y, vui lÃ²ng sá»­ dá»¥ng URL sau.<br />\n<br />\nURL thuÃª bao: {$subscriptionUrl}<br />\n'),(95,'SUBSCRIPTION_RENEW_INSTL','en','Renew Institutional Subscription','Subscription Renewal: Institutional','An institutional subscription has been renewed online for {$journalName} with the following details.<br />\n<br />\nSubscription Type:<br />\n{$subscriptionType}<br />\n<br />\nInstitution:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nDomain (if provided):<br />\n{$domain}<br />\n<br />\nIP Ranges (if provided):<br />\n{$ipRanges}<br />\n<br />\nContact Person:<br />\n{$subscriberDetails}<br />\n<br />\nMembership Information (if provided):<br />\n{$membership}<br />\n<br />\nTo view or edit this subscription, please use the following URL.<br />\n<br />\nSubscription URL: {$subscriptionUrl}<br />\n'),(96,'SUBSCRIPTION_RENEW_INSTL','vi','','Gia háº¡n thuÃª bao: Tá»• chá»©c','An institutional subscription has been renewed online for {$journalName} with the following details.<br />\n<br />\nKiá»ƒu thuÃª bao:<br />\n{$subscriptionType}<br />\n<br />\nTá»• chá»©c:<br />\n{$institutionName}<br />\n{$institutionMailingAddress}<br />\n<br />\nTÃªn miá»n (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$domain}<br />\n<br />\nPháº¡m vi IP (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$ipRanges}<br />\n<br />\nNgÆ°á»i liÃªn há»‡:<br />\n{$subscriberDetails}<br />\n<br />\nThÃ´ng tin thÃ nh viÃªn (náº¿u Ä‘Æ°á»£c cung cáº¥p):<br />\n{$membership}<br />\n<br />\nÄá»ƒ xem hoáº·c chá»‰nh sá»­a Ä‘Äƒng kÃ½ nÃ y, vui lÃ²ng sá»­ dá»¥ng URL sau.<br />\n<br />\nURL thuÃª bao: {$subscriptionUrl}<br />\n'),(97,'REVISED_VERSION_NOTIFY','en','Revised Version Notification','Revised Version Uploaded','<p>Dear {$recipientName},</p><p>The author has uploaded revisions for the submission, <b>{$authorsShort} â€” {$submissionTitle}</b>. <p>As an assigned editor, we ask that you login and <a href=\"{$submissionUrl}\">view the revisions</a> and make a decision to accept, decline or send the submission for further review.</p><br><br>â€”<br>This is an automated message from <a href=\"{$journalUrl}\">{$journalName}</a>.'),(98,'REVISED_VERSION_NOTIFY','vi','','Táº£i lÃªn báº£n sá»­a chá»¯a','KÃ­nh gá»­i BiÃªn táº­p viÃªn,<br />\n<br />\nMá»™t báº£n sá»­a chá»¯a cá»§a bÃ i gá»­i &quot;{$submissionTitle}&quot; Ä‘Ã£ Ä‘Æ°á»£c táº£i lÃªn bá»Ÿi tÃ¡c giáº£ {$submitterName}.<br />\n<br />\nURL bÃ i gá»­i: {$submissionUrl}<br />\n<br />\n{$signature}'),(99,'STATISTICS_REPORT_NOTIFICATION','en','Statistics Report Notification','Editorial activity for {$month}, {$year}','\n{$recipientName}, <br />\n<br />\nYour journal health report for {$month}, {$year} is now available. Your key stats for this month are below.<br />\n<ul>\n	<li>New submissions this month: {$newSubmissions}</li>\n	<li>Declined submissions this month: {$declinedSubmissions}</li>\n	<li>Accepted submissions this month: {$acceptedSubmissions}</li>\n	<li>Total submissions in the system: {$totalSubmissions}</li>\n</ul>\nLogin to the journal to view more detailed <a href=\"{$editorialStatsLink}\">editorial trends</a> and <a href=\"{$publicationStatsLink}\">published article stats</a>. A full copy of this month\'s editorial trends is attached.<br />\n<br />\nSincerely,<br />\n{$journalSignature}'),(100,'STATISTICS_REPORT_NOTIFICATION','vi','','Hoáº¡t Ä‘á»™ng cho {$month}, {$year}','\n{$recipientName}, <br />\n<br />\nBÃ¡o cÃ¡o tÃ¬nh tráº¡ng hoáº¡t Ä‘á»™ng cá»§a táº¡p chÃ­ vÃ o {$month}, {$year} Ä‘Ã£ cÃ³. Sá»‘ liá»‡u thá»‘ng kÃª quan trá»ng cá»§a táº¡p chÃ­ trong thÃ¡ng nÃ y hiá»ƒn thá»‹ á»Ÿ dÆ°á»›i Ä‘Ã¢y.<br />\n<ul>\n	<li>BÃ i gá»­i má»›i trong thÃ¡ng nÃ y: {$newSubmissions}</li>\n	<li>BÃ i tá»« chá»‘i trong thÃ¡ng nÃ y: {$declinedSubmissions}</li>\n	<li>BÃ i Ä‘á»“ng Ã½ Ä‘Äƒng trong thÃ¡ng nÃ y: {$acceptedSubmissions}</li>\n	<li>Tá»•ng sá»‘ bÃ i trÃªn há»‡ thá»‘ng: {$totalSubmissions}</li>\n</ul>\nÄÄƒng nháº­p vÃ o táº¡p chÃ­ Ä‘á»ƒ xem chi tiáº¿t hÆ¡n <a href=\"{$editorialStatsLink}\">xu tháº¿</a> vÃ  <a href=\"{$publicationStatsLink}\">sá»‘ liá»‡u thá»‘ng kÃª bÃ i bÃ¡o</a>. Má»™t báº£n sao Ä‘áº§y Ä‘á»§ cá»§a cÃ¡c xu tháº¿ trong thÃ¡ng nÃ y Ä‘Æ°á»£c Ä‘Ã­nh kÃ¨m.<br />\n<br />\nTrÃ¢n trá»ng,<br />\n{$journalSignature}'),(101,'ANNOUNCEMENT','en','New Announcement','{$announcementTitle}','<b>{$announcementTitle}</b><br />\n<br />\n{$announcementSummary}<br />\n<br />\nVisit our website to read the <a href=\"{$announcementUrl}\">full announcement</a>.'),(102,'ANNOUNCEMENT','vi','','{$announcementTitle}','<b>{$announcementTitle}</b><br />\n<br />\n{$announcementSummary}<br />\n<br />\nGhÃ© thÄƒm trang web cá»§a chÃºng tÃ´i Ä‘á»ƒ Ä‘á»c <a href=\"{$announcementUrl}\">thÃ´ng bÃ¡o Ä‘áº§y Ä‘á»§</a>.'),(103,'DISCUSSION_NOTIFICATION_SUBMISSION','en','Discussion (Submission)','A message regarding {$journalName}','Please enter your message.'),(104,'DISCUSSION_NOTIFICATION_SUBMISSION','vi','','Má»™t thÃ´ng bÃ¡o liÃªn quan Ä‘áº¿n {$journalName}','Vui lÃ²ng nháº­p tin nháº¯n cá»§a báº¡n.'),(105,'DISCUSSION_NOTIFICATION_REVIEW','en','Discussion (Review)','A message regarding {$journalName}','Please enter your message.'),(106,'DISCUSSION_NOTIFICATION_REVIEW','vi','','Má»™t thÃ´ng bÃ¡o liÃªn quan Ä‘áº¿n {$journalName}','Vui lÃ²ng nháº­p tin nháº¯n cá»§a báº¡n.'),(107,'DISCUSSION_NOTIFICATION_COPYEDITING','en','Discussion (Copyediting)','A message regarding {$journalName}','Please enter your message.'),(108,'DISCUSSION_NOTIFICATION_COPYEDITING','vi','','Má»™t thÃ´ng bÃ¡o liÃªn quan Ä‘áº¿n {$journalName}','Vui lÃ²ng nháº­p tin nháº¯n cá»§a báº¡n.'),(109,'DISCUSSION_NOTIFICATION_PRODUCTION','en','Discussion (Production)','A message regarding {$journalName}','Please enter your message.'),(110,'DISCUSSION_NOTIFICATION_PRODUCTION','vi','','Má»™t thÃ´ng bÃ¡o liÃªn quan Ä‘áº¿n {$journalName}','Vui lÃ²ng nháº­p tin nháº¯n cá»§a báº¡n.'),(111,'COPYEDIT_REQUEST','en','Request Copyedit','Submission {$submissionId} is ready to be copyedited for {$contextAcronym}','<p>Dear {$recipientName},</p><p>A new submission is ready to be copyedited:</p><p><a href\"{$submissionUrl}\">{$submissionId} â€” {$submissionTitle}</a><br />{$journalName}</p><p>Please follow these steps to complete this task:</p><ol><li>Click on the Submission URL below.</li><li>Open any files available under Draft Files and edit the files. Use the Copyediting Discussions area if you need to contact the editor(s) or author(s).</li><li>Save the copyedited file(s) and upload them to the Copyedited panel.</li><li>Use the Copyediting Discussions to notify the editor(s) that all files have been prepared, and that the Production process may begin.</li></ol><p>If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to {$journalName}.</p><p>Kind regards,</p>{$signature}'),(112,'COPYEDIT_REQUEST','vi','','YÃªu cáº§u biÃªn táº­p báº£n tháº£o','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nTÃ´i muá»‘n yÃªu cáº§u báº¡n thá»±c hiá»‡n viá»‡c biÃªn táº­p báº£n tháº£o &quot;{$submissionTitle}&quot; cho {$journalName} báº±ng cÃ¡ch lÃ m theo cÃ¡c bÆ°á»›c sau.<br />\n1. Nháº¥p vÃ o URL gá»­i dÆ°á»›i Ä‘Ã¢y.<br />\n2. Má»Ÿ báº¥t ká»³ táº­p tin cÃ³ sáºµn á»Ÿ má»¥c NhÃ¡p vÃ  biÃªn táº­p báº£n tháº£o Ä‘Ã³, Ä‘á»“ng thá»i cÃ³ thá»ƒ tháº£o luáº­n báº¥t ká»³ Ä‘iá»u gÃ¬ náº¿u cáº§n thiáº¿t trong má»¥c tháº£o luáº­n báº£n tháº£o.<br />\n3. LÆ°u (cÃ¡c) táº­p tin Ä‘Ã£ biÃªn táº­p báº£n tháº£o vÃ  táº£i lÃªn.<br />\n4. ThÃ´ng bÃ¡o cho cÃ¡c biÃªn táº­p viÃªn mÃ  táº¥t cáº£ cÃ¡c file Ä‘Ã£ Ä‘Æ°á»£c chuáº©n bá»‹, vÃ  ráº±ng quÃ¡ trÃ¬nh cháº¿ báº£n cÃ³ thá»ƒ báº¯t Ä‘áº§u.<br />\n<br />\n{$journalName} URL: {$journalUrl}<br />\nURL bÃ i gá»­i: {$submissionUrl}<br />\nUsername: {$recipientUsername}'),(113,'EDITOR_ASSIGN_SUBMISSION','en','Assign Editor','You have been assigned as an editor on a submission to {$journalName}','<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the editorial process.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>If you find the submission to be relevant for {$journalName}, please forward the submission to the review stage by selecting \"Send to Review\" and then assign reviewers by clicking \"Add Reviewer\".</p><p>If the submission is not appropriate for this journal, please decline the submission.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$journalSignature}'),(114,'EDITOR_ASSIGN_SUBMISSION','vi','','Báº¡n Ä‘Ã£ Ä‘Æ°á»£c chá»‰ Ä‘á»‹nh lÃ  ngÆ°á»i biÃªn táº­p cho bÃ i gá»­i {$journalName}','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nBÃ i gá»­i, &quot;{$submissionTitle},&quot; cá»§a {$journalName} Ä‘Ã£ Ä‘Æ°á»£c phÃ¢n cÃ´ng cho báº¡n Ä‘á»ƒ xem qua quy trÃ¬nh biÃªn táº­p vá»›i vai trÃ² lÃ  BiÃªn táº­p viÃªn chuyÃªn má»¥c.<br />\n<br />\nURL bÃ i gá»­i: {$submissionUrl}<br />\nUsername: {$recipientUsername}<br />\n<br />\nTrÃ¢n trá»ng.'),(115,'EDITOR_ASSIGN_REVIEW','en','Assign Editor','You have been assigned as an editor on a submission to {$journalName}','<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the peer review process.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please login to <a href=\"{$submissionUrl}\">view the submission</a> and assign qualified reviewers. You can assign a reviewer by clicking \"Add Reviewer\".</p><p>Thank you in advance.</p><p>Kind regards,</p>{$signature}'),(116,'EDITOR_ASSIGN_REVIEW','vi','','Báº¡n Ä‘Ã£ Ä‘Æ°á»£c chá»‰ Ä‘á»‹nh lÃ  ngÆ°á»i biÃªn táº­p cho bÃ i gá»­i {$journalName}','<p>KÃ­nh gá»­i {$recipientName},</p><p>BÃ i gá»­i sau Ä‘Ã¢y Ä‘Ã£ Ä‘Æ°á»£c giao cho báº¡n Ä‘á»ƒ tá»• chá»©c pháº£n biá»‡n kÃ­n.</p><p><a href=\"{$submissionUrl}\"> {$submissionTitle</a><br />{$authors</p><p><b>TÃ³m táº¯t</b></p>{$submissionAbstract<p>Vui lÃ²ng Ä‘Äƒng nháº­p vÃ o <a href=\" {$submissionUrl}\">xem ná»™i dung gá»­i</a> vÃ  chá»‰ Ä‘á»‹nh ngÆ°á»i Ä‘Ã¡nh giÃ¡ Ä‘á»§ tiÃªu chuáº©n. Báº¡n cÃ³ thá»ƒ chá»‰ Ä‘á»‹nh ngÆ°á»i Ä‘Ã¡nh giÃ¡ báº±ng cÃ¡ch nháº¥p vÃ o \"ThÃªm ngÆ°á»i Ä‘Ã¡nh giÃ¡\".</p><p>Cáº£m Æ¡n báº¡n trÆ°á»›c.</p><p>TrÃ¢n trá»ng,</p>{$signature}'),(117,'EDITOR_ASSIGN_PRODUCTION','en','Assign Editor','You have been assigned as an editor on a submission to {$journalName}','<p>Dear {$recipientName},</p><p>The following submission has been assigned to you to see through the production stage.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please login to <a href=\"{$submissionUrl}\">view the submission</a>. Once production-ready files are available, upload them under the <strong>Publication > Galleys</strong> section. Then schedule the work for publication by clicking the <strong>Schedule for Publication</strong> button.</p><p>Thank you in advance.</p><p>Kind regards,</p>{$signature}'),(118,'EDITOR_ASSIGN_PRODUCTION','vi','','Báº¡n Ä‘Ã£ Ä‘Æ°á»£c chá»‰ Ä‘á»‹nh lÃ  ngÆ°á»i biÃªn táº­p cho bÃ i gá»­i {$journalName}',''),(119,'LAYOUT_REQUEST','en','Ready for Production','Submission {$submissionId} is ready for production at {$contextAcronym}','<p>Dear {$recipientName},</p><p>A new submission is ready for layout editing:</p><p><a href=\"{$submissionUrl}\">{$submissionId} â€” {$submissionTitle}</a><br />{$journalName}</p><ol><li>Click on the Submission URL above.</li><li>Download the Production Ready files and use them to create the galleys according to the journal\'s standards.</li><li>Upload the galleys to the Publication section of the submission.</li><li>Use the  Production Discussions to notify the editor that the galleys are ready.</li></ol><p>If you are unable to undertake this work at this time or have any questions, please contact me. Thank you for your contribution to this journal.</p><p>Kind regards,</p>{$signature}'),(120,'LAYOUT_REQUEST','vi','','BÃ i gá»­i {$submissionId} Ä‘Ã£ sáºµn sÃ ng xuáº¥t báº£n á»Ÿ {$contextAcronym}','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nBÃ i gá»­i &quot;{$submissionTitle}&quot; Ä‘áº¿n {$journalName} bÃ¢y giá» cáº§n báº£n in báº±ng cÃ¡ch lÃ m theo cÃ¡c bÆ°á»›c sau.<br />\n1. Nháº¥p vÃ o URL gá»­i dÆ°á»›i Ä‘Ã¢y.<br />\n2. ÄÄƒng nháº­p vÃ o táº¡p chÃ­ vÃ  sá»­ dá»¥ng cÃ¡c táº­p tin sáºµn sÃ ng cháº¿ báº£n Ä‘á»ƒ táº¡o ra cÃ¡c báº£n in theo tiÃªu chuáº©n cá»§a táº¡p chÃ­.<br />\n3. Táº£i cÃ¡c báº£n in thá»­ vÃ o táº­p tin Báº£n in<br />\n4. ThÃ´ng bÃ¡o cho BiÃªn táº­p viÃªn báº±ng má»¥c tháº£o luáº­n khi cháº¿ báº£n ráº±ng cÃ¡c báº£n in Ä‘Æ°á»£c táº£i lÃªn vÃ  sáºµn sÃ ng.<br />\n<br />\n{$journalName} URL: {$journalUrl}<br />\nURL bÃ i gá»­i: {$submissionUrl}<br />\nUsername: {$recipientUsername}<br />\n<br />\nNáº¿u báº¡n khÃ´ng thá»ƒ thá»±c hiá»‡n cÃ´ng viá»‡c nÃ y vÃ o lÃºc nÃ y hoáº·c cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i tÃ´i. Cáº£m Æ¡n báº¡n Ä‘Ã£ Ä‘Ã³ng gÃ³p cho táº¡p chÃ­ nÃ y.'),(121,'LAYOUT_COMPLETE','en','Galleys Complete','Galleys Complete','<p>Dear {$recipientName},</p><p>Galleys have now been prepared for the following submission and are ready for final review.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$journalName}</p><p>If you have any questions, please contact me.</p><p>Kind regards,</p><p>{$signature}</p>'),(122,'LAYOUT_COMPLETE','vi','','HoÃ n thÃ nh báº£n in','KÃ­nh gá»­i {$recipientName},<br />\n<br />\nBáº£n in hiá»‡n Ä‘Ã£ Ä‘Æ°á»£c chuáº©n bá»‹ cho báº£n tháº£o, &quot;{$submissionTitle},&quot; cá»§a {$journalName} vÃ  sáºµn sÃ ng cho hiá»‡u Ä‘Ã­nh.<br />\n<br />\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i nÃ o, xin vui lÃ²ng liÃªn há»‡ vá»›i chÃºng tÃ´i.<br />\n<br />\n{$senderName}'),(123,'VERSION_CREATED','en','Version Created','A new version was created for {$submissionTitle}','<p>Dear {$recipientName}, </p><p>This is an automated message to inform you that a new version of your submission, {$submissionTitle}, was created. You can view this version from your submission dashboard at the following link:</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a></p><hr><p>This is an automatic email sent from <a href=\"{$journalUrl}\">{$journalName}</a>.</p>'),(124,'VERSION_CREATED','vi','','',''),(125,'EDITORIAL_REMINDER','en','Editorial Reminder','Outstanding editorial tasks for {$journalName}','<p>Dear {$recipientName},</p><p>You are currently assigned to {$numberOfSubmissions} submissions in <a href=\"{$journalUrl}\">{$journalName}</a>. The following submissions are <b>waiting for your response</b>.</p>{$outstandingTasks}<p>View all of your assignments in your <a href=\"{$submissionsUrl}\">submission dashboard</a>.</p><p>If you have any questions about your assignments, please contact {$contactName} at {$contactEmail}.</p>'),(126,'EDITORIAL_REMINDER','vi','','',''),(127,'SUBMISSION_SAVED_FOR_LATER','en','Submission Saved for Later','Resume your submission to {$journalName}','<p>Dear {$recipientName},</p><p>Your submission details have been saved in our system, but it has not yet been submitted for consideration. You can return to complete your submission at any time by following the link below.</p><p><a href=\"{$submissionWizardUrl}\">{$authorsShort} â€” {$submissionTitle}</a></p><hr><p>This is an automated email from <a href=\"{$journalUrl}\">{$journalName}</a>.</p>'),(128,'SUBMISSION_SAVED_FOR_LATER','vi','','',''),(129,'SUBMISSION_NEEDS_EDITOR','en','Submission Needs Editor','A new submission needs an editor to be assigned: {$submissionTitle}','<p>Dear {$recipientName},</p><p>The following submission has been submitted and there is no editor assigned.</p><p><a href=\"{$submissionUrl}\">{$submissionTitle}</a><br />{$authors}</p><p><b>Abstract</b></p>{$submissionAbstract}<p>Please assign an editor who will be responsible for the submission by clicking the title above and assigning an editor under the Participants section.</p><hr><p>This is an automated email from <a href=\"{$journalUrl}\">{$journalName}</a>.</p>'),(130,'SUBMISSION_NEEDS_EDITOR','vi','','',''),(131,'PAYMENT_REQUEST_NOTIFICATION','en','Payment Request','Payment Request Notification','<p>Dear {$recipientName},</p><p>Congratulations on the acceptance of your submission, {$submissionTitle}, to {$journalName}. Now that your submission has been accepted, we would like to request payment of the publication fee.</p><p>This fee covers the production costs of bringing your submission to publication. To make the payment, please visit <a href=\"{$queuedPaymentUrl}\">{$queuedPaymentUrl}</a>.</p><p>If you have any questions, please see our <a href=\"{$submissionGuidelinesUrl}\">Submission Guidelines</a></p>'),(132,'PAYMENT_REQUEST_NOTIFICATION','vi','','ThÃ´ng bÃ¡o yÃªu cáº§u thanh toÃ¡n',''),(133,'ORCID_COLLECT_AUTHOR_ID','en','orcidCollectAuthorId','Submission ORCID','Dear {$recipientName},<br/>\n<br/>\nYou have been listed as an author on a manuscript submission to {$journalName}.<br/>\nTo confirm your authorship, please add your ORCID id to this submission by visiting the link provided below.<br/>\n<br/>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Register or connect your ORCID iD</a><br/>\n<br/>\n<br>\n<a href=\"{$orcidAboutUrl}\">More information about ORCID at {$journalName}</a><br/>\n<br/>\nIf you have any questions, please contact me.<br/>\n<br/>\n{$principalContactSignature}<br/>\n'),(134,'ORCID_COLLECT_AUTHOR_ID','vi','','Gá»­i ORCID','KÃ­nh gá»­i {$recipientName},<br/>\n<br/>\nBáº¡n Ä‘Ã£ Ä‘Æ°á»£c liá»‡t kÃª nhÆ° lÃ  má»™t tÃ¡c giáº£ trÃªn má»™t báº£n tháº£o Ä‘á»ƒ {$journalName}.<br/>\nÄá»ƒ xÃ¡c nháº­n quyá»n tÃ¡c giáº£ cá»§a báº¡n, vui lÃ²ng thÃªm id ORCID cá»§a báº¡n vÃ o bÃ i Ä‘Äƒng nÃ y báº±ng cÃ¡ch truy cáº­p liÃªn káº¿t Ä‘Æ°á»£c cung cáº¥p bÃªn dÆ°á»›i.<br/>\n<br/>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://orcid.org/sites/default/files/images/orcid_16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Register or connect your ORCID iD</a><br/>\n<br/>\n<br>\n<a href=\"{$orcidAboutUrl}\">ThÃ´ng tin thÃªm vá» ORCID táº¡i {$journalName}</a><br/>\n<br/>\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i, xin vui lÃ²ng liÃªn há»‡ vá»›i tÃ´i.<br/>\n<br/>\n{$principalContactSignature}<br/>\n'),(135,'ORCID_REQUEST_AUTHOR_AUTHORIZATION','en','orcidRequestAuthorAuthorization','Requesting ORCID record access','Dear {$recipientName},<br>\n<br>\nYou have been listed as an author on the manuscript submission \"{$submissionTitle}\" to {$journalName}.\n<br>\n<br>\nPlease allow us to add your ORCID id to this submission and also to add the submission to your ORCID profile on publication.<br>\nVisit the link to the official ORCID website, login with your profile and authorize the access by following the instructions.<br>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://info.orcid.org/wp-content/uploads/2020/12/ORCIDiD_icon16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>Register or Connect your ORCID iD</a><br/>\n<br>\n<br>\n<a href=\"{$orcidAboutUrl}\">More about ORCID at {$journalName}</a><br/>\n<br>\nIf you have any questions, please contact me.<br>\n<br>\n{$principalContactSignature}<br>\n'),(136,'ORCID_REQUEST_AUTHOR_AUTHORIZATION','vi','','YÃªu cáº§u truy cáº­p báº£n ghi ORCID','KÃ­nh gá»­i {$recipientName},<br>\n<br>\nBáº¡n Ä‘Ã£ Ä‘Æ°á»£c liá»‡t kÃª nhÆ° lÃ  má»™t tÃ¡c giáº£ cá»§a báº£n tháº£o \"{$submissionTitle}\" to {$journalName}.\n<br>\n<br>\nVui lÃ²ng cho phÃ©p chÃºng tÃ´i thÃªm id ORCID cá»§a báº¡n vÃ o bÃ i Ä‘Äƒng nÃ y vÃ  cÅ©ng Ä‘á»ƒ thÃªm bÃ i Ä‘Äƒng vÃ o há»“ sÆ¡ ORCID cá»§a báº¡n trÃªn xuáº¥t báº£n.<br>\nTruy cáº­p liÃªn káº¿t Ä‘áº¿n trang web ORCID chÃ­nh thá»©c, Ä‘Äƒng nháº­p vá»›i há»“ sÆ¡ cá»§a báº¡n vÃ  cho phÃ©p truy cáº­p báº±ng cÃ¡ch lÃ m theo cÃ¡c hÆ°á»›ng dáº«n.<br>\n<a href=\"{$authorOrcidUrl}\"><img id=\"orcid-id-logo\" src=\"https://orcid.org/sites/default/files/images/orcid_16x16.png\" width=\'16\' height=\'16\' alt=\"ORCID iD icon\" style=\"display: block; margin: 0 .5em 0 0; padding: 0; float: left;\"/>ÄÄƒng kÃ½ hoáº·c káº¿t ná»‘i ORCID iD cá»§a báº¡n</a><br/>\n<br>\n<br>\n<a href=\"{$orcidAboutUrl}\">TÃ¬m hiá»ƒu thÃªm vá» ORCID táº¡i {$journalName}</a><br/>\n<br>\nNáº¿u báº¡n cÃ³ báº¥t ká»³ cÃ¢u há»i, xin vui lÃ²ng liÃªn há»‡ vá»›i tÃ´i.<br>\n<br>\n{$principalContactSignature}<br>\n'),(137,'MANUAL_PAYMENT_NOTIFICATION','en','Manual Payment Notify','Manual Payment Notification','A manual payment needs to be processed for the journal {$journalName} and the user {senderName} (username &quot;{$senderUsername}&quot;).<br />\n<br />\nThe item being paid for is &quot;{$paymentName}&quot;.<br />\nThe cost is {$paymentAmount} ({$paymentCurrencyCode}).<br />\n<br />\nThis email was generated by Open Journal Systems\' Manual Payment plugin.'),(138,'MANUAL_PAYMENT_NOTIFICATION','vi','','','');
/*!40000 ALTER TABLE `email_templates_default_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_templates_settings`
--

DROP TABLE IF EXISTS `email_templates_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_templates_settings` (
  `email_template_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `email_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`email_template_setting_id`),
  UNIQUE KEY `email_templates_settings_unique` (`email_id`,`locale`,`setting_name`),
  KEY `email_templates_settings_email_id` (`email_id`),
  CONSTRAINT `email_templates_settings_email_id` FOREIGN KEY (`email_id`) REFERENCES `email_templates` (`email_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about custom email templates, including localized properties such as the subject and body.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_templates_settings`
--

LOCK TABLES `email_templates_settings` WRITE;
/*!40000 ALTER TABLE `email_templates_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `email_templates_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log`
--

DROP TABLE IF EXISTS `event_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `user_id` bigint DEFAULT NULL COMMENT 'NULL if it''s system or automated event',
  `date_logged` datetime NOT NULL,
  `event_type` bigint DEFAULT NULL,
  `message` text,
  `is_translated` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`log_id`),
  KEY `event_log_user_id` (`user_id`),
  KEY `event_log_assoc` (`assoc_type`,`assoc_id`),
  CONSTRAINT `event_log_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='A log of all events related to an object like a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log`
--

LOCK TABLES `event_log` WRITE;
/*!40000 ALTER TABLE `event_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_log_settings`
--

DROP TABLE IF EXISTS `event_log_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_log_settings` (
  `event_log_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `log_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`event_log_setting_id`),
  UNIQUE KEY `event_log_settings_unique` (`log_id`,`setting_name`,`locale`),
  KEY `event_log_settings_log_id` (`log_id`),
  KEY `event_log_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  CONSTRAINT `event_log_settings_log_id` FOREIGN KEY (`log_id`) REFERENCES `event_log` (`log_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Data about an event log entry. This data is commonly used to display information about an event to a user.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_log_settings`
--

LOCK TABLES `event_log_settings` WRITE;
/*!40000 ALTER TABLE `event_log_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `event_log_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A log of all failed jobs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `files`
--

DROP TABLE IF EXISTS `files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `files` (
  `file_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `mimetype` varchar(255) NOT NULL,
  PRIMARY KEY (`file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Records information in the database about files tracked by the system, linking them to the local filesystem.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `files`
--

LOCK TABLES `files` WRITE;
/*!40000 ALTER TABLE `files` DISABLE KEYS */;
/*!40000 ALTER TABLE `files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_groups`
--

DROP TABLE IF EXISTS `filter_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filter_groups` (
  `filter_group_id` bigint NOT NULL AUTO_INCREMENT,
  `symbolic` varchar(255) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `input_type` varchar(255) DEFAULT NULL,
  `output_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`filter_group_id`),
  UNIQUE KEY `filter_groups_symbolic` (`symbolic`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COMMENT='Filter groups are used to organized filters into named sets, which can be retrieved by the application for invocation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_groups`
--

LOCK TABLES `filter_groups` WRITE;
/*!40000 ALTER TABLE `filter_groups` DISABLE KEYS */;
INSERT INTO `filter_groups` VALUES (1,'issue=>crossref-xml','plugins.importexport.crossref.displayName','plugins.importexport.crossref.description','class::classes.issue.Issue[]','xml::schema(https://www.crossref.org/schemas/crossref5.3.1.xsd)'),(2,'article=>crossref-xml','plugins.importexport.crossref.displayName','plugins.importexport.crossref.description','class::classes.submission.Submission[]','xml::schema(https://www.crossref.org/schemas/crossref5.3.1.xsd)'),(3,'issue=>datacite-xml','plugins.importexport.datacite.displayName','plugins.importexport.datacite.description','class::classes.issue.Issue','xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),(4,'article=>datacite-xml','plugins.importexport.datacite.displayName','plugins.importexport.datacite.description','class::classes.submission.Submission','xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),(5,'galley=>datacite-xml','plugins.importexport.datacite.displayName','plugins.importexport.datacite.description','class::lib.pkp.classes.galley.Galley','xml::schema(http://schema.datacite.org/meta/kernel-4/metadata.xsd)'),(6,'article=>dc11','plugins.metadata.dc11.articleAdapter.displayName','plugins.metadata.dc11.articleAdapter.description','class::classes.submission.Submission','metadata::APP\\plugins\\metadata\\dc11\\schema\\Dc11Schema(ARTICLE)'),(7,'article=>doaj-xml','plugins.importexport.doaj.displayName','plugins.importexport.doaj.description','class::classes.submission.Submission[]','xml::schema(plugins/importexport/doaj/doajArticles.xsd)'),(8,'article=>doaj-json','plugins.importexport.doaj.displayName','plugins.importexport.doaj.description','class::classes.submission.Submission','primitive::string'),(9,'article=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.submission.Submission[]','xml::schema(plugins/importexport/native/native.xsd)'),(10,'native-xml=>article','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.submission.Submission[]'),(11,'issue=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.issue.Issue[]','xml::schema(plugins/importexport/native/native.xsd)'),(12,'native-xml=>issue','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.issue.Issue[]'),(13,'issuegalley=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.issue.IssueGalley[]','xml::schema(plugins/importexport/native/native.xsd)'),(14,'native-xml=>issuegalley','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.issue.IssueGalley[]'),(15,'author=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.author.Author[]','xml::schema(plugins/importexport/native/native.xsd)'),(16,'native-xml=>author','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.author.Author[]'),(17,'SubmissionFile=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::lib.pkp.classes.submissionFile.SubmissionFile','xml::schema(plugins/importexport/native/native.xsd)'),(18,'native-xml=>SubmissionFile','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::lib.pkp.classes.submissionFile.SubmissionFile[]'),(19,'article-galley=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::lib.pkp.classes.galley.Galley','xml::schema(plugins/importexport/native/native.xsd)'),(20,'native-xml=>ArticleGalley','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::lib.pkp.classes.galley.Galley[]'),(21,'publication=>native-xml','plugins.importexport.native.displayName','plugins.importexport.native.description','class::classes.publication.Publication','xml::schema(plugins/importexport/native/native.xsd)'),(22,'native-xml=>Publication','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(plugins/importexport/native/native.xsd)','class::classes.publication.Publication[]'),(23,'article=>pubmed-xml','plugins.importexport.pubmed.displayName','plugins.importexport.pubmed.description','class::classes.submission.Submission[]','xml::dtd'),(24,'user=>user-xml','plugins.importexport.users.displayName','plugins.importexport.users.description','class::lib.pkp.classes.user.User[]','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)'),(25,'user-xml=>user','plugins.importexport.users.displayName','plugins.importexport.users.description','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)','class::classes.users.User[]'),(26,'usergroup=>user-xml','plugins.importexport.users.displayName','plugins.importexport.users.description','class::lib.pkp.classes.security.UserGroup[]','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)'),(27,'user-xml=>usergroup','plugins.importexport.native.displayName','plugins.importexport.native.description','xml::schema(lib/pkp/plugins/importexport/users/pkp-users.xsd)','class::lib.pkp.classes.security.UserGroup[]');
/*!40000 ALTER TABLE `filter_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filter_settings`
--

DROP TABLE IF EXISTS `filter_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filter_settings` (
  `filter_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `filter_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`filter_setting_id`),
  UNIQUE KEY `filter_settings_unique` (`filter_id`,`locale`,`setting_name`),
  KEY `filter_settings_id` (`filter_id`),
  CONSTRAINT `filter_settings_filter_id_foreign` FOREIGN KEY (`filter_id`) REFERENCES `filters` (`filter_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about filters, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filter_settings`
--

LOCK TABLES `filter_settings` WRITE;
/*!40000 ALTER TABLE `filter_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `filter_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `filters`
--

DROP TABLE IF EXISTS `filters`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `filters` (
  `filter_id` bigint NOT NULL AUTO_INCREMENT,
  `filter_group_id` bigint NOT NULL DEFAULT '0',
  `context_id` bigint NOT NULL DEFAULT '0',
  `display_name` varchar(255) DEFAULT NULL,
  `class_name` varchar(255) DEFAULT NULL,
  `is_template` smallint NOT NULL DEFAULT '0',
  `parent_filter_id` bigint NOT NULL DEFAULT '0',
  `seq` bigint NOT NULL DEFAULT '0',
  PRIMARY KEY (`filter_id`),
  KEY `filters_filter_group_id` (`filter_group_id`),
  CONSTRAINT `filters_filter_group_id_foreign` FOREIGN KEY (`filter_group_id`) REFERENCES `filter_groups` (`filter_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8mb3 COMMENT='Filters represent a transformation of a supported piece of data from one form to another, such as a PHP object into an XML document.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `filters`
--

LOCK TABLES `filters` WRITE;
/*!40000 ALTER TABLE `filters` DISABLE KEYS */;
INSERT INTO `filters` VALUES (1,1,0,'Crossref XML issue export','APP\\plugins\\generic\\crossref\\filter\\IssueCrossrefXmlFilter',0,0,0),(2,2,0,'Crossref XML article export','APP\\plugins\\generic\\crossref\\filter\\ArticleCrossrefXmlFilter',0,0,0),(3,3,0,'DataCite XML export','APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter',0,0,0),(4,4,0,'DataCite XML export','APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter',0,0,0),(5,5,0,'DataCite XML export','APP\\plugins\\generic\\datacite\\filter\\DataciteXmlFilter',0,0,0),(6,6,0,'Extract metadata from a(n) Submission','APP\\plugins\\metadata\\dc11\\filter\\Dc11SchemaArticleAdapter',0,0,0),(7,7,0,'DOAJ XML export','APP\\plugins\\importexport\\doaj\\filter\\DOAJXmlFilter',0,0,0),(8,8,0,'DOAJ JSON export','APP\\plugins\\importexport\\doaj\\filter\\DOAJJsonFilter',0,0,0),(9,9,0,'Native XML submission export','APP\\plugins\\importexport\\native\\filter\\ArticleNativeXmlFilter',0,0,0),(10,10,0,'Native XML submission import','APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleFilter',0,0,0),(11,11,0,'Native XML issue export','APP\\plugins\\importexport\\native\\filter\\IssueNativeXmlFilter',0,0,0),(12,12,0,'Native XML issue import','APP\\plugins\\importexport\\native\\filter\\NativeXmlIssueFilter',0,0,0),(13,13,0,'Native XML issue galley export','APP\\plugins\\importexport\\native\\filter\\IssueGalleyNativeXmlFilter',0,0,0),(14,14,0,'Native XML issue galley import','APP\\plugins\\importexport\\native\\filter\\NativeXmlIssueGalleyFilter',0,0,0),(15,15,0,'Native XML author export','APP\\plugins\\importexport\\native\\filter\\AuthorNativeXmlFilter',0,0,0),(16,16,0,'Native XML author import','APP\\plugins\\importexport\\native\\filter\\NativeXmlAuthorFilter',0,0,0),(17,18,0,'Native XML submission file import','APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleFileFilter',0,0,0),(18,17,0,'Native XML submission file export','PKP\\plugins\\importexport\\native\\filter\\SubmissionFileNativeXmlFilter',0,0,0),(19,19,0,'Native XML representation export','APP\\plugins\\importexport\\native\\filter\\ArticleGalleyNativeXmlFilter',0,0,0),(20,20,0,'Native XML representation import','APP\\plugins\\importexport\\native\\filter\\NativeXmlArticleGalleyFilter',0,0,0),(21,21,0,'Native XML Publication export','APP\\plugins\\importexport\\native\\filter\\PublicationNativeXmlFilter',0,0,0),(22,22,0,'Native XML publication import','APP\\plugins\\importexport\\native\\filter\\NativeXmlPublicationFilter',0,0,0),(23,23,0,'APP\\plugins\\importexport\\pubmed\\filter\\ArticlePubMedXmlFilter','APP\\plugins\\importexport\\pubmed\\filter\\ArticlePubMedXmlFilter',0,0,0),(24,24,0,'User XML user export','PKP\\plugins\\importexport\\users\\filter\\PKPUserUserXmlFilter',0,0,0),(25,25,0,'User XML user import','PKP\\plugins\\importexport\\users\\filter\\UserXmlPKPUserFilter',0,0,0),(26,26,0,'Native XML user group export','PKP\\plugins\\importexport\\users\\filter\\UserGroupNativeXmlFilter',0,0,0),(27,27,0,'Native XML user group import','PKP\\plugins\\importexport\\users\\filter\\NativeXmlUserGroupFilter',0,0,0);
/*!40000 ALTER TABLE `filters` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre_settings`
--

DROP TABLE IF EXISTS `genre_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre_settings` (
  `genre_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `genre_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`genre_setting_id`),
  UNIQUE KEY `genre_settings_unique` (`genre_id`,`locale`,`setting_name`),
  KEY `genre_settings_genre_id` (`genre_id`),
  CONSTRAINT `genre_settings_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb3 COMMENT='More data about file genres, including localized properties such as the genre name.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre_settings`
--

LOCK TABLES `genre_settings` WRITE;
/*!40000 ALTER TABLE `genre_settings` DISABLE KEYS */;
INSERT INTO `genre_settings` VALUES (1,1,'en','name','Article Text','string'),(2,1,'vi','name','VÄƒn báº£n cá»§a bÃ i bÃ¡o','string'),(3,2,'en','name','Research Instrument','string'),(4,2,'vi','name','CÃ´ng cá»¥ nghiÃªn cá»©u','string'),(5,3,'en','name','Research Materials','string'),(6,3,'vi','name','Váº­t liá»‡u nghiÃªn cá»©u','string'),(7,4,'en','name','Research Results','string'),(8,4,'vi','name','Káº¿t quáº£ nghiÃªn cá»©u','string'),(9,5,'en','name','Transcripts','string'),(10,5,'vi','name','Báº£n dá»‹ch láº¡i','string'),(11,6,'en','name','Data Analysis','string'),(12,6,'vi','name','PhÃ¢n tÃ­ch dá»¯ liá»‡u','string'),(13,7,'en','name','Data Set','string'),(14,7,'vi','name','Táº­p dá»¯ liá»‡u','string'),(15,8,'en','name','Source Texts','string'),(16,8,'vi','name','CÃ¡c vÄƒn báº£n nguá»“n','string'),(17,9,'en','name','Multimedia','string'),(18,9,'vi','name','Äa phÆ°Æ¡ng tiá»‡n','string'),(19,10,'en','name','Image','string'),(20,10,'vi','name','HÃ¬nh áº£nh','string'),(21,11,'en','name','HTML Stylesheet','string'),(22,11,'vi','name','Biá»ƒu Ä‘á»‹nh kiá»ƒu HTML','string'),(23,12,'en','name','Other','string'),(24,12,'vi','name','KhÃ¡c','string');
/*!40000 ALTER TABLE `genre_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genres`
--

DROP TABLE IF EXISTS `genres`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genres` (
  `genre_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `seq` bigint NOT NULL,
  `enabled` smallint NOT NULL DEFAULT '1',
  `category` bigint NOT NULL DEFAULT '1',
  `dependent` smallint NOT NULL DEFAULT '0',
  `supplementary` smallint NOT NULL DEFAULT '0',
  `required` smallint NOT NULL DEFAULT '0' COMMENT 'Whether or not at least one file of this genre is required for a new submission.',
  `entry_key` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`genre_id`),
  KEY `genres_context_id` (`context_id`),
  CONSTRAINT `genres_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COMMENT='The types of submission files configured for each context, such as Article Text, Data Set, Transcript, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genres`
--

LOCK TABLES `genres` WRITE;
/*!40000 ALTER TABLE `genres` DISABLE KEYS */;
INSERT INTO `genres` VALUES (1,1,0,1,1,0,0,1,'SUBMISSION'),(2,1,1,1,3,0,1,0,'RESEARCHINSTRUMENT'),(3,1,2,1,3,0,1,0,'RESEARCHMATERIALS'),(4,1,3,1,3,0,1,0,'RESEARCHRESULTS'),(5,1,4,1,3,0,1,0,'TRANSCRIPTS'),(6,1,5,1,3,0,1,0,'DATAANALYSIS'),(7,1,6,1,3,0,1,0,'DATASET'),(8,1,7,1,3,0,1,0,'SOURCETEXTS'),(9,1,8,1,1,1,1,0,'MULTIMEDIA'),(10,1,9,1,2,1,0,0,'IMAGE'),(11,1,10,1,1,1,0,0,'STYLE'),(12,1,11,1,3,0,1,0,'OTHER');
/*!40000 ALTER TABLE `genres` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution_ip`
--

DROP TABLE IF EXISTS `institution_ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institution_ip` (
  `institution_ip_id` bigint NOT NULL AUTO_INCREMENT,
  `institution_id` bigint NOT NULL,
  `ip_string` varchar(40) NOT NULL,
  `ip_start` bigint NOT NULL,
  `ip_end` bigint DEFAULT NULL,
  PRIMARY KEY (`institution_ip_id`),
  KEY `institution_ip_institution_id` (`institution_id`),
  KEY `institution_ip_start` (`ip_start`),
  KEY `institution_ip_end` (`ip_end`),
  CONSTRAINT `institution_ip_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Records IP address ranges and associates them with institutions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution_ip`
--

LOCK TABLES `institution_ip` WRITE;
/*!40000 ALTER TABLE `institution_ip` DISABLE KEYS */;
/*!40000 ALTER TABLE `institution_ip` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institution_settings`
--

DROP TABLE IF EXISTS `institution_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institution_settings` (
  `institution_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `institution_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`institution_setting_id`),
  UNIQUE KEY `institution_settings_unique` (`institution_id`,`locale`,`setting_name`),
  KEY `institution_settings_institution_id` (`institution_id`),
  CONSTRAINT `institution_settings_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about institutions, including localized properties like names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institution_settings`
--

LOCK TABLES `institution_settings` WRITE;
/*!40000 ALTER TABLE `institution_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `institution_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutional_subscriptions`
--

DROP TABLE IF EXISTS `institutional_subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institutional_subscriptions` (
  `institutional_subscription_id` bigint NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint NOT NULL,
  `institution_id` bigint NOT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `domain` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`institutional_subscription_id`),
  KEY `institutional_subscriptions_subscription_id` (`subscription_id`),
  KEY `institutional_subscriptions_institution_id` (`institution_id`),
  KEY `institutional_subscriptions_domain` (`domain`),
  CONSTRAINT `institutional_subscriptions_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  CONSTRAINT `institutional_subscriptions_subscription_id` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`subscription_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of institutional subscriptions, linking a subscription with an institution.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutional_subscriptions`
--

LOCK TABLES `institutional_subscriptions` WRITE;
/*!40000 ALTER TABLE `institutional_subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `institutional_subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `institutions`
--

DROP TABLE IF EXISTS `institutions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `institutions` (
  `institution_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `ror` varchar(255) DEFAULT NULL COMMENT 'ROR (Research Organization Registry) ID',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`institution_id`),
  KEY `institutions_context_id` (`context_id`),
  CONSTRAINT `institutions_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Institutions for statistics and subscriptions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `institutions`
--

LOCK TABLES `institutions` WRITE;
/*!40000 ALTER TABLE `institutions` DISABLE KEYS */;
/*!40000 ALTER TABLE `institutions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_files`
--

DROP TABLE IF EXISTS `issue_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_files` (
  `file_id` bigint NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` bigint NOT NULL,
  `content_type` bigint NOT NULL,
  `original_file_name` varchar(127) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `issue_files_issue_id` (`issue_id`),
  CONSTRAINT `issue_files_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between issues and issue files, such as cover images.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_files`
--

LOCK TABLES `issue_files` WRITE;
/*!40000 ALTER TABLE `issue_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_galley_settings`
--

DROP TABLE IF EXISTS `issue_galley_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_galley_settings` (
  `issue_galley_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `galley_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`issue_galley_setting_id`),
  UNIQUE KEY `issue_galley_settings_unique` (`galley_id`,`locale`,`setting_name`),
  KEY `issue_galley_settings_galley_id` (`galley_id`),
  CONSTRAINT `issue_galleys_settings_galley_id` FOREIGN KEY (`galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about issue galleys, including localized content such as labels.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_galley_settings`
--

LOCK TABLES `issue_galley_settings` WRITE;
/*!40000 ALTER TABLE `issue_galley_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_galley_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_galleys`
--

DROP TABLE IF EXISTS `issue_galleys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_galleys` (
  `galley_id` bigint NOT NULL AUTO_INCREMENT,
  `locale` varchar(14) DEFAULT NULL,
  `issue_id` bigint NOT NULL,
  `file_id` bigint NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `url_path` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`galley_id`),
  KEY `issue_galleys_issue_id` (`issue_id`),
  KEY `issue_galleys_file_id` (`file_id`),
  KEY `issue_galleys_url_path` (`url_path`),
  CONSTRAINT `issue_galleys_file_id` FOREIGN KEY (`file_id`) REFERENCES `issue_files` (`file_id`) ON DELETE CASCADE,
  CONSTRAINT `issue_galleys_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Issue galleys are representations of the entire issue in a single file, such as a complete issue PDF.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_galleys`
--

LOCK TABLES `issue_galleys` WRITE;
/*!40000 ALTER TABLE `issue_galleys` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_galleys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issue_settings`
--

DROP TABLE IF EXISTS `issue_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issue_settings` (
  `issue_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `issue_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`issue_setting_id`),
  UNIQUE KEY `issue_settings_unique` (`issue_id`,`locale`,`setting_name`),
  KEY `issue_settings_issue_id` (`issue_id`),
  KEY `issue_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  CONSTRAINT `issue_settings_issue_id` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about issues, including localized properties such as issue titles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issue_settings`
--

LOCK TABLES `issue_settings` WRITE;
/*!40000 ALTER TABLE `issue_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `issue_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `issues`
--

DROP TABLE IF EXISTS `issues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `issues` (
  `issue_id` bigint NOT NULL AUTO_INCREMENT,
  `journal_id` bigint NOT NULL,
  `volume` smallint DEFAULT NULL,
  `number` varchar(40) DEFAULT NULL,
  `year` smallint DEFAULT NULL,
  `published` smallint NOT NULL DEFAULT '0',
  `date_published` datetime DEFAULT NULL,
  `date_notified` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `access_status` smallint NOT NULL DEFAULT '1',
  `open_access_date` datetime DEFAULT NULL,
  `show_volume` smallint NOT NULL DEFAULT '0',
  `show_number` smallint NOT NULL DEFAULT '0',
  `show_year` smallint NOT NULL DEFAULT '0',
  `show_title` smallint NOT NULL DEFAULT '0',
  `style_file_name` varchar(90) DEFAULT NULL,
  `original_style_file_name` varchar(255) DEFAULT NULL,
  `url_path` varchar(64) DEFAULT NULL,
  `doi_id` bigint DEFAULT NULL,
  PRIMARY KEY (`issue_id`),
  KEY `issues_journal_id` (`journal_id`),
  KEY `issues_doi_id` (`doi_id`),
  KEY `issues_url_path` (`url_path`),
  CONSTRAINT `issues_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  CONSTRAINT `issues_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of all journal issues, with identifying information like year, number, volume, etc.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `issues`
--

LOCK TABLES `issues` WRITE;
/*!40000 ALTER TABLE `issues` DISABLE KEYS */;
/*!40000 ALTER TABLE `issues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` text NOT NULL,
  `options` mediumtext,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Job batches allow jobs to be collected into groups for managed processing.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
INSERT INTO `job_batches` VALUES ('a1eee4e9-1e9f-48ac-8c89-3acd865c3faf','',0,0,0,'[]','a:0:{}',NULL,1780474149,NULL);
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_reserved_at_index` (`queue`,`reserved_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='All pending or in-progress jobs.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journal_settings`
--

DROP TABLE IF EXISTS `journal_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journal_settings` (
  `journal_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `journal_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`journal_setting_id`),
  UNIQUE KEY `journal_settings_unique` (`journal_id`,`locale`,`setting_name`),
  KEY `journal_settings_journal_id` (`journal_id`),
  CONSTRAINT `journal_settings_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=99 DEFAULT CHARSET=utf8mb3 COMMENT='More data about journals, including localized properties like policies.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journal_settings`
--

LOCK TABLES `journal_settings` WRITE;
/*!40000 ALTER TABLE `journal_settings` DISABLE KEYS */;
INSERT INTO `journal_settings` VALUES (1,1,'en','acronym','HEI'),(2,1,'vi','acronym',NULL),(4,1,'vi','authorGuidelines','##default.contextSettings.authorGuidelines##'),(5,1,'en','authorInformation','Interested in submitting to this journal? We recommend that you review the <a href=\"http://localhost/ojs/index.php/heijournal/about\">About the Journal</a> page for the journal\'s section policies, as well as the <a href=\"http://localhost/ojs/index.php/heijournal/about/submissions#authorGuidelines\">Author Guidelines</a>. Authors need to <a href=\"http://localhost/ojs/index.php/heijournal/user/register\">register</a> with the journal prior to submitting or, if already registered, can simply <a href=\"http://localhost/ojs/index.php/index/login\">log in</a> and begin the five-step process.'),(6,1,'vi','authorInformation','Ban quan tÃ¢m Ä‘áº¿n viá»‡c gá»­i bÃ i Ä‘áº¿n táº¡p chÃ­ nÃ y? ChÃºng tÃ´i khuyÃªn báº¡n nÃªn tham kháº£o <a href=\"http://localhost/ojs/index.php/heijournal/about\">About the Journal</a> trang cho cÃ¡c chÃ­nh sÃ¡ch pháº§n cá»§a táº¡p chÃ­, cÅ©ng nhÆ° <a href=\"http://localhost/ojs/index.php/heijournal/about/submissions#authorGuidelines\">HÆ°á»›ng dáº«n cho tÃ¡c giáº£</a>. TÃ¡c giáº£ cáº§n pháº£i <a href=\"http://localhost/ojs/index.php/heijournal/user/register\">register</a> vá»›i táº¡p chÃ­ trÆ°á»›c khi gá»­i hoáº·c, náº¿u Ä‘Ã£ Ä‘Äƒng kÃ½, cÃ³ thá»ƒ chá»‰ cáº§n <a href=\"http://localhost/ojs/index.php/index/login\">log in</a> vÃ  báº¯t Ä‘áº§u quy trÃ¬nh nÄƒm bÆ°á»›c.'),(7,1,'en','beginSubmissionHelp','<p>Thank you for submitting to the Higher Education Inquiry. You will be asked to upload files, identify co-authors, and provide information such as the title and abstract.</p>\n<p>Please read our <a title=\"Submission Guidelines\" href=\"http://localhost/ojs/index.php/heijournal/submission_guidelines\" target=\"_blank\" rel=\"noopener\">Submission Guidelines</a> if you have not done so already. When filling out the forms, provide as many details as possible in order to help our editors evaluate your work.</p>\n<p>Once you begin, you can save your submission and come back to it later. You will be able to review and correct any information before you submit.</p>'),(8,1,'vi','beginSubmissionHelp','##default.submission.step.beforeYouBegin##'),(9,1,'','contactEmail','heijournal@gmail.com'),(10,1,'','contactName','Editorial Office'),(11,1,'en','contributorsHelp','<p>Add details for all of the contributors to this submission. Contributors added here will be sent an email confirmation of the submission, as well as a copy of all editorial decisions recorded against this submission.</p><p>If a contributor can not be contacted by email, because they must remain anonymous or do not have an email account, please do not enter a fake email address. You can add information about this contributor in a message to the editor at a later step in the submission process.</p>'),(12,1,'vi','contributorsHelp','##default.submission.step.contributors##'),(13,1,'','country','VN'),(14,1,'','defaultReviewMode','2'),(15,1,'en','description','<p><em>Higher Education Inquiry (HEI) </em>is an online, fully open-access journal run by a group of international scholars in higher education and English language teaching and learning. We would like to use this double-blind, peer-reviewed journal as a useful and exciting platform for established and emerging researchers, early-career academics, students, education policymakers, and teachers to publish their recent work.</p>'),(16,1,'vi','description',NULL),(17,1,'en','detailsHelp','<p>Please provide the following details to help us manage your submission in our system.</p>'),(18,1,'vi','detailsHelp','##default.submission.step.details##'),(19,1,'','copySubmissionAckPrimaryContact','0'),(20,1,'','copySubmissionAckAddress',''),(21,1,'','emailSignature','<br><br>â€”<br><p>This is an automated message from <a href=\"http://localhost/ojs/index.php/heijournal\">Higher Education Inquiry</a>.</p>'),(22,1,'','enableDois','1'),(23,1,'','doiSuffixType','default'),(24,1,'','registrationAgency',''),(25,1,'','disableSubmissions','0'),(26,1,'','editorialStatsEmail','1'),(27,1,'en','forTheEditorsHelp','<p>Please provide the following details in order to help our editorial team manage your submission.</p><p>When entering metadata, provide entries that you think would be most helpful to the person managing your submission. This information can be changed before publication.</p>'),(28,1,'vi','forTheEditorsHelp','##default.submission.step.forTheEditors##'),(29,1,'','itemsPerPage','25'),(30,1,'','keywords','request'),(31,1,'en','librarianInformation','We encourage research librarians to list this journal among their library\'s electronic journal holdings. As well, it may be worth noting that this journal\'s open source publishing system is suitable for libraries to host for their faculty members to use with journals they are involved in editing (see <a href=\"https://pkp.sfu.ca/ojs\">Open Journal Systems</a>).'),(32,1,'vi','librarianInformation','ChÃºng tÃ´i khuyáº¿n khÃ­ch cÃ¡c thá»§ thÆ° nghiÃªn cá»©u liá»‡t kÃª táº¡p chÃ­ nÃ y trong sá»‘ cÃ¡c táº¡p chÃ­ Ä‘iá»‡n tá»­ cá»§a thÆ° viá»‡n cá»§a há». Äá»“ng thá»i, cÃ³ thá»ƒ chÃº Ã½ ráº±ng há»‡ thá»‘ng xuáº¥t báº£n nguá»“n má»Ÿ cá»§a táº¡p chÃ­ nÃ y phÃ¹ há»£p Ä‘á»ƒ cÃ¡c thÆ° viá»‡n lÆ°u trá»¯ cho cÃ¡c giáº£ng viÃªn cá»§a há» sá»­ dá»¥ng vá»›i cÃ¡c táº¡p chÃ­ mÃ  há» tham gia biÃªn táº­p (see <a href=\"http://pkp.sfu.ca/ojs\">Open Journal Systems</a>).'),(33,1,'en','name','Higher Education Inquiry'),(34,1,'vi','name',NULL),(35,1,'','notifyAllAuthors','1'),(36,1,'','numPageLinks','10'),(37,1,'','numWeeksPerResponse','4'),(38,1,'','numWeeksPerReview','4'),(39,1,'en','openAccessPolicy','This journal provides immediate open access to its content on the principle that making research freely available to the public supports a greater global exchange of knowledge.'),(40,1,'vi','openAccessPolicy','Táº¡p chÃ­ nÃ y cung cáº¥p quyá»n truy cáº­p má»Ÿ vÃ o ná»™i dung cá»§a nÃ³ theo nguyÃªn táº¯c cÃ¡c nghiÃªn cá»©u miá»…n phÃ­ cho cá»™ng Ä‘á»“ng nháº±m há»— trá»£ trao Ä‘á»•i kiáº¿n thá»©c toÃ n cáº§u tá»‘t hÆ¡n.'),(41,1,'en','privacyStatement','<p>The names and email addresses entered in this journal site will be used exclusively for the stated purposes of this journal and will not be made available for any other purpose or to any other party.</p>'),(42,1,'vi','privacyStatement','<p>TÃªn vÃ  Ä‘á»‹a chá»‰ email Ä‘Æ°á»£c nháº­p trong trang táº¡p chÃ­ nÃ y sáº½ Ä‘Æ°á»£c sá»­ dá»¥ng riÃªng cho cÃ¡c má»¥c Ä‘Ã­ch Ä‘Ã£ nÃªu cá»§a táº¡p chÃ­ nÃ y vÃ  sáº½ khÃ´ng Ä‘Æ°á»£c cung cáº¥p cho báº¥t ká»³ má»¥c Ä‘Ã­ch nÃ o khÃ¡c hoáº·c cho báº¥t ká»³ bÃªn nÃ o khÃ¡c.</p>'),(43,1,'en','readerInformation','We encourage readers to sign up for the publishing notification service for this journal. Use the <a href=\"http://localhost/ojs/index.php/heijournal/user/register\">Register</a> link at the top of the home page for the journal. This registration will result in the reader receiving the Table of Contents by email for each new issue of the journal. This list also allows the journal to claim a certain level of support or readership. See the journal\'s <a href=\"http://localhost/ojs/index.php/heijournal/about/submissions#privacyStatement\">Privacy Statement</a>, which assures readers that their name and email address will not be used for other purposes.'),(44,1,'vi','readerInformation','ChÃºng tÃ´i khuyáº¿n khÃ­ch Ä‘á»™c giáº£ Ä‘Äƒng kÃ½ dá»‹ch vá»¥ thÃ´ng bÃ¡o xuáº¥t báº£n cho táº¡p chÃ­ nÃ y. Sá»­ dá»¥ng <a href=\"http://localhost/ojs/index.php/heijournal/user/register\">ÄÄƒng kÃ½</a> liÃªn káº¿t á»Ÿ Ä‘áº§u trang chá»§ cho táº¡p chÃ­. Viá»‡c Ä‘Äƒng kÃ½ nÃ y sáº½ dáº«n Ä‘áº¿n viá»‡c ngÆ°á»i Ä‘á»c nháº­n Ä‘Æ°á»£c Má»¥c lá»¥c qua email cho má»—i sá»‘ má»›i cá»§a táº¡p chÃ­. Danh sÃ¡ch nÃ y cÅ©ng cho phÃ©p táº¡p chÃ­ yÃªu cáº§u má»™t má»©c Ä‘á»™ há»— trá»£ hoáº·c Ä‘á»™c giáº£ nháº¥t Ä‘á»‹nh. Xem táº¡p chÃ­ <a href=\"http://localhost/ojs/index.php/heijournal/about/submissions#privacyStatement\">Cam káº¿t báº£o máº­t</a>, Ä‘áº£m báº£o cho ngÆ°á»i Ä‘á»c ráº±ng tÃªn vÃ  Ä‘á»‹a chá»‰ email cá»§a há» sáº½ khÃ´ng Ä‘Æ°á»£c sá»­ dá»¥ng cho cÃ¡c má»¥c Ä‘Ã­ch khÃ¡c.'),(45,1,'en','reviewHelp','<p>Review the information you have entered before you complete your submission. You can change any of the details displayed here by clicking the edit button at the top of each section.</p><p>Once you complete your submission, a member of our editorial team will be assigned to review it. Please ensure the details you have entered here are as accurate as possible.</p>'),(46,1,'vi','reviewHelp','##default.submission.step.review##'),(47,1,'','submissionAcknowledgement','allAuthors'),(48,1,'en','submissionChecklist','<p>All submissions must meet the following requirements.</p>\n<ul>\n<li>This submission meets the requirements outlined in the <a title=\"Author Guidelines\" href=\"http://localhost/ojs/index.php/heijournal/author_guidelines\">Author Guidelines</a>.</li>\n<li>This submission has not been previously published, nor is it before another journal for consideration.</li>\n<li>All references have been checked for accuracy and completeness.</li>\n<li>All tables and figures have been numbered and labeled.</li>\n<li>Permission has been obtained to publish all photos, datasets and other material provided with this submission.</li>\n</ul>'),(49,1,'vi','submissionChecklist','##default.contextSettings.checklist##'),(50,1,'','submitWithCategories','1'),(51,1,'','supportedFormLocales','[\"en\"]'),(52,1,'','supportedLocales','[\"en\",\"vi\"]'),(53,1,'','supportedSubmissionLocales','[\"en\"]'),(54,1,'','themePluginPath','default'),(56,1,'vi','uploadFilesHelp','##default.submission.step.uploadFiles##'),(57,1,'','enableGeoUsageStats','country+region+city'),(58,1,'','enableInstitutionUsageStats','1'),(59,1,'','isSushiApiPublic','1'),(60,1,'en','abbreviation','HEI'),(61,1,'vi','abbreviation',NULL),(62,1,'en','clockssLicense','This journal utilizes the CLOCKSS system to create a distributed archiving system among participating libraries and permits those libraries to create permanent archives of the journal for purposes of preservation and restoration. <a href=\"https://clockss.org\">More...</a>'),(63,1,'vi','clockssLicense','Táº¡p chÃ­ nÃ y sá»­ dá»¥ng há»‡ thá»‘ng CLOCKSS Ä‘á»ƒ táº¡o ra má»™t há»‡ thá»‘ng lÆ°u trá»¯ phÃ¢n tÃ¡n giá»¯a cÃ¡c thÆ° viá»‡n tham gia vÃ  cho phÃ©p cÃ¡c thÆ° viá»‡n Ä‘Ã³ táº¡o tÃ i liá»‡u lÆ°u trá»¯ vÄ©nh viá»…n cá»§a táº¡p chÃ­ cho má»¥c Ä‘Ã­ch báº£o quáº£n vÃ  phá»¥c há»“i. <a href=\"http://clockss.org/\">ThÃªm...</a>'),(64,1,'','copyrightYearBasis','issue'),(65,1,'','enabledDoiTypes','[\"publication\"]'),(66,1,'','doiCreationTime','copyEditCreationTime'),(67,1,'','enableOai','0'),(68,1,'en','lockssLicense','This journal utilizes the LOCKSS system to create a distributed archiving system among participating libraries and permits those libraries to create permanent archives of the journal for purposes of preservation and restoration. <a href=\"https://www.lockss.org\">More...</a>'),(69,1,'vi','lockssLicense','Táº¡p chÃ­ nÃ y sá»­ dá»¥ng há»‡ thá»‘ng LOCKSS Ä‘á»ƒ táº¡o ra má»™t há»‡ thá»‘ng lÆ°u trá»¯ phÃ¢n tÃ¡n giá»¯a cÃ¡c thÆ° viá»‡n tham gia vÃ  cho phÃ©p cÃ¡c thÆ° viá»‡n Ä‘Ã³ táº¡o tÃ i liá»‡u lÆ°u trá»¯ vÄ©nh viá»…n cá»§a táº¡p chÃ­ cho má»¥c Ä‘Ã­ch báº£o quáº£n vÃ  phá»¥c há»“i. <a href=\"http://www.lockss.org/\">ThÃªm...</a>'),(70,1,'','membershipFee','0'),(71,1,'','publicationFee','0'),(72,1,'','purchaseArticleFee','0'),(73,1,'','doiVersioning','0'),(74,1,'en','about','<h3>Aims</h3>\n<p><em>Higher Education Inquiry (HEI) </em>is an online, fully open-access journal run by a group of international scholars in higher education and English language teaching and learning. We would like to use this double-blind, peer-reviewed journal as a useful and exciting platform for established and emerging researchers, early-career academics, students, education policymakers, and teachers to publish their recent work.</p>\n<p>The intellectual identity of <em>HEI </em>primarily lies in the word â€œinquiry.â€ <em>HEI </em>focuses on:</p>\n<ol>\n<li>Inquiry as knowledge generation</li>\n</ol>\n<p><em>HEI </em>aims to receive original research works that produce new knowledge in higher education, rather than reporting experiences or describing educational phenomena. It primarily asks what new knowledge a manuscript can produce.</p>\n<ol start=\"2\">\n<li>Inquiry as critical examination</li>\n</ol>\n<p><em>HEI </em>emphasizes critical analysis, critical literature reviews, critical perspectives, critical reflection, and critical evaluation of policies and practices. It asks what theoretical assumptions, policies, practices, theories, or trends are being critically interrogated and examined.</p>\n<ol start=\"3\">\n<li>Inquiry as international relevance and impact</li>\n</ol>\n<p><em>HEI </em>does not prioritize local case studies without shedding light on international relevance and impact. It urges authors to address the question of why scholars and educational practitioners outside the studyâ€™s context care about the findings.</p>\n<h3>No Article Publishing Charge</h3>\n<p>Prospective authors and authors are charged no fees when submitting and publishing their works. By covering the article processing fee, <em>HEI</em> expects to disseminate scientific works, values, and impacts to diverse audiences worldwide, allowing everyone to have easy, fast access to its publications.</p>'),(75,1,'en','editorialTeam','<h2><strong>Editor-in-Chief</strong></h2>\n<p>Chi Hong Nguyen</p>\n<p><em>English Faculty, FPT University, Can Tho Campus, Vietnam</em></p>\n<h2><strong>Associate Editor</strong></h2>\n<p>Nguyen Trong Nguyen</p>\n<p><em>English Faculty, FPT University, Can Tho Campus, Vietnam</em></p>\n<h2><strong>Managing Editor</strong></h2>\n<p>Tran Thanh Duy</p>\n<p><em>English Faculty, FPT University, Can Tho Campus, Vietnam</em></p>\n<h2><strong>Subject Editor</strong></h2>\n<h3><em>Educational Leadership and Management</em></h3>\n<p>Associate Professor Tran Van Dat (An Giang University, Vietnam National University Ho Chi Minh City, Vietnam)</p>\n<h3><em>Theory and practice in educational philosophies</em></h3>\n<p>Associate Professor Gloria Dallâ€™Alba</p>\n<h3><em>English language teaching and learning, and educational technologies</em></h3>\n<p>Dr. Ho Thi Thao Nguyen (FPT University, Vietnam)</p>\n<p>Dr. Le Ha Van (Swinburne Vietnam)</p>\n<p>Associate Professorâ€¦â€¦</p>\n<h3><em>Educational mobilities</em></h3>\n<p>Professorâ€¦â€¦</p>\n<h3><em>Foreign language professional development</em></h3>\n<p>Associate Professor â€¦.</p>'),(76,1,'en','announcementsIntroduction','<h1><strong>No Article Publishing Charge</strong></h1>\n<p>Prospective authors and authors are charged no fees when submitting and publishing their works. By covering the article processing fee, <em>HEI</em> expects to disseminate scientific works, values, and impacts to diverse audiences worldwide, allowing everyone to have easy, fast access to its publications</p>'),(77,1,'','enableAnnouncements','0'),(78,1,'','numAnnouncementsHomepage','2'),(79,1,'en','additionalHomeContent','<h2><strong>No Article Publishing Charge</strong></h2>\n<p>Prospective authors and authors are charged no fees when submitting and publishing their works. By covering the article processing fee, <em>HEI</em> expects to disseminate scientific works, values, and impacts to diverse audiences worldwide, allowing everyone to have easy, fast access to its publications</p>'),(80,1,'en','authorGuidelines','<p>Please visit this <a title=\"Author Guidelines\" href=\"http://localhost/ojs/index.php/heijournal/author_guidelines\">Author Guidelines</a> page for detailed instructions</p>'),(81,1,'en','pageFooter','<div class=\"heij-footer\">\n<p><strong>Higher Education Inquiry</strong> is an international, peer-reviewed, open-access journal dedicated to research, practice, and policy in higher education.</p>\n<p>We welcome contributions from established and emerging researchers, early-career academics, students, education policymakers, and practitioners.</p>\n<p class=\"heij-footer-links\"><a href=\"http://localhost/ojs/index.php/heijournal/about\">About</a> | <a href=\"http://localhost/ojs/index.php/heijournal/about/submissions\">Submissions</a> | <a href=\"http://localhost/ojs/index.php/heijournal/about/editorialTeam\">Editorial Team</a> | <a href=\"http://localhost/ojs/index.php/heijournal/about/privacy\">Privacy Statement</a></p>\n<p class=\"heij-footer-copy\">Â© 2026 Higher Education Inquiry. All rights reserved.</p>\n</div>'),(82,1,'','sidebar','[\"makesubmissionblockplugin\",\"browseblockplugin\",\"informationblockplugin\"]'),(83,1,'','agencies','require'),(84,1,'','citations','0'),(85,1,'','coverage','0'),(86,1,'','disciplines','0'),(87,1,'','requireAuthorCompetingInterests','1'),(88,1,'','languages','0'),(89,1,'','rights','require'),(90,1,'','source','0'),(91,1,'','subjects','require'),(92,1,'','type','0'),(93,1,'','dataAvailability','require'),(94,1,'','enablePublisherId','[]'),(95,1,'','copyrightHolderType','author'),(96,1,'en','licenseTerms','<div class=\"relative w-full mt-4 mb-1\">\n<div class=\"\">\n<div class=\"contents\">\n<div class=\"relative\">\n<div class=\"h-full min-h-0 min-w-0\">\n<div class=\"h-full min-h-0 min-w-0\">\n<div class=\"border border-token-border-light border-radius-3xl corner-superellipse/1.1 rounded-3xl\">\n<div class=\"h-full w-full border-radius-3xl bg-token-bg-elevated-secondary corner-superellipse/1.1 overflow-clip rounded-3xl lxnfua_clipPathFallback\">\n<div class=\"relative\">\n<div class=\"pe-11 pt-3\">\n<div class=\"relative z-0 flex max-w-full\">\n<div id=\"code-block-viewer\" class=\"q9tKkq_viewer cm-editor z-10 light:cm-light dark:cm-light flex h-full w-full flex-col items-stretch Í¼s Í¼16\" dir=\"ltr\">\n<div class=\"cm-scroller\">\n<pre class=\"cm-content q9tKkq_readonly m-0\"><code>Authors retain copyright and grant the journal right of first publication. Articles are distributed under the terms of the Creative Commons Attribution 4.0 International License (CC BY 4.0), which permits unrestricted use, distribution, and reproduction in any medium, provided the original author(s) and source are credited.</code></pre>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>\n</div>'),(97,1,'','licenseUrl','https://creativecommons.org/licenses/by/4.0'),(98,1,'','publishingMode','0');
/*!40000 ALTER TABLE `journal_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `journals`
--

DROP TABLE IF EXISTS `journals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `journals` (
  `journal_id` bigint NOT NULL AUTO_INCREMENT,
  `path` varchar(32) NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00' COMMENT 'Used to order lists of journals',
  `primary_locale` varchar(14) NOT NULL,
  `enabled` smallint NOT NULL DEFAULT '1' COMMENT 'Controls whether or not the journal is considered "live" and will appear on the website. (Note that disabled journals may still be accessible, but only if the user knows the URL.)',
  `current_issue_id` bigint DEFAULT NULL,
  PRIMARY KEY (`journal_id`),
  UNIQUE KEY `journals_path` (`path`),
  KEY `journals_issue_id` (`current_issue_id`),
  CONSTRAINT `journals_current_issue_id_foreign` FOREIGN KEY (`current_issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='A list of all journals in the installation of OJS.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `journals`
--

LOCK TABLES `journals` WRITE;
/*!40000 ALTER TABLE `journals` DISABLE KEYS */;
INSERT INTO `journals` VALUES (1,'heijournal',1.00,'en',1,NULL);
/*!40000 ALTER TABLE `journals` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_file_settings`
--

DROP TABLE IF EXISTS `library_file_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_file_settings` (
  `library_file_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `file_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object|date)',
  PRIMARY KEY (`library_file_setting_id`),
  UNIQUE KEY `library_file_settings_unique` (`file_id`,`locale`,`setting_name`),
  KEY `library_file_settings_file_id` (`file_id`),
  CONSTRAINT `library_file_settings_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `library_files` (`file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about library files, including localized content such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_file_settings`
--

LOCK TABLES `library_file_settings` WRITE;
/*!40000 ALTER TABLE `library_file_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_file_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `library_files`
--

DROP TABLE IF EXISTS `library_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `library_files` (
  `file_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `file_name` varchar(255) NOT NULL,
  `original_file_name` varchar(255) NOT NULL,
  `file_type` varchar(255) NOT NULL,
  `file_size` bigint NOT NULL,
  `type` smallint NOT NULL,
  `date_uploaded` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `submission_id` bigint DEFAULT NULL,
  `public_access` smallint DEFAULT '0',
  PRIMARY KEY (`file_id`),
  KEY `library_files_context_id` (`context_id`),
  KEY `library_files_submission_id` (`submission_id`),
  CONSTRAINT `library_files_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `library_files_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Library files can be associated with the context (press/server/journal) or with individual submissions, and are typically forms, agreements, and other administrative documents that are not part of the scholarly content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `library_files`
--

LOCK TABLES `library_files` WRITE;
/*!40000 ALTER TABLE `library_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `library_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_context`
--

DROP TABLE IF EXISTS `metrics_context`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_context` (
  `metrics_context_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint NOT NULL,
  `date` date NOT NULL,
  `metric` int NOT NULL,
  PRIMARY KEY (`metrics_context_id`),
  KEY `metrics_context_load_id` (`load_id`),
  KEY `metrics_context_context_id` (`context_id`),
  CONSTRAINT `metrics_context_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Daily statistics for views of the homepage.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_context`
--

LOCK TABLES `metrics_context` WRITE;
/*!40000 ALTER TABLE `metrics_context` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_context` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_daily`
--

DROP TABLE IF EXISTS `metrics_counter_submission_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_counter_submission_daily` (
  `metrics_counter_submission_daily_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `date` date NOT NULL,
  `metric_investigations` int NOT NULL,
  `metric_investigations_unique` int NOT NULL,
  `metric_requests` int NOT NULL,
  `metric_requests_unique` int NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_daily_id`),
  UNIQUE KEY `msd_uc_load_id_context_id_submission_id_date` (`load_id`,`context_id`,`submission_id`,`date`),
  KEY `msd_load_id` (`load_id`),
  KEY `metrics_counter_submission_daily_context_id` (`context_id`),
  KEY `metrics_counter_submission_daily_submission_id` (`submission_id`),
  KEY `msd_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msd_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msd_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Daily statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_daily`
--

LOCK TABLES `metrics_counter_submission_daily` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_institution_daily`
--

DROP TABLE IF EXISTS `metrics_counter_submission_institution_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_counter_submission_institution_daily` (
  `metrics_counter_submission_institution_daily_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `institution_id` bigint NOT NULL,
  `date` date NOT NULL,
  `metric_investigations` int NOT NULL,
  `metric_investigations_unique` int NOT NULL,
  `metric_requests` int NOT NULL,
  `metric_requests_unique` int NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_institution_daily_id`),
  UNIQUE KEY `msid_uc_load_id_context_id_submission_id_institution_id_date` (`load_id`,`context_id`,`submission_id`,`institution_id`,`date`),
  KEY `msid_load_id` (`load_id`),
  KEY `metrics_counter_submission_institution_daily_context_id` (`context_id`),
  KEY `metrics_counter_submission_institution_daily_submission_id` (`submission_id`),
  KEY `metrics_counter_submission_institution_daily_institution_id` (`institution_id`),
  KEY `msid_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msid_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msid_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  CONSTRAINT `msid_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Daily statistics matching the COUNTER R5 protocol for views and downloads from institutions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_institution_daily`
--

LOCK TABLES `metrics_counter_submission_institution_daily` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_institution_monthly`
--

DROP TABLE IF EXISTS `metrics_counter_submission_institution_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_counter_submission_institution_monthly` (
  `metrics_counter_submission_institution_monthly_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `institution_id` bigint NOT NULL,
  `month` int NOT NULL,
  `metric_investigations` int NOT NULL,
  `metric_investigations_unique` int NOT NULL,
  `metric_requests` int NOT NULL,
  `metric_requests_unique` int NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_institution_monthly_id`),
  UNIQUE KEY `msim_uc_context_id_submission_id_institution_id_month` (`context_id`,`submission_id`,`institution_id`,`month`),
  KEY `metrics_counter_submission_institution_monthly_context_id` (`context_id`),
  KEY `metrics_counter_submission_institution_monthly_submission_id` (`submission_id`),
  KEY `metrics_counter_submission_institution_monthly_institution_id` (`institution_id`),
  KEY `msim_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msim_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msim_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE,
  CONSTRAINT `msim_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Monthly statistics matching the COUNTER R5 protocol for views and downloads from institutions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_institution_monthly`
--

LOCK TABLES `metrics_counter_submission_institution_monthly` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_institution_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_counter_submission_monthly`
--

DROP TABLE IF EXISTS `metrics_counter_submission_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_counter_submission_monthly` (
  `metrics_counter_submission_monthly_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `month` int NOT NULL,
  `metric_investigations` int NOT NULL,
  `metric_investigations_unique` int NOT NULL,
  `metric_requests` int NOT NULL,
  `metric_requests_unique` int NOT NULL,
  PRIMARY KEY (`metrics_counter_submission_monthly_id`),
  UNIQUE KEY `msm_uc_context_id_submission_id_month` (`context_id`,`submission_id`,`month`),
  KEY `metrics_counter_submission_monthly_context_id` (`context_id`),
  KEY `metrics_counter_submission_monthly_submission_id` (`submission_id`),
  KEY `msm_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msm_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msm_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Monthly statistics matching the COUNTER R5 protocol for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_counter_submission_monthly`
--

LOCK TABLES `metrics_counter_submission_monthly` WRITE;
/*!40000 ALTER TABLE `metrics_counter_submission_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_counter_submission_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_issue`
--

DROP TABLE IF EXISTS `metrics_issue`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_issue` (
  `metrics_issue_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint NOT NULL,
  `issue_id` bigint NOT NULL,
  `issue_galley_id` bigint DEFAULT NULL,
  `date` date NOT NULL,
  `metric` int NOT NULL,
  PRIMARY KEY (`metrics_issue_id`),
  KEY `metrics_issue_load_id` (`load_id`),
  KEY `metrics_issue_context_id` (`context_id`),
  KEY `metrics_issue_issue_id` (`issue_id`),
  KEY `metrics_issue_issue_galley_id` (`issue_galley_id`),
  KEY `metrics_issue_context_id_issue_id` (`context_id`,`issue_id`),
  CONSTRAINT `metrics_issue_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_issue_issue_galley_id_foreign` FOREIGN KEY (`issue_galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_issue_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Daily statistics for views and downloads of published issues.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_issue`
--

LOCK TABLES `metrics_issue` WRITE;
/*!40000 ALTER TABLE `metrics_issue` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_issue` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_submission`
--

DROP TABLE IF EXISTS `metrics_submission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_submission` (
  `metrics_submission_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `representation_id` bigint DEFAULT NULL,
  `submission_file_id` bigint unsigned DEFAULT NULL,
  `file_type` bigint DEFAULT NULL,
  `assoc_type` bigint NOT NULL,
  `date` date NOT NULL,
  `metric` int NOT NULL,
  PRIMARY KEY (`metrics_submission_id`),
  KEY `ms_load_id` (`load_id`),
  KEY `metrics_submission_context_id` (`context_id`),
  KEY `metrics_submission_submission_id` (`submission_id`),
  KEY `metrics_submission_representation_id` (`representation_id`),
  KEY `metrics_submission_submission_file_id` (`submission_file_id`),
  KEY `ms_context_id_submission_id_assoc_type_file_type` (`context_id`,`submission_id`,`assoc_type`,`file_type`),
  CONSTRAINT `metrics_submission_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_submission_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_submission_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `metrics_submission_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Daily statistics for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_submission`
--

LOCK TABLES `metrics_submission` WRITE;
/*!40000 ALTER TABLE `metrics_submission` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_submission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_submission_geo_daily`
--

DROP TABLE IF EXISTS `metrics_submission_geo_daily`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_submission_geo_daily` (
  `metrics_submission_geo_daily_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `date` date NOT NULL,
  `metric` int NOT NULL,
  `metric_unique` int NOT NULL,
  PRIMARY KEY (`metrics_submission_geo_daily_id`),
  UNIQUE KEY `msgd_uc_load_context_submission_c_r_c_date` (`load_id`,`context_id`,`submission_id`,`country`,`region`,`city`(80),`date`),
  KEY `msgd_load_id` (`load_id`),
  KEY `metrics_submission_geo_daily_context_id` (`context_id`),
  KEY `metrics_submission_geo_daily_submission_id` (`submission_id`),
  KEY `msgd_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msgd_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msgd_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Daily statistics by country, region and city for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_submission_geo_daily`
--

LOCK TABLES `metrics_submission_geo_daily` WRITE;
/*!40000 ALTER TABLE `metrics_submission_geo_daily` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_submission_geo_daily` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `metrics_submission_geo_monthly`
--

DROP TABLE IF EXISTS `metrics_submission_geo_monthly`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `metrics_submission_geo_monthly` (
  `metrics_submission_geo_monthly_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `month` int NOT NULL,
  `metric` int NOT NULL,
  `metric_unique` int NOT NULL,
  PRIMARY KEY (`metrics_submission_geo_monthly_id`),
  UNIQUE KEY `msgm_uc_context_submission_c_r_c_month` (`context_id`,`submission_id`,`country`,`region`,`city`(80),`month`),
  KEY `metrics_submission_geo_monthly_context_id` (`context_id`),
  KEY `metrics_submission_geo_monthly_submission_id` (`submission_id`),
  KEY `msgm_context_id_submission_id` (`context_id`,`submission_id`),
  CONSTRAINT `msgm_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `msgm_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Monthly statistics by country, region and city for views and downloads of published submissions and galleys.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `metrics_submission_geo_monthly`
--

LOCK TABLES `metrics_submission_geo_monthly` WRITE;
/*!40000 ALTER TABLE `metrics_submission_geo_monthly` DISABLE KEYS */;
/*!40000 ALTER TABLE `metrics_submission_geo_monthly` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_item_assignment_settings`
--

DROP TABLE IF EXISTS `navigation_menu_item_assignment_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_menu_item_assignment_settings` (
  `navigation_menu_item_assignment_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `navigation_menu_item_assignment_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`navigation_menu_item_assignment_setting_id`),
  UNIQUE KEY `navigation_menu_item_assignment_settings_unique` (`navigation_menu_item_assignment_id`,`locale`,`setting_name`),
  KEY `navigation_menu_item_assignment_settings_n_m_i_a_id` (`navigation_menu_item_assignment_id`),
  CONSTRAINT `assignment_settings_navigation_menu_item_assignment_id` FOREIGN KEY (`navigation_menu_item_assignment_id`) REFERENCES `navigation_menu_item_assignments` (`navigation_menu_item_assignment_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb3 COMMENT='More data about navigation menu item assignments to navigation menus, including localized content.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_item_assignment_settings`
--

LOCK TABLES `navigation_menu_item_assignment_settings` WRITE;
/*!40000 ALTER TABLE `navigation_menu_item_assignment_settings` DISABLE KEYS */;
INSERT INTO `navigation_menu_item_assignment_settings` VALUES (47,143,'en','title','About','string'),(48,144,'en','title','Aims','string'),(49,145,'en','title','Scopes','string'),(50,150,'en','title','For authors','string'),(51,152,'en','title','Submission Guidelines','string'),(52,153,'en','title','Author guidelines','string'),(53,154,'en','title','Article types','string'),(54,155,'en','title','Review process','string'),(55,156,'en','title','Abstracting & Indexing','string');
/*!40000 ALTER TABLE `navigation_menu_item_assignment_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_item_assignments`
--

DROP TABLE IF EXISTS `navigation_menu_item_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_menu_item_assignments` (
  `navigation_menu_item_assignment_id` bigint NOT NULL AUTO_INCREMENT,
  `navigation_menu_id` bigint NOT NULL,
  `navigation_menu_item_id` bigint NOT NULL,
  `parent_id` bigint DEFAULT NULL,
  `seq` bigint DEFAULT '0',
  PRIMARY KEY (`navigation_menu_item_assignment_id`),
  KEY `navigation_menu_item_assignments_navigation_menu_id` (`navigation_menu_id`),
  KEY `navigation_menu_item_assignments_navigation_menu_item_id` (`navigation_menu_item_id`),
  CONSTRAINT `navigation_menu_item_assignments_navigation_menu_id_foreign` FOREIGN KEY (`navigation_menu_id`) REFERENCES `navigation_menus` (`navigation_menu_id`) ON DELETE CASCADE,
  CONSTRAINT `navigation_menu_item_assignments_navigation_menu_item_id_foreign` FOREIGN KEY (`navigation_menu_item_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8mb3 COMMENT='Links navigation menu items to navigation menus.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_item_assignments`
--

LOCK TABLES `navigation_menu_item_assignments` WRITE;
/*!40000 ALTER TABLE `navigation_menu_item_assignments` DISABLE KEYS */;
INSERT INTO `navigation_menu_item_assignments` VALUES (1,1,1,0,0),(2,1,2,0,1),(3,1,3,0,2),(4,1,4,3,0),(5,1,5,3,1),(6,1,6,3,2),(7,1,7,3,3),(77,2,8,0,0),(78,2,9,0,1),(79,2,10,0,2),(80,2,11,10,3),(81,2,12,10,4),(82,2,14,10,5),(143,3,25,0,0),(144,3,19,25,1),(145,3,26,25,2),(146,3,23,25,3),(147,3,21,25,4),(148,3,15,0,5),(149,3,16,0,6),(150,3,28,0,7),(151,3,20,28,8),(152,3,30,28,9),(153,3,27,28,10),(154,3,29,28,11),(155,3,31,0,12),(156,3,32,0,13);
/*!40000 ALTER TABLE `navigation_menu_item_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_item_settings`
--

DROP TABLE IF EXISTS `navigation_menu_item_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_menu_item_settings` (
  `navigation_menu_item_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `navigation_menu_item_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` longtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`navigation_menu_item_setting_id`),
  UNIQUE KEY `navigation_menu_item_settings_unique` (`navigation_menu_item_id`,`locale`,`setting_name`),
  KEY `navigation_menu_item_settings_navigation_menu_item_id` (`navigation_menu_item_id`),
  CONSTRAINT `navigation_menu_item_settings_navigation_menu_id` FOREIGN KEY (`navigation_menu_item_id`) REFERENCES `navigation_menu_items` (`navigation_menu_item_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=60 DEFAULT CHARSET=utf8mb3 COMMENT='More data about navigation menu items, including localized content such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_item_settings`
--

LOCK TABLES `navigation_menu_item_settings` WRITE;
/*!40000 ALTER TABLE `navigation_menu_item_settings` DISABLE KEYS */;
INSERT INTO `navigation_menu_item_settings` VALUES (1,1,'','titleLocaleKey','navigation.register','string'),(2,2,'','titleLocaleKey','navigation.login','string'),(3,3,'','titleLocaleKey','{$loggedInUsername}','string'),(4,4,'','titleLocaleKey','navigation.dashboard','string'),(5,5,'','titleLocaleKey','common.viewProfile','string'),(6,6,'','titleLocaleKey','navigation.admin','string'),(7,7,'','titleLocaleKey','user.logOut','string'),(8,8,'','titleLocaleKey','navigation.register','string'),(9,9,'','titleLocaleKey','navigation.login','string'),(10,10,'','titleLocaleKey','{$loggedInUsername}','string'),(11,11,'','titleLocaleKey','navigation.dashboard','string'),(12,12,'','titleLocaleKey','common.viewProfile','string'),(13,13,'','titleLocaleKey','navigation.admin','string'),(14,14,'','titleLocaleKey','user.logOut','string'),(15,15,'','titleLocaleKey','navigation.current','string'),(16,16,'','titleLocaleKey','navigation.archives','string'),(17,17,'','titleLocaleKey','manager.announcements','string'),(19,19,'','titleLocaleKey','about.aboutContext','string'),(20,20,'','titleLocaleKey','about.submissions','string'),(21,21,'','titleLocaleKey','about.editorialTeam','string'),(22,22,'','titleLocaleKey','manager.setup.privacyStatement','string'),(23,23,'','titleLocaleKey','about.contact','string'),(24,24,'','titleLocaleKey','common.search','string'),(25,21,'en','content','','string'),(26,21,'en','remoteUrl','','string'),(27,25,'en','title','About','string'),(28,25,'en','content','','string'),(29,25,'en','remoteUrl','','string'),(30,19,'en','content','','string'),(31,19,'en','remoteUrl','','string'),(32,19,'en','title','Aims','string'),(33,26,'en','title','Scopes','string'),(34,26,'en','content','<p><em>HEI</em> welcomes submissions that center on:</p>\r\n<ul>\r\n<li>Theory and practice in educational philosophies</li>\r\n<li>Foreign language teaching and learning, and educational technologies</li>\r\n<li>Teaching English to Speakers of Other Languages (TESOL) teaching methodologies</li>\r\n<li>Educational mobilities</li>\r\n<li>Foreign language professional development</li>\r\n<li>Educational leadership and management</li>\r\n</ul>\r\n<p>Submissions should be original and not under publication review anywhere else. Contributions should be made in the following forms:</p>\r\n<ul>\r\n<li>Empirical research in full-length research articles</li>\r\n<li>Critical literature reviews that point to innovative conceptual frameworks</li>\r\n<li>Methodological papers that propose practical and new models</li>\r\n<li>Practice-based studies</li>\r\n<li>Academic papers that highlight critical perspectives on current trends in higher education</li>\r\n</ul>\r\n<p>All articles must shed light on new understandings of higher education phenomena and trends and provide both theoretical and practical implications for international contexts rather than being situated in local cases or contexts.</p>','string'),(35,26,'en','remoteUrl','','string'),(36,10,'en','content','','string'),(37,10,'en','remoteUrl','','string'),(38,27,'en','title','Author guidelines','string'),(39,27,'en','content','<h2><strong>Language</strong></h2>\r\n<p><em>HEI </em>accepts submissions in English only. Authors can use either British or American English, but it should be consistent throughout the article. Submissions will be returned to authors for language corrections if they are not at a good level of English. Authors are encouraged to use professional English language editing services to improve language accuracy before submissions, and such use must be acknowledged in the article.</p>\r\n<h2><strong>No discriminatory language</strong></h2>\r\n<p><em>HEI </em>does not accept papers that are politically, religiously, culturally, or gender biased.</p>\r\n<h2><strong>Inclusive language</strong></h2>\r\n<p>Authors must use inclusive language that acknowledges diversity and promotes equality on the grounds of age, gender, race, ethnicity, culture, sexual orientation, disabilities, health conditions, nationality, and political and religious doctrines. Authors are encouraged to use gender neutrality with plural nouns as the default.</p>\r\n<h2><strong>Titles</strong></h2>\r\n<p>All articles must have clear and grammatically correct titles that capture the main arguments. They should not include references or longer than 18 words.</p>\r\n<h2><strong>Abstract</strong></h2>\r\n<p>All articles must include clearly stated abstracts of 180-200 words.</p>\r\n<h2><strong>Keywords</strong></h2>\r\n<p>All articles must include 5-7 keywords that capture the studyâ€™s inquiry, theoretical/conceptual framing, research paradigm, and main arguments.</p>\r\n<h2><strong>References</strong></h2>\r\n<p><em>HEI </em>accepts references in APA 7<sup>th</sup> edition style only. Authors must comply with this referencing requirement for formatting to avoid desk rejection.</p>\r\n<p>At least 25% of the references that are cited in a manuscript must be published within the past 5 years by reputable journals/publishers.</p>','string'),(40,27,'en','remoteUrl','','string'),(41,28,'en','title','For authors','string'),(42,28,'en','content','','string'),(43,28,'en','remoteUrl','','string'),(44,29,'en','title','Article types','string'),(45,29,'en','content','<h3><em>Full-length research articles</em></h3>\r\n<p>A full-length research article must demonstrate an empirical study with original findings that align with <em>HEI</em>â€™s aims and scopes. It must be around 7,500 to 8,000 words, including all main components (except appendices and supplementary materials). It should follow this structure:</p>\r\n<ul>\r\n<li>Introduction</li>\r\n<li>Literature review</li>\r\n<li>Theoretical or conceptual framing</li>\r\n<li>Methods, including ethical considerations and the benefits the study brings to the participants and research contexts</li>\r\n<li>Results/Findings</li>\r\n<li>Discussion</li>\r\n<li>Theoretical and practical implications</li>\r\n<li>Conclusion</li>\r\n<li>Limitations</li>\r\n<li>Suggestions or recommendations for further research</li>\r\n<li>References</li>\r\n<li>Appendices (if any, and limit them to a minimum)</li>\r\n<li>Supplementary materials (if any, and sent in a separate file)</li>\r\n</ul>\r\n<h3><em>Critical or systematic literature review</em></h3>\r\n<p>The word count for this type of article ranges from 7,500 to 8,000 words, including all main components. All articles must address robust questions that are timely and relevant to higher education. Methodologies for the review must be included, clearly explained, and argued.</p>\r\n<h3><em>Methodological papers</em></h3>\r\n<p>Written in between 7,500 and 8,000 words (including all main components), all articles of this type must present innovative methodological approaches in higher education research.</p>\r\n<h3><em>Practice-based and policy impact articles</em></h3>\r\n<p>All articles of this type must be between 7,500 and 8,000 words, including all main components and excluding appendices and supplementary materials (which should be kept to a minimum). Authors must focus on educational practices and/or effects of higher education policies in several contexts (cross-national contexts are encouraged). Papers of this style must clearly demonstrate policy and practice implications to international contexts.</p>\r\n<h3><em>Academic papers</em></h3>\r\n<p>All articles of this type must be written between 5,000 and 5,500 words, including all main components. They must briefly, yet analytically and critically, review practice-based studies in higher education and/or policy effects, including the authorsâ€™ critical evaluations and opinions.</p>','string'),(46,29,'en','remoteUrl','','string'),(47,20,'en','content','','string'),(48,20,'en','remoteUrl','','string'),(49,30,'en','title','Submission Guidelines','string'),(50,30,'en','content','<p>All articles must be submitted to <em>HEI</em>â€™s website (<a href=\"https://hei\">https://hei</a>....). Authors must submit the following <u>four</u> (or <u>three</u> files for practice-based and policy impact, as well as academic papers) files in Word:</p>\r\n<ul>\r\n<li><strong>Title page file</strong>, including the paperâ€™s title, authorsâ€™ details, authorsâ€™ contact details (full name, work affiliations, email addresses, and countries of residence), author contributions with corresponding authorsâ€™ emails, abstracts, and keywords</li>\r\n<li><strong>Anonymized file</strong> (authors must replace their names in their own works cited in their papers with Author X or Author Y). Names of research sites must also be anonymized for confidentiality</li>\r\n<li><strong>Non-anonymized file</strong> that includes all components of the article and the required declarations</li>\r\n<li><strong>Ethical clearance approval</strong></li>\r\n<li><strong>Declarations:&nbsp;</strong>see details below</li>\r\n</ul>\r\n<h2><strong>Declarations</strong></h2>\r\n<p>All articles must include all the following <u>five</u> declarations (put them before the reference entry list and write N/A where not applicable, with a brief explanation, and/or choose the most suitable option):</p>\r\n<h3><em>Conflict of interest</em></h3>\r\n<p><u>If there is no conflict of interest:</u> The author(s) declare no conflict of interest.</p>\r\n<p><u>If there is a conflict of interest:</u> The author(s) declare the following potential conflicts of interest: [provide details].</p>\r\n<p><u>If an author has financial or professional affiliations related to the study:</u> Author(s) [name(s)] has/have affiliations with [organization/company]. This affiliation did not influence the design, data collection, analysis, interpretation, or reporting of this study.</p>\r\n<h3><em>Funding statements</em></h3>\r\n<p><u>If funded:</u> This research was funded by [Funding agency] under Grant No. [Grant number].</p>\r\n<p><u>If not funded:</u> This research received no funding.</p>\r\n<h3><em>Ethical Review Board statements</em></h3>\r\n<p>The ethical clearance form for this study has been approved by the [Name of the ethics board/committee] (Approval No. [number/code], Date [insert the date of the approval]).</p>\r\n<h3><em>Artificial intelligence (AI) usage declaration</em></h3>\r\n<p><u>If AI tools were used:</u> The author(s) used [names of AI tools] to assist with [e.g., language editing, proofreading, data coding, or idea generation]. The author(s) carefully reviewed and appropriately revised all outputs and are willing to take full responsibility for the content of this article. This article is now free of AI detection.</p>\r\n<p><u>If AI tools were not used:</u> The author(s) did not use AI tools in the preparation, analysis, and writing of this manuscript. This article is now free of AI detection.</p>\r\n<h3><em>Human involvement statements</em></h3>\r\n<p><u>If human participants were involved:</u> This study involved human participants. Informed consent was obtained from all participants prior to their participation in the study. There was no or minimal risk to the research context in which this study was conducted. The findings of this study offer specific benefits to participants, as outlined in the manuscript.</p>\r\n<p><u>If human participants were not involved:</u> This study did not involve human participants. There was no or minimal risk to the research context in which this study was conducted. The findings of this study offer specific benefits to the research site and international contexts, as outlined in the manuscript.</p>\r\n<h3><em>Data availability statements</em></h3>\r\n<p><u>If data are publicly available:</u> The data supporting the findings of this study are available at [repository name and link].</p>\r\n<p><u>If data are available upon request:</u> The data supporting the findings of this study are available from the corresponding author upon request.</p>\r\n<p><u>If data cannot be shared:</u> The data are not publicly available due to ethical, legal, or privacy restrictions.</p>\r\n<p><u>If no data were generated:</u> N/A. No new data were created or analyzed in this study.</p>','string'),(51,30,'en','remoteUrl','','string'),(52,17,'en','content','','string'),(53,17,'en','remoteUrl','','string'),(54,31,'en','title','Review process','string'),(55,31,'en','content','<h2><strong>Publishing Timeline</strong></h2>\r\n<p>To reduce unnecessary delays in reviewing caused by surging submissions, <em>HEI </em>limits submissions to 20 per month. Each paper is assigned to a code that includes the date and the order of submissions. Submissions that exceed the twentieth in a month will be assigned to the next order for the month that follows.</p>\r\n<ul>\r\n<li>7 days from submission to the subject editorâ€™s first decision</li>\r\n<li>14 days for review</li>\r\n<li>7 days for the editorâ€™s decision</li>\r\n<li>7-14 days for authorsâ€™ revisions</li>\r\n<li>7 days from acceptance to online publication</li>\r\n</ul>\r\n<h2><strong>Review policies</strong></h2>\r\n<p>All editors and reviewers must not disclose any details of any submissions to another party during and after the review process.</p>\r\n<p>Editors and reviewers must immediately inform the Editor-in-Chief of their conflict of interest with the content of the manuscript and/or author(s).</p>\r\n<p>A double-blind review process is conducted at <em>HEI</em> in which both the author(s) and reviewers do not know each otherâ€™s identities.</p>\r\n<p>A subject editor is assigned to review a manuscript submitted to <em>HEI</em>. If the manuscript is evaluated as suitable for <em>HEI</em>â€™s aims and scope and complies with HEIâ€™s requirements, the subject editor and the Editor-in-Chief will send it out for two reviewers who are not in conflict of interest with the author(s).</p>\r\n<h2><strong>Revise</strong></h2>\r\n<p>Author(s) will receive a final decision for their submission and are often asked to revise in line with the reviewersâ€™ comments and suggestions. They must include another separate file titled â€œResponses to Reviewersâ€™ Commentsâ€ and submit it online together with the title page, revised anonymous manuscript, and a clean version of the revised non-anonymous manuscript to <em>HEI</em>â€™s submission platform.</p>\r\n<p>The â€œResponses to Reviewersâ€™ Commentsâ€ file must clearly outline the reviewersâ€™ comments and the author(s)â€™ revision or feedback. Author(s) must not write generic responses, such as â€œalready fixed,â€ â€œthank you, and weâ€™ve revised this issue in the manuscript,â€ or â€œrevised, and please refer to page 8.â€ Author(s) must specify the revised parts or present specific feedback to avoid delays in the subsequent round of review.</p>\r\n<h2><strong>After acceptance</strong></h2>\r\n<p>Authors must sign a copyright transfer form and send it to the article editor before publishing.</p>\r\n<h2><strong>Post acceptance</strong></h2>\r\n<p>All accepted manuscripts are published on <em>HEI</em>â€™s volumes and issues immediately after page proofs are reviewed, and the page layout format is complete. Author(s) are encouraged to post and share their works on their personal and institutional media and platforms after their articles have been officially published by <em>HEI</em>.</p>','string'),(56,31,'en','remoteUrl','','string'),(57,32,'en','title','Abstracting & Indexing','string'),(58,32,'en','content','<h2>Journal Metrics</h2>\r\n<p>The following journal metrics provide an overview of the editorial activity and readership of <strong>Higher Education Inquiry</strong>. These figures are updated annually.</p>\r\n<table style=\"width: 100%; border-collapse: collapse; margin: 20px 0;\">\r\n<tbody>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Year established</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">2026</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Publication frequency</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">Two issues per year</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Peer-review model</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">Double-blind peer review</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Average time to first editorial decision</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">21 days</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Average time from submission to acceptance</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">68 days</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Average time from acceptance to publication</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">24 days</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Acceptance rate</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">38%</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Articles published</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">18 articles</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Downloads and views</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">4,850 article views and downloads</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>International authorship</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">Authors from 12 countries and regions</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p><em>Note: Metrics are provided for demonstration purposes and should be updated with verified journal data.</em></p>\r\n<h2>Abstracting and Indexing</h2>\r\n<p><strong>Higher Education Inquiry</strong> is committed to increasing the visibility, discoverability, and accessibility of published research.</p>\r\n<table style=\"width: 100%; border-collapse: collapse; margin: 20px 0;\">\r\n<thead>\r\n<tr>\r\n<th style=\"border: 1px solid #ccc; padding: 10px; text-align: left;\">Category</th>\r\n<th style=\"border: 1px solid #ccc; padding: 10px; text-align: left;\">Services</th>\r\n</tr>\r\n</thead>\r\n<tbody>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Current discovery and metadata services</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">Google Scholar<br>Crossref Metadata Search<br>OpenAIRE<br>BASE â€“ Bielefeld Academic Search Engine<br>WorldCat<br>ROAD â€“ Directory of Open Access Scholarly Resources</td>\r\n</tr>\r\n<tr>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\"><strong>Target indexing services</strong></td>\r\n<td style=\"border: 1px solid #ccc; padding: 10px;\">Directory of Open Access Journals â€” DOAJ<br>EBSCO academic databases<br>ProQuest academic databases<br>ERIH PLUS<br>Scopus</td>\r\n</tr>\r\n</tbody>\r\n</table>\r\n<p>The journal will update this page as new indexing and abstracting services are confirmed.</p>','string'),(59,32,'en','remoteUrl','','string');
/*!40000 ALTER TABLE `navigation_menu_item_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menu_items`
--

DROP TABLE IF EXISTS `navigation_menu_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_menu_items` (
  `navigation_menu_item_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `path` varchar(255) DEFAULT '',
  `type` varchar(255) DEFAULT '',
  PRIMARY KEY (`navigation_menu_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb3 COMMENT='Navigation menu items are single elements within a navigation menu.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menu_items`
--

LOCK TABLES `navigation_menu_items` WRITE;
/*!40000 ALTER TABLE `navigation_menu_items` DISABLE KEYS */;
INSERT INTO `navigation_menu_items` VALUES (1,0,NULL,'NMI_TYPE_USER_REGISTER'),(2,0,NULL,'NMI_TYPE_USER_LOGIN'),(3,0,NULL,'NMI_TYPE_USER_DASHBOARD'),(4,0,NULL,'NMI_TYPE_USER_DASHBOARD'),(5,0,NULL,'NMI_TYPE_USER_PROFILE'),(6,0,NULL,'NMI_TYPE_ADMINISTRATION'),(7,0,NULL,'NMI_TYPE_USER_LOGOUT'),(8,1,NULL,'NMI_TYPE_USER_REGISTER'),(9,1,NULL,'NMI_TYPE_USER_LOGIN'),(10,1,'','NMI_TYPE_USER_DASHBOARD'),(11,1,NULL,'NMI_TYPE_USER_DASHBOARD'),(12,1,NULL,'NMI_TYPE_USER_PROFILE'),(13,1,NULL,'NMI_TYPE_ADMINISTRATION'),(14,1,NULL,'NMI_TYPE_USER_LOGOUT'),(15,1,NULL,'NMI_TYPE_CURRENT'),(16,1,NULL,'NMI_TYPE_ARCHIVES'),(17,1,'','NMI_TYPE_ANNOUNCEMENTS'),(19,1,'','NMI_TYPE_ABOUT'),(20,1,'submission','NMI_TYPE_SUBMISSIONS'),(21,1,'','NMI_TYPE_EDITORIAL_TEAM'),(22,1,NULL,'NMI_TYPE_PRIVACY'),(23,1,NULL,'NMI_TYPE_CONTACT'),(24,1,NULL,'NMI_TYPE_SEARCH'),(25,1,'','NMI_TYPE_ABOUT'),(26,1,'scopes','NMI_TYPE_CUSTOM'),(27,1,'author_guidelines','NMI_TYPE_CUSTOM'),(28,1,'for_authors','NMI_TYPE_CUSTOM'),(29,1,'article_types','NMI_TYPE_CUSTOM'),(30,1,'submission_guidelines','NMI_TYPE_CUSTOM'),(31,1,'review_process','NMI_TYPE_CUSTOM'),(32,1,'abstracting_indexing','NMI_TYPE_CUSTOM');
/*!40000 ALTER TABLE `navigation_menu_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_menus`
--

DROP TABLE IF EXISTS `navigation_menus`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `navigation_menus` (
  `navigation_menu_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `area_name` varchar(255) DEFAULT '',
  `title` varchar(255) NOT NULL,
  PRIMARY KEY (`navigation_menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3 COMMENT='Navigation menus on the website are installed with the software as a default set, and can be customized.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_menus`
--

LOCK TABLES `navigation_menus` WRITE;
/*!40000 ALTER TABLE `navigation_menus` DISABLE KEYS */;
INSERT INTO `navigation_menus` VALUES (1,0,'user','User Navigation Menu'),(2,1,'user','User Navigation Menu'),(3,1,'primary','Primary Navigation Menu');
/*!40000 ALTER TABLE `navigation_menus` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `note_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `date_created` datetime NOT NULL,
  `date_modified` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `contents` text,
  PRIMARY KEY (`note_id`),
  KEY `notes_user_id` (`user_id`),
  KEY `notes_assoc` (`assoc_type`,`assoc_id`),
  CONSTRAINT `notes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Notes allow users to annotate associated entities, such as submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_settings`
--

DROP TABLE IF EXISTS `notification_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_settings` (
  `notification_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `notification_id` bigint NOT NULL,
  `locale` varchar(14) DEFAULT NULL,
  `setting_name` varchar(64) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`notification_setting_id`),
  UNIQUE KEY `notification_settings_unique` (`notification_id`,`locale`,`setting_name`),
  KEY `notification_settings_notification_id` (`notification_id`),
  CONSTRAINT `notification_settings_notification_id_foreign` FOREIGN KEY (`notification_id`) REFERENCES `notifications` (`notification_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=70 DEFAULT CHARSET=utf8mb3 COMMENT='More data about notifications, including localized properties.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_settings`
--

LOCK TABLES `notification_settings` WRITE;
/*!40000 ALTER TABLE `notification_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification_subscription_settings`
--

DROP TABLE IF EXISTS `notification_subscription_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification_subscription_settings` (
  `setting_id` bigint NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(64) NOT NULL,
  `setting_value` mediumtext NOT NULL,
  `user_id` bigint NOT NULL,
  `context` bigint DEFAULT NULL,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`setting_id`),
  KEY `notification_subscription_settings_user_id` (`user_id`),
  KEY `notification_subscription_settings_context` (`context`),
  CONSTRAINT `notification_subscription_settings_context_foreign` FOREIGN KEY (`context`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `notification_subscription_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Which email notifications a user has chosen to unsubscribe from.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification_subscription_settings`
--

LOCK TABLES `notification_subscription_settings` WRITE;
/*!40000 ALTER TABLE `notification_subscription_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification_subscription_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `notification_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `level` bigint NOT NULL,
  `type` bigint NOT NULL,
  `date_created` datetime NOT NULL,
  `date_read` datetime DEFAULT NULL,
  `assoc_type` bigint DEFAULT NULL,
  `assoc_id` bigint DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `notifications_context_id` (`context_id`),
  KEY `notifications_user_id` (`user_id`),
  KEY `notifications_context_id_user_id` (`context_id`,`user_id`,`level`),
  KEY `notifications_context_id_level` (`context_id`,`level`),
  KEY `notifications_assoc` (`assoc_type`,`assoc_id`),
  KEY `notifications_user_id_level` (`user_id`,`level`),
  CONSTRAINT `notifications_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `notifications_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb3 COMMENT='User notifications created during certain operations.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oai_resumption_tokens`
--

DROP TABLE IF EXISTS `oai_resumption_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oai_resumption_tokens` (
  `oai_resumption_token_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `token` varchar(32) NOT NULL,
  `expire` bigint NOT NULL,
  `record_offset` int NOT NULL,
  `params` text,
  PRIMARY KEY (`oai_resumption_token_id`),
  UNIQUE KEY `oai_resumption_tokens_unique` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='OAI resumption tokens are used to allow for pagination of large result sets into manageable pieces.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oai_resumption_tokens`
--

LOCK TABLES `oai_resumption_tokens` WRITE;
/*!40000 ALTER TABLE `oai_resumption_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `oai_resumption_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `plugin_settings`
--

DROP TABLE IF EXISTS `plugin_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `plugin_settings` (
  `plugin_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `plugin_name` varchar(80) NOT NULL,
  `context_id` bigint NOT NULL,
  `setting_name` varchar(80) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`plugin_setting_id`),
  UNIQUE KEY `plugin_settings_unique` (`plugin_name`,`context_id`,`setting_name`),
  KEY `plugin_settings_plugin_name` (`plugin_name`)
) ENGINE=InnoDB AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb3 COMMENT='More data about plugins, including localized properties. This table is frequently used to store plugin-specific configuration.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `plugin_settings`
--

LOCK TABLES `plugin_settings` WRITE;
/*!40000 ALTER TABLE `plugin_settings` DISABLE KEYS */;
INSERT INTO `plugin_settings` VALUES (1,'acronplugin',0,'enabled','1','bool'),(2,'acronplugin',0,'crontab','[{\"className\":\"APP\\\\plugins\\\\importexport\\\\doaj\\\\DOAJInfoSender\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\ReviewReminder\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\StatisticsReport\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"APP\\\\tasks\\\\SubscriptionExpiryReminder\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"PKP\\\\task\\\\DepositDois\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\RemoveUnvalidatedExpiredUsers\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"PKP\\\\task\\\\EditorialReminders\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"PKP\\\\task\\\\UpdateIPGeoDB\",\"frequency\":{\"day\":\"10\"},\"args\":[]},{\"className\":\"APP\\\\tasks\\\\UsageStatsLoader\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\ProcessQueueJobs\",\"frequency\":{\"hour\":24},\"args\":[]},{\"className\":\"PKP\\\\task\\\\RemoveFailedJobs\",\"frequency\":{\"day\":\"1\"},\"args\":[]},{\"className\":\"APP\\\\tasks\\\\OpenAccessNotification\",\"frequency\":{\"hour\":24},\"args\":[]}]','object'),(3,'defaultthemeplugin',0,'enabled','1','bool'),(4,'tinymceplugin',0,'enabled','1','bool'),(5,'usageeventplugin',0,'enabled','1','bool'),(6,'developedbyblockplugin',0,'enabled','0','bool'),(7,'developedbyblockplugin',0,'seq','0','int'),(8,'languagetoggleblockplugin',0,'enabled','1','bool'),(9,'languagetoggleblockplugin',0,'seq','4','int'),(10,'defaultthemeplugin',1,'enabled','1','bool'),(11,'tinymceplugin',1,'enabled','1','bool'),(12,'developedbyblockplugin',1,'enabled','1','bool'),(13,'developedbyblockplugin',1,'seq','0','int'),(14,'informationblockplugin',1,'enabled','1','bool'),(15,'informationblockplugin',1,'seq','7','int'),(16,'languagetoggleblockplugin',1,'enabled','1','bool'),(17,'languagetoggleblockplugin',1,'seq','4','int'),(18,'subscriptionblockplugin',1,'enabled','1','bool'),(19,'subscriptionblockplugin',1,'seq','2','int'),(20,'resolverplugin',1,'enabled','1','bool'),(21,'dublincoremetaplugin',1,'enabled','1','bool'),(22,'googlescholarplugin',1,'enabled','1','bool'),(23,'htmlarticlegalleyplugin',1,'enabled','1','bool'),(24,'lensgalleyplugin',1,'enabled','1','bool'),(25,'pdfjsviewerplugin',1,'enabled','1','bool'),(26,'webfeedplugin',1,'enabled','1','bool'),(27,'webfeedplugin',1,'displayPage','homepage','string'),(28,'webfeedplugin',1,'displayItems','1','bool'),(29,'webfeedplugin',1,'recentItems','30','int'),(30,'webfeedplugin',1,'includeIdentifiers','0','bool'),(31,'defaultthemeplugin',1,'typography','notoSans','string'),(32,'defaultthemeplugin',1,'baseColour','#175AC9','string'),(33,'defaultthemeplugin',1,'showDescriptionInJournalIndex','true','string'),(34,'defaultthemeplugin',1,'useHomepageImageAsHeader','true','string'),(35,'defaultthemeplugin',1,'displayStats','bar','string'),(36,'browseblockplugin',1,'enabled','1','bool'),(37,'makesubmissionblockplugin',1,'enabled','1','bool'),(38,'orcidprofileplugin',1,'enabled','1','bool'),(39,'recommendbyauthorplugin',1,'enabled','1','bool'),(40,'recommendbysimilarityplugin',1,'enabled','1','bool'),(41,'customblockmanagerplugin',1,'enabled','1','bool'),(42,'crossrefplugin',1,'enabled','1','bool'),(43,'citationstylelanguageplugin',1,'enabled','1','bool'),(44,'googleanalyticsplugin',1,'enabled','1','bool'),(45,'staticpagesplugin',1,'enabled','1','bool'),(46,'immersionthemeplugin',1,'enabled','1','bool'),(47,'immersionthemeplugin',1,'sectionDescriptionSetting','enable','string'),(48,'immersionthemeplugin',1,'journalDescription','1','string'),(49,'immersionthemeplugin',1,'journalDescriptionColour','#1F61A6','string'),(50,'immersionthemeplugin',1,'immersionAnnouncementsColor','#1F61A6','string'),(51,'immersionthemeplugin',1,'abstractsOnIssuePage','fadeoutAbstracts','string'),(52,'immersionthemeplugin',1,'displayStats','line','string'),(53,'dataciteplugin',1,'enabled','1','bool');
/*!40000 ALTER TABLE `plugin_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_categories`
--

DROP TABLE IF EXISTS `publication_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_categories` (
  `publication_category_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `publication_id` bigint NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`publication_category_id`),
  UNIQUE KEY `publication_categories_id` (`publication_id`,`category_id`),
  KEY `publication_categories_publication_id` (`publication_id`),
  KEY `publication_categories_category_id` (`category_id`),
  CONSTRAINT `publication_categories_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`) ON DELETE CASCADE,
  CONSTRAINT `publication_categories_publication_id_foreign` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Associates publications (and thus submissions) with categories.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_categories`
--

LOCK TABLES `publication_categories` WRITE;
/*!40000 ALTER TABLE `publication_categories` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_galley_settings`
--

DROP TABLE IF EXISTS `publication_galley_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_galley_settings` (
  `publication_galley_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `galley_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`publication_galley_setting_id`),
  UNIQUE KEY `publication_galley_settings_unique` (`galley_id`,`locale`,`setting_name`),
  KEY `publication_galley_settings_galley_id` (`galley_id`),
  KEY `publication_galley_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  CONSTRAINT `publication_galley_settings_galley_id` FOREIGN KEY (`galley_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about publication galleys, including localized content such as labels.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_galley_settings`
--

LOCK TABLES `publication_galley_settings` WRITE;
/*!40000 ALTER TABLE `publication_galley_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_galley_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_galleys`
--

DROP TABLE IF EXISTS `publication_galleys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_galleys` (
  `galley_id` bigint NOT NULL AUTO_INCREMENT,
  `locale` varchar(14) DEFAULT NULL,
  `publication_id` bigint NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `submission_file_id` bigint unsigned DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `remote_url` varchar(2047) DEFAULT NULL,
  `is_approved` smallint NOT NULL DEFAULT '0',
  `url_path` varchar(64) DEFAULT NULL,
  `doi_id` bigint DEFAULT NULL,
  PRIMARY KEY (`galley_id`),
  KEY `publication_galleys_publication_id` (`publication_id`),
  KEY `publication_galleys_submission_file_id` (`submission_file_id`),
  KEY `publication_galleys_doi_id` (`doi_id`),
  KEY `publication_galleys_url_path` (`url_path`),
  CONSTRAINT `publication_galleys_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  CONSTRAINT `publication_galleys_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE,
  CONSTRAINT `publication_galleys_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Publication galleys are representations of a publication in a specific format, e.g. a PDF.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_galleys`
--

LOCK TABLES `publication_galleys` WRITE;
/*!40000 ALTER TABLE `publication_galleys` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_galleys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publication_settings`
--

DROP TABLE IF EXISTS `publication_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publication_settings` (
  `publication_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `publication_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`publication_setting_id`),
  UNIQUE KEY `publication_settings_unique` (`publication_id`,`locale`,`setting_name`),
  KEY `publication_settings_name_value` (`setting_name`(50),`setting_value`(150)),
  KEY `publication_settings_publication_id` (`publication_id`),
  CONSTRAINT `publication_settings_publication_id` FOREIGN KEY (`publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='More data about publications, including localized properties such as the title and abstract.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publication_settings`
--

LOCK TABLES `publication_settings` WRITE;
/*!40000 ALTER TABLE `publication_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `publication_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publications`
--

DROP TABLE IF EXISTS `publications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publications` (
  `publication_id` bigint NOT NULL AUTO_INCREMENT,
  `access_status` bigint DEFAULT '0',
  `date_published` date DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `primary_contact_id` bigint DEFAULT NULL,
  `section_id` bigint DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `submission_id` bigint NOT NULL,
  `status` smallint NOT NULL DEFAULT '1',
  `url_path` varchar(64) DEFAULT NULL,
  `version` bigint DEFAULT NULL,
  `doi_id` bigint DEFAULT NULL,
  PRIMARY KEY (`publication_id`),
  KEY `publications_primary_contact_id` (`primary_contact_id`),
  KEY `publications_section_id` (`section_id`),
  KEY `publications_submission_id` (`submission_id`),
  KEY `publications_doi_id` (`doi_id`),
  KEY `publications_url_path` (`url_path`),
  CONSTRAINT `publications_doi_id_foreign` FOREIGN KEY (`doi_id`) REFERENCES `dois` (`doi_id`) ON DELETE SET NULL,
  CONSTRAINT `publications_primary_contact_id` FOREIGN KEY (`primary_contact_id`) REFERENCES `authors` (`author_id`) ON DELETE SET NULL,
  CONSTRAINT `publications_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE SET NULL,
  CONSTRAINT `publications_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='Each publication is one version of a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publications`
--

LOCK TABLES `publications` WRITE;
/*!40000 ALTER TABLE `publications` DISABLE KEYS */;
/*!40000 ALTER TABLE `publications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queries`
--

DROP TABLE IF EXISTS `queries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queries` (
  `query_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `stage_id` smallint NOT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `date_posted` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `closed` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`query_id`),
  KEY `queries_assoc_id` (`assoc_type`,`assoc_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Discussions, usually related to a submission, created by editors, authors and other editorial staff.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queries`
--

LOCK TABLES `queries` WRITE;
/*!40000 ALTER TABLE `queries` DISABLE KEYS */;
/*!40000 ALTER TABLE `queries` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `query_participants`
--

DROP TABLE IF EXISTS `query_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `query_participants` (
  `query_participant_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `query_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`query_participant_id`),
  UNIQUE KEY `query_participants_unique` (`query_id`,`user_id`),
  KEY `query_participants_query_id` (`query_id`),
  KEY `query_participants_user_id` (`user_id`),
  CONSTRAINT `query_participants_query_id_foreign` FOREIGN KEY (`query_id`) REFERENCES `queries` (`query_id`) ON DELETE CASCADE,
  CONSTRAINT `query_participants_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='The users assigned to a discussion.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `query_participants`
--

LOCK TABLES `query_participants` WRITE;
/*!40000 ALTER TABLE `query_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `query_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `queued_payments`
--

DROP TABLE IF EXISTS `queued_payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `queued_payments` (
  `queued_payment_id` bigint NOT NULL AUTO_INCREMENT,
  `date_created` datetime NOT NULL,
  `date_modified` datetime NOT NULL,
  `expiry_date` date DEFAULT NULL,
  `payment_data` text,
  PRIMARY KEY (`queued_payment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Unfulfilled (queued) payments, i.e. payments that have not yet been completed via an online payment system.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `queued_payments`
--

LOCK TABLES `queued_payments` WRITE;
/*!40000 ALTER TABLE `queued_payments` DISABLE KEYS */;
/*!40000 ALTER TABLE `queued_payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_assignments`
--

DROP TABLE IF EXISTS `review_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_assignments` (
  `review_id` bigint NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `reviewer_id` bigint NOT NULL,
  `competing_interests` text,
  `recommendation` smallint DEFAULT NULL,
  `date_assigned` datetime DEFAULT NULL,
  `date_notified` datetime DEFAULT NULL,
  `date_confirmed` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `date_acknowledged` datetime DEFAULT NULL,
  `date_due` datetime DEFAULT NULL,
  `date_response_due` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `reminder_was_automatic` smallint NOT NULL DEFAULT '0',
  `declined` smallint NOT NULL DEFAULT '0',
  `cancelled` smallint NOT NULL DEFAULT '0',
  `date_rated` datetime DEFAULT NULL,
  `date_reminded` datetime DEFAULT NULL,
  `quality` smallint DEFAULT NULL,
  `review_round_id` bigint NOT NULL,
  `stage_id` smallint NOT NULL,
  `review_method` smallint NOT NULL DEFAULT '1',
  `round` smallint NOT NULL DEFAULT '1',
  `step` smallint NOT NULL DEFAULT '1',
  `review_form_id` bigint DEFAULT NULL,
  `considered` smallint DEFAULT NULL,
  `request_resent` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`review_id`),
  KEY `review_assignments_submission_id` (`submission_id`),
  KEY `review_assignments_reviewer_id` (`reviewer_id`),
  KEY `review_assignment_reviewer_round` (`review_round_id`,`reviewer_id`),
  KEY `review_assignments_form_id` (`review_form_id`),
  KEY `review_assignments_reviewer_review` (`reviewer_id`,`review_id`),
  CONSTRAINT `review_assignments_review_form_id_foreign` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`),
  CONSTRAINT `review_assignments_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`),
  CONSTRAINT `review_assignments_reviewer_id_foreign` FOREIGN KEY (`reviewer_id`) REFERENCES `users` (`user_id`),
  CONSTRAINT `review_assignments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Data about peer review assignments for all submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_assignments`
--

LOCK TABLES `review_assignments` WRITE;
/*!40000 ALTER TABLE `review_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_files`
--

DROP TABLE IF EXISTS `review_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_files` (
  `review_file_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `review_id` bigint NOT NULL,
  `submission_file_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`review_file_id`),
  UNIQUE KEY `review_files_unique` (`review_id`,`submission_file_id`),
  KEY `review_files_review_id` (`review_id`),
  KEY `review_files_submission_file_id` (`submission_file_id`),
  CONSTRAINT `review_files_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE,
  CONSTRAINT `review_files_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of the submission files made available to each assigned reviewer.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_files`
--

LOCK TABLES `review_files` WRITE;
/*!40000 ALTER TABLE `review_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_element_settings`
--

DROP TABLE IF EXISTS `review_form_element_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_form_element_settings` (
  `review_form_element_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `review_form_element_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`review_form_element_setting_id`),
  UNIQUE KEY `review_form_element_settings_unique` (`review_form_element_id`,`locale`,`setting_name`),
  KEY `review_form_element_settings_review_form_element_id` (`review_form_element_id`),
  CONSTRAINT `review_form_element_settings_review_form_element_id` FOREIGN KEY (`review_form_element_id`) REFERENCES `review_form_elements` (`review_form_element_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about review form elements, including localized content such as question text.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_element_settings`
--

LOCK TABLES `review_form_element_settings` WRITE;
/*!40000 ALTER TABLE `review_form_element_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_element_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_elements`
--

DROP TABLE IF EXISTS `review_form_elements`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_form_elements` (
  `review_form_element_id` bigint NOT NULL AUTO_INCREMENT,
  `review_form_id` bigint NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  `element_type` bigint DEFAULT NULL,
  `required` smallint DEFAULT NULL,
  `included` smallint DEFAULT NULL,
  PRIMARY KEY (`review_form_element_id`),
  KEY `review_form_elements_review_form_id` (`review_form_id`),
  CONSTRAINT `review_form_elements_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Each review form element represents a single question on a review form.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_elements`
--

LOCK TABLES `review_form_elements` WRITE;
/*!40000 ALTER TABLE `review_form_elements` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_elements` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_responses`
--

DROP TABLE IF EXISTS `review_form_responses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_form_responses` (
  `review_form_response_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `review_form_element_id` bigint NOT NULL,
  `review_id` bigint NOT NULL,
  `response_type` varchar(6) DEFAULT NULL,
  `response_value` text,
  PRIMARY KEY (`review_form_response_id`),
  KEY `review_form_responses_review_form_element_id` (`review_form_element_id`),
  KEY `review_form_responses_review_id` (`review_id`),
  KEY `review_form_responses_unique` (`review_form_element_id`,`review_id`),
  CONSTRAINT `review_form_responses_review_form_element_id_foreign` FOREIGN KEY (`review_form_element_id`) REFERENCES `review_form_elements` (`review_form_element_id`) ON DELETE CASCADE,
  CONSTRAINT `review_form_responses_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `review_assignments` (`review_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Each review form response records a reviewer''s answer to a review form element associated with a peer review.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_responses`
--

LOCK TABLES `review_form_responses` WRITE;
/*!40000 ALTER TABLE `review_form_responses` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_responses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_form_settings`
--

DROP TABLE IF EXISTS `review_form_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_form_settings` (
  `review_form_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `review_form_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`review_form_setting_id`),
  UNIQUE KEY `review_form_settings_unique` (`review_form_id`,`locale`,`setting_name`),
  KEY `review_form_settings_review_form_id` (`review_form_id`),
  CONSTRAINT `review_form_settings_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about review forms, including localized content such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_form_settings`
--

LOCK TABLES `review_form_settings` WRITE;
/*!40000 ALTER TABLE `review_form_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_form_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_forms`
--

DROP TABLE IF EXISTS `review_forms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_forms` (
  `review_form_id` bigint NOT NULL AUTO_INCREMENT,
  `assoc_type` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `seq` double(8,2) DEFAULT NULL,
  `is_active` smallint DEFAULT NULL,
  PRIMARY KEY (`review_form_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Review forms provide custom templates for peer reviews with several types of questions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_forms`
--

LOCK TABLES `review_forms` WRITE;
/*!40000 ALTER TABLE `review_forms` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_forms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_round_files`
--

DROP TABLE IF EXISTS `review_round_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_round_files` (
  `review_round_file_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `review_round_id` bigint NOT NULL,
  `stage_id` smallint NOT NULL,
  `submission_file_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`review_round_file_id`),
  UNIQUE KEY `review_round_files_unique` (`submission_id`,`review_round_id`,`submission_file_id`),
  KEY `review_round_files_submission_id` (`submission_id`),
  KEY `review_round_files_review_round_id` (`review_round_id`),
  KEY `review_round_files_submission_file_id` (`submission_file_id`),
  CONSTRAINT `review_round_files_review_round_id_foreign` FOREIGN KEY (`review_round_id`) REFERENCES `review_rounds` (`review_round_id`) ON DELETE CASCADE,
  CONSTRAINT `review_round_files_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `review_round_files_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Records the files made available to reviewers for a round of reviews. These can be further customized on a per review basis with review_files.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_round_files`
--

LOCK TABLES `review_round_files` WRITE;
/*!40000 ALTER TABLE `review_round_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_round_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `review_rounds`
--

DROP TABLE IF EXISTS `review_rounds`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review_rounds` (
  `review_round_id` bigint NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `stage_id` bigint DEFAULT NULL,
  `round` smallint NOT NULL,
  `review_revision` bigint DEFAULT NULL,
  `status` bigint DEFAULT NULL,
  PRIMARY KEY (`review_round_id`),
  UNIQUE KEY `review_rounds_submission_id_stage_id_round_pkey` (`submission_id`,`stage_id`,`round`),
  KEY `review_rounds_submission_id` (`submission_id`),
  CONSTRAINT `review_rounds_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Peer review assignments are organized into multiple rounds on a submission.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `review_rounds`
--

LOCK TABLES `review_rounds` WRITE;
/*!40000 ALTER TABLE `review_rounds` DISABLE KEYS */;
/*!40000 ALTER TABLE `review_rounds` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduled_tasks`
--

DROP TABLE IF EXISTS `scheduled_tasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduled_tasks` (
  `scheduled_task_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `class_name` varchar(255) NOT NULL,
  `last_run` datetime DEFAULT NULL,
  PRIMARY KEY (`scheduled_task_id`),
  UNIQUE KEY `scheduled_tasks_unique` (`class_name`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COMMENT='The last time each scheduled task was run.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduled_tasks`
--

LOCK TABLES `scheduled_tasks` WRITE;
/*!40000 ALTER TABLE `scheduled_tasks` DISABLE KEYS */;
INSERT INTO `scheduled_tasks` VALUES (1,'PKP\\task\\ReviewReminder','2026-06-03 15:09:04'),(2,'PKP\\task\\StatisticsReport','2026-06-03 15:09:04'),(3,'APP\\tasks\\SubscriptionExpiryReminder','2026-06-03 15:09:09'),(4,'PKP\\task\\DepositDois','2026-06-03 15:09:09'),(5,'PKP\\task\\RemoveUnvalidatedExpiredUsers','2026-06-03 15:09:09'),(6,'PKP\\task\\EditorialReminders','2026-06-03 15:09:09'),(7,'PKP\\task\\UpdateIPGeoDB','2026-06-03 15:09:09'),(8,'APP\\tasks\\UsageStatsLoader','2026-06-03 15:09:33'),(9,'PKP\\task\\ProcessQueueJobs','2026-06-03 15:09:33'),(10,'PKP\\task\\RemoveFailedJobs','2026-06-03 15:09:33'),(11,'APP\\tasks\\OpenAccessNotification','2026-06-03 15:09:34'),(12,'APP\\plugins\\importexport\\doaj\\DOAJInfoSender','2026-06-03 18:06:18');
/*!40000 ALTER TABLE `scheduled_tasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `section_settings`
--

DROP TABLE IF EXISTS `section_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `section_settings` (
  `section_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `section_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`section_setting_id`),
  UNIQUE KEY `section_settings_unique` (`section_id`,`locale`,`setting_name`),
  KEY `section_settings_section_id` (`section_id`),
  CONSTRAINT `section_settings_section_id` FOREIGN KEY (`section_id`) REFERENCES `sections` (`section_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb3 COMMENT='More data about sections, including localized properties like section titles.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `section_settings`
--

LOCK TABLES `section_settings` WRITE;
/*!40000 ALTER TABLE `section_settings` DISABLE KEYS */;
INSERT INTO `section_settings` VALUES (1,1,'en','title','Full-length research articles'),(2,1,'en','abbrev','ART'),(3,1,'en','policy','<p>A full-length research article must demonstrate an empirical study with original findings that align with <em>HEI</em>â€™s aims and scopes. It must be around 7,500 to 8,000 words, including all main components (except appendices and supplementary materials). It should follow this structure:</p>\r\n<ul>\r\n<li>Introduction</li>\r\n<li>Literature review</li>\r\n<li>Theoretical or conceptual framing</li>\r\n<li>Methods, including ethical considerations and the benefits the study brings to the participants and research contexts</li>\r\n<li>Results/Findings</li>\r\n<li>Discussion</li>\r\n<li>Theoretical and practical implications</li>\r\n<li>Conclusion</li>\r\n<li>Limitations</li>\r\n<li>Suggestions or recommendations for further research</li>\r\n<li>References</li>\r\n<li>Appendices (if any, and limit them to a minimum)</li>\r\n<li>Supplementary materials (if any, and sent in a separate file)</li>\r\n</ul>'),(4,1,'en','identifyType','Full-length research articles'),(5,2,'en','title','Critical or systematic literature review'),(6,2,'en','abbrev','SYSR'),(7,2,'en','identifyType','\"Critical literature review\", \"Systematic literature review\"'),(8,2,'en','policy','<p>The word count for this type of article ranges from 7,500 to 8,000 words, including all main components. All articles must address robust questions that are timely and relevant to higher education. Methodologies for the review must be included, clearly explained, and argued.</p>'),(9,3,'en','title','Methodological papers'),(10,3,'en','abbrev','MEP'),(11,3,'en','identifyType','Methodological Paper'),(12,3,'en','policy','<p>Written in between 7,500 and 8,000 words (including all main components), all articles of this type must present innovative methodological approaches in higher education research.</p>'),(13,4,'en','title','Practice-based and policy impact articles'),(14,4,'en','abbrev','POLP'),(15,4,'en','identifyType','Practice-based and Policy Impact Article'),(16,4,'en','policy','<p>All articles of this type must be between 7,500 and 8,000 words, including all main components and excluding appendices and supplementary materials (which should be kept to a minimum). Authors must focus on educational practices and/or effects of higher education policies in several contexts (cross-national contexts are encouraged). Papers of this style must clearly demonstrate policy and practice implications to international contexts.</p>'),(17,5,'en','title','Academic papers'),(18,5,'en','abbrev','ACAP'),(19,5,'en','identifyType','Academic papers'),(20,5,'en','policy','<p>All articles of this type must be written between 5,000 and 5,500 words, including all main components. They must briefly, yet analytically and critically, review practice-based studies in higher education and/or policy effects, including the authorsâ€™ critical evaluations and opinions.</p>');
/*!40000 ALTER TABLE `section_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sections`
--

DROP TABLE IF EXISTS `sections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sections` (
  `section_id` bigint NOT NULL AUTO_INCREMENT,
  `journal_id` bigint NOT NULL,
  `review_form_id` bigint DEFAULT NULL,
  `seq` double(8,2) NOT NULL DEFAULT '0.00',
  `editor_restricted` smallint NOT NULL DEFAULT '0',
  `meta_indexed` smallint NOT NULL DEFAULT '0',
  `meta_reviewed` smallint NOT NULL DEFAULT '1',
  `abstracts_not_required` smallint NOT NULL DEFAULT '0',
  `hide_title` smallint NOT NULL DEFAULT '0',
  `hide_author` smallint NOT NULL DEFAULT '0',
  `is_inactive` smallint NOT NULL DEFAULT '0',
  `abstract_word_count` bigint DEFAULT NULL,
  PRIMARY KEY (`section_id`),
  KEY `sections_journal_id` (`journal_id`),
  KEY `sections_review_form_id` (`review_form_id`),
  CONSTRAINT `sections_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `sections_review_form_id` FOREIGN KEY (`review_form_id`) REFERENCES `review_forms` (`review_form_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='A list of all sections into which submissions can be organized, forming the table of contents.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sections`
--

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;
INSERT INTO `sections` VALUES (1,1,NULL,0.00,0,1,1,0,0,0,0,7),(2,1,NULL,1.00,0,1,1,0,0,0,0,7),(3,1,NULL,2.00,0,1,1,0,0,0,0,7),(4,1,NULL,3.00,0,1,1,0,0,0,0,7),(5,1,NULL,4.00,0,1,1,0,0,0,0,5);
/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `session_id` varchar(128) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `ip_address` varchar(39) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `created` bigint NOT NULL DEFAULT '0',
  `last_used` bigint NOT NULL DEFAULT '0',
  `remember` smallint NOT NULL DEFAULT '0',
  `data` text NOT NULL,
  `domain` varchar(255) DEFAULT NULL,
  UNIQUE KEY `sessions_pkey` (`session_id`),
  KEY `sessions_user_id` (`user_id`),
  CONSTRAINT `sessions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Session data for logged-in users.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES ('0u8m14vdse3cgrtbl0gu4fvlfq',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780487290,1780487585,0,'','removed-gout-procurer.ngrok-free.dev'),('1nded13cgqusiaotefpv6v8o7a',1,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780474141,1780494389,1,'csrf|a:2:{s:9:\"timestamp\";i:1780494389;s:5:\"token\";s:32:\"0fad572c9e5ceccab6d35132a8760222\";}username|s:5:\"admin\";email|s:24:\"nguyenb1407364@gmail.com\";currentLocale|s:2:\"en\";userId|i:1;','localhost'),('37991jtmph4r5o5793bf7e2aur',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490682,1780490682,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490682;s:5:\"token\";s:32:\"77e242bc349df4e63927f52cec4eb79f\";}','turn-federal-britain-auburn.trycloudflare.com'),('37o2oq6mv9b7g0b7r6v61bilom',NULL,'::1','WhatsApp/2',1780487284,1780487284,0,'','removed-gout-procurer.ngrok-free.dev'),('3jc39ulsivvo1rn4v6vbfan27t',NULL,'127.0.0.1','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) _zbot',1780488403,1780488403,0,'','removed-gout-procurer.ngrok-free.dev'),('3pnqtk9q7is7hftgu3m1rg0fm4',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490370,1780490370,0,'','turn-federal-britain-auburn.trycloudflare.com'),('4auh76vmnuqlctbung6udd7sbv',NULL,'::1','WhatsApp/2',1780491308,1780491309,0,'','turn-federal-britain-auburn.trycloudflare.com'),('4qfs6gsk6016194vmsmistv5re',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780477637,1780483028,0,'csrf|a:2:{s:9:\"timestamp\";i:1780480774;s:5:\"token\";s:32:\"cf2b44760e7f3801653616870a5a42cc\";}username|s:10:\"nguyennt64\";','localhost'),('5ggie56bgirn858khe9er7k3fs',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780491288,1780491368,0,'','turn-federal-britain-auburn.trycloudflare.com'),('5o9vli28q8lhm2jg559impflkd',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780492316,1780492316,0,'','localhost'),('6s6gj3p6odrfa2kp7di950t9c5',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780491464,1780491464,0,'','turn-federal-britain-auburn.trycloudflare.com'),('74l930dht79olvm1rvr3oolp1m',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490719,1780490719,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490719;s:5:\"token\";s:32:\"74a9042cc1a846b70efd16fa769b9cb2\";}','turn-federal-britain-auburn.trycloudflare.com'),('831gvqv3ldsvdnp1dk23a4jt7t',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490687,1780490687,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490687;s:5:\"token\";s:32:\"30eee522f19e7d0ae0f3c63853622fd1\";}','turn-federal-britain-auburn.trycloudflare.com'),('8i4qan9d3m49ooobhs9oo65kni',NULL,'::1','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) _zbot',1780486478,1780486478,0,'','removed-gout-procurer.ngrok-free.dev'),('bu6h0n6b99rmjr7muekpd92scg',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/147.0.0.0 Safari/537.36',1780488448,1780488448,0,'','ojs.test'),('cmeqsjs76fcavi6n2lp89h5tk9',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0',1780491418,1780491419,0,'','turn-federal-britain-auburn.trycloudflare.com'),('d4mh8mnoks2jkopg18p16r6oa1',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490396,1780490396,0,'','turn-federal-britain-auburn.trycloudflare.com'),('daut33b11jieomdl2l39rftesv',NULL,'::1','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Mobile Safari/537.36',1780491314,1780491394,0,'','turn-federal-britain-auburn.trycloudflare.com'),('dc9conu6n7746409a4lpnvhj7m',NULL,'::1','Mozilla/5.0 (Linux; Android 14; SM-S711B Build/UP1A.231005.007;) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/148.0.7778.121 Mobile Safari/537.36 Zalo android/260501901 ZaloTheme/light ZaloLanguage/vi',1780491362,1780491402,0,'','turn-federal-britain-auburn.trycloudflare.com'),('df6elsvs2kndvijp7v5h7dug5h',NULL,'::1','Mozilla/5.0 (iPhone; CPU iPhone OS 26_5_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) CriOS/148.0.7778.47 Mobile/15E148 Safari/604.1',1780486489,1780487245,0,'','removed-gout-procurer.ngrok-free.dev'),('dl1hln6b0pod5g0q12ls8g88rr',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490197,1780490197,0,'','turn-federal-britain-auburn.trycloudflare.com'),('f3pccecuiptus4ngtm61mq9rjp',5,'::1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Zalo iOS/260501802 ZaloTheme/dark ZaloLanguage/en',1780491051,1780491376,1,'csrf|a:2:{s:9:\"timestamp\";i:1780491376;s:5:\"token\";s:32:\"4fd0b0350ebb5be8a7d6c46667fd65ff\";}userId|i:5;username|s:10:\"nguyennt64\";','turn-federal-britain-auburn.trycloudflare.com'),('gp2mdm04qb37tifpbds5v7fqos',NULL,'127.0.0.1','WhatsApp/2',1780488399,1780488399,0,'','removed-gout-procurer.ngrok-free.dev'),('hshhn8ni5e6affc7m4vi4bto4e',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780477350,1780477353,0,'csrf|a:2:{s:9:\"timestamp\";i:1780477352;s:5:\"token\";s:32:\"5f858f20fb843aa7ed2703d7fc646928\";}','localhost'),('htf8dav451tnv3atgmjfs5ufbk',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490693,1780490693,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490693;s:5:\"token\";s:32:\"adaa93d0af9b33449dedff300a4486f3\";}','turn-federal-britain-auburn.trycloudflare.com'),('i14iu0hqr2tutkbh1hm6g1f281',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490400,1780490400,0,'','turn-federal-britain-auburn.trycloudflare.com'),('j4j4mllc4aqocoprms72q97aj3',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490371,1780490371,0,'','turn-federal-britain-auburn.trycloudflare.com'),('k1i6es23lrp1ll5eu2j6o50div',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490194,1780491150,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490906;s:5:\"token\";s:32:\"1ac75de97dfdac021eb6d44fc21a4c7a\";}','turn-federal-britain-auburn.trycloudflare.com'),('lih4gm2f35qdr9368f1i8ronk9',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780489938,1780489938,0,'','turn-federal-britain-auburn.trycloudflare.com'),('lqgaeak6458vels64b9d6eb9a9',NULL,'::1','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) _zbot',1780491036,1780491036,0,'','turn-federal-britain-auburn.trycloudflare.com'),('n4jsg2aoqvf6o12ppr54b1io9n',NULL,'::1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Zalo iOS/260501802 ZaloTheme/dark ZaloLanguage/en',1780486510,1780487275,0,'','removed-gout-procurer.ngrok-free.dev'),('noju4k60o80b9084vgr6c8mbe3',5,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780483043,1780491172,1,'csrf|a:2:{s:9:\"timestamp\";i:1780491169;s:5:\"token\";s:32:\"d4fe47d8917c78f59866f8ca1a23f662\";}username|s:10:\"nguyennt64\";userId|i:5;','localhost'),('nqrb3dve4qmvmfl3hn5fptuj4a',NULL,'::1','Mozilla/5.0 (Windows NT 6.1; WOW64) SkypeUriPreview Preview/0.5 skype-url-preview@microsoft.com',1780490456,1780490456,0,'','turn-federal-britain-auburn.trycloudflare.com'),('o2ickdb0c217pdkmb6aprss2aa',5,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780483043,1780488824,1,'csrf|a:2:{s:9:\"timestamp\";i:1780488824;s:5:\"token\";s:32:\"d4fe47d8917c78f59866f8ca1a23f662\";}userId|i:5;username|s:10:\"nguyennt64\";','localhost'),('os24ekirsjmku2k5r0cke8cgld',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490673,1780490673,0,'','turn-federal-britain-auburn.trycloudflare.com'),('ov34dp5mgpb6llbnfs9eg9neup',NULL,'::1','WhatsApp/2',1780486477,1780486477,0,'','removed-gout-procurer.ngrok-free.dev'),('pa8ft489vrd1lmu0m2bg5i1ph0',NULL,'::1','WhatsApp/2',1780486768,1780486768,0,'','removed-gout-procurer.ngrok-free.dev'),('pvvhnq4874hp1q58vtf9nffldn',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490673,1780490673,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490673;s:5:\"token\";s:32:\"c11ae62f40c3d7676983cb58e33feefe\";}','turn-federal-britain-auburn.trycloudflare.com'),('qo1nso94c0q6uta3v6or9iuag9',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490350,1780490350,0,'','turn-federal-britain-auburn.trycloudflare.com'),('r3e9cl98e5eof83mu5bupbfgi2',NULL,'127.0.0.1','facebookexternalhit/1.1 (+http://www.facebook.com/externalhit_uatext.php) _zbot',1780488405,1780488405,0,'','removed-gout-procurer.ngrok-free.dev'),('s136l19dpllrrr7p962pfdtr91',NULL,'127.0.0.1','WhatsApp/2',1780488401,1780488401,0,'','removed-gout-procurer.ngrok-free.dev'),('s410324bebrmuk28mb9nr9iv1g',NULL,'::1','Mozilla/5.0 (Windows NT 6.1; WOW64) SkypeUriPreview Preview/0.5 skype-url-preview@microsoft.com',1780490456,1780490456,0,'','turn-federal-britain-auburn.trycloudflare.com'),('u2b7172b5dtje1941s254usv1g',NULL,'127.0.0.1','Mozilla/5.0 (iPhone; CPU iPhone OS 18_7 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Mobile/15E148 Zalo iOS/260501802 ZaloTheme/dark ZaloLanguage/en',1780488408,1780488408,0,'','removed-gout-procurer.ngrok-free.dev'),('u4h6tg89dh7i7b4sc0aps1geia',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490383,1780490383,0,'','turn-federal-britain-auburn.trycloudflare.com'),('un9l8t77p9rnacgqjgveeo2ujg',NULL,'::1','WhatsApp/2',1780486767,1780486767,0,'','removed-gout-procurer.ngrok-free.dev'),('v019i5hhna6u479imqnq5v4srd',NULL,'::1','WhatsApp/2',1780486475,1780486475,0,'','removed-gout-procurer.ngrok-free.dev'),('v2qsicbk2qmbnre64jq1gk4891',NULL,'::1','WhatsApp/2',1780486475,1780486475,0,'','removed-gout-procurer.ngrok-free.dev'),('vh87vbr26ir3bj79iiivl2f4r7',NULL,'::1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36',1780490701,1780490701,0,'csrf|a:2:{s:9:\"timestamp\";i:1780490702;s:5:\"token\";s:32:\"8ef779c33c6b7fc217cb23f5fadb903c\";}','turn-federal-britain-auburn.trycloudflare.com');
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site`
--

DROP TABLE IF EXISTS `site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site` (
  `site_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `redirect` bigint NOT NULL DEFAULT '0' COMMENT 'If not 0, redirect to the specified journal/conference/... site.',
  `primary_locale` varchar(14) NOT NULL COMMENT 'Primary locale for the site.',
  `min_password_length` smallint NOT NULL DEFAULT '6',
  `installed_locales` varchar(1024) NOT NULL DEFAULT 'en' COMMENT 'Locales for which support has been installed.',
  `supported_locales` varchar(1024) DEFAULT NULL COMMENT 'Locales supported by the site (for hosted journals/conferences/...).',
  `original_style_file_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='A singleton table describing basic information about the site.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site`
--

LOCK TABLES `site` WRITE;
/*!40000 ALTER TABLE `site` DISABLE KEYS */;
INSERT INTO `site` VALUES (1,0,'en',6,'[\"en\",\"vi\"]','[\"en\",\"vi\"]',NULL);
/*!40000 ALTER TABLE `site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `site_settings`
--

DROP TABLE IF EXISTS `site_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `site_settings` (
  `site_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `setting_name` varchar(255) NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_value` mediumtext,
  PRIMARY KEY (`site_setting_id`),
  UNIQUE KEY `site_settings_unique` (`setting_name`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3 COMMENT='More data about the site, including localized properties such as its name.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `site_settings`
--

LOCK TABLES `site_settings` WRITE;
/*!40000 ALTER TABLE `site_settings` DISABLE KEYS */;
INSERT INTO `site_settings` VALUES (1,'contactEmail','en','nguyenb1407364@gmail.com'),(2,'contactName','en','Open Journal Systems'),(3,'contactName','vi','Há»‡ thá»‘ng táº¡p chÃ­ má»Ÿ'),(4,'compressStatsLogs','','0'),(5,'enableGeoUsageStats','','country+region+city'),(6,'enableInstitutionUsageStats','','1'),(7,'keepDailyUsageStats','','0'),(8,'isSiteSushiPlatform','','0'),(9,'isSushiApiPublic','','1'),(10,'disableSharedReviewerStatistics','','0'),(11,'themePluginPath','','default'),(12,'uniqueSiteId','','0D19454D-1F69-4C1D-8275-76085E93CE17');
/*!40000 ALTER TABLE `site_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stage_assignments`
--

DROP TABLE IF EXISTS `stage_assignments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stage_assignments` (
  `stage_assignment_id` bigint NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `user_group_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `date_assigned` datetime NOT NULL,
  `recommend_only` smallint NOT NULL DEFAULT '0',
  `can_change_metadata` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`stage_assignment_id`),
  UNIQUE KEY `stage_assignment` (`submission_id`,`user_group_id`,`user_id`),
  KEY `stage_assignments_user_group_id` (`user_group_id`),
  KEY `stage_assignments_user_id` (`user_id`),
  KEY `stage_assignments_submission_id` (`submission_id`),
  CONSTRAINT `stage_assignments_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  CONSTRAINT `stage_assignments_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `stage_assignments_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='Who can access a submission while it is in the editorial workflow. Includes all editorial and author assignments. For reviewers, see review_assignments.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stage_assignments`
--

LOCK TABLES `stage_assignments` WRITE;
/*!40000 ALTER TABLE `stage_assignments` DISABLE KEYS */;
/*!40000 ALTER TABLE `stage_assignments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_page_settings`
--

DROP TABLE IF EXISTS `static_page_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_page_settings` (
  `static_page_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `static_page_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` longtext,
  `setting_type` varchar(6) NOT NULL COMMENT '(bool|int|float|string|object)',
  PRIMARY KEY (`static_page_setting_id`),
  KEY `static_page_settings_static_page_id` (`static_page_id`),
  CONSTRAINT `static_page_settings_static_page_id` FOREIGN KEY (`static_page_id`) REFERENCES `static_pages` (`static_page_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_page_settings`
--

LOCK TABLES `static_page_settings` WRITE;
/*!40000 ALTER TABLE `static_page_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_page_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `static_pages`
--

DROP TABLE IF EXISTS `static_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_pages` (
  `static_page_id` bigint NOT NULL AUTO_INCREMENT,
  `path` varchar(255) NOT NULL,
  `context_id` bigint NOT NULL,
  PRIMARY KEY (`static_page_id`),
  KEY `static_pages_context_id` (`context_id`),
  CONSTRAINT `static_pages_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `static_pages`
--

LOCK TABLES `static_pages` WRITE;
/*!40000 ALTER TABLE `static_pages` DISABLE KEYS */;
/*!40000 ALTER TABLE `static_pages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subeditor_submission_group`
--

DROP TABLE IF EXISTS `subeditor_submission_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subeditor_submission_group` (
  `subeditor_submission_group_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `assoc_type` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `user_group_id` bigint NOT NULL,
  PRIMARY KEY (`subeditor_submission_group_id`),
  UNIQUE KEY `section_editors_unique` (`context_id`,`assoc_id`,`assoc_type`,`user_id`,`user_group_id`),
  KEY `subeditor_submission_group_context_id` (`context_id`),
  KEY `subeditor_submission_group_user_id` (`user_id`),
  KEY `subeditor_submission_group_user_group_id` (`user_group_id`),
  KEY `subeditor_submission_group_assoc_id` (`assoc_id`,`assoc_type`),
  CONSTRAINT `section_editors_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `subeditor_submission_group_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `subeditor_submission_group_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3 COMMENT='Subeditor assignments to e.g. sections and categories';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subeditor_submission_group`
--

LOCK TABLES `subeditor_submission_group` WRITE;
/*!40000 ALTER TABLE `subeditor_submission_group` DISABLE KEYS */;
INSERT INTO `subeditor_submission_group` VALUES (1,1,1,525,4,5),(2,1,4,525,2,3);
/*!40000 ALTER TABLE `subeditor_submission_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_comments`
--

DROP TABLE IF EXISTS `submission_comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_comments` (
  `comment_id` bigint NOT NULL AUTO_INCREMENT,
  `comment_type` bigint DEFAULT NULL,
  `role_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `assoc_id` bigint NOT NULL,
  `author_id` bigint NOT NULL,
  `comment_title` text NOT NULL,
  `comments` text,
  `date_posted` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `viewable` smallint DEFAULT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `submission_comments_submission_id` (`submission_id`),
  KEY `submission_comments_author_id` (`author_id`),
  CONSTRAINT `submission_comments_author_id_foreign` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_comments_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Comments on a submission, e.g. peer review comments';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_comments`
--

LOCK TABLES `submission_comments` WRITE;
/*!40000 ALTER TABLE `submission_comments` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_file_revisions`
--

DROP TABLE IF EXISTS `submission_file_revisions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_file_revisions` (
  `revision_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `submission_file_id` bigint unsigned NOT NULL,
  `file_id` bigint unsigned NOT NULL,
  PRIMARY KEY (`revision_id`),
  KEY `submission_file_revisions_submission_file_id` (`submission_file_id`),
  KEY `submission_file_revisions_file_id` (`file_id`),
  CONSTRAINT `submission_file_revisions_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_file_revisions_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Revisions map submission_file entries to files on the data store.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_file_revisions`
--

LOCK TABLES `submission_file_revisions` WRITE;
/*!40000 ALTER TABLE `submission_file_revisions` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_file_revisions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_file_settings`
--

DROP TABLE IF EXISTS `submission_file_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_file_settings` (
  `submission_file_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `submission_file_id` bigint unsigned NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`submission_file_setting_id`),
  UNIQUE KEY `submission_file_settings_unique` (`submission_file_id`,`locale`,`setting_name`),
  KEY `submission_file_settings_submission_file_id` (`submission_file_id`),
  CONSTRAINT `submission_file_settings_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Localized data about submission files like published metadata.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_file_settings`
--

LOCK TABLES `submission_file_settings` WRITE;
/*!40000 ALTER TABLE `submission_file_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_file_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_files`
--

DROP TABLE IF EXISTS `submission_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_files` (
  `submission_file_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `file_id` bigint unsigned NOT NULL,
  `source_submission_file_id` bigint unsigned DEFAULT NULL,
  `genre_id` bigint DEFAULT NULL,
  `file_stage` bigint NOT NULL,
  `direct_sales_price` varchar(255) DEFAULT NULL,
  `sales_type` varchar(255) DEFAULT NULL,
  `viewable` smallint DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `uploader_user_id` bigint DEFAULT NULL,
  `assoc_type` bigint DEFAULT NULL,
  `assoc_id` bigint DEFAULT NULL,
  PRIMARY KEY (`submission_file_id`),
  KEY `submission_files_submission_id` (`submission_id`),
  KEY `submission_files_file_id` (`file_id`),
  KEY `submission_files_genre_id` (`genre_id`),
  KEY `submission_files_uploader_user_id` (`uploader_user_id`),
  KEY `submission_files_stage_assoc` (`file_stage`,`assoc_type`,`assoc_id`),
  KEY `submission_files_source_submission_file_id` (`source_submission_file_id`),
  CONSTRAINT `submission_files_file_id_foreign` FOREIGN KEY (`file_id`) REFERENCES `files` (`file_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_files_genre_id_foreign` FOREIGN KEY (`genre_id`) REFERENCES `genres` (`genre_id`) ON DELETE SET NULL,
  CONSTRAINT `submission_files_source_submission_file_id_foreign` FOREIGN KEY (`source_submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_files_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_files_uploader_user_id_foreign` FOREIGN KEY (`uploader_user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='All files associated with a submission, such as those uploaded during submission, as revisions, or by copyeditors or layout editors for production.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_files`
--

LOCK TABLES `submission_files` WRITE;
/*!40000 ALTER TABLE `submission_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_search_keyword_list`
--

DROP TABLE IF EXISTS `submission_search_keyword_list`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_search_keyword_list` (
  `keyword_id` bigint NOT NULL AUTO_INCREMENT,
  `keyword_text` varchar(60) NOT NULL,
  PRIMARY KEY (`keyword_id`),
  UNIQUE KEY `submission_search_keyword_text` (`keyword_text`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of all keywords used in the search index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_search_keyword_list`
--

LOCK TABLES `submission_search_keyword_list` WRITE;
/*!40000 ALTER TABLE `submission_search_keyword_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_search_keyword_list` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_search_object_keywords`
--

DROP TABLE IF EXISTS `submission_search_object_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_search_object_keywords` (
  `submission_search_object_keyword_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `object_id` bigint NOT NULL,
  `keyword_id` bigint NOT NULL,
  `pos` int NOT NULL COMMENT 'Word position of the keyword in the object.',
  PRIMARY KEY (`submission_search_object_keyword_id`),
  UNIQUE KEY `submission_search_object_keywords_unique` (`object_id`,`pos`),
  KEY `submission_search_object_keywords_object_id` (`object_id`),
  KEY `submission_search_object_keywords_keyword_id` (`keyword_id`),
  CONSTRAINT `submission_search_object_keywords_keyword_id` FOREIGN KEY (`keyword_id`) REFERENCES `submission_search_keyword_list` (`keyword_id`) ON DELETE CASCADE,
  CONSTRAINT `submission_search_object_keywords_object_id_foreign` FOREIGN KEY (`object_id`) REFERENCES `submission_search_objects` (`object_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Relationships between search objects and keywords in the search index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_search_object_keywords`
--

LOCK TABLES `submission_search_object_keywords` WRITE;
/*!40000 ALTER TABLE `submission_search_object_keywords` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_search_object_keywords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_search_objects`
--

DROP TABLE IF EXISTS `submission_search_objects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_search_objects` (
  `object_id` bigint NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `type` int NOT NULL COMMENT 'Type of item. E.g., abstract, fulltext, etc.',
  `assoc_id` bigint DEFAULT NULL COMMENT 'Optional ID of an associated record (e.g., a file_id)',
  PRIMARY KEY (`object_id`),
  KEY `submission_search_objects_submission_id` (`submission_id`),
  CONSTRAINT `submission_search_object_submission` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of all search objects indexed in the search index';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_search_objects`
--

LOCK TABLES `submission_search_objects` WRITE;
/*!40000 ALTER TABLE `submission_search_objects` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_search_objects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submission_settings`
--

DROP TABLE IF EXISTS `submission_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submission_settings` (
  `submission_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `submission_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`submission_setting_id`),
  UNIQUE KEY `submission_settings_unique` (`submission_id`,`locale`,`setting_name`),
  KEY `submission_settings_submission_id` (`submission_id`),
  CONSTRAINT `submission_settings_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Localized data about submissions';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submission_settings`
--

LOCK TABLES `submission_settings` WRITE;
/*!40000 ALTER TABLE `submission_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `submission_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `submissions`
--

DROP TABLE IF EXISTS `submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `submissions` (
  `submission_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `current_publication_id` bigint DEFAULT NULL,
  `date_last_activity` datetime DEFAULT NULL,
  `date_submitted` datetime DEFAULT NULL,
  `last_modified` datetime DEFAULT NULL,
  `stage_id` bigint NOT NULL DEFAULT '1',
  `locale` varchar(14) DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1',
  `submission_progress` varchar(50) NOT NULL DEFAULT 'start',
  `work_type` smallint DEFAULT '0',
  PRIMARY KEY (`submission_id`),
  KEY `submissions_context_id` (`context_id`),
  KEY `submissions_publication_id` (`current_publication_id`),
  CONSTRAINT `submissions_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `submissions_publication_id` FOREIGN KEY (`current_publication_id`) REFERENCES `publications` (`publication_id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3 COMMENT='All submissions submitted to the context, including incomplete, declined and unpublished submissions.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `submissions`
--

LOCK TABLES `submissions` WRITE;
/*!40000 ALTER TABLE `submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_type_settings`
--

DROP TABLE IF EXISTS `subscription_type_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_type_settings` (
  `subscription_type_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `type_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  `setting_type` varchar(6) NOT NULL,
  PRIMARY KEY (`subscription_type_setting_id`),
  UNIQUE KEY `subscription_type_settings_unique` (`type_id`,`locale`,`setting_name`),
  KEY `subscription_type_settings_type_id` (`type_id`),
  CONSTRAINT `subscription_type_settings_type_id` FOREIGN KEY (`type_id`) REFERENCES `subscription_types` (`type_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='More data about subscription types, including localized properties such as names.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_type_settings`
--

LOCK TABLES `subscription_type_settings` WRITE;
/*!40000 ALTER TABLE `subscription_type_settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_type_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscription_types`
--

DROP TABLE IF EXISTS `subscription_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscription_types` (
  `type_id` bigint NOT NULL AUTO_INCREMENT,
  `journal_id` bigint NOT NULL,
  `cost` double(8,2) NOT NULL,
  `currency_code_alpha` varchar(3) NOT NULL,
  `duration` smallint DEFAULT NULL,
  `format` smallint NOT NULL,
  `institutional` smallint NOT NULL DEFAULT '0',
  `membership` smallint NOT NULL DEFAULT '0',
  `disable_public_display` smallint NOT NULL,
  `seq` double(8,2) NOT NULL,
  PRIMARY KEY (`type_id`),
  KEY `subscription_types_journal_id` (`journal_id`),
  CONSTRAINT `subscription_types_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Subscription types represent the kinds of subscriptions that a user or institution may have, such as an annual subscription or a discounted subscription.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscription_types`
--

LOCK TABLES `subscription_types` WRITE;
/*!40000 ALTER TABLE `subscription_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscription_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subscriptions`
--

DROP TABLE IF EXISTS `subscriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `subscriptions` (
  `subscription_id` bigint NOT NULL AUTO_INCREMENT,
  `journal_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `type_id` bigint NOT NULL,
  `date_start` date DEFAULT NULL,
  `date_end` datetime DEFAULT NULL,
  `status` smallint NOT NULL DEFAULT '1',
  `membership` varchar(40) DEFAULT NULL,
  `reference_number` varchar(40) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`subscription_id`),
  KEY `subscriptions_journal_id` (`journal_id`),
  KEY `subscriptions_user_id` (`user_id`),
  KEY `subscriptions_type_id` (`type_id`),
  CONSTRAINT `subscriptions_journal_id` FOREIGN KEY (`journal_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_type_id` FOREIGN KEY (`type_id`) REFERENCES `subscription_types` (`type_id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='A list of subscriptions, both institutional and individual, for journals that use subscription-based publishing.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subscriptions`
--

LOCK TABLES `subscriptions` WRITE;
/*!40000 ALTER TABLE `subscriptions` DISABLE KEYS */;
/*!40000 ALTER TABLE `subscriptions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `temporary_files`
--

DROP TABLE IF EXISTS `temporary_files`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `temporary_files` (
  `file_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `file_name` varchar(90) NOT NULL,
  `file_type` varchar(255) DEFAULT NULL,
  `file_size` bigint NOT NULL,
  `original_file_name` varchar(127) DEFAULT NULL,
  `date_uploaded` datetime NOT NULL,
  PRIMARY KEY (`file_id`),
  KEY `temporary_files_user_id` (`user_id`),
  CONSTRAINT `temporary_files_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Temporary files, e.g. where files are kept during an upload process before they are moved somewhere more appropriate.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `temporary_files`
--

LOCK TABLES `temporary_files` WRITE;
/*!40000 ALTER TABLE `temporary_files` DISABLE KEYS */;
/*!40000 ALTER TABLE `temporary_files` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_institution_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_institution_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usage_stats_institution_temporary_records` (
  `usage_stats_temp_institution_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `load_id` varchar(50) NOT NULL,
  `line_number` bigint NOT NULL,
  `institution_id` bigint NOT NULL,
  PRIMARY KEY (`usage_stats_temp_institution_id`),
  UNIQUE KEY `usitr_load_id_line_number_institution_id` (`load_id`,`line_number`,`institution_id`),
  KEY `usi_institution_id` (`institution_id`),
  CONSTRAINT `usi_institution_id_foreign` FOREIGN KEY (`institution_id`) REFERENCES `institutions` (`institution_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Temporary stats for views and downloads from institutions based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_institution_temporary_records`
--

LOCK TABLES `usage_stats_institution_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_institution_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_institution_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_total_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_total_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usage_stats_total_temporary_records` (
  `usage_stats_temp_total_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint NOT NULL,
  `canonical_url` varchar(255) NOT NULL,
  `issue_id` bigint DEFAULT NULL,
  `issue_galley_id` bigint DEFAULT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint DEFAULT NULL,
  `representation_id` bigint DEFAULT NULL,
  `submission_file_id` bigint unsigned DEFAULT NULL,
  `assoc_type` bigint NOT NULL,
  `file_type` smallint DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_total_id`),
  KEY `usage_stats_total_temporary_records_issue_id` (`issue_id`),
  KEY `usage_stats_total_temporary_records_issue_galley_id` (`issue_galley_id`),
  KEY `usage_stats_total_temporary_records_context_id` (`context_id`),
  KEY `usage_stats_total_temporary_records_submission_id` (`submission_id`),
  KEY `usage_stats_total_temporary_records_representation_id` (`representation_id`),
  KEY `usage_stats_total_temporary_records_submission_file_id` (`submission_file_id`),
  KEY `ust_load_id_context_id_ip_ua_url` (`load_id`,`context_id`,`ip`,`user_agent`,`canonical_url`),
  CONSTRAINT `ust_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_issue_galley_id_foreign` FOREIGN KEY (`issue_galley_id`) REFERENCES `issue_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_issue_id_foreign` FOREIGN KEY (`issue_id`) REFERENCES `issues` (`issue_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `ust_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Temporary stats totals based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_total_temporary_records`
--

LOCK TABLES `usage_stats_total_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_total_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_total_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_unique_item_investigations_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_unique_item_investigations_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usage_stats_unique_item_investigations_temporary_records` (
  `usage_stats_temp_unique_item_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint NOT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `representation_id` bigint DEFAULT NULL,
  `submission_file_id` bigint unsigned DEFAULT NULL,
  `assoc_type` bigint NOT NULL,
  `file_type` smallint DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_unique_item_id`),
  KEY `usii_context_id` (`context_id`),
  KEY `usii_submission_id` (`submission_id`),
  KEY `usii_representation_id` (`representation_id`),
  KEY `usii_submission_file_id` (`submission_file_id`),
  KEY `usii_load_id_context_id_ip_ua` (`load_id`,`context_id`,`ip`,`user_agent`),
  CONSTRAINT `usii_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `usii_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `usii_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `usii_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Temporary stats on unique downloads based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_unique_item_investigations_temporary_records`
--

LOCK TABLES `usage_stats_unique_item_investigations_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_unique_item_investigations_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_unique_item_investigations_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usage_stats_unique_item_requests_temporary_records`
--

DROP TABLE IF EXISTS `usage_stats_unique_item_requests_temporary_records`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usage_stats_unique_item_requests_temporary_records` (
  `usage_stats_temp_item_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` datetime NOT NULL,
  `ip` varchar(64) NOT NULL,
  `user_agent` varchar(255) NOT NULL,
  `line_number` bigint NOT NULL,
  `context_id` bigint NOT NULL,
  `submission_id` bigint NOT NULL,
  `representation_id` bigint DEFAULT NULL,
  `submission_file_id` bigint unsigned DEFAULT NULL,
  `assoc_type` bigint NOT NULL,
  `file_type` smallint DEFAULT NULL,
  `country` varchar(2) NOT NULL DEFAULT '',
  `region` varchar(3) NOT NULL DEFAULT '',
  `city` varchar(255) NOT NULL DEFAULT '',
  `load_id` varchar(50) NOT NULL,
  PRIMARY KEY (`usage_stats_temp_item_id`),
  KEY `usir_context_id` (`context_id`),
  KEY `usir_submission_id` (`submission_id`),
  KEY `usir_representation_id` (`representation_id`),
  KEY `usir_submission_file_id` (`submission_file_id`),
  KEY `usir_load_id_context_id_ip_ua` (`load_id`,`context_id`,`ip`,`user_agent`),
  CONSTRAINT `usir_context_id_foreign` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `usir_representation_id_foreign` FOREIGN KEY (`representation_id`) REFERENCES `publication_galleys` (`galley_id`) ON DELETE CASCADE,
  CONSTRAINT `usir_submission_file_id_foreign` FOREIGN KEY (`submission_file_id`) REFERENCES `submission_files` (`submission_file_id`) ON DELETE CASCADE,
  CONSTRAINT `usir_submission_id_foreign` FOREIGN KEY (`submission_id`) REFERENCES `submissions` (`submission_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Temporary stats on unique views based on visitor log records. Data in this table is provisional. See the metrics_* tables for compiled stats.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usage_stats_unique_item_requests_temporary_records`
--

LOCK TABLES `usage_stats_unique_item_requests_temporary_records` WRITE;
/*!40000 ALTER TABLE `usage_stats_unique_item_requests_temporary_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `usage_stats_unique_item_requests_temporary_records` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_settings`
--

DROP TABLE IF EXISTS `user_group_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group_settings` (
  `user_group_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_group_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`user_group_setting_id`),
  UNIQUE KEY `user_group_settings_unique` (`user_group_id`,`locale`,`setting_name`),
  KEY `user_group_settings_user_group_id` (`user_group_id`),
  CONSTRAINT `user_group_settings_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8mb3 COMMENT='More data about user groups, including localized properties such as the name.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_settings`
--

LOCK TABLES `user_group_settings` WRITE;
/*!40000 ALTER TABLE `user_group_settings` DISABLE KEYS */;
INSERT INTO `user_group_settings` VALUES (1,1,'en','name','Site Admin'),(2,1,'vi','name','Quáº£n trá»‹ trang web'),(3,2,'','nameLocaleKey','default.groups.name.manager'),(4,2,'','abbrevLocaleKey','default.groups.abbrev.manager'),(5,2,'en','abbrev','JM'),(6,2,'en','name','Journal manager'),(7,2,'vi','abbrev','JM'),(8,2,'vi','name','NgÆ°á»i quáº£n lÃ½ táº¡p chÃ­'),(9,3,'','nameLocaleKey','default.groups.name.editor'),(10,3,'','abbrevLocaleKey','default.groups.abbrev.editor'),(11,3,'en','abbrev','JE'),(12,3,'en','name','Journal editor'),(13,3,'vi','abbrev','JE'),(14,3,'vi','name','BiÃªn táº­p viÃªn chuyÃªn má»¥c'),(15,4,'','nameLocaleKey','default.groups.name.productionEditor'),(16,4,'','abbrevLocaleKey','default.groups.abbrev.productionEditor'),(17,4,'en','abbrev','ProdE'),(18,4,'en','name','Production editor'),(19,4,'vi','abbrev','Prod-E'),(20,4,'vi','name','BiÃªn táº­p viÃªn sáº£n xuáº¥t'),(21,5,'','nameLocaleKey','default.groups.name.sectionEditor'),(22,5,'','abbrevLocaleKey','default.groups.abbrev.sectionEditor'),(23,5,'en','abbrev','SecE'),(24,5,'en','name','Section editor'),(25,5,'vi','abbrev','Sec-E'),(26,5,'vi','name','BiÃªn táº­p viÃªn chuyÃªn má»¥c'),(27,6,'','nameLocaleKey','default.groups.name.guestEditor'),(28,6,'','abbrevLocaleKey','default.groups.abbrev.guestEditor'),(29,6,'en','abbrev','GE'),(30,6,'en','name','Guest editor'),(31,6,'vi','abbrev','GE'),(32,6,'vi','name','BiÃªn táº­p biÃªn khÃ¡ch má»i'),(33,7,'','nameLocaleKey','default.groups.name.copyeditor'),(34,7,'','abbrevLocaleKey','default.groups.abbrev.copyeditor'),(35,7,'en','abbrev','CE'),(36,7,'en','name','Copyeditor'),(37,7,'vi','abbrev','CE'),(38,7,'vi','name','BiÃªn táº­p viÃªn báº£n tháº£o'),(39,8,'','nameLocaleKey','default.groups.name.designer'),(40,8,'','abbrevLocaleKey','default.groups.abbrev.designer'),(41,8,'en','abbrev','Design'),(42,8,'en','name','Designer'),(43,8,'vi','abbrev','Thiáº¿t káº¿'),(44,8,'vi','name','NhÃ  thiáº¿t káº¿'),(45,9,'','nameLocaleKey','default.groups.name.funding'),(46,9,'','abbrevLocaleKey','default.groups.abbrev.funding'),(47,9,'en','abbrev','FC'),(48,9,'en','name','Funding coordinator'),(49,9,'vi','abbrev','FC'),(50,9,'vi','name','Äiá»u phá»‘i viÃªn tÃ i trá»£'),(51,10,'','nameLocaleKey','default.groups.name.indexer'),(52,10,'','abbrevLocaleKey','default.groups.abbrev.indexer'),(53,10,'en','abbrev','IND'),(54,10,'en','name','Indexer'),(55,10,'vi','abbrev','IND'),(56,10,'vi','name','NgÆ°á»i láº­p chá»‰ má»¥c'),(57,11,'','nameLocaleKey','default.groups.name.layoutEditor'),(58,11,'','abbrevLocaleKey','default.groups.abbrev.layoutEditor'),(59,11,'en','abbrev','LE'),(60,11,'en','name','Layout Editor'),(61,11,'vi','abbrev','LE'),(62,11,'vi','name','BiÃªn táº­p viÃªn TrÃ¬nh bÃ y'),(63,12,'','nameLocaleKey','default.groups.name.marketing'),(64,12,'','abbrevLocaleKey','default.groups.abbrev.marketing'),(65,12,'en','abbrev','MS'),(66,12,'en','name','Marketing and sales coordinator'),(67,12,'vi','abbrev','MS'),(68,12,'vi','name','Äiá»u phá»‘i viÃªn tiáº¿p thá»‹ vÃ  bÃ¡n hÃ ng'),(69,13,'','nameLocaleKey','default.groups.name.proofreader'),(70,13,'','abbrevLocaleKey','default.groups.abbrev.proofreader'),(71,13,'en','abbrev','PR'),(72,13,'en','name','Proofreader'),(73,13,'vi','abbrev','PR'),(74,13,'vi','name','NgÆ°á»i Ä‘á»c soÃ¡t lá»—i'),(75,14,'','nameLocaleKey','default.groups.name.author'),(76,14,'','abbrevLocaleKey','default.groups.abbrev.author'),(77,14,'en','abbrev','AU'),(78,14,'en','name','Author'),(79,14,'vi','abbrev','AU'),(80,14,'vi','name','TÃ¡c giáº£'),(81,15,'','nameLocaleKey','default.groups.name.translator'),(82,15,'','abbrevLocaleKey','default.groups.abbrev.translator'),(83,15,'en','abbrev','Trans'),(84,15,'en','name','Translator'),(85,15,'vi','abbrev','Trans'),(86,15,'vi','name','BiÃªn dá»‹ch viÃªn'),(87,16,'','nameLocaleKey','default.groups.name.externalReviewer'),(88,16,'','abbrevLocaleKey','default.groups.abbrev.externalReviewer'),(89,16,'en','abbrev','R'),(90,16,'en','name','Reviewer'),(91,16,'vi','abbrev','R'),(92,16,'vi','name','NgÆ°á»i pháº£n biá»‡n'),(93,17,'','nameLocaleKey','default.groups.name.reader'),(94,17,'','abbrevLocaleKey','default.groups.abbrev.reader'),(95,17,'en','abbrev','Read'),(96,17,'en','name','Reader'),(97,17,'vi','abbrev','Äá»c'),(98,17,'vi','name','Báº¡n Ä‘á»c'),(99,18,'','nameLocaleKey','default.groups.name.subscriptionManager'),(100,18,'','abbrevLocaleKey','default.groups.abbrev.subscriptionManager'),(101,18,'en','abbrev','SubM'),(102,18,'en','name','Subscription Manager'),(103,18,'vi','abbrev','Sub-M'),(104,18,'vi','name','NgÆ°á»i quáº£n lÃ½ thuÃª bao');
/*!40000 ALTER TABLE `user_group_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_group_stage`
--

DROP TABLE IF EXISTS `user_group_stage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_group_stage` (
  `user_group_stage_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `user_group_id` bigint NOT NULL,
  `stage_id` bigint NOT NULL,
  PRIMARY KEY (`user_group_stage_id`),
  UNIQUE KEY `user_group_stage_unique` (`context_id`,`user_group_id`,`stage_id`),
  KEY `user_group_stage_context_id` (`context_id`),
  KEY `user_group_stage_user_group_id` (`user_group_id`),
  KEY `user_group_stage_stage_id` (`stage_id`),
  CONSTRAINT `user_group_stage_context_id` FOREIGN KEY (`context_id`) REFERENCES `journals` (`journal_id`) ON DELETE CASCADE,
  CONSTRAINT `user_group_stage_user_group_id` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb3 COMMENT='Which stages of the editorial workflow the user_groups can access.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_group_stage`
--

LOCK TABLES `user_group_stage` WRITE;
/*!40000 ALTER TABLE `user_group_stage` DISABLE KEYS */;
INSERT INTO `user_group_stage` VALUES (1,1,3,1),(2,1,3,3),(3,1,3,4),(4,1,3,5),(5,1,4,4),(6,1,4,5),(7,1,5,1),(8,1,5,3),(9,1,5,4),(10,1,5,5),(11,1,6,1),(12,1,6,3),(13,1,6,4),(14,1,6,5),(15,1,7,4),(16,1,8,5),(17,1,9,1),(18,1,9,3),(19,1,10,5),(20,1,11,5),(21,1,12,4),(22,1,13,5),(23,1,14,1),(24,1,14,3),(25,1,14,4),(26,1,14,5),(27,1,15,1),(28,1,15,3),(29,1,15,4),(30,1,15,5),(31,1,16,3);
/*!40000 ALTER TABLE `user_group_stage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_groups`
--

DROP TABLE IF EXISTS `user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_groups` (
  `user_group_id` bigint NOT NULL AUTO_INCREMENT,
  `context_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  `is_default` smallint NOT NULL DEFAULT '0',
  `show_title` smallint NOT NULL DEFAULT '1',
  `permit_self_registration` smallint NOT NULL DEFAULT '0',
  `permit_metadata_edit` smallint NOT NULL DEFAULT '0',
  PRIMARY KEY (`user_group_id`),
  KEY `user_groups_user_group_id` (`user_group_id`),
  KEY `user_groups_context_id` (`context_id`),
  KEY `user_groups_role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 COMMENT='All defined user roles in a context, such as Author, Reviewer, Section Editor and Journal Manager.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_groups`
--

LOCK TABLES `user_groups` WRITE;
/*!40000 ALTER TABLE `user_groups` DISABLE KEYS */;
INSERT INTO `user_groups` VALUES (1,0,1,1,1,0,0),(2,1,16,1,1,0,1),(3,1,16,1,1,0,1),(4,1,16,1,1,0,1),(5,1,17,1,1,0,1),(6,1,17,1,1,0,0),(7,1,4097,1,1,0,0),(8,1,4097,1,1,0,0),(9,1,4097,1,1,0,0),(10,1,4097,1,1,0,0),(11,1,4097,1,1,0,0),(12,1,4097,1,1,0,0),(13,1,4097,1,1,0,0),(14,1,65536,1,1,1,0),(15,1,65536,1,1,0,0),(16,1,4096,1,1,1,0),(17,1,1048576,1,1,1,0),(18,1,2097152,1,1,0,0);
/*!40000 ALTER TABLE `user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_interests`
--

DROP TABLE IF EXISTS `user_interests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_interests` (
  `user_interest_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `controlled_vocab_entry_id` bigint NOT NULL,
  PRIMARY KEY (`user_interest_id`),
  UNIQUE KEY `u_e_pkey` (`user_id`,`controlled_vocab_entry_id`),
  KEY `user_interests_user_id` (`user_id`),
  KEY `user_interests_controlled_vocab_entry_id` (`controlled_vocab_entry_id`),
  CONSTRAINT `user_interests_controlled_vocab_entry_id_foreign` FOREIGN KEY (`controlled_vocab_entry_id`) REFERENCES `controlled_vocab_entries` (`controlled_vocab_entry_id`) ON DELETE CASCADE,
  CONSTRAINT `user_interests_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COMMENT='Associates users with user interests (which are stored in the controlled vocabulary tables).';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_interests`
--

LOCK TABLES `user_interests` WRITE;
/*!40000 ALTER TABLE `user_interests` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_interests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_settings`
--

DROP TABLE IF EXISTS `user_settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_settings` (
  `user_setting_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `locale` varchar(14) NOT NULL DEFAULT '',
  `setting_name` varchar(255) NOT NULL,
  `setting_value` mediumtext,
  PRIMARY KEY (`user_setting_id`),
  UNIQUE KEY `user_settings_unique` (`user_id`,`locale`,`setting_name`),
  KEY `user_settings_user_id` (`user_id`),
  KEY `user_settings_locale_setting_name_index` (`setting_name`,`locale`),
  CONSTRAINT `user_settings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb3 COMMENT='More data about users, including localized properties like their name and affiliation.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_settings`
--

LOCK TABLES `user_settings` WRITE;
/*!40000 ALTER TABLE `user_settings` DISABLE KEYS */;
INSERT INTO `user_settings` VALUES (1,1,'en','familyName','admin'),(2,1,'en','givenName','admin'),(3,2,'en','affiliation','FPT University, Can Tho Campus, Vietnam'),(4,2,'en','biography',''),(5,2,'en','familyName','Nguyen'),(6,2,'en','givenName','Hong Chi'),(7,2,'','orcid','https://orcid.org/0000-0001-8380-2727'),(8,2,'en','preferredPublicName','Dr. Chi Hong Nguyen'),(9,2,'en','signature',''),(10,3,'en','affiliation',''),(11,3,'en','biography',''),(12,3,'en','familyName','Tran'),(13,3,'en','givenName','Thanh Duy'),(14,3,'','orcid','https://orcid.org/0009-0004-7140-0156'),(15,3,'en','preferredPublicName','M.A. Thanh Duy Tran'),(16,3,'en','signature',''),(17,4,'en','affiliation','An Giang University, Vietnam National University Ho Chi Minh City, Vietnam'),(18,4,'en','biography',''),(19,4,'en','familyName','Tran'),(20,4,'en','givenName','Dat Van'),(21,4,'','orcid',''),(22,4,'en','preferredPublicName','Assoc. Prof. Dat Van Tran'),(23,4,'en','signature',''),(24,5,'en','affiliation',''),(25,5,'en','biography',''),(26,5,'en','familyName','Nguyen'),(27,5,'en','givenName','Nguyen Trong'),(28,5,'','orcid',''),(29,5,'en','preferredPublicName','M.A. Nguyen Trong Nguyen'),(30,5,'en','signature','');
/*!40000 ALTER TABLE `user_settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_user_groups`
--

DROP TABLE IF EXISTS `user_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_user_groups` (
  `user_user_group_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `user_group_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`user_user_group_id`),
  UNIQUE KEY `user_user_groups_unique` (`user_group_id`,`user_id`),
  KEY `user_user_groups_user_group_id` (`user_group_id`),
  KEY `user_user_groups_user_id` (`user_id`),
  CONSTRAINT `user_user_groups_user_group_id_foreign` FOREIGN KEY (`user_group_id`) REFERENCES `user_groups` (`user_group_id`) ON DELETE CASCADE,
  CONSTRAINT `user_user_groups_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3 COMMENT='Maps users to their assigned user_groups.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_user_groups`
--

LOCK TABLES `user_user_groups` WRITE;
/*!40000 ALTER TABLE `user_user_groups` DISABLE KEYS */;
INSERT INTO `user_user_groups` VALUES (1,1,1),(2,2,1),(3,2,2),(4,3,2),(6,5,4),(7,14,5),(10,16,3);
/*!40000 ALTER TABLE `user_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `url` varchar(2047) DEFAULT NULL,
  `phone` varchar(32) DEFAULT NULL,
  `mailing_address` varchar(255) DEFAULT NULL,
  `billing_address` varchar(255) DEFAULT NULL,
  `country` varchar(90) DEFAULT NULL,
  `locales` varchar(255) NOT NULL DEFAULT '[]',
  `gossip` text,
  `date_last_email` datetime DEFAULT NULL,
  `date_registered` datetime NOT NULL,
  `date_validated` datetime DEFAULT NULL,
  `date_last_login` datetime DEFAULT NULL,
  `must_change_password` smallint DEFAULT NULL,
  `auth_id` bigint DEFAULT NULL,
  `auth_str` varchar(255) DEFAULT NULL,
  `disabled` smallint NOT NULL DEFAULT '0',
  `disabled_reason` text,
  `inline_help` smallint DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `users_username` (`username`),
  UNIQUE KEY `users_email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 COMMENT='All registered users, including authentication data and profile data.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','$2y$10$gz.LNlZ0AypcChN0kr2jguuMKOLRCXJOFiblCVvQKO7aN61F/S82C','nguyenb1407364@gmail.com',NULL,NULL,NULL,NULL,NULL,'[]',NULL,NULL,'2026-06-03 08:08:38',NULL,'2026-06-03 20:12:38',NULL,NULL,NULL,0,NULL,1),(2,'chinh6','$2y$10$lN/qhLDK8ny6t69nHN3vMOf7ENCpYoLzzSEFdmbkgwcjZFoDZDV/6','chinh6@fe.edu.vn','','','',NULL,'VN','[]',NULL,NULL,'2026-06-03 15:34:05',NULL,NULL,1,NULL,NULL,0,NULL,1),(3,'duytt34','$2y$10$4M0w/nWDeSvSCEvuH1JFY.YL1iXTM4aFkgiFsOGCVrDlmftdiZeiq','duytt34@fe.edu.vn','','','',NULL,'VN','[\"en\",\"vi\"]','',NULL,'2026-06-03 15:37:05',NULL,NULL,0,NULL,NULL,0,NULL,1),(4,'tvdat','$2y$10$OAYCONtaQsrI7ujIenQ4Vexgap9AXzx056X9./LpVnd0IeWeiJvf6','tvdat@agu.edu.vn','','','',NULL,'VN','[\"vi\"]',NULL,NULL,'2026-06-03 15:41:47',NULL,NULL,1,NULL,NULL,0,NULL,1),(5,'nguyennt64','$2y$10$DThzU8W991CWTv3rOYrMn.S005ol2iCQtWw5AolltQ0YfXGLcZkMu','nguyennt64@fe.edu.vn','','','',NULL,'VN','[\"en\",\"vi\"]',NULL,NULL,'2026-06-03 16:04:19',NULL,'2026-06-03 19:55:33',0,NULL,NULL,0,NULL,1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `versions`
--

DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `versions` (
  `version_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `major` int NOT NULL DEFAULT '0' COMMENT 'Major component of version number, e.g. the 2 in OJS 2.3.8-0',
  `minor` int NOT NULL DEFAULT '0' COMMENT 'Minor component of version number, e.g. the 3 in OJS 2.3.8-0',
  `revision` int NOT NULL DEFAULT '0' COMMENT 'Revision component of version number, e.g. the 8 in OJS 2.3.8-0',
  `build` int NOT NULL DEFAULT '0' COMMENT 'Build component of version number, e.g. the 0 in OJS 2.3.8-0',
  `date_installed` datetime NOT NULL,
  `current` smallint NOT NULL DEFAULT '0' COMMENT '1 iff the version entry being described is currently active. This permits the table to store past installation history for forensic purposes.',
  `product_type` varchar(30) DEFAULT NULL COMMENT 'Describes the type of product this row describes, e.g. "plugins.generic" (for a generic plugin) or "core" for the application itself',
  `product` varchar(30) DEFAULT NULL COMMENT 'Uniquely identifies the product this version row describes, e.g. "ojs2" for OJS 2.x, "languageToggle" for the language toggle block plugin, etc.',
  `product_class_name` varchar(80) DEFAULT NULL COMMENT 'Specifies the class name associated with this product, for plugins, or the empty string where not applicable.',
  `lazy_load` smallint NOT NULL DEFAULT '0' COMMENT '1 iff the row describes a lazy-load plugin; 0 otherwise',
  `sitewide` smallint NOT NULL DEFAULT '0' COMMENT '1 iff the row describes a site-wide plugin; 0 otherwise',
  PRIMARY KEY (`version_id`),
  UNIQUE KEY `versions_unique` (`product_type`,`product`,`major`,`minor`,`revision`,`build`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb3 COMMENT='Describes the installation and upgrade version history for the application and all installed plugins.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `versions`
--

LOCK TABLES `versions` WRITE;
/*!40000 ALTER TABLE `versions` DISABLE KEYS */;
INSERT INTO `versions` VALUES (1,1,0,0,0,'2026-06-03 08:08:43',1,'plugins.metadata','dc11','',0,0),(2,1,0,1,0,'2026-06-03 08:08:43',1,'plugins.blocks','browse','BrowseBlockPlugin',1,0),(3,1,0,0,0,'2026-06-03 08:08:43',1,'plugins.blocks','developedBy','DevelopedByBlockPlugin',1,0),(4,1,0,0,0,'2026-06-03 08:08:43',1,'plugins.blocks','information','InformationBlockPlugin',1,0),(5,1,0,0,0,'2026-06-03 08:08:43',1,'plugins.blocks','languageToggle','LanguageToggleBlockPlugin',1,0),(6,1,0,0,0,'2026-06-03 08:08:43',1,'plugins.blocks','makeSubmission','MakeSubmissionBlockPlugin',1,0),(7,1,1,0,0,'2026-06-03 08:08:43',1,'plugins.blocks','subscription','SubscriptionBlockPlugin',1,0),(8,1,0,0,0,'2026-06-03 08:08:43',1,'plugins.gateways','resolver','',0,0),(9,1,3,0,0,'2026-06-03 08:08:43',1,'plugins.generic','acron','AcronPlugin',1,1),(10,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','announcementFeed','AnnouncementFeedPlugin',1,0),(11,0,1,0,0,'2026-06-03 08:08:44',1,'plugins.generic','citationStyleLanguage','CitationStyleLanguagePlugin',1,0),(12,3,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','crossref','',0,0),(13,1,2,0,0,'2026-06-03 08:08:44',1,'plugins.generic','customBlockManager','CustomBlockManagerPlugin',1,0),(14,2,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','datacite','',0,0),(15,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','driver','DRIVERPlugin',1,0),(16,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','dublinCoreMeta','DublinCoreMetaPlugin',1,0),(17,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','googleAnalytics','GoogleAnalyticsPlugin',1,0),(18,1,1,0,0,'2026-06-03 08:08:44',1,'plugins.generic','googleScholar','GoogleScholarPlugin',1,0),(19,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','htmlArticleGalley','HtmlArticleGalleyPlugin',1,0),(20,1,0,1,0,'2026-06-03 08:08:44',1,'plugins.generic','lensGalley','LensGalleyPlugin',1,0),(21,1,3,4,9,'2026-06-03 08:08:44',1,'plugins.generic','orcidProfile','OrcidProfilePlugin',1,0),(22,1,0,1,0,'2026-06-03 08:08:44',1,'plugins.generic','pdfJsViewer','PdfJsViewerPlugin',1,0),(23,1,0,0,1,'2026-06-03 08:08:44',1,'plugins.generic','recommendByAuthor','RecommendByAuthorPlugin',1,1),(24,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','recommendBySimilarity','RecommendBySimilarityPlugin',1,1),(25,1,2,0,0,'2026-06-03 08:08:44',1,'plugins.generic','staticPages','StaticPagesPlugin',1,0),(26,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','tinymce','TinyMCEPlugin',1,0),(27,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','usageEvent','',0,0),(28,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.generic','webFeed','WebFeedPlugin',1,0),(29,1,1,0,0,'2026-06-03 08:08:44',1,'plugins.importexport','doaj','',0,0),(30,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.importexport','native','',0,0),(31,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.importexport','pubmed','',0,0),(32,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.importexport','users','',0,0),(33,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.oaiMetadataFormats','dc','',0,0),(34,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.oaiMetadataFormats','marc','',0,0),(35,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.oaiMetadataFormats','marcxml','',0,0),(36,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.oaiMetadataFormats','rfc1807','',0,0),(37,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.paymethod','manual','',0,0),(38,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.paymethod','paypal','',0,0),(39,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.pubIds','urn','URNPubIdPlugin',1,0),(40,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.reports','articles','',0,0),(41,1,1,0,0,'2026-06-03 08:08:44',1,'plugins.reports','counterReport','',0,0),(42,2,0,1,0,'2026-06-03 08:08:44',1,'plugins.reports','reviewReport','',0,0),(43,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.reports','subscriptions','',0,0),(44,1,0,0,0,'2026-06-03 08:08:44',1,'plugins.themes','default','DefaultThemePlugin',1,0),(45,3,4,0,10,'2026-06-03 08:08:04',1,'core','ojs2','',0,1),(46,1,1,2,6,'2026-06-03 18:06:16',1,'plugins.themes','immersion','ImmersionThemePlugin',1,0);
/*!40000 ALTER TABLE `versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'ojs_local'
--

--
-- Dumping routines for database 'ojs_local'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!50606 SET GLOBAL INNODB_STATS_AUTO_RECALC=@OLD_INNODB_STATS_AUTO_RECALC */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-06-04  6:54:27
