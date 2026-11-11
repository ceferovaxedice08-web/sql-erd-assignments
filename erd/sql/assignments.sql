-- =====================================================
-- SalesDB - SQL assignment solutions (SQLite)
-- =====================================================

PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

PRAGMA foreign_keys = ON;

-- =====================================================
-- PART I - DATABASE SETUP
-- =====================================================

-- Create tables with primary keys and foreign keys
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Country    VARCHAR(50),
    Score      INTEGER
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    Product   VARCHAR(100),
    Category  VARCHAR(50),
    Price     DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName  VARCHAR(50),
    LastName   VARCHAR(50),
    Department VARCHAR(50),
    BirthDate  DATE,
    Gender     VARCHAR(10),
    Salary     DECIMAL(10,2),
    ManagerID  INTEGER,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Orders (
    OrderID       INTEGER PRIMARY KEY,
    ProductID     INTEGER,
    CustomerID    INTEGER,
    SalesPersonID INTEGER,
    OrderDate     DATE,
    ShipDate      DATE,
    OrderStatus   VARCHAR(30),
    ShipAddress   VARCHAR(150),
    BillAddress   VARCHAR(150),
    Quantity      INTEGER,
    Sales         DECIMAL(10,2),
    CreationTime  DATETIME,
    FOREIGN KEY (ProductID)     REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID)    REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

-- Insert sample data
INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Ayla',  'Karimova', 'Azerbaijan', 720),
(2, 'John',  'Miller',   'USA',        450),
(3, 'Emma',  'Schmidt',  'Germany',    860),
(4, 'Sara',  'Martin',   'France',     280),
(5, 'Lukas', 'Weber',    'Germany',    550);

INSERT INTO Products (ProductID, Product, Category, Price) VALUES
(101, 'Wireless Mouse', 'Electronics', 55),
(102, 'Office Chair',   'Furniture',   230),
(103, 'Laptop',         'Electronics', 850),
(104, 'Notebook',       'Stationery',  12),
(105, 'Smart Phone',    'Electronics', 420);

INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
(11, 'David', 'Lee',   'Sales',   '1985-03-12', 'Male',   2200, NULL),
(12, 'Maya',  'Brown', 'Sales',   '1990-07-25', 'Female', 2400, 11),
(13, 'Alex',  'Green', 'Support', '1992-11-02', 'Male',   1900, 11);

