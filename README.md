# 🍽️ Zomato Restaurant Market & Performance Analytics

> **Portfolio project:** Source-backed analysis of 224K+ restaurants across India using Python, MySQL and Power BI.

**Tools:** Python • Pandas • MySQL • SQL • Power BI • Data Quality • Business Analytics

---

## 🎯 Executive Summary

This project analyzes a large restaurant-level dataset to understand **market supply, restaurant quality signals, pricing, cuisine mix, and digital-ordering adoption**.

The analysis is deliberately source-backed: the uploaded dataset contains restaurant attributes, ratings, rating counts, listed cost-for-two, location, cuisine, online ordering, table reservation and delivery-only indicators. It does **not** contain verified customer-level transactions or order revenue.

### Dataset at a glance

| Metric | Value |
|---|---:|
| Restaurant records | **224,520** |
| Cities | **83** |
| Areas | **2,501** |
| Unique Zomato URLs | **224,520** |
| Restaurants with usable ratings | **144,735** |
| Average valid rating | **3.49 / 5** |
| Online-order adoption | **49.58%** |
| Table-reservation adoption | **2.95%** |

---

## 🧠 Business Questions

1. Which cities have the largest restaurant supply?
2. Which markets combine scale with stronger ratings and customer-engagement signals?
3. How does listed cost-for-two vary across cities, cuisines and price bands?
4. Which cuisines dominate restaurant supply, and how does their quality signal compare?
5. How widely are online ordering and table reservation adopted?
6. Which cities show the strongest digital adoption?
7. Which restaurants combine high ratings with high rating-count engagement?
8. Where are data-quality issues likely to affect geographic or pricing analysis?

Full framework: [`Documentation/BUSINESS_QUESTIONS.md`](Documentation/BUSINESS_QUESTIONS.md)

---

## 🔄 Analytical Workflow

```text
Raw Zomato Restaurant Data
          ↓
Source Profiling
          ↓
Data Quality & Validation
          ↓
Python Cleaning / Feature Creation
          ↓
Clean Source-Backed MySQL Table
          ↓
SQL Business Analysis
          ↓
KPI & Segmentation Framework
          ↓
Power BI Dashboard
          ↓
Insights & Recommendations
```

---

## 🛠️ Technical Skills Demonstrated

### Python / Pandas

- Source profiling
- Missing-value analysis
- Type conversion
- Rating normalization
- Numeric parsing
- Coordinate validation
- Text standardization
- Analytical feature creation

### SQL / MySQL

- Data modelling
- Data-quality checks
- Conditional aggregation
- CTEs
- Window functions
- `RANK()` / `NTILE()`
- Market segmentation
- Pricing bands
- Cuisine analysis
- Digital-adoption analysis

### Power BI

- KPI reporting
- Interactive filtering
- City and market analysis
- Pricing analysis
- Rating analysis
- Digital adoption
- Restaurant segmentation

---

## 📊 Dashboard Plan

### Page 1 — Executive Market Overview

- Restaurant count
- Cities / areas covered
- Average rating
- Median cost-for-two
- Online-order adoption
- Table-reservation adoption
- Restaurant supply by city

### Page 2 — City & Market Analysis

- City ranking by restaurant supply
- Rating vs. market scale
- Cost-for-two comparison
- Digital adoption by city
- Engagement signal using rating counts

### Page 3 — Cuisine & Restaurant Analysis

- Top cuisines by restaurant count
- Cuisine rating comparison
- Cuisine pricing bands
- High-rating / high-engagement restaurants
- Restaurant-level drill-through

### Page 4 — Digital & Operating Model

- Online ordering
- Table reservation
- Delivery-only share
- City comparison
- Cross-feature adoption

> Dashboard screenshots will be refreshed after the source-backed Power BI model is rebuilt.

---

## 🔎 Data Quality Findings

The source contains several important analytical-quality issues that are explicitly handled rather than hidden:

