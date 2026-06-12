-- Q3. What percent of total customers uses gmail?
WITH Gmail_Count AS (
    SELECT COUNT(*) AS Gmail_Users 
    FROM public.DimCustomers 
    WHERE email LIKE '%@gmail.com'
),
Total_Count AS (
    SELECT COUNT(*) AS Total_Customers 
    FROM public.DimCustomers
)
SELECT 
    g.Gmail_Users AS "Total_Gmail_User",
    t.Total_Customers AS "Total_Customers", 
    ROUND((g.Gmail_Users * 100.0) / t.Total_Customers, 2) AS "Gmail_Percentage(%)"
FROM Gmail_Count g, Total_Count t;