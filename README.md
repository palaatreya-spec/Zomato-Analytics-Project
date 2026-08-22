# 🍽️ Zomato Restaurant Analytics

> **Portfolio project:** Analysis of a large restaurant-level dataset across India using **Python, MySQL/SQL and Power BI**.

**Tools:** Python • Pandas • MySQL • SQL • Power BI

---

## 📌 Project Overview

This project analyzes restaurant-level data to understand **restaurant supply, ratings, pricing, cuisine mix and digital-ordering adoption** across cities in India.

The dataset contains restaurant attributes such as restaurant name, city, cuisine, ratings, rating counts, listed cost-for-two, online ordering, table reservation and location information.

The project is designed as a practical **entry-level Data Analyst portfolio project**, with the focus on data cleaning, SQL analysis, dashboarding and business interpretation.

> **Important:** The dataset does not contain verified customer-level transactions or order revenue. Therefore, this project does not claim revenue, profit, customer lifetime value, retention or transaction-level analysis.

---

## 🎯 Business Questions

1. Which cities have the largest restaurant supply?
2. How do average ratings differ across cities?
3. How does listed cost-for-two vary across cities and price bands?
4. Which cuisines have the largest restaurant presence?
5. How common are online ordering and table reservations?
6. Which cities show higher digital-ordering adoption?
7. What data-quality issues need to be considered before analysis?

---

## 🔄 Project Workflow

```text
Raw Dataset
    ↓
Python Source Profiling
    ↓
Python Data Cleaning
    ↓
Python Basic EDA
    ↓
Cleaned Dataset
    ↓
MySQL / SQL Analysis
    ↓
Power BI Dashboard
    ↓
Business Insights
```

### Python scripts

```text
Python/
├── 01_source_profile.py
├── 02_clean_restaurant_data.py
└── 03_eda_analysis.py
```

### SQL scripts

```text
SQL/
├── 01_Table_Setup.sql
├── 02_Data_Quality_Checks.sql
├── 03_Restaurant_Analysis.sql
└── 04_KPI_Analysis.sql
```

---

## 🐍 Python Analysis

Python is used for practical data-preparation and exploratory analysis:

- Reading and profiling the source CSV
- Checking missing values and data types
- Cleaning restaurant ratings
- Converting cost-for-two into a numeric field
- Cleaning text fields
- Splitting latitude and longitude
- Creating basic data-quality flags
- Calculating simple overall, city and cuisine summaries
- Exporting cleaned and analytical datasets for further use

The Python work intentionally uses straightforward **Pandas-based analysis** appropriate for an entry-level Data Analyst project.

---

## 🗄️ SQL / MySQL Analysis

The SQL analysis focuses on practical business questions using:

- `SELECT` and `WHERE`
- `CASE` statements
- `GROUP BY` and `HAVING`
- `ORDER BY`
- `COUNT`, `SUM` and `AVG`
- Basic percentage calculations
- Simple data-quality checks

### Main analyses

- Restaurant count by city
- Average rating by city
- Pricing bands
- Rating bands
- Online-order and table-reservation adoption
- Cuisine-level restaurant analysis
- Overall and city-level KPIs

The SQL deliberately avoids unsupported revenue or customer metrics.

---

## 📊 Power BI Dashboard

The dashboard is designed around a simple restaurant-market analysis rather than an overly complex BI model.

### Main dashboard areas

**Market Overview**
- Restaurant count
- City count
- Average rating
- Average cost-for-two
- Online-order adoption
- Table-reservation adoption

**City Analysis**
- Restaurant supply by city
- Average rating by city
- Cost comparison
- Digital-ordering adoption

**Restaurant & Cuisine Analysis**
- Rating distribution
- Pricing bands
- Cuisine presence
- Cuisine rating comparison

Interactive slicers can be used to explore cities, cuisines and restaurant characteristics.

---

## 🔎 Data Quality

Some source fields require cleaning before analysis.

Examples include:

- Ratings such as `0`, `NEW` or `Nové` are treated as unavailable ratings rather than genuine zero-star ratings.
- Cost-for-two values require numeric cleaning because some values contain formatting such as commas.
- Restaurant URLs are used as the restaurant-level identifier in the cleaned dataset.
- Missing cuisine, rating and cost values are retained/flagged where appropriate rather than silently treated as valid values.
- Coordinates are checked for basic geographic validity.

The purpose of these checks is to make the analysis more reliable without introducing unnecessary modelling complexity.

---

## ⚠️ Dataset Limitations

This is a restaurant-level dataset, not a transaction database.

Therefore it cannot reliably answer questions about:

- Actual restaurant revenue
- Restaurant profit
- Customer lifetime value
- Customer retention
- Order frequency
- Average order value
- Monthly sales
- Customer-level behaviour

`Cost-for-two` is a **listed pricing field**, not restaurant revenue.

---

## 📚 Documentation

Additional project notes are available in the `Documentation/` folder, including:

- Business questions
- Data dictionary
- Source profile
- EDA findings
- Cleaning principles
- Assumptions and limitations
- Interview story

The documentation is intentionally kept focused on the final project rather than the project's internal development history.

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
│   └── run_pipeline.py
│
├── SQL/
│   ├── 01_Table_Setup.sql
│   ├── 02_Data_Quality_Checks.sql
│   ├── 03_Restaurant_Analysis.sql
│   └── 04_KPI_Analysis.sql
│
├── PowerBI/
├── Screenshots/
├── Documentation/
├── requirements.txt
└── README.md
```

---

## 💡 Business Interpretation

The project follows a simple analytical approach:

**Metric → Pattern → Interpretation → Business takeaway**

For example, a city with a large restaurant base but lower online-order adoption can be identified as a market where restaurant supply and digital availability differ. This should be treated as an observation from the dataset, not as proof of a business opportunity without further information.

---

## 👨‍💻 Author

**Aatreya Pal**  
Aspiring Data Analyst

**Core skills:** SQL • Python • Advanced Excel • Power BI • Data Analysis

[LinkedIn](https://www.linkedin.com/in/aatreya-pal-403ba8237)
