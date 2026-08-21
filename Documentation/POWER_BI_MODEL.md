# Power BI Model & DAX Specification

## Model grain

Use `zomato_restaurants_clean` as the primary fact-like table at **one row per restaurant URL**. Do not create artificial order/customer tables.

## Recommended dimensions

Where useful, create dimensions from the restaurant table:

- `DimCity`
- `DimCuisine`
- `DimPriceBand`
- `DimRatingBand`

Keep the source table as the detailed restaurant table for drill-through.

## Core measures

```DAX
Restaurant Count = DISTINCTCOUNT(zomato_restaurants_clean[zomato_url])

Rated Restaurants =
CALCULATE(
    [Restaurant Count],
    NOT ISBLANK(zomato_restaurants_clean[rating_clean])
)

Average Rating = AVERAGE(zomato_restaurants_clean[rating_clean])

Median Cost for Two = MEDIAN(zomato_restaurants_clean[cost_for_two_clean])

Online Order Restaurants =
CALCULATE(
    [Restaurant Count],
    zomato_restaurants_clean[online_order] = TRUE()
)

Online Order Adoption % =
DIVIDE([Online Order Restaurants], [Restaurant Count])

Reservation Restaurants =
CALCULATE(
    [Restaurant Count],
    zomato_restaurants_clean[table_reservation] = TRUE()
)

Reservation Adoption % =
DIVIDE([Reservation Restaurants], [Restaurant Count])

Delivery Only Restaurants =
CALCULATE(
    [Restaurant Count],
    zomato_restaurants_clean[delivery_only] = TRUE()
)

Delivery Only % =
DIVIDE([Delivery Only Restaurants], [Restaurant Count])

Average Rating Count = AVERAGE(zomato_restaurants_clean[rating_count])

Average Performance Score = AVERAGE(zomato_restaurants_clean[performance_score])
```

## Calculated columns

### Price Band

```DAX
Price Band =
SWITCH(
    TRUE(),
    ISBLANK(zomato_restaurants_clean[cost_for_two_clean]), "Unknown",
    zomato_restaurants_clean[cost_for_two_clean] <= 200, "Budget",
    zomato_restaurants_clean[cost_for_two_clean] <= 500, "Mid",
    zomato_restaurants_clean[cost_for_two_clean] <= 1000, "Premium",
    "Luxury"
)
```

### Rating Band

```DAX
Rating Band =
SWITCH(
    TRUE(),
    ISBLANK(zomato_restaurants_clean[rating_clean]), "Unrated",
    zomato_restaurants_clean[rating_clean] < 3, "<3.0",
    zomato_restaurants_clean[rating_clean] < 3.5, "3.0–3.4",
    zomato_restaurants_clean[rating_clean] < 4, "3.5–3.9",
    zomato_restaurants_clean[rating_clean] < 4.5, "4.0–4.4",
    "4.5+"
)
```

## Page design

### Page 1 — Executive Market Overview

KPI cards: Restaurant Count, Rated Restaurants, Average Rating, Median Cost, Online Order Adoption, Reservation Adoption.

Visuals: top cities, restaurant supply map, rating distribution, digital adoption comparison.

### Page 2 — City Intelligence

Use city as the main slicer. Show restaurant supply, rating, pricing, engagement and digital adoption. Include a scatter plot of restaurant count vs average rating with bubble size based on rating count.

### Page 3 — Restaurant Performance

Show Performance Score distribution, top performers, rating vs engagement, price band mix and a detailed restaurant drill-through.

### Page 4 — Cuisine Intelligence

Show cuisine supply, rating, price, engagement and digital adoption. Require a minimum restaurant-count threshold for rankings to avoid tiny categories dominating the view.

## UX rules

- Keep slicers consistent across pages.
- Use dynamic titles.
- Show units clearly (`₹`, `%`, counts).
- Avoid pie charts for high-cardinality cuisine data.
- Use tooltips for secondary metrics.
- Use drill-through for restaurant detail rather than overcrowding the overview.
- Include a visible data-quality/limitations note on the report.