- `rating = 0` is treated as unrated rather than a genuine zero-star score.
- `NEW` / `Nové` ratings are treated as missing.
- `cost_for_two` requires numeric parsing because values may contain commas.
- `zomato_url` is a strong source-level unique key.
- Duplicate restaurant names are not automatically deleted because chain/location repetition can be legitimate.
- 12,869 coordinate records fall outside the selected India geographic QA bounds and are flagged.
- `famous_food` is missing for approximately 76.61% of records and should not be treated as complete.

See [`Documentation/SOURCE_PROFILE.md`](Documentation/SOURCE_PROFILE.md).

---

## 🧮 Source-Backed SQL Analysis

The new source-backed SQL layer covers:

1. Restaurant supply by city
2. City quality and engagement
3. Pricing bands
4. Rating bands
5. Digital adoption by city
6. Cuisine performance
7. High-rating / high-engagement restaurant prioritization

See [`SQL/13_Source_Backend_Restaurant_Analysis.sql`](SQL/13_Source_Backend_Restaurant_Analysis.sql).

The cleaned MySQL table is defined in [`SQL/14_Source_Backend_Table_Setup.sql`](SQL/14_Source_Backend_Table_Setup.sql).

---

## ⚠️ What this dataset does NOT support

The source dataset does not contain verified order-level revenue or customer transaction history. Therefore the final source-backed analysis does **not** claim:

- Actual Zomato revenue
- Actual restaurant profit
- Contribution margin
- Customer lifetime value
- Customer retention
- Basket composition
- Monthly transaction revenue

Those concepts appeared in the original learning version of the project and are intentionally being removed from the source-backed narrative.

This is an intentional quality improvement: **analytical credibility is more important than adding impressive but unsupported metrics.**

---

## 📚 Documentation

| Document | Purpose |
|---|---|
| [`SOURCE_PROFILE.md`](Documentation/SOURCE_PROFILE.md) | Verified dataset profile and quality findings |
| [`SOURCE_TO_SQL_MAPPING.md`](Documentation/SOURCE_TO_SQL_MAPPING.md) | Data lineage and model mapping |
| [`BUSINESS_QUESTIONS.md`](Documentation/BUSINESS_QUESTIONS.md) | Business questions |
| [`KPI_DEFINITIONS.md`](Documentation/KPI_DEFINITIONS.md) | KPI definitions and governance |
| [`DATA_DICTIONARY.md`](Documentation/DATA_DICTIONARY.md) | Field definitions |
| [`CLEANING_PRINCIPLES.md`](Documentation/CLEANING_PRINCIPLES.md) | Auditable cleaning methodology |
| [`ASSUMPTIONS_AND_LIMITATIONS.md`](Documentation/ASSUMPTIONS_AND_LIMITATIONS.md) | Analytical limitations |
| [`REBUILD_PLAN.md`](Documentation/REBUILD_PLAN.md) | Technical rebuild plan |

---

## 📂 Project Structure

```text
Zomato-Analytics-Project/
│
├── Data/
│   ├── india_all_restaurants_details.csv.zst
│   └── processed/
│
├── Python/
│   ├── 01_source_profile.py
│   └── 02_clean_restaurant_data.py
│
├── SQL/
│   ├── 01–09_original_learning_workflow.sql
│   ├── 10_Portfolio_Analysis.sql
│   ├── 11_Data_Quality_Report.sql
│   ├── 12_Analyst_Quality_Gates.sql
│   ├── 13_Source_Backend_Restaurant_Analysis.sql
│   └── 14_Source_Backend_Table_Setup.sql
│
├── PowerBI/
├── Screenshots/
├── Documentation/
└── README.md
```

---

## 💡 Business Interpretation Framework

The project follows:

**Metric → Pattern → Interpretation → Recommendation**

Example:

> **Finding:** A city has a large restaurant base but relatively low online-order adoption.
>
> **Interpretation:** Restaurant supply and digital ordering availability are not necessarily aligned.
>
> **Action:** Investigate whether the market represents an opportunity for digital-order enablement, while controlling for restaurant type and dataset coverage.

---

## 👨‍💻 Author

**Aatreya Pal**  
Aspiring Data Analyst

**Core skills:** SQL • Python • Advanced Excel • Power BI • Data Analysis

[LinkedIn](https://www.linkedin.com/in/aatreya-pal-403ba8237)
