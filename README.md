# 🍽️ Zomato Restaurant Market & Performance Analytics

> **Portfolio project:** Source-backed analysis of **224K+ restaurants across India** using Python, MySQL and Power BI.

**Tools:** Python • Pandas • MySQL • SQL • Power BI • Data Quality • Business Analytics

---

## 🎯 Executive Summary

This project analyzes a large restaurant-level dataset to understand **market supply, restaurant quality signals, pricing, cuisine mix, customer-engagement signals, and digital-ordering adoption**.

The analysis is deliberately source-backed. The uploaded dataset contains restaurant attributes, ratings, rating counts, listed cost-for-two, location, cuisine, online ordering, table reservation and delivery-only indicators. It does **not** contain verified customer-level transactions or order revenue.

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
2. Which markets combine scale with stronger ratings and engagement signals?
3. How does listed cost-for-two vary across cities, cuisines and price bands?
4. Which cuisines dominate restaurant supply, and how does their quality signal compare?
5. How widely are online ordering and table reservation adopted?
6. Which cities show the strongest digital adoption?
7. Which restaurants combine high ratings with high rating-count engagement?
8. Where are data-quality issues likely to affect geographic or pricing analysis?

Full framework: [`Documentation/BUSINESS_QUESTIONS.md`](Documentation/BUSINESS_QUESTIONS.md)

---

## 🔄 Reproducible Analytical Workflow

```text
Raw .zst Source
      ↓
Decompressed CSV
      ↓
Python Profiling
      ↓
Python Cleaning + EDA + Scoring
      ↓
Clean Source-Backed MySQL Table
      ↓
SQL KPI / Business Analysis
      ↓
Power BI Semantic Model
      ↓
Dashboard + Business Insights
```

### One-command Python pipeline

From the repository root:

```bash
python Python/run_pipeline.py
```

The raw source is never overwritten.

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
- EDA
- Correlation analysis
- Percentile-based scoring

### SQL / MySQL

- Data modelling
- Data-quality checks
- Conditional aggregation
- CTEs
- Window functions
- `RANK()` / `PERCENT_RANK()` / `NTILE()`
- Market segmentation
- Pricing bands
- Cuisine analysis
- Digital-adoption analysis
- KPI views

### Power BI

- KPI reporting
- Semantic modelling
- DAX measures
- Interactive filtering
- City and market analysis
- Pricing analysis
- Rating analysis
- Digital adoption
- Restaurant segmentation
- Drill-through

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

### Page 2 — City Intelligence

- City ranking by restaurant supply
- Rating vs. market scale
- Cost-for-two comparison
- Digital adoption by city
- Engagement signal using rating counts

### Page 3 — Restaurant Performance

- Performance Score
- Performance segments
- Rating vs. engagement
- High-rating / high-engagement restaurants
- Restaurant-level drill-through

### Page 4 — Cuisine Intelligence

- Top cuisines by restaurant count
- Cuisine rating comparison
- Cuisine pricing bands
- Digital adoption
- Engagement

> The repository currently contains the Power BI implementation specification. Dashboard screenshots will be refreshed after the source-backed `.pbix` is rebuilt.

---

## 🔎 Data Quality Findings

The source contains important analytical-quality issues that are explicitly handled rather than hidden:

- `rating = 0` is treated as unrated rather than a genuine zero-star score.
- `NEW` / `Nové` ratings are treated as missing.
- `cost_for_two` requires numeric parsing because values may contain commas.
- `zomato_url` is the source-level restaurant key used by the analytical model.
- Duplicate restaurant names are not automatically deleted because chain/location repetition can be legitimate.
- **12,869** coordinate records fall outside the selected India geographic QA bounds and are flagged.
- `famous_food` is missing for approximately **76.61%** of records and is not treated as complete.

See [`Documentation/SOURCE_PROFILE.md`](Documentation/SOURCE_PROFILE.md).

---

## 🧮 Source-Backed SQL Analysis

The primary SQL layer covers:

1. Restaurant supply by city
2. City quality and engagement
3. Pricing bands
4. Rating bands
5. Digital adoption by city
6. Cuisine performance
7. Restaurant performance scoring
8. Source-backed KPI views
9. Data-quality KPI views

Key files:

- [`SQL/13_Source_Backend_Restaurant_Analysis.sql`](SQL/13_Source_Backend_Restaurant_Analysis.sql)
- [`SQL/14_Source_Backend_Table_Setup.sql`](SQL/14_Source_Backend_Table_Setup.sql)
- [`SQL/15_Restaurant_Performance_Scoring.sql`](SQL/15_Restaurant_Performance_Scoring.sql)
- [`SQL/16_Source_Backend_KPI_Layer.sql`](SQL/16_Source_Backend_KPI_Layer.sql)
- [`SQL/17_Data_Quality_KPIs.sql`](SQL/17_Data_Quality_KPIs.sql)

---

## ⭐ Restaurant Performance Score

A transparent descriptive score ranks restaurants using:

| Component | Weight |
|---|---:|
| Rating quality percentile | **50%** |
| Log-transformed rating-count engagement percentile | **35%** |
| Digital availability | **15%** |

The score is a **portfolio segmentation tool**, not a profitability or revenue model.

Details: [`Documentation/PERFORMANCE_SCORE.md`](Documentation/PERFORMANCE_SCORE.md)

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

Those concepts appeared in the original learning version and are intentionally excluded from the source-backed narrative.

**Analytical credibility is more important than unsupported metrics.**

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
| [`EDA_FINDINGS.md`](Documentation/EDA_FINDINGS.md) | Source-backed EDA findings |
| [`PERFORMANCE_SCORE.md`](Documentation/PERFORMANCE_SCORE.md) | Performance-score methodology |
| [`POWER_BI_MODEL.md`](Documentation/POWER_BI_MODEL.md) | Power BI semantic model and DAX |
| [`SQL_EXECUTION_GUIDE.md`](Documentation/SQL_EXECUTION_GUIDE.md) | SQL execution and QA |
| [`INTERVIEW_STORY.md`](Documentation/INTERVIEW_STORY.md) | Interview preparation |
| [`REPOSITORY_ARCHITECTURE.md`](Documentation/REPOSITORY_ARCHITECTURE.md) | Recruiter-facing repo structure |
| [`PORTFOLIO_CHECKLIST.md`](Documentation/PORTFOLIO_CHECKLIST.md) | Final release QA |
| [`LEGACY_SQL_NOTICE.md`](Documentation/LEGACY_SQL_NOTICE.md) | Legacy workflow boundary |

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
│   ├── 02_clean_restaurant_data.py
│   ├── 03_eda_analysis.py
│   ├── 04_restaurant_score.py
│   └── run_pipeline.py
│
├── SQL/
│   ├── 01–09 legacy learning workflow
│   ├── 10_Portfolio_Analysis.sql
│   ├── 11_Data_Quality_Report.sql
│   ├── 12_Analyst_Quality_Gates.sql
│   ├── 13_Source_Backend_Restaurant_Analysis.sql
│   ├── 14_Source_Backend_Table_Setup.sql
│   ├── 15_Restaurant_Performance_Scoring.sql
│   ├── 16_Source_Backend_KPI_Layer.sql
│   └── 17_Data_Quality_KPIs.sql
│
├── PowerBI/
├── Screenshots/
├── Documentation/
├── requirements.txt
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

urlLinkedInhttps://www.linkedin.com/in/aatreya-pal-403ba8237
