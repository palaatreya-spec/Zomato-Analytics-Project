# Zomato Analysis Results Log

> Working record of SQL and Python analysis results for the Zomato Analytics portfolio project.
>
> **Purpose:** Preserve the actual outputs and business interpretations used later for the README, documentation and interview preparation. Large query outputs are summarized rather than copied in full.

---

## SQL Results

### Q01 — Total restaurants, total cities, total areas, total cuisines
- **Status:** Completed and result recorded.
- **Question:** What is the overall scale and coverage of the restaurant dataset?

| Metric | Result |
|---|---:|
| Total restaurants | 224,520 |
| Total cities | 83 |
| Total areas | 2,500 |
| Total cuisines | 19,675 |

**Key observation:** The dataset contains 224,520 restaurant records across 83 cities, 2,500 areas and 19,675 cuisine values.

**README-worthy:** Potentially, as a dataset overview statistic.

### Q02 — Restaurant distribution by city
- **Status:** Completed and result recorded.
- **Question:** How is the restaurant supply distributed across cities?
- **Output size:** 83 cities; full output is not duplicated here because the complete SQL result was supplied in the conversation.

**Top cities by restaurant count:**

| City | Restaurant count | % of total |
|---|---:|---:|
| Delhi NCR | 38,699 | 17.24% |
| Mumbai | 25,692 | 11.44% |
| Bengaluru | 20,283 | 9.03% |
| Pune | 15,430 | 6.87% |
| Hyderabad | 12,393 | 5.52% |
| Chennai | 11,917 | 5.31% |
| Kolkata | 9,571 | 4.26% |
| Ahmedabad | 6,432 | 2.86% |
| Jaipur | 5,367 | 2.39% |
| Chandigarh | 4,278 | 1.91% |

**Key observation:** Delhi NCR has the largest restaurant presence in the dataset, followed by Mumbai and Bengaluru. The top three cities together account for approximately **37.7%** of the dataset's restaurant records.

**README-worthy:** Yes — useful for establishing geographic concentration of restaurant supply.

### Q03 — City-level restaurant performance
- **Status:** Completed and result recorded.
- **Question:** How does restaurant presence, rating coverage and rating engagement vary across cities?
- **Output size:** 83 cities; only decision-relevant observations are summarized here.

**Selected results:**

| City | Restaurant count | Rated restaurants | Rating coverage | Avg rating | Avg rating count |
|---|---:|---:|---:|---:|---:|
| Bengaluru | 20,283 | 13,590 | 67.00% | 3.61 | 139 |
| Delhi NCR | 38,699 | 24,528 | 63.38% | 3.52 | 105 |
| Mumbai | 25,692 | 18,133 | 70.58% | 3.51 | 141 |
| Hyderabad | 12,393 | 8,777 | 70.82% | 3.46 | 153 |
| Kolkata | 9,571 | 6,745 | 70.47% | 3.46 | 145 |
| Pune | 15,430 | 9,785 | 63.42% | 3.45 | 98 |
| Jaipur | 5,367 | 3,605 | 67.17% | 3.45 | 94 |
| Ludhiana | 2,304 | 1,721 | 74.70% | 3.45 | 87 |
| Palakkad | 139 | 0 | 0.00% | — | 0 |
| Alappuzha | 226 | 0 | 0.00% | — | 0 |

**Key observations:** Bengaluru has the highest average rating among the major cities shown (3.61). Mumbai and Hyderabad have high rating coverage, while some smaller locations have little or no rating data. City comparisons should consider rating coverage and sample size.

**README-worthy:** Yes.

### Q04 — Rating Distribution
- **Status:** Completed and result recorded.
- **Question:** How are restaurant ratings distributed across rated restaurants?
- **Output size:** 32 rating values from 1.80 to 4.90.

**Key observation:** Ratings are concentrated around the **3.2–3.9 range**, with the largest individual rating bucket at **3.30 (8.98%)**. Very high ratings are comparatively uncommon.

**README-worthy:** Yes, potentially.

### Q05 — Rating Band Distribution
- **Status:** Completed and result recorded.
- **Question:** How are rated restaurants distributed across broader rating bands?

| Rating band | Restaurant count | % of rated restaurants |
|---|---:|---:|
| Below 2.5 | 629 | 0.43% |
| 2.5 - 2.9 | 13,134 | 9.07% |
| 3.0 - 3.4 | 55,638 | 38.44% |
| 3.5 - 3.9 | 55,036 | 38.03% |
| 4.0+ | 20,298 | 14.02% |

