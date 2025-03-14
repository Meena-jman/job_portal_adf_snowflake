
  
    

        create or replace transient table JOB_PORTAL.RAW.jointable
         as
        (WITH tablejoin1
AS(
    SELECT
        customer.customer_id,
        customer.Customer_Name,
        product_id,
        payment_month,
        revenue,
        revenue_type
    FROM 
        JOB_PORTAL.staging.stg_customer AS customer 
    INNER JOIN 
        JOB_PORTAL.staging.stg_transaction AS trans
    ON 
        customer.customer_id=trans.customer_id
),
 tablejoin2 AS(
        SELECT
            customer_id,
            Customer_Name,
            join1.product_id,
            product_family,
            payment_month,
            revenue,
            revenue_type
        FROM
            tablejoin1 AS join1
        INNER JOIN
            JOB_PORTAL.staging.stg_product AS product
        ON
            join1.product_id=product.product_id
 )
SELECT
    *
FROM
    tablejoin2
        );
      
  