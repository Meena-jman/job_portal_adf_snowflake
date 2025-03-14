WITH product_data
AS(
	SELECT
		DISTINCT(UPPER(product_id)) AS product_id,
		product_family,
		product_sub_family
	FROM
		{{source('job_portal_source', 'PRODUCT')}}
	WHERE
		product_id IS NOT NULL
)
SELECT
	*
FROM
	product_data