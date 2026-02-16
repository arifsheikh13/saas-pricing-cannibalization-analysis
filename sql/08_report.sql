CREATE OR REPLACE VIEW vw_monthly_revenue AS
SELECT
    r.month,
    r.user_id,
    u.signup_date,
    CASE 
        WHEN u.signup_date < DATE '2024-07-01' THEN 'Existing'
        ELSE 'New'
    END AS user_type,
    p.plan_name,
    r.MRR
FROM revenue_monthly_snapshot r
JOIN users u ON r.user_id = u.user_id
JOIN plans p ON r.plan_id = p.plan_id;

CREATE OR REPLACE VIEW vw_downgrade_summary AS
SELECT
    COUNT(*) AS total_downgrades,
    SUM(ABS(MRR_change)) AS monthly_mrr_lost,
    SUM(ABS(MRR_change)) * 12 AS annualized_mrr_lost
FROM subscription_events
WHERE event_type = 'downgrade';

CREATE OR REPLACE VIEW vw_plan_distribution AS
SELECT
    p.plan_name,
    COUNT(*) AS active_users
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
WHERE s.status = 'active'
GROUP BY p.plan_name;