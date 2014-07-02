
/* Order table */
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order` (
  `orderID`     INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `description` VARCHAR(255) NOT NULL,
  `datetime`    DATETIME NOT NULL DEFAULT 0, /* when the order was registered */

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