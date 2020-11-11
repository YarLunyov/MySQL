/*DROP DATABASE IF EXISTS TEST;
CREATE DATABASE TEST;
USE TEST;

DROP TABLE IF EXISTS products;
CREATE TABLE products(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	value INT
);

INSERT INTO products VALUES 
(NULL, 0),
(NULL, 2500),
(NULL, 0),
(NULL, 30),
(NULL, 500),
(NULL, 1);

(SELECT id, value FROM products WHERE value != 0 ORDER BY value)
UNION 
(SELECT id, value FROM products WHERE value = 0)
;

*/

DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY, 
	value INT
);

INSERT INTO storehouses_products VALUES 
(NULL, 0),
(NULL, 2500),
(NULL, 0),
(NULL, 30),
(NULL, 500),
(NULL, 1);

DROP TABLE IF EXISTS null_values;
CREATE TABLE null_values(
	null_id SERIAL PRIMARY KEY,
	null_value INT,
	FOREIGN KEY (null_id) REFERENCES storehouses_products(id)
);

INSERT INTO null_values SELECT * FROM storehouses_products WHERE value = 0;

(SELECT id, value FROM storehouses_products WHERE value != 0 ORDER BY value)
UNION 
(SELECT null_id, null_value FROM null_values)
-- ORDER BY value
;
