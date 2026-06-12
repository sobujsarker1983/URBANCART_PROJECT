-- Q1. How many total orders has UrbanCart received so far?
SELECT COUNT(DISTINCT order_id) AS "Total_Orders"
FROM public.FactOrders;
