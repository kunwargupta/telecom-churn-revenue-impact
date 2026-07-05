# Telecom Churn Risk Segmentation & Revenue Loss Analysis

## Overview

Customer churn analysis on real telecom data. Goal: Find which customers leave, why they leave, and how much revenue walks out the door. Built entirely in SQL using PostgreSQL.

This isn't a tutorial project. It's a case study you'd see in a real data analyst role — segment customers, measure impact, recommend action.

## Problem

Telecom company losing customers. Need answers fast:

- Who's leaving?
- What patterns predict churn?
- Which segments cost us the most money?
- Who do we save first?

## Dataset

**Telco Customer Churn** (Kaggle)

- 7,043 customers
- 21 attributes per customer (demographics, services, billing, contract)
- Binary churn target (Yes/No)

Free download: [kaggle.com/datasets/blastchar/telco-customer-churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn)

## Tech Stack

| Component | Tool |
|-----------|------|
| Database | PostgreSQL |
| Client | pgAdmin 4 |
| Language | SQL |
| Environment | Local |

## What This Project Covers

### Data Cleaning
- Checked null values in TotalCharges column
- Found: newly joined customers with zero tenure had blank billing data
- Action: replaced blanks with 0 (legitimate)
- Verified no duplicates

### Core Analysis (11 Business Questions)

1. **Contract Type Impact** — Month-to-month contracts show 42% churn. Two-year contracts drop to 3%.
2. **Revenue Loss by Contract** — Which contracts cost us the most money? Month-to-month bleeds 1.73M alone.
3. **Payment Method** — Does how people pay affect whether they stay?
4. **Internet Service Type** — Fiber optic customers churn more (42%) than DSL (19%).
5. **Customer Tenure** — First 10 months are critical. Churn rate: 49%. By year 5+: 7%.
6. **Monthly Charges** — Higher bills correlate with higher churn. Price sensitivity real.
7. **Churn vs Retained: Charges** — Churned customers pay more per month (74.44) but have lower lifetime value (1531.80).
8. **Customer Value Segments** — Split customers into Low/Medium/High value. Low-value churn most.
9. **Support Services** — Customers with tech support, security, or backup services stay longer. Statistically significant.
10. **Revenue Loss by Segment** — Fiber + month-to-month is the kill zone. 54.61% churn. 1.73M revenue loss.
11. **Churn Risk Model** — Built scoring system: High-Risk (59% churn), Medium-Risk (24% churn), Low-Risk (5% churn).

## Key Findings

### Early Customer Experience Matters
- 0-10 months: 49% churn
- 61-72 months: 7% churn
- **Action**: Onboarding campaigns, early engagement programs, faster support response

### Month-to-Month Contracts Are Risk
- 42% churn vs 3% for two-year
- **Action**: Incentivize annual contracts through discounts or loyalty benefits

### High Bills = Higher Churn
- Churned: avg 74.44/mo. Retained: avg 61.27/mo
- **Action**: Review pricing. Test retention discounts for high-bill customers.

### Fiber + Month-to-Month = Biggest Problem
- 2,128 customers. 1,162 churned. 54.61% churn rate.
- Revenue loss: 1.73M
- **Action**: Priority retention target. Proactive outreach, service audits.

### Support Services Reduce Churn
- Customers with tech support + device protection: lower churn
- **Action**: Bundle support services. Make them default on signup.

### Risk Model Works
- High-Risk segment: 1,809 customers, 59% churn
- Medium-Risk: 2,790 customers, 24% churn
- Low-Risk: 2,444 customers, 5% churn
- **Action**: Use scoring to rank customers for retention campaigns before they leave

## Challenges Faced & Solutions

### 1. TotalCharges Data Quality Issue

**Problem**: Some TotalCharges values were blank.

**Investigation**: Checked related records. Found:
- Tenure = 0 months
- Customers had annual or two-year contracts
- No billing history yet

**Root Cause**: Newly joined customers hadn't completed first billing cycle.

**Solution**: Converted blank values to 0 to maintain numerical consistency.

---

### 2. Incorrect Data Type

**Problem**: TotalCharges stored as text (due to blanks). Broke revenue calculations.

**Solution**: Cleaned invalid values, converted TotalCharges to numeric.

---

### 3. Customer Segmentation Bias

**Problem**: Manual value buckets (0-2000 = Low, 2000-5000 = Medium) had no statistical basis. Arbitrary.

**Solution**: Used NTILE() window function to divide customers into equal value groups based on TotalCharges. Eliminated bias.

---

### 4. Churn % vs Business Impact

**Problem**: Highest churn percentage doesn't always mean highest revenue loss. A small segment could bleed more money.

**Solution**: Created separate revenue loss analysis. Ranked segments by impact using RANK() window function. Found: Fiber + month-to-month (54% churn) = 1.73M loss. DSL month-to-month (25% churn) = only 761K loss.

---

### 5. Historical vs Predictive Churn

**Problem**: Analyzing historical churn only. Doesn't help decide which active customers need attention now.

**Solution**: Built SQL-based churn risk scoring. Used business rules:
- Tenure < 12 months
- Month-to-month contract
- High monthly charges
- No support services
- Senior citizen / no dependents

Classified all active customers as High/Medium/Low Risk. Now you can prioritize retention before they leave.

## SQL Skills Used

### Basic
- SELECT, WHERE, GROUP BY, ORDER BY
- Aggregate functions (COUNT, SUM, AVG, MAX)

### Intermediate
- CASE WHEN conditional logic
- Conditional aggregations (SUM with WHERE inside aggregate)
- Subqueries and NOT IN
- Common Table Expressions (CTEs)

### Advanced
- Multiple CTEs in single query
- Window functions: NTILE(), RANK()
- Feature engineering and customer segmentation
- Risk categorization logic

## Files in This Project

```
Customer-Churn-Analysis/
├── dataset/
│   └── telco_customer_churn.csv
├── sql/
│   ├── 01_table_creation.sql
│   ├── 02_data_inspection.sql
│   ├── 03_data_cleaning.sql
│   ├── 04_eda.sql
│   ├── 05_business_analysis.sql
│   └── 06_churn_risk_model.sql
├── README.md
└── insights.md
```

## How to Run

1. Download dataset from Kaggle
2. Create PostgreSQL database
3. Run SQL scripts in order (01 → 06)
4. Review insights.md for full findings

## Results You Can Show

- 11 complete business analyses with SQL queries
- Customer segmentation framework
- Risk scoring model (validated against actual churn)
- Revenue impact quantified by segment
- Specific, actionable recommendations per segment

## Resume Points

"Performed end-to-end customer churn analysis using PostgreSQL on 7K+ telecom customers. Built customer segmentation and churn risk model using CTEs, CASE WHEN, and window functions. Identified high-risk segment losing 1.73M in revenue and recommended targeted retention strategy."

---

*Check insights.md for detailed query breakdowns and business logic.*
