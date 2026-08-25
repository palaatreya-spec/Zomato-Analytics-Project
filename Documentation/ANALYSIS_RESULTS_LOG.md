# Exploratory SQL Analysis — Results Log (Q1–Q18)

This is a concise record of the useful findings from the exploratory SQL work. Full SQL is stored in `SQL/05_Exploratory_Analysis.sql`.

## Q1 — Overall dataset overview

Established the basic analytical scope: restaurant count, city count, area count and cuisine count.

**Purpose:** confirm the size and dimensionality of the cleaned restaurant dataset before deeper analysis.

## Q2 — Restaurant distribution by city

Restaurant supply is highly concentrated in a limited number of major markets. Delhi NCR, Mumbai, Bengaluru, Pune, Hyderabad and Chennai form the largest city-level restaurant bases in the supplied results.

**Learning:** volume and market presence should be separated from performance metrics.

## Q3 — City-level restaurant performance

Major cities generally have substantially higher rating coverage than many smaller/tourist markets. Rating coverage varies materially by city, so average rating should be interpreted alongside the number of rated restaurants.

**Useful example:** Bengaluru and Mumbai have large restaurant bases with roughly 67–71% rating coverage in the supplied output, while some smaller markets have much lower coverage.

## Q4 — Rating distribution

Ratings are concentrated around the 3.2–3.9 range. The supplied distribution peaks around 3.3–3.4, while very low and very high ratings represent much smaller shares.

## Q5 — Rating band distribution

The supplied results show the largest groups in the `3.0–3.4` and `3.5–3.9` bands. `4.0+` represents a meaningful but smaller share, while restaurants below 2.5 are rare.

## Q6 — Rating vs customer engagement

Higher-rated restaurants, especially the `4.0+` group, have substantially higher average rating counts in the supplied results than mid-rated groups.

**Interpretation:** rating and review engagement appear associated in this dataset, but this is an observational relationship, not proof that higher ratings cause more reviews.

## Q7 — Most reviewed restaurants

The top reviewed restaurants are concentrated in major cities such as Hyderabad, Bengaluru, Delhi NCR, Mumbai and Kolkata. The leading result in the supplied output is Bawarchi in Hyderabad with more than 42,000 ratings.

**Interview point:** top-N queries are useful for identifying highly engaged/high-visibility restaurants.

## Q8 — Most common cuisine listings

North Indian, Fast Food, North Indian/Chinese combinations, South Indian, Bakery and Chinese are among the most common cuisine listings.

## Q9 — Cuisine performance

The supplied results show substantial variation in rating coverage and average rating across cuisine listings. Several dessert/beverage, burger/fast-food and ice-cream/dessert combinations rank highly by average rating.

A minimum restaurant-count threshold is used to avoid over-interpreting tiny cuisine groups.

## Q10 — Most popular cuisine listings

The largest cuisine listings again include North Indian, Fast Food, North Indian/Chinese, South Indian, Bakery and Chinese.

**Important distinction:** Q10 measures popularity/representation by restaurant count; Q9 measures performance.

## Q11 — Online ordering analysis

The supplied result is almost evenly split:

- Online order available: **49.58%**
- Online order not available: **50.42%**

This indicates that online ordering is widespread but not universal in the dataset.

## Q12 — Online ordering by city

Online-order adoption varies considerably by city. Jhansi and Patiala are among the highest in the supplied results, while Goa is a major low-adoption outlier at about 15.7%.

**Interpretation:** digital adoption differs substantially by market and should not be assumed to be uniform nationally.

## Q13 — Online ordering vs restaurant characteristics

Restaurants with online ordering have higher average rating and average rating-count values in the supplied results. They also have a higher table-reservation percentage.

**Caution:** these are associations within the dataset, not causal effects.

## Q14 — Online ordering vs financial performance

The unit-economics table shows higher average estimated revenue and contribution margin for the online-order group in the supplied results.

**Critical caveat:** these are estimated financial metrics from the project model, not verified restaurant transaction revenue or profit.

## Q15 — Revenue contribution by online ordering

The supplied results show the online-order group contributing approximately **61.81% of total estimated revenue** and **60.58% of total contribution margin**, despite representing about half of the restaurants.

**Learning:** Q15 moves from average comparison to contribution/share-of-total analysis.

## Q16 — City-level financial performance

Mumbai ranks first in average estimated revenue in the supplied output, followed by Bengaluru, Kolkata, Hyderabad and Delhi NCR. Mumbai also has very high total estimated revenue because it combines strong average performance with a large restaurant base.

**Learning:** average and total metrics answer different business questions.

## Q17 — City ranking by average estimated revenue

The query ranks cities using `RANK()` after calculating city-level average estimated revenue. Mumbai ranks #1, followed by Bengaluru, Kolkata, Hyderabad and Delhi NCR in the supplied results.

**Interview point:** ranking is based on average estimated revenue, not total revenue.

## Q18 — Table reservation vs restaurant characteristics

The supplied result shows a major difference between reservation-enabled and non-enabled restaurants. Reservation-enabled restaurants have higher average rating, substantially higher average rating count, and much higher average estimated revenue and contribution margin.

**Caution:** the relationship is observational and the unit-economics values are estimated.

## Cross-query themes

### 1. Market concentration
Restaurant supply is concentrated in major cities, while smaller cities can have very different coverage and service-adoption patterns.

### 2. Ratings and engagement
Higher-rated restaurants tend to have greater review engagement in the supplied results, but causality cannot be established from this dataset.

### 3. Digital adoption
Online ordering is close to a 50/50 split overall, but adoption varies significantly by city.

### 4. Service availability and financial estimates
Online ordering and table reservation are associated with stronger estimated financial metrics in the unit-economics analysis.

### 5. Data limitations
The original restaurant dataset is not a transaction database. Financial outputs come from the separate `zomato_unit_economics` table and should always be described as **estimated**.
