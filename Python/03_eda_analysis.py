"""Basic exploratory analysis for the Zomato restaurant dataset.

Creates simple CSV outputs that can be used for SQL checks or Power BI.
"""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"
OUTPUT = ROOT / "Data" / "processed"


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)
    OUTPUT.mkdir(parents=True, exist_ok=True)

    # Overall dataset summary
    dataset_kpis = pd.DataFrame([{
        "restaurants": df["zomato_url"].nunique(),
        "cities": df["city_clean"].nunique(),
        "rated_restaurants": int(df["has_rating"].sum()),
        "avg_rating": round(df["rating_clean"].mean(), 2),
        "avg_cost_for_two": round(
            df.loc[df["cost_for_two_clean"] > 0, "cost_for_two_clean"].mean(), 2
        ),
        "online_order_pct": round(df["online_order"].mean() * 100, 2),
        "table_reservation_pct": round(df["table_reservation"].mean() * 100, 2),
    }])
    dataset_kpis.to_csv(OUTPUT / "dataset_kpis.csv", index=False)

    # City-level summary
    city_kpis = df.groupby("city_clean").agg(
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

    # Simple cuisine summary
    cuisine_kpis = df.groupby("cusine_clean").agg(
        restaurants=("zomato_url", "nunique"),
        avg_rating=("rating_clean", "mean"),
        avg_cost_for_two=("cost_for_two_clean", "mean"),
    ).reset_index()
    cuisine_kpis["avg_rating"] = cuisine_kpis["avg_rating"].round(2)
    cuisine_kpis["avg_cost_for_two"] = cuisine_kpis["avg_cost_for_two"].round(2)
    cuisine_kpis.to_csv(OUTPUT / "cuisine_kpis.csv", index=False)

    print(f"Restaurants: {df['zomato_url'].nunique():,}")
    print(f"Cities: {df['city_clean'].nunique():,}")
    print("EDA outputs written to Data/processed/")


if __name__ == "__main__":
    main()
