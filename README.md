**Interactive Dashboard**

View the dashboards here: https://public.tableau.com/app/profile/michael.horne/vizzes

**Olist E-Commerce Analytics Project**

SQL, PostgreSQL, Tableau: End-to-End Data Analysis

This project simulates a real-world data analyst workflow using the Olist Brazilian E-Commerce dataset. The goal was to transform raw transactional data into a structured database, perform business analysis with SQL, and communicate insights through dashboards.

**Project Overview**

E-commerce companies rely on data to track revenue, customer behavior, and operational performance. In this project, I built an analytics pipeline:

Raw CSV Data -> Relational Database -> SQL Analysis -> Tableau Dashboards

This project demonstrates both data analysis fundamentals and business intelligence skills.

**Database Design (PostgreSQL)**

I designed a relational schema to structure the raw datasets into connected tables.

**Key Tables:**

- orders:	Order-level transaction data
- order_items:	Item-level revenue (core fact table)
- customers:	Customer location and IDs
- products:	Product and category info
- payments:	Payment type and installments

**Data Modeling Features:**

- Primary and foreign keys
- Multi-table relationships
- Data validation queries after loading

**Data Loading:**

- Imported CSV files into PostgreSQL using pgAdmin
- Verified row counts and null checks
- Ensured referential integrity across tables

**SQL Analysis:**

I wrote analytical queries involving multi-table joins, aggregations, and time-based analysis.

**Business Questions Answered:**

- How has revenue trended over time?
- What is the monthly order volume?
- Which product categories drive the most revenue?
- What is the distribution of payment methods?

**SQL Views for BI:**

To prepare data for Tableau, I created SQL views including:

- revenue_by_month
- orders_by_month
- category_revenue
- payment_method_distribution
  
These views simplify complex joins and make dashboards efficient.

The dashboards translate SQL outputs into business insights.

**Skills Demonstrated:**

**Data Engineering**

- Relational database design
- Schema modeling
- Data validation

**SQL Analytics**

- Multi-table joins
- Aggregations
- Time-series metrics
- View creation

**Business Intelligence**

- KPI design
- Dashboard layout
- Data storytelling

**Key Takeaway**

This project showcases the complete analytics lifecycle:

Designing databases → Preparing analysis-ready data → Delivering insights.
