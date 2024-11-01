CREATE TABLE customer (
	id SERIAL PRIMARY KEY,
	name VARCHAR(30),
	address VARCHAR(60),
	phone VARCHAR(20)
);

CREATE TABLE drinks (
	name VARCHAR(20) PRIMARY KEY,
	price DECIMAL(8,2)
);

CREATE TABLE sizes (
	name VARCHAR(20) PRIMARY KEY,
	price DECIMAL(8,2)
);

CREATE TABLE toppings (
	name VARCHAR(20) PRIMARY KEY
);

CREATE TABLE credit_card (
	id SERIAL PRIMARY KEY,
	name VARCHAR(30),
	number BIGINT UNIQUE,
	expiration DATE
);

CREATE TABLE customer_credit_card (
	customer_id INT,
	credit_card_id INT,
	
	FOREIGN KEY (customer_id) REFERENCES customer (id),
	FOREIGN KEY (credit_card_id) REFERENCES credit_card (id)
);

CREATE TABLE customer_order (
	id SERIAL PRIMARY KEY,
	customer_id INT,
	credit_card_id INT,
	total_price DECIMAL(8,2),
	
	FOREIGN KEY (customer_id) REFERENCES customer (id),
	FOREIGN KEY (credit_card_id) REFERENCES credit_card (id)
);

CREATE TABLE customer_order_preference (
	customer_id INT,
	customer_order_id INT,
	
	FOREIGN KEY (customer_id) REFERENCES customer (id),
	FOREIGN KEY (customer_order_id) REFERENCES customer_order (id)
);

CREATE TABLE customer_drinks (
	customer_order_id INT,
	drink VARCHAR(20),
	
	FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
	FOREIGN KEY (drink) REFERENCES drinks (name)
);

CREATE TABLE pizzas (
	id SERIAL PRIMARY KEY,
	size VARCHAR(20),
	topping_1 VARCHAR(20),
	topping_2 VARCHAR(20),
	
	FOREIGN KEY (size) REFERENCES sizes (name),
	FOREIGN KEY (topping_1) REFERENCES toppings (name),
	FOREIGN KEY (topping_2) REFERENCES toppings (name)
);

CREATE TABLE customer_pizzas (
	customer_order_id INT,
	pizza_id INT,
	
	FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
	FOREIGN KEY (pizza_id) REFERENCES pizzas (id)
);