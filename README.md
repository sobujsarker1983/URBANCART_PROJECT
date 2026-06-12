# UrbanCart Retail Analytics

### End-to-End E-Commerce Data Analytics Project | PostgreSQL · SQL · Power BI

[![Status](https://img.shields.io/badge/Status-Completed-brightgreen)](.)
[![SQL](https://img.shields.io/badge/SQL-25%20Queries-blue)](.)
[![Tool](https://img.shields.io/badge/BI%20Tool-Power%20BI-yellow)](.)
[![DB](https://img.shields.io/badge/Database-PostgreSQL%2016-336791)](.)

An end-to-end data analytics portfolio project covering sales performance, customer behavior, product intelligence, inventory monitoring, and payment analytics for a fictional Bangladeshi e-commerce retailer.

---

## Table of Contents

- [Executive Summary](#executive-summary)
- [Business Objectives](#business-objectives)
- [Technology Stack](#technology-stack)
- [Database Architecture](#database-architecture)
- [Dataset Overview](#dataset-overview)
- [Business Questions Answered (Q1–Q25)](#business-questions-answered-q1q25)
- [Key Business Insights](#key-business-insights)
- [Power BI Dashboard](#power-bi-dashboard)
- [Repository Structure](#repository-structure)
- [How to Run](#how-to-run)
- [Skills Demonstrated](#skills-demonstrated)
- [Author](#author)

---

## Executive Summary

UrbanCart is a simulated retail e-commerce platform operating across 10 major cities in Bangladesh. This project analyzes **1,200 customer orders** and **4,621 order line items** collected between **September and December 2025**.

The objective was to transform raw transactional data into actionable business insights through relational data modeling, SQL analytics, and interactive BI dashboards.

**Full analytics workflow:**

```
Raw Data → PostgreSQL Database → SQL Analysis (25 Queries) → CSV Exports → Power BI Dashboard
```

---

## Business Objectives

The project was designed to answer key business questions across four analytical domains:

| Domain | Focus Area |
|--------|-----------|
| Revenue & Sales | Monthly trends, city performance, AOV |
| Product & Inventory | Category contribution, stock-out risk, market basket |
| Customer Behavior | Lifetime value, cancellation patterns, gender segmentation |
| Payment Analytics | Method preferences, completion rates, AOV by method |

A total of **25 business-driven SQL queries** were written and executed to uncover trends, identify risks, and support data-informed decision-making.

---

## Technology Stack

| Component | Technology |
|-----------|-----------|
| Database | PostgreSQL 16 |
| Database Management | pgAdmin 4 |
| Query Language | SQL (CTEs, Window Functions, JOINs, Aggregations) |
| Data Preparation | Microsoft Excel + VBA Macros |
| Data Visualization | Microsoft Power BI |
| Data Modeling | Star Schema (2 Dim + 3 Fact tables) |
| ER Diagramming | pgAdmin ERD Tool + Power BI Model View |
| Version Control | Git & GitHub |

---

## Database Architecture

The solution follows a **star schema** design optimized for analytical querying.

### Schema Diagram

```
                    ┌─────────────────┐
                    │   DimCustomers  │
                    │─────────────────│
                    │ customer_id  PK │
                    │ full_name       │
                    │ gender          │
                    │ email           │
                    │ phone           │
                    │ city            │
                    │ created_at      │
                    └────────┬────────┘
                             │ 1
                             │
┌──────────────┐      ┌──────▼──────────┐      ┌──────────────────┐
│  DimProducts │      │   FactOrders    │      │   FactPayment    │
│──────────────│      │─────────────────│      │──────────────────│
│ product_id PK│      │ order_id     PK │      │ payment_id    PK │
│ product_name │      │ customer_id  FK │      │ order_id      FK │
│ category     │      │ order_date      │      │ method           │
│ unit_price   │      │ status          │      └──────────────────┘
│ stock        │      └──────┬──────────┘
└──────┬───────┘             │ 1
       │ 1                   │
       │              ┌──────▼──────────┐
       └──────────────│ FactOrderItems  │
                    * │─────────────────│
                      │ order_item_id PK│
                      │ order_id      FK│
                      │ product_id    FK│
                      │ quantity        │
                      └─────────────────┘
```

### Relationships

| Relationship | Type | Description |
|---|---|---|
| `DimCustomers` → `FactOrders` | One-to-Many | One customer can place many orders |
| `FactOrders` → `FactOrderItems` | One-to-Many | One order can have many line items |
| `DimProducts` → `FactOrderItems` | One-to-Many | One product can appear in many orders |
| `FactOrders` → `FactPayment` | One-to-One | Each order has exactly one payment record |

> ER diagram generated with **pgAdmin 4** · Relationship model verified in **Power BI Model View**

---

## Dataset Overview

| Table | Records | Description |
|-------|--------:|-------------|
| `DimCustomers` | 100 | Customer profiles — name, gender, email, city |
| `DimProducts` | 41 | Product catalog — category, unit price, stock level |
| `FactOrders` | 1,200 | Order headers — date, status, customer reference |
| `FactOrderItems` | 4,621 | Line-item detail — product, quantity per order |
| `FactPayment` | 1,200 | Payment record — method per order |

| Attribute | Detail |
|-----------|--------|
| Coverage period | September 2025 – December 2025 *(December partial)* |
| Cities | Barishal, Chattogram, Cumilla, Dhaka, Gazipur, Khulna, Narayanganj, Rajshahi, Rangpur, Sylhet |
| Product categories | 12 — Fashion, Grocery, Electronics, Beverages, Personal Care, Health, Digital, Meat, Snacks, Poultry, Home Care, Dairy |
| Order statuses | Completed, Pending, Cancelled |
| Payment methods | COD, bKash, Nagad, Credit Card, Debit Card |

---

## Business Questions Answered (Q1–Q25)

### Orders & Revenue

| # | Business Question |
|---|-------------------|
| Q1 | How many total orders has UrbanCart received so far? |
| Q2 | Which cities generate the highest number of orders and revenue? |
| Q4 | What is the monthly trend of total orders over time? |
| Q6 | What is the total revenue generated by UrbanCart? |
| Q9 | What is the average order value (AOV) and average basket size? |
| Q25 | What is the daily operations summary — orders, items, revenue, completions? |

### Products & Inventory

| # | Business Question |
|---|-------------------|
| Q7 | Which product categories contribute most to total revenue? |
| Q8 | Which individual products generate the highest revenue? |
| Q10 | Which products are at risk of stock-out based on recent sales vs current stock? |
| Q22 | How does each product's price compare to its category average? |
| Q23 | Which products are most frequently purchased together? *(Market Basket Analysis)* |
| Q24 | Which product pairs generate the highest combined revenue when bought together? |

### Customer Analysis

| # | Business Question |
|---|-------------------|
| Q3 | What percentage of customers use Gmail? |
| Q11 | Which customers contribute the highest total lifetime revenue? |
| Q12 | What is the cancellation rate by city and by individual customer? |
| Q13 | How do purchasing patterns differ between male and female customers? |
| Q14 | How does customer spend evolve over months since account creation? |
| Q15 | Which customers have placed orders but never completed one? |
| Q16 | Which customers have never placed any order at all? |

### Payment Intelligence

| # | Business Question |
|---|-------------------|
| Q17 | Which payment methods are most commonly used? |
| Q18 | What is the order completion rate by payment method? |
| Q19 | Which payment method does each city prefer? |
| Q20 | Which payment method yields the highest average order value? |
| Q21 | Which payment method is associated with the largest basket size? |

---

## Key Business Insights

### Revenue Performance

- Total revenue of **BDT 2,168,986** was generated across **1,200 orders** in four months — an average of BDT 542,247 per month.
- **October 2025** was the peak month with **413 orders**, a **70% spike** over September (243). November softened to 371 orders, suggesting a post-peak correction.
- **Barishal leads all cities** in revenue at BDT 305,652 — despite not being the largest city by population — while Narayanganj ranks lowest at BDT 116,208.
- The **average order value is BDT 1,807** with an average basket of **9.59 items per order**, indicating a strong tendency toward bulk and mixed-category purchasing.

### Product Intelligence

- **Power Bank 10000mAh** is the top-revenue product at **BDT 301,150** — nearly **double** the second-ranked Nazirshail Rice 5kg (BDT 162,760).
- **Fashion** (22.8%, BDT 495,220) and **Grocery** (22.1%, BDT 478,637) together account for **~45% of total revenue**.
- **Stock-out risk detected for 2 products:**
  - *Power Bank 10000mAh* — 90 units in stock vs 177 units sold in the last 2 months (deficit: −87 units) → **Critical**
  - *Wallet (Men)* — 150 units in stock vs 151 units sold (deficit: −1 unit) → **Warning**
- **Market basket analysis** identified that *Potato 1kg + Peanut 500g* and *Farm Fresh Milk 1L + Potato 1kg* are the most co-purchased pairs (20 times each). The highest-revenue co-purchase pair is *Miniket Rice 5kg + Power Bank 10000mAh* at BDT 58,450 combined.

### Customer Behavior

- **Top customer "Raisa"** spent BDT 41,151 — **1.9× more** than the second-ranked customer (Mim, BDT 37,025).
- **Gazipur has the highest cancellation rate at 27.18%**, followed by Rangpur (24.79%) and Barishal (24.28%). **Cumilla is the most reliable city** at only 14.29%.
- **Male customers outspend female customers** in every major category — Male Grocery: BDT 295,343 vs Female: BDT 183,294; Male Fashion: BDT 285,620 vs Female: BDT 209,600.
- **76% of customers use Gmail**, making it the primary channel for email-based retention and re-engagement campaigns.
- **Dhaka is the only city where bKash overtakes COD** as the #1 payment method, reflecting higher digital payment maturity in the capital.

### Payment Patterns

- **COD dominates** with 40.7% of all transactions (488 orders), followed by bKash (29.1%), Nagad (19.6%), and card-based payments (10.7% combined).
- **Nagad yields the highest AOV at BDT 1,876**, while **Debit Card drives the largest basket size at 10.30 items per order** — indicating Debit Card users tend to do larger, grocery-style purchases.
- Order completion rates range narrowly between **55.6% and 61.5%** across all payment methods, indicating cancellation is a **platform-wide operational issue**, not isolated to any specific payment channel.
- COD leads completion at **61.5%**; Debit Card lags at **55.6%**.

---

## Power BI Dashboard

The `.pbix` file connects all five CSV source files and replicates the star schema in Power BI's Model View. The dashboard is structured across four interactive report pages:

| Page | Contents |
|------|----------|
| Executive Overview | KPI cards, monthly trend, revenue by city, category share donut |
| Revenue & Products | Top 10 products, category table, stock-risk alert with deficit |
| Customer Analytics | Cancellation rate by city (color-coded), top 10 customers, gender × category chart |
| Payment Analytics | Method distribution, AOV vs basket size (dual-axis), stacked order status |

> File: `DASHBOARD_POWER_BI/URBANCART_DASHBOARD.pbix`

---

## Repository Structure

```
URBANCART_PROJECT/
│
├── RAW_DATA/
│   ├── CSV_FILE/                        # 5 source tables as CSV
│   │   ├── DimCustomers.csv
│   │   ├── DimProducts.csv
│   │   ├── FactOrders.csv
│   │   ├── FactOrderItems.csv
│   │   └── FactPayment.csv
│   └── EXCEL_FILE/                      # Excel versions + VBA macro workbook
│
├── SQL_SCRIPTS/
│   ├── 1Q_1_TO_Q_25_SQL_CODE.sql        # All 25 queries (combined)
│   ├── Q_1_SQL_CODE.sql                 # Individual query files
│   └── ...                              # Q2 through Q25
│
├── OUTPUT_CSV_FILE_1_TO_25/             # Query result exports (one CSV per question)
│   ├── CSV_OUTPUT_FOR_Q_1.csv
│   └── ...
│
├── DASHBOARD_POWER_BI/
│   └── URBANCART_DASHBOARD.pbix
│
├── IMAGE/
│   ├── DAIGRAM_FOR_URBANCART_PROJECT.png       # pgAdmin ER diagram
│   └── POWERBI_MODEL_VIEW_SCREENSHORT.png      # Power BI model view
│
├── QUESTION_FOR_PROJECT/
│   └── PROJECT_UrbanCart Retail Shop Analytics.pdf
│
└── README.md
```

---

## How to Run

### PostgreSQL setup

```sql
-- Step 1: Create the database
CREATE DATABASE urbancart_db;

-- Step 2: Create tables and import CSVs from RAW_DATA/CSV_FILE/
-- Step 3: Open SQL_SCRIPTS/1Q_1_TO_Q_25_SQL_CODE.sql in pgAdmin Query Tool
-- Step 4: Run all queries
```

### Power BI setup

1. Open `DASHBOARD_POWER_BI/URBANCART_DASHBOARD.pbix` in Power BI Desktop.
2. If prompted, update the data source path to your local `RAW_DATA/CSV_FILE/` folder.
3. Click **Refresh** to reload all data.

### Sample query

```sql
-- Revenue contribution by product category
SELECT
    p.category                                AS category_name,
    ROUND(SUM(oi.quantity * p.unit_price), 2) AS total_revenue,
    ROUND(
        SUM(oi.quantity * p.unit_price) * 100.0
        / SUM(SUM(oi.quantity * p.unit_price)) OVER (), 2
    )                                         AS revenue_share_pct
FROM public.FactOrderItems oi
JOIN public.DimProducts p ON oi.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC;
```

---

## Skills Demonstrated

| Skill | Application |
|-------|------------|
| SQL Query Development | CTEs, window functions, multi-table JOINs, aggregations, HAVING, DATE functions |
| Relational Database Design | Star schema, primary/foreign keys, normalization |
| Data Modeling | Power BI model view, relationship cardinality |
| Business Intelligence | KPI design, drill-through navigation, cross-filter logic |
| Data Visualization | Bar, donut, stacked, dual-axis, and trend charts |
| Business Insight Generation | Translating query results into actionable recommendations |
| Inventory Analysis | Stock-out risk detection using sales velocity vs current stock |
| Market Basket Analysis | Co-purchase frequency and combined revenue pair analysis |

---

## Author

**Sobuj Sarker**
Data Analytics Enthusiast · SQL Developer · Power BI Analyst

| | |
|--|--|
| Tools | PostgreSQL · SQL · Microsoft Excel · Power BI · Git & GitHub |
| Project type | Portfolio / End-to-End Analytics |
| Status | Completed |
| Last updated | June 2026 |

---

*Built to demonstrate end-to-end analytical thinking — from data modeling and SQL query design to business insight generation and BI visualization.*
