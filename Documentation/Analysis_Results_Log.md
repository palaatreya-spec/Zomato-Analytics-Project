# Zomato Analysis Results Log

> Working record of SQL and Python analysis results for the Zomato Analytics portfolio project.
>
> **Purpose:** Preserve the actual outputs and business interpretations used later for the README, documentation and interview preparation. Large query outputs are summarized rather than copied in full.

---

## SQL Results

### Q01 — Overall Dataset Coverage
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

### Q02 — Restaurant Supply by City
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

### Q03 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q04 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

### Q05 — Pending result record
- **Status:** Result to be reconstructed from the completed SQL work.

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
- Q14: Online-ordering groups show materially different average estimated financial metrics in the current analysis. Treat as an association, not causation.

---

## Recording Rules

1. Record actual outputs, not estimates or remembered values.
2. For small outputs, preserve the complete result.
3. For large outputs, preserve the important aggregates, rankings or representative rows needed to support the conclusion.
4. Record the business question and the key insight for every completed analysis.
5. Record caveats when a result could be misinterpreted.
6. Do not add README claims until the underlying result has been validated.
7. Update this file after each completed SQL/Python analysis.
