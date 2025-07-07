select * from inventories;
select * from Productsmovement;

-- TO store logs
CREATE TABLE audit_logs(
log_id INT PRIMARY KEY AUTO_INCREMENT,
action_type VARCHAR(15),
table_name VARCHAR(20),
action_description TEXT,
user_name VARCHAR(20),
action_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

SELECT * FROM audit_logs;

-- DROP TRIGGER IF EXISTS auto_update_inventory;

-- To Update the inventory when after inserting a new row in Productsmovement
DELIMITER //
CREATE TRIGGER auto_update_inventory
AFTER INSERT ON Productsmovement
FOR EACH ROW
BEGIN 
    DECLARE current_quantity int;
    SELECT 	quantity_in_stock INTO current_quantity FROM inventories
    WHERE product_id = new.product_id AND warehouse_id = new.warehouse_id;
    
    IF LOWER(new.movement_type) = "shipped" THEN
        UPDATE inventories 
        SET quantity_in_stock = (current_quantity - new.quantity)
        WHERE product_id = new.product_id AND warehouse_id = new.warehouse_id;
	ELSEIF LOWER(new.movement_type) = "received" THEN
        UPDATE inventories
        SET quantity_in_stock = (current_quantity + new.quantity)
        WHERE product_id = new.product_id AND warehouse_id = new.warehouse_id;
	END IF;
END;
//
DELIMITER ;

-- To Place a order
DELIMITER //

DROP PROCEDURE IF EXISTS Place_order;

CREATE PROCEDURE Place_order(
IN in_customer_id INT,
IN in_product_id INT,
IN in_quantity INT, 
IN in_supplier_id INT
)   
BEGIN 
    DECLARE available_stock INT;
    DECLARE stock_warehouse_id INT;
    
    SELECT quantity_in_stock, warehouse_id INTO available_stock, stock_warehouse_id FROM inventories
    WHERE product_id = in_product_id LIMIT 1;

    IF in_quantity > available_stock THEN
        INSERT INTO audit_logs(action_type, table_name, action_description, user_name)
        VALUES('Order Blocked', 'Orders', CONCAT('insufficient stock for ',in_product_id, ' in', stock_warehouse_id), CURRENT_USER());
	ELSE
        INSERT INTO Orders (product_id, customer_id, supplier_id, order_status)
        VALUES (in_product_id, in_customer_id, in_supplier_id, 'Pending');
        
        UPDATE inventories
        SET quantity_in_stock = available_stock - in_quantity
        WHERE product_id = in_product_id AND warehouse_id = stock_warehouse_id;
		
        INSERT INTO audit_logs(action_type, table_name, action_description, user_name)
        VALUES('Order Placed', 'Orders', CONCAT('New order placed for ',in_customer_id), CURRENT_USER());
        
	END IF;
END;
//
DELIMITER ;

-- To add the logs when the inventory table is updated
DELIMITER //
CREATE TRIGGER log_inventory
AFTER UPDATE ON inventories
FOR EACH ROW
BEGIN
    INSERT INTO audit_logs(action_type, table_name, action_description, user_name)
    VALUES('UPDATE','inventories',CONCAT('Stock changed for ',NEW.product_id,' in Warehouse ', 
           NEW.warehouse_id, ' from ',OLD.quantity_in_stock,' to ', NEW.quantity_in_stock), CURRENT_USER());
END;
//
DELIMITER ;

-- To view the products and its quantities
CREATE VIEW product_quantity AS
SELECT product_id, SUM(quantity_in_stock) AS total_stock FROM inventories
GROUP BY product_id;

SELECT * FROM product_quantity;
