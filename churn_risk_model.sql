-- Customer Churn Risk Scoring Model

with cte as (
	select
			customer_id,
			churn,

			(
			case 
				when tenure <= 10 then 1 
				else 0 
			end

			+

			case 
				when contract = 'Month-to-month' then 1
				else 0
			end

			+

			case 
				when monthlycharges > (select avg(monthlycharges) from telco_customer_clean)
				then 1
				else 0
			end

			+

			case
				when techsupport = 'No'
				and onlinesecurity = 'No'
				then 1
				else 0
			end

			+

			case 
				when seniorcitizen = 1 
				then 1
				else 0
			end

			+

			case 
				when partner = 'No'
				and dependents = 'No'
				then 1
				else 0
			end

			) as risk_score

	from telco_customer_clean
),

risk_category as (

	select 
			customer_id,
			churn,
			risk_score,

			case
				when risk_score >= 4 then 'High Risk'
				when risk_score between 2 and 3 then 'Medium Risk'
				else 'Low Risk'
			end as risk_segment

	from cte
)


select
		risk_segment,

		count(*) as customers,

		sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,

		round(
			sum(case when churn = 'Yes' then 1 else 0 end) 
			* 100.0 / count(*), 
		2) as churn_rate

from risk_category

group by risk_segment

order by churn_rate desc;

