-- SQL Retail Sales Analysis - project 1
create database sql_project1 ;

-- create table
drop table if exists retail_sales;
create table retail_sales 
         ( 
              transactions_id int primary key,
			  sale_date date,
			  sale_time time,
              customer_id int,
              gender varchar(20),
              age int,
              category varchar(15),
			  quantiy int,
              price_per_unit float,
              cogs float,
              total_sale float
              );
              
              
select * from retail_sales;
              
SELECT 
	 COUNT(*) 
FROM retail_sales;

-- Data Cleaning

SELECT * FROM retail_sales
where transactions_id is null;

SELECT * FROM retail_sales
where sale_date is null;

SELECT * FROM retail_sales
where sale_time is null;

select * from retail_sales
where
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     category is null
     or 
     quantiy is null
     or
     price_per_unit is null
     or
     cogs is null
     or
     total_sale is null;
     
     delete from retail_sales
     where
     transactions_id is null
     or
     sale_date is null
     or
     sale_time is null
     or
     customer_id is null
     or
     gender is null
     or
     category is null
     or 
     quantiy is null
     or
     price_per_unit is null
     or
     cogs is null
     or
     total_sale is null;

-- Data Exploration

-- how many sales we have?
select count(*) as total_sales from retail_sales;

-- how many customer we have?
select count(distinct customer_id) as total_customers from retail_sales;

-- how many category we have?
select distinct category as total_cateogry from retail_sales;

-- Data Analysis & Business Key Problems & Answers

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'
      select * from retail_sales
      where sale_date = '2022-11-05';

-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is 4 or more than 4 in the month of Nov-2022
      SELECT * FROM
			retail_sales
       WHERE
    category = 'clothing' AND quantiy >=4
        AND YEAR(sale_date) = '2022'
        AND MONTH(sale_date) = '11';
	
-- 3. Write a SQL query to calculate the total sales (total_sale) for each category
     select 
     category, 
     sum(total_sale) as net_sales,
     count(*) as total_order
     from retail_sales
     group by category;
     
-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
      select 
            round(avg(age),2) as avg_age
      from retail_sales
      where category = 'beauty';
      
-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
      select * from retail_sales
      where total_sale > 1000;
      
-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
	select category, gender, count(transactions_id) as net_transaction
    from retail_sales
    group by gender, category
    order by 1;

-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
     
      select year, month, avg_sales
      from (select year(sale_date) as year,  month(sale_date) as month, round(avg(total_sale),2) as avg_sales, 
      rank() over(partition by year(sale_date) order by avg(total_sale) desc) rnk
      from retail_sales
      group by year, month)
      as monthly_rank
      where rnk = '1';
      
-- 8. Write a SQL query to find the top 5 customers based on the highest total sales
      
      select customer_id, sum(total_sale) as total_sales
      from retail_sales
      group by customer_id
      order by total_sales desc
      limit 5; 
	
-- 9. Write a SQL query to find the number of unique customers who purchased items from each category
 select category, count(distinct customer_id) as cust_no
 from retail_sales
group by category;
	
-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
     
          select 
	case 
          when hour(sale_time)< 12 then 'Morning'
          when hour(sale_time) between 12 and 17 then 'Afternoon'
          else 'Evening'
          end as shift,
		count(*) as numbers_of_order
        from retail_sales
        group by shift;
        







