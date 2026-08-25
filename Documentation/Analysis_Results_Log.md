# Zomato Analysis Results Log

> Working record of SQL and Python analysis results for the Zomato Analytics portfolio project. Large outputs are summarized; useful findings, SQL concepts, interview explanations, validation notes, and project-learning notes are retained.

---

## How to Use This Document

This is the **working knowledge base** for the project, not just a results dump.

For every analysis we aim to retain:
- the business question;
- the SQL approach and concepts learned;
- the important output rather than every large row;
- the business interpretation;
- caveats and data-quality issues;
- an interview-friendly explanation;
- whether the analysis is worth highlighting in the final README.

This keeps the project reproducible and makes it easier to revise SQL concepts later without relying on memory.

---

## SQL Results

### Q01 — Total restaurants, total cities, total areas, total cuisines
- **Result:** 224,520 restaurants; 83 cities; 2,500 areas; 19,675 cuisine values.
- **Useful finding:** The dataset has broad geographic and cuisine coverage and is large enough for city-, cuisine-, rating- and ordering-level comparisons.
- **SQL concepts:** `COUNT`, aggregate functions, basic dataset profiling.
- **Interview explanation:** "I started by profiling the dataset to understand its size and geographic/cuisine coverage before doing deeper analysis."

### Q02 — Restaurant distribution by city
- **Top cities:** Delhi NCR 38,699 (17.24%); Mumbai 25,692 (11.44%); Bengaluru 20,283 (9.03%); Pune 15,430 (6.87%); Hyderabad 12,393 (5.52%); Chennai 11,917 (5.31%); Kolkata 9,571 (4.26%).
- **Useful finding:** Delhi NCR, Mumbai and Bengaluru together account for approximately **37.7%** of all restaurant records, showing strong geographic concentration.
- **Caveat:** City percentages describe restaurant supply, not market revenue or demand.
- **SQL concepts:** `GROUP BY`, `COUNT`, percentage calculation, `ORDER BY`.
- **Interview explanation:** "I grouped restaurants by city and calculated each city's share of the total restaurant population."

### Q03 — City-level restaurant performance
- **Selected:** Bengaluru: 20,283 restaurants, 67.00% rating coverage, 3.61 avg rating, 139 avg rating count; Delhi NCR: 38,699, 63.38%, 3.52, 105; Mumbai: 25,692, 70.58%, 3.51, 141; Hyderabad: 12,393, 70.82%, 3.46, 153; Kolkata: 9,571, 70.47%, 3.46, 145; Pune: 15,430, 63.42%, 3.45, 98.
- **Useful finding:** Bengaluru has the highest average rating among the major cities shown (**3.61**), while Hyderabad has both high rating coverage (**70.82%**) and relatively high rating engagement (**153**).
- **Important caveat:** Several smaller cities have extreme results because of very small rated samples. Rating coverage must be considered alongside average rating.
- **SQL concepts:** grouped aggregates, conditional counts, percentage calculations.
- **Interview explanation:** "I compared cities not only by restaurant count but also by how many restaurants had ratings and how much rating activity they received."

### Q04 — Rating Distribution
- **Result:** Individual rating buckets are concentrated around **3.2–3.9**; 3.30 is the largest bucket at **12,991 restaurants / 8.98%** of rated restaurants.
- **Useful finding:** The dataset is not dominated by either very low or very high ratings; the central rating range is the norm.
- **SQL concepts:** grouping by a cleaned numeric rating and percentage of total rated restaurants.
- **Interview explanation:** "I looked at the distribution of ratings rather than relying only on an overall average."

### Q05 — Rating Band Distribution

| Rating band | Restaurant count | % of rated restaurants |
|---|---:|---:|
| Below 2.5 | 629 | 0.43% |
| 2.5 - 2.9 | 13,134 | 9.07% |
| 3.0 - 3.4 | 55,638 | 38.44% |
| 3.5 - 3.9 | 55,036 | 38.03% |
| 4.0+ | 20,298 | 14.02% |

- **Useful finding:** **76.47%** of rated restaurants are between **3.0 and 3.9**, while only **0.43%** are below 2.5 and **14.02%** are 4.0+.
- **SQL concepts:** `CASE`, conditional grouping, percentage calculations.
- **Interview explanation:** "I converted individual ratings into business-friendly rating bands to make the distribution easier to interpret."

