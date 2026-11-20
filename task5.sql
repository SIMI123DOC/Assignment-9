Task 5: Raise a Business Error Using SIGNAL SQLSTATE '45000'


1. Create the stored procedure

USE RetailDB;

DELIMITER //

CREATE PROCEDURE sp_check_stock(
    IN p_product_id INT,
    IN p_quantity INT
)
BEGIN
    DECLARE v_stock INT;

    SELECT COALESCE(
        (SELECT quantity
         FROM Products
         WHERE product_id = p_product_id),
        -1
    )
    INTO v_stock;

    IF p_quantity <= 0 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid quantity';

    ELSEIF v_stock = -1 THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product not found';

    ELSEIF v_stock < p_quantity THEN

        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient stock available';

    ELSE

        SELECT 'Stock Available' AS Message;

    END IF;

END //

DELIMITER ;


2. Test the procedure

Case 1:

Valid product and sufficient stock

CALL sp_check_stock(101, 2);

Expected output:

Success
Stock Available

Case 2: Insufficient stock

CALL sp_check_stock(101, 100);

Expected error:

ERROR 1644 (45000): Insufficient stock available

Case 3: Invalid quantity

CALL sp_check_stock(101, -5);

Expected error:

ERROR 1644 (45000): Invalid quantity

Case 4: Product does not exist

CALL sp_check_stock(999, 2);

Expected error:

ERROR 1644 (45000): Product not found

--Explanation
- SIGNAL is used to generate an error manually.
- SQLSTATE '45000' represents a user-defined exception in MySQL.
- MESSAGE_TEXT specifies the error message displayed to the caller.
- When the procedure encounters SIGNAL, execution stops and MySQL returns the error to the caller.