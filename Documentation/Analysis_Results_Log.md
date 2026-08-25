# Zomato Analysis Results Log

> Working record of SQL and Python analysis results for the Zomato Analytics portfolio project.
> Large query outputs are summarized rather than copied in full.

---

## SQL Results

### Q01 — Total restaurants, total cities, total areas, total cuisines
- **Status:** Completed and result recorded.

| Metric | Result |
|---|---:|
| Total restaurants | 224,520 |
| Total cities | 83 |
| Total areas | 2,500 |
| Total cuisines | 19,675 |

**Key observation:** The dataset contains 224,520 restaurant records across 83 cities, 2,500 areas and 19,675 cuisine values.

### Q02 — Restaurant distribution by city
- **Status:** Completed and result recorded.

**Top cities:** Delhi NCR 38,699 (17.24%); Mumbai 25,692 (11.44%); Bengaluru 20,283 (9.03%); Pune 15,430 (6.87%); Hyderabad 12,393 (5.52%); Chennai 11,917 (5.31%); Kolkata 9,571 (4.26%); Ahmedabad 6,432 (2.86%); Jaipur 5,367 (2.39%); Chandigarh 4,278 (1.91%).

**Key observation:** Delhi NCR has the largest restaurant presence. Delhi NCR, Mumbai and Bengaluru together account for approximately **37.7%** of restaurant records.

### Q03 — City-level restaurant performance
- **Status:** Completed and result recorded.

**Selected results:** Bengaluru 20,283 restaurants, 67.00% rating coverage, 3.61 avg rating, 139 avg rating count; Delhi NCR 38,699, 63.38%, 3.52, 105; Mumbai 25,692, 70.58%, 3.51, 141; Hyderabad 12,393, 70.82%, 3.46, 153; Kolkata 9,571, 70.47%, 3.46, 145; Pune 15,430, 63.42%, 3.45, 98.

**Key observation:** Rating coverage varies substantially, so city comparisons should consider coverage and sample size.

### Q04 — Rating Distribution
- **Status:** Completed and result recorded.

**Key observation:** Ratings are concentrated around **3.2–3.9**, with **3.30** the largest individual rating bucket at **8.98%**.

### Q05 — Rating Band Distribution
- **Status:** Completed and result recorded.

| Rating band | Restaurant count | % of rated restaurants |
|---|---:|---:|
| Below 2.5 | 629 | 0.43% |
| 2.5 - 2.9 | 13,134 | 9.07% |
| 3.0 - 3.4 | 55,638 | 38.44% |
| 3.5 - 3.9 | 55,036 | 38.03% |
| 4.0+ | 20,298 | 14.02% |

**Key observation:** **76.47%** of rated restaurants fall between **3.0 and 3.9**.

### Q06 — Rating vs Customer Engagement
- **Status:** Completed and result recorded.

| Rating band | Restaurant count | Restaurants with reviews | Avg rating count | Avg positive rating count |
|---|---:|---:|---:|---:|
| Below 2.5 | 629 | 627 | 108 | 108 |
| 2.5 - 2.9 | 13,134 | 12,908 | 45 | 45 |
| 3.0 - 3.4 | 55,638 | 54,852 | 29 | 29 |
| 3.5 - 3.9 | 55,036 | 54,026 | 138 | 141 |
| 4.0+ | 20,298 | 19,984 | 570 | 579 |

**Key observation:** The **4.0+ band has the strongest observed customer engagement**, averaging 570 ratings per restaurant versus 29 for the 3.0–3.4 band. Association, not causation.

### Q07 — Most Reviewed Restaurants
- **Status:** Completed and result recorded.

**Selected:** Bawarchi, Hyderabad — 4.50 rating, 42,621 ratings, ₹750; Byg Brewski Brewing Company, Bengaluru — 4.90, 19,305, ₹1,600; Toit, Bengaluru — 4.60, 15,731, ₹1,000; Truffles, Bengaluru — 4.60, 15,653, ₹900; Hauz Khas Social, Delhi NCR — 4.70, 14,936.

**Key observation:** Bawarchi leads with **42,621 ratings**. Bengaluru and Hyderabad are prominent among highly reviewed restaurants.

