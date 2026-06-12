-- Q25. Generate a daily report containing the columns Date, Total Orders, Total Items, Completed Orders, Cancelled Orders, Total Revenue
SELECT
    DATE(o.order_date) AS "Date",
    COUNT(DISTINCT o.order_id) AS "Total_Orders",
    SUM(oi.quantity) AS "Total_Items",
    COUNT(DISTINCT CASE WHEN LOWER(o.status) = 'completed' THEN o.order_id END) AS "Completed Orders",
    COUNT(DISTINCT CASE WHEN LOWER(o.status) = 'cancelled' THEN o.order_id END) AS "Cancelled Orders",
    ROUND(SUM(CASE WHEN LOWER(o.status) = 'completed' THEN oi.quantity * p.unit_price ELSE 0 END), 2) AS "Total_Revenue"
FROM public.FactOrders o
JOIN public.FactOrderItems oi ON o.order_id = oi.order_id
JOIN public.DimProducts p ON oi.product_id = p.product_id
GROUP BY DATE(o.order_date)
ORDER BY "Date" DESC;