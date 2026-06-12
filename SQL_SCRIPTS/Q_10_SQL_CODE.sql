-- Q10. Which products are at risk of stock-out due to high sales volume and low inventory?
SELECT 
    p.product_name AS "Product_Name",
    p.stock AS "Current_Stock",
    SUM(oi.quantity) AS "Sales_Volume"
FROM public.FactOrderItems oi
JOIN public.DimProducts p ON oi.product_id = p.product_id
JOIN public.FactOrders o ON oi.order_id = o.order_id
WHERE o.order_date >= DATE '2025-11-01'  -- আপনার ডাটার টাইমলাইন অনুযায়ী ফিক্সড ডেট
GROUP BY p.product_name, p.stock
HAVING p.stock < SUM(oi.quantity)
ORDER BY "Current_Stock" ASC, "Sales_Volume" DESC;