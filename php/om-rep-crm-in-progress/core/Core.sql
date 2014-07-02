SET FOREIGN_KEY_CHECKS = 0;
SET STORAGE_ENGINE = InnoDB;

/*  Create/re-create core tables
    ============================================================================
*/

/* Activity - for tracking general activity */
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity` (
    `activityID` INT UNSIGNED NOT NULL AUTO_INCREMENT,

    `type`      TINYINT(3) NOT NULL,
    `data`      TEXT DEFAULT NULL,
    `datetime`  DATETIME NOT NULL DEFAULT 0, /* activity datetime */

    `userID`    INT UNSIGNED NOT NULL,

    PRIMARY KEY (activityID)
)
    AUTO_INCREMENT = 1001
    DEFAULT	CHARSET = UTF8;

/* User table */
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
    `userID`    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `roleID`    INT UNSIGNED NOT NULL,

    `active`	INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',
    `uid`		VARCHAR(32) NOT NULL COMMENT 'auth. uid',
    `hash`      VARCHAR(128) NOT NULL COMMENT 'pass. hash',
    `salt`	    VARCHAR(128) NOT NULL COMMENT 'pass. salt',

    `type`      TINYINT(1) NOT NULL,
    `firstName` VARCHAR(64) NOT NULL,
    `lastName`  VARCHAR(64) NOT NULL,
    `avatar`	VARCHAR(64) DEFAULT NULL,
    `signedUp`  DATETIME NOT NULL DEFAULT 0, /* registration datetime */

    `sessionID` VARCHAR(128) NULL, /* for remember me functionality - one-to-one relationship */

    PRIMARY KEY (`userID`)
)
    AUTO_INCREMENT = 1001
	DEFAULT	CHARSET = UTF8;

/* Organisation table */
DROP TABLE IF EXISTS `organisation`;
CREATE TABLE `organisation` (
    `orgID`         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name`          VARCHAR(255) NOT NULL,
    `description`   TEXT NOT NULL,
    `registered`    DATETIME NOT NULL DEFAULT 0, /* when the organisation was registered */

    PRIMARY KEY (`orgID`)
)
    AUTO_INCREMENT = 1001
    DEFAULT CHARSET = UTF8;

