/* Customer Demographics */

-- Total Customers
SELECT count(customer_id) as totalCustomers
from telco_customer_clean;

-- Active vs Churned customers
SELECT 'Active', count(*) as cnt
from telco_customer_clean
where churn = 'No'
UNION ALL
select 'Churned', count(*) as cnt
FROM telco_customer_clean
WHERE churn = 'Yes';

select churn, count(*) as customers, round(count(*) * 100 / sum(count(*)) over(), 2) as percentage
from telco_customer_clean
group by churn;

-- select churn, count(*) as customers, sum(count(*)) over() as percentage
-- from telco_customer_clean
-- group by churn;

-- Gender Distribution
SELECT gender, count(*) as customers, round(count(*) * 100/ sum(count(*)) OVER(), 2) as percentage
FROM telco_customer_clean
group by gender;

-- Gender Distribution across churn
SELECT gender, 
		sum(case when churn = 'Yes' then 1 end) as churned,
		sum(case when churn = 'No' then 1 end) as retained,
		round(count(case when churn = 'Yes' then 1 end) * 100.0 /count(*), 2) as churn_rate
from telco_customer_clean
group by gender;

-- SELECT gender, 
-- 		sum(case when churn = 'Yes' then 1 end) as churned,
-- 		sum(case when churn = 'No' then 1 end) as retained,
-- 		count(*) as churn_rate
-- from telco_customer_clean
-- group by gender;


-- Contract Distribution
SELECT 	contract,
		count(*) as customers,
		round(count(*) * 100 / sum(count(*)) over(), 2) as percentage
from telco_customer_clean
GROUP by contract
ORDER by customers desc;

-- Revenue Overview
SELECT
		round(avg(monthlycharges), 2) as avg_monthly_charges,
		round(avg(totalcharges), 2) as avg_total_charges,
		round(avg(tenure), 2) as avg_tenure
from telco_customer_clean;

-- Internet Service Distribution
SELECT
		InternetService,
		count(*) as customers,
		round(count(*) * 100 / sum(count(*)) over(), 2) as percentage
from telco_customer_clean
group by InternetService
order by customers desc;

-- Statistical Summary
SELECT 
		min(tenure) as min_tenure,
		max(tenure) as max_tenure,
		min(monthlycharges) as min_monthly_charges,
		max(monthlycharges) as max_monthly_charges,
		min(totalcharges) as min_total_charges,
		max(totalcharges) as max_total_charges	
from telco_customer_clean;


