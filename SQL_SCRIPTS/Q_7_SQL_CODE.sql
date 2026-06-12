-- Q7. Which product categories contribute the most to total revenue?
SELECT 
    p.category AS "Category_Name", 
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS "Total_Revenue"
FROM public.FactOrderItems oi
JOIN public.DimProducts p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;