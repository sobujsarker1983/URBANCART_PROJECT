-- Q9. What is the average order value (AOV) and Average Basket Size?
WITH Order_Metrics AS (
    SELECT 
        oi.order_id,
        SUM(oi.quantity) AS total_items,
        SUM(oi.quantity * p.unit_price) AS order_value
    FROM public.FactOrderItems oi
    JOIN public.DimProducts p ON oi.product_id = p.product_id
    GROUP BY oi.order_id
)
SELECT 
    ROUND(AVG(order_value), 2) AS "Average_Order_Value",
    ROUND(AVG(total_items), 2) AS "Average_Basket_Size"
FROM Order_Metrics;uct_id;