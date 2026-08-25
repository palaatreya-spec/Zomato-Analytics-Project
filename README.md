# 🍽️ Zomato Restaurant Analytics

> **Portfolio project:** Analysis of a large restaurant-level dataset across India using **Python, MySQL/SQL and Power BI**.

**Tools:** Python • Pandas • MySQL • SQL • Power BI

## 📊 Project Completion

**Current completion: ~70%**

> Current checkpoint: **Raw data → Python profiling → cleaning → EDA → validation → MySQL → SQL analysis Q1–Q20 complete.**
>
> Power BI and final presentation are intentionally pending because the existing dashboard/screenshots are from an earlier version of the pipeline and will be rebuilt after the SQL stage.

---

## 📌 Project Overview

This project analyzes restaurant-level data to understand **restaurant supply, ratings, pricing, cuisine mix, digital-ordering adoption, table reservations and estimated unit-economics patterns** across cities in India.

The dataset contains restaurant attributes such as restaurant name, city, cuisine, ratings, rating counts, listed cost-for-two, online ordering, table reservation and location information.

The project is designed as a practical **entry-level Data Analyst portfolio project**, with the focus on data cleaning, exploratory analysis, SQL business analysis, dashboarding and business interpretation.

> **Important:** The source dataset does not contain verified customer-level transactions or actual restaurant sales. Financial analysis in the later SQL stage uses **estimated unit-economics metrics** from the project dataset and must not be interpreted as verified Zomato revenue or profit.

---

## 🎯 Business Questions

The analysis progressively addresses questions around:

1. Restaurant supply and geographic distribution
2. Rating coverage and rating distribution
3. Customer engagement through rating activity
4. Highly reviewed restaurants
5. Cuisine presence and cuisine-level performance
6. Online-order adoption and city-level differences
7. Online ordering vs restaurant characteristics
8. Online ordering vs estimated financial performance
9. City-level estimated financial performance
10. Table-reservation availability and restaurant characteristics
11. Cost bands vs estimated financial performance
12. Delivery-only vs non-delivery-only restaurant performance

The SQL stage currently contains **20 practical, interview-explainable exploratory questions** rather than extending the project with unnecessary complexity.

---

## 🔄 Project Workflow

```text
Raw Dataset
    ↓
Python Source Profiling
    ↓
Python Data Cleaning
    ↓
Python EDA
    ↓
Python Validation
    ↓
Cleaned / Validated Data
    ↓
MySQL Table Setup
    ↓
SQL Data Quality Checks
    ↓
SQL Business & Exploratory Analysis
    ↓
Q1–Q20 Complete ✅
    ↓
Power BI Rebuild ⏳
    ↓
New Screenshots ⏳
    ↓
Final Insights & Portfolio Presentation ⏳
```

---

## 🐍 Python Analysis

Python is used for practical data preparation, quality checks and exploratory analysis:

- Reading and profiling the source CSV
- Checking missing values and data types
- Cleaning restaurant ratings
- Converting cost-for-two into a numeric field
- Cleaning text fields
- Splitting latitude and longitude
- Creating basic data-quality flags
- Calculating overall, city and cuisine summaries
- Exporting cleaned and analytical datasets for SQL/BI use
- Validating the cleaned output before downstream analysis

The Python work intentionally uses straightforward **Pandas-based analysis** appropriate for an entry-level Data Analyst project.

---

## 🗄️ SQL / MySQL Analysis

The SQL stage has now been completed through **20 exploratory business questions**.

The analysis uses practical SQL concepts including:

- `SELECT` and `WHERE`
- `CASE` statements
- `GROUP BY` and `HAVING`
- `ORDER BY`
- `COUNT`, `SUM` and `AVG`
- Percentage calculations
- Conditional aggregation
- Business segmentation using `CASE`
- Window-function usage with `RANK()`
- Schema validation when working across analysis tables

### Main analysis areas

