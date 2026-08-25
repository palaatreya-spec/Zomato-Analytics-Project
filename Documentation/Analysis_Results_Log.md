# Zomato Analysis Results Log

> Working record of SQL and Python analysis results for the Zomato Analytics portfolio project. Large outputs are summarized; useful findings and validation notes are retained.

---

## SQL Results

### Q01 — Total restaurants, total cities, total areas, total cuisines
- **Result:** 224,520 restaurants; 83 cities; 2,500 areas; 19,675 cuisine values.
- **Useful finding:** The dataset has broad geographic and cuisine coverage and is large enough for city-, cuisine-, rating- and ordering-level comparisons.

### Q02 — Restaurant distribution by city
- **Top cities:** Delhi NCR 38,699 (17.24%); Mumbai 25,692 (11.44%); Bengaluru 20,283 (9.03%); Pune 15,430 (6.87%); Hyderabad 12,393 (5.52%); Chennai 11,917 (5.31%); Kolkata 9,571 (4.26%).
- **Useful finding:** Delhi NCR, Mumbai and Bengaluru together account for approximately **37.7%** of all restaurant records, showing strong geographic concentration.
- **Caveat:** City percentages describe restaurant supply, not market revenue or demand.

### Q03 — City-level restaurant performance
- **Selected:** Bengaluru: 20,283 restaurants, 67.00% rating coverage, 3.61 avg rating, 139 avg rating count; Delhi NCR: 38,699, 63.38%, 3.52, 105; Mumbai: 25,692, 70.58%, 3.51, 141; Hyderabad: 12,393, 70.82%, 3.46, 153; Kolkata: 9,571, 70.47%, 3.46, 145; Pune: 15,430, 63.42%, 3.45, 98.
- **Useful finding:** Bengaluru has the highest average rating among the major cities shown (**3.61**), while Hyderabad has both high rating coverage (**70.82%**) and relatively high rating engagement (**153**).
- **Important caveat:** Several smaller cities have extreme results because of very small rated samples. Rating coverage must be considered alongside average rating.

### Q04 — Rating Distribution
- **Result:** Individual rating buckets are concentrated around **3.2–3.9**; 3.30 is the largest bucket at **12,991 restaurants / 8.98%** of rated restaurants.
- **Useful finding:** The dataset is not dominated by either very low or very high ratings; the central rating range is the norm.

### Q05 — Rating Band Distribution

| Rating band | Restaurant count | % of rated restaurants |
|---|---:|---:|
| Below 2.5 | 629 | 0.43% |
| 2.5 - 2.9 | 13,134 | 9.07% |
| 3.0 - 3.4 | 55,638 | 38.44% |
| 3.5 - 3.9 | 55,036 | 38.03% |
| 4.0+ | 20,298 | 14.02% |

- **Useful finding:** **76.47%** of rated restaurants are between **3.0 and 3.9**, while only **0.43%** are below 2.5 and **14.02%** are 4.0+.

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

### Q07 — Most Reviewed Restaurants
- **Top result:** Bawarchi, Hyderabad — **42,621 ratings**, 4.50 rating, ₹750 cost for two.
- Other highly reviewed examples include Byg Brewski Brewing Company (Bengaluru, 19,305), Toit (Bengaluru, 15,731), Truffles (Bengaluru, 15,653), Hauz Khas Social (Delhi NCR, 14,936).
- **Useful finding:** High-engagement restaurants are concentrated notably in Bengaluru and Hyderabad, with Bawarchi a clear outlier in review volume.
- **Caveat:** Restaurant names repeat across cities, so analysis should use restaurant + city/area where appropriate.

### Q08 — Most Common Cuisine Listings
- **Top listings:** North Indian 20,549 (9.15%); Fast Food 11,462 (5.11%); North Indian, Chinese 11,230 (5.00%); South Indian 6,676 (2.97%); Bakery 5,703 (2.54%); Chinese 5,346 (2.38%); Street Food 4,134 (1.84%).
- **Useful finding:** North Indian is the most common cuisine listing. Cuisine values are combinations/listings rather than mutually exclusive single cuisines.
- **Data-quality note:** `0` appears as a cuisine listing for 1,330 restaurants (0.59%) and should be treated as a missing/invalid category rather than a real cuisine.

### Q09 — Cuisine Performance
- **Highest selected averages:** Desserts, Beverages 3.74; Burger, Fast Food 3.71 with 331 average ratings; Beverages, Desserts 3.65; Ice Cream, Desserts 3.62; Cafe, Fast Food 3.56; Pizza, Fast Food 3.54 with 251 average ratings.
- **Large mainstream examples:** North Indian 3.38 rating / 90 avg ratings; Fast Food 3.39 / 56; Chinese 3.36 / 74; Biryani 3.33 / 69.
- **Useful finding:** Some specialized/combo cuisine listings show stronger observed ratings and customer engagement than high-volume mainstream listings.
- **Caveat:** Cuisine listings differ in size and rating coverage, so ranking cuisines by average rating alone can be misleading.

