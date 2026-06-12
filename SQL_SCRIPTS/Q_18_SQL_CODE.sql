-- Q18. Is there any relationship between payment method and order status?
WITH Method_Status_Counts AS (
    SELECT 
        fp.method AS "Payment_Method",
        fo.status AS "Order_Status",
        COUNT(DISTINCT fo.order_id) AS "Total_Orders"
    FROM public.FactPayment fp
    JOIN public.FactOrders fo ON fp.order_id = fo.order_id
    GROUP BY fp.method, fo.status
),
Method_Totals AS (
    SELECT 
        "Payment_Method",
        SUM("Total_Orders") AS "Method_Total_Orders"
    FROM Method_Status_Counts
    GROUP BY "Payment_Method"
)
SELECT 
    m."Payment_Method",
    m."Order_Status",
    m."Total_Orders",
    ROUND((m."Total_Orders" * 100.0) / t."Method_Total_Orders", 2) AS "Percentage_Within_Method(%)"
FROM Method_Status_Counts m
JOIN Method_Totals t ON m."Payment_Method" = t."Payment_Method"
ORDER BY m."Payment_Method", m."Total_Orders" DESC;
