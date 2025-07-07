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
