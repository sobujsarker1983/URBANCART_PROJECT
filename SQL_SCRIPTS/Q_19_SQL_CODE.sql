-- Q19. Do certain cities prefer specific payment methods?
SELECT 
    c.city AS "City",
    fp.method AS "Payment_Method",
    COUNT(fp.payment_id) AS "Usage_Count",
    ROW_NUMBER() OVER (PARTITION BY c.city ORDER BY COUNT(fp.payment_id) DESC) AS "Preference_Rank"
FROM public.DimCustomers c
JOIN public.FactOrders fo ON c.customer_id = fo.customer_id
JOIN public.FactPayment fp ON fo.order_id = fp.order_id
GROUP BY c.city, fp.method
ORDER BY c.city, "Usage_Count" DESC;