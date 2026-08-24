"""Exploratory and descriptive analysis for the cleaned Zomato dataset."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"
OUTPUT = ROOT / "Data" / "processed"


def main() -> None:
    if not SOURCE.exists():
        raise FileNotFoundError(f"Cleaned dataset not found: {SOURCE}")

    df = pd.read_csv(SOURCE, low_memory=False)
    OUTPUT.mkdir(parents=True, exist_ok=True)

    # Use a stable restaurant key where possible. URL is preferred, with SNO as fallback.
    if "zomato_url" in df.columns:
        restaurant_key = df["zomato_url"].astype("string")
    else:
        restaurant_key = pd.Series(pd.NA, index=df.index, dtype="string")

    if "sno" in df.columns:
        restaurant_key = restaurant_key.fillna(df["sno"].astype("string"))

    if restaurant_key.isna().any():
        restaurant_key = restaurant_key.fillna(
            pd.Series(df.index.astype(str), index=df.index, dtype="string")
        )

    df["_restaurant_key"] = restaurant_key

    # Treat missing/non-positive cost as unavailable for cost-based analysis.
    valid_cost = df["cost_for_two_clean"].where(df["cost_for_two_clean"] > 0)

    # Overall KPIs.
    dataset_kpis = pd.DataFrame([{
        "restaurants": df["_restaurant_key"].nunique(),
        "cities": df["city"].nunique(dropna=True),
        "rated_restaurants": int(df["has_rating"].sum()),
        "avg_rating": round(df["rating_clean"].mean(), 2),
        "median_rating": round(df["rating_clean"].median(), 2),
        "avg_cost_for_two": round(valid_cost.mean(), 2),
        "median_cost_for_two": round(valid_cost.median(), 2),
        "online_order_pct": round(df["online_order"].mean() * 100, 2),
        "table_reservation_pct": round(df["table_reservation"].mean() * 100, 2),
        "delivery_only_pct": round(df["delivery_only"].mean() * 100, 2),
    }])
    dataset_kpis.to_csv(OUTPUT / "dataset_kpis.csv", index=False)

    # City-level summary. Cost metrics use only positive listed costs.
    city_kpis = df.groupby("city", dropna=False).agg(
        restaurants=("_restaurant_key", "nunique"),
        avg_rating=("rating_clean", "mean"),
        rating_count=("rating_count", "sum"),
        online_order_pct=("online_order", "mean"),
        table_reservation_pct=("table_reservation", "mean"),
        delivery_only_pct=("delivery_only", "mean"),
    ).reset_index()

    city_cost = (
        df.assign(cost_valid=valid_cost)
        .groupby("city", dropna=False)["cost_valid"]
        .mean()
        .rename("avg_cost_for_two")
        .reset_index()
    )
    city_kpis = city_kpis.merge(city_cost, on="city", how="left")
    city_kpis["avg_rating"] = city_kpis["avg_rating"].round(2)
    city_kpis["avg_cost_for_two"] = city_kpis["avg_cost_for_two"].round(2)
    for column in ["online_order_pct", "table_reservation_pct", "delivery_only_pct"]:
        city_kpis[column] = (city_kpis[column] * 100).round(2)
    city_kpis.to_csv(OUTPUT / "city_kpis.csv", index=False)

    # Cuisine-level summary. Cost metrics use only positive listed costs.
    cuisine_kpis = df.groupby("cuisine", dropna=False).agg(
        restaurants=("_restaurant_key", "nunique"),
        avg_rating=("rating_clean", "mean"),
    ).reset_index()

    cuisine_cost = (
        df.assign(cost_valid=valid_cost)
        .groupby("cuisine", dropna=False)["cost_valid"]
        .mean()
        .rename("avg_cost_for_two")
        .reset_index()
    )
    cuisine_kpis = cuisine_kpis.merge(cuisine_cost, on="cuisine", how="left")
    cuisine_kpis["avg_rating"] = cuisine_kpis["avg_rating"].round(2)
    cuisine_kpis["avg_cost_for_two"] = cuisine_kpis["avg_cost_for_two"].round(2)
    cuisine_kpis.to_csv(OUTPUT / "cuisine_kpis.csv", index=False)

    # Descriptive statistics for the main numeric fields.
    stats = df[["rating_clean", "rating_count"]].describe().T
    cost_stats = valid_cost.describe().to_frame().T
    cost_stats.index = ["cost_for_two_clean"]
    stats = pd.concat([stats, cost_stats])
    stats = stats[["count", "mean", "std", "min", "25%", "50%", "75%", "max"]].round(2)
    stats.to_csv(OUTPUT / "descriptive_statistics.csv")

    # Pearson correlation using valid observations for each pair.
    correlation_df = pd.DataFrame({
        "rating_clean": df["rating_clean"],
        "rating_count": df["rating_count"],
        "cost_for_two_clean": valid_cost,
    })
    correlation = correlation_df.corr().round(3)
    correlation.to_csv(OUTPUT / "correlation_matrix.csv")

    print(f"Restaurants: {df['_restaurant_key'].nunique():,}")
    print(f"Cities: {df['city'].nunique(dropna=True):,}")
    print("Basic statistical analysis completed.")
    print("EDA and statistics outputs written to Data/processed/")


if __name__ == "__main__":
    main()
