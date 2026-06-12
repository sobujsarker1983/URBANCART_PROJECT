-- Q13. Do male and female customers show different purchasing patterns by category?
SELECT 
    c.gender AS "Gender",
    p.category AS "Category",
    COUNT(DISTINCT o.order_id) AS "Total_Orders",
    SUM(oi.quantity) AS "Total_Quantity_Purchased",
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS "Total_Revenue",
    ROUND(SUM(oi.quantity)::NUMERIC / COUNT(DISTINCT o.order_id), 2) AS "Avg_Basket_Size_Per_Order",
    ROUND(SUM(oi.quantity * p.unit_price)::NUMERIC / COUNT(DISTINCT o.order_id), 2) AS "Avg_Order_Value_AOV"
FROM public.DimCustomers c
JOIN public.FactOrders o ON c.customer_id = o.customer_id
JOIN public.FactOrderItems oi ON o.order_id = oi.order_id
JOIN public.DimProducts p ON oi.product_id = p.product_id
WHERE c.gender IS NOT NULL 
GROUP BY c.gender, p.category
ORDER BY c.gender ASC, "Total_Revenue" DESC;
