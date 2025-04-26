-- Assignment: Database Design and Normalization
----------------------------------------------------------------------
-- Question 1: Achieving 1NF (First Normal Form)
----------------------------------------------------------------------
-- The 'Products' column in the original table violates 1NF by containing multiple values in a single field.
-- I created a new table, ProductDetail_1NF, where each row represents a single product per order, ensuring atomic values.

CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Inserting data with one product per row
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

----------------------------------------------------------------------
-- Question 2: Achieving 2NF (Second Normal Form)
----------------------------------------------------------------------
-- The original OrderDetails table has a partial dependency where CustomerName depends only on OrderID.
-- I split the table into Orders and OrderDetails_2NF to remove this dependency.
-- Orders stores OrderID and CustomerName, while OrderDetails_2NF stores OrderID, Product, and Quantity.

-- Creating the Orders table for order information
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Inserting the order information into Orders table
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Creating the OrderDetails_2NF table for product details and quantities
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    PRIMARY KEY (OrderID, Product),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting data into OrderDetails_2NF
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);
