use [pizza DB];
select * from pizza_sales;
--KPI's requirement
--problem stament
--we need to analyze key indicators for our pizza sales to gain insights into our business performace

--1) total revenue
select sum(total_price) as TOTAL_REVENUE from pizza_sales;

-- 2) average order value
select sum(total_price) / count(distinct order_id) as average_order_value
from pizza_sales;

--3)total pizza sold
select sum(quantity) as total_pizza_sold from pizza_sales;

--4) total orders
select count(distinct order_id) as total_orders from pizza_sales;


--5) average_pizza per_order
select cast(cast(sum(quantity)as  decimal(10,2)) / cast(count(distinct order_id) as decimal(10,2))
as decimal(10,2))as average_pizza_per_order from pizza_sales;




--1) daily trends for total orders
select * from pizza_sales;
select DATENAME(DW, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
group by DATENAME(DW, order_date);

--2) hourly trends
SELECT DATEPART(hour, order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(hour, order_time)
ORDER BY total_orders DESC;

--3) top 5 peak hour sales
SELECT top 5 DATEPART(hour, order_time) AS order_hours, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DATEPART(hour, order_time)
ORDER BY total_orders DESC;

--4) Percentage of sales by pizza category:
select * from pizza_sales;

select pizza_category,cast(sum(total_price)as decimal(10,2))as total_sales,
cast(sum(total_price) * 100 /
(select sum(total_price)from pizza_sales)as decimal(10,2))as PCT
from pizza_sales
group by pizza_category
order by total_sales desc;

--5) percentage of sales by pizza size:
select pizza_size,cast(sum(total_price)as decimal(10,2))as total_sales,
cast(sum(total_price) * 100 /
(select sum(total_price)from pizza_sales where month(order_date) = 1)as decimal(10,2))as PCT
from pizza_sales
--in where clause we can see that total sales on month of januray
where month(order_date)=1
group by pizza_size
order by total_sales desc;

--6) Total pizza sold by pizza category:
select * from pizza_sales
select pizza_category,sum(quantity)as sold_pizza
from pizza_sales
group by pizza_category
order by sold_pizza desc;


--7)Top 5 best sellers by total pizza sold:
select * from pizza_sales

select top 5 pizza_name, sum(quantity)as total_pizza_sold,pizza_category
from pizza_sales
group by pizza_name,pizza_category
order by total_pizza_sold desc;

--8) bottom 5 worst sellers by total pizza sold:
select top 5  pizza_name,sum(quantity) as total_pizza_sold
from pizza_sales
where month(order_date)= 2
group by pizza_name
order by total_pizza_sold;