- Restaurant distribution by city
- City-level rating coverage and performance
- Rating distribution and rating bands
- Rating/customer-engagement relationships
- Most-reviewed restaurants
- Cuisine popularity and performance
- Online-order availability and city adoption
- Online ordering vs restaurant characteristics
- Online ordering vs estimated financial performance
- Revenue and contribution-margin comparisons
- City-level estimated financial performance
- City revenue ranking
- Table-reservation availability vs restaurant characteristics
- Cost-for-two bands vs estimated financial performance
- Delivery-only vs non-delivery-only restaurant performance

The detailed SQL is maintained in:

`SQL/05_Exploratory_Analysis.sql`

The corresponding validated findings and interview-learning notes are maintained in the `Documentation/` folder.

### Important financial limitation

The unit-economics analysis uses **estimated revenue, estimated orders and contribution-margin fields available in the project dataset**. These are analytical estimates, not verified Zomato transaction or accounting figures.

---

## 📊 Power BI Dashboard — Next Stage

The current Power BI dashboard and screenshots are **not treated as the final version**.

They were created before the Python/EDA/SQL pipeline was updated and will be rebuilt after the SQL analysis is finalized.

The next Power BI stage will:

- Reconcile dashboard metrics with the finalized SQL definitions
- Rebuild relevant KPIs and measures
- Update visuals around the strongest validated findings
- Replace outdated screenshots
- Document the final dashboard model

---

## 🔎 Data Quality

Some source fields require cleaning before analysis.

Examples include:

- Ratings such as `0`, `NEW` or `Nové` are treated as unavailable ratings rather than genuine zero-star ratings.
- Cost-for-two values require numeric cleaning because some values contain formatting such as commas.
- Restaurant URLs are used as the restaurant-level identifier in the cleaned dataset.
- Missing cuisine, rating and cost values are retained/flagged where appropriate rather than silently treated as valid values.
- Coordinates are checked for basic geographic validity.
- Service flags and text fields are normalized before analysis where required.

The project also uses validation checks to confirm that the cleaned data is suitable for downstream SQL and BI analysis.

---

## ⚠️ Dataset Limitations

This is a restaurant-level dataset, not a transaction database.

Therefore it cannot reliably answer questions about:

- Actual restaurant revenue
- Actual restaurant profit
- Customer lifetime value
- Customer retention
- Order frequency
- Monthly sales
- Customer-level behaviour

`Cost-for-two` is a **listed pricing field**, not restaurant revenue.

Where the later unit-economics table is used, financial values are explicitly treated as **estimated analytical metrics** rather than verified business figures.

Observational comparisons are interpreted as associations rather than causal relationships unless stronger evidence exists.

---

## 📚 Documentation

The `Documentation/` folder contains the project's working knowledge base, including:

- Business questions
- Data dictionary
- Source profile
- Cleaning principles
- EDA findings
- Assumptions and limitations
- SQL execution guidance
- SQL learning notes
- Analysis results log
- Project journey
- Pipeline synchronization notes
- Power BI model documentation
- Interview story

The working documentation records only relevant project information: validated results, important findings, technical learning, data-quality problems, decisions, fixes, caveats and interview explanations.

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
│   ├── 04_validate_output.py
│   └── run_pipeline.py
│
├── SQL/
│   ├── 01_Table_Setup.sql
│   ├── 02_Data_Quality_Checks.sql
│   ├── 03_Restaurant_Analysis.sql
│   ├── 04_KPI_Analysis.sql
│   └── 05_Exploratory_Analysis.sql
│
├── PowerBI/
├── Screenshots/
├── Documentation/
├── requirements.txt
└── README.md
```

---

## 💡 Business Interpretation Approach

The project follows a simple analytical approach:

**Business question → SQL/Python analysis → validated result → pattern → interpretation → business takeaway → caveat**

For example, city-level analysis can show differences in restaurant supply, ratings, digital-order adoption and estimated financial performance. These are treated as observations from the dataset rather than proof of causation or verified business impact.

---

## 👨‍💻 Author

**Aatreya Pal**  
Aspiring Data Analyst

**Core skills:** SQL • Python • Advanced Excel • Power BI • Data Analysis

[LinkedIn](https://www.linkedin.com/in/aatreya-pal-403ba8237)
