# 🥤 Coffee Shop Sales Performance Analysis (SQL + Power BI)
<img width="1584" height="396" alt="banner" src="/images/banner.png" />

---

## 🎯 Objective
To understand sales performance and customer buying patterns by analyzing data across time, locations, product categories, and order volumes, helping to identify trends, top products, and opportunities for growth.

---

## ❓ Key Business Requirements:
1. **Weekday vs Weekend Sales**  
   See how sales change between weekdays and weekends for each month.

2. **Sales by Store Location**  
   Find out which store locations bring in the most sales for each month.

3. **Average Sales Line**  
   Add an average sales line to spot days with unusually high or low sales for each month.

4. **Sales by Product Category**  
   Check which product categories sell the most and which sell the least for each month.

5. **Top Selling Products**  
   List the products that bring in the highest sales for each month.

6. **Sales by Day and Hour**  
   Discover which days and times have the most sales for each month.

7. **Total Orders**  
   Look at the total number of orders and how they change over time for each month.

8. **Total Quantity Sold**  
   See how many items are sold in total and spot changes in demand for each month.

---

## 🛠️ Tech Stack
 - PostreSQL
 - Power Bi
 - Github

---

## 📁 Dataset Understanding

This analysis is based on a structured dataset in CSV format, containing 10,108 records across 18 features.

### 📊 Columns Description

- Dataset: <a href="">coffee_shop_sales.csv</a>

| Column Name    | Description |
|----------------|-------------|
| `transaction_id`      | Unique sequential ID representing an individual transaction |
| `transaction_date`         |  Date of the transaction (MM/DD/YY)  |
| `transaction_time`        | Timestamp of the transaction (HH:MM:SS) |
| `transaction_qty`     | Quantity of items sold |
| `store_id`         | Unique ID of the coffee shop where the transaction took place |
| `store_location`      | Location of the coffee shop where the transaction took place |
| `product_id`   | Unique ID of the product sold |
| `unit_price` | Retail price of the product sold |
| `product_category`       | Description of the product category |
| `product_type`     | Description of the product type |
| `product_detail`    | Description of the product detail |

---

## 📥 Loading the Data

Rather than loading the data directly into Power BI, I chose to connect it through an SQL Server. This setup allows all visualizations to update dynamically whenever new data is added to the source

For this project, I used pgAdmin4 to manage and query the database efficiently.

- Once the database was set up in pgAdmin4 I created a table with the same columns as the source CSVs—one.

```SQL
-- Create Table "coffee_sales"
CREATE TABLE coffee_sales(
	transaction_id INT,
	transaction_date DATE,
	transaction_time TIME,
	transaction_qty INT,
	store_id INT,
	store_location VARCHAR(100),
	product_id INT,
	unit_price FLOAT,
	product_category VARCHAR(100),
	product_type VARCHAR(100),
	product_detail VARCHAR(100)
);
```
- Next, I imported all the raw data from the source CSV files into the newly created table using pgAdmin4 Import Data wizard.
- Each column was thoroughly reviewed to gain a clear understanding of the data and its relevance within the business domain. No missing values or inconsistencies were identified.
- `📄Note`: For better readability, only key snippets are shown in this README. You can view the full set of SQL queries <a href="/queries.sql">**in this file**</a>

---

## 🔌 Connecting SQL Server Database to Power BI
Linking SQL Server Management Studio database directly to Power BI in order to easily visualize and analyze the data in real-time.

<img width="1584" height="396" alt="connect" src="/images/connection.png" />

Before creating visualization, using DAX time intelligence functionality, I created additional table, calculated columns and measures, incorporating key business metrics and performance indicators to strengthen dashboard insights. New Added Table, Coumns and Measures are following:

- Date Table
- MONTH, Month Number, Month Year, Day Name, Week Number, Day Number, Week Day Number 
- Weekday / Weekend
- Hour
- Total Orders
- Total Quantity Sold
- Total Sales
- Current Month Orders
- Current Month Quantity
- Current Month Sales
- Previous Month Orders
- Previous Month Quantity
- Previous Month Sales
- MOM Change Orders
- MOM Change Quantity
- MOM Change Sales 
- Label for Product Category
- Label for Product Type
- Label for Store Location

#### ℹ **You can check the complete dax code in this <a href="/coffee_sales.dax">`File`</a>**
---

## 📈 Dashboard Development

The dashboard....

**Coffee Sales Dashboard** 

<img width="1584" height="396" alt="connect" src="/images/dashboard.jpg" />

- **KPIs** : There are 3 main KPIs -> Total Sales, Total Orders and Total Quantity Sold.
- **Filters** : Dashboard can be filtered by Month, Date, Weekdays or Weekends, Category, Product Types
- **Slicer**: I used month as a slicer, only one month can be selected at a time.

#### ℹ **You can downlaod the PowerBi file from <a href="/powerbi.pbix">Here</a>**
---

## ✅ Solution

1. Most sales were in June ($166,486), followed by May ($156,728) and April ($118,941), indicating a steady month-on-month sales increase.

2. Weekday sales ($54,003) are over 2.4× higher than weekend sales ($22,143), showing stronger performance during the week, but average sales per day is almost equal (10,800 for weekdays and 11,071 for weekends).

3. All three locations contribute almost equally ($236,511, $232,244, $230,057), with Hell's Kitchen leading by a small margin.

4. Coffee leads sales at $269,952, followed by Tea ($196,406). The top two categories (Coffee & Tea) account for the majority of revenue.

5. Barista Espresso leads with $91,406, followed by Brewed Chai Tea ($77,082) and Hot Chocolate ($72,416).

6. Sales peak between 8–10 AM ($82,700–$88,673), with 9 AM and 10 AM as the strongest hours. Performance dips after 11 AM, with a steady decline through the afternoon and evening. The lowest sales occur at 8 PM ($2,936), showing mornings as the prime revenue window.

7. Total Sales of 6 months are $698,812, Total Orders 149,116 and Total Quantity Sold 214470

---
