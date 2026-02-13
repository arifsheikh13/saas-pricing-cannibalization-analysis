INSERT INTO revenue_monthly_snapshot (
    user_id,
    month,
    plan_id,
    MRR,
    is_active
)
SELECT
    s.user_id,
    date_trunc('month', d)::date AS month,
    s.plan_id,
    p.monthly_price AS MRR,
    TRUE
FROM subscriptions s
JOIN plans p ON s.plan_id = p.plan_id
JOIN generate_series(
    DATE '2023-01-01',
    DATE '2025-01-01',
    interval '1 month'
) d ON d >= s.start_date
WHERE s.status = 'active';