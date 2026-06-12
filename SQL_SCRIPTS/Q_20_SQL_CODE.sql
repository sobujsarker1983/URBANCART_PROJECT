-- Q20. Are higher-value orders associated with specific payment methods?
WITH Order_Values AS (
    SELECT 
        fo.order_id,
        SUM(oi.quantity * p.unit_price) AS order_total
    FROM public.FactOrders fo
    JOIN public.FactOrderItems oi ON fo.order_id = oi.order_id
    JOIN public.DimProducts p ON oi.product_id = p.product_id
    GROUP BY fo.order_id
)
SELECT 
    fp.method AS "Payment_Method",
    ROUND(AVG(ov.order_total), 2) AS "Average_Order_Value",
    ROUND(MAX(ov.order_total), 2) AS "Max_Order_Value"
FROM public.FactPayment fp
JOIN Order_Values ov ON fp.order_id = ov.order_id
GROUP BY fp.method
ORDER BY "Average_Order_Value" DESC;