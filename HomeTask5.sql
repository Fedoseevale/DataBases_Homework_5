-- Создаём базу данных
DROP DATABASE IF EXISTS HomeTask5;
CREATE DATABASE HomeTask5;
USE HomeTask5;

-- Создаём таблицу с автомобилями
CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

-- Заполняем таблицу с автомобилями
INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    
SELECT * FROM cars;


/* Задание 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов 
CREATE VIEW CheapCars AS SELECT Name FROM Cars WHERE Cost<25000 */

DROP VIEW IF EXISTS cheap_cars;
CREATE VIEW cheap_cars
  AS SELECT * 
	  FROM cars
      WHERE cost < 25000;
      
SELECT * FROM cheap_cars;


/* Задание 2. Изменить в существующем представлении порог для стоимости: пусть цена будет 
до 30 000 долларов (используя оператор ALTER VIEW) ALTER VIEW CheapCars AS SELECT 
Name FROM CarsWHERE Cost<30000 */

ALTER VIEW cheap_cars
 AS SELECT * 
	  FROM cars
      WHERE cost < 30000;

SELECT * FROM cheap_cars;


/* Задание 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди” */


DROP VIEW IF EXISTS cheap_cars;
CREATE VIEW cheap_cars
 AS SELECT * 
	  FROM cars
      WHERE name in ('Skoda', 'Audi');
	
SELECT * FROM cheap_cars;


/* Задание 4. Добавьте новый столбец под названием «время до следующей станции». 
Чтобы получить это значение, мы вычитаем время станций для пар смежных станций. 
Мы можем вычислить это значение без использования оконной функции SQL, 
но это может быть очень сложно. Проще это сделать с помощью оконной функции
LEAD. Эта функция сравнивает значения из одной строки со следующей строкой, 
чтобы получить результат. В этом случае функция сравнивает значения в столбце «время» 
для станции со станцией сразу после нее.*/

-- Создаём таблицу
DROP TABLE IF EXISTS train_routs;
CREATE TABLE train_routs 
(       
	train_id int unsigned NOT NULL,
	station VARCHAR(20), 
	station_time TIME
);

-- Заполняем таблицу
INSERT INTO train_routs (train_id, station,	station_time)
VALUES (110, 'San Francisco', '10:00:00'),
       (110, 'Redwood City', '10:54:00'),
       (110, 'Palo Alto', '11:02:00'),
       (110, 'San Jose', '12:35:00'),
	   (120, 'San Francisco', '11:00:00'),
       (120, 'Palo Alto', '12:49:00'),
       (120, 'San Jose', '13:30:00');

SELECT * FROM train_routs;

SELECT *,
  LEAD (station_time) OVER (PARTITION BY train_id ORDER BY station_time) AS lead_1,
  timediff(LEAD (station_time) OVER (PARTITION BY train_id ORDER BY station_time), station_time) AS time_to_next_station
  FROM train_routs;





