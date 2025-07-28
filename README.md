# 📚 SQL Project: Online Bookstore

A hands-on SQL project that simulates an online bookstore using **Oracle SQL**. It covers database creation, data import from `.csv` files, and real-world SQL queries for managing books, customers, and orders.

---

## 📁 Files Included

| File Name             | Description                                    |
|----------------------|------------------------------------------------|
| `Online_bookstore.sql` | Main SQL script: table creation, inserts, and queries |
| `Books.csv`           | Sample dataset containing book details         |
| `Customers.csv`       | Sample dataset with customer information       |
| `Orders.csv`          | Sample dataset showing customer orders         |

---

## 🧠 Key Features

- Book, Customer & Order Management  
- Price, stock, and sales analytics  
- Grouping, filtering, subqueries, and ranking  
- Practical business scenarios using SQL  

---

## 🛠 Tools Used

- **Oracle SQL**
- **SQL Developer** / [Oracle Live SQL](https://livesql.oracle.com)
- CSV files for sample data

---

## 🔑 Main SQL Queries Used

### 📘 General Queries
- Retrieve all books in the **"Fiction"** genre
- Find books published **after 1950**
- List customers from **Canada**
- Show orders placed in **November 2023**
- Retrieve the **total stock** of books
- Find the **most expensive book**
- Show customers who ordered **more than 1 quantity**
- List orders with **Total_Amount > $20**
- List all **distinct genres**
- Find the book with the **lowest stock**
- Calculate **total revenue**

### 📊 Advanced & Analytical Queries
- Total books sold for each **genre**
- **Average price** of Fantasy books
- Customers with **at least 2 orders**
- Most **frequently ordered book**
- Top 3 most **expensive Fantasy books**
- Total quantity sold by **each author**
- List cities where customers **spent over $30**
- Customer who **spent the most**
- Calculate **remaining stock** after sales

---

## 💬 Sample Query Snippets

```sql
-- Total Revenue
SELECT SUM(Total_Amount) AS Total_Revenue FROM Orders;

-- Most Frequently Ordered Book
SELECT * FROM (
              SELECT o.Book_id, b.title, COUNT(o.order_id) AS Order_Count
              FROM Orders o
              JOIN Books b ON o.book_id = b.book_id
              GROUP BY o.book_id, b.title
              ORDER BY COUNT(o.order_id) DESC) 
              WHERE ROWNUM = 1;
-- Remaining Stock After Orders
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