**Key observations:** **76.47%** of rated restaurants fall between **3.0 and 3.9**; only 0.43% fall below 2.5; 14.02% are rated 4.0+.

**README-worthy:** Yes.

### Q06 — Rating vs Customer Engagement
- **Status:** Completed and result recorded.
- **Question:** Does customer engagement differ across restaurant rating bands?

| Rating band | Restaurant count | Restaurants with reviews | Avg rating count | Avg positive rating count |
|---|---:|---:|---:|---:|
| Below 2.5 | 629 | 627 | 108 | 108 |
| 2.5 - 2.9 | 13,134 | 12,908 | 45 | 45 |
| 3.0 - 3.4 | 55,638 | 54,852 | 29 | 29 |
| 3.5 - 3.9 | 55,036 | 54,026 | 138 | 141 |
| 4.0+ | 20,298 | 19,984 | 570 | 579 |

**Key observations:** The **4.0+ band has the strongest customer engagement**, averaging 570 ratings per restaurant, while the 3.0–3.4 band averages only 29. The relationship is not perfectly linear because the below-2.5 group also has relatively high engagement.

**Interpretation caution:** Association only; this does not establish that higher ratings cause more reviews.

**README-worthy:** Yes, potentially.

### Q07 — Most Reviewed Restaurants
- **Status:** Completed and result recorded.
- **Question:** Which restaurants have the highest number of recorded ratings/reviews, and what characteristics do they have?
- **Output size:** Top 20 restaurants.

**Selected top results:**

| Restaurant | City | Rating | Rating count | Cost for two | Online order | Table reservation |
|---|---|---:|---:|---:|---:|---:|
| Bawarchi | Hyderabad | 4.50 | 42,621 | ₹750 | Yes | No |
| Byg Brewski Brewing Company | Bengaluru | 4.90 | 19,305 | ₹1,600 | Yes | Yes |
| Toit | Bengaluru | 4.60 | 15,731 | ₹1,000 | No | No |
| Truffles | Bengaluru | 4.60 | 15,653 | ₹900 | No | No |
| Hauz Khas Social | Delhi NCR | 4.70 | 14,936 | — | No | Yes |
| AB's - Absolute Barbecues | Bengaluru | 4.80 | 13,164 | ₹1,600 | No | Yes |
| Paradise | Hyderabad | 4.70 | 13,152 | ₹800 | Yes | No |
| The Black Pearl | Bengaluru | 4.90 | 12,686 | ₹1,500 | No | Yes |
| Shah Ghouse Hotel & Restaurant | Hyderabad | 4.20 | 12,514 | ₹800 | Yes | No |
| Peter Cat | Kolkata | 4.20 | 11,917 | ₹1,200 | Yes | No |

**Key observations:** Bawarchi in Hyderabad leads with **42,621 ratings**. Bengaluru and Hyderabad are prominent among highly reviewed restaurants. Online ordering and table reservations are mixed.

**Interpretation caution:** Rating count represents observed engagement, not revenue or profitability.

**README-worthy:** Potentially.

### Q08 — Most Common Cuisine Listings
- **Status:** Completed and result recorded.
- **Question:** Which cuisine categories/listings are most frequently represented across restaurants?
- **Output size:** Top 25 cuisine listings supplied in the conversation.

| Cuisine listing | Restaurant count | % of restaurants |
|---|---:|---:|
| North Indian | 20,549 | 9.15% |
| Fast Food | 11,462 | 5.11% |
| North Indian, Chinese | 11,230 | 5.00% |
| South Indian | 6,676 | 2.97% |
| Bakery | 5,703 | 2.54% |
| Chinese | 5,346 | 2.38% |
| Street Food | 4,134 | 1.84% |
| Bakery, Desserts | 3,297 | 1.47% |
| Biryani | 2,791 | 1.24% |
| Chinese, North Indian | 2,675 | 1.19% |
| Pizza, Fast Food | 2,626 | 1.17% |
| Bakery, Fast Food | 2,405 | 1.07% |
| Desserts | 2,323 | 1.03% |
| North Indian, Fast Food | 2,289 | 1.02% |
| Mithai | 2,176 | 0.97% |
| Cafe | 2,135 | 0.95% |
| North Indian, Mughlai | 2,054 | 0.91% |
| Beverages | 1,985 | 0.88% |
| Fast Food, Beverages | 1,827 | 0.81% |
| Ice Cream, Desserts | 1,603 | 0.71% |
| Mithai, Street Food | 1,547 | 0.69% |
| Ice Cream | 1,512 | 0.67% |
| Chinese, Fast Food | 1,461 | 0.65% |
| North Indian, Chinese, Fast Food | 1,412 | 0.63% |
| 0 | 1,330 | 0.59% |

