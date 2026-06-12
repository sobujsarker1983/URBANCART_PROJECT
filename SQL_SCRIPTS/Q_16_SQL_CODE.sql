-- Q16. Generate a list of customers who ordered both in October & December.
SELECT DISTINCT c.customer_id, c.full_name, c.email
FROM public.DimCustomers c
JOIN public.FactOrders o ON c.customer_id = o.customer_id
WHERE DATE_TRUNC('month', o.order_date) = DATE '2025-10-01'
INTERSECT
SELECT DISTINCT c.customer_id, c.full_name, c.email
FROM public.DimCustomers c
JOIN public.FactOrders o ON c.customer_id = o.customer_id
WHERE DATE_TRUNC('month', o.order_date) = DATE '2025-12-01';