### Q06 — Rating vs Customer Engagement

| Rating band | Restaurant count | Restaurants with reviews | Avg rating count | Avg positive rating count |
|---|---:|---:|---:|---:|
| Below 2.5 | 629 | 627 | 108 | 108 |
| 2.5 - 2.9 | 13,134 | 12,908 | 45 | 45 |
| 3.0 - 3.4 | 55,638 | 54,852 | 29 | 29 |
| 3.5 - 3.9 | 55,036 | 54,026 | 138 | 141 |
| 4.0+ | 20,298 | 19,984 | 570 | 579 |

- **Useful finding:** The 4.0+ group has dramatically higher observed rating activity (**570 average ratings**) than the 3.0–3.4 group (**29**).
- **Important interpretation:** This is an association. It does not prove that higher ratings cause more reviews; popularity, visibility, restaurant age or other factors may contribute.
- **SQL concepts:** conditional aggregation, `CASE`, grouped comparison.
- **Interview explanation:** "I compared rating bands against rating activity to see whether higher-rated restaurants also showed higher observed engagement, while avoiding causal claims."

### Q07 — Most Reviewed Restaurants
- **Top result:** Bawarchi, Hyderabad — **42,621 ratings**, 4.50 rating, ₹750 cost for two.
- Other highly reviewed examples include Byg Brewski Brewing Company (Bengaluru, 19,305), Toit (Bengaluru, 15,731), Truffles (Bengaluru, 15,653), Hauz Khas Social (Delhi NCR, 14,936).
- **Useful finding:** High-engagement restaurants are concentrated notably in Bengaluru and Hyderabad, with Bawarchi a clear outlier in review volume.
- **Caveat:** Restaurant names repeat across cities, so analysis should use restaurant + city/area where appropriate.
- **SQL concepts:** `ORDER BY ... DESC`, top-N analysis.
- **Interview explanation:** "I ranked individual restaurant records by rating count to identify the most reviewed restaurants."

### Q08 — Most Common Cuisine Listings
- **Top listings:** North Indian 20,549 (9.15%); Fast Food 11,462 (5.11%); North Indian, Chinese 11,230 (5.00%); South Indian 6,676 (2.97%); Bakery 5,703 (2.54%); Chinese 5,346 (2.38%); Street Food 4,134 (1.84%).
- **Useful finding:** North Indian is the most common cuisine listing. Cuisine values are combinations/listings rather than mutually exclusive single cuisines.
- **Data-quality note:** `0` appears as a cuisine listing for 1,330 restaurants (0.59%) and should be treated as a missing/invalid category rather than a real cuisine.
- **SQL concepts:** grouping text categories, counts, percentages.

### Q09 — Cuisine Performance
- **Highest selected averages:** Desserts, Beverages 3.74; Burger, Fast Food 3.71 with 331 average ratings; Beverages, Desserts 3.65; Ice Cream, Desserts 3.62; Cafe, Fast Food 3.56; Pizza, Fast Food 3.54 with 251 average ratings.
- **Large mainstream examples:** North Indian 3.38 rating / 90 avg ratings; Fast Food 3.39 / 56; Chinese 3.36 / 74; Biryani 3.33 / 69.
- **Useful finding:** Some specialized/combo cuisine listings show stronger observed ratings and customer engagement than high-volume mainstream listings.
- **Caveat:** Cuisine listings differ in size and rating coverage, so ranking cuisines by average rating alone can be misleading.
- **SQL concepts:** grouped aggregates, conditional counts, multi-metric comparison.

### Q10 — Most Popular Cuisine Listings
- **Top:** North Indian 20,549 (9.21%); Fast Food 11,462 (5.14%); North Indian, Chinese 11,230 (5.03%); South Indian 6,676 (2.99%); Bakery 5,703 (2.56%); Chinese 5,346 (2.40%).
- **Useful finding:** Q10 independently reinforces Q08: North Indian is the largest cuisine listing by restaurant presence.
- **Documentation note:** Keep this as supporting/validation analysis rather than presenting Q08 and Q10 as two separate major insights.
- **SQL concepts:** ranking/grouped counts and validation of an earlier finding.

