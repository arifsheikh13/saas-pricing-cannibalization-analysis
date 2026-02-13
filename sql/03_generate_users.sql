INSERT INTO users (signup_date, acquisition_channel, country, company_size, industry, initial_plan_id)
SELECT
    DATE '2023-01-01' + (random() * 730)::INT,
    (ARRAY['Organic','Paid Ads','Referral'])[floor(random()*3)+1],
    (ARRAY['US','UK','India','Germany'])[floor(random()*4)+1],
    (ARRAY['SMB','Mid-Market','Enterprise'])[floor(random()*3)+1],
    (ARRAY['SaaS','Fintech','E-commerce','Health'])[floor(random()*4)+1],
    CASE
        WHEN DATE '2023-01-01' + (random() * 730)::INT < DATE '2024-07-01'
        THEN (SELECT plan_id FROM plans WHERE plan_name = 'Pro')
        ELSE (SELECT plan_id FROM plans WHERE plan_name = 'Basic')
    END
FROM generate_series(1,5000);
