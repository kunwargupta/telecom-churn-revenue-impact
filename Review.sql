-- Verify row count
select count(*)
from telco_customer;

-- Check Duplicate Customers
select customer_Id
from telco_customer
group by customer_id
having count(*) > 1;

-- Check NULL Values
SELECT 
		count(*) as total_rows,
		count(customer_id) as customer_id,
		count(gender) as gender,
		count(tenure) as tenure,
		count(MonthlyCharges) as monthlycharges,
		count(TotalCharges) as TotalCharges,
		count(churn) as churn
FROM telco_customer;

-- Check Blank Strings
SELECT count(*) as blank_total_charges
FROM telco_customer
WHERE TRIM(totalcharges) = '';


select count(*) as blank_customer_id
from telco_customer
where trim(customer_id) = '';


-- Explore Categorical Values
select distinct gender
from telco_customer;

select distinct multiplelines
from telco_customer;

SELECT distinct InternetService 
from telco_customer;

SELECT distinct Contract
from telco_customer;

SELECT distinct PaymentMethod
from telco_customer;

-- Numeric Validation
select min(tenure), max(tenure)
from telco_customer;

select min(MonthlyCharges), max(MonthlyCharges)
from telco_customer;


-- Data type issues
SELECT count(*) as blank_values
from telco_customer
where trim(totalcharges) = ''

select customer_id, totalcharges
from telco_customer
where trim(totalcharges) != '' and
totalcharges !~ '^[0-9]+(\.[0-9]+)?$';
