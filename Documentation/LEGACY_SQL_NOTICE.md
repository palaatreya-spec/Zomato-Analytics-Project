# Legacy SQL Notice

The original SQL scripts in `SQL/01–09` were created for the earlier learning version of this project. That version assumed a relational dataset containing customers, orders, order items and reviews.

The verified uploaded source is a restaurant-level dataset and does not provide those transaction entities.

## Portfolio rule

The final portfolio narrative should use only the source-backed workflow:

`Python profiling → Python cleaning/EDA → SQL 14–17 → Power BI`

Legacy scripts may be retained as historical learning material, but they must not be used to support claims about actual Zomato orders, revenue, profit, customer retention or customer lifetime value.

## Recommended future cleanup

Move the original scripts to `SQL/legacy/` when repository restructuring is performed, preserving their history while keeping the recruiter-facing path clean.
