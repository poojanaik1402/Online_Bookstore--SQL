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
  SELECT b.title, COUNT(*) AS Order_Count
  FROM Orders o
  JOIN Books b ON o.Book_ID = b.Book_ID
  GROUP BY b.title
  ORDER BY Order_Count DESC
) WHERE ROWNUM = 1;

-- Remaining Stock After Orders
SELECT 
  b.Book_ID, b.Title, b.Stock, 
  NVL(SUM(o.Quantity), 0) AS Ordered, 
  b.Stock - NVL(SUM(o.Quantity), 0) AS Remaining
FROM Books b
LEFT JOIN Orders o ON b.Book_ID = o.Book_ID
GROUP BY b.Book_ID, b.Title, b.Stock;