### Q11 — Online Ordering Analysis

| Online order status | Restaurant count | % of restaurants |
|---|---:|---:|
| Online Order Not Available | 113,210 | 50.42% |
| Online Order Available | 111,310 | 49.58% |

- **Useful finding:** Overall online-order availability is almost perfectly balanced: only **0.84 percentage points** separate the groups.
- **Business implication:** A national-level percentage alone hides meaningful city-level differences, which Q12 investigates.
- **SQL concepts:** `CASE`, `GROUP BY`, percentage of total.

### Q12 — Online Ordering by City
- **Highest adoption:** Jhansi 72.93%; Patiala 72.72%; Jabalpur 66.58%; Gwalior 66.42%; Kota 62.46%; Nagpur 62.02%; Chandigarh 60.71%; Bhopal 60.49%; Agra 60.42%; Surat 59.03%.
- **Major-city adoption:** Hyderabad 52.34%; Kolkata 51.54%; Ahmedabad 50.82%; Delhi NCR 50.78%; Chennai 50.06%; Mumbai 47.64%; Bengaluru 47.17%; Pune 47.01%.
- **Lowest:** Goa 15.73%; Siliguri 34.78%; Puducherry 36.56%; Trivandrum 38.49%; Kochi 41.75%.
- **Useful finding:** City-level adoption ranges from **72.93% to 15.73%**, showing that the near-50/50 national split conceals substantial geographic variation.
- **Caveat:** Small cities can show extreme percentages because their restaurant counts are smaller; interpret adoption rate with restaurant count.
- **SQL concepts:** grouped conditional counts, percentages, sorting.

### Q13 — Online Ordering vs Restaurant Characteristics

| Online order status | Restaurant count | Avg rating | Avg rating count | Avg cost for two | Table reservation % |
|---|---:|---:|---:|---:|---:|
| Online Order Available | 111,310 | 3.55 | 173 | ₹421 | 3.48% |
| Online Order Not Available | 113,210 | 3.39 | 115 | ₹430 | 2.43% |

- **Useful finding:** Restaurants with online ordering have **0.16 higher average rating**, **58 more average ratings**, **₹9 lower average cost for two**, and **1.05 percentage points higher table-reservation adoption**.
- **Relative engagement:** 173 vs 115 means the online-order group has roughly **50% more average rating activity**.
- **Interpretation:** Strong evidence of a relationship between online-order availability and a more engaged/higher-rated restaurant profile, but not proof of causation.
- **SQL concepts:** `CASE`, grouped comparison, conditional `AVG`, `SUM` for percentage calculations.
- **Interview explanation:** "I compared restaurants with and without online ordering across rating, engagement, price and reservation adoption to identify differences in their observed profiles."

### Q14 — Online Ordering vs Financial Performance
- **Supplied output:** first row labeled `Online Order Not Available` with 111,310 restaurants, ₹48,152 avg estimated revenue, ₹36,987.47 avg contribution margin; second row labeled `Online Order Not Available` with 113,210 restaurants, ₹29,249 revenue, ₹23,663.12 margin.
- **Data-quality correction:** Q11/Q13 establish that **111,310 = Online Order Available** and **113,210 = Online Order Not Available**. Therefore the first Q14 label appears duplicated/incorrect and is recorded as `Online Order Available*` pending verification of the original SQL output.
- **Useful finding if the grouping is confirmed:** The 111,310 group is approximately **₹18,903 higher in average estimated revenue** and **₹13,324.35 higher in average contribution margin** than the 113,210 group.
- **Critical caveat:** These are estimated financial metrics and observational group comparisons. Do not state that online ordering causes the financial difference.
- **SQL concepts:** grouped financial comparison and conditional grouping.
- **Interview explanation:** "I compared average estimated revenue and contribution margin between the two online-ordering groups, while treating the result as an association rather than a causal effect."

### Q15 — Revenue Contribution by Online Ordering
- **Question:** How much total estimated revenue and contribution margin does each online-ordering group contribute?