### Q08 — Most Common Cuisine Listings
- **Status:** Completed and result recorded.

**Top listings:** North Indian 20,549 (9.15%); Fast Food 11,462 (5.11%); North Indian, Chinese 11,230 (5.00%); South Indian 6,676 (2.97%); Bakery 5,703 (2.54%); Chinese 5,346 (2.38%).

**Key observation:** North Indian is the most common cuisine listing. The `0` listing (1,330; 0.59%) is treated as a data-quality/missing-value category. Cuisine listings are not mutually exclusive.

### Q09 — Cuisine Performance
- **Status:** Completed and result recorded.

**Selected:** Desserts, Beverages 3.74 avg rating; Burger, Fast Food 3.71 rating and 331 avg ratings; Ice Cream, Desserts 3.62; Pizza, Fast Food 3.54 rating and 251 avg ratings; North Indian 3.38 rating and 90 avg ratings; Fast Food 3.39 rating and 56 avg ratings.

**Key observation:** Several specialized listings show stronger observed ratings/engagement than large mainstream listings. Sample size and coverage must be considered.

### Q10 — Most Popular Cuisine Listings
- **Status:** Completed and result recorded.

**Top listings:** North Indian 20,549 (9.21%); Fast Food 11,462 (5.14%); North Indian, Chinese 11,230 (5.03%); South Indian 6,676 (2.99%); Bakery 5,703 (2.56%); Chinese 5,346 (2.40%); Street Food 4,134 (1.85%); Bakery, Desserts 3,297 (1.48%); Biryani 2,791 (1.25%); Chinese, North Indian 2,675 (1.20%).

**Key observation:** North Indian is the largest cuisine listing. This largely validates Q08 and will be treated as supporting analysis rather than a separate headline finding.

### Q11 — Online Ordering Analysis
- **Status:** Completed and result recorded.

| Online order status | Restaurant count | % of restaurants |
|---|---:|---:|
| Online Order Not Available | 113,210 | 50.42% |
| Online Order Available | 111,310 | 49.58% |

**Key observation:** Online-order availability is almost evenly split; the difference is only **1,900 restaurants (0.84 percentage points)**.

### Q12 — Online Ordering by City
- **Status:** Completed and result recorded.

**Highest adoption:** Jhansi 72.93%; Patiala 72.72%; Jabalpur 66.58%; Gwalior 66.42%; Kota 62.46%; Nagpur 62.02%; Chandigarh 60.71%; Bhopal 60.49%; Agra 60.42%; Surat 59.03%.

**Major-city results:** Hyderabad 52.34%; Kolkata 51.54%; Ahmedabad 50.82%; Delhi NCR 50.78%; Chennai 50.06%; Mumbai 47.64%; Bengaluru 47.17%; Pune 47.01%.

**Lowest adoption:** Goa 15.73%; Siliguri 34.78%; Puducherry 36.56%; Trivandrum 38.49%; Kochi 41.75%.

**Key observation:** Online-order adoption varies substantially by city, ranging from **72.93% in Jhansi to 15.73% in Goa**. Small-city percentages should be interpreted alongside restaurant count.

### Q13 — Online Ordering vs Restaurant Characteristics
- **Status:** Completed and result recorded.

| Online order status | Restaurant count | Avg rating | Avg rating count | Avg cost for two | Table reservation % |
|---|---:|---:|---:|---:|---:|
| Online Order Available | 111,310 | 3.55 | 173 | ₹421 | 3.48% |
| Online Order Not Available | 113,210 | 3.39 | 115 | ₹430 | 2.43% |

**Key observation:** Restaurants with online ordering have higher average rating (3.55 vs 3.39), higher rating engagement (173 vs 115), slightly lower average cost for two (₹421 vs ₹430), and higher table-reservation adoption (3.48% vs 2.43%). Association, not causation.

### Q14 — Online Ordering vs Financial Performance
- **Status:** Completed and result recorded.
- **Question:** Do restaurants with and without online ordering show different estimated financial performance?

