create table telco_customer_clean as
select *
from telco_customer;

-- Review it 
select *
from telco_customer_clean
LIMIT 10;

-- Handle Blank TotalCharges
UPDATE telco_customer_clean
set totalcharges = 0
where TRIM(totalcharges) = '';

-- Convert TotalCharges to Numeric
Alter TABLE telco_customer_clean
ALTER COLUMN totalcharges
TYPE numeric(10,2)
USING totalcharges::Numeric;

-- Verify Conversion
SELECT min(totalcharges), max(totalcharges), avg(totalcharges)
from telco_customer_clean;

-- Check for Remaining NULLs
select count(*)
from telco_customer_clean
where totalcharges is null;

-- Validate Data Again
SELECT count(*), count(totalcharges)
from telco_customer_clean;



