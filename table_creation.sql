
CREATE DATABASE IF NOT EXISTS RetailDB;
USE RetailDB;

-- 1. Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    cost_price DECIMAL(10,2),
    supplier VARCHAR(100),
    reorder_level INT
);

-- 2. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

-- 3. Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(30),
    FOREIGN KEY (customer_id)
        REFERENCES Customers(customer_id)
);

-- 4. Order_Items Table
CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES Products(product_id)
);

-- 5. Follow_ups Table
CREATE TABLE Follow_ups (
    followup_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    followup_date DATE,
    remarks VARCHAR(200),
    FOREIGN KEY (order_id)
        REFERENCES Orders(order_id)
);

SHOW TABLES;
