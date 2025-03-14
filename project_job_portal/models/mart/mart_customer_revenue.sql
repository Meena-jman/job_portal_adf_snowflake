WITH customer_revenue_rank
AS (
    SELECT 
        customer_id,
        customername,
        SUM(revenue*Quantity) AS total_revenue,
        RANK() OVER(ORDER BY SUM(revenue) DESC) AS revenue_rank
    FROM
        {{ ref('master_table') }}
    GROUP BY
        customer_id,
        customername      
)
SELECT
    *
FROM 
    customer_revenue_rank
ORDER BY
    total_revenue DESC