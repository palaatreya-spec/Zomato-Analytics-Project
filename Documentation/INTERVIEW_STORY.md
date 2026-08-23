# Interview Story — Zomato Restaurant Analytics

## 30-second version

I analyzed a restaurant-level dataset using Python, MySQL and Power BI. I first profiled the data and found issues such as placeholder ratings, mixed-format pricing and some invalid coordinates. I cleaned the important fields using Pandas, created a cleaned dataset, and then used basic SQL analysis to study restaurant supply, ratings, pricing, cuisine mix and online-order adoption. Finally, I used the resulting KPIs and analysis to build a Power BI dashboard.

## Why did you not calculate revenue?

The dataset does not contain verified order-level transaction data or revenue. So I did not make revenue or profit claims. I used the available cost-for-two field as a pricing measure instead.

## Why did you clean ratings such as `0`, `NEW` and `Nové`?

These values do not represent a normal 1–5 restaurant rating. Treating them as real ratings would reduce the accuracy of average-rating calculations, so I converted them to missing values before analysis.

## What did you use Python for?

I used Pandas for source profiling, data cleaning, basic data-quality checks and exploratory summaries. Python was mainly the data-preparation step before SQL and Power BI analysis.

## What did you use SQL for?

I used MySQL to validate the cleaned data and answer business questions such as restaurant count by city, average rating, pricing bands, cuisine analysis and online-order adoption.

## Why use SQL after Python?

Python was useful for cleaning and preparing the dataset. SQL was then useful for grouping, filtering and comparing the cleaned data from a business-analysis perspective. This also gave me practice using the same dataset with different analyst tools.

## What business decision can this support?

The analysis can help compare restaurant markets by supply, ratings, pricing and digital-ordering availability. These are descriptive findings from the dataset and would need additional business data before making a major commercial decision.

## Key technical skills demonstrated

- Python/Pandas data cleaning and basic EDA
- MySQL and practical SQL analysis
- Data-quality checks
- KPI calculations
- Power BI dashboarding
- Business interpretation
- Understanding of dataset limitations

> **Interview rule:** Every technique used in this project is intentionally kept at a level that I can explain and demonstrate as a fresher Data Analyst.
