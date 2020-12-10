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
	l_rent bit default 0 COMMENT 'Арендован или нет',
#	status ENUM('reserved', 'free', 'free_in_week') default 'free',
    FOREIGN KEY (l_dist) REFERENCES districts(d_name),
    FOREIGN KEY (l_name) REFERENCES my_types(t_title)
);

INSERT INTO list (l_name, l_dist, l_numb) values
 	('40 DV', 'Адмиралтейский', 1),
	('40 DV', 'Адмиралтейский', 2),
	('40 DV', 'Адмиралтейский', 3),
  	('40 DV', 'Адмиралтейский', 4),
 	('40 DV', 'Адмиралтейский', 5),
	('40 DV', 'Адмиралтейский', 6),
	('20 DC', 'Адмиралтейский', 7),
	('20 DC', 'Адмиралтейский', 8),	
	('20 DC', 'Адмиралтейский', 9),	
	('20 DC', 'Адмиралтейский', 10),	
	('20 DC', 'Адмиралтейский', 11),	
	('20 DC', 'Адмиралтейский', 12),	
	('20 DC', 'Адмиралтейский', 13),	
	('20 DC', 'Адмиралтейский', 14),	
  	('40 DV', 'Выборгский', 1),
  	('40 DV', 'Выборгский', 2),
	('40 DV', 'Выборгский', 3),
  	('40 HS', 'Петроградский', 1),
  	('40 HS', 'Выборгский', 4),
  	('40 HS', 'Красногвардейский', 1),
  	('40 HS', 'Выборгский', 5),
 	('40 HS', 'Выборгский', 6),
	('40 HS', 'Красногвардейский', 2),
  	('40 HS', 'Выборгский', 7),
  	('40 HS', 'Приморский', 1),
 	('40 HS', 'Выборгский', 8),
	('40 HS', 'Приморский', 2)
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
	id SERIAL PRIMARY KEY,
    gender CHAR(1),
    birthday DATE,
    created_at DATETIME DEFAULT NOW(),
    user_discount DECIMAL(3,2) unsigned default 1.00 COMMENT 'Величина скидки пользователя от 0.00 до 1.00',
    balance DECIMAL(7,2),
    FOREIGN KEY (id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

INSERT INTO profiles (gender, birthday, created_at, user_discount, balance) values
('m', '1956-02-12', '2013-01-11 19:37:45', 0.9, 22566.34),
('m', '1999-04-22', '2013-02-12 19:37:45', 1, 14566.18),
('m', '1996-12-12', '2010-12-18 19:37:45', 1, 9566.20),
('m', '2000-07-18', '2009-07-22 19:37:45', 0.95, 12566.18),
('m', '1989-12-22', '2014-06-26 19:37:45', 1, 1123.30),
('m', '1978-04-24', '2011-01-25 19:37:45', 1.1, -4566.18),
('f', '1995-03-12', '2010-05-21 19:37:45', 1, 0),
('m', '1998-11-08', '2009-08-15 19:37:45', 1, 24500.18),
('f', '1982-09-15', '2010-09-11 19:37:45', 0.95, 1789.18),
('m', '1975-12-27', '2011-07-27 19:37:45', 1, 16566.00),
('m', '1977-07-27', '2013-02-22 19:37:45', 1, 11111.18),
('m', '1978-04-07', '2014-08-28 19:37:45', 1, 2345.95),
('m', '1989-08-15', '2016-04-15 19:37:45', 1, 547.18),
('m', '1998-06-28', '2017-07-07 19:37:45', 0.95, 9865.02),
('m', '1986-07-30', '2020-01-24 19:37:45', 0.9, 27652.00),
('m', '1987-11-13', '2018-03-05 19:37:45', 0.85, 37821.34),
('m', '1998-10-08', '2015-08-18 19:37:45', 1, 0),
('m', '2005-08-14', '2016-02-14 19:37:45', 1.1, -566.80),
('m', '2001-12-17', '2018-05-11 19:37:45', 0.9, 15321.18),
('f', '1995-08-27', '2019-09-19 19:37:45', 0.9, 8650.11),
('f', '1976-03-21', '2012-05-08 19:37:45', 0.95, 6566.32),
('f', '1986-12-25', '2016-07-03 19:37:45', 0.85, 21984.22),
('f', '1978-04-18', '2008-04-27 19:37:45', 0.95, 4689.00),
('m', '1969-02-16', '2020-07-14 19:37:45', 1, 7237.56),
('m', '1995-07-09', '2008-10-12 19:37:45', 1, 6596.50)
;

-- Структура таблицы 7 "Акции / скидки" 

DROP TABLE IF EXISTS discounts;
CREATE TABLE discounts (
  id SERIAL PRIMARY KEY,
  annotation TEXT,
  district_name VARCHAR(100),
  my_type VARCHAR(100),
  district_discount DECIMAL(3,2) unsigned default 1.00 COMMENT 'Величина скидки по району от 0.00 до 1.00',
  type_discount DECIMAL(3,2) unsigned default 1.00 COMMENT 'Величина скидки по типу ячейки от 0.00 до 1.00',
  started_at DATETIME,
  finished_at DATETIME,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY index_of_district_name(district_name),
  KEY index_of_type_id(my_type),
  FOREIGN KEY (district_name) REFERENCES districts(d_name),
  FOREIGN KEY (my_type) REFERENCES my_types(t_title)
);

INSERT INTO discounts (my_type, type_discount, started_at, finished_at, annotation) values
('40 DV', 0.9, '2010-01-01', '2030-12-31', 'Коррект'),
('40 HS', 1, '2010-01-01', '2030-12-31', 'Дефолт'),
('20 DC', 0.85, '2010-01-01', '2030-12-31', 'Коррект'),
('20 HC', 1, '2010-01-01', '2030-12-31', 'Дефолт'),
('10 GP', 1, '2010-01-01', '2030-12-31', 'Дефолт'),
('10 HC', 1, '2010-01-01', '2030-12-31', 'Дефолт')
;

INSERT INTO discounts (district_name, district_discount, started_at, finished_at, annotation) values
('Адмиралтейский', 0.95, '2010-01-01', '2030-12-31', 'Район'),
('Выборгский', 0.90, '2010-01-01', '2030-12-31', 'Район'),
('Красногвардейский', 1.00, '2010-01-01', '2030-12-31', 'Район'),
('Петроградский', 0.95, '2010-01-01', '2030-12-31', 'Район'),
('Приморский', 1.00, '2010-01-01', '2030-12-31', 'Район')
;

-- Структура таблицы 8 "Базовая стоимость аренды ячейки" 

DROP TABLE IF EXISTS costs;
CREATE TABLE costs (
	id SERIAL PRIMARY key,
	my_type VARCHAR(100),
	type_cost int unsigned,
	FOREIGN KEY (my_type) REFERENCES my_types(t_title)
);

INSERT INTO costs (my_type, type_cost) values
('40 DV', 12000),
('40 HS', 14000),
('20 DC', 7000),
('20 HC', 8000),
('10 GP', 3000),
('10 HC', 4000)
;

-- Структура таблицы 9 "Прайс с учётом скидок и акций"

DROP TABLE IF EXISTS price;
CREATE TABLE price (
	id SERIAL PRIMARY key,
	my_dist VARCHAR(100),
	my_list VARCHAR(100),
	price_type_cost int unsigned default 0,
	price_type_discount DECIMAL(3,2) unsigned default 1.00,
	price_district_discount DECIMAL(3,2)unsigned default 1.00,
	total_discount DECIMAL(3,2) unsigned default 1.00,
	total_cost int unsigned default 0,
	total_day_cost DECIMAL(7,2) default 0,
	FOREIGN KEY (my_list) REFERENCES my_types(t_title),
	FOREIGN KEY (my_dist) REFERENCES districts(d_name)
);

insert into price(my_dist, my_list, price_type_cost, price_type_discount, price_district_discount)
	select
		l.l_dist,
		l.l_name,
		c.type_cost,
		d1.type_discount,
		d2.district_discount 
	from list l 
	join costs c 
		on l.l_name = c.my_type
	join discounts d1
		on l.l_name = d1.my_type
	join discounts d2
		on l.l_dist = d2.district_name
	order by l.l_dist
;  

update price set total_discount = price_type_discount * price_district_discount;
update price set total_cost = price_type_cost * total_discount;
update price set total_day_cost = total_cost / (SELECT DAY(LAST_DAY(now()))); -- 'Стоимость посуточной аренды в текущем месяце'


-- Структура таблицы 10 "Таблица аренды" 

DROP TABLE IF EXISTS rents;
CREATE TABLE rents (
	id SERIAL PRIMARY key,
	profile_id bigint unsigned,
	list_id bigint unsigned,
	start_rent date,
	end_rent date,
	day_limit int,
	FOREIGN KEY (profile_id) REFERENCES profiles(id),
	FOREIGN KEY (list_id) REFERENCES list(id)
);

insert into rents (profile_id, list_id, start_rent) values
(1, 5, CURDATE()),
(2, 3, CURDATE()),
(3, 1, CURDATE()),
(4, 4, CURDATE()),
(5, 2, CURDATE()),
(6, 8, CURDATE()),
(7, 14, CURDATE()),
(8, 7, CURDATE()),
(9, 6, CURDATE()),
(10, 19, CURDATE()),
(11, 9, CURDATE()),
(12, 11, CURDATE()),
(13, 22, CURDATE()),
(14, 10, CURDATE()),
(15, 17, CURDATE()),
(16, 12, CURDATE()),
(17, 24, CURDATE()),
(18, 13, CURDATE()),
(19, 15, CURDATE()),
(20, 18, CURDATE());

update rents set end_rent = date_add(start_rent , interval 
	((select balance from profiles where id = rents.profile_id) 
	/ ((select total_day_cost from price where id = rents.list_id) 
	* (select user_discount from profiles where id = rents.profile_id))) day);

update rents set day_limit = DATEDIFF(end_rent, start_rent);

update list set l_rent = 1 where id in (select list_id from rents);

-- Представления

CREATE or REPLACE VIEW user_rent
as
	select 
		u.id,
		u.firstname,
		u.lastname, 
		u.phone,
		p.balance,
		r.day_limit
	from users u
	join profiles p
	on u.id = p.id
	join rents r
	on u.id = r.profile_id
	order by p.balance desc;
	
SELECT * from user_rent;



