/*
1. Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, 
который больше всех общался с выбранным пользователем (написал ему сообщений).
2. Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
3. Определить кто больше поставил лайков (всего): мужчины или женщины.
*/

#Задача №1
-- Берём пользователя №1

SELECT count(*) AS activity, from_user_id AS id FROM messages WHERE to_user_id = 1 GROUP BY from_user_id ORDER BY activity DESC;

# больше всего сообщений нашему пользователю написал пользователь с id = 8.


#Задача №2
-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

# У нас в базе vk лайки получают media, которые выложены отдельными пользователями.

SELECT user_id FROM profiles WHERE birthday > (NOW() - interval 10 year); -- пользователи младше 10 лет в таблице profiles

SELECT id AS med_id FROM media WHERE user_id IN 
	(SELECT user_id FROM profiles WHERE birthday > (NOW() - interval 10 year)); -- медиа, которые выложены этими пользователями
	
SELECT id, media_id FROM likes WHERE media_id IN 
	(SELECT id AS m_id FROM media WHERE user_id IN 
	(SELECT user_id FROM profiles WHERE birthday > (NOW() - interval 10 year))); -- медиа, которые получили лайки

SELECT count(*) FROM likes WHERE media_id IN 
	(SELECT id AS m_id FROM media WHERE user_id IN 
	(SELECT user_id FROM profiles WHERE birthday > (NOW() - interval 10 year))); -- количество лайков = 3. 

#Подскажите пожалуйста, верно ли я понял задачу и логику решения?
	
#Задача №3	
	
SELECT count(*), gender FROM profiles WHERE user_id IN
(SELECT user_id FROM likes WHERE media_id IN 
	(SELECT id AS m_id FROM media WHERE user_id IN 
	(SELECT user_id FROM profiles WHERE birthday > (NOW() - interval 10 year)))) GROUP BY gender; -- 2 лайка = f и 1 лайк = m.


#Задачи к уроку №6 решал без JOIN, но подозреваю ) , что с JOIN решение было бы намного проще и быстрее.
#Этот момент буду разбирать в домашнем задании №7. 
#Тема одна и та же, сложные запросы, поэтому рассчитываю, что JOIN разберу подробно.

	