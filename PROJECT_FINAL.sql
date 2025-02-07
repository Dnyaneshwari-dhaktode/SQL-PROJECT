USE pizzahut;
 SHOW tables;
-- --1) Retrieve the total number of orders placed-- 

SELECT count(order_id) AS total_orders
FROM  pizzahut.orders;





-- 2)Calculate the total revenue genrated from pizza sales

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
    
    
    
    
    
    
    
    
    -- Identify highest-priced pizza.

SELECT  pizza_types.name,pizzas.price
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;








-- 3)Identify the most common pizza QUANTITY ordered

SELECT quantity,count(order_details_id)
FROM order_details
GROUP BY quantity
limit 1;







-- 4)Identify  count most common pizza size order

SELECT pizzas.size,count(order_details.order_details_id) AS order_ount
FROM pizzas JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY  pizzas.size
ORDER BY order_ount desc;









-- 5)list the top 5 most orderdered pizza 
-- types along with their quantities

SELECT pizza_types.name,
sum(order_details.quantity) as quantity
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id =pizzas.pizza_type_id
join order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.name
order by quantity desc
limit 5;







-- 6)Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT sum(order_details.quantity) AS quantity,
pizza_types.category
FROM pizza_types JOIN pizzas
ON pizza_types.pizza_type_id =pizzas.pizza_type_id
JOIN order_details 
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY category
order by quantity;





-- 7)Determine the distribution of orders by hour of the day.

SELECT HOUR(orders.time),COUNT(order_id)
FROM orders
GROUP BY  HOUR(orders.time);










-- 8)Join relevant tables to find the category-wise distribution of pizzas.
SELECT category,count(name)
FROM pizza_types
GROUP BY category;










-- 9) Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT round(AVG(quantity)) from 
(SELECT orders.date,sum(order_details.quantity) as quantity
FROM order_details
JOIN orders
ON orders.order_id=order_details.order_id
GROUP BY date) AS order_perday ;








-- 10)Determine the top 3 most ordered pizza types based on revenue.
SELECT  pizza_types.name,
sum(order_details.quantity * pizzas.price) AS revenue
FROM pizzas JOIN pizza_types
ON pizza_types.pizza_type_id=pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3 ;









-- 11)Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.category ,
ROUND(SUM(order_details.quantity * pizzas.price) /(SELECT 
ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_sales
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id)*100,2 )AS revenue
FROM  pizza_types JOIN pizzas 
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id=pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY revenue DESC ;






-- 12)Analyze the cumulative revenue generated over time.
-- cumulative
SELECT date,
SUM(revenue) OVER (order by date) as cum_sum
FROM
(SELECT orders.date,
sum(order_details.quantity*pizzas.price) AS revenue
FROM order_details JOIN pizzas
ON order_details.pizza_id =pizzas.pizza_id
JOIN  orders
ON orders.order_id=order_details.order_id
GROUP BY orders.date)AS sales;


use pizzahut;
SELECT MAX(price),size
FROM PIZZAS
group by size
order by size;