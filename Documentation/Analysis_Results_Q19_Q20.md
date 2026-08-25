# SQL Analysis Results — Q19 & Q20

This file records the validated findings for the latest SQL analyses. It is a compact addendum to the main Analysis Results Log; large raw result grids are intentionally not duplicated.

---

## Q19 — Restaurant Cost vs Estimated Financial Performance

### Business question
Do restaurants in higher cost-for-two bands show different estimated financial performance and average ratings?

### Result

| Cost band | Restaurant count | Avg estimated revenue | Avg contribution margin | Avg rating |
|---|---:|---:|---:|---:|
| Under 300 | 76,739 | ₹2,678 | ₹1,211 | 3.39 |
| 300 - 599 | 101,746 | ₹15,390 | ₹10,381 | 3.46 |
| 600 - 999 | 29,529 | ₹66,170 | ₹50,496 | 3.57 |
| 1000 - 1499 | 7,267 | ₹224,024 | ₹183,715 | 3.76 |
| 1500+ | 5,591 | ₹593,412 | ₹506,202 | 3.95 |

### Findings
- Higher cost bands show progressively higher average estimated revenue, contribution margin and rating.
- The 1500+ group has approximately **222×** the average estimated revenue and **418×** the average contribution margin of the Under 300 group.
- The result shows a strong positive association between cost-for-two band and the observed financial/rating metrics.

### Caveat
This is an observational comparison. It does not establish that higher pricing causes higher revenue or margin. Location, restaurant type, brand strength, demand and other factors may influence the relationship.

### SQL learning
`CASE` for business segmentation, `GROUP BY`, `COUNT`, `AVG`, conditional ranges and ordered aggregation.

### Interview explanation
> I segmented restaurants into cost bands and compared their average financial performance and ratings. Higher-cost groups showed substantially higher observed revenue and margin, but I treated this as an association rather than a causal relationship.

### Problem encountered and fix
The first Q19 query incorrectly referenced `cost_for_two_clean` while querying `zomato_unit_economics`. Schema verification showed that this table contains `COST_FOR_TWO`, so the query was corrected. Lesson: verify column availability when switching between the cleaned restaurant table and the unit-economics table.

---

## Q20 — Delivery-Only Restaurants vs Characteristics & Financial Performance

### Business question
Do delivery-only restaurants have a different customer and estimated financial profile from restaurants that are not delivery-only?

### Result

| Delivery status | Restaurant count | Avg rating | Avg rating count | Avg cost for two | Avg estimated revenue | Avg contribution margin |
|---|---:|---:|---:|---:|---:|---:|
| Not Delivery Only | 210,442 | 3.49 | 153 | ₹419 | ₹40,323 | ₹31,649.10 |
| Delivery Only | 14,078 | 3.50 | 95 | ₹404 | ₹13,166 | ₹9,637.51 |

### Findings
- Delivery-only restaurants have almost identical average ratings: **3.50 vs 3.49**.
- Delivery-only restaurants have lower observed rating activity: **95 vs 153** average ratings.
- Delivery-only restaurants have lower average estimated revenue: **₹13,166 vs ₹40,323**.
- Delivery-only restaurants have lower average contribution margin: **₹9,637.51 vs ₹31,649.10**.
- Average cost for two is slightly lower for delivery-only restaurants: **₹404 vs ₹419**.

### Interpretation
Delivery-only restaurants appear financially smaller in this dataset while maintaining nearly identical average ratings.

### Caveat
This is an observational comparison using estimated financial metrics. It does not prove that delivery-only status causes lower revenue or margin.

### Data-quality caveat
The query classifies normalized `true` as Delivery Only and everything else as Not Delivery Only. Unexpected values, blanks or NULLs would therefore fall into the latter group and should be checked before using this field in the final dashboard.

### SQL learning
`CASE`, `LOWER`, `TRIM`, `GROUP BY`, conditional `AVG` and grouped comparison.

### Interview explanation
> I compared delivery-only and non-delivery-only restaurants across rating, engagement, price and estimated financial performance. Ratings were nearly identical, while the delivery-only group showed lower observed financial metrics.

### Level
Intermediate / fresher interview-explainable.

---

## Documentation rule

Keep recording only relevant project information: validated results, useful findings, SQL/Python learning, data-quality problems, decisions, fixes, caveats and interview explanations. Do not copy large raw result grids when a concise record preserves the useful information.
