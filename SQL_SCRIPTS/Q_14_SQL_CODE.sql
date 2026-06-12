-- Q14. How does customer purchasing behavior change over time since account creation?
WITH Customer_Monthly_Order AS (
    SELECT 
        o.customer_id,
        o.order_id,
        o.order_date,
        SUM(oi.quantity * p.unit_price) AS order_revenue
    FROM public.FactOrders o
    JOIN public.FactOrderItems oi ON o.order_id = oi.order_id
    JOIN public.DimProducts p ON oi.product_id = p.product_id
    GROUP BY o.customer_id, o.order_id, o.order_date
)
SELECT
    c.customer_id,
    c.full_name,
    c.created_at AS account_creation_date,
    ((EXTRACT(YEAR FROM m.order_date) - EXTRACT(YEAR FROM c.created_at)) * 12 + 
     (EXTRACT(MONTH FROM m.order_date) - EXTRACT(MONTH FROM c.created_at))) AS month_since_signup,
    COUNT(DISTINCT m.order_id) AS total_orders,
    ROUND(SUM(m.order_revenue), 2) AS total_spent,
    ROUND(AVG(m.order_revenue), 2) AS avg_order_value
FROM public.DimCustomers c
JOIN Customer_Monthly_Order m ON c.customer_id = m.customer_id
GROUP BY
    c.customer_id,
    c.full_name,
    c.created_at,
    ((EXTRACT(YEAR FROM m.order_date) - EXTRACT(YEAR FROM c.created_at)) * 12 + 
     (EXTRACT(MONTH FROM m.order_date) - EXTRACT(MONTH FROM c.created_at)))
ORDER BY c.customer_id, month_since_signup;