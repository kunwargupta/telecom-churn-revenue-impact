-- Total rows
select count(*)
from telco_customer;

-- Preview Data
select *
from telco_customer
limit 10;

-- Count columns
select count(*)
from information_schema.columns
where table_name = 'telco_customer';

