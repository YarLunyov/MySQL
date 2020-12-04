#Задача №1
/*
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте
транзакции.
*/
# Основа решения

start transaction;

INSERT into sample.users 
select * from shop.users where id = 1;

commit;

#Решение с защитами и информацией об ошибках

drop procedure if exists `copy_users`;

delimiter $$

create procedure `copy_users` (out tran_result varchar(200))
begin
	declare `_rollback` bool default 0;
	declare code varchar(100);
	declare error_string varchar(100);
	
	declare continue handler for sqlexception
	begin
		set `_rollback` = 1;
		get stacked diagnostics condition 1
			code = returned_sqlstate, error_string = message_text;
		set tran_result := CONCAT('Error occured. Code: ', code, '. Text: ', error_string); 
	end;

	start transaction;
		INSERT into sample.users (name, birthday_at, created_at, updated_at)
		select name, birthday_at, created_at, updated_at from shop.users where id = 1;

	if `_rollback` then
		rollback;
	else
		set tran_result := 'ok';
		commit;
	end if;
END$$

delimiter ;

call copy_users(@tran_result);

SELECT @tran_result;


#Задача №2
/*
Создайте представление, которое выводит название name товарной позиции из таблицы
products и соответствующее название каталога name из таблицы catalogs.
*/

CREATE or REPLACE VIEW view_name
as
	select 
		p.name as products, -- from products p
		c.name as catalogs
	from products p
	join catalogs c
	on p.catalog_id = c.id;
	
SELECT * from view_name;

#Задача №3
/*
по желанию) Пусть имеется таблица с календарным полем created_at. В ней размещены
разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и
2018-08-17. Составьте запрос, который выводит полный список дат за август, выставляя в
соседнем поле значение 1, если дата присутствует в исходном таблице и 0, если она
отсутствует.
*/

drop table if exists august;
create table august (
	id serial primary key,
	day_at DATE COMMENT 'Разреженные даты'
);

INSERT into august (day_at) values
	('2018-08-01'),
	('2018-08-04'),
	('2018-08-16'),
	('2018-08-17');
	
drop procedure if exists `filldates`;

delimiter $$

CREATE PROCEDURE `filldates`(dateStart DATE, dateEnd DATE)
BEGIN
DECLARE adate date;

    WHILE dateStart <= dateEnd DO
        SET adate = (SELECT date_at FROM my_dates WHERE date_at = dateStart);
        IF adate IS NULL THEN BEGIN
           INSERT INTO my_dates (date_at) VALUES (dateStart);
        END; END IF;
        SET dateStart = date_add(dateStart, INTERVAL 1 DAY);
    END WHILE;
END$$

delimiter ;

start transaction;

drop table if exists my_dates;
create table my_dates (
	date_at DATE COMMENT 'Даты за август 2018 г.'
);

CALL filldates('2018-08-01','2018-08-31');

ALTER table my_dates ADD COLUMN num_id bit default 0;
update my_dates set num_id = 1 where date_at in (select day_at from august);
SELECT * from my_dates;

commit;


