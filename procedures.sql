TASK 2:  Stored Procedure: Place Order
Requirements: IN parameters, OUT parameter, stock validation, order insertion, stock update, transaction and rollback handler.



USE RetailDB;

DELIMITER //

CREATE PROCEDURE sp_place_order(
    IN p_customer_id INT,
    IN p_product_id INT,
    IN p_quantity INT,
    OUT p_order_id INT
)
BEGIN
    DECLARE v_stock INT;
    DECLARE v_price DECIMAL(10,2);

    -- Rollback if any SQL error occurs
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    -- Get product stock and price
    SELECT quantity, price
    INTO v_stock, v_price
    FROM Products
    WHERE product_id = p_product_id
    FOR UPDATE;

    -- Validate quantity
    IF p_quantity <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid quantity';
    END IF;

    -- Validate stock
    IF v_stock < p_quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock';
    END IF;

    -- Insert order
    INSERT INTO Orders(
        customer_id,
        order_date,
        status
    )
    VALUES(
        p_customer_id,
        CURDATE(),
        'Pending'
    );

    -- Get generated order ID
    SET p_order_id = LAST_INSERT_ID();

    -- Insert order items
    INSERT INTO Order_Items(
        order_id,
        product_id,
        quantity,
        unit_price
    )
    VALUES(
        p_order_id,
        p_product_id,
        p_quantity,
        v_price
    );

    -- Reduce product stock
    UPDATE Products
    SET quantity = quantity - p_quantity
    WHERE product_id = p_product_id;

    COMMIT;

END //

DELIMITER ;


-- CALL PROCEDURE

CALL sp_place_order(1, 101, 2, @order_number);

SELECT @order_number AS Generated_Order_ID;

-- Verify order
SELECT * FROM Orders;

SELECT * FROM Order_Items;

SELECT * FROM Products;

TASK 3 : Stored Function: Calculate Order Total With Tax

Requirement: Create fn_order_total_with_tax and use it inside SELECT.


USE RetailDB;

DELIMITER //

CREATE FUNCTION fn_order_total_with_tax(
    p_order_id INT
)
RETURNS DECIMAL(12,2)
NOT DETERMINISTIC
READS SQL DATA
BEGIN

    DECLARE v_total DECIMAL(12,2);

    SELECT COALESCE(SUM(quantity * unit_price), 0)
    INTO v_total
    FROM Order_Items
    WHERE order_id = p_order_id;

    RETURN v_total * 1.18;

END //

DELIMITER ;


-- Call Function Inside SELECT

SELECT
    order_id,
    fn_order_total_with_tax(order_id) AS total_with_tax
FROM Orders;

