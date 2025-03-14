WITH new_customer AS (
    SELECT
        customer_id,
        customername,
        MIN(payment_month) AS first_order_date
    FROM
       {{ref('master_table')}}
    GROUP BY 
        customer_id,
        customername
)
SELECT
    year(first_order_date) AS fiscal_year,
    count(customer_id) AS No_of_new_customers
FROM
    new_customer
GROUP BY
    fiscal_year
ORDER BY
    fiscal_year
 

