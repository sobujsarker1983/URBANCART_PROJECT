-- Q22. Create a list to show the difference between the category average price and product’s price for all the products.
SELECT 
    product_id,
    product_name,
    category,
    unit_price,
    ROUND(AVG(unit_price) OVER(PARTITION BY category), 2) AS "Category_Average_Price",
    ROUND(unit_price - AVG(unit_price) OVER(PARTITION BY category), 2) AS "Price_Difference"
FROM public.DimProducts;