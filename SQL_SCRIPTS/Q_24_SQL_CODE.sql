-- Q24. Which product pairs generate the highest total revenue when sold together?
WITH Order_Product_Revenue AS (
    SELECT 
        oi.order_id, 
        oi.product_id,
        SUM(oi.quantity * p.unit_price) AS product_revenue
    FROM public.FactOrderItems oi
    JOIN public.DimProducts p ON oi.product_id = p.product_id
    GROUP BY oi.order_id, oi.product_id
)
SELECT 
    p1.product_name AS "Product_1",
    p2.product_name AS "Product_2",
    COUNT(DISTINCT opr1.order_id) AS "Times_Purchased_Together",
    ROUND(SUM(opr1.product_revenue + opr2.product_revenue), 2) AS "Combined_Revenue"
FROM Order_Product_Revenue opr1
JOIN Order_Product_Revenue opr2 ON opr1.order_id = opr2.order_id AND opr1.product_id < opr2.product_id
JOIN public.DimProducts p1 ON opr1.product_id = p1.product_id
JOIN public.DimProducts p2 ON opr2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY "Combined_Revenue" DESC
LIMIT 10;
