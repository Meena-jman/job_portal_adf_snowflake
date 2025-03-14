
  
    

        create or replace transient table JOB_PORTAL.mart.mart_product_revenue
         as
        (WITH product_rev
AS(
    SELECT
        UPPER(product_id) as product_id,
        product_family,
        SUM(revenue*Quantity) AS Total_revenue,
        RANK() OVER(ORDER BY SUM(revenue*Quantity) DESC) AS Revenue_rank
    FROM
        JOB_PORTAL.Intermediate.master_table
    GROUP BY
        product_id,
        product_family
    ORDER BY
        Total_revenue DESC
)
SELECT * FROM product_rev
        );
      
  