> **Data-quality note:** The supplied output labels both rows as `Online Order Not Available`. Because the restaurant counts exactly correspond to the Q11 online-order groups (111,310 and 113,210), the first row is recorded below as **Online Order Available** based on the established grouping. This should be verified against the original SQL output before the final README is published.

| Online order status | Restaurant count | Avg estimated revenue | Avg contribution margin |
|---|---:|---:|---:|
| Online Order Available* | 111,310 | ₹48,152 | ₹36,987.47 |
| Online Order Not Available | 113,210 | ₹29,249 | ₹23,663.12 |

**Key observation (pending label verification):** The group represented by 111,310 restaurants has substantially higher average estimated revenue and contribution margin than the 113,210 group. The gap is approximately **₹18,903 in estimated revenue** and **₹13,324.35 in contribution margin** per restaurant.

**Interpretation caution:** These are estimated financial metrics and group-level associations. They do not establish that online ordering causes higher or lower revenue/margins. Verify the first-row label in the SQL result before using this as a headline claim.

### Q15 — Revenue Contribution by Online Ordering
- **Status:** Planned; run and record result before proceeding.

### Q16 — Planned
- **Status:** To be defined after reviewing Q15 results.

### Q17 — Planned
- **Status:** To be defined after reviewing prior results.

### Q18 — Planned
- **Status:** To be defined after reviewing prior results.

### Q19 — Planned
- **Status:** To be defined after reviewing prior results.

### Q20 — Planned stopping point
- **Status:** To be defined only if it adds a meaningful, non-repetitive business question.

---

## Python Results

### P01 — Pending result record
- **Status:** Results to be reconstructed from completed Python analysis.

### P02 — Pending result record
- **Status:** Results to be reconstructed from completed Python analysis.

### P03 — Pending result record
- **Status:** Results to be reconstructed from completed Python analysis.

> Additional Python result entries will be added as the existing analysis is reviewed.

---

## README Candidate Findings

Only validated findings with actual recorded outputs should be promoted here.

- Q01: Dataset contains 224,520 restaurants across 83 cities, 2,500 areas and 19,675 cuisine values.
- Q02: Restaurant supply is geographically concentrated; Delhi NCR, Mumbai and Bengaluru account for approximately 37.7% of restaurant records.
- Q03: City-level rating coverage varies substantially; average ratings should be interpreted alongside coverage and sample size.
- Q04: Ratings are concentrated around the 3.2–3.9 range, with 3.30 as the largest individual rating bucket at 8.98%.
- Q05: 76.47% of rated restaurants fall in the 3.0–3.9 rating bands.
- Q06: The 4.0+ rating band has substantially higher observed rating activity than the 3.0–3.4 band, indicating an association between high ratings and customer engagement.
- Q07: Bawarchi in Hyderabad leads the top-reviewed list with 42,621 ratings.
- Q08: North Indian is the most common cuisine listing at 20,549 restaurants.
- Q09: Several specialized cuisine listings show stronger observed ratings and engagement than large mainstream listings.
- Q10: North Indian is the largest cuisine listing by restaurant presence; this largely validates Q08.
- Q11: Online ordering is almost evenly split: 49.58% available vs 50.42% unavailable.
- Q12: Online-order adoption varies widely by city, from 72.93% in Jhansi to 15.73% in Goa.
- Q13: Online-ordering restaurants have higher average ratings (3.55 vs 3.39), higher average rating counts (173 vs 115), slightly lower average cost for two (₹421 vs ₹430), and higher table-reservation adoption (3.48% vs 2.43%).
- Q14: The supplied financial result has a duplicated status label; the first row likely represents Online Order Available based on its 111,310 count. The label must be verified before promoting the finding to the README.

---

## Recording Rules

1. Record actual outputs, not estimates or remembered values.
2. Use the exact query name from the SQL project when available.
3. For small outputs, preserve the complete result.
4. For large outputs, preserve important aggregates, rankings or representative rows needed to support the conclusion.
5. Record the business question and key insight for every completed analysis.
6. Record caveats when a result could be misinterpreted.
7. Do not add README claims until the underlying result has been validated.
8. Update this file after each completed SQL/Python analysis.
