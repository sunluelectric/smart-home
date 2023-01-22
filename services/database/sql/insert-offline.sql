/*select database*/
USE smart_home;

/* user table schema:
    PRIMARY KEY (user_id),
    user_id                     INT(5),
    first_name                  VARCHAR(50)     NOT NULL,
    last_name                   VARCHAR(50)     NOT NULL,
    email                       VARCHAR(50)     NOT NULL  
*/

INSERT INTO user
VALUES (0, 'undefined', 'undefined', 'undefined');

/* product_type table schema:
    PRIMARY KEY (product_type_id),
    product_type_id             INT(5)          AUTO_INCREMENT,
    product_type_name           VARCHAR(50)     NOT NULL DEFAULT ('na'),
    product_type_name_sub       VARCHAR(50)     NOT NULL DEFAULT ('na')
*/

INSERT INTO product_type
VALUES (NULL, 'undefined', 'undefined');
UPDATE product_type
SET product_type_id = 0
WHERE product_type_id = 1;


/* product_brand table schema:
    PRIMARY KEY (product_brand_id),
    product_brand_id            INT(5)          AUTO_INCREMENT,
    product_brand_name          VARCHAR(50)     NOT NULL DEFAULT ('na')
*/

INSERT INTO product_brand
VALUES (NULL, 'undefined');
UPDATE product_brand
SET product_brand_id = 0
WHERE product_brand_id = 1;

/* payment_method table schema:
    PRIMARY KEY (payment_method_id),
    payment_method_id           INT(50)         AUTO_INCREMENT,
    user_id                     INT(5)          NOT NULL,
    payment_method_name         VARCHAR(50)     NOT NULL  
*/

INSERT INTO payment_method
VALUES (NULL, 0, 'undefined');
UPDATE payment_method
SET payment_method_id = 0
WHERE payment_method_id = 1;
