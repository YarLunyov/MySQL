DROP DATABASE IF EXISTS flights;
CREATE DATABASE flights;
USE flights;

/*
(по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label,
name). Поля from, to и label содержат английские названия городов, поле name — русское.
Выведите список рейсов flights с русскими названиями городов.
*/

DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	id SERIAL PRIMARY KEY,
	f_from VARCHAR(50),
    f_to VARCHAR(50)
);

INSERT INTO flights 
	(f_from, f_to)
VALUES
	('moscow', 'omsk'),
	('novgorod', 'kasan'),
	('irkutsk', 'moscow'),
	('omsk', 'irkutsk'),
	('novgorod', 'kasan');
    
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
	label VARCHAR(50),
    name VARCHAR(50)
);

INSERT INTO cities VALUES
	('moscow', 'москва'),
	('irkutsk', 'иркутск'),
	('novgorod', 'новгород'),
	('kasan', 'казань'),
	('omsk', 'омск');


DROP TABLE IF EXISTS cities_2;
CREATE TABLE cities_2 (
	label_2 VARCHAR(50),
    name_2 VARCHAR(50)
);

INSERT cities_2 (label_2, name_2)
	SELECT label, name FROM cities;


SELECT 
	flights.id,
	cities.name AS `from`,
	cities_2.name_2 AS `to`
FROM 
	flights
JOIN 
	cities 
ON 
	flights.f_from = cities.label
JOIN 
	cities_2 
ON 
	flights.f_to = cities_2.label_2
ORDER BY id;

