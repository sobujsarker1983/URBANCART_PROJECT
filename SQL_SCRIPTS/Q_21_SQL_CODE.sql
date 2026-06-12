-- Q21. What is the average number of items per order by payment method?
WITH Order_Items AS (
    SELECT 
        order_id,
        SUM(quantity) AS total_items
    FROM public.FactOrderItems
    GROUP BY order_id
)
SELECT 
    fp.method AS "Payment_Method",
    ROUND(AVG(oi.total_items), 2) AS "Average_Items_Per_Order"
FROM public.FactPayment fp
JOIN Order_Items oi ON fp.order_id = oi.order_id
GROUP BY fp.method
ORDER BY "Average_Items_Per_Order" DESC;