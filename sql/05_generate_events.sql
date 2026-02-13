INSERT INTO subscription_events (
    user_id,
    event_date,
    event_type,
    old_plan_id,
    new_plan_id,
    MRR_change
)
SELECT
    s.user_id,
    DATE '2024-07-01' + (random() * 180)::INT,
    'downgrade',
    p_pro.plan_id,
    p_basic.plan_id,
    p_basic.monthly_price - p_pro.monthly_price
FROM subscriptions s
JOIN plans p_pro ON s.plan_id = p_pro.plan_id
JOIN plans p_basic ON p_basic.plan_name = 'Basic'
WHERE p_pro.plan_name = 'Pro'
AND s.start_date < DATE '2024-07-01'
AND random() < 0.15;

UPDATE subscriptions s
SET plan_id = e.new_plan_id,
    start_date = e.event_date
FROM subscription_events e
WHERE s.user_id = e.user_id
AND e.event_type = 'downgrade';