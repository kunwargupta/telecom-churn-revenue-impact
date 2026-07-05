-- Which contract type has the highest customer churn rate?

SELECT 
		contract,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 end) as churned_customers,
		sum(case when churn = 'No' then 1 end) as retained_customers,
		round(sum((case when churn = 'Yes' then 1 end)) * 100 / count(*), 2) as churn_rate
from telco_customer_clean
group by contract
order by churn_rate desc;


-- How much monthly revenue is lost due to churn across different contract types?
SELECT 
		contract,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 end) as churned_customers,
		sum(case when churn = 'No' then 1 end) as retained_customers,
		sum(case when churn = 'Yes' then monthlycharges end) as lost_revenus,
		sum(case when churn = 'No' then monthlycharges end) as retained_revenus
from telco_customer_clean
group by contract
order by lost_revenus desc;


-- Average monthly charges of churned vs retained customers

select
	churn,
	count(*) as customers,
	round(avg(monthlycharges),2) as avg_monthly_charge,
	round(avg(totalcharges),2) as avg_total_charge
from telco_customer_clean
group by churn;

--  Which payment method has the highest churn rate?

--   Objective:
--   Identify whether certain payment methods are associated
--   with higher customer churn.

select
		paymentmethod,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 end) as churned_customers,
		round(sum(case when churn = 'Yes' then 1 end) * 100.0 / count(*), 2) as churn_rate
from telco_customer_clean
group by paymentmethod
order by churn_rate desc;


-- Which Internet Service type has the highest churn rate?

SELECT 
		internetservice,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
		round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as churn_rate
from telco_customer_clean
GROUP by internetservice
order by churn_rate desc;


-- Does customer tenure impact churn?

with cte as (
		select 	
				customer_id,
				churn,
				case
					when tenure <= 10 then '0-10'
					when tenure <= 20 then '11-20'
					when tenure <= 30 then '21-30'
					when tenure <= 40 then '31-40' 
					when tenure <= 50 then '41-50'
					when tenure <= 60 then '51-60'
					else '61-72'
				end as tenure_bucket
		from telco_customer_clean
)

select 
		tenure_bucket,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
		round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as churn_rate
from cte
group by tenure_bucket
order by tenure_bucket;


-- Do customers with higher monthly charges churn more?

with cte as (
		select 
				customer_id,
				churn,
				case
					when monthlycharges <= 38 then '18-38'
					when monthlycharges <= 58 then '39-58'
					when monthlycharges <= 78 then '59-78'
					when monthlycharges <= 98 then '79-98'
					else '99-119'
				end as monthlycharges_bucket
		from telco_customer_clean
		
)

SELECT 
		monthlycharges_bucket,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
		round(sum(case when churn = 'Yes' then 1 else 0 end) * 100 / count(*), 2) as churn_rate
from cte
group by monthlycharges_bucket
order by churn_rate desc;

-- Which customer segments are high value but still leaving?

 with cte as (
 	select 
 		customer_id,
		churn,
		totalcharges,
 		ntile(3) over(order by totalcharges) as ntiles
 	from telco_customer_clean
 )

 select 
 		case 
			when ntiles = 1 then 'Low Value'
			when ntiles = 2 then 'Medium Value'
			else 'High Value'
		end as Segment,
		count(*) as cutomers,
		sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
		round(sum(case when churn = 'Yes' then 1 else 0 end) * 100.0 / count(*), 2) as churn_rate
from cte
GROUP by Segment
order by churn_rate desc;

-- Which service-related factors contribute most to churn?

with cte as (
		select 	customer_id,
				churn,
				case 
				when onlinesecurity = 'No' and onlinesecurity = 'No internet service' and 
					techsupport = 'No'  techsupport = 'No internet service' or
					deviceprotection = 'No' or deviceprotection = 'No internet service' or
					Onlinebackup = 'No' or Onlinebackup = 'No internet service'
					then 'No support services'
				else 'Has support services'
				end as support_segment
		from telco_customer_clean
)

select 
		support_segment,
		count(*) as customers,
		sum(case when churn = 'Yes' then 1 else 0 end) as churned_customers,
		round(sum(case when churn = 'Yes' then 1 else 0 end) * 100 / count(*), 2) as churn_rate
from cte
group by support_segment
order by churn_rate desc;


-- Which customer segments contribute the highest revenue loss?

WITH customer_segment AS (

	SELECT
		customer_id,
		churn,
		totalcharges,

		CONCAT(
			internetservice,
			' + ',
			contract
		) AS segment

	FROM telco_customer_clean
),

segment_revenue AS (

	SELECT
		segment,

		COUNT(*) AS customers,

		SUM(
			CASE
				WHEN churn = 'Yes'
				THEN 1
				ELSE 0
			END
		) AS churned_customers,

		ROUND(
			SUM(
				CASE
					WHEN churn = 'Yes'
					THEN 1
					ELSE 0
				END
			) * 100.0 / COUNT(*),
		2) AS churn_rate,


		SUM(
			CASE
				WHEN churn = 'Yes'
				THEN totalcharges
				ELSE 0
			END
		) AS lost_revenue

	FROM customer_segment

	GROUP BY segment
)

SELECT

	segment,
	customers,
	churned_customers,
	churn_rate,
	lost_revenue,

	RANK() OVER(
		ORDER BY lost_revenue DESC
	) AS revenue_loss_rank

FROM segment_revenue;


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