INSERT INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime) VALUES
(201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', '12 Nizami St, Baku', '12 Nizami St, Baku', 2, 110, '2026-10-04 10:15:00'),
(202, 103, 3, 12, '2026-10-08', '2026-10-10', 'Shipped', '5 Berliner Str, Berlin', '5 Berliner Str, Berlin', 1, 850, '2026-10-08 09:30:00'),
(203, 102, 2, 11, '2026-10-12', NULL, 'Pending', '77 5th Ave, New York', '77 5th Ave, New York', 1, 230, '2026-10-12 14:00:00'),
(204, 105, 5, 12, '2026-10-15', '2026-10-26', 'Delivered', '9 Hauptstr, Munich', '9 Hauptstr, Munich', 1, 420, '2026-10-15 11:45:00'),
(105, 103, 3, 12, '2026-10-20', NULL, 'Pending', '5 Berliner Str, Berlin', '5 Berliner Str, Berlin', 2, 1700, '2026-10-20 16:20:00'),
(110, 101, 5, 11, '2026-10-22', NULL, 'Pending', 'Old address', '9 Hauptstr, Munich', 3, 165, '2026-10-22 13:10:00'),
(206, 103, 3, 12, '2026-10-28', '2026-10-30', 'Shipped', '5 Berliner Str, Berlin', '5 Berliner Str, Berlin', 5, 4250, '2026-10-28 10:00:00'),
(207, 105, 1, 11, '2026-09-28', '2026-09-30', 'Delivered', '12 Nizami St, Baku', '12 Nizami St, Baku', 3, 1260, '2026-09-28 15:00:00'),
(999, 104, 2, 13, '2026-10-30', NULL, 'Test', 'Test address', 'Test address', 1, 12, '2026-10-30 08:00:00');

-- Verify each table
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Employees;
SELECT * FROM Orders;

-- =====================================================
-- PART I - TEN BASIC TASKS
-- =====================================================

-- Task 1: all columns, then only three columns
SELECT * FROM Customers;
SELECT FirstName, LastName, Country FROM Customers;

-- Task 2: customers from Germany
SELECT CustomerID, FirstName, LastName, Country
FROM Customers
WHERE Country = 'Germany';

-- Task 3: Score >= 300 and Germany or France
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Score >= 300 AND Country IN ('Germany', 'France');

-- Task 4: products, most expensive first
SELECT ProductID, Product, Category, Price
FROM Products
ORDER BY Price DESC;

-- Task 5: price between 50 and 300 (inclusive)
SELECT Product, Price
FROM Products
WHERE Price BETWEEN 50 AND 300;

-- Task 6: product name contains "Phone"
SELECT Product, Category
FROM Products
WHERE Product LIKE '%Phone%';

-- Task 7: unique categories, alphabetical
SELECT DISTINCT Category
FROM Products
ORDER BY Category;

-- Task 8: OrderID with customer's first and last name
SELECT o.OrderID, c.FirstName, c.LastName
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID;

-- Task 9: order count and total sales per status, biggest total first
SELECT OrderStatus, COUNT(*) AS OrderCount, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalSales DESC;

-- Task 10: safe INSERT / UPDATE / DELETE with an unused ID (900)
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (900, 'Test Product', 'Test', 10);

UPDATE Products SET Price = 15 WHERE ProductID = 900;

SELECT * FROM Products WHERE ProductID = 900;

DELETE FROM Products WHERE ProductID = 900;

-- Why WHERE is needed: without WHERE, UPDATE changes EVERY row
-- and DELETE removes EVERY row of the table. WHERE limits the
-- change to the intended row(s) only.

-- =====================================================
-- ASSIGNMENT 1 - CUSTOMER LOYALTY AND SALES ANALYSIS
-- =====================================================

-- A1 Task 1: customers with Score > 500, highest score first
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Score > 500
ORDER BY Score DESC;

-- A1 Task 2: target countries with Score >= 300
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Country IN ('Germany', 'France', 'USA') AND Score >= 300;

-- A1 Task 3: purchase history (customer full name + order info)
SELECT c.FirstName || ' ' || c.LastName AS Customer,
       o.OrderID, o.OrderDate, o.Sales
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID;

-- A1 Task 4: customers who never ordered (LEFT JOIN keeps unmatched customers)
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country
FROM Customers AS c
LEFT JOIN Orders AS o ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- A1 Task 5: total sales per customer (only customers with orders)
SELECT c.FirstName || ' ' || c.LastName AS Customer,
       SUM(o.Sales) AS TotalSales
FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSales DESC;

-- A1 Task 6: loyalty threshold - total sales > 1000 (HAVING filters groups)
SELECT c.FirstName || ' ' || c.LastName AS Customer,
       SUM(o.Sales) AS TotalSales
FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING SUM(o.Sales) > 1000
ORDER BY TotalSales DESC;

-- A1 Task 7: top five customers by total spending
SELECT c.FirstName || ' ' || c.LastName AS Customer,
       c.Country,
       SUM(o.Sales) AS TotalSales
FROM Customers AS c
INNER JOIN Orders AS o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
ORDER BY TotalSales DESC
LIMIT 5;

-- =====================================================
-- ASSIGNMENT 2 - ORDER AND DELIVERY INVESTIGATION
-- =====================================================

-- A2 Task 1: orders placed in October 2026
SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus
FROM Orders
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31';

-- A2 Task 2: pending orders, oldest first
SELECT *
FROM Orders
WHERE OrderStatus = 'Pending'
ORDER BY OrderDate ASC;

-- A2 Task 3: late shipments (ShipDate more than 7 days after OrderDate)
-- SQLite: julianday() turns a date into a number, so we can subtract
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS Customer,
       o.OrderDate, o.ShipDate
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
WHERE julianday(o.ShipDate) - julianday(o.OrderDate) > 7;

-- A2 Task 4: customers affected by the late shipments
SELECT DISTINCT c.FirstName, c.LastName, c.Country
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
WHERE julianday(o.ShipDate) - julianday(o.OrderDate) > 7;

-- A2 Task 5: status correction for OrderID 105
SELECT * FROM Orders WHERE OrderID = 105;
UPDATE Orders
SET OrderStatus = 'Shipped', ShipDate = '2026-11-05'
WHERE OrderID = 105;
SELECT * FROM Orders WHERE OrderID = 105;

-- A2 Task 6: address correction for OrderID 110
SELECT * FROM Orders WHERE OrderID = 110;
UPDATE Orders
SET ShipAddress = '45 Main Street, Baku'
WHERE OrderID = 110;
SELECT * FROM Orders WHERE OrderID = 110;

-- A2 Task 7: delete the temporary test order only
SELECT * FROM Orders WHERE OrderID = 999;
DELETE FROM Orders WHERE OrderID = 999;
SELECT * FROM Orders WHERE OrderID = 999;

-- A2 Task 8: number of orders per status
SELECT OrderStatus, COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus;

-- A2 Task 9: orders not shipped yet (ShipDate is NULL, so use IS NULL)
SELECT c.FirstName || ' ' || c.LastName AS Customer,
       o.OrderID, o.OrderDate, o.OrderStatus
FROM Orders AS o
INNER JOIN Customers AS c ON o.CustomerID = c.CustomerID
WHERE o.ShipDate IS NULL;

-- =====================================================
-- ASSIGNMENT 3 - PRODUCTS AND EMPLOYEE PERFORMANCE
-- =====================================================

-- A3 Task 1: affordable products (50-300), cheapest first
SELECT Product, Category, Price
FROM Products
WHERE Price BETWEEN 50 AND 300
ORDER BY Price ASC;

-- A3 Task 2: premium electronics (price > 500)
SELECT *
FROM Products
WHERE Category = 'Electronics' AND Price > 500;

-- A3 Task 3: product sales (product name, category, quantity, sales)
SELECT p.Product, p.Category, o.Quantity, o.Sales
FROM Products AS p
INNER JOIN Orders AS o ON p.ProductID = o.ProductID;

-- A3 Task 4: top five best-selling products by total quantity
SELECT p.Product, SUM(o.Quantity) AS TotalQuantity
FROM Products AS p
INNER JOIN Orders AS o ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.Product
ORDER BY TotalQuantity DESC
LIMIT 5;

-- A3 Task 5: unsold products (LEFT JOIN + IS NULL)
SELECT p.ProductID, p.Product, p.Category
FROM Products AS p
LEFT JOIN Orders AS o ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL;

-- A3 Task 6: employee performance (EmployeeID = SalesPersonID)
SELECT e.FirstName || ' ' || e.LastName AS Employee,
       e.Department,
       SUM(o.Sales) AS TotalSales
FROM Employees AS e
INNER JOIN Orders AS o ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department;

-- A3 Task 7: top staff - total sales above 5000
SELECT e.FirstName || ' ' || e.LastName AS Employee,
       e.Department,
       SUM(o.Sales) AS TotalSales
FROM Employees AS e
INNER JOIN Orders AS o ON e.EmployeeID = o.SalesPersonID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department
HAVING SUM(o.Sales) > 5000
ORDER BY TotalSales DESC;

-- A3 Task 8: register a new product
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (501, 'Wireless Keyboard', 'Electronics', 75);

-- A3 Task 9: price correction 75 -> 90
UPDATE Products SET Price = 90 WHERE ProductID = 501;
SELECT * FROM Products WHERE ProductID = 501;

-- A3 Task 10: add an inventory column
ALTER TABLE Products ADD COLUMN StockQuantity INTEGER;

-- A3 Task 11: unique combined list of names (UNION removes duplicates)
SELECT FirstName, LastName FROM Customers
UNION
SELECT FirstName, LastName FROM Employees;

-- A3 Task 12: category performance, only categories with total sales > 2000
SELECT p.Category,
       SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales)    AS TotalSales
FROM Products AS p
INNER JOIN Orders AS o ON p.ProductID = o.ProductID
GROUP BY p.Category
HAVING SUM(o.Sales) > 2000
ORDER BY TotalSales DESC;
