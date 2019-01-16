-- Select * tab
SELECT * FROM TAB;

-- Select count(*) 
SELECT COUNT(*) FROM TAB;

-- Select * Table
SELECT * FROM customers; --1
SELECT * FROM Employees; --2
SELECT * FROM Shippers; --3
SELECT * FROM Orders; --4
SELECT * FROM Suppliers; --5
SELECT * FROM Categories; --6
SELECT * FROM Products; --7
SELECT * FROM Order_details; --8

-- Drop Table 
DROP TABLE Categories;

--1. Create table Cutomers
CREATE TABLE Customers(
customer_id VARCHAR2(15) PRIMARY KEY,
customer_name VARCHAR2(15) NOT NULL,
contact_name VARCHAR2(15) NOT NULL,
address VARCHAR2(15) NOT NULL,
city VARCHAR2(15) NOT NULL,
postal_code VARCHAR2(15) NOT NULL,
country VARCHAR2(15) NOT NULL
);

--2. Create Table Employees
CREATE TABLE Employees(
employee_id VARCHAR2(15) PRIMARY KEY,
last_name VARCHAR2(15) NOT NULL,
first_name VARCHAR2(15) NOT NULL,
birth_date VARCHAR2(15) NOT NULL,
photo VARCHAR2(15),
notes VARCHAR2(15)
);

--3. Create Table Shippers
CREATE TABLE Shippers(
shipper_id VARCHAR2(15) PRIMARY KEY,
shipper_name VARCHAR2(15) NOT NULL,
phone VARCHAR2(15) NOT NULL
);

--4. Create Table Orders
CREATE TABLE Orders(
order_id VARCHAR2(15) PRIMARY KEY,
customer_id VARCHAR2(15),
employee_id VARCHAR2(15),
order_date DATE DEFAULT SYSDATE,
shipper_id VARCHAR2(15),
CONSTRAINT customers_fk_orders FOREIGN KEY(customer_id)
REFERENCES Customers(customer_id),
CONSTRAINT employees_fk_orders FOREIGN KEY(employee_id)
REFERENCES Employees(employee_id),
CONSTRAINT shippers_fk_orders FOREIGN KEY(shipper_id)
REFERENCES Shippers(shipper_id)
);

--5. Create Table Suppliers
CREATE TABLE Suppliers(
supplier_id VARCHAR2(15) PRIMARY KEY,
supplier_name VARCHAR2(15) NOT NULL,
contact_name VARCHAR2(15) NOT NULL,
address VARCHAR2(15) NOT NULL,
city VARCHAR2(15) NOT NULL,
postal_code VARCHAR2(15) NOT NULL,
country VARCHAR2(15) NOT NULL,
phone VARCHAR2(15) NOT NULL
);

--6. Create Table Categories
CREATE TABLE Categories(
category_id NUMBER PRIMARY KEY,
category_name VARCHAR2(15) NOT NULL,
description VARCHAR2(15)
);

--7. Create Table Products
CREATE TABLE Products(
product_id NUMBER PRIMARY KEY,
product_name VARCHAR2(15) NOT NULL,
supplier_id VARCHAR2(15),
category_id NUMBER, 
unit VARCHAR2(15),
price NUMBER,
CONSTRAINT suppliers_fk_products FOREIGN KEY(supplier_id)
REFERENCES Suppliers(supplier_id),
CONSTRAINT categorys_fk_products FOREIGN KEY(category_id)
REFERENCES Categories(category_id)
);

--8. Create Table OrderDetails
CREATE TABLE Order_details(
order_detail_id NUMBER PRIMARY KEY,
order_id varchar2(15),--
product_id NUMBER,--
quantity NUMBER,
CONSTRAINT order_fk_orderDetails FOREIGN KEY(order_id)
REFERENCES Orders(order_id),
CONSTRAINT products_fk_orderDetails FOREIGN KEY(product_id)
REFERENCES Products(product_id)
);


