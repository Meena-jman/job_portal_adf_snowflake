
 WITH Contraction_revenue
 AS(
    SELECT
        revenue,
        payment_month,
        LAG(revenue) OVER(ORDER BY payment_month) AS previous_revenue
    FROM
        {{ref('master_table')}}  
)
SELECT
    *,
    CASE
        WHEN 
            previous_revenue>revenue 
        THEN
             previous_revenue-revenue
        ELSE
            0
    END 
    AS loss
FROM
    Contraction_revenue
ORDER BY 
    payment_month