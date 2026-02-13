INSERT INTO subscriptions (user_id, plan_id, start_date, status)
SELECT
    u.user_id,
    u.initial_plan_id,
    u.signup_date,
    'active'
FROM users u;