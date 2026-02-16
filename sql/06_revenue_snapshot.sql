TRUNCATE revenue_monthly_snapshot;

INSERT INTO revenue_monthly_snapshot (
    user_id,
    month,
    plan_id,
    MRR,
    is_active
)

WITH ordered_users AS (
    SELECT
        s.user_id,
        s.plan_id,
        s.start_date,
        p.monthly_price,
        ROW_NUMBER() OVER (ORDER BY s.user_id) AS rn
    FROM subscriptions s
    JOIN plans p ON s.plan_id = p.plan_id
    WHERE s.status = 'active'
),

user_base AS (
    SELECT *,
           (rn % 12 + 3) AS churn_after_months
    FROM ordered_users
),

user_months AS (
    SELECT
        u.user_id,
        u.plan_id,
        u.start_date + (interval '1 month' * g.n) AS month,
        u.monthly_price AS MRR
    FROM user_base u
    JOIN generate_series(0, 23) AS g(n)
        ON g.n <= u.churn_after_months
)

SELECT
    user_id,
    date_trunc('month', month)::date AS month,
    plan_id,
    MRR,
    TRUE AS is_active
FROM user_months;
