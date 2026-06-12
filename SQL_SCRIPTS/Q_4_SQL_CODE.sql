-- Q4. What is the monthly trend of total orders over time?
SELECT 
    DATE_TRUNC('month', order_date) AS "Month", 
    COUNT(DISTINCT order_id) AS "Total_Orders"
FROM public.FactOrders
GROUP BY 1
ORDER BY 1 ASC;