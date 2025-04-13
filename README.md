# pizza-sales-analysis-project-using-SQL-and-EXCEL
# 🍕 Pizza Sales Analysis Project

## 📌 Overview
This project is a comprehensive sales analysis for a fictional pizza restaurant. It leverages **SQL** for querying the database and **Excel** for creating insightful visualizations. The aim is to provide business intelligence that can help improve decision-making, from inventory management to marketing strategies.

---

## 🧰 Tools & Technologies
- **MySQL** – for querying the dataset
- **Excel** – for dashboard and data visualization
- **Pivot Tables** – to summarize sales
- **Date & Time functions** – for time-based insights
- **Aggregations** – to calculate revenue, sales volume, etc.

---

## 🔍 Key Insights
- 🍕 Most popular and least popular pizzas
- 🕒 Peak hours and days for pizza sales
- 💰 Revenue trends by pizza size and category
- 📉 Underperforming areas needing attention
- 📆 Monthly and weekly performance patterns

---

## 📊 Visuals & Dashboards
Excel dashboards were created to display:
- Monthly Revenue Trends
- Pizza Category Performance
- Top 5 and Bottom 5 Pizzas
- Hourly and Weekly Sales Heatmaps

---

## 📁 Project Files
- `pizza_sales analysis project query.sql`: SQL queries used for analysis
- `pizza_sales excel file.xlsx`: Interactive Excel dashboard with charts and pivot tables

---



---

## 📜 Full SQL Queries

```sql
-- Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- Average Order Value
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM pizza_sales;

-- Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales;

-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- Average Pizzas Per Order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / COUNT(DISTINCT order_id) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM pizza_sales;

-- Daily Trend for Total Orders
SELECT DATE(order_date) AS Order_Date, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY DATE(order_date)
ORDER BY DATE(order_date);

-- Monthly Trend for Orders
SELECT MONTHNAME(order_date) AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY MONTHNAME(order_date), MONTH(order_date)
ORDER BY MONTH(order_date);

-- Percentage of Sales by Pizza Category
SELECT pizza_category, SUM(total_price) AS Total_Sales,
       SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

-- Percentage of Sales by Pizza Size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Sales,
       CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- Total Pizzas Sold by Pizza Category
SELECT pizza_category, SUM(quantity) AS Total_Pizzas_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Pizzas_Sold DESC;

-- Top 5 Best Sellers by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity DESC
LIMIT 5;

-- Bottom 5 Worst Sellers by Quantity
SELECT pizza_name, SUM(quantity) AS Total_Quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Quantity ASC
LIMIT 5;
