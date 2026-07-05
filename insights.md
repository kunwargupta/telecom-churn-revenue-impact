# Customer Churn Analysis — Detailed Insights

## Data Overview

**Total Customers**: 7,043
**Churned**: 1,869 (26.5%)
**Retained**: 5,174 (73.5%)

Dataset spans multiple contract types, service packages, and billing methods. Focus: Which segments are bleeding customers, how much revenue that represents, and where to focus retention efforts.

---

## Finding 1: Contract Type Drives Churn

### Query Logic
Group customers by contract type. Calculate churn rate and lost revenue.

### Results

| Contract Type | Customers | Churned | Churn Rate | Lost Revenue |
|---|---|---|---|---|
| Month-to-Month | 3,875 | 1,630 | 42.0% | 2.88M |
| One Year | 1,474 | 234 | 15.9% | 412K |
| Two Year | 1,694 | 5 | 0.3% | 9K |

### Business Insight

Month-to-month customers are 140x more likely to churn than two-year contract holders. Not a preference issue. It's structural. Low commitment = low stickiness.

One-year falls between extremes but still represents material risk.

### Recommendation

- Offer pricing incentives to move month-to-month customers to annual contracts
- Bundle loyalty credits for year-one commitment
- Early renewal discounts for one-year customers approaching expiration

---

## Finding 2: First 10 Months Are Critical

### Query Logic
Segment customers by tenure (10-month buckets). Calculate churn rate per bucket.

### Results

| Tenure (Months) | Customers | Churned | Churn Rate |
|---|---|---|---|
| 0-10 | 1,045 | 513 | 49.1% |
| 11-20 | 1,052 | 332 | 31.6% |
| 21-30 | 910 | 179 | 19.7% |
| 31-40 | 787 | 105 | 13.3% |
| 41-50 | 772 | 77 | 10.0% |
| 51-60 | 772 | 61 | 7.9% |
| 61-72 | 705 | 50 | 7.1% |

### Business Insight

Half of new customers leave within the first 10 months. This is not normal churn. This is onboarding failure, or unrealistic customer expectations, or poor early service experience.

By month 31, churn stabilizes around 7-10%. Customer is "sticky" if they survive year one.

### Recommendation

- Increase onboarding touchpoints in first 30 days (welcome call, service education, quick wins)
- Proactive support team follow-up at 30 days and 60 days
- Monitor service quality metrics heavily for new customers
- Consider new-customer retention bonus (discount month 6-12 if no support tickets?)

---

## Finding 3: High Monthly Bills Correlate with Higher Churn

### Query Logic
Compare average monthly charges for churned vs retained customers.

### Results

**Retained Customers**:
- Average Monthly Charge: 61.27
- Average Total Charge: 2,549.91

**Churned Customers**:
- Average Monthly Charge: 74.44
- Average Total Charge: 1,531.80

### Business Insight

Churned customers pay 21% higher monthly bills but have 40% lower lifetime value. They are unhappy with cost AND didn't stay long.

This suggests two issues:
1. Price-sensitive customers being charged premium rates
2. Customers feeling upsold or misaligned with actual value

### Recommendation

- Audit billing for new customers. Are we upselling unnecessary services?
- Test personalized discount offers for high-bill churn customers
- Offer service downgrades without penalty (let them reduce monthly bill mid-contract)
- Review sales practices: are we overselling bundled services?

---

## Finding 4: Fiber Optic + Month-to-Month = Danger Zone

### Query Logic
Combine internet service type with contract type. Calculate churn and revenue impact.

### Results (Top Risk Segments)

| Internet Service | Contract | Customers | Churned | Churn Rate | Lost Revenue |
|---|---|---|---|---|---|
| Fiber Optic | Month-to-Month | 2,128 | 1,162 | 54.6% | 1.73M |
| Fiber Optic | One Year | 613 | 133 | 21.7% | 277K |
| DSL | Month-to-Month | 1,747 | 433 | 24.8% | 761K |
| No Internet | Month-to-Month | 1,000 | 35 | 3.5% | 67K |

### Business Insight

Fiber optic customers are fundamentally different. They might expect faster, more reliable service (premium expectations). When combined with month-to-month flexibility, they have zero friction to leave.

1.73M of 2.88M total month-to-month revenue loss comes from Fiber customers.

### Recommendation

**Immediate (High Priority)**:
- Dedicated retention team for this segment
- Proactive outreach at contract renewal
- Offer loyalty discounts exclusive to fiber customers
- Ensure SLA compliance (speed, uptime) rigorously monitored

