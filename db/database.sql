-- Table structure for table `answers`
--

DROP TABLE IF EXISTS `answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `answers` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionID` int(11) NOT NULL,
  `Answer` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `GPT_Prompt` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `QuestionID` (`QuestionID`),
  CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `questions` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answers`
--

LOCK TABLES `answers` WRITE;
/*!40000 ALTER TABLE `answers` DISABLE KEYS */;
INSERT INTO `answers` VALUES (1,1,'Κοτόπουλο','Chicken'),(2,1,'Κόκκινο κρέας','Red Wine'),(3,1,'Ποικιλία τυριών','Cheese plate'),(4,2,'Φρουτώδης','Fruity'),(5,2,'Ξηρή','Dry'),(6,2,'Πολύ γλυκιά','Very sweet'),(7,3,'Σε γεύματα','At meals'),(8,3,'Σε κοινωνικές εκδηλώσεις','At social gatherings'),(9,3,'Στη χαλάρωση','During relaxation'),(10,4,'Κόκκινα','Red'),(11,4,'Λευκά','White'),(12,4,'Ροζέ','Rose'),(13,5,'Καλοκαιρικές Διακοπές','Summer vacation'),(14,5,'Κοινωνική Εκδήλωση','Social gatherings'),(15,5,'Ρομαντική Έξοδος','Romantic Event');
/*!40000 ALTER TABLE `answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Question` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `GPT_Prompt` varchar(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Question` (`Question`) USING HASH
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Ποιο από τα παρακάτω γεύματα προτιμάτε;','Prefers eating {{answer}} over {{otheranswers}}'),(2,'Ποια από τις παρακάτω γεύσεις προτιμάτε;','Prefers the flavour of {{answer}} over {{otheranswers}}'),(3,'Σε ποια από τις παρακάτω περιστάσεις απολαμβάνετε περισσότερο ένα ποτήρι κρασί;','Prefers to enjoy a glass of wine when {{answer}} over when {{otheranswers}}'),(4,'Προτιμάτε τα κόκκινα, τα λευκά, η τα ροζέ κρασιά;','Prefers {{answer}} wines over {{otheranswers}}'),(5,'Με τι απο τα παρακάτω συνδέετε το κρασί; ','Thinks wine is mostly connected with {{answer}} instead of {{otheranswers}}');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_choices`
--

