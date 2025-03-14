
  
    

        create or replace transient table JOB_PORTAL.staging.stg_product
         as
        (WITH product_data
AS(
	SELECT
		DISTINCT(UPPER(product_id)) AS product_id,
		product_family,
		product_sub_family
	FROM
		job_portal.raw.PRODUCT
	WHERE
		product_id IS NOT NULL
)
SELECT
	*
FROM
	product_data
        );
      
  