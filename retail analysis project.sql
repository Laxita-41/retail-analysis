--sql retail sales analysis-p1
Create Database sql_project_p2;
use sql_project_p2;
---create table
Drop table if exists retail_sales;
create table retail_sales
(
transactions_id	int primary key,
sale_date date,
sale_time time,
customer_id int ,
gender	varchar(15),
age	int,
category varchar(15),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);
select * from retail_sales;

----
select
count( *)
from retail_sales;
----- finding null values----data cleaning
select * from retail_sales
where transactions_id is null;

select * from retail_sales
where
 sale_date is null
or
sale_time is null
or
gender is null
or
category is null
or
cogs is null
or
total_sale is null;

------data exploration

-----how many sales we have?
select count(*) as total_sale from retail_sales;

-----how many unique customers we have?
select count(distinct customer_id)as total_sale from retail_sales;
--how many unique categories we have?
select distinct category from retail_sales;

------data analysis and business key problems and answers


--writequery to retrieve all columns for sales made on '2022-11-05
select*from retail_sales
where sale_date='2022-11-05';

---Write a SQL query to calculate the total sales (total_sales) for each category is clothingand the quantity sold is more then 4 in the month 2022-11-10
SELECT sale_date,
       SUM(total_sale) AS total_sales
FROM retail_sales
WHERE category = 'Clothing'
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
  AND quantiy   >= 4
GROUP BY sale_date
ORDER BY sale_date;


---Write a SQL query to find the customer with the highest total purchase 
select customer_id,total_sale
from retail_sales
order by total_sale desc
limit 1;

-----write a query to calculate total sales by each category
select category, total_sale
from retail_sales
order by category;
or
select category, sum(total_sale)as total_sale
from retail_sales
group by category 
order by total_sale;

-----write query to find the average age of customers who purchaes fromm beauty category
select  round(AVG(age),2)as customers_age,
 from retail_sales
where category='beauty';
 
 -------write a sql query to show all the transactions where total sale is greater then 1000
 select * from retail_sales 
 where total_sale> 1000;
 
 -----write a sql query to find the total number of transactions (transaction_id)made by each gender in each category
 select count(transactions_id)as transactins, gender,category  from retail_sales
 group by gender,category
 order by 1;
 
 ------write a sql quert to calculate the average sale for each month,find the best selling month from each year
SELECT 
    year,
    month,
    avg_sale,
    RANK() OVER (ORDER BY avg_sale  desc) AS sales_rank
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        ROUND(AVG(total_sale), 2) AS avg_sale
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS monthly_sales
ORDER BY year DESC, month DESC;


-----write a sql query to find the top 5 customers based on the highest total sales
     select customer_id,sum(total_sale)as total_sale
     from retail_sales
     group by 1
     order by 2 desc
     limit 5;
     
     ----que--write a sql query to find the number of unique customers who purchased itmes from each category.
    SELECT 
    category,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM retail_sales
GROUP BY category;

---write sql to create each shift and no.of orders(example morning<12,afternoon between 12 and 17,evening>17)
 SELECT 
    sale_time,
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    END AS shift
FROM retail_sales;
        ELSE 'Evening'
        
        --------end of project---

