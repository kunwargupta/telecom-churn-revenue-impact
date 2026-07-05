CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT crosstab(
	$$
	select gender, churn, count(*)
	from telco_customer_clean
	GROUP by gender, churn
	order by gender, churn
	$$,
	
	$$
	SELECT distinct churn
	from telco_customer_clean
	ORDER by churn
	$$
) AS ct (
	gender VARCHAR
	'No' as int
	'Yes' as int
);