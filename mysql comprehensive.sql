CREATE DATABASE library;

USE library;

CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20));

CREATE TABLE Employee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(100),
    Salary DECIMAL(10,2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));

CREATE TABLE Books (
    ISBN CHAR(30) PRIMARY KEY,
    Book_title CHAR(100),
    Category CHAR(50),
    Rental_Price DECIMAL(10,2),
    Status CHAR(3),
    Author CHAR(50),
    Publisher CHAR(50));

CREATE TABLE Customer (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(50),
    Customer_address VARCHAR(100),
    Reg_date DATE);

CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust INT,
    Issued_book_name VARCHAR(100),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN));

CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN));

INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES 
(1, 66,'123 ABC ST', '110-445');


INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES 
(188, 'Vikram ik', 'coo', 50000, 4),
(066, 'Vineeth Bro', 'Manager', 45000, 2),
(095, 'Charly boom', 'Shelf keeper', 16000, 3),
(022, 'Harish kk', 'Book Assistance', 20000, 1);
      
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES 
('001-1-7334-2609-4', '1979', 'Science Fiction', 7.00, 'yes', 'DANIEL DEFOE', 'jiraffe'),
('002-2-7225-2608-3', '1996', 'HORROR', 15.0, 'yes', 'STEPHAEN KING', 'dolphin'),
('003-3-2247-7717-6', 1890, 'Drama', 14.0, 'YES', 'ANNI EBESANT', 'king fish'),
('004-4-6658-22667-7','1994', 'SPORT', 8.33, 'YES', 'INDIA AT THE OLYMPICS', 'BLACK DARK ');
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES 
(1, 'KIRAN KARAN', '226 DFG JL', '2024-05-21'),
(2, 'JACKY KOOM', '445 JHG TL', 2022-08-13),
(3, 'KARTHI MOOM', '224 KJH PO', 2020-01-05);

INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, Isbn_book)
VALUES 
(1, 3, '1979', '2024-01-21', '001-1-7334-2609-4');

INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES 
(1, 3, '1984', '2024-01-29', '001-1-7334-2609-4'),
(2, 5, '1996', '23-02-28', '003-3-2247-7717-6');

SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';

SELECT Emp_name, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT DISTINCT b.Book_title, c.Customer_name
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN
JOIN Customer c ON iss.Issued_cust = c.Customer_Id;

SELECT Category, COUNT(*) as Total_Count
FROM Books
GROUP BY Category;

SELECT Emp_name, Position
FROM Employee
WHERE Salary > 50000;

SELECT Customer_name
FROM Customer
WHERE Reg_date < '2022-01-01'
AND Customer_id NOT IN (SELECT Issued_cust FROM IssueStatus);

SELECT Branch_no, COUNT(*) as Total_Employees
FROM Employee
GROUP BY Branch_no;

SELECT DISTINCT c.Customer_name
FROM IssueStatus iss
JOIN Customer c ON iss.Issued_cust = c.Customer_Id
WHERE MONTH(iss.Issue_date) = 6 AND YEAR(iss.Issue_date) = 2023;

SELECT DISTINCT b.Book_title
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN;

SELECT Branch_no, COUNT(*) as Employee_count
FROM Employee
GROUP BY Branch_no
HAVING COUNT(*) > 5;

SELECT E.Emp_name, B.Branch_address
FROM Employee E
JOIN Branch B ON E.Branch_no = B.Branch_no
WHERE E.Position = 'Manager';

SELECT DISTINCT c.Customer_name
FROM IssueStatus iss
JOIN Books b ON iss.Isbn_book = b.ISBN
JOIN Customer c ON iss.Issued_cust = c.Customer_Id
WHERE b.Rental_Price > 25;

