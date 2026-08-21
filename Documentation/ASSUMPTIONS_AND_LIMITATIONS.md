# Zomato Analytics — Assumptions & Limitations

## Analytical assumptions

1. Revenue metrics are derived from the available order data and should be treated as project-level analytical metrics rather than Zomato's internal financial reporting.
2. Restaurant `rating` and review-level ratings are separate fields; the project uses review-level averages where explicitly stated.
3. A relationship between rating, ordering activity, pricing, reservations, or operating model is observational and does not by itself establish causation.
4. `cost_for_two` is treated as a pricing proxy and should not be interpreted as realized customer spend.
5. Restaurant-level comparisons should account for differences in location, cuisine mix, and available observations.
6. Missing or invalid values are handled through the documented data-quality and cleaning steps.

## Data limitations

- The repository contains a compressed restaurant dataset, while the SQL workflow also models customers, orders, order items, and reviews. Those transactional tables require their corresponding source files before the full relational workflow can be reproduced.
- The Power BI dashboard should be interpreted using the actual model and measures contained in the `.pbix` file.
- Estimated or derived profitability metrics should be clearly labelled as assumptions wherever they are presented.

## Interpretation guidance

The goal of the project is to demonstrate an end-to-end analytics workflow: data validation, SQL transformation, business analysis, and BI reporting. Findings are intended to demonstrate analytical reasoning rather than represent official Zomato business performance.
