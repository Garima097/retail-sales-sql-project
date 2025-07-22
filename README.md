# 🛍️ Retail Sales Analysis — SQL Project

### 📊 Project Title: Retail Sales Analysis  
**Level:** Beginner  
**Database Name:** sql_project1
**Tool:** MySQL Workbench  
**Records Analyzed:** 2000  

---

## 📌 Project Overview

This project was created to practice and demonstrate my SQL skills in a real-world scenario. I worked with a retail sales dataset to clean, explore, and analyze transaction data using SQL queries. The project simulates the kind of tasks data analysts regularly perform when working with structured databases.

It covers:
- Setting up and importing data into MySQL
- Handling nulls and formatting issues
- Writing SQL queries to answer business-related questions
- Summarizing insights about sales, customers, and product performance

---

## 🎯 Objectives

- ✅ **Database Setup:** Create and populate a retail sales database
- ✅ **Data Cleaning:** Handle missing values, data types, and structure issues
- ✅ **Exploratory Data Analysis (EDA):** Understand customer and sales patterns
- ✅ **Business Insights:** Answer practical questions using SQL

---

## 🧱 Project Structure

### 1. 📂 Database Setup

```sql
CREATE DATABASE sql_project1;

CREATE TABLE retail_sales (
  transactions_id INT PRIMARY KEY,
  sale_date DATE,
  sale_time TIME,
  customer_id INT,
  gender VARCHAR(20),
  age INT,
  category VARCHAR(35),
  quantiy INT,
  price_per_unit FLOAT,
  cogs FLOAT,
  total_sale FLOAT
);
```

Data was imported using `LOAD DATA INFILE`, and nulls were handled using `NULLIF()` and user-defined variables (`@col`) for robust error-free loading.

---

### 2. 🧼 Data Cleaning & Exploration

- ✅ Checked total number of records
- ✅ Found unique customers and categories
- ✅ Handled missing values by treating blanks as `NULL`
- ✅ Verified and corrected data types

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;
```

---

### 3. 📊 Data Analysis

Here are some of the questions answered using SQL:

#### 🛒 Sales & Category Insights

- Total sales per category  
- Number of orders per shift: Morning (<12), Afternoon (12–17), Evening (>17)  
- High-value transactions (sale > 1000)

#### 👥 Customer Analysis

- Top 5 customers by total spending  
- Average age of customers in the Beauty category  
- Number of unique customers per category

#### 📅 Time Trend Analysis

- Monthly average sales  
- Best-selling month in each year (using `RANK()` window function)

---

### 🔍 Sample SQL Queries

```sql
-- Top 5 Customers by Sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Shift-based Orders
WITH hourly_sales AS (
  SELECT *,
    CASE
      WHEN HOUR(sale_time) < 12 THEN 'Morning'
      WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
      ELSE 'Evening'
    END AS shift
  FROM retail_sales
)
SELECT shift, COUNT(*) AS total_orders
FROM hourly_sales
GROUP BY shift;

-- Best Month per Year by Avg Sale
SELECT year, month, avg_sale
FROM (
  SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    AVG(total_sale) AS avg_sale,
    RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rank
  FROM retail_sales
  GROUP BY year, month
) ranked_sales
WHERE rank = 1;
```

---

## 📈 Key Findings

- 🏆 **Top customers** account for a significant share of sales
- 👗 **Clothing** was the most sold category by quantity
- 🕒 Most transactions happen in the **Morning shift**
- 📆 Highest average sales were observed in **[insert month once known]**

---

## 📑 Files

- `project1 retails sales.sql` — Full SQL script (setup, cleaning, queries)
- `SQL - Retail Sales Analysis_utf .csv` — Original dataset
- `README.md` — Project documentation

---

## 📌 How to Use This Project

1. Download the dataset and import it into MySQL
2. Run the SQL script step-by-step using MySQL Workbench
3. Observe insights and modify queries as needed for deeper analysis

---

## 👩‍💻 About Me

**Author:** Garima 
**Focus:** Building strong SQL foundations for Data Analytics roles  
💬 *Feel free to connect if you want feedback or want to collaborate.*