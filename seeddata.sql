
USE RetailDB;

-- Insert Products
INSERT INTO Products VALUES
(101, 'Laptop', 'Electronics', 10, 50000, 40000, 'Dell', 5),
(102, 'Mouse', 'Accessories', 3, 500, 300, 'HP', 5),
(103, 'Keyboard', 'Accessories', 15, 1000, 700, 'Logitech', 5),
(104, 'Monitor', 'Electronics', 2, 12000, 9000, 'Samsung', 5),
(105, 'Headphones', 'Accessories', 20, 2000, 1500, 'Sony', 5);

-- Insert Customers
INSERT INTO Customers VALUES
(1, 'Asha', 'asha@gmail.com'),
(2, 'Rahul', 'rahul@gmail.com'),
(3, 'Priya', 'priya@gmail.com'),
(4, 'Arun', 'arun@gmail.com'),
(5, 'Divya', 'divya@gmail.com');

-- Insert Orders
INSERT INTO Orders (customer_id, order_date, status)
VALUES
(1, '2026-11-10', 'Pending'),
(2, '2026-11-12', 'Delivered'),
(3, '2026-11-14', 'Pending'),
(4, '2026-11-15', 'Pending'),
(5, '2026-11-16', 'Shipped');

-- Insert Order Items
INSERT INTO Order_Items
(order_id, product_id, quantity, unit_price)
VALUES
(1, 101, 1, 50000),
(2, 102, 2, 500),
(3, 103, 1, 1000),
(4, 104, 1, 12000),
(5, 105, 2, 2000);

-- Verify
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM Order_Items;
SELECT * FROM Follow_ups;
