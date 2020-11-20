DROP DATABASE IF EXISTS Homework_5;
CREATE DATABASE Homework_5;
USE Homework_5;


# Задача №1
#Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их
#текущими датой и временем.

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id SERIAL, 
	firstname VARCHAR(100),
	created_at DATETIME,
	updated_at DATETIME
);

INSERT INTO users (id, firstname) VALUES 
('1', 'Иван'),
('2', 'Фёдорович'),
('3', 'Крузенштерн'),
('4', 'Человек'),
('5', 'И'),
('6', 'Пароход');

# Столбцы created_at и updated_at не заполнены.

UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();



#Задача №2
#Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы
#типом VARCHAR и в них долгое время помещались значения в формате "20.10.2017 8:10".
#Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.

DROP TABLE IF EXISTS users_2;
CREATE TABLE users_2(
	id SERIAL, 
	firstname VARCHAR(100),
	created_at VARCHAR(100),
	updated_at VARCHAR(100)
);

# Записи created_at и updated_at заданы типом VARCHAR

INSERT INTO users_2 VALUES 
(NULL, 'Иван', '20.10.2017 8:10', '26.10.2017 8:10'),
(NULL, 'Фёдорович', '21.10.2017 8:10', '27.10.2017 8:10'),
(NULL, 'Крузенштерн', '22.10.2017 8:10', '28.10.2017 8:10'),
(NULL, 'Человек', '23.10.2017 8:10', '29.10.2017 8:10'),
(NULL, 'И', '24.10.2017 8:10', '30.10.2017 8:10'),
(NULL, 'Пароход', '25.10.2017 8:10', '31.10.2017 8:10');

ALTER TABLE users_2 ADD COLUMN created_at_2 datetime;
ALTER TABLE users_2 ADD COLUMN updated_at_2 datetime;
UPDATE users_2 SET created_at_2=STR_TO_DATE(created_at, '%d.%m.%Y %h:%i');
UPDATE users_2 SET updated_at_2=STR_TO_DATE(updated_at, '%d.%m.%Y %h:%i');

ALTER TABLE users_2 DROP COLUMN created_at;
ALTER TABLE users_2 DROP COLUMN updated_at;


#Задача №3
#В таблице складских запасов storehouses_products в поле value могут встречаться самые
#разные цифры: 0, если товар закончился и выше нуля, если на складе имеются запасы.
#Необходимо отсортировать записи таким образом, чтобы они выводились в порядке
#увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех
#записей.

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

-- Вариант с одной таблицей
ALTER TABLE storehouses_products ADD COLUMN tag int;
UPDATE storehouses_products SET tag=2 WHERE value = 0;
UPDATE storehouses_products SET tag=1 WHERE value != 0;

(SELECT tag, value FROM storehouses_products WHERE tag = 1)
UNION ALL 
(SELECT tag, value FROM storehouses_products  WHERE tag = 2)
ORDER BY  tag, value;


/* -- Вариант с дополнительной таблицей
DROP TABLE IF EXISTS null_values;
CREATE TABLE null_values(
	null_id SERIAL PRIMARY KEY,
	value INT,
	FOREIGN KEY (null_id) REFERENCES storehouses_products(id)
);

INSERT INTO null_values SELECT * FROM storehouses_products WHERE value = 0;

(SELECT 1 AS sort, value FROM storehouses_products WHERE value != 0)
UNION all
(SELECT 2 AS sort, value FROM null_values)
ORDER BY  sort, value
;
*/






