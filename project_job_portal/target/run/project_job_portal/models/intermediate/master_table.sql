
  
    

        create or replace transient table JOB_PORTAL.Intermediate.master_table
         as
        (WITH tablejoin1
AS(
    SELECT
        customer_id,
        join1.product_id AS product_id,
        product_family,
        payment_month,
        revenue,
        Quantity,
        revenue_type
    FROM 
        JOB_PORTAL.staging.stg_product AS product
    INNER JOIN 
        JOB_PORTAL.staging.stg_transaction AS join1
    ON 
        join1.product_id=product.product_id

),
 mastertable AS(
        SELECT
            customer.customer_id AS customer_id,
            customer.Customername AS customername,
            product_id,
            product_family,
            payment_month,
            revenue,
            Quantity,
            Revenue_type
        FROM
            tablejoin1 AS join1
        INNER JOIN
           JOB_PORTAL.staging.stg_customer AS customer
        ON
            customer.customer_id=join1.customer_id
 )
SELECT
    *
FROM
    mastertable
        );
      
  