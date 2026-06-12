-- Q12. Generate a list of cancellation rate by city; also the cancellation rate for customers.
-- (Part A: By City)
SELECT 
    c.city AS "City",
    COUNT(DISTINCT o.order_id) AS "Total_Orders",
    COUNT(DISTINCT CASE WHEN o.status = 'Cancelled' THEN o.order_id END) AS "Cancelled_Orders",
    ROUND((COUNT(DISTINCT CASE WHEN o.status = 'Cancelled' THEN o.order_id END) * 100.0) / COUNT(DISTINCT o.order_id), 2) AS "Cancellation_Rate(%)"
FROM public.DimCustomers c
JOIN public.FactOrders o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY "Cancellation_Rate(%)" DESC;

-- (Part B: By Customer)
SELECT 
    c.customer_id,
    c.full_name,
    COUNT(DISTINCT o.order_id) AS "Total_Orders",
    COUNT(DISTINCT CASE WHEN o.status = 'Cancelled' THEN o.order_id END) AS "Cancelled_Orders",
    ROUND((COUNT(DISTINCT CASE WHEN o.status = 'Cancelled' THEN o.order_id END) * 100.0) / NULLIF(COUNT(DISTINCT o.order_id), 0), 2) AS "Cancellation_Rate(%)"
FROM public.DimCustomers c
JOIN public.FactOrders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.full_name
ORDER BY "Cancellation_Rate(%)" DESC;