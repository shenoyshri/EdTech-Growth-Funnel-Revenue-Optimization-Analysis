SELECT * FROM edtech_funnel;

# 1. Total Leads
SELECT count(lead_id) AS total_leads
FROM edtech_funnel;

# 2. Total Trials
SELECT COUNT(trial) AS total_trials
FROM edtech_funnel
WHERE trial = "Yes";

SELECT
COUNT(CASE WHEN trial = "Yes" THEN 1 END) AS total_trials
FROM edtech_funnel;

# 3. Total Enrollments
SELECT COUNT(enrolled) AS total_enrollments 
FROM edtech_funnel
WHERE enrolled = "Yes";

SELECT
COUNT(CASE WHEN enrolled = "Yes" THEN 1 END) AS total_enrollments
FROM edtech_funnel;

# 4. Total Retained
SELECT 
COUNT(CASE WHEN retained = "Yes" THEN 1 END) AS total_retained
FROM edtech_funnel;

SELECT COUNT(*) AS total_retained
FROM edtech_funnel
WHERE retained = "Yes";

# FULL FUNNEL CONVERSION  RATES
# 5. Lead → Trial Conversion
SELECT 
ROUND(COUNT(CASE WHEN trial = "Yes" THEN 1 END)*100.0 / 
COUNT(lead_id),2) AS lead_trial_rate
FROM edtech_funnel;

# 6. Trial → Enrollment Conversion
SELECT 
    ROUND(
        COUNT(CASE WHEN enrolled = 'Yes' THEN 1 END) * 100.0 
        / COUNT(CASE WHEN trial = 'Yes' THEN 1 END), 2
    ) AS trial_to_enrollment_rate
FROM edtech_funnel;


# 7. Lead → Enrollment Conversion
SELECT 
ROUND (COUNT( CASE WHEN enrolled="Yes" THEN 1 END)  * 100.0/
COUNT(lead_id),2) AS lead_enrollment_rate
FROM edtech_funnel;

# 8. Enrollment → Retention Conversion
SELECT
ROUND(COUNT(CASE WHEN retained = "Yes" THEN 1 END) *100.0/
	COUNT(CASE WHEN enrolled = "Yes" THEN 1 END),2 ) AS enrollment_retention_rate
FROM edtech_funnel;

# REVENUE KPI
# 10. Total Revenue
SELECT SUM( course_fee - discount ) AS total_revenue
FROM edtech_funnel
WHERE enrolled = "yes";

# SEGMENT ANALYSIS
# Batch wise Conversion
SELECT 
    batch_type,
    COUNT(*) AS total_leads,
    COUNT(CASE
        WHEN enrolled = 'Yes' THEN 1
    END) AS enrollments,
    ROUND(SUM(CASE
                WHEN enrolled = 'Yes' THEN 1
            END) * 100.0 / COUNT(*),
            2) AS conversion_rate
FROM
    edtech_funnel
GROUP BY batch_type;

# Retention by Batch
SELECT 
    batch_type,
    COUNT(CASE WHEN enrolled = 'Yes' THEN 1 END) AS enrolled,
    COUNT(CASE WHEN retained = 'Yes' THEN 1 END) AS retained,
    ROUND(
        COUNT(CASE WHEN retained = 'Yes' THEN 1 END) * 100.0 
        / COUNT(CASE WHEN enrolled = 'Yes' THEN 1 END), 2
    ) AS retention_rate
FROM edtech_funnel
GROUP BY batch_type;

# Discount Impact by Income Segment
SELECT
parent_income_segment,
COUNT(*) AS total_leads,
COUNT(CASE WHEN enrolled = 'Yes' THEN 1 END) AS enrollments,
ROUND( AVG(discount), 2) AS avg_discount,
ROUND( COUNT(CASE WHEN enrolled = "Yes" THEN 1 END) * 100.0
/COUNT(*), 2) AS conversion_rate
FROM edtech_funnel
GROUP BY parent_income_segment
ORDER BY conversion_rate;

# Source-wise Funnel
SELECT
source,
COUNT(*) AS total_leads,
COUNT(CASE WHEN enrolled = "Yes" THEN 1 END) AS enrollments,
ROUND( AVG(discount), 2) AS avg_discount,
ROUND(COUNT(CASE WHEN enrolled ="Yes" THEN 1 END) * 100.0
/ COUNT(*),2) AS conversion_rate
FROM edtech_funnel
GROUP BY source
ORDER BY conversion_rate DESC;

# Regional Performance
SELECT
region,
COUNT(*) AS total_leads,
COUNT(CASE WHEN enrolled = "Yes" THEN 1 END) AS enrollments,
COUNT(CASE WHEN retained = "Yes" THEN 1 END) AS retained,
ROUND(COUNT(CASE WHEN enrolled = "Yes" THEN 1 END) * 100.0 /
COUNT(*), 2) AS conversion_rate
FROM edtech_funnel
GROUP BY region
ORDER BY conversion_rate DESC;