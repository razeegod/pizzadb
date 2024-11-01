INSERT INTO customer ("name", address, phone)
VALUES ('Иван Иванов', 'г.Москва, ул.Пушкина, 1', '+7 (999)-999-99-99'),
	('Петр Петров', 'г.Москва, ул.Есенина, 3', '+7 (999)-999-99-88'),
	('Федор Федоров', 'г.Москва, ул.Автомобилистов, 31', '+7 (999)-999-88-88'),
	('Алексей Алексеев', 'г.Москва, ул.Маяковского, 15', '+7 (999)-888-88-88'),
	('Денис Денисенко', 'г.Москва, ул.Вязов, 66', '+7 (999)-999-99-66'),
	('Максим Лещенко', 'г.Москва, ул.Певцов, 12', '+7 (999)-999-51-11');

INSERT INTO credit_card ("name", "number", expiration)
VALUES ('Иван Иванов', 1234123412341234, '01-09-2027'),
	('Петр Петров', 4321123531341234, '01-09-2026'),
	('Федор Федоров', 1234741845341234, '01-03-2025'),
	('Алексей Алексеев', 1234174648561234, '01-06-2025'),
	('Денис Денисенко', 7684257412341234, '01-12-2026'),
	('Максим Лещенко', 1234195467312346, '01-10-2027');
	
INSERT INTO drinks ("name", price)
VALUES ('Sprite', 159.00),
	('Coca-Cola', 159.00),
	('Сок Добрый', 199.00),
	('Fanta', 159.00),
	('Everless Cola', 119.00),
	('Морс Брусничный', 99.00);
	
INSERT INTO sizes ("name" , price)
VALUES ('Большая XXL 40см', 1249.00),
	('Большая 35см', 999.00),
	('Средняя 30см', 749.00),
	('Маленькая 25см', 579.00);

INSERT INTO toppings ("name")
VALUES ('Халапеньо'),
	('Сыр Чеддер'),
	('Сыр Моцарелла'),
	('Шампиньоны'),
	('Митболы'),
	('Креветки'),
	('Цыпленок');
	
INSERT INTO customer_credit_card (customer_id, credit_card_id)
SELECT c.id, cc.id
FROM customer c INNER JOIN credit_card cc USING(id);

-- INSERT INTO pizzas ("size", topping_1, topping_2)
-- SELECT s.name, t."name", t1."name" 
-- FROM sizes s, toppings t, toppings t1
-- ORDER BY s.name;

INSERT INTO pizzas ("size", topping_1, topping_2)
VALUES ('Маленькая 25см', 'Халапеньо', 'Цыпленок'),
	('Маленькая 25см', 'Шампиньоны', 'Цыпленок'),
	('Маленькая 25см', 'Митболы', 'Цыпленок'),
	('Средняя 30см', 'Сыр Чеддер', 'Сыр Моцарелла'),
	('Средняя 30см', 'Креветки', 'Митболы'),
	('Средняя 30см', 'Халапеньо', 'Цыпленок'),
	('Большая 35см', 'Сыр Моцарелла', 'Сыр Чеддер'),
	('Большая 35см', 'Сыр Моцарелла', 'Цыпленок'),
	('Большая 35см', 'Халапеньо', 'Цыпленок'),
	('Большая XXL 40см', 'Сыр Чеддер', 'Цыпленок');

INSERT INTO customer_order (customer_id, credit_card_id, total_price, order_date)
VALUES (1, 1, 1896.00, '2024-09-02'),
	(2, 2, 1408.00, '2024-09-12'),
	(3, 3, 2316.00, '2024-09-22'),
	(4, 4, 1527.00, '2024-10-04'),
	(5, 5, 3255.00, '2024-10-16'),
	(6, 6, 1867.00, '2024-10-28');

INSERT INTO customer_order_preference (customer_id, customer_order_id)
SELECT c.id, cc.id
FROM customer c INNER JOIN customer_order cc USING(id);

INSERT INTO customer_pizzas (customer_order_id, pizza_id)
VALUES (1, 1),
	(1, 7),
	(2, 10),
	(3, 8),
	(3, 9),
	(4, 5),
	(4, 3),
	(5, 7),
	(5, 8),
	(5, 9),
	(6, 8),
	(6, 6);

INSERT INTO customer_drinks (customer_order_id, drink)
VALUES (1, 'Sprite'),
	(1, 'Fanta'),
	(2, 'Coca-Cola'),
	(3, 'Sprite'),
	(3, 'Sprite'),
	(4, 'Сок Добрый'),
	(3, 'Sprite'),
	(5, 'Coca-Cola'),
	(5, 'Морс Брусничный'),
	(6, 'Everless Cola');