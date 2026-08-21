# Restaurant Performance Score

## Purpose

The Performance Score is a **descriptive prioritization framework** for comparing restaurants in the source dataset. It is not a revenue, profit, customer-lifetime-value, or causal model.

## Components

| Component | Weight | Rationale |
|---|---:|---|
| Quality percentile | 50% | Rating is the strongest direct quality signal available |
| Engagement percentile | 35% | Rating count provides a proxy for customer engagement/visibility |
| Digital availability | 15% | Online ordering receives 70% of this component and table reservation 30% |

### Engagement transformation

`log(1 + rating_count)` is used before percentile ranking so extremely popular restaurants do not dominate the score purely because of scale.

### Segment thresholds

| Score | Segment |
|---:|---|
| 75–100 | Top Performer |
| 50–74.99 | Strong |
| 25–49.99 | Established |
| <25 | Developing |

## Interpretation

A high score means the restaurant combines relatively strong rating, engagement and digital availability **within this dataset**.

It does **not** mean:

- highest revenue
- highest profit
- best customer retention
- strongest unit economics
- causal business performance

## Limitations

The weights are an analytical design choice rather than an externally validated business model. The score should therefore be presented as a portfolio segmentation tool and not as an official Zomato ranking.
