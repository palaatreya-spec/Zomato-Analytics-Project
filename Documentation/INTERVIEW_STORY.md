# Interview Story — Zomato Restaurant Analytics

## 30-second version

I analyzed a 224K+ restaurant dataset using Python, SQL and Power BI. I first profiled the source and found issues such as placeholder ratings, mixed-format pricing and invalid geographic coordinates. I built a reproducible cleaning layer, standardized the analytical fields, then used SQL and Python to study city supply, ratings, pricing, cuisine mix and digital-order adoption. I also created a transparent performance score combining quality, engagement and digital availability, and designed a Power BI model around source-backed KPIs.

## Why did you not calculate revenue?

The source contains restaurant attributes but no verified order-level transaction revenue. Rather than fabricate revenue or profitability metrics, I explicitly removed those claims from the source-backed analysis and used listed cost-for-two as a pricing proxy.

## Why is rating count used as engagement?

Rating count is an observable source field and can act as a descriptive proxy for customer engagement or visibility. It is not equivalent to orders, customers or revenue, so I interpret it cautiously.

## Why use percentiles in the performance score?

Restaurant rating and rating count operate on different scales. Percentile transformation puts them on a comparable relative scale. A log transformation is applied to rating count first so extreme engagement values have less influence.

## What was the biggest data-quality issue?

Ratings contain numeric scores as well as `0`, `NEW`, and `Nové`. Treating those values as genuine ratings would distort averages, so they are normalized to missing before quality analysis.

## What business decision can this support?

The analysis can help identify markets and restaurant segments with stronger quality, engagement and digital availability, which can inform where to investigate growth opportunities or operational gaps. It is descriptive rather than causal.

## Key technical skills demonstrated

- Python/Pandas data profiling and transformation
- MySQL data modelling and QA
- CTEs and window functions
- Percentile-based segmentation
- KPI design and metric governance
- Power BI semantic modelling and DAX
- Business interpretation and limitations
