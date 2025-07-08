# 🗃️ Supply Chain ERP System – SQL Triggers, Procedures & Audit Logs

This project simulates an ERP-style Supply Chain Management system using **MySQL**. It includes a normalized database schema, stored procedures, triggers, audit logging, views, and test scripts. The system tracks suppliers, customers, warehouses, products, orders, inventory movements, and provides real-time stock tracking and transaction auditing.

---

## 🚀 Features

✅ **Normalized Supply Chain Schema**  
✅ **Inventory Auto-Update via Triggers**  
✅ **Order Placement with Stock Validation**  
✅ **Audit Logging for Inventory & Orders**  
✅ **Stored Procedures with Dynamic Logic**  
✅ **Rollback-safe Test Scripts**  
✅ **View for Product Stock Summary**

---

## 🛠️ Technologies Used

- **MySQL** 
- SQL Triggers (AFTER INSERT, AFTER UPDATE)
- Stored Procedures
- Audit Logging Table
- Views for aggregated inventory insights
- Transaction Testing Scripts

---

## 📁 Project Structure

```plaintext
sql-supplychain-erp/
├── SCM_DB_structure.sql      # Schema creation + data insertion
├── Backend_actions.sql       # Triggers, procedures, views, audit logging
├── SCM_action_test.sql       # Test scripts with transactions & rollback
```
---

## 📂 Database Schema Overview

| Table             | Description                            |
|------------------|----------------------------------------|
| `Suppliers`       | Supplier information                  |
| `Customers`       | Loyalty-based customer profiles        |
| `Products`        | Mapped to suppliers                    |
| `Orders` / `OrderDetails` | Core purchasing mechanism     |
| `Inventories`     | Stock by warehouse                     |
| `Warehouses`      | Global locations                       |
| `Shipments` / `products_movement` | Item movement tracking |
| `AuditLogs`       | Tracks CRUD activity                   |

---

## ⚙️ Core Functional Logic

### 🔹 Trigger: `auto_update_inventory`
Automatically updates stock in the `inventories` table when a row is inserted into `productmovements`.

```sql
IF LOWER(NEW.movement_type) = 'received' THEN
    UPDATE inventories 
    SET quantity_in_stock = quantity_in_stock + NEW.quantity
    WHERE product_id = NEW.product_id AND warehouse_id = NEW.warehouse_id;
ELSEIF LOWER(NEW.movement_type) = 'shipped' THEN
    UPDATE inventories 
    SET quantity_in_stock = quantity_in_stock - NEW.quantity
    WHERE product_id = NEW.product_id AND warehouse_id = NEW.warehouse_id;
END IF;
```
---

## 🔹 Procedure: `Place_order`

Validates stock availability, places an order, updates inventory, and logs the action.

```sql
IF in_quantity > available_stock THEN
    -- Block the order and log the failure
ELSE
    -- Place the order
    -- Deduct stock from inventories
    -- Log transaction in AuditLogs
END IF;
```

### 🔹 Trigger: `log_inventory`

Creates an entry in the `auditlogs` table every time stock is updated in the `inventories` table.

### 🔹 Trigger: `log_inventory`

Creates an entry in the `auditlogs` table every time stock is updated in the `inventories` table.

```sql
CREATE TRIGGER log_inventory
AFTER UPDATE ON inventories
FOR EACH ROW
BEGIN
    -- Insert audit trail capturing old and new stock values
    INSERT INTO auditlogs (...)
    VALUES (...);
END;
```
### 🔹 View: `product_quantity`

Summarizes total available stock by product using a SQL aggregation view.

```sql
CREATE VIEW product_quantity AS
SELECT product_id, 
       SUM(...) AS total_stock
FROM inventories
GROUP BY product_id;
```
## 🧪 Testing and Transactions

The test file (`SCM_SQL_test.sql`) includes transactional logic to validate system behavior across various edge cases.

- Uses `START TRANSACTION`, `ROLLBACK`, and `COMMIT`
- Includes visibility checks using `SELECT *` before and after actions

---

### ✅ Test Scenarios

- ✔️ Valid order placement  
- ❌ Order blocked due to insufficient stock  
- 🔄 Inventory updates triggered automatically  
- 🧾 Audit log created on stock changes

---

## 📈 Use Cases

- 🎓 Educational demonstration of SQL-based supply chain design  
- 🧮 Audit-proof enterprise workflow simulation  
- 📊 Backend simulation for BI tools like Power BI or Tableau  
  
---

## 🧠 Future Enhancements

- ⏱️ Add stored functions for real-time KPI calculations  
- 🐍 Integrate with Python for analytics and automation  
- 📊 Visualize stock and lead times with Power BI or Tableau  
- 🔐 Implement user roles and access control logic  
- ⚠️ Introduce robust error handling inside stored procedures  

---

## 👨‍💼 Author

**Guruprasad P**  
Aspiring Data & Supply Chain Analyst  
Passionate about analytics, and automation  

📧 Email: [guruprem2002@gmail.com](mailto:guruprem2002@gmail.com)  
🔗 LinkedIn: [linkedin.com/in/guruprasad2002](https://www.linkedin.com/in/guruprasad2002)

