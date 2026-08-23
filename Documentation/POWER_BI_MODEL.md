# Power BI Model — Zomato Restaurant Analytics

## Model grain

Use `zomato_restaurants_clean` as the main restaurant-level table, with one row per restaurant URL.

Keep the model simple. No customer, order or revenue tables are created because those fields are not available in the source dataset.

## Core measures

```DAX
Restaurant Count = DISTINCTCOUNT(zomato_restaurants_clean[zomato_url])

Rated Restaurants =
CALCULATE(
    [Restaurant Count],
    NOT ISBLANK(zomato_restaurants_clean[rating_clean])
)

Average Rating = AVERAGE(zomato_restaurants_clean[rating_clean])

Average Cost for Two =
CALCULATE(
    AVERAGE(zomato_restaurants_clean[cost_for_two_clean]),
    zomato_restaurants_clean[cost_for_two_clean] > 0
)

Online Order Restaurants =
CALCULATE(
    [Restaurant Count],
    zomato_restaurants_clean[online_order] = 1
)

Online Order Adoption % =
DIVIDE([Online Order Restaurants], [Restaurant Count])

Reservation Restaurants =
CALCULATE(
    [Restaurant Count],
    zomato_restaurants_clean[table_reservation] = 1
)

Reservation Adoption % =
DIVIDE([Reservation Restaurants], [Restaurant Count])
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
    zomato_restaurants_clean[rating_clean] < 3.5, "3.0-3.4",
    zomato_restaurants_clean[rating_clean] < 4, "3.5-3.9",
    zomato_restaurants_clean[rating_clean] < 4.5, "4.0-4.4",
    "4.5+"
)
```

## Dashboard pages

### Page 1 — Market Overview

KPI cards: Restaurant Count, Rated Restaurants, Average Rating, Average Cost for Two, Online Order Adoption and Reservation Adoption.

Visuals: restaurant supply by city, rating distribution, price-band distribution and digital-ordering comparison.

### Page 2 — City Analysis

Use city, area, price band, rating band, online order and table reservation as slicers where useful.

Visuals: restaurant count, average rating, average cost for two, rating count and online-order adoption by city.

### Page 3 — Restaurant & Cuisine Analysis

Visuals: top cuisines by restaurant count, cuisine rating comparison, cuisine pricing comparison, rating distribution and a restaurant detail table.

## UX rules

- Keep slicers consistent across pages.
- Show units clearly (`₹`, `%`, counts).
- Prefer simple bar charts, cards and tables.
- Avoid overcrowding the dashboard.
- Do not use a custom Performance Score or weighted ranking model.
- Add a small methodology note: listed cost-for-two is a pricing field, not realized revenue.
- Keep data-quality limitations visible where relevant.
