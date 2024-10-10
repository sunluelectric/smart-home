/*create database*/
CREATE DATABASE smart_home;

/*select database*/
USE smart_home;

/*create resources tables*/
CREATE TABLE asset (
    PRIMARY KEY (serial_num),
    serial_num                  VARCHAR(50),
    product_type_id             INT(5),
    product_brand_id            INT(5),
    product_name                VARCHAR(50)     NOT NULL,
    receipt_num                 VARCHAR(50),
    procured_date               DATE            NOT NULL DEFAULT (CURRENT_DATE),
    procured_price              DECIMAL(10,2),
    payment_method_id           INT(5),
    warranty_date_1             DATE            NOT NULL DEFAULT (CURRENT_DATE),
    warranty_date_2             DATE            NOT NULL DEFAULT (CURRENT_DATE),
    expire_date                 DATE            NOT NULL DEFAULT '9999-12-31',
                                CONSTRAINT warranty_after_procured
                                CHECK(warranty_date_1 >= procured_date AND warranty_date_2 >= warranty_date_1),
                                CONSTRAINT expire_after_procured
                                CHECK(expire_date >= procured_date)
);

CREATE TABLE accessory (
    PRIMARY KEY (item_id),
    item_id                     INT(5)          AUTO_INCREMENT,
    product_type_id             INT(5),
    product_brand_id            INT(5),
    product_name                VARCHAR(50)     NOT NULL,
    receipt_num                 VARCHAR(50),
    procured_date               DATE            NOT NULL DEFAULT (CURRENT_DATE),
    procured_number             DECIMAL(10,2)   NOT NULL DEFAULT 1.00,
    procured_unit_price         DECIMAL(10,2),
    procured_price              DECIMAL(10,2),
    payment_method_id           INT(5),
    expire_date                 DATE            NOT NULL DEFAULT '9999-12-31',
                                CONSTRAINT expire_after_procured
                                CHECK(expire_date >= procured_date)
);

CREATE TABLE consumable (
    PRIMARY KEY (item_id),
    item_id                     INT(5)          AUTO_INCREMENT,
    product_type_id             INT(5),
    product_brand_id            INT(5),
    product_name                VARCHAR(50)     NOT NULL,
    receipt_num                 VARCHAR(50),
    procured_date               DATE            NOT NULL DEFAULT (CURRENT_DATE),
    procured_number             DECIMAL(10,2)   NOT NULL DEFAULT 1.00,
    procured_unit_price         DECIMAL(10,2),
    procured_price              DECIMAL(10,2),
    payment_method_id           INT(5),
    expire_date                 DATE            NOT NULL DEFAULT (CURRENT_DATE),
                                CONSTRAINT expire_after_procured
                                CHECK(expire_date >= procured_date)
);

CREATE TABLE subscription (
    PRIMARY KEY (item_id),
    item_id                     INT(5)          AUTO_INCREMENT,
    product_type_id             INT(5),
    product_brand_id            INT(5),
    product_name                VARCHAR(50)     NOT NULL,
    receipt_num                 VARCHAR(50),
    procured_date               DATE            NOT NULL DEFAULT (CURRENT_DATE),
    procured_price              DECIMAL(10,2),
    payment_method_id           INT(5),
    expire_date                 DATE            NOT NULL DEFAULT (CURRENT_DATE),
                                CONSTRAINT expire_after_procured
                                CHECK(expire_date >= procured_date)
);

/*create reference tables*/

CREATE TABLE user (
    PRIMARY KEY (user_id),
    user_id                     INT(5),
    first_name                  VARCHAR(50)     NOT NULL,
    last_name                   VARCHAR(50)     NOT NULL,
    email                       VARCHAR(50)     NOT NULL UNIQUE   
);

CREATE TABLE product_type (
    PRIMARY KEY (product_type_id),
    product_type_id             INT(5)          AUTO_INCREMENT,
    product_type_name           VARCHAR(50)     NOT NULL UNIQUE,
    product_type_name_sub       VARCHAR(50)     NOT NULL DEFAULT ('na')
);

CREATE TABLE product_brand (
    PRIMARY KEY (product_brand_id),
    product_brand_id            INT(5)          AUTO_INCREMENT,
    product_brand_name          VARCHAR(50)     NOT NULL UNIQUE
);

CREATE TABLE payment_method (
    PRIMARY KEY (payment_method_id),
    payment_method_id           INT(50)         AUTO_INCREMENT,
    user_id                     INT(5),
    payment_method_name         VARCHAR(50)     NOT NULL          
);

/*build schema*/
ALTER TABLE payment_method
ADD FOREIGN KEY (user_id) 
REFERENCES user(user_id);
ALTER TABLE asset
ADD FOREIGN KEY (product_type_id) 
REFERENCES product_type(product_type_id);
ALTER TABLE asset
ADD FOREIGN KEY (product_brand_id) 
REFERENCES product_brand(product_brand_id);
ALTER TABLE asset
ADD FOREIGN KEY (payment_method_id) 
REFERENCES payment_method(payment_method_id);
ALTER TABLE accessory
ADD FOREIGN KEY (product_type_id) 
REFERENCES product_type(product_type_id);
ALTER TABLE accessory
ADD FOREIGN KEY (product_brand_id) 
REFERENCES product_brand(product_brand_id);
ALTER TABLE accessory
ADD FOREIGN KEY (payment_method_id) 
REFERENCES payment_method(payment_method_id);
ALTER TABLE consumable
ADD FOREIGN KEY (product_type_id) 
REFERENCES product_type(product_type_id);
ALTER TABLE consumable
ADD FOREIGN KEY (product_brand_id) 
REFERENCES product_brand(product_brand_id);
ALTER TABLE consumable
ADD FOREIGN KEY (payment_method_id) 
REFERENCES payment_method(payment_method_id);
ALTER TABLE subscription
ADD FOREIGN KEY (product_type_id) 
REFERENCES product_type(product_type_id);
ALTER TABLE subscription
ADD FOREIGN KEY (product_brand_id) 
REFERENCES product_brand(product_brand_id);
ALTER TABLE subscription
ADD FOREIGN KEY (payment_method_id) 
REFERENCES payment_method(payment_method_id);