| Online order status | Restaurant count | Total estimated revenue | Total contribution margin | Revenue contribution | Contribution margin |
|---|---:|---:|---:|---:|---:|
| Online Order Available* | 111,310 | ₹5,359,759,821 | ₹4,117,075,690.36 | 61.81% | 60.58% |
| Online Order Not Available | 113,210 | ₹3,311,280,216 | ₹2,678,901,304.71 | 38.19% | 39.42% |

- **Data-quality note:** The supplied Q15 output again labels both rows `Online Order Not Available`. Based on Q11/Q13 and matching restaurant counts, **111,310 is recorded as Online Order Available*** and 113,210 as Online Order Not Available. Verify the original SQL output before final README publication.
- **Useful finding:** The 111,310-restaurant group contributes **61.81% of total estimated revenue** and **60.58% of total contribution margin**, despite representing only **49.58% of restaurants**.
- **Scale effect:** The group therefore contributes disproportionately more financial value than its restaurant share.
- **Interpretation caution:** These are estimated financial metrics and observational group comparisons; do not claim that online ordering itself causes the higher contribution.
- **SQL concepts:** `SUM`, grouped totals, percentage-of-total using window aggregation.
- **Interview explanation:** "Q14 compared average financial performance, while Q15 moved to total contribution and showed how the two groups compare in overall estimated revenue and margin."

### Q16 — City-Level Financial Performance
- **Question:** Which cities show the strongest estimated financial performance per restaurant, and which contribute the most total estimated revenue and contribution margin?
- **Method:** Cities with fewer than 500 restaurants were excluded to avoid unstable comparisons.

| City | Restaurant count | Avg estimated revenue | Avg contribution margin | Total estimated revenue | Total contribution margin |
|---|---:|---:|---:|---:|---:|
| Mumbai | 25,692 | ₹70,896 | ₹56,987.00 | ₹1,821,453,772 | ₹1,464,110,102.53 |
| Bengaluru | 20,283 | ₹63,964 | ₹51,367.28 | ₹1,297,373,878 | ₹1,041,882,619.75 |
| Kolkata | 9,571 | ₹56,602 | ₹44,085.30 | ₹541,737,349 | ₹421,940,374.91 |
| Hyderabad | 12,393 | ₹54,216 | ₹41,542.68 | ₹671,898,922 | ₹514,838,457.70 |
| Delhi NCR | 38,699 | ₹47,103 | ₹37,467.69 | ₹1,822,836,265 | ₹1,449,962,310.33 |
| Pune | 15,430 | ₹42,755 | ₹33,786.13 | ₹659,709,925 | ₹521,319,953.25 |
| Jaipur | 5,367 | ₹33,941 | ₹26,078.15 | ₹182,158,700 | ₹139,961,412.75 |
| Chennai | 11,917 | ₹33,699 | ₹26,246.09 | ₹401,592,690 | ₹312,774,691.75 |
| Chandigarh | 4,278 | ₹33,503 | ₹25,206.39 | ₹143,323,894 | ₹107,832,926.45 |
| Ahmedabad | 6,432 | ₹28,665 | ₹21,417.52 | ₹184,370,735 | ₹137,757,513.00 |

- **Useful finding:** **Market size and unit economics are not the same.** Delhi NCR has the largest restaurant footprint, while Mumbai shows stronger estimated financial performance per restaurant.
- **Additional finding:** Delhi NCR has the highest total estimated revenue in the supplied results (**₹1.823B**) only slightly above Mumbai (**₹1.821B**), while Mumbai has the highest total contribution margin (**₹1.464B**).
- **Caveat:** These are estimated financial metrics from the project model, not audited city-level financial statements.
- **SQL concepts:** grouped aggregation, `HAVING`, multiple financial metrics.
- **Interview explanation:** "I compared city-level unit economics with total scale so that a large restaurant count would not automatically be interpreted as better financial performance."

### Q17 — City Ranking by Restaurant Revenue
- **Question:** Which cities rank highest by average estimated revenue per restaurant?
- **SQL skill demonstrated:** Subquery + `GROUP BY` + `HAVING` + `RANK() OVER()` window function.
- **Method:** Cities with at least 500 restaurants were included.