DROP TABLE IF EXISTS `user_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_choices` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `QuestionID` int(11) NOT NULL,
  `AnswerID` int(11) NOT NULL,
  `UserID` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `QuestionID` (`QuestionID`,`UserID`),
  KEY `AnswerID` (`AnswerID`),
  KEY `UserID` (`UserID`),
  CONSTRAINT `user_choices_ibfk_1` FOREIGN KEY (`QuestionID`) REFERENCES `questions` (`ID`),
  CONSTRAINT `user_choices_ibfk_2` FOREIGN KEY (`AnswerID`) REFERENCES `answers` (`ID`),
  CONSTRAINT `user_choices_ibfk_3` FOREIGN KEY (`UserID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_choices`
--

LOCK TABLES `user_choices` WRITE;
/*!40000 ALTER TABLE `user_choices` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_wine_preferences`
--

DROP TABLE IF EXISTS `user_wine_preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_wine_preferences` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL,
  `WineID` int(11) NOT NULL,
  `Order` int(11) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `UserID` (`UserID`,`Order`),
  KEY `WineID` (`WineID`),
  CONSTRAINT `user_wine_preferences_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`ID`),
  CONSTRAINT `user_wine_preferences_ibfk_2` FOREIGN KEY (`WineID`) REFERENCES `wines` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_wine_preferences`
--

LOCK TABLES `user_wine_preferences` WRITE;
/*!40000 ALTER TABLE `user_wine_preferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_wine_preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(256) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `FirstName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `LastName` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Active` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT 'Y',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `Username` (`Username`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`Active` in ('Y','N'))
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (27,'tester','tester','tester','tester','Y'),(28,'test_parousiash','Test 2','Parousiash 2','12345','Y');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wines`
--

DROP TABLE IF EXISTS `wines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `wines` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `Description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ImagePath` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wines`
--

LOCK TABLES `wines` WRITE;
/*!40000 ALTER TABLE `wines` DISABLE KEYS */;
INSERT INTO `wines` VALUES (1,'Caymus 1998 Cabernet Sauvignon (Napa Valley)','Κρεμώδη αρώματα μαύρου κερασιού σε στρώσεις με φρέσκα λαχανάκια Βρυξελλών και πικάντικες γεύσεις ρόκας από κόκκινα δαμάσκηνα και φρυγανισμένη βελανιδιά.','/static/images/wines/1.jpg'),(2,'M. Chapoutier 1999 Le Méal Ermitage  (Hermitage)','Οι επιλογές του Chapoutier με τα καλύτερα αγροτεμάχια με αμπέλια στο Ερμιτάζ πρόκειται να γίνουν θρυλικές. Πωλούνται με την αρχαία ορθογραφία της ονομασίας (Ermitage), αντιπροσωπεύουν την επιτομή της δύναμης και της συγκέντρωσης που κρύβεται πίσω από τη φήμη της ονομασίας. Αυτό το cuvée είναι το καλύτερο της συλλογής, με τον αδιαφανή χαρακτήρα του, που υποδηλώνει αντί να αποκαλύπτει δύναμη σε αυτό το στάδιο. Μεγαλώστε το μέχρι το νεογέννητο μωρό σας να είναι αρκετά μεγάλο για να πιει και θα είναι σχεδόν έτοιμο.','/static/images/wines/2.jpeg'),(3,'J.L. Chave 1999  Hermitage','Ο Jean-Louis, ο γιος του Gérard Chave, είναι πλέον υπεύθυνος της οικογενειακής επιχείρησης, καθώς και πρόεδρος των οινοπαραγωγών Hermitage. Συνεχίζει την οικογενειακή παράδοση να κάνει δυνατές δηλώσεις του Syrah από το Hermitage, συνδυάζοντας τεράστια δομή και υπέρμετρα αρώματα. Αυτό το 1999 φαίνεται να έχει τα καλύτερα από τον παραδοσιακό κόσμο της ταννικής απεραντοσύνης και τον σύγχρονο κόσμο των όμορφων, ώριμων φρούτων. Ένα κρασί που θα παλαιώσει για πολύ καιρό.','/static/images/wines/3.jpg'),(4,'Colgin 1999 Herb Lamb Vineyard Cabernet Sauvignon (Napa Valley)','Τα αρώματα κλίνουν προς το μαύρο κεράσι, τη σοκολάτα και τα βότανα, τα οποία αναδύονται στον ουρανίσκο, σερβίροντας πιο πυκνά φρούτα, γλυκόριζα, καφέ και όμορφες γεύσεις τοστ. Οι τανίνες είναι λείες, εύκαμπτες και ώριμες. Μακρύ, πλούσιο και παρακμιακό στο τελείωμα.','/static/images/wines/4.jpeg'),(5,'Stag\'s Leap Wine Cellars 1998 SLV Cabernet Sauvignon (Napa Valley)','Σίγουρα μια από τις επιτυχίες του vintage. Συσκευασμένο με κασσία, φασκόμηλο, δαμάσκηνο, καπνό, χώμα και καπνιστή βελανιδιά, και τέλεια στεγνό και ισορροπημένο. Σκέτη χαρά στο στόμα, σαν υγρό βελούδο. Αλλάζει κάθε δευτερόλεπτο, προσφέροντας σειρές γεύσεων μέσα από το πικάντικο φινίρισμα.','/static/images/wines/5.png'),(6,'Dalla Valle 1999 Maya Red (Napa Valley)','Λούτρινο, απαλό και σφιχτό με πολύπλοκες γεύσεις. Το βατόμουρο, ο γλυκάνισος, το μαύρο κεράσι, η πίσσα, ο άνθρακας, τα μπαχαρικά, η γη και τα βότανα παραμένουν σφιχτά τυλιγμένα, περιμένοντας υπομονετικά να αποκαλύψουν την πλήρη γοητεία τους στον χρόνο. Οι ελαστικές, απαλές τανίνες και η όμορφη ισορροπία δίνουν σε αυτό το κρασί κλασική κομψότητα.','/static/images/wines/6.jpg'),(7,'E. Guigal 1998 La Mouline  (Côte Rôtie)','Παρόλο που οι 42 μήνες που πέρασε αυτό το κρασί σε νέο ξύλο του δίνουν έναν έντονα φρυγανισμένο χαρακτήρα, τα εξαιρετικά μαλακά, αρωματικά φρούτα και οι ώριμες, γλυκές γεύσεις που συνδυάζονται με το ξύλο παράγουν ένα καλά συντονισμένο, ισορροπημένο κρασί που πρέπει να παλαιώσει για πολλά χρόνια. . Ως έκφραση του καθαρού Syrah, υπάρχουν λίγα καλύτερα.','/static/images/wines/7.png'),(8,'Quilceda Creek 1998 Cabernet Sauvignon (Washington)','Αφού «τσάκωσε», όπως λέει, με μείγματα στις καμπίνες του \'96 και του \'97, ο οινοποιός Alex Golitzin αποφάσισε να πάει με το straight Cabernet το \'98, ένα εξαιρετικό vintage για την Πολιτεία της Ουάσιγκτον. Αυτή είναι μια σφιχτή, εστιασμένη προσπάθεια, με ισχυρά μαύρα φρούτα ενισχυμένα με βότανα και μπαχαρικά και έναν υπαινιγμό ορυκτών. Νέο, ξινό και τανικό, θα συνεχίσει να βελτιώνεται καθώς πλέκει μαζί με τα χρόνια. Η επιλογή των συντακτών.','/static/images/wines/8.png'),(9,'E. Guigal 1998 La Turque  (Côte Rôtie)','Ένα σταθερό, ξηρό, τετράγωνο κρασί που έχει δύναμη και δομή και όχι τα άμεσα αρώματα του La Mouline, του συνεργάτη cuvée από το Guigal. Αυτό είναι το κρασί για όσους θέλουν δύναμη με μεγάλες τανίνες, και δεν είναι πιο δυνατό ή τανικό από αυτό. Η δυνατότητα παλαίωσής του είναι τεράστια: μετά από 10 χρόνια θα πρέπει να υπάρχουν περισσότερα σημάδια από το αρωματικό φρούτο που βρίσκεται εκεί, κάπου.','/static/images/wines/9.png'),(10,'Domaine Jean-Michel Gerin 1999 La Landonne  (Côte Rôtie)','Εδώ είναι ένα εξαιρετικά πλούσιο και απαλό κρασί. Αρώματα βιολέτας και γεύσεις από βατόμουρα και κόκκινα κεράσια μαζί με σκονισμένες τανίνες, δίνουν σε αυτό το κρασί τόσο άμεση γοητεία όσο και υπόσχεση για ένα καλό μακροπρόθεσμο μέλλον.','/static/images/wines/10.jpg'),(11,'Éric & Jöel Durand 1999 Empreintes  (Cornas)','Ένα τεράστιο, μαύρο κρασί με όλο το μεγαλείο που δίνει στο Cornas τη φήμη του. Μια υπερπαραγωγή με τεράστιες πλούσιες, γλυκές τανίνες. Στο τέλος κυριαρχεί η ποιότητα των υπερώριμων φρούτων από παλιά αμπέλια, αλλά σίγουρα είναι ένα κρασί που πρέπει να διατηρηθεί για γενιές.','/static/images/wines/11.jpg'),(12,'E. Guigal 1999  Hermitage','Ένα τεράστιο κρασί, με το αδιαφανές, πυκνό μωβ χρώμα του, τις τεράστιες τανίνες και τη σφιχτή, ισχυρή δομή του. Όταν αναπτυχθεί —ίσως σε 10 ή 15 χρόνια— τα αρωματικά, ζουμερά φρούτα Syrah που μόλις προτείνονται προς το παρόν θα είναι τόσο κυρίαρχα όσο οι τανίνες τώρα. Τι κρασί θα είναι τότε.','/static/images/wines/12.jpeg'),(13,'Stag\'s Leap Wine Cellars 1998 Cask 23 Red (Napa Valley)','Τι μεγάλη επιτυχία. Στάζει με μαρμελάδα φραγκοστάφυλου και κασσί και λίγο μαύρο πιπέρι. Η επιδεικτική βελανιδιά προσθέτει ένα άρωμα βανίλιας και καπνού. Σαρκώδες, μακρύ και γεμάτο, αυτό το όμορφο κρασί δεν είναι τέρας, αλλά ντύνει τον ουρανίσκο με πικάντικες γεύσεις που συνοψίζουν την τάξη και το στυλ.','/static/images/wines/13.jpg'),(14,'Switchback Ridge 1999 Cabernet Sauvignon (Napa Valley)','Ένα υπέροχα ισορροπημένο κρασί, πλαισιωμένο από βελούδινες, ώριμες, βελούδινες τανίνες και με πλούσια γεύση μαύρου κεράσι, δαμάσκηνου, βατόμουρου, μπαχαρικών, βοτάνων και σοκολάτας. Εξαιρετικά περίπλοκο, χωρίς ραφές στην κομψότητά του, το κρασί είναι γεμάτο με γοητεία και προσωπικότητα. μακρύς στο τέρμα.','/static/images/wines/14.jpeg'),(15,'Dalla Valle 1999 Cabernet Sauvignon (Napa Valley)','Ώριμο, πλούσιο και κομψό, αυτό το κρασί είναι γεμάτο με νότες μαύρου δαμάσκηνου, φράουλας, κασσίας, σοκολάτας, μπαχαρικών και βοτάνων. Έχει λεία υφή και ενσωματώνεται απρόσκοπτα, ακόμη και σε αυτό το αρχικό στάδιο. Σκληρές, βελούδινες τανίνες και η σωστή ποσότητα φρυγανιάς βελανιδιάς πλαισιώνουν το σύνολο.','/static/images/wines/15.jpg'),(16,'Paul Jaboulet Aîné 1999 Chevalier de Sterimberg White (Hermitage)','Το λευκό Ερμιτάζ του Jaboulet πήρε το όνομά του από τον σταυροφόρο ιππότη που έχτισε και εγκαταστάθηκε στο μικρό παρεκκλήσι στον λόφο Ερμιτάζ. Το ίδιο το κρασί είναι δυνατό, πλούσιο και συμπυκνωμένο, με μεθυστικά αρώματα από αγριολούλουδα και ξηρούς καρπούς. Ο ουρανίσκος συνδυάζει μια νότα ξύλου, μια γεμάτη, λιπαρή υφή και μια εκπληκτική έκρηξη οξύτητας που αφήνει μια τραγανή επίγευση.','/static/images/wines/16.jpeg');
/*!40000 ALTER TABLE `wines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'quizvine_db'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-01-15 23:19:42
