drop database if exists project;
create database project;
use project;

-- Структура таблицы 1 "Районы"

drop table if exists districts;
create table districts(
	id serial primary key,
	d_name VARCHAR(100) unique COMMENT 'Название района',
	d_address VARCHAR(200) COMMENT 'Адрес площадки'
);

INSERT INTO districts VALUES
  (NULL, 'Адмиралтейский', 'Перевозная ул., дом 8'),
  (NULL, 'Выборгский', 'Парголово, ул. Верхняя дом 1'),
  (NULL, 'Красногвардейский', 'Шафировский пр-кт, дом 15'),
  (NULL, 'Петроградский', 'ул. Пионерская, дом 44'),
  (NULL, 'Приморский', 'ул. Автобусная, дом 5д')
 ;

-- Структура таблицы 2 "Типы складских ячеек" 
 
drop table if exists my_types;
create table my_types(
	type_id serial,	
	t_title VARCHAR(100) unique key COMMENT 'Краткое наименование ячейки / контейнера',
	t_type VARCHAR(100) COMMENT 'Тип ячейки / контейнера',
	t_dim VARCHAR(100) COMMENT 'Размер ячейки / контейнера',
	t_vol DECIMAL(5,2) COMMENT 'Объём ячейки / контейнера'
);

INSERT INTO my_types (t_title, t_type, t_dim, t_vol) values
  	('40 DV', 'Контейнер морской 40 ft стандартный', '12192х2438х2591', 77.0),
  	('40 HS', 'Контейнер морской 40 ft высокий', '12192х2438х2896', 86.1),
  	('20 DC', 'Контейнер морской 20 ft стандартный', '6058х2438х2591', 38.3),
  	('20 HC', 'Контейнер морской 20 ft высокий', '6058х2438х2896', 42.8),
 	('10 GP', 'Контейнер морской 10 ft стандартный', '2991х2438х2591', 18.9),
	('10 HC', 'Контейнер морской 10 ft высокий', '2991х2438х2896', 21.1)
;

-- Структура таблицы 3 "Перечень ячеек" 

drop table if exists list;
create table list(
	id serial primary key,
	l_name VARCHAR(100) COMMENT 'Краткое наименование ячейки / контейнера',
	l_dist VARCHAR(100) COMMENT 'Привязка к району',
	l_numb INT COMMENT 'Номер ячейки / контейнера на территории',
	t_el bit default 1 COMMENT 'Подведено ли электричество',
    FOREIGN KEY (l_dist) REFERENCES districts(d_name),
    FOREIGN KEY (l_name) REFERENCES my_types(t_title)
);

INSERT INTO list (l_name, l_dist, l_numb, t_el) values
 	('40 DV', 'Адмиралтейский', 1, 1),
	('40 DV', 'Адмиралтейский', 2, 1),
	('40 DV', 'Адмиралтейский', 3, 1),
  	('40 DV', 'Адмиралтейский', 4, 0),
 	('40 DV', 'Адмиралтейский', 5, 1),
	('40 DV', 'Адмиралтейский', 6, 0),
	('20 DC', 'Адмиралтейский', 7, 1),
	('20 DC', 'Адмиралтейский', 8, 1),	
	('20 DC', 'Адмиралтейский', 9, 1),	
	('20 DC', 'Адмиралтейский', 10, 1),	
	('20 DC', 'Адмиралтейский', 11, 0),	
	('20 DC', 'Адмиралтейский', 12, 1),	
	('20 DC', 'Адмиралтейский', 13, 1),	
	('20 DC', 'Адмиралтейский', 14, 0),	
  	('40 DV', 'Выборгский', 1, 1),
  	('40 DV', 'Выборгский', 2, 1),
	('40 DV', 'Выборгский', 3, 1),
  	('40 HS', 'Петроградский', 1, 1),
  	('40 HS', 'Выборгский', 4, 0),
  	('40 HS', 'Красногвардейский', 1, 0),
  	('40 HS', 'Выборгский', 5, 0),
 	('40 HS', 'Выборгский', 6, 1),
	('40 HS', 'Красногвардейский', 2, 1),
  	('40 HS', 'Выборгский', 7, 1),
  	('40 HS', 'Приморский', 1, 1),
 	('40 HS', 'Выборгский', 8, 1),
	('40 HS', 'Приморский', 2, 0)
;


-- Структура таблицы 4 "Администрация" 

DROP TABLE IF EXISTS admins;
CREATE TABLE admins(
	admine_id SERIAL PRIMARY KEY,
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	INDEX idx_admine_name(firstname, lastname)
);

INSERT INTO admins (firstname, lastname, email, phone) values
('Виктор', 'Сухоруков', 'xeichmann@example.net', '9136605713'),
('Сергей', 'Бодров', 'damaris34@example.net', '9192291407'),
('Далай', 'Лама', 'gail.lockman@example.net', '9491584055'),
('Джим', 'Керри', 'rolando45@example.org', '9512440690')
;

-- Структура таблицы 5 "Пользователи" 

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    email VARCHAR(120),
    phone BIGINT UNSIGNED UNIQUE, 
    INDEX users_phone_idx(phone),
    INDEX users_firstname_lastname_idx(firstname, lastname)
);

