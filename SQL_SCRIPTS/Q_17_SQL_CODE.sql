-- Q17. Which payment methods are used most frequently?
SELECT 
    method AS "Payment_Method",
    COUNT(payment_id) AS "Usage_Count"
FROM public.FactPayment
GROUP BY method
ORDER BY "Usage_Count" DESC;