SELECT
    CASE 
        WHEN month < DATE '2024-07-01' THEN 'Before Basic Launch'
        ELSE 'After Basic Launch'
    END AS period,
    SUM(MRR) / COUNT(DISTINCT user_id) AS ARPU
FROM revenue_monthly_snapshot
GROUP BY 1;

WITH pro_users_pre_launch AS (
    SELECT u.user_id
    FROM users u
    JOIN plans p ON u.initial_plan_id = p.plan_id
    WHERE p.plan_name = 'Pro'
    AND u.signup_date < DATE '2024-07-01'
),

downgraded_users AS (
    SELECT DISTINCT user_id
    FROM subscription_events
    WHERE event_type = 'downgrade'
    AND event_date >= DATE '2024-07-01'
)

SELECT 
    COUNT(d.user_id)::float / COUNT(p.user_id) * 100 AS downgrade_rate_percent
FROM pro_users_pre_launch p
LEFT JOIN downgraded_users d
ON p.user_id = d.user_id;

WITH existing_users AS (
    SELECT user_id
    FROM users
    WHERE signup_date < DATE '2024-07-01'
),

revenue_before AS (
    SELECT SUM(MRR) AS revenue_before
    FROM revenue_monthly_snapshot
    WHERE month = DATE '2024-06-01'
    AND user_id IN (SELECT user_id FROM existing_users)
),

revenue_after AS (
    SELECT SUM(MRR) AS revenue_after
    FROM revenue_monthly_snapshot
    WHERE month = DATE '2024-12-01'
    AND user_id IN (SELECT user_id FROM existing_users)
)

SELECT 
    revenue_after / revenue_before * 100 AS NRR_percent
FROM revenue_before, revenue_after;

SELECT
    CASE 
        WHEN u.signup_date < DATE '2024-07-01' THEN 'Existing Users'
        ELSE 'New Users'
    END AS user_type,
    SUM(r.MRR) AS total_revenue
FROM revenue_monthly_snapshot r
JOIN users u ON r.user_id = u.user_id
WHERE r.month >= DATE '2024-07-01'
GROUP BY 1;

SELECT 
    SUM(ABS(MRR_change)) AS total_monthly_revenue_lost
FROM subscription_events
WHERE event_type = 'downgrade';

COPY (
    SELECT  
        u.user_id,
        u.signup_date,
        r.month AS revenue_month,
        r.mrr,
        r.is_active
    FROM users u
    JOIN revenue_monthly_snapshot r
        ON u.user_id = r.user_id
    ORDER BY u.user_id, r.month
)
TO 'D:\saas_pricing_cannibalization_project\data\exports\revenue_snapshot.csv'
WITH CSV HEADER;