### Q10 — Most Popular Cuisine Listings
- **Top:** North Indian 20,549 (9.21%); Fast Food 11,462 (5.14%); North Indian, Chinese 11,230 (5.03%); South Indian 6,676 (2.99%); Bakery 5,703 (2.56%); Chinese 5,346 (2.40%).
- **Useful finding:** Q10 independently reinforces Q08: North Indian is the largest cuisine listing by restaurant presence.
- **Documentation note:** Keep this as supporting/validation analysis rather than presenting Q08 and Q10 as two separate major insights.

### Q11 — Online Ordering Analysis

| Online order status | Restaurant count | % of restaurants |
|---|---:|---:|
| Online Order Not Available | 113,210 | 50.42% |
| Online Order Available | 111,310 | 49.58% |

- **Useful finding:** Overall online-order availability is almost perfectly balanced: only **0.84 percentage points** separate the groups.
- **Business implication:** A national-level percentage alone hides meaningful city-level differences, which Q12 investigates.

### Q12 — Online Ordering by City
- **Highest adoption:** Jhansi 72.93%; Patiala 72.72%; Jabalpur 66.58%; Gwalior 66.42%; Kota 62.46%; Nagpur 62.02%; Chandigarh 60.71%; Bhopal 60.49%; Agra 60.42%; Surat 59.03%.
- **Major-city adoption:** Hyderabad 52.34%; Kolkata 51.54%; Ahmedabad 50.82%; Delhi NCR 50.78%; Chennai 50.06%; Mumbai 47.64%; Bengaluru 47.17%; Pune 47.01%.
- **Lowest:** Goa 15.73%; Siliguri 34.78%; Puducherry 36.56%; Trivandrum 38.49%; Kochi 41.75%.
- **Useful finding:** City-level adoption ranges from **72.93% to 15.73%**, showing that the near-50/50 national split conceals substantial geographic variation.
- **Caveat:** Small cities can show extreme percentages because their restaurant counts are smaller; interpret adoption rate with restaurant count.

### Q13 — Online Ordering vs Restaurant Characteristics

| Online order status | Restaurant count | Avg rating | Avg rating count | Avg cost for two | Table reservation % |
|---|---:|---:|---:|---:|---:|
| Online Order Available | 111,310 | 3.55 | 173 | ₹421 | 3.48% |
| Online Order Not Available | 113,210 | 3.39 | 115 | ₹430 | 2.43% |

- **Useful finding:** Restaurants with online ordering have **0.16 higher average rating**, **58 more average ratings**, **₹9 lower average cost for two**, and **1.05 percentage points higher table-reservation adoption**.
- **Relative engagement:** 173 vs 115 means the online-order group has roughly **50% more average rating activity**.
- **Interpretation:** Strong evidence of a relationship between online-order availability and a more engaged/higher-rated restaurant profile, but not proof of causation.

### Q14 — Online Ordering vs Financial Performance
- **Supplied output:** first row labeled `Online Order Not Available` with 111,310 restaurants, ₹48,152 avg estimated revenue, ₹36,987.47 avg contribution margin; second row labeled `Online Order Not Available` with 113,210 restaurants, ₹29,249 revenue, ₹23,663.12 margin.
- **Data-quality correction:** Q11/Q13 establish that **111,310 = Online Order Available** and **113,210 = Online Order Not Available**. Therefore the first Q14 label appears duplicated/incorrect and is recorded as `Online Order Available*` pending verification of the original SQL output.
- **Useful finding if the grouping is confirmed:** The 111,310 group is approximately **₹18,903 higher in average estimated revenue** and **₹13,324.35 higher in average contribution margin** than the 113,210 group.
- **Critical caveat:** These are estimated financial metrics and observational group comparisons. Do not state that online ordering causes the financial difference.

---

## Cross-Query Findings Worth Carrying Into the Final README

1. **Geographic concentration:** Delhi NCR, Mumbai and Bengaluru together represent about **37.7%** of the restaurant records.
2. **Rating concentration:** **76.47%** of rated restaurants fall between 3.0 and 3.9.
3. **Rating engagement relationship:** 4.0+ restaurants average **570 ratings**, versus **29** in the 3.0–3.4 band.
4. **Cuisine dominance:** North Indian is the largest cuisine listing at about **9.2%** of restaurants; Q08 and Q10 reinforce the same pattern.
5. **Online ordering is nationally balanced but geographically uneven:** 49.58% overall availability, but city adoption ranges from **15.73% to 72.93%**.
6. **Online-order restaurants show a stronger customer profile:** 3.55 vs 3.39 average rating and 173 vs 115 average rating count, with slightly lower cost for two and higher table-reservation adoption.
7. **Financial result requires label verification:** Q14 suggests a large financial difference between the two online-order groups, but the pasted output contains a duplicated group label and therefore should not become a headline README claim until verified.

---

## Python Results

### P01–P03 — Existing Python analysis
- **Status:** Results still need to be reconstructed from the completed Python work.
- **Rule:** Do not invent or backfill Python numbers from memory; record the actual outputs when reviewed.

---

## Recording Rules

1. Record actual outputs, not remembered values.
2. For large outputs, preserve the important aggregates/rankings rather than copying every row.
3. Record the business question, useful finding and caveat for each query.
4. Avoid duplicate headline insights when two queries validate the same result.
5. Do not turn observational associations into causal claims.
6. Flag data-quality inconsistencies rather than silently correcting them.
7. Promote findings to the README only after the underlying result has been validated.
8. Update this file after every completed SQL/Python analysis.
