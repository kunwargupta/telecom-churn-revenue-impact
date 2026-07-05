create database telco_customer_churn;

create table customer_churn(
customer_id varchar(20) primary key,
gender varchar(10),
SeniorCitizen int,
Partner varchar(5),
Dependents varchar(5),
tenure int,	
PhoneService varchar(5),
MultipleLines varchar(25),
InternetService varchar(20),
OnlineSecurity varchar(25),
OnlineBackup varchar(25),
DeviceProtection varchar(25),
TechSupport varchar(25),
StreamingTV varchar(25),
StreamingMovies varchar(25),
Contract varchar(25),
PaperlessBilling varchar(5),
PaymentMethod varchar(40),
MonthlyCharges decimal(10,2),	
TotalCharges text,
Churn varchar(5)
);


alter table customer_churn
rename to telco;