| Rank | City | Restaurant count | Avg estimated revenue |
|---:|---|---:|---:|
| 1 | Mumbai | 25,692 | ₹70,896 |
| 2 | Bengaluru | 20,283 | ₹63,964 |
| 3 | Kolkata | 9,571 | ₹56,602 |
| 4 | Hyderabad | 12,393 | ₹54,216 |
| 5 | Delhi NCR | 38,699 | ₹47,103 |
| 6 | Pune | 15,430 | ₹42,755 |
| 7 | Jaipur | 5,367 | ₹33,941 |
| 8 | Chennai | 11,917 | ₹33,699 |
| 9 | Chandigarh | 4,278 | ₹33,503 |
| 10 | Ahmedabad | 6,432 | ₹28,665 |

- **Useful finding:** Mumbai ranks **#1** in estimated revenue per restaurant, while Delhi NCR ranks **#5** despite having the largest restaurant base.
- **Cross-query insight:** Q16 and Q17 tell a consistent story: **Mumbai leads on estimated unit economics, while Delhi NCR leads on restaurant scale.**
- **Portfolio role:** Q17 is primarily a **SQL skill demonstration** for `RANK()` and a validation of Q16 rather than a separate headline business finding.
- **Interview explanation:** "I first calculated average estimated revenue by city, filtered out very small cities, and then used `RANK()` to create a revenue ranking."

### Q18 — Table Reservation vs Restaurant Characteristics
- **Question:** Do restaurants offering table reservations differ from those without reservations in rating, customer engagement and estimated financial performance?
- **Data validation:** `zomato_unit_economics.TABLE_RESERVATION` is stored as text values `True`/`False`, not `1`/`0`. The table contains **6,621 True** and **217,899 False** records.
- **Important schema lesson:** `zomato_restaurants_clean` does not contain `restaurant_id`; its primary key is `zomato_url`. `zomato_unit_economics` contains `RESTAURANT_ID`. Therefore this Q18 analysis was correctly performed directly from `zomato_unit_economics` rather than using an assumed join.

| Table reservation status | Restaurant count | Avg rating | Avg rating count | Avg estimated revenue | Avg contribution margin |
|---|---:|---:|---:|---:|---:|
| Table Reservation Available | 6,621 | 4.03 | 778 | ₹558,052 | ₹468,293.01 |
| Table Reservation Not Available | 217,899 | 3.46 | 121 | ₹22,837 | ₹16,959.27 |

- **Additional calculation:** Reservation-enabled restaurants represent approximately **2.95%** of the 224,520-record financial dataset.
- **Useful finding:** Reservation-enabled restaurants have substantially higher observed metrics: **4.03 vs 3.46 average rating**, **778 vs 121 average rating count**, **₹558,052 vs ₹22,837 average estimated revenue**, and **₹468,293.01 vs ₹16,959.27 average contribution margin**.
- **Engagement comparison:** The reservation group has roughly **6.4×** the average rating count of the non-reservation group.
- **Financial comparison:** The reservation group has roughly **24.4×** the average estimated revenue and **27.6×** the average contribution margin.
- **Critical interpretation:** This is a **strong association, not proof that table reservations cause higher revenue or ratings**. Reservation-enabled restaurants may differ systematically in size, restaurant type, positioning, pricing, demand or customer segment.
- **Why this is useful:** The result suggests table reservation availability is a strong marker of a different restaurant profile and is worth investigating further, but it should not be presented as a causal business recommendation by itself.
- **SQL concepts:** `CASE`, `GROUP BY`, `COUNT`, `AVG`, conditional aggregation.
- **Interview explanation:** "I compared restaurants with and without table reservations using the operational and financial fields already available in the unit-economics table. The reservation group showed much higher observed ratings, engagement and estimated financial performance, but I would treat that as correlation because restaurant type and other factors could explain the difference."
- **Portfolio status:** **KEEP.** This is a strong intermediate-level business comparison and is more useful than adding unnecessary SQL complexity.

---

## Cross-Query Findings Worth Carrying Into the Final README

