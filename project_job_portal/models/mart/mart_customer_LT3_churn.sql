WITH customer_month_churn_calculation
AS(
	SELECT
		customer_id,
		Revenue_type,
		revenue,
		payment_month,
		MAX(payment_month) OVER(PARTITION BY customer_id ORDER BY payment_month DESC) AS last_payment_month
	FROM
		{{ ref('master_table') }}
	WHERE 
		Revenue_type=TRUE
),
compare AS(
	SELECT
		*,
		DATEDIFF(month,last_payment_month,'2020-01-05') AS Churn_month_period,
		CASE 
			WHEN 
				DATEDIFF(month,last_payment_month,'2020-01-05')>3
			THEN
				'Customer_churn' 
			WHEN
				DATEDIFF(month,last_payment_month,'2020-01-05')=0
			THEN
				'Active_customer' 
			ELSE
				'Active_customer' 
		END
		 AS LT3_Churn
	FROM 
		customer_month_churn_calculation

),
final_month AS(
	SELECT 
		
		LT3_Churn,
		SUM(revenue) AS LT3_Revenue,
		COUNT(LT3_Churn) AS LT3_Count,
	FROM
		compare
	GROUP BY
		LT3_Churn
	
)
SELECT
	* 
FROM
	final_month