INSERT INTO users (firstname, lastname, email, phone) values
('Андрей', 'Никитин', 'lowe.amelia@example.net', '9765846197'),
('Виталий', 'Мелков', 'aschneider@example.net', '9533355262'),
('Чак', 'Норрис', 'cathryn40@example.net', '9163727209'),
('Джекки', 'Чан', 'allie.witting@example.com', '9891313707'),
('Брюс', 'Ли', 'durward83@example.com', '9613848114'),
('Алексей', 'Кадочников', 'stamm.bret@example.net', '9763350438'),
('Наталия', 'Орейро', 'concepcion.conn@example.net', '9675063949'),
('Владимир', 'Владимирович', 'ibeer@example.com', '9987381304'),
('Надежда', 'Бабкина', 'tkessler@example.com', '9938579943'),
('Сергей', 'Ястржембский', 'barrett12@example.com', '9886578202'),
('Джордж', 'Лукас', 'orin69@example.net', '9160120629'),
('Почтальон', 'Печкин', 'sleffler@example.net', '9414604655'),
('Дядя', 'Фёдор', 'bartell.einar@example.net', '9916593682'),
('Кот', 'Матроскин', 'linda58@example.com', '9519551625'),
('Пёс', 'Шарик', 'abbigail68@example.net', '9484610686'),
('Джек', 'Воробей', 'callie.wuckert@example.org', '9532811737'),
('Николай', 'Валуев', 'loyal.herzog@example.org', '9659591995'),
('Дмитрий', 'Дюжев', 'nils93@example.org', '9905318598'),
('Сергей', 'Есенин', 'chelsea01@example.com', '9412172452'),
('Ольга', 'Форш', 'modesta.haley@example.com', '9803009959'),
('Ксения', 'Собчак', 'mmarvin@example.com', '9428224970'),
('Аделина', 'Сотникова', 'urunolfsdottir@example.net', '9247233922'),
('Алина', 'Кабаева', 'jamaal.farrell@example.com', '9902477849'),
('Сергей', 'Шойгу', 'noemie38@example.org', '9803133328'),
('Лев', 'Лурье', 'johnathan.waelchi@example.org', '9330339588')
;

-- Структура таблицы 6 "Профили пользователей" 

DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles (
	user_id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
    created_at DATETIME DEFAULT NOW(),
    balance DECIMAL(7,2),
    FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO profiles (gender, birthday, created_at, balance) values
('m', '1956-02-12', '2013-01-11 19:37:45', 92566.34),
('m', '1999-04-22', '2013-02-12 19:37:45', 14566.18),
('m', '1996-12-12', '2010-12-18 19:37:45', 9566.20),
('m', '2000-07-18', '2009-07-22 19:37:45', 12566.18),
('m', '1989-12-22', '2014-06-26 19:37:45', 1123.30),
('m', '1978-04-24', '2011-01-25 19:37:45', -4566.18),
('f', '1995-03-12', '2010-05-21 19:37:45', 0),
('m', '1998-11-08', '2009-08-15 19:37:45', 24500.18),
('f', '1982-09-15', '2010-09-11 19:37:45', 1789.18),
('m', '1975-12-27', '2011-07-27 19:37:45', 34566.00),
('m', '1977-07-27', '2013-02-22 19:37:45', 11111.18),
('m', '1978-04-07', '2014-08-28 19:37:45', 2345.95),
('m', '1989-08-15', '2016-04-15 19:37:45', 547.18),
('m', '1998-06-28', '2017-07-07 19:37:45', 9865.02),
('m', '1986-07-30', '2020-01-24 19:37:45', 87652.00),
('m', '1987-11-13', '2018-03-05 19:37:45', 57821.34),
('m', '1998-10-08', '2015-08-18 19:37:45', 0),
('m', '2005-08-14', '2016-02-14 19:37:45', -566.80),
('m', '2001-12-17', '2018-05-11 19:37:45', 65321.18),
('f', '1995-08-27', '2019-09-19 19:37:45', 8650.11),
('f', '1976-03-21', '2012-05-08 19:37:45', 6566.32),
('f', '1986-12-25', '2016-07-03 19:37:45', 21984.22),
('f', '1978-04-18', '2008-04-27 19:37:45', 4689.00),
('m', '1969-02-16', '2020-07-14 19:37:45', 7237.56),
('m', '1995-07-09', '2008-10-12 19:37:45', 6596.50)
;

-- Структура таблицы 7 "Акции / скидки" 

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  user_id BIGINT UNSIGNED,
  district_id BIGINT UNSIGNED,
  my_type VARCHAR(100),
  district_discount DECIMAL(3,2) unsigned default 1.00 COMMENT 'Величина скидки по району от 0.00 до 1.00',
  user_discount DECIMAL(3,2) unsigned default 1.00 COMMENT 'Величина скидки пользователя от 0.00 до 1.00',
  type_discount DECIMAL(3,2) unsigned default 1.00 COMMENT 'Величина скидки по типу ячейки от 0.00 до 1.00',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_user_id(user_id),
  KEY index_of_district_id(district_id),
  KEY index_of_type_id(my_type),
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (district_id) REFERENCES districts(id),
  FOREIGN KEY (my_type) REFERENCES my_types(t_title)
);

#INSERT INTO discounts (district_id, district_discount, started_at, finished_at) values
#(1, )








