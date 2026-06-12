-- Q15. Generate a list of customers who ordered in October but didn’t order in December.
SELECT DISTINCT c.customer_id, c.full_name, c.email
FROM public.DimCustomers c
JOIN public.FactOrders o ON c.customer_id = o.customer_id
WHERE DATE_TRUNC('month', o.order_date) = DATE '2025-10-01'
  AND NOT EXISTS (
      SELECT 1 
      FROM public.FactOrders o2 
      WHERE o2.customer_id = c.customer_id 
        AND DATE_TRUNC('month', o2.order_date) = DATE '2025-12-01'
  );
