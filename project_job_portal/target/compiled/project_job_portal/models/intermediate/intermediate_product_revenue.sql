WITH product_rev
AS(
    SELECT
        product_id,
        product_family,
        SUM(revenue) AS Total_revenue
    FROM
        JOB_PORTAL.Intermediate.master_table
    GROUP BY
        product_id,
        product_family
    ORDER BY
        Total_revenue DESC
)