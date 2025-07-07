CREATE DATABASE Supply_chain;
Use Supply_chain;

show tables;

-- Supplier Table
CREATE TABLE Suppliers(
supplier_id INT AUTO_INCREMENT PRIMARY KEY,
supplier_name VARCHAR(50),
region VARCHAR(20),
phone_number VARCHAR(20),
email VARCHAR(50)
);

Select * from Suppliers;

-- Customers Table
CREATE TABLE Customers(
customer_id INT AUTO_INCREMENT PRIMARY KEY,
customer_name VARCHAR(20),
cust_phone_number VARCHAR(20),
loyalty_status ENUM('Gold','Silver','Regular'),
address VARCHAR(100)
);

ALTER TABLE Customers
MODIFY loyalty_status ENUM('Gold','Silver','Bronze');

SELECT * FROM Customers;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(30),
    product_category VARCHAR(30),
    supplier_id INT NOT NULL,
    unit_price DECIMAL(6,2),

    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE
);

SELECT * FROM Products;

-- Orders Table
CREATE TABLE Orders(
order_id INT AUTO_INCREMENT PRIMARY KEY,
product_id INT,
customer_id INT,
supplier_id INT,
order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
order_status ENUM('Pending','Completed','Shipped','Cancelled'),

FOREIGN KEY (product_id) REFERENCES Products(product_id),
FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE
);

SELECT * FROM customersOrders;

CREATE TABLE Orderdetails (
    orderdetail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT CHECK (quantity > 0),

    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SELECT * FROM Orderdetails;

CREATE TABLE Warehouses (
    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,
    warehouse_name VARCHAR(30),
    location VARCHAR(30)
);

SELECT * FROM Warehouses;

CREATE TABLE Inventories (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    warehouse_id INT NOT NULL,
    quantity_in_stock INT,
    product_category VARCHAR(30),

    FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE
);

SELECT * FROM Inventories;

CREATE TABLE Shipments (
    shipment_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    warehouse_id INT,
    shipment_date DATE,
    delivery_date DATE,
    weight FLOAT,
    status ENUM('In Transit', 'Received'),

    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id) ON DELETE CASCADE
);

SELECT * FROM Shipments;

CREATE TABLE products_movement (
    movement_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    warehouse_id INT,
    shipment_id INT,
    movement_type ENUM('Received', 'Shipped', 'Stored'),
    quantity INT CHECK (quantity > 0),
    movement_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (warehouse_id) REFERENCES Warehouses(warehouse_id),
    FOREIGN KEY (shipment_id) REFERENCES Shipments(shipment_id)
);

SELECT * FROM products_movement;

