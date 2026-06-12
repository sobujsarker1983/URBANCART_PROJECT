-- Q2. Which cities generate the highest number of orders & revenue?
WITH Order_Revenue AS (
    SELECT 
        o.order_id,
        o.customer_id,
        SUM(oi.quantity * p.unit_price) AS order_total
    FROM public.FactOrders o
    JOIN public.FactOrderItems oi ON o.order_id = oi.order_id
    JOIN public.DimProducts p ON oi.product_id = p.product_id
    GROUP BY o.order_id, o.customer_id
)
SELECT 
    c.city AS "City",
    COUNT(DISTINCT r.order_id) AS "Total_Orders",
    ROUND(SUM(r.order_total), 2) AS "Total_Revenue"
FROM public.DimCustomers c
JOIN Order_Revenue r ON c.customer_id = r.customer_id
GROUP BY c.city
ORDER BY "Total_Revenue" DESC;;