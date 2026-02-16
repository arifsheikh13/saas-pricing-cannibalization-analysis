# SaaS Pricing Cannibalization & Revenue Analytics Project

## Executive Summary
This project simulates a SaaS subscription business to analyze revenue performance, pricing dynamics, and plan behavior.

### The analysis focuses on:

1. Monthly Recurring Revenue (MRR) trends
2. Upgrade and downgrade behavior
3. Revenue loss from downgrades
4. Plan distribution shifts
5. Potential pricing cannibalization

The project was built end-to-end — from synthetic data generation and SQL pipeline design to business KPI modeling and dashboard reporting.

It demonstrates both data engineering and business analytics capabilities within a single structured workflow.

## Project Architecture

The solution follows a modular SQL pipeline with clear separation of responsibilities.

01_create_tables.sql          → Schema definition
02_plans_data.sql             → Seed pricing plans
03_generate_users.sql         → Synthetic user generation
04_generate_subscriptions.sql → Subscription lifecycle modeling
05_generate_events.sql        → Upgrade and downgrade simulation
06_revenue_snapshot.sql       → Monthly MRR snapshot (analytics fact table)
07_analysis_queries.sql       → KPI calculations and business metrics
08_report.sql                 → Reporting views

## Analytics Layer

The revenue_monthly_snapshot table acts as the core fact table powering all business reporting and dashboard metrics.

This layered structure mirrors real-world data workflows:

Operational tables → Transformation layer → Analytics fact table → Reporting views

## Business Problems Addressed

1. Is revenue growth sustainable over time?
2. How much revenue is lost due to downgrades?
3. Are lower-tier plans cannibalizing premium plans?
4. What is the revenue mix between new and existing users?
5. How does plan distribution impact overall revenue stability?

## Key Metrics Developed

- Monthly Recurring Revenue (MRR)
- MRR growth trend
- Downgrade impact (monthly and annualized)
- Active users by plan
- Revenue segmentation (New vs Existing users)
- Plan distribution share

## Business Insights Derived
1. Revenue Growth Is Acquisition-Driven

Revenue growth was primarily driven by new user acquisition rather than expansion revenue from existing customers.

Insight:
The company is more dependent on marketing and acquisition efforts than on upsell or expansion strategies. Long-term sustainability requires strengthening retention and expansion revenue.

2. Downgrades Create Recurring Revenue Leakage

Downgrade events generated measurable monthly MRR loss. When annualized, even moderate downgrade activity resulted in significant revenue impact.

Insight:
Reducing downgrade frequency may generate higher ROI than increasing acquisition spend. Feature optimization and pricing adjustments should be evaluated.

3. Plan Cannibalization Risk Exists

Lower-tier plans captured a substantial share of active users, while premium plans showed slower relative growth.

Insight:
The pricing structure may be incentivizing downward movement rather than upgrades. This indicates potential cannibalization of higher-value plans.

4. Revenue Concentration in Mid-Tier Plans

A large portion of active revenue was concentrated in mid-tier plans.

Insight:
If mid-tier pricing is not strategically optimized, it can distort upgrade and downgrade flows and reduce expansion revenue potential.

5. Existing Users Drive Revenue Stability

Existing users contributed the majority of recurring revenue, while new users drove incremental monthly growth.

Insight:
Retention strategies are equally critical as acquisition strategies for maintaining predictable revenue.

## Dashboard

The Power BI dashboard includes:

- MRR trend over time
- Plan distribution visualization
- Downgrade revenue impact KPI
- Revenue segmentation (New vs Existing users)
- Active users by plan

The dashboard translates SQL-derived metrics into executive-level decision visuals.

## Data Model

### Core tables:

- users
- plans
- subscriptions
- subscription_events
- revenue_monthly_snapshot

### The data model separates:

- Simulated operational data
- Transformed analytics layer
- Reporting views

This reflects real-world warehouse architecture principles.

## Tech Stack

- PostgreSQL

- SQL

- Power BI

- Git

- VS Code

## Skills Demonstrated

### Data Engineering

1. Modular SQL architecture
2. Fact table design
3. Reporting layer using views
4. Data transformation logic
5. Version control best practices

### Business Analytics

1. KPI modeling
2. Revenue impact quantification
3. Cannibalization risk assessment
4. Segmentation analysis
5. Executive-level reporting mindset

## Future Enhancements

- Cohort retention analysis
- Customer Lifetime Value (LTV) modeling
- Churn probability scoring
- Pricing elasticity simulation
- A/B pricing scenario analysis