CREATE TABLE Supplierproducts (
    supplier_productid INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    product_id INT,
    
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

SELECT * FROM Supplierproducts;

-- This should fail since Platinum is not a vaild option
INSERT INTO Customers (customer_name, cust_phone_number, loyalty_status, Address)
VALUES ('John Doe', '+91-3788901284', 'Platinum', '332- set st');  

INSERT INTO Suppliers (supplier_name, region, phone_number, email) VALUES
('ElectroWorld', 'Asia', '+91-1234567890', 'electro@world.com'),
('FashionHub', 'Europe', '+44-9876543210', 'fashion@hub.com'),
('TechGiant', 'North America', '+1-5551234567', 'tech@giant.com'),
('HomeEssentials', 'Asia', '+91-9876543210', 'home@essentials.com'),
('GadgetZone', 'Europe', '+44-1234567890', 'gadget@zone.com'),
('StyleMakers', 'North America', '+1-5559876543', 'style@makers.com'),
('ApplianceKing', 'Asia', '+91-5551234567', 'appliance@king.com'),
('TrendyWear', 'Europe', '+44-5559876543', 'trendy@wear.com'),
('SmartTech', 'North America', '+1-1234567890', 'smart@tech.com'),
('UrbanFashion', 'Asia', '+91-5559876543', 'urban@fashion.com'),
('GlobalGadgets', 'Europe', '+44-5551234567', 'global@gadgets.com'),
('ClassicStyles', 'North America', '+1-9876543210', 'classic@styles.com'),
('EcoFriendly', 'Asia', '+91-1234567890', 'eco@friendly.com'),
('LuxuryLane', 'Europe', '+44-9876543210', 'luxury@lane.com'),
('TechNest', 'North America', '+1-5551234567', 'tech@nest.com'),
('FashionFiesta', 'Asia', '+91-9876543210', 'fashion@fiesta.com'),
('HomeDecor', 'Europe', '+44-1234567890', 'home@decor.com'),
('GadgetGalaxy', 'North America', '+1-5559876543', 'gadget@galaxy.com'),
('StyleStudio', 'Asia', '+91-5551234567', 'style@studio.com'),
('TechVibe', 'Europe', '+44-5559876543', 'tech@vibe.com');

INSERT INTO Customers (customer_name, cust_phone_number, loyalty_status, Address) VALUES
('John Doe', '+1-1234567890', 'Gold', '123 Main St'),
('Jane Smith', '+1-9876543210', 'Silver', '456 Elm St'),
('Alice Johnson', '+1-5551234567', 'Bronze', '789 Oak St'),
('Bob Brown', '+1-5559876543', 'Gold', '321 Pine St'),
('Charlie Davis', '+1-1234567890', 'Silver', '654 Maple St'),
('Eva Green', '+1-9876543210', 'Bronze', '987 Cedar St'),
('Frank White', '+1-5551234567', 'Gold', '135 Birch St'),
('Grace Black', '+1-5559876543', 'Silver', '246 Walnut St'),
('Henry Blue', '+1-1234567890', 'Bronze', '369 Spruce St'),
('Ivy Red', '+1-9876543210', 'Gold', '482 Cherry St'),
('Jack Yellow', '+1-5551234567', 'Silver', '591 Peach St'),
('Karen Pink', '+1-5559876543', 'Bronze', '624 Plum St'),
('Leo Orange', '+1-1234567890', 'Gold', '753 Apple St'),
('Mia Purple', '+1-9876543210', 'Silver', '864 Grape St'),
('Noah Green', '+1-5551234567', 'Bronze', '975 Lemon St'),
('Olivia Gray', '+1-5559876543', 'Gold', '108 Berry St'),
('Paul Brown', '+1-1234567890', 'Silver', '219 Mango St'),
('Quinn White', '+1-9876543210', 'Bronze', '330 Kiwi St'),
('Ryan Black', '+1-5551234567', 'Gold', '441 Lime St'),
('Sara Blue', '+1-5559876543', 'Silver', '552 Melon St');

INSERT INTO Products (product_name, product_category, supplier_id, unit_price) VALUES
('Smartphone X', 'Electronics', 1, 999.99),
('Laptop Pro', 'Electronics', 3, 1499.99),
('T-Shirt', 'Clothing', 2, 19.99),
('Jeans', 'Clothing', 5, 49.99),
('Blender', 'Home Appliances', 4, 79.99),
('Microwave', 'Home Appliances', 7, 129.99),
('Headphones', 'Electronics', 1, 199.99),
('Sneakers', 'Clothing', 5, 89.99),
('Toaster', 'Home Appliances', 4, 39.99),
('Tablet', 'Electronics', 3, 499.99),
('Jacket', 'Clothing', 2, 99.99),
('Vacuum Cleaner', 'Home Appliances', 7, 199.99),
('Smartwatch', 'Electronics', 1, 299.99),
('Dress', 'Clothing', 5, 59.99),
('Coffee Maker', 'Home Appliances', 4, 89.99),
('Monitor', 'Electronics', 3, 299.99),
('Hoodie', 'Clothing', 2, 39.99),
('Air Fryer', 'Home Appliances', 7, 149.99),
('Keyboard', 'Electronics', 1, 49.99),
('Sweater', 'Clothing', 5, 69.99);

INSERT INTO Orders (product_id, supplier_id, customer_id, order_date, order_status) VALUES
(1, 1, 1, '2024-01-15', 'Completed'),
(2, 3, 2, '2024-02-20', 'Shipped'),
(3, 2, 3, '2024-03-10', 'Pending'),
(4, 5, 4, '2024-01-25', 'Completed'),
(5, 4, 5, '2024-02-05', 'Cancelled'),
(6, 7, 6, '2024-03-15', 'Shipped'),
(7, 1, 7, '2024-01-10', 'Completed'),
(8, 5, 8, '2024-02-28', 'Pending'),
(9, 4, 9, '2024-03-20', 'Completed'),
(10, 3, 10, '2024-01-30', 'Shipped'),
(11, 2, 11, '2024-02-10', 'Completed'),
(12, 7, 12, '2024-03-25', 'Pending'),
(13, 1, 13, '2024-01-05', 'Completed'),
(14, 5, 14, '2024-02-15', 'Shipped'),
(15, 4, 15, '2024-03-30', 'Completed'),
(16, 3, 16, '2024-01-20', 'Pending'),
(17, 2, 17, '2024-02-25', 'Completed'),
(18, 7, 18, '2024-03-05', 'Shipped'),
(19, 1, 19, '2024-01-12', 'Completed'),
(20, 5, 20, '2024-02-18', 'Pending');

INSERT INTO Orderdetails (order_id, product_id, quantity) VALUES
(1, 1, 2),
(2, 2, 1),
(3, 3, 5),
(4, 4, 3),
(5, 5, 1),
(6, 6, 2),
(7, 7, 4),
(8, 8, 2),
(9, 9, 1),
(10, 10, 3),
(11, 11, 2),
(12, 12, 1),
(13, 13, 4),
(14, 14, 2),
(15, 15, 1),
(16, 16, 3),
(17, 17, 2),
(18, 18, 1),
(19, 19, 4),
(20, 20, 2);

INSERT INTO Warehouses (warehouse_name, location) VALUES
('Warehouse A', 'New York'),
('Warehouse B', 'London'),
('Warehouse C', 'Tokyo'),
('Warehouse D', 'Berlin'),
('Warehouse E', 'Mumbai'),
('Warehouse F', 'Paris'),
('Warehouse G', 'Sydney'),
('Warehouse H', 'Toronto'),
('Warehouse I', 'Dubai'),
('Warehouse J', 'Singapore'),
('Warehouse K', 'Los Angeles'),
('Warehouse L', 'Hong Kong'),
('Warehouse M', 'Chicago'),
('Warehouse N', 'Shanghai'),
('Warehouse O', 'Seoul'),
('Warehouse P', 'Moscow'),
('Warehouse Q', 'San Francisco'),
('Warehouse R', 'Beijing'),
('Warehouse S', 'Osaka'),
('Warehouse T', 'Melbourne');

INSERT INTO Inventories (product_id, warehouse_id, quantity_in_stock, product_category) VALUES
(1, 1, 100, 'Electronics'),
(2, 2, 50, 'Electronics'),
(3, 3, 200, 'Clothing'),
(4, 4, 150, 'Clothing'),
(5, 5, 75, 'Home Appliances'),
(6, 6, 60, 'Home Appliances'),
(7, 7, 90, 'Electronics'),
(8, 8, 120, 'Clothing'),
(9, 9, 80, 'Home Appliances'),
(10, 10, 70, 'Electronics'),
(11, 11, 110, 'Clothing'),
(12, 12, 40, 'Home Appliances'),
(13, 13, 95, 'Electronics'),
(14, 14, 130, 'Clothing'),
(15, 15, 55, 'Home Appliances'),
(16, 16, 85, 'Electronics'),
(17, 17, 140, 'Clothing'),
(18, 18, 45, 'Home Appliances'),
(19, 19, 65, 'Electronics'),
(20, 20, 115, 'Clothing');

INSERT INTO Shipments (supplier_id, warehouse_id, shipment_date, delivery_date, weight, status) VALUES
(1, 1, '2024-01-01', '2024-01-10', 500, 'Received'),
(2, 2, '2024-01-05', '2024-01-15', 300, 'Received'),
(3, 3, '2024-01-10', '2024-01-20', 700, 'In Transit'),
(4, 4, '2024-01-15', '2024-01-25', 400, 'Received'),
(5, 5, '2024-01-20', '2024-01-30', 600, 'In Transit'),
(6, 6, '2024-01-25', '2024-02-05', 800, 'Received'),
(7, 7, '2024-01-30', '2024-02-10', 900, 'In Transit'),
(8, 8, '2024-02-01', '2024-02-11', 200, 'Received'),
(9, 9, '2024-02-05', '2024-02-15', 1000, 'In Transit'),
(10, 10, '2024-02-10', '2024-02-20', 550, 'Received'),
(11, 11, '2024-02-15', '2024-02-25', 750, 'In Transit'),
(12, 12, '2024-02-20', '2024-03-01', 350, 'Received'),
(13, 13, '2024-02-25', '2024-03-05', 950, 'In Transit'),
(14, 14, '2024-03-01', '2024-03-11', 450, 'Received'),
(15, 15, '2024-03-05', '2024-03-15', 650, 'In Transit'),
(16, 16, '2024-03-10', '2024-03-20', 850, 'Received'),
(17, 17, '2024-03-15', '2024-03-25', 150, 'In Transit'),
(18, 18, '2024-03-20', '2024-03-30', 250, 'Received'),
(19, 19, '2024-03-25', '2024-04-05', 1050, 'In Transit'),
(20, 20, '2024-03-30', '2024-04-10', 500, 'Received');

INSERT INTO products_movement (product_id, warehouse_id, shipment_id, movement_type, quantity, movement_date) VALUES
(1, 1, 1, 'Received', 100, '2024-01-10'),
(2, 2, 2, 'Received', 50, '2024-01-15'),
(3, 3, 3, 'Shipped', 200, '2024-01-20'),
(4, 4, 4, 'Received', 150, '2024-01-25'),
(5, 5, 5, 'Shipped', 75, '2024-01-30'),
(6, 6, 6, 'Received', 60, '2024-02-05'),
(7, 7, 7, 'Shipped', 90, '2024-02-10'),
(8, 8, 8, 'Received', 120, '2024-02-11'),
(9, 9, 9, 'Shipped', 80, '2024-02-15'),
(10, 10, 10, 'Received', 70, '2024-02-20'),
(11, 11, 11, 'Shipped', 110, '2024-02-25'),
(12, 12, 12, 'Received', 40, '2024-03-01'),
(13, 13, 13, 'Shipped', 95, '2024-03-05'),
(14, 14, 14, 'Received', 130, '2024-03-11'),
(15, 15, 15, 'Shipped', 55, '2024-03-15'),
(16, 16, 16, 'Received', 85, '2024-03-20'),
(17, 17, 17, 'Shipped', 140, '2024-03-25'),
(18, 18, 18, 'Received', 45, '2024-03-30'),
(19, 19, 19, 'Shipped', 65, '2024-04-05'),
(20, 20, 20, 'Received', 115, '2024-04-10');

INSERT INTO SupplierProducts (supplier_id, product_id) VALUES
(1, 1),  -- ElectroWorld supplies Smartphone X
(1, 7),  -- ElectroWorld supplies Headphones
(1, 13), -- ElectroWorld supplies Smartwatch
(1, 19), -- ElectroWorld supplies Keyboard
(2, 3),  -- FashionHub supplies T-Shirt
(2, 11), -- FashionHub supplies Jacket
(2, 17), -- FashionHub supplies Hoodie
(3, 2),  -- TechGiant supplies Laptop Pro
(3, 10), -- TechGiant supplies Tablet
(3, 16), -- TechGiant supplies Monitor
(4, 5),  -- HomeEssentials supplies Blender
(4, 9),  -- HomeEssentials supplies Toaster
(4, 15), -- HomeEssentials supplies Coffee Maker
(5, 4),  -- GadgetZone supplies Jeans
(5, 8),  -- GadgetZone supplies Sneakers
(5, 14), -- GadgetZone supplies Dress
(5, 20), -- GadgetZone supplies Sweater
(6, 6),  -- StyleMakers supplies Microwave
(6, 12), -- StyleMakers supplies Vacuum Cleaner
(6, 18); -- StyleMakers supplies Air Fryer