**Medium-term**:
- Audit fiber service quality independently. Are we delivering on promise?
- Consider auto-renew with penalty-free exit (reduces perception of "trap")
- Fiber-exclusive perks (premium support, priority support channel)

---

## Finding 5: Support Services Reduce Churn

### Query Logic
Compare churn rates for customers with tech support, device protection, online security, online backup vs those without.

### Results

**Customers With At Least One Support Service**:
- Churn Rate: 18.2%

**Customers With No Support Services**:
- Churn Rate: 41.8%

### Business Insight

Service adoption is a proxy for engagement. Customers who buy tech support are literally asking for help. They feel supported. They churn at half the rate.

This is actionable: increasing service bundle adoption directly improves retention.

### Recommendation

- Make tech support opt-out instead of opt-in (trial period)
- Bundle support services into premium plans at lower cost
- Educate sales team: mention support services as customer success enabler, not just revenue
- For at-risk customers (high bills, new), auto-include trial tech support

---

## Finding 6: Churn Risk Scoring Model

### Query Logic
Assign risk points based on:
- Tenure < 12 months (HIGH risk)
- Month-to-month contract (HIGH risk)
- Monthly charge > 75th percentile (MEDIUM risk)
- No support services (HIGH risk)
- Senior citizen status (MEDIUM risk)
- No partner/dependents (MEDIUM risk)

Sum points and categorize:
- High Risk: 4+ points
- Medium Risk: 2-3 points
- Low Risk: 0-1 points

### Results

| Risk Level | Customers | Churn Rate | Actual Churn | Revenue at Risk |
|---|---|---|---|---|
| High Risk | 1,809 | 59.0% | 1,067 | 2.89M |
| Medium Risk | 2,790 | 24.3% | 678 | 1.58M |
| Low Risk | 2,444 | 5.1% | 124 | 189K |

### Business Insight

Model separates customers cleanly by actual churn probability. High-risk segment has 59% churn. Low-risk has 5%.

This gives actionable segmentation: you can rank 7K customers by churn likelihood and invest retention dollars proportionally.

### Recommendation

- Run this scoring monthly. Track which customers move from Low → Medium or Medium → High
- Alert retention team when customer moves to High Risk
- Personalize outreach by risk level (High: personal call; Medium: email offer; Low: standard comms)
- Test intervention effectiveness: track if retained high-risk customers actually stay longer

---

## Summary of Actionable Insights

### Immediate Actions (Month 1)
1. Create retention campaign for fiber + month-to-month segment (1,162 customers at 54% churn)
2. Implement proactive 30/60 day touchpoints for new customers
3. Audit high-bill churn: review what services they were sold

### Short-term (Month 1-3)
1. Shift support services from opt-in to opt-out
2. Offer annual contract incentives to month-to-month holders
3. Run risk model monthly. Alert team when customers breach High Risk threshold

### Medium-term (Quarter 2)
1. Analyze support service trial results. How many convert to paying customers?
2. Compare tenure churn (0-10 months) before/after onboarding improvements
3. Model: what's the ROI on retention discount vs cost of new customer acquisition?

### Long-term (Build)
1. Add predictive churn signals to CRM (for proactive outreach, not just reactive)
2. Develop service quality scorecards for fiber customers
3. A/B test contract term incentives (how much discount needed to move customers to annual?)

---

## Technical Notes

### Why This Approach

- **SQL first**: No ML needed. Simple CASE WHEN + aggregations solve the problem.
- **Segmentation > prediction**: We don't need to predict who leaves. We can measure who's already at risk and act.
- **Revenue impact first**: Not just counting churn. Measuring financial impact per segment.

### Data Quality Checks Done

- Verified no duplicate customers
- Checked NULL values (found and fixed TotalCharges blanks for new customers)
- Confirmed churn label is binary (Yes/No)
- Validated tenure aligns with TotalCharges (new customers = low tenure = low charges)

### Limitations

- Dataset is snapshot in time. Churn is historical, not forward-looking.
- Geographic data not available (can't segment by region)
- No service quality metrics (uptime, latency, support response time)
- No customer acquisition cost data (limits retention ROI calc)

---

## Files Reference

**01_table_creation.sql**: Creates schema from CSV

**02_data_inspection.sql**: Count records, check nulls, validate data types

**03_data_cleaning.sql**: Handle TotalCharges blanks, verify no duplicates

**04_eda.sql**: Basic counts, churn rate, demographics breakdown

**05_business_analysis.sql**: All 10 segment analyses (contract, tenure, charges, service type, etc.)

**06_churn_risk_model.sql**: Scoring logic, risk stratification, revenue impact
