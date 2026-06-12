-- Q11. Which customers contribute the highest total revenue?
WITH Customer_Spend AS (
    SELECT 
        o.customer_id,
        SUM(oi.quantity * p.unit_price) AS total_spent
    FROM public.FactOrders o
    JOIN public.FactOrderItems oi ON o.order_id = oi.order_id
    JOIN public.DimProducts p ON oi.product_id = p.product_id
    GROUP BY o.customer_id
)
SELECT 
    c.customer_id,
    c.full_name,
    ROUND(cs.total_spent, 2) AS "Total_Spent"
FROM Customer_Spend cs
JOIN public.DimCustomers c ON c.customer_id = cs.customer_id
ORDER BY "Total_Spent" DESC
LIMIT 10;
