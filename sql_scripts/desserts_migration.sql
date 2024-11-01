CREATE TABLE desserts (
	name VARCHAR(40) PRIMARY KEY,
	price DECIMAL(8,2)
);


CREATE TABLE customer_desserts (
	customer_order_id INT,
	dessert VARCHAR(40),
	amount INT,
	
	FOREIGN KEY (customer_order_id) REFERENCES customer_order (id),
	FOREIGN KEY (dessert) REFERENCES desserts (name)
);
