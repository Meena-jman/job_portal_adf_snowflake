WITH customer_data_conversion
AS(
    SELECT
        DISTINCT(customer_id) AS customer_id,
        company AS Company,
        customername AS Customername
	FROM 
		job_portal.raw.CUSTOMERS
	WHERE 
		customer_id IS NOT NULL
	AND
		customer_id <> 'Job portal'
		
),
Casting_data AS(
	SELECT 
		Company,
		CAST(customer_id AS INT) AS customer_id,
		Customername 
	FROM
		customer_data_conversion

)

SELECT 
   *
FROM 
    Casting_data