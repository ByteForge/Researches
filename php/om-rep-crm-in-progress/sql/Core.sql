SET FOREIGN_KEY_CHECKS = 0;
SET STORAGE_ENGINE = InnoDB;

/*  Create/re-create tables
    ============================================================================
*/

/* User table */
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userID`    INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `active`	  BIT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',
  `uid`		  VARCHAR(32) NOT NULL COMMENT 'auth. uid',
  `hash`	  VARCHAR(128) NOT NULL COMMENT 'pass. hash',
  `salt`	  VARCHAR(128) NOT NULL COMMENT 'pass. salt',
  `firstName` VARCHAR(64) NOT NULL,
  `lastName`  VARCHAR(64) NOT NULL,
  `avatar`	  VARCHAR(64) DEFAULT NULL,
  `datetime`  DATETIME DEFAULT CURRENT_TIMESTAMP, /* registration datetime */

  `roleID`    INT UNSIGNED NOT NULL,

  PRIMARY KEY (`userID`)
)
	AUTO_INCREMENT = 1
	DEFAULT	CHARSET = UTF8;

/* Role table */
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleID`      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(64) NOT NULL,
  `description` VARCHAR(255) NOT NULL,

  PRIMARY KEY (`roleID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Privilege table */
DROP TABLE IF EXISTS `privilege`;
CREATE TABLE `privilege` (
  `privilegeID` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(64) NOT NULL,
  `description` VARCHAR(255) NOT NULL,

  PRIMARY KEY (`privilegeID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Address table */
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `primary`     BIT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',
  `line1`       VARCHAR(128) NOT NULL,
  `line2`       VARCHAR(128) NOT NULL,
  `city`        VARCHAR(64) NOT NULL,
  `zip`         VARCHAR(16) NOT NULL,

  `countryID`   INT UNSIGNED NOT NULL,
  `userID`      INT UNSIGNED NOT NULL,

  PRIMARY KEY (`addressID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Contact table */
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contactID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `primary`     BIT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',
  `type`        TINYINT(2) NOT NULL,
  `value`       VARCHAR(255) NOT NULL,

  /*  either addressID or userID must be NULL at the same time,
      i.e.:
        a "basic contact" cannot belong to a "regular address"
        a "regular address" cannot have a "basic contact" */
  `addressID`   INT UNSIGNED DEFAULT NULL,
                /*  contacts can exist without addressID ("basic contact"),
                    i.e.: just a phone number without address */

  `userID`      INT UNSIGNED DEFAULT NULL,
                /*  contacts can exist without userID ("regular address"),
                    i.e.: an address with a contact (a phone number)
                    one-to-many relationship, 1 user - many contacts */

  PRIMARY KEY (`contactID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Language table */
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `languageID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code`  CHAR(2) NOT NULL,
  `name`  VARCHAR(64) NOT NULL,

  PRIMARY KEY (`languageID`)
)
	AUTO_INCREMENT = 1
	DEFAULT CHARSET = UTF8;

/* Country table */
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `countryID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code`  CHAR(2) NOT NULL,
  `name`  VARCHAR(64) NOT NULL,

  PRIMARY KEY (`countryID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Message table */
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `messageID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject`     VARCHAR(255) NOT NULL,
  `message`     TEXT NOT NULL,
  `datetime`    DATETIME DEFAULT CURRENT_TIMESTAMP,

  `userID`      INT UNSIGNED NOT NULL COMMENT 'userID as sender',

  PRIMARY KEY (`messageID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Organisation table */
DROP TABLE IF EXISTS `organisation`;
CREATE TABLE `organisation` (
  `orgID`       INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `datetime`    DATETIME DEFAULT CURRENT_TIMESTAMP, /* when the organisation was registered */

  PRIMARY KEY (`orgID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Supplier table */
DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `supplierID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `datetime`    DATETIME DEFAULT CURRENT_TIMESTAMP, /* when the supplier was registered */

  PRIMARY KEY (`supplierID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Order table */
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderID`     INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `datetime`    DATETIME DEFAULT CURRENT_TIMESTAMP, /* when the order was registered */

  `userID`      INT UNSIGNED NOT NULL,

  PRIMARY KEY (`orderID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Item table */
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `itemID`      INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(64) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `stock`       INT UNSIGNED NOT NULL,
  `price`       INT UNSIGNED NOT NULL,

  PRIMARY KEY (`itemID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/*  "CRM" Specific tables - below
    >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*/

/* Campaign table */
DROP TABLE IF EXISTS `campaign`;
CREATE TABLE `campaign` (
  `campaignID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`        VARCHAR(64) NOT NULL,
  `description` VARCHAR(255) NOT NULL,

  PRIMARY KEY (`campaignID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Newsletter table for "newsletter subscriptions" */
DROP TABLE IF EXISTS `newsletter`;
CREATE TABLE `newsletter` (
  `newsletterID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name`          VARCHAR(64) NOT NULL,

  `userID`      INT UNSIGNED NOT NULL,

  PRIMARY KEY (`newsletterID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Complaint table */
DROP TABLE IF EXISTS `complaint`;
CREATE TABLE `complaint` (
  `complaintID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description`   VARCHAR(255) NOT NULL,

  PRIMARY KEY (`complaintID`)
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/*  "CRM" Specific tables - above
    <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
*/

/*  Add foreign keys and create/re-create relationship tables
    ============================================================================
*/
SET FOREIGN_KEY_CHECKS = 1;

/* User table, one-to-one relationship, 1 user - 1 role */
ALTER TABLE `user`
  ADD CONSTRAINT `user_fk_role` FOREIGN KEY (`roleID`) REFERENCES `role`(`roleID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Session table, one-to-one relationship, one user - one session */
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `userID`   INT UNSIGNED NOT NULL,
  `hash`     VARCHAR(255) NOT NULL,

  PRIMARY KEY (`userID`),
  CONSTRAINT `session_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  AUTO_INCREMENT = 1
  DEFAULT CHARSET = UTF8;

/* Role_Privilege table, many-to-many relationship between `role` and `privilege` */
DROP TABLE IF EXISTS `role_privilege`;
CREATE TABLE `role_privilege` (
  `roleID`      INT UNSIGNED NOT NULL,
  `privilegeID` INT UNSIGNED NOT NULL,

  PRIMARY KEY (`roleID`,`privilegeID`),
  CONSTRAINT `ropi_fk_role` FOREIGN KEY (`roleID`) REFERENCES `role`(`roleID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `ropi_fk_privilege` FOREIGN KEY (`privilegeID`) REFERENCES `privilege`(`privilegeID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

/* Address table,
  one-to-one relationship, 1 address - 1 country
  one-to-many relationships, 1 user - many addresses */
ALTER TABLE `address`
  ADD CONSTRAINT `address_fk_country` FOREIGN KEY (`countryID`) REFERENCES `country`(`countryID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  ADD CONSTRAINT `address_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Contact table, many-to-one relationship, many contacts - 1 address */
ALTER TABLE `contact`
  ADD CONSTRAINT `contact_fk_address` FOREIGN KEY (`addressID`) REFERENCES `address`(`addressID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  ADD CONSTRAINT `contact_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* User_Language, many-to-many relationships, many users - many languages */
DROP TABLE IF EXISTS `user_language`;
CREATE TABLE `user_language` (
  `userID`      INT UNSIGNED NOT NULL,
  `languageID`  INT UNSIGNED NOT NULL,
  `primary`     BIT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

  PRIMARY KEY (`userID`,`languageID`),
  CONSTRAINT `usla_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `usla_fk_lang` FOREIGN KEY (`languageID`) REFERENCES `language`(`languageID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

/* Recipient table, one-to-many relationship, 1 message - many users(recipients) */
DROP TABLE IF EXISTS `recipient`;
CREATE TABLE `recipient` (
  `messageID` INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `userID`    INT UNSIGNED NOT NULL,

  PRIMARY KEY (`messageID`,`userID`),
  CONSTRAINT `reci_fk_message` FOREIGN KEY (`messageID`) REFERENCES `message`(`messageID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `reci_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

/* Message table, one-to-one sender relationship, 1 message - 1 user */
ALTER TABLE `message`
ADD CONSTRAINT `mess_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

/* Order table, one-to-one relationship, 1 order - 1 user */
ALTER TABLE `order`
ADD CONSTRAINT `order_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
  ON UPDATE CASCADE
  ON DELETE CASCADE;

/* Order_Item table, many-to-many relationship, many order - many items */
DROP TABLE IF EXISTS `order_item`;
CREATE TABLE `order_item` (
  `orderID`     INT UNSIGNED NOT NULL,
  `itemID`      INT UNSIGNED NOT NULL,

  PRIMARY KEY (`orderID`,`itemID`),
  CONSTRAINT `orit_fk_order` FOREIGN KEY (`orderID`) REFERENCES `order`(`orderID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `orit_fk_item` FOREIGN KEY (`itemID`) REFERENCES `item`(`itemID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

/*  Insert data
    ============================================================================
*/
INSERT INTO `language` (`code`, `name`) VALUES
  ('AB', 'Abkhazian'),
  ('AA', 'Afar'),
  ('AF', 'Afrikaans'),
  ('SQ', 'Albanian'),
  ('AM', 'Amharic'),
  ('AR', 'Arabic'),
  ('AN', 'Aragonese'),
  ('HY', 'Armenian'),
  ('AS', 'Assamese'),
  ('AY', 'Aymara'),
  ('AZ', 'Azerbaijani'),
  ('BA', 'Bashkir'),
  ('EU', 'Basque'),
  ('BN', 'Bengali'),
  ('DZ', 'Bhutani'),
  ('BH', 'Bihari'),
  ('BI', 'Bislama'),
  ('BR', 'Breton'),
  ('BG', 'Bulgarian'),
  ('MY', 'Burmese'),
  ('BE', 'Byelorussian'),
  ('KM', 'Cambodian'),
  ('CA', 'Catalan'),
  ('ZH', 'Chinese'),
  ('CO', 'Corsican'),
  ('HR', 'Croatian'),
  ('CS', 'Czech'),
  ('DA', 'Danish'),
  ('NL', 'Dutch'),
  ('EN', 'English'),
  ('EO', 'Esperanto'),
  ('ET', 'Estonian'),
  ('FO', 'Faeroese'),
  ('FA', 'Farsi'),
  ('FJ', 'Fiji'),
  ('FI', 'Finnish'),
  ('FR', 'French'),
  ('FY', 'Frisian'),
  ('GL', 'Galician'),
  ('GD', 'Gaelic'),
  ('KA', 'Georgian'),
  ('DE', 'German'),
  ('EL', 'Greek'),
  ('KL', 'Greenlandic'),
  ('GN', 'Guarani'),
  ('GU', 'Gujarati'),
  ('HT', 'Haitian Creole'),
  ('HA', 'Hausa'),
  ('HE', 'Hebrew'),
  ('HI', 'Hindi'),
  ('HU', 'Hungarian'),
  ('IS', 'Icelandic'),
  ('IO', 'Ido'),
  ('ID', 'Indonesian'),
  ('IA', 'Interlingua'),
  ('IE', 'Interlingue'),
  ('IU', 'Inuktitut'),
  ('IK', 'Inupiak'),
  ('GA', 'Irish'),
  ('IT', 'Italian'),
  ('JA', 'Japanese'),
  ('JV', 'Javanese'),
  ('KN', 'Kannada'),
  ('KS', 'Kashmiri'),
  ('KK', 'Kazakh'),
  ('RW', 'Kinyarwanda'),
  ('KY', 'Kirghiz'),
  ('RN', 'Kirundi'),
  ('KO', 'Korean'),
  ('KU', 'Kurdish'),
  ('LO', 'Laothian'),
  ('LA', 'Latin'),
  ('LV', 'Latvian'),
  ('LI', 'Limburgish'),
  ('LN', 'Lingala'),
  ('LT', 'Lithuanian'),
  ('MK', 'Macedonian'),
  ('MG', 'Malagasy'),
  ('MS', 'Malay'),
  ('ML', 'Malayalam'),
  ('MT', 'Maltese'),
  ('MI', 'Maori'),
  ('MR', 'Marathi'),
  ('MO', 'Moldavian'),
  ('MN', 'Mongolian'),
  ('NA', 'Nauru'),
  ('NE', 'Nepali'),
  ('NO', 'Norwegian'),
  ('OC', 'Occitan'),
  ('OR', 'Oriya'),
  ('OM', 'Oromo'),
  ('PS', 'Pashto'),
  ('PL', 'Polish'),
  ('PT', 'Portuguese'),
  ('PA', 'Punjabi'),
  ('QU', 'Quechua'),
  ('RM', 'Rhaeto-Romance'),
  ('RO', 'Romanian'),
  ('RU', 'Russian'),
  ('SM', 'Samoan'),
  ('SG', 'Sangro'),
  ('SA', 'Sanskrit'),
  ('SR', 'Serbian'),
  ('SH', 'Serbo-Croatian'),
  ('ST', 'Sesotho'),
  ('TN', 'Setswana'),
  ('SN', 'Shona'),
  ('II', 'Sichuan Yi'),
  ('SD', 'Sindhi'),
  ('SI', 'Sinhalese'),
  ('SS', 'Siswati'),
  ('SK', 'Slovak'),
  ('SL', 'Slovenian'),
  ('SO', 'Somali'),
  ('ES', 'Spanish'),
  ('SU', 'Sundanese'),
  ('SW', 'Swahili'),
  ('SV', 'Swedish'),
  ('TL', 'Tagalog'),
  ('TG', 'Tajik'),
  ('TA', 'Tamil'),
  ('TT', 'Tatar'),
  ('TE', 'Telugu'),
  ('TH', 'Thai'),
  ('BO', 'Tibetan'),
  ('TI', 'Tigrinya'),
  ('TO', 'Tonga'),
  ('TS', 'Tsonga'),
  ('TR', 'Turkish'),
  ('TK', 'Turkmen'),
  ('TW', 'Twi'),
  ('UG', 'Uighur'),
  ('UK', 'Ukrainian'),
  ('UR', 'Urdu'),
  ('UZ', 'Uzbek'),
  ('VI', 'Vietnamese'),
  ('VO', 'Volapok'),
  ('WA', 'Wallon'),
  ('CY', 'Welsh'),
  ('WO', 'Wolof'),
  ('XH', 'Xhosa'),
  ('YI', 'Yiddish'),
  ('YO', 'Yoruba'),
  ('ZU', 'Zulu');

INSERT INTO `country` (`code`, `name`) VALUES
  ('AD', 'Andorra'),
  ('AE', 'United Arab Emirates'),
  ('AF', 'Afghanistan'),
  ('AG', 'Antigua and Barbuda'),
  ('AI', 'Anguilla'),
  ('AL', 'Albania'),
  ('AM', 'Armenia'),
  ('AO', 'Angola'),
  ('AQ', 'Antarctica'),
  ('AR', 'Argentina'),
  ('AS', 'American Samoa'),
  ('AT', 'Austria'),
  ('AU', 'Australia'),
  ('AW', 'Aruba'),
  ('AX', 'Aland Islands'),
  ('AZ', 'Azerbaijan'),
  ('BA', 'Bosnia and Herzegovina'),
  ('BB', 'Barbados'),
  ('BD', 'Bangladesh'),
  ('BE', 'Belgium'),
  ('BF', 'Burkina Faso'),
  ('BG', 'Bulgaria'),
  ('BH', 'Bahrain'),
  ('BI', 'Burundi'),
  ('BJ', 'Benin'),
  ('BL', 'Saint Barthélemy'),
  ('BM', 'Bermuda'),
  ('BN', 'Brunei Darussalam'),
  ('BO', 'Bolivia, Plurinational State of'),
  ('BQ', 'Bonaire, Sint Eustatius and Saba'),
  ('BR', 'Brazil'),
  ('BS', 'Bahamas'),
  ('BT', 'Bhutan'),
  ('BV', 'Bouvet Island'),
  ('BW', 'Botswana'),
  ('BY', 'Belarus'),
  ('BZ', 'Belize'),
  ('CA', 'Canada'),
  ('CC', 'Cocos (Keeling) Islands'),
  ('CD', 'Congo, the Democratic Republic of the'),
  ('CF', 'Central African Republic'),
  ('CG', 'Congo'),
  ('CH', 'Switzerland'),
  ('CI', 'Côte d\'Ivoire'),
  ('CK', 'Cook Islands'),
  ('CL', 'Chile'),
  ('CM', 'Cameroon'),
  ('CN', 'China'),
  ('CO', 'Colombia'),
  ('CR', 'Costa Rica'),
  ('CU', 'Cuba'),
  ('CV', 'Cabo Verde'),
  ('CW', 'Curaçao'),
  ('CX', 'Christmas Island'),
  ('CY', 'Cyprus'),
  ('CZ', 'Czech Republic'),
  ('DE', 'Germany'),
  ('DJ', 'Djibouti'),
  ('DK', 'Denmark'),
  ('DM', 'Dominica'),
  ('DO', 'Dominican Republic'),
  ('DZ', 'Algeria'),
  ('EC', 'Ecuador'),
  ('EE', 'Estonia'),
  ('EG', 'Egypt'),
  ('EH', 'Western Sahara'),
  ('ER', 'Eritrea'),
  ('ES', 'Spain'),
  ('ET', 'Ethiopia'),
  ('FI', 'Finland'),
  ('FJ', 'Fiji'),
  ('FK', 'Falkland Islands (Malvinas)'),
  ('FM', 'Micronesia, Federated States of'),
  ('FO', 'Faroe Islands'),
  ('FR', 'France'),
  ('GA', 'Gabon'),
  ('GB', 'United Kingdom'),
  ('GD', 'Grenada'),
  ('GE', 'Georgia'),
  ('GF', 'French Guiana'),
  ('GG', 'Guernsey'),
  ('GH', 'Ghana'),
  ('GI', 'Gibraltar'),
  ('GL', 'Greenland'),
  ('GM', 'Gambia'),
  ('GN', 'Guinea'),
  ('GP', 'Guadeloupe'),
  ('GQ', 'Equatorial Guinea'),
  ('GR', 'Greece'),
  ('GS', 'South Georgia and the South Sandwich Islands'),
  ('GT', 'Guatemala'),
  ('GU', 'Guam'),
  ('GW', 'Guinea-Bissau'),
  ('GY', 'Guyana'),
  ('HK', 'Hong Kong'),
  ('HM', 'Heard Island and McDonald Islands'),
  ('HN', 'Honduras'),
  ('HR', 'Croatia'),
  ('HT', 'Haiti'),
  ('HU', 'Hungary'),
  ('ID', 'Indonesia'),
  ('IE', 'Ireland'),
  ('IL', 'Israel'),
  ('IM', 'Isle of Man'),
  ('IN', 'India'),
  ('IO', 'British Indian Ocean Territory'),
  ('IQ', 'Iraq'),
  ('IR', 'Iran, Islamic Republic of'),
  ('IS', 'Iceland'),
  ('IT', 'Italy'),
  ('JE', 'Jersey'),
  ('JM', 'Jamaica'),
  ('JO', 'Jordan'),
  ('JP', 'Japan'),
  ('KE', 'Kenya'),
  ('KG', 'Kyrgyzstan'),
  ('KH', 'Cambodia'),
  ('KI', 'Kiribati'),
  ('KM', 'Comoros'),
  ('KN', 'Saint Kitts and Nevis'),
  ('KP', 'Korea, Democratic People\'s Republic of'),
  ('KR', 'Korea, Republic of'),
  ('KW', 'Kuwait'),
  ('KY', 'Cayman Islands'),
  ('KZ', 'Kazakhstan'),
  ('LA', 'Lao People\'s Democratic Republic'),
  ('LB', 'Lebanon'),
  ('LC', 'Saint Lucia'),
  ('LI', 'Liechtenstein'),
  ('LK', 'Sri Lanka'),
  ('LR', 'Liberia'),
  ('LS', 'Lesotho'),
  ('LT', 'Lithuania'),
  ('LU', 'Luxembourg'),
  ('LV', 'Latvia'),
  ('LY', 'Libya'),
  ('MA', 'Morocco'),
  ('MC', 'Monaco'),
  ('MD', 'Moldova, Republic of'),
  ('ME', 'Montenegro'),
  ('MF', 'Saint Martin (French part)'),
  ('MG', 'Madagascar'),
  ('MH', 'Marshall Islands'),
  ('MK', 'Macedonia, the former Yugoslav Republic of'),
  ('ML', 'Mali'),
  ('MM', 'Myanmar'),
  ('MN', 'Mongolia'),
  ('MO', 'Macao'),
  ('MP', 'Northern Mariana Islands'),
  ('MQ', 'Martinique'),
  ('MR', 'Mauritania'),
  ('MS', 'Montserrat'),
  ('MT', 'Malta'),
  ('MU', 'Mauritius'),
  ('MV', 'Maldives'),
  ('MW', 'Malawi'),
  ('MX', 'Mexico'),
  ('MY', 'Malaysia'),
  ('MZ', 'Mozambique'),
  ('NA', 'Namibia'),
  ('NC', 'New Caledonia'),
  ('NE', 'Niger'),
  ('NF', 'Norfolk Island'),
  ('NG', 'Nigeria'),
  ('NI', 'Nicaragua'),
  ('NL', 'Netherlands'),
  ('NO', 'Norway'),
  ('NP', 'Nepal'),
  ('NR', 'Nauru'),
  ('NU', 'Niue'),
  ('NZ', 'New Zealand'),
  ('OM', 'Oman'),
  ('PA', 'Panama'),
  ('PE', 'Peru'),
  ('PF', 'French Polynesia'),
  ('PG', 'Papua New Guinea'),
  ('PH', 'Philippines'),
  ('PK', 'Pakistan'),
  ('PL', 'Poland'),
  ('PM', 'Saint Pierre and Miquelon'),
  ('PN', 'Pitcairn'),
  ('PR', 'Puerto Rico'),
  ('PS', 'Palestine, State of'),
  ('PT', 'Portugal'),
  ('PW', 'Palau'),
  ('PY', 'Paraguay'),
  ('QA', 'Qatar'),
  ('RE', 'Réunion'),
  ('RO', 'Romania'),
  ('RS', 'Serbia'),
  ('RU', 'Russian Federation'),
  ('RW', 'Rwanda'),
  ('SA', 'Saudi Arabia'),
  ('SB', 'Solomon Islands'),
  ('SC', 'Seychelles'),
  ('SD', 'Sudan'),
  ('SE', 'Sweden'),
  ('SG', 'Singapore'),
  ('SH', 'Saint Helena, Ascension and Tristan da Cunha'),
  ('SI', 'Slovenia'),
  ('SJ', 'Svalbard and Jan Mayen'),
  ('SK', 'Slovakia'),
  ('SL', 'Sierra Leone'),
  ('SM', 'San Marino'),
  ('SN', 'Senegal'),
  ('SO', 'Somalia'),
  ('SR', 'Suriname'),
  ('SS', 'South Sudan'),
  ('ST', 'Sao Tome and Principe'),
  ('SV', 'El Salvador'),
  ('SX', 'Sint Maarten (Dutch part)'),
  ('SY', 'Syrian Arab Republic'),
  ('SZ', 'Swaziland'),
  ('TC', 'Turks and Caicos Islands'),
  ('TD', 'Chad'),
  ('TF', 'French Southern Territories'),
  ('TG', 'Togo'),
  ('TH', 'Thailand'),
  ('TJ', 'Tajikistan'),
  ('TK', 'Tokelau'),
  ('TL', 'Timor-Leste'),
  ('TM', 'Turkmenistan'),
  ('TN', 'Tunisia'),
  ('TO', 'Tonga'),
  ('TR', 'Turkey'),
  ('TT', 'Trinidad and Tobago'),
  ('TV', 'Tuvalu'),
  ('TW', 'Taiwan, Province of China'),
  ('TZ', 'Tanzania, United Republic of'),
  ('UA', 'Ukraine'),
  ('UG', 'Uganda'),
  ('UM', 'United States Minor Outlying Islands'),
  ('US', 'United States'),
  ('UY', 'Uruguay'),
  ('UZ', 'Uzbekistan'),
  ('VA', 'Holy See (Vatican City State)'),
  ('VC', 'Saint Vincent and the Grenadines'),
  ('VE', 'Venezuela, Bolivarian Republic of'),
  ('VG', 'Virgin Islands, British'),
  ('VI', 'Virgin Islands, U.S.'),
  ('VN', 'Viet Nam'),
  ('VU', 'Vanuatu'),
  ('WF', 'Wallis and Futuna'),
  ('WS', 'Samoa'),
  ('YE', 'Yemen'),
  ('YT', 'Mayotte'),
  ('ZA', 'South Africa'),
  ('ZM', 'Zambia'),
  ('ZW', 'Zimbabwe');