**Key observations:**
- **North Indian is the most common cuisine listing**, appearing for 20,549 restaurants (9.15%).
- Fast Food and North Indian–Chinese combinations are also highly prevalent.
- Multi-cuisine listings are common, so listings are not mutually exclusive categories.
- The `0` listing should be treated as a **data-quality/missing-value category**, not as a genuine cuisine.

**Interpretation caution:** These are cuisine listings, not mutually exclusive cuisine categories.

**README-worthy:** Potentially useful for understanding cuisine-market composition and motivating cuisine normalization.

### Q09 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q10 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q11 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q12 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q13 — Online Ordering vs Restaurant Characteristics
- **Status:** Query completed; exact output to be recorded/reconstructed.
- **SQL source:** `13. Online Ordering vs Restaurant Characteristics`
- **Question:** How do restaurants with and without online ordering differ in rating, rating engagement, pricing and table-reservation adoption?

### Q14 — Online Ordering vs Financial Performance
- **Status:** Completed and result recorded.
- **Question:** Do restaurants with and without online ordering show different estimated financial performance?

| Online order status | Restaurant count | Avg estimated revenue | Avg contribution margin |
|---|---:|---:|---:|
| Online Order Not Available | 111,310 | ₹48,152 | ₹36,987.97 |
| Online Order Available | 113,210 | ₹29,249 | ₹23,663.12 |

**Key observation:** Restaurants without online ordering show higher average estimated revenue and contribution margin in this dataset.

**Interpretation caution:** This is an observed association, not evidence that online ordering causes lower revenue or margin.

**README-worthy:** Yes, potentially.

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
- **Status:** Results to be reconstructed from the completed Python analysis.

### P02 — Pending result record
- **Status:** Results to be reconstructed from the completed Python analysis.

### P03 — Pending result record
- **Status:** Results to be reconstructed from the completed Python analysis.

> Additional Python result entries will be added as the existing analysis is reviewed.

---

## README Candidate Findings

Only validated findings with actual recorded outputs should be promoted here.

- Q01: Dataset contains 224,520 restaurants across 83 cities, 2,500 areas and 19,675 cuisine values.
- Q02: Restaurant supply is geographically concentrated; Delhi NCR, Mumbai and Bengaluru account for approximately 37.7% of restaurant records.
- Q03: City-level rating coverage varies substantially; major cities such as Mumbai and Hyderabad have around 71% coverage, while some smaller cities have little or no rating data. Average ratings should therefore be interpreted alongside coverage and sample size.
- Q04: Ratings are concentrated around the 3.2–3.9 range, with 3.30 as the largest individual rating bucket at 8.98% of rated restaurants.
- Q05: 76.47% of rated restaurants fall in the 3.0–3.9 rating bands, while only 0.43% fall below 2.5 and 14.02% are rated 4.0+.
- Q06: The 4.0+ rating band has substantially higher observed rating activity (570 average ratings per restaurant) than the 3.0–3.4 band (29), indicating a strong association between high ratings and customer engagement in this dataset.
- Q07: Bawarchi in Hyderabad leads the top-20 most-reviewed list with 42,621 ratings; Bengaluru and Hyderabad are prominent among the highest-engagement restaurants, while online ordering and table reservation adoption are mixed.
- Q08: North Indian is the most common cuisine listing at 20,549 restaurants (9.15%); cuisine combinations are common, and the `0` listing should be treated as a data-quality/missing-value category.
- Q14: Online-ordering groups show materially different average estimated financial metrics in the current analysis. Treat as an association, not causation.

---

## Recording Rules

1. Record actual outputs, not estimates or remembered values.
2. Use the exact query name from the SQL project when available.
3. For small outputs, preserve the complete result.
4. For large outputs, preserve the important aggregates, rankings or representative rows needed to support the conclusion.
5. Record the business question and the key insight for every completed analysis.
6. Record caveats when a result could be misinterpreted.
7. Do not add README claims until the underlying result has been validated.
8. Update this file after each completed SQL/Python analysis.
