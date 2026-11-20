# SET 1 Retail Order Fulfilment System – MySQL

## Assignment Overview

The **Retail Order Fulfilment System** is a MySQL database project designed to manage products, customers, orders, stock availability, and order follow-ups.

This project demonstrates important MySQL concepts such as Views, Stored Procedures, Stored Functions, Cursors, Transactions, Exception Handling, and Business Error Handling using `SIGNAL SQLSTATE`.

## Technologies Used

- Database: MySQL
- Tool: MySQL Workbench
- Language: SQL

## Database Name

`RetailDB`

## Database Tables

| Table Name | Description |
|---|---|
| Products | Stores product details, price, stock, and supplier information. |
| Customers | Stores customer information. |
| Orders | Stores customer order details and order status. |
| Order_Items | Stores products and quantities associated with orders. |
| Follow_ups | Stores follow-up records for delayed pending orders. |

## Assignment Structure

```text
Retail_Order_Fulfilment/
│
├── table_creation.sql
├── seed_data.sql
├── views.sql
├── procedures.sql
├── cursor.sql
├── task5.sql
└── README.md
```

## Tasks Implemented

### Task 1: Views

**Objective:** Create views to display order information and identify low-stock products.

**Implementation:**
- Created `vw_order_summary` to display order and customer details without exposing cost price and supplier information.
- Created `vw_low_stock` to identify products whose quantity is at or below the reorder level.
- Created `vw_available_products` as an updatable view using `WITH CHECK OPTION`.

**Concepts Used:**
- CREATE VIEW
- SELECT
- WHERE
- WITH CHECK OPTION
- UPDATE

### Task 2: Stored Procedure with Transaction

**Objective:** Create a stored procedure named `sp_place_order` to place customer orders.

**Implementation:**
- Accepts customer ID, product ID, and quantity using IN parameters.
- Returns the generated order ID using an OUT parameter.
- Checks product stock availability.
- Inserts a new order and order item.
- Updates product stock.
- Uses a transaction to ensure all operations succeed together.
- Uses an exception handler to perform ROLLBACK if an SQL error occurs.

**Concepts Used:**
- Stored Procedure
- IN and OUT Parameters
- START TRANSACTION
- COMMIT
- ROLLBACK
- Exception Handler
- RESIGNAL

### Task 3: Stored Function

**Objective:** Create a function named `fn_order_total_with_tax` to calculate the total order amount including 18% tax.

**Implementation:**
- Calculates the total using quantity multiplied by unit price.
- Adds 18% tax to the order total.
- Returns the calculated amount.
- Uses the function inside a SELECT statement.

**Concepts Used:**
- CREATE FUNCTION
- RETURN
- SUM()
- SELECT
- Stored Function

### Task 4: Cursor and Set-Based Approach

**Objective:** Identify pending orders that are more than three days old and insert follow-up records.

**Cursor Implementation:**
- Declares a cursor to retrieve eligible pending orders.
- Uses OPEN to open the cursor.
- Uses FETCH to retrieve orders one by one.
- Uses a NOT FOUND handler to identify the end of the cursor.
- Inserts follow-up records into the Follow_ups table.
- Uses CLOSE to close the cursor.

**Set-Based Implementation:**
- Uses `INSERT INTO ... SELECT` to insert follow-up records for all eligible orders in a single SQL statement.
- Uses `NOT EXISTS` to prevent duplicate follow-up records.

**Concepts Used:**
- CURSOR
- DECLARE
- OPEN
- FETCH
- CLOSE
- NOT FOUND Handler
- INSERT INTO SELECT
- NOT EXISTS

### Task 5: Business Error Handling

**Objective:** Raise custom business errors using `SIGNAL SQLSTATE '45000'`.

**Implementation:**
Created `sp_check_stock` to validate product stock.

It raises custom errors for:
- Invalid quantity.
- Product not found.
- Insufficient stock.

If the stock is sufficient, it displays `Stock Available`.

**Concepts Used:**
- SIGNAL
- SQLSTATE '45000'
- MESSAGE_TEXT
- IF / ELSEIF
- Stored Procedure

## Important Comparisons

### Function vs Stored Procedure
### Cursor vs Set-Based Approach


## Execution Order

Execute the SQL files in the following order in MySQL Workbench:

1. `table_creation.sql` – Create the database and tables.
2. `seed_data.sql` – Insert sample records.
3. `views.sql` – Create and test views.
4. `procedures.sql` – Create and test the order placement procedure and function.
5. `cursor.sql` – Create and test cursor-based and set-based follow-ups.
6. `task5.sql` – Create and test custom business errors.

## Conclusion

The Retail Order Fulfilment System demonstrates how MySQL can be used to manage retail operations efficiently. It covers database creation, data manipulation, views, stored programs, transaction management, cursor processing, and error handling.
