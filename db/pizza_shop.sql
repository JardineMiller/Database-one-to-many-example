DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
  id SERIAL8 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255)
);

CREATE TABLE orders (
  id SERIAL8 PRIMARY KEY,
  customer_id INT4 REFERENCES customers(id),
  topping VARCHAR(255),
  quantity INT
);