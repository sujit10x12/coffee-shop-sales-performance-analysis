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
)


-- Total Sales
SELECT 
	ROUND(SUM(unit_price*transaction_qty)) AS total_sales
FROM 
	coffee_sales
WHERE 
	EXTRACT(MONTH FROM transaction_date) = 06 -- Particular Month

	
-- MOM Percentage Change in Sales
SELECT
	EXTRACT(MONTH FROM transaction_date) AS month,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales,
	LAG(ROUND(SUM(transaction_qty*unit_price))) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month_sales,
	ROUND((SUM(transaction_qty*unit_price) - LAG(SUM(transaction_qty*unit_price))
	OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)))*100 / LAG(SUM(transaction_qty*unit_price))
	OVER (ORDER BY EXTRACT(MONTH FROM transaction_date))) AS mom_percentage_change
FROM
	coffee_sales
GROUP BY
	month
	
	
-- Total Orders
SELECT
	COUNT(DISTINCT transaction_id) AS total_orders
FROM
	coffee_sales
	
	
-- MOM Percentage Change in Orders
SELECT
	EXTRACT(MONTH FROM transaction_date) AS month,
	COUNT(transaction_id) AS total_orders,
	LAG(COUNT(transaction_id)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month_orders,
	(COUNT(transaction_id) - LAG(COUNT(transaction_id)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)))*100 / 
	LAG(COUNT(transaction_id)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)) AS mom_percentage_change
FROM
	coffee_sales
GROUP BY
	month
	
	
-- Total Quantity Sold
SELECT SUM(transaction_qty) AS total_qty
FROM coffee_sales
	

-- MOM Percentage Change in Quantity
SELECT
	EXTRACT(MONTH FROM transaction_date) AS month,
	SUM(transaction_qty) AS total_qty,
	LAG(SUM(transaction_qty)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)) AS previous_month,
	((SUM(transaction_qty) - LAG(SUM(transaction_qty)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date))))*100/
	LAG(SUM(transaction_qty)) OVER (ORDER BY EXTRACT(MONTH FROM transaction_date)) AS mom_percentage_change
FROM
	coffee_sales
GROUP BY
	EXTRACT(MONTH FROM transaction_date)
	
	
-- Total Sales, Total Orders and Total Quantity Sold by Month
SELECT 
	EXTRACT(MONTH FROM transaction_date) AS month,
	ROUND(SUM(unit_price*transaction_qty)) AS total_sales,
	COUNT(DISTINCT transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_qty
FROM 
	coffee_sales
GROUP BY 
	month
	
	
-- By Date Analysis
SELECT
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales,
	SUM(transaction_qty) AS total_qty,
	COUNT(transaction_id) AS total_orders
FROM 
	coffee_sales
WHERE
	transaction_date = '2023-06-14'
	

-- Analysis by Weekdays & Weekends
SELECT
	CASE 
		WHEN EXTRACT(DOW FROM transaction_date) IN (0,6) 
		THEN 'weekends'
	ELSE 'week_days'
	END AS day_type,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales,
	COUNT(DISTINCT transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_qty
FROM
	coffee_sales
WHERE
	EXTRACT(MONTH FROM transaction_date) = 2
GROUP BY
	CASE WHEN EXTRACT(DOW FROM transaction_date) IN (0,6) THEN 'weekends'
	ELSE 'week_days'
	END
	

-- Analysis by Location
SELECT 
	store_location,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales,
	COUNT(DISTINCT transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_qty
FROM coffee_sales
WHERE EXTRACT(MONTH FROM transaction_date) = 5
GROUP BY store_location
ORDER BY total_sales DESC


-- Average Sales of a Month
SELECT
	ROUND(AVG(total_sales)) AS avg_sales
FROM
	(
		SELECT 
			EXTRACT(MONTH FROM transaction_date) AS month,
			SUM(transaction_qty*unit_price) AS total_sales
		FROM coffee_sales
		WHERE EXTRACT(MONTH FROM transaction_date) = 5 -- For May Month
		GROUP BY transaction_date
	) AS subquery
	

-- Average Sales by Day
SELECT
	EXTRACT(DAY FROM transaction_date) AS date,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales
FROM coffee_sales
--WHERE EXTRACT(MONTH FROM transaction_date) = 5
GROUP BY EXTRACT(DAY FROM transaction_date)


-- Sales Status by Day
SELECT
	date,
	CASE
		WHEN total_sales > avg_sales THEN 'Above Average Sales'
		WHEN total_sales < avg_sales THEN 'Below Average Sales'
		ELSE 'Equal to Average Sales'
	END AS sales_status,
	ROUND(total_sales)
FROM(
	SELECT
		EXTRACT(DAY FROM transaction_date) AS date,
		SUM(transaction_qty*unit_price) AS total_sales,
		AVG(SUM(transaction_qty*unit_price)) OVER() AS avg_sales
	FROM
		coffee_sales
	GROUP BY
		EXTRACT(DAY FROM transaction_date)
)


-- Sales by Product Category
SELECT 
	product_category,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales
FROM coffee_sales
GROUP BY product_category
ORDER BY total_sales DESC


-- Top 10 Products by Sales 
SELECT
	product_type,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales
FROM coffee_sales
GROUP BY product_type
ORDER BY total_sales DESC
LIMIT 10


-- Sales, Orders and Quantity Sold by Hour 
SELECT
	EXTRACT(HOUR FROM transaction_time) AS hour,
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales,
	SUM(transaction_qty) AS total_qty,
	COUNT(transaction_id) AS total_orders
FROM coffee_sales
GROUP BY EXTRACT(HOUR FROM transaction_time)
ORDER BY hour
-- ORDER BY total_sales DESC
-- ORDER BY total_qty DESC
-- ORDER BY total_orders DESC


-- Analysis by Week Days
SELECT
	TO_CHAR(transaction_date, 'DAY'),
	ROUND(SUM(transaction_qty*unit_price)) AS total_sales,
	COUNT(DISTINCT transaction_id) AS total_orders,
	SUM(transaction_qty) AS total_qty
FROM coffee_sales
GROUP BY TO_CHAR(transaction_date, 'DAY')
ORDER BY total_sales DESC