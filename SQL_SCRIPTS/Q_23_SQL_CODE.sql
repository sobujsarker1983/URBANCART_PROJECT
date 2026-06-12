-- Q23. Which product pairs are most frequently purchased together in the same order?
WITH Order_Product_List AS (
    SELECT order_id, product_id 
    FROM public.FactOrderItems
    GROUP BY order_id, product_id
)
SELECT 
    p1.product_name AS "Product_1",
    p2.product_name AS "Product_2",
    COUNT(DISTINCT opl1.order_id) AS "Times_Purchased_Together"
FROM Order_Product_List opl1
JOIN Order_Product_List opl2 ON opl1.order_id = opl2.order_id AND opl1.product_id < opl2.product_id
JOIN public.DimProducts p1 ON opl1.product_id = p1.product_id
JOIN public.DimProducts p2 ON opl2.product_id = p2.product_id
GROUP BY p1.product_name, p2.product_name
ORDER BY "Times_Purchased_Together" DESC
LIMIT 10;