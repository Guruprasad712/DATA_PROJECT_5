SELECT @@autocommit;
SET autocommit = 0;

SELECT * FROM audit_logs;

-- To test the trigger 'auto_update_inventory'
START TRANSACTION;
SELECT * FROM inventories
WHERE product_id = 1 AND warehouse_id = 1;

INSERT INTO productsmovement(product_id, warehouse_id, shipment_id, movement_type, quantity)
VALUES(1,1,1,"Received",200);

SELECT * FROM productsmovement 
ORDER BY movement_id DESC;
ROLLBACK;

-- To test the procedure 'Place_order'
START TRANSACTION;
SELECT * FROM inventories;
SELECT * from orders;
SELECT * FROM customers;
SELECT * FROM suppliers;

CALL Place_order(3, 1, 30, 1); 

CALL Place_order(3, 1, 1000, 1); -- Order should fail

SELECT * FROM audit_logs order by log_id desc;

SELECT * FROM orders ORDER BY order_date DESC limit 1;
ROLLBACK;

-- To test the trigger 'log_entry'
START TRANSACTION;
UPDATE inventories
SET quantity_in_stock = 1000 
WHERE product_id = 1;
ROLLBACK;

SELECT * FROM product_quantity;

SET autocommit = 1;