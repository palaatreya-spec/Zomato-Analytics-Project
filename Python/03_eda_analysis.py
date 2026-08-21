"""Source-backed EDA for the Zomato restaurant dataset.

Run from the repository root. The raw source is never modified.
"""

from pathlib import Path
import numpy as np
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
OUTPUT = ROOT / "Data" / "processed"


def prepare(df: pd.DataFrame) -> pd.DataFrame:
    df = df.copy()
    df["rating_clean"] = pd.to_numeric(
        df["rating"].replace({"NEW": np.nan, "Nové": np.nan}), errors="coerce"
    )
    df.loc[df["rating_clean"] == 0, "rating_clean"] = np.nan
    df["cost_for_two_clean"] = pd.to_numeric(
        df["cost_for_two"].astype("string").str.replace(",", "", regex=False),
        errors="coerce",
    )
    df["rating_count_num"] = pd.to_numeric(df["rating_count"], errors="coerce")
    return df


def main() -> None:
    df = prepare(pd.read_csv(SOURCE, low_memory=False))
    OUTPUT.mkdir(parents=True, exist_ok=True)

    dataset_kpis = pd.DataFrame([{
        "restaurants": df["zomato_url"].nunique(),
        "cities": df["city"].nunique(),
        "areas": df["area"].nunique(),
        "rated_restaurants": int(df["rating_clean"].notna().sum()),
        "avg_rating": round(df["rating_clean"].mean(), 3),
        "median_cost_for_two": df.loc[df["cost_for_two_clean"] > 0, "cost_for_two_clean"].median(),
        "online_order_pct": round(df["online_order"].mean() * 100, 2),
        "table_reservation_pct": round(df["table_reservation"].mean() * 100, 2),
    }])
    dataset_kpis.to_csv(OUTPUT / "dataset_kpis.csv", index=False)

    city = df.groupby("city").agg(
        restaurants=("zomato_url", "nunique"),
        avg_rating=("rating_clean", "mean"),
        median_cost_for_two=("cost_for_two_clean", "median"),
        rating_count=("rating_count_num", "sum"),
        online_order_pct=("online_order", "mean"),
        table_reservation_pct=("table_reservation", "mean"),
    ).reset_index()
    city["online_order_pct"] *= 100
    city["table_reservation_pct"] *= 100
    city.to_csv(OUTPUT / "city_kpis.csv", index=False)

    cuisine = df.assign(cuisine=df["cusine"].astype("string").str.split(",")).explode("cuisine")
    cuisine["cuisine"] = cuisine["cuisine"].str.strip()
    cuisine_kpis = cuisine.groupby("cuisine").agg(
        restaurants=("zomato_url", "nunique"),
        avg_rating=("rating_clean", "mean"),
        median_cost_for_two=("cost_for_two_clean", "median"),
        rating_count=("rating_count_num", "sum"),
    ).reset_index()
    cuisine_kpis.to_csv(OUTPUT / "cuisine_kpis.csv", index=False)

    correlations = df[["rating_clean", "rating_count_num", "cost_for_two_clean"]].corr()
    correlations.to_csv(OUTPUT / "numeric_correlations.csv")

    print("EDA outputs written to", OUTPUT)


if __name__ == "__main__":
    main()
