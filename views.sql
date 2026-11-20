--Task 1 Views

Requirements: Create vw_order_summary, vw_low_stock and an updatable view with WITH CHECK OPTION.


USE RetailDB;

-- VIEW 1: Order Summary
-- Hides cost_price and supplier

CREATE VIEW vw_order_summary AS
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.status,
    p.product_name,
    oi.quantity,
    oi.unit_price,
    (oi.quantity * oi.unit_price) AS total_amount
FROM Orders o
JOIN Customers c
    ON o.customer_id = c.customer_id
JOIN Order_Items oi
    ON o.order_id = oi.order_id
JOIN Products p
    ON oi.product_id = p.product_id;


-- VIEW 2: Low Stock

CREATE VIEW vw_low_stock AS
SELECT
    product_id,
    product_name,
    quantity,
    reorder_level
FROM Products
WHERE quantity <= reorder_level;


-- VIEW 3: Updatable View with CHECK OPTION

CREATE VIEW vw_available_products AS
SELECT
    product_id,
    product_name,
    category,
    quantity,
    price
FROM Products
WHERE quantity > 0
WITH CHECK OPTION;


-- Display Views

SELECT * FROM vw_order_summary;

SELECT * FROM vw_low_stock;

SELECT * FROM vw_available_products;


-- Demonstrate Updatable View

UPDATE vw_available_products
SET quantity = 8
WHERE product_id = 101;


-- This fails because quantity = 0 violates CHECK OPTION

UPDATE vw_available_products
SET quantity = 0
WHERE product_id = 101;
