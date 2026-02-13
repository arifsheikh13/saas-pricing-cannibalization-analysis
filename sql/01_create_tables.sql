CREATE TABLE plans (
    plan_id SERIAL PRIMARY KEY,
    plan_name VARCHAR(50) NOT NULL,
    monthly_price NUMERIC(10,2) NOT NULL,
    launch_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    signup_date DATE NOT NULL,
    acquisition_channel VARCHAR(50),
    country VARCHAR(50),
    company_size VARCHAR(50),
    industry VARCHAR(100),
    initial_plan_id INT REFERENCES plans(plan_id)
);

CREATE TABLE subscriptions (
    subscription_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    plan_id INT REFERENCES plans(plan_id),
    start_date DATE NOT NULL,
    end_date DATE,
    status VARCHAR(20) CHECK (status IN ('active', 'cancelled')),
    billing_cycle VARCHAR(20) CHECK (billing_cycle IN ('monthly', 'annual'))
);

CREATE TABLE subscription_events (
    event_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(user_id),
    event_date DATE NOT NULL,
    event_type VARCHAR(20) CHECK (event_type IN ('upgrade', 'downgrade', 'cancel', 'reactivation')),
    old_plan_id INT REFERENCES plans(plan_id),
    new_plan_id INT REFERENCES plans(plan_id),
    MRR_change NUMERIC(10,2)
);

CREATE TABLE revenue_monthly_snapshot (
    user_id INT REFERENCES users(user_id),
    month DATE NOT NULL,
    plan_id INT REFERENCES plans(plan_id),
    MRR NUMERIC(10,2) NOT NULL,
    is_active BOOLEAN,
    PRIMARY KEY (user_id, month)
);
