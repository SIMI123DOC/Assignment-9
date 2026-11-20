Part A: Cursor-based procedure


USE RetailDB;

DELIMITER //

CREATE PROCEDURE sp_pending_order_followups()
BEGIN

    DECLARE v_order_id INT;
    DECLARE v_done INT DEFAULT 0;

    -- Step 1: Declare cursor
    DECLARE order_cursor CURSOR FOR
        SELECT order_id
        FROM Orders
        WHERE status = 'Pending'
        AND order_date < CURDATE() - INTERVAL 3 DAY;

    -- Step 2: Declare NOT FOUND handler
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET v_done = 1;

    -- Step 3: Open cursor
    OPEN order_cursor;

    read_loop: LOOP

        -- Step 4: Fetch one order at a time
        FETCH order_cursor INTO v_order_id;

        -- Step 5: Stop when no records are available
        IF v_done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- Step 6: Insert follow-up record
        INSERT INTO Follow_ups(
            order_id,
            followup_date,
            remarks
        )
        VALUES(
            v_order_id,
            CURDATE(),
            'Order pending for more than 3 days'
        );

    END LOOP;

    -- Step 7: Close cursor
    CLOSE order_cursor;

END //

DELIMITER ;


-- Execute procedure
CALL sp_pending_order_followups();

-- Display follow-up records
SELECT * FROM Follow_ups;


Part B: Set-based statement



USE RetailDB;

INSERT INTO Follow_ups(
    order_id,
    followup_date,
    remarks
)
SELECT
    order_id,
    CURDATE(),
    'Order pending for more than 3 days'
FROM Orders
WHERE status = 'Pending'
AND order_date < CURDATE() - INTERVAL 3 DAY
AND NOT EXISTS (
    SELECT 1
    FROM Follow_ups f
    WHERE f.order_id = Orders.order_id
);

-- Display follow-up records
SELECT * FROM Follow_ups;
