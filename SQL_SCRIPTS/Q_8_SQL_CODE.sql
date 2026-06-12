-- Q8. Which individual products generate the highest revenue?
SELECT 
    p.product_name AS "Product_Name", 
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS "Total_Revenue"
FROM public.FactOrderItems oi
JOIN public.DimProducts p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY "Total_Revenue" DESC
LIMIT 10;