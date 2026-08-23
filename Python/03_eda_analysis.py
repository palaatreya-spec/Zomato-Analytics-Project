"""Basic exploratory and statistical analysis for the cleaned Zomato dataset."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"
OUTPUT = ROOT / "Data" / "processed"


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)
    OUTPUT.mkdir(parents=True, exist_ok=True)

    # Overall KPIs
    dataset_kpis = pd.DataFrame([{
        "restaurants": df["zomato_url"].nunique(),
        "cities": df["city"].nunique(),
        "rated_restaurants": int(df["has_rating"].sum()),
        "avg_rating": round(df["rating_clean"].mean(), 2),
        "median_rating": round(df["rating_clean"].median(), 2),
        "avg_cost_for_two": round(df.loc[df["cost_for_two_clean"] > 0, "cost_for_two_clean"].mean(), 2),
        "median_cost_for_two": round(df.loc[df["cost_for_two_clean"] > 0, "cost_for_two_clean"].median(), 2),
        "online_order_pct": round(df["online_order"].mean() * 100, 2),
        "table_reservation_pct": round(df["table_reservation"].mean() * 100, 2),
    }])
    dataset_kpis.to_csv(OUTPUT / "dataset_kpis.csv", index=False)

    # City-level summary
    city_kpis = df.groupby("city").agg(
        restaurants=("zomato_url", "nunique"),
        avg_rating=("rating_clean", "mean"),
        avg_cost_for_two=("cost_for_two_clean", "mean"),
        rating_count=("rating_count", "sum"),
        online_order_pct=("online_order", "mean"),
    ).reset_index()
    city_kpis["avg_rating"] = city_kpis["avg_rating"].round(2)
    city_kpis["avg_cost_for_two"] = city_kpis["avg_cost_for_two"].round(2)
    city_kpis["online_order_pct"] = (city_kpis["online_order_pct"] * 100).round(2)
    city_kpis.to_csv(OUTPUT / "city_kpis.csv", index=False)

    # Cuisine-level summary
    cuisine_kpis = df.groupby("cuisine").agg(
        restaurants=("zomato_url", "nunique"),
        avg_rating=("rating_clean", "mean"),
        avg_cost_for_two=("cost_for_two_clean", "mean"),
    ).reset_index()
    cuisine_kpis["avg_rating"] = cuisine_kpis["avg_rating"].round(2)
    cuisine_kpis["avg_cost_for_two"] = cuisine_kpis["avg_cost_for_two"].round(2)
    cuisine_kpis.to_csv(OUTPUT / "cuisine_kpis.csv", index=False)

    # Basic descriptive statistics for key numeric fields.
    stats = df[["rating_clean", "rating_count", "cost_for_two_clean"]].describe().T
    stats = stats[["count", "mean", "std", "min", "25%", "50%", "75%", "max"]].round(2)
    stats.to_csv(OUTPUT / "descriptive_statistics.csv")

    # Simple Pearson correlation between numeric restaurant attributes.
    correlation = df[["rating_clean", "rating_count", "cost_for_two_clean"]].corr().round(3)
    correlation.to_csv(OUTPUT / "correlation_matrix.csv")

    print(f"Restaurants: {df['zomato_url'].nunique():,}")
    print(f"Cities: {df['city'].nunique():,}")
    print("Basic statistical analysis completed.")
    print("EDA and statistics outputs written to Data/processed/")


if __name__ == "__main__":
    main()