1. **Geographic concentration:** Delhi NCR, Mumbai and Bengaluru together represent about **37.7%** of restaurant records.
2. **Rating concentration:** **76.47%** of rated restaurants fall between 3.0 and 3.9.
3. **Rating engagement relationship:** 4.0+ restaurants average **570 ratings**, versus **29** in the 3.0–3.4 band.
4. **Cuisine dominance:** North Indian is the largest cuisine listing at about **9.2%** of restaurants; Q08 and Q10 reinforce the same pattern.
5. **Online ordering is nationally balanced but geographically uneven:** 49.58% overall availability, but city adoption ranges from **15.73% to 72.93%**.
6. **Online-order restaurants show a stronger observed customer profile:** 3.55 vs 3.39 average rating and 173 vs 115 average rating count, with slightly lower cost for two and higher table-reservation adoption.
7. **Financial contribution is uneven across online-order groups:** the 111,310 group accounts for **61.81% of estimated revenue** and **60.58% of estimated contribution margin**, pending verification of the duplicated Q14/Q15 labels.
8. **City economics vs scale:** Mumbai has the strongest estimated revenue per restaurant, while Delhi NCR has the largest restaurant footprint and slightly higher total estimated revenue.
9. **Table reservation is a strong profile differentiator:** only about **2.95%** of restaurants have reservations in the financial dataset, yet that group shows substantially higher observed rating, engagement and financial metrics. This is an association, not a causal claim.
10. **SQL skill progression:** Q17 introduces a practical `RANK()` window function without making the project unnecessarily advanced for a fresher-level analyst. Q18 returns to straightforward intermediate grouped comparison and emphasizes business interpretation.

---

## Project Learning & Interview Notes

### SQL level target
The project should remain **fresher-to-intermediate and interview-explainable**. We should demonstrate useful SQL skills without artificially making queries complex just to appear advanced.

**Skills demonstrated so far:**
- Basic aggregation and dataset profiling
- `WHERE`, `GROUP BY`, `ORDER BY`, `HAVING`
- `CASE` expressions
- Conditional aggregation
- Percentages and business metrics
- Top-N/ranking analysis
- `JOIN` awareness and schema validation
- Subqueries
- Window function: `RANK() OVER()`
- Business interpretation and correlation-vs-causation reasoning
- Data-quality checking before publishing conclusions

### Important schema lesson
Never assume a join key from a table name or from an earlier query. Before joining tables, inspect the schema and identify the actual common key. In this project, `zomato_restaurants_clean` uses `zomato_url` as its primary key, while `zomato_unit_economics` has `RESTAURANT_ID`. Q18 showed that a join was unnecessary because the required fields already existed in the unit-economics table.

### Interview principle
Every project query should be explainable in plain language:
1. What business question was being asked?
2. Which tables/columns were used?
3. What aggregation or SQL technique was applied?
4. What did the result show?
5. What limitation or caveat should a business user know?

### Claims we should avoid
- "Online ordering causes higher revenue."
- "Table reservations increase revenue."
- "Higher ratings cause more reviews."

Instead use:
- "Restaurants with online ordering **show higher observed** revenue/engagement."
- "Reservation-enabled restaurants **are associated with** substantially higher observed financial metrics."
- "The analysis shows a relationship, but it does not establish causation."

### Documentation practice
After each query:
1. Save the final SQL in the SQL query file/repository.
2. Record the result and important finding here.
3. Record the SQL concept learned.
4. Record an interview-friendly explanation.
5. Record data-quality issues and caveats.
6. Mark whether the result is README-worthy or mainly a skill demonstration.

This file is the **long-term project memory**. The final README should be concise; this document should remain more detailed so the reasoning and learning process are not lost.

---

## Python Results

### P01–P03 — Existing Python analysis
- **Status:** Results still need to be reconstructed from the completed Python work.
- **Rule:** Do not invent or backfill Python numbers from memory; record the actual outputs when reviewed.

---

## Recording Rules

1. Record actual outputs, not remembered values.
2. For large outputs, preserve important aggregates/rankings rather than copying every row.
3. Record the business question, useful finding, SQL concept, interview explanation and caveat for each query.
4. Avoid duplicate headline insights when two queries validate the same result.
5. Do not turn observational associations into causal claims.
6. Flag data-quality inconsistencies rather than silently correcting them.
7. Promote findings to the README only after the underlying result has been validated.
8. Keep SQL difficulty realistic for the user's current fresher/intermediate level.
9. Validate table schemas before writing joins.
10. Keep this detailed log as the project's long-term working memory; keep the final README focused on the strongest business insights and project outcomes.
11. Update this file after every completed SQL/Python analysis.
