
WITH transaction_data
AS(
	SELECT
		CAST(customer_id AS INT)	 AS customer_id,
		CAST(product_id AS varchar(50))		AS product_id,
		CAST(payment_month AS DATE)		AS PAyment_month,
		CAST(revenue_type AS BOOLEAN)	AS Revenue_type,
		CAST(revenue AS DECIMAL)	AS Revenue,
		CAST(quantity AS INT)   AS Quantity,
		CAST(companies AS varchar(50))	    AS Company
	FROM
		{{source('job_portal_source', 'TRANSACTION1')}}
	WHERE
		customer_id IS NOT NULL

)
SELECT 
	*
FROM
	transaction_data