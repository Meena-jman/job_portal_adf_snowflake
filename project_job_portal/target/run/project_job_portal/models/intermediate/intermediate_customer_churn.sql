
  
    

        create or replace transient table JOB_PORTAL.Intermediate.intermediate_customer_churn
         as
        (WITH customer_churn_calculation
AS(
	SELECT
		customer_id,
		revenue_type,
		MAX(payment_month) OVER(PARTITION BY customer_id ORDER BY payment_month DESC) AS last_payment_month
	FROM
		JOB_PORTAL.Intermediate.master_table
	WHERE 
		revenue_type='TRUE'
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
		 AS LT3_Churn,

		 DATEDIFF(year,last_payment_month,'2020-01-05') AS Churn_year_period,
		 CASE 
			WHEN 
				DATEDIFF(year,last_payment_month,'2020-01-05')>=1
			THEN
				'Customer_churn' 
			ELSE
				'Active_customer' 
			END
		 AS LTM_Churn
	FROM 
		customer_churn_calculation

),
final AS(
	SELECT 
		COUNT(customer_id) AS Total_Customers,
		LT3_Churn,
		COUNT(LT3_Churn) AS LT3_Count,
		LTM_Churn,
		COUNT(LTM_Churn) AS LTM_Count
	FROM
		compare
	GROUP BY
		
		LT3_Churn,
		LTM_Churn
		
)

SELECT
	* 
FROM
	final


-- SELECT MAX(payment_month) FROM JOB_PORTAL.Intermediate.master_table
        );
      
  