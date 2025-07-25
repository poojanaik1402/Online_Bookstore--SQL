-- Create Database
CREATE DATABASE OnlineBookstore;

-- Create Tables
CREATE TABLE Books(
    Book_ID INT PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);

CREATE TABLE Customers (
    Customer_ID INT PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);

CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);

SELECT * FROM Books;

SELECT * FROM Customers;

SELECT * FROM Orders;


-- Data Imported to table with the help of the import wizard option

---Need to check these key points in Oracle sql 

-- 1) Retrieve all books in the "Fiction" genre:
    SELECT * FROM Books 
    WHERE Genre = 'Fiction';

-- 2) Find books published after the year 1950:
    SELECT * FROM Books 
    WHERE Published_Year>1950;

-- 3) List all customers from the Canada:
    SELECT * FROM Customers 
    WHERE Country = 'Canada';

-- 4) Show orders placed in November 2023:
    SELECT * FROM Orders 
    WHERE Order_date BETWEEN TO_DATE('2023-11-01','yyyy-mm-dd') 
                         AND TO_DATE('2023-11-30','yyyy-mm-dd');

-- 5) Retrieve the total stock of books available:
    SELECT SUM(Stock)AS Total_Stocks 
    FROM BOOKS;

-- 6) Find the details of the most expensive book:
    
    SELECT * FROM Books WHERE Price =(SELECT MAX(Price)From Books);
    
    select * from
    (select book_id,title,author,genre,published_year,price,stock,rank()
    over(order by price desc)rn From books)
    where rn =1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
    SELECT * FROM Orders 
    WHERE Quantity>1;

-- 8) Retrieve all orders where the total amount exceeds $20:
    SELECT * FROM Orders 
    WHERE Total_Amount>20;

-- 9) List all genres available in the Books table:
    select distinct Genre FROM Books;

-- 10) Find the book with the lowest stock:
    SELECT * FROM 
    (SELECT Book_Id,Title,Author,Genre,Published_Year,Price,Stock,ROW_NUMBER()
    OVER(ORDER BY Stock ASC)RNK FROM Books)
    WHERE RNK = 1;

-- 11) Calculate the total revenue generated from all orders:
    SELECT SUM(Total_Amount) AS Total_Revenue FROM Orders;

-- Advance Questions : 

-- 1) Retrieve the total number of books sold for each genre:
    SELECT B.genre,SUM(O.quantity)AS total_books_sold
    FROM orders O
    JOIN books B ON O.book_id =B.book_id
    GROUP BY B.genre;

-- 2) Find the average price of books in the "Fantasy" genre:
    SELECT AVG(price) AS avg_price FROM books WHERE genre ='Fantasy';

-- 3) List customers who have placed at least 2 orders:
    select O.CUSTOMER_ID,c.Name,Count(o.ORDER_ID)as ORDER_COUNT
    from ORDERS O
    join CUSTOMERS C on o.CUSTOMER_ID = c.CUSTOMER_ID
    group by o.CUSTOMER_ID,c.Name
    having count(o.ORDER_ID)>=2;
    
-- 4) Find the most frequently ordered book:
    SELECT * FROM (
        SELECT o.Book_id, b.title, COUNT(o.order_id) AS Order_Count
        FROM Orders o
        JOIN Books b ON o.book_id = b.book_id
        GROUP BY o.book_id, b.title
        ORDER BY COUNT(o.order_id) DESC) 
        WHERE ROWNUM = 1;
    
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :
    SELECT book_id, title, genre, price 
    FROM (SELECT book_id, title, genre, price,
    RANK() OVER (ORDER BY price DESC) AS rnk
    FROM books
    WHERE genre = 'Fantasy')
    WHERE rnk <= 3;
   
-- 6) Retrieve the total quantity of books sold by each author:
    SELECT B.author,SUM(O.quantity)AS total_books_sold
    FROM orders O 
    JOIN books B ON O.book_id= B.book_id
    GROUP BY B.author ;
    
-- 7) List the cities where customers who spent over $30 are located:
    Select Distinct C.City,C.Name,O.Total_Amount
    From Orders O 
    Join Customers C 
    On O.Customer_Id= C.Customer_Id
    Where O.Total_Amount > 30;
   
-- 8) Find the customer who spent the most on orders:
    SELECT customer_id,NAME,total_spent
    FROM(SELECT C.customer_id,C.NAME,SUM(O.total_amount) AS total_spent
    FROM orders O 
    JOIN customers C ON O.customer_id = C.customer_id
    GROUP BY C.customer_id,C.NAME 
    ORDER BY SUM(O.total_amount) DESC)
    WHERE ROWNUM =1;

--9) Calculate the stock remaining after fulfilling all orders:
    SELECT 
    b.book_id, 
    b.title, 
    b.stock, 
    NVL(SUM(o.quantity), 0) AS order_quantity,
    b.stock - NVL(SUM(o.quantity), 0) AS remaining_quantity
    FROM books b
    LEFT JOIN orders o ON b.book_id = o.book_id
    GROUP BY b.book_id, b.title, b.stock
    ORDER BY b.book_id;

