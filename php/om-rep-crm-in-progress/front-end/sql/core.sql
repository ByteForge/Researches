SET FOREIGN_KEY_CHECKS = 0;

/* User table */
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `userID`    INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `firstName` VARCHAR(64) NOT NULL,
  `lastName`  VARCHAR(64) NOT NULL,
  `active`	  BIT(1) NOT NULL DEFAULT 0 COMMENT 'active (0 = false, 1 = true)',
  `avatar`	  VARCHAR(64) DEFAULT NULL COMMENT 'avatar/portrait',
  `roleID`    INT UNSIGNED NOT NULL COMMENT 'role foreign key',
	PRIMARY KEY (`userID`)
)
	ENGINE=InnoDB
	AUTO_INCREMENT=1
	DEFAULT	CHARSET=UTF8;

/* Role table */
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `roleID`      INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `name`        VARCHAR(64) NOT NULL,
  `description` VARCHAR(255) NOT NULL,

  PRIMARY KEY (`roleID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Privilege table */
DROP TABLE IF EXISTS `privilege`;
CREATE TABLE `privilege` (
  `privilegeID` INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `name`        VARCHAR(64) NOT NULL,
  `description` VARCHAR(255) NOT NULL,

  PRIMARY KEY (`privilegeID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Message table */
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `messageID`   INT UNSIGNED NOT NULL	AUTO_INCREMENT,

  PRIMARY KEY (`messageID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Recipient table */
DROP TABLE IF EXISTS `recipient`;
CREATE TABLE `recipient` (
  `recipientID`   INT UNSIGNED NOT NULL	AUTO_INCREMENT,

  PRIMARY KEY (`recipientID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Item table */
DROP TABLE IF EXISTS `item`;
CREATE TABLE `item` (
  `itemID`   INT UNSIGNED NOT NULL	AUTO_INCREMENT,

  PRIMARY KEY (`itemID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Order table */
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderID`   INT UNSIGNED NOT NULL	AUTO_INCREMENT,

  PRIMARY KEY (`orderID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Address table */
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressID`   INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `primary`     BIT(1) NOT NULL DEFAULT 0
                COMMENT '1 => primary address, 0 => non-primary address',

  `line1`       VARCHAR(128) NOT NULL,
  `line2`       VARCHAR(128) NOT NULL,
  `city`        VARCHAR(64) NOT NULL,
  `zip`         VARCHAR(16) NOT NULL,

  `countryID`   INT UNSIGNED NOT NULL COMMENT 'country foreign key',
  `userID`      INT UNSIGNED NOT NULL COMMENT 'user foreign key',

  PRIMARY KEY (`addressID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Contact table */
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contactID`   INT UNSIGNED NOT NULL	AUTO_INCREMENT,
  `primary`     BIT(1) NOT NULL DEFAULT 0
                COMMENT '1 => primary address, 0 => non-primary address',
  `type`        TINYINT(2) NOT NULL
                COMMENT 'contact type',
  `value`       VARCHAR(255) NOT NULL,

  `addressID`   INT UNSIGNED NOT NULL COMMENT 'address foreign key',

  PRIMARY KEY (`contactID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

/* Language table */
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `languageID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,

  `shortName` CHAR(2) NOT NULL,
  `longName`  VARCHAR(64) NOT NULL,

	PRIMARY KEY (`languageID`)
)
	ENGINE=InnoDB
	AUTO_INCREMENT=1
	DEFAULT	CHARSET=UTF8;

INSERT INTO `language` (`shortName`, `longName`) VALUES
('BG', 'Bulgarian'),
('HR', 'Croatian'),
('CS', 'Czech'),
('DA', 'Danish'),
('NL', 'Dutch'),
('EN', 'English'),
('ET', 'Estonian'),
('FI', 'Finnish'),
('FR', 'French'),
('DE', 'German'),
('EL', 'Greek'),
('HU', 'Hungarian'),
('GA', 'Irish'),
('IT', 'Italian'),
('LV', 'Latvian'),
('LT', 'Lithuanian'),
('MT', 'Maltese'),
('PL', 'Polish'),
('PT', 'Portuguese'),
('RO', 'Romanian'),
('SK', 'Slovak'),
('SL', 'Slovene'),
('ES', 'Spanish'),
('SV', 'Swedish');

/* Country table */
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `countryID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,

  `shortName` CHAR(2) NOT NULL,
  `longName`  VARCHAR(64) NOT NULL,

  PRIMARY KEY (`countryID`)
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;

INSERT INTO `country` (`shortName`, `longName`) VALUES
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

/* Add foreign keys */
SET FOREIGN_KEY_CHECKS = 1;

/* User table, one-to-one relationship, 1 user - 1 role */
ALTER TABLE `user`
  ADD CONSTRAINT `user_fk_role` FOREIGN KEY (`roleID`) REFERENCES `role`(`roleID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

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
)
  ENGINE=InnoDB;

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
    ON DELETE CASCADE;

/* User_Language, many-to-many relationships, many users - many languages */
DROP TABLE IF EXISTS `user_language`;
CREATE TABLE `user_language` (
  `userID`      INT UNSIGNED NOT NULL,
  `languageID`  INT UNSIGNED NOT NULL,
  `primary`     BIT(1) NOT NULL DEFAULT 0
                COMMENT '1 => primary language, 0 => non-primary language',

  PRIMARY KEY (`userID`,`languageID`),
  CONSTRAINT `usla_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `usla_fk_lang` FOREIGN KEY (`languageID`) REFERENCES `language`(`languageID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE=InnoDB;

/* Session table, one-to-one relationship, one user - one session */
DROP TABLE IF EXISTS `session`;
CREATE TABLE `session` (
  `userID`   INT UNSIGNED NOT NULL,
  `hash`     VARCHAR(88) NOT NULL,

  PRIMARY KEY (`userID`),
  CONSTRAINT `session_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
)
  ENGINE=InnoDB
  AUTO_INCREMENT=1
  DEFAULT	CHARSET=UTF8;
