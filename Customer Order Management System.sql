CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    Region VARCHAR(255),
    Email VARCHAR(255)
);

INSERT INTO Customers (CustomerID, CustomerName, Region, Email) VALUES
(1, 'John Smith', 'North', 'john.smith@email.com'),
(2, 'Mary Johnson', 'South', 'mary.johnson@email.com'),
(3, 'James Brown', 'East', 'james.brown@email.com'),
(4, 'Patricia Miller', 'West', 'patricia.miller@email.com'),
(5, 'Michael Davis', 'North', 'michael.davis@email.com'),
(6, 'Linda Wilson', 'South', 'linda.wilson@email.com'),
(7, 'David Martinez', 'East', 'david.martinez@email.com'),
(8, 'Sarah Garcia', 'West', 'sarah.garcia@email.com');

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Category VARCHAR(255),
    Price DECIMAL(10, 2)
);

INSERT INTO Products (ProductID, ProductName, Category, Price) VALUES
(101, 'Laptop', 'Electronics', 800.00),
(102, 'Smartphone', 'Electronics', 500.00),
(103, 'Office Chair', 'Furniture', 120.00),
(104, 'Desk Lamp', 'Furniture', 40.00),
(105, 'Tablet', 'Electronics', 250.00),
(106, 'Monitor', 'Electronics', 150.00),
(107, 'Bookshelf', 'Furniture', 80.00),
(108, 'Kitchen Chair', 'Furniture', 45.00);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(201, 1, '2025-01-15', 840.00),
(202, 2, '2025-01-16', 500.00),
(203, 3, '2025-01-17', 200.00),
(204, 4, '2025-01-18', 160.00),
(205, 5, '2025-01-19', 950.00),
(206, 6, '2025-01-20', 270.00),
(207, 7, '2025-01-21', 720.00),
(208, 8, '2025-01-22', 140.00);


CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(201, 101, 1, 800.00),
(201, 104, 1, 40.00),
(202, 102, 1, 500.00),
(203, 103, 2, 120.00),
(204, 104, 4, 40.00),
(205, 101, 1, 800.00),
(205, 105, 1, 250.00),
(206, 102, 1, 500.00),
(206, 107, 2, 80.00),
(207, 106, 2, 150.00),
(207, 103, 1, 120.00),
(208, 104, 3, 40.00);

-- View all customers
SELECT * FROM Customers;

-- View all products
SELECT * FROM Products;

-- View All Orders
SELECT * FROM Orders;

-- View All OrderDetails
SELECT * FROM OrderDetails;

-- Retrieve All Order Details with Customer and Product Information
SELECT o.OrderID, c.CustomerName, o.OrderDate, p.ProductName, od.Quantity, od.Price
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID;

-- Total Sales per Customer
SELECT c.CustomerName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerName;

-- Total Sales per Product
SELECT p.ProductName, SUM(od.Quantity * od.Price) AS TotalSales
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName;

-- Average Order Size
SELECT AVG(TotalAmount) AS AverageOrderSize
FROM Orders;

-- Orders in a Specific Date Range
SELECT * FROM Orders
WHERE OrderDate BETWEEN '2025-01-15' AND '2025-01-20';

-- Total Sales per Customer for Orders Above a Certain Amount
SELECT c.CustomerName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerName
HAVING SUM(od.Quantity * od.Price) > 500;

-- Highest Total Sales by Customer
SELECT TOP 1 c.CustomerName, SUM(od.Quantity * od.Price) AS TotalSales
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerName
ORDER BY TotalSales DESC;

--  Most Purchased Product
SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY TotalQuantity DESC;

