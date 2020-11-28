/*
Домашнее задание к уроку №7
1. Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
интернет магазине.
2. Выведите список товаров products и разделов catalogs, который соответствует товару.
*/


# Подготовим базу для возможности выборки и работы с таблицами.

USE shop;

DROP TABLE IF EXISTS orders_products;
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';

ALTER TABLE orders ADD COLUMN product_id bigint UNSIGNED;
ALTER TABLE orders ADD CONSTRAINT product_id
FOREIGN KEY (product_id) REFERENCES products(id);
ALTER TABLE orders ADD CONSTRAINT user_id
FOREIGN KEY (user_id) REFERENCES users(id);
ALTER TABLE orders ADD COLUMN quantity bigint UNSIGNED
;

INSERT INTO orders
  (user_id, product_id, quantity)
VALUES
  (2, 6, 2),
  (1, 4, 1),
  (3, 3, 1),
  (5, 1, 2);

CREATE TABLE orders_products (
  id SERIAL PRIMARY KEY,
  order_id INT UNSIGNED,
  product_id INT UNSIGNED,
  total INT UNSIGNED DEFAULT 1 COMMENT 'Количество заказанных товарных позиций',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказа';

ALTER TABLE orders_products DROP COLUMN order_id;
ALTER TABLE orders_products ADD COLUMN order_id BIGINT UNSIGNED;
ALTER TABLE orders_products ADD CONSTRAINT order_id
FOREIGN KEY (order_id) REFERENCES orders(id);
ALTER TABLE orders_products DROP COLUMN product_id;
ALTER TABLE orders_products ADD COLUMN o_product_id BIGINT UNSIGNED;
ALTER TABLE orders_products ADD CONSTRAINT o_product_id
FOREIGN KEY (o_product_id) REFERENCES products(id);

INSERT orders_products 
	(total, order_id, o_product_id)
	SELECT quantity, id, product_id FROM orders;

/*
Задача №1
Составьте список пользователей users, которые осуществили хотя бы один заказ orders в
интернет магазине.
*/

SELECT
	users.id,
	users.name,
	orders.id AS orders_id
FROM 
	Users
JOIN
	orders
WHERE 
	users.id = orders.user_id;
	
/*
Задача №2
Выведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT
	products.id, 
	products.name,
	catalogs.name
FROM 
	products
JOIN
	catalogs
WHERE 
	products.catalog_id = catalogs.id;










