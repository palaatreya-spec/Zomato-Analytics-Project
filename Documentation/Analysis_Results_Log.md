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
- **Output size:** 83 cities; the complete output was supplied in the conversation, so only decision-relevant observations are summarized here.

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

**Key observations:**
- Among the major cities shown, **Bengaluru has the highest average rating (3.61)**.
- **Mumbai and Hyderabad have high rating coverage**, at 70.58% and 70.82% respectively.
- **Mumbai, Hyderabad and Kolkata show relatively high average rating counts**, indicating stronger rating engagement among rated restaurants.
- Rating coverage varies substantially across cities. Some smaller locations have very limited rating availability; Palakkad and Alappuzha have no rated restaurants in this output.
- Small cities with very few rated restaurants can show unstable average ratings, so city-level comparisons should consider rating coverage and sample size.

**README-worthy:** Yes, potentially — especially for demonstrating that city performance should be evaluated using both rating quality and rating coverage rather than average rating alone.

### Q04 — Rating Distribution
- **Status:** Completed and result recorded.
- **Question:** How are restaurant ratings distributed across rated restaurants?
- **Output size:** 32 rating values from 1.80 to 4.90; full output was supplied in the conversation.

**Key distribution points:**

| Rating | Restaurant count | % of rated restaurants |
|---:|---:|---:|
| 2.80 | 3,677 | 2.54% |
| 2.90 | 5,604 | 3.87% |
| 3.00 | 7,876 | 5.44% |
| 3.10 | 9,650 | 6.67% |
| 3.20 | 12,220 | 8.44% |
| 3.30 | 12,991 | 8.98% |
| 3.40 | 12,901 | 8.91% |
| 3.50 | 12,578 | 8.69% |
| 3.60 | 12,206 | 8.43% |
| 3.70 | 11,411 | 7.88% |
| 3.80 | 10,194 | 7.04% |
| 3.90 | 8,647 | 5.97% |
| 4.00 | 6,764 | 4.67% |
| 4.10 | 4,825 | 3.33% |
| 4.20 | 3,290 | 2.27% |
| 4.30 | 2,246 | 1.55% |
| 4.40 | 1,370 | 0.95% |
| 4.50 | 806 | 0.56% |
| 4.60 | 474 | 0.33% |
| 4.70 | 253 | 0.17% |
| 4.80 | 138 | 0.10% |
| 4.90 | 132 | 0.09% |

**Key observation:** Ratings are concentrated around the **3.2–3.9 range**, with the largest individual rating bucket at **3.30 (8.98%)**, followed closely by 3.40 (8.91%) and 3.50 (8.69%). Very high ratings are comparatively uncommon: ratings of 4.50 and above each represent less than 1% individually.

**Interpretation caution:** This describes the distribution of recorded ratings; it does not imply that the underlying restaurants are objectively of a particular quality level. Rating availability and platform/user behavior can influence the observed distribution.

**README-worthy:** Yes, potentially — useful for showing the overall rating landscape and supporting later segmentation.

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

**Key observations:**
- **76.47%** of rated restaurants fall between **3.0 and 3.9**.
- Only **0.43%** fall below 2.5.
- **14.02%** of rated restaurants have a rating of 4.0 or above.
- The distribution is therefore strongly centered in the mid-rating bands rather than at the extremes.

**README-worthy:** Yes — stronger than the raw rating distribution for communicating the overall rating profile.

### Q06 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q07 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q08 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

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

**Interpretation caution:** This is an observed association, not evidence that online ordering causes lower revenue or margin. Restaurant type, city, pricing and other characteristics may differ between the groups.

**README-worthy:** Yes, potentially — if consistent with the final validated analysis.

---

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