/* Address table */
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `addressID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `line1`       VARCHAR(128) NOT NULL,
  `line2`       VARCHAR(128) NOT NULL,
  `city`        VARCHAR(64) NOT NULL,
  `zip`         VARCHAR(16) NOT NULL,

  `countryID`   INT UNSIGNED NOT NULL,

  PRIMARY KEY (`addressID`)
)
    AUTO_INCREMENT = 1001
  DEFAULT CHARSET = UTF8;

/* Contact table */
DROP TABLE IF EXISTS `contact`;
CREATE TABLE `contact` (
  `contactID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type`        TINYINT(3) UNSIGNED NOT NULL,
  `value`       VARCHAR(255) NOT NULL,

  PRIMARY KEY (`contactID`)
)
    AUTO_INCREMENT = 1001
    DEFAULT CHARSET = UTF8;

/* Language table */
DROP TABLE IF EXISTS `language`;
CREATE TABLE `language` (
  `languageID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code`  CHAR(2) NOT NULL,
  `name`  VARCHAR(64) NOT NULL,

  PRIMARY KEY (`languageID`)
)
    AUTO_INCREMENT = 1001
	DEFAULT CHARSET = UTF8;

/* Country table */
DROP TABLE IF EXISTS `country`;
CREATE TABLE `country` (
  `countryID`  INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `code`  CHAR(2) NOT NULL,
  `name`  VARCHAR(64) NOT NULL,

  PRIMARY KEY (`countryID`)
)
  AUTO_INCREMENT = 1001
  DEFAULT CHARSET = UTF8;

/* Message table */
DROP TABLE IF EXISTS `message`;
CREATE TABLE `message` (
  `messageID`   INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `subject`     VARCHAR(255) NOT NULL,
  `message`     TEXT NOT NULL,
  `datetime`    DATETIME NOT NULL DEFAULT 0,

  `userID`      INT UNSIGNED NOT NULL COMMENT 'userID as sender',

  PRIMARY KEY (`messageID`)
)
  AUTO_INCREMENT = 1001
  DEFAULT CHARSET = UTF8;

/*  Add foreign keys and create/re-create relationship tables
    ============================================================================
*/
SET FOREIGN_KEY_CHECKS = 1;

/* Activity table */
ALTER TABLE `activity`
ADD CONSTRAINT `activity_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Address table, one-to-one relationship, 1 address - 1 country */
ALTER TABLE `address`
  ADD CONSTRAINT `address_fk_country` FOREIGN KEY (`countryID`) REFERENCES `country`(`countryID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE;

/* Address_Contact, one-to-many relationship, one address - many contacts */
DROP TABLE IF EXISTS `address_contact`;
CREATE TABLE `address_contact` (
    `addressID`     INT UNSIGNED NOT NULL,
    `contactID`     INT UNSIGNED NOT NULL,
    `primary`       INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

    PRIMARY KEY (`addressID`,`contactID`),
    CONSTRAINT `adco_fk_addr` FOREIGN KEY (`addressID`) REFERENCES `address`(`addressID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `adco_fk_cont` FOREIGN KEY (`contactID`) REFERENCES `contact`(`contactID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

/* User_Address, one-to-many relationship, one user - many addresses */
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
    `userID`        INT UNSIGNED NOT NULL,
    `addressID`     INT UNSIGNED NOT NULL,
    `primary`       INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

    PRIMARY KEY (`userID`,`addressID`),
    CONSTRAINT `usad_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `usad_fk_addr` FOREIGN KEY (`addressID`) REFERENCES `address`(`addressID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

/* User_Contact, one-to-many relationship, one user - many contacts */
DROP TABLE IF EXISTS `user_contact`;
CREATE TABLE `user_contact` (
    `userID`        INT UNSIGNED NOT NULL,
    `contactID`     INT UNSIGNED NOT NULL,
    `primary`       INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

    PRIMARY KEY (`userID`,contactID),
    CONSTRAINT `usco_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `usco_fk_cont` FOREIGN KEY (contactID) REFERENCES `contact`(`contactID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

/* User_Language, many-to-many relationships, many users - many languages */
DROP TABLE IF EXISTS `user_language`;
CREATE TABLE `user_language` (
  `userID`      INT UNSIGNED NOT NULL,
  `languageID`  INT UNSIGNED NOT NULL,
  `primary`     INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

  PRIMARY KEY (`userID`,`languageID`),
  CONSTRAINT `usla_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT `usla_fk_lang` FOREIGN KEY (`languageID`) REFERENCES `language`(`languageID`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);

/* Org_User, one-to-many relationship, one organisation - many users */
DROP TABLE IF EXISTS `org_user`;
CREATE TABLE `org_user` (
    `orgID`     INT UNSIGNED NOT NULL,
    `userID`    INT UNSIGNED NOT NULL,

    PRIMARY KEY (`orgID`,`userID`),
    CONSTRAINT `orus_fk_org` FOREIGN KEY (`orgID`) REFERENCES `organisation`(`orgID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `orus_fk_user` FOREIGN KEY (`userID`) REFERENCES `user`(`userID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

/* Org_Address, one-to-many relationship, one organisation - many addresses */
DROP TABLE IF EXISTS `org_address`;
CREATE TABLE `org_address` (
    `orgID`         INT UNSIGNED NOT NULL,
    `addressID`     INT UNSIGNED NOT NULL,
    `primary`       INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

    PRIMARY KEY (`orgID`,`addressID`),
    CONSTRAINT `orad_fk_org` FOREIGN KEY (`orgID`) REFERENCES `organisation`(`orgID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `orad_fk_addr` FOREIGN KEY (`addressID`) REFERENCES `address`(`addressID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

/* Org_Contact, one-to-many relationship, one organisation - many contacts */
DROP TABLE IF EXISTS `org_contact`;
CREATE TABLE `org_contact` (
    `orgID`         INT UNSIGNED NOT NULL,
    `contactID`     INT UNSIGNED NOT NULL,
    `primary`       INT(1) NOT NULL DEFAULT 0 COMMENT '1=>true, 0=>false',

    PRIMARY KEY (`orgID`,contactID),
    CONSTRAINT `orco_fk_org` FOREIGN KEY (`orgID`) REFERENCES `organisation`(`orgID`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT `orco_fk_cont` FOREIGN KEY (contactID) REFERENCES `contact`(`contactID`)
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
