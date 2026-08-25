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

**Key observations:** North Indian is the most common cuisine listing at 20,549 restaurants (9.15%). Multi-cuisine listings are common. The `0` listing should be treated as a data-quality/missing-value category.

**Interpretation caution:** Cuisine listings are not mutually exclusive categories.

**README-worthy:** Potentially useful.

### Q09 — Cuisine Performance
- **Status:** Completed and result recorded.
- **Question:** How do cuisine listings differ in restaurant scale, rating coverage, average rating and customer engagement?
- **Output size:** 60 cuisine listings supplied in the conversation.

**Selected results:**

| Cuisine listing | Restaurant count | Rated restaurants | Rating coverage | Avg rating | Avg rating count |
|---|---:|---:|---:|---:|---:|
| Desserts, Beverages | 791 | 619 | 78.26% | 3.74 | 127 |
| Burger, Fast Food | 1,081 | 930 | 86.03% | 3.71 | 331 |
| Beverages, Desserts | 573 | 426 | 74.35% | 3.65 | 92 |
| Ice Cream, Desserts | 1,603 | 1,182 | 73.74% | 3.62 | 119 |
| Cafe, Fast Food | 799 | 588 | 73.59% | 3.56 | 141 |
| Cafe | 2,135 | 1,510 | 70.73% | 3.54 | 116 |
| Pizza, Fast Food | 2,626 | 2,258 | 85.99% | 3.54 | 251 |
| North Indian, Mughlai | 2,054 | 1,455 | 70.84% | 3.49 | 201 |
| Pizza | 1,243 | 948 | 76.27% | 3.49 | 112 |
| Healthy Food | 506 | 275 | 54.35% | 3.47 | 53 |
| South Indian | 6,676 | 3,599 | 53.91% | 3.44 | 92 |
| Fast Food | 11,462 | 6,100 | 53.22% | 3.39 | 56 |
| North Indian | 20,549 | 10,817 | 52.64% | 3.38 | 90 |
| North Indian, Chinese | 11,230 | 7,352 | 65.47% | 3.37 | 106 |
| Chinese | 5,346 | 2,773 | 51.87% | 3.36 | 74 |
| Biryani | 2,791 | 1,471 | 52.71% | 3.33 | 69 |
| Chinese, North Indian | 2,675 | 1,683 | 62.92% | 3.33 | 79 |
| Bakery, Fast Food | 2,405 | 1,663 | 69.15% | 3.32 | 54 |
| Beverages, Cafe, Sandwich, Fast Food, Desserts | 603 | 564 | 93.53% | 3.25 | 48 |

**Key observations:**
- Among the supplied cuisine listings, **Desserts, Beverages** has the highest average rating at **3.74**, while **Burger, Fast Food** combines a high average rating (**3.71**) with very strong engagement (**331 average ratings**).
- **Pizza, Fast Food** also shows strong engagement at **251 average ratings** and 85.99% rating coverage.
- Large mainstream listings such as **North Indian (20,549 restaurants)** and **Fast Food (11,462)** have lower average ratings (3.38 and 3.39) and lower average rating counts (90 and 56) than several smaller/specialized listings.
- Rating coverage varies widely across cuisine listings, so average ratings should not be compared without considering coverage and restaurant count.
- The results suggest that cuisine mix may be associated with both customer engagement and rating performance, but the analysis does not establish causation.

**Interpretation caution:** Cuisine listings are not mutually exclusive, and some combinations have small sample sizes. High average ratings for small listings should therefore be treated cautiously.

**README-worthy:** Yes — potentially useful for identifying cuisine segments associated with stronger observed ratings and engagement.

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
- Q09: Several specialized cuisine listings show stronger observed ratings and engagement than large mainstream listings; Burger, Fast Food has 3.71 average rating and 331 average ratings, while North Indian has 3.38 average rating and 90 average ratings. Treat this as association and consider sample size/coverage.
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
