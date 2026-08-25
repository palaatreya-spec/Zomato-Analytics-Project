# Q19 — Restaurant Cost vs Estimated Financial Performance

## Business question

Do restaurants in higher cost-for-two bands show different estimated revenue, contribution margin and average rating?

## Result

| Cost band | Restaurant count | Avg estimated revenue | Avg contribution margin | Avg rating |
|---|---:|---:|---:|---:|
| Under 300 | 76,739 | ₹2,678 | ₹1,211 | 3.39 |
| 300 - 599 | 101,746 | ₹15,390 | ₹10,381 | 3.46 |
| 600 - 999 | 29,529 | ₹66,170 | ₹50,496 | 3.57 |
| 1000 - 1499 | 7,267 | ₹224,024 | ₹183,715 | 3.76 |
| 1500+ | 5,591 | ₹593,412 | ₹506,202 | 3.95 |

The analysis used 220,872 restaurants with positive/non-null cost values, approximately 98.38% of the 224,520-row financial dataset.

## Key finding

The supplied results show a strong monotonic association: higher cost bands have higher average estimated revenue, contribution margin and rating.

Compared with the `Under 300` group, the `1500+` group has approximately:

- **222× higher average estimated revenue**
- **418× higher average contribution margin**
- **0.56 points higher average rating**

## Interpretation

Higher-cost restaurants have a substantially different observed financial and rating profile in this model. However, this does **not** prove that higher pricing causes higher revenue or contribution margin. Restaurant type, positioning, city mix, demand, scale and other factors may contribute to the relationship.

## SQL concepts

- `CASE` for business-friendly cost bands
- `GROUP BY` for segment comparison
- `COUNT(*)` for segment size
- `AVG()` for financial and rating comparisons
- `ORDER BY MIN(COST_FOR_TWO)` to display bands in logical price order

## Problem encountered

The first version of Q19 failed because it referenced `cost_for_two_clean` while querying `zomato_unit_economics`.

`cost_for_two_clean` exists in `zomato_restaurants_clean`, but the unit-economics table uses `COST_FOR_TWO`.

### Resolution

The table schema was checked and the query was corrected to use `COST_FOR_TWO`.

### Learning

Always verify the schema of the table being queried before assuming a column from another table is available.

## Interview explanation

> "I segmented restaurants by cost-for-two and compared average estimated revenue, contribution margin and rating across the segments. The higher-cost groups showed higher observed financial metrics, but I would describe this as an association rather than a causal relationship because restaurant type, location and other factors can influence the result."

## Portfolio status

**Keep.** This is an intermediate, interview-explainable business analysis rather than an unnecessarily complex SQL exercise.

## Important caveat

`ESTIMATED_REVENUE` and `CONTRIBUTION_MARGIN` come from the project's unit-economics model. They are estimated analytical metrics, not verified transaction-level Zomato revenue or profit.
