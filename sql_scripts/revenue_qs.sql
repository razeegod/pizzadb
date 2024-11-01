
SELECT --общая выручка
	SUM(co.total_price)
FROM 
	customer_order co 
WHERE 
	order_date BETWEEN '2024-09-01' AND '2024-09-30';

--Выручка за период для пицц
SELECT 
	SUM(s.price) AS Сумма
FROM
	customer_order co 
	INNER JOIN customer_pizzas cp ON co.id = cp.customer_order_id 
	INNER JOIN pizzas p ON cp.pizza_id = p.id 
	INNER JOIN sizes s ON p."size" = s."name" 
WHERE
	co.order_date BETWEEN '2024-09-01' AND '2024-09-30';
	

--Выручка за период для напитков
SELECT 
	SUM(d.price) AS Сумма
FROM
	customer_order co 
	INNER JOIN customer_drinks cd ON co.id = cd.customer_order_id 
	INNER JOIN drinks d ON cd.drink = d."name" 
WHERE
	co.order_date BETWEEN '2024-09-01' AND '2024-09-30';
	

--SELECT 
--	cp.customer_order_id, s.name, s.price
--FROM
--	customer_order co 
--	JOIN customer_pizzas cp ON co.id = cp.customer_order_id 
--	JOIN  pizzas p ON cp.pizza_id = p.id 
--	JOIN sizes s ON p."size" = s."name" 
--WHERE
--	co.order_date BETWEEN '2024-10-01' AND '2024-10-30';