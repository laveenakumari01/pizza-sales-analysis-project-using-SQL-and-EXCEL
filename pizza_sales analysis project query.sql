create database pizza_sales;
use pizza_sales;
select * from pizza_sales;
-- KPIS
-- total_revenue the sum of total price of all total orders 
select  sum(total_price) as Total_Revenue from pizza_sales;

-- Average order value: the average amount spent per order
select sum(total_price) / count(distinct order_id) as Average_order_value from pizza_sales;

-- total_orders total pizza sold: the sum of the quantities of all the pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;

-- total order of orders placed
select count(distinct order_id) as total_orders from pizza_sales;

-- Average pizza per order: the average number of pizza sold per order, calculated by dividing the total
-- number of pizza sold by the total number of orders
select cast(sum(quantity) as decimal(10, 2))/
cast(count(distinct order_id) as decimal(10,2)) from pizza_sales;

-- chart requirements
-- daily trend for total orders
SELECT DAYNAME(STR_TO_DATE(order_date, '%Y-%m-%d')) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY order_day;

-- percentage of sales by pizza category
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as per_of_total_sales
from pizza_sales
group by pizza_category;

-- if we want to the percentage of janraury month sales then we will use where clause
select pizza_category, sum(total_price) * 100 / (select sum(total_price) from pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1) as per_of_total_sales
from pizza_sales
WHERE MONTH(STR_TO_DATE(order_date, '%Y-%m-%d')) = 1
group by pizza_category;

-- percentage of sales by pizza_size
select pizza_size, sum(total_price) * 100 / (select sum(total_price) from pizza_sales) as per_of_total_sales
from pizza_sales
group by pizza_size
order by per_of_total_sales DESC;

-- Total pizza sold by pizza_category
select pizza_category, sum(quantity) as total_pizza_sold from pizza_sales
group by pizza_category;

-- top 5 best sellers by total pizza sold
select pizza_name, sum(quantity) as total_pizza_sold from pizza_sales
group by pizza_name
order by sum(quantity) DESC
limit 5;

-- botom 5 worst sellers by total pizza sold
select pizza_name, sum(quantity) as total_pizza_sold from pizza_sales
group by pizza_name
order by sum(quantity) 
limit 5;

