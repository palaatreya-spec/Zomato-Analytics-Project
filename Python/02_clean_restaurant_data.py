"""Create a source-backed cleaned restaurant dataset.

Run from the repository root. The raw source is never overwritten.
"""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
OUTPUT = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"


def parse_rating(series: pd.Series) -> pd.Series:
    cleaned = series.astype("string").str.strip()
    cleaned = cleaned.replace({"NEW": pd.NA, "Nové": pd.NA, "0": pd.NA})
    return pd.to_numeric(cleaned, errors="coerce")


def parse_cost(series: pd.Series) -> pd.Series:
    cleaned = series.astype("string").str.replace(",", "", regex=False).str.strip()
    return pd.to_numeric(cleaned, errors="coerce")


def parse_coordinates(series: pd.Series) -> pd.DataFrame:
    coords = series.astype("string").str.extract(
        r"^\s*([-+]?\d*\.?\d+)\s*,\s*([-+]?\d*\.?\d+)\s*$"
    )
    return coords.rename(columns={0: "latitude", 1: "longitude"}).astype(float)


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)

    if "Unnamed: 0" in df.columns:
        df = df.drop(columns=["Unnamed: 0"])

    df["rating_clean"] = parse_rating(df["rating"])
    df["cost_for_two_clean"] = parse_cost(df["cost_for_two"])

    coords = parse_coordinates(df["coordinates"])
    df = pd.concat([df, coords], axis=1)
    df["coordinate_valid"] = (
        df["latitude"].between(6, 38)
        & df["longitude"].between(68, 98)
    )

    for column in ["name", "city", "area", "cusine"]:
        df[f"{column}_clean"] = df[column].astype("string").str.strip()

    df["has_rating"] = df["rating_clean"].notna()
    df["has_cost"] = df["cost_for_two_clean"].notna() & (df["cost_for_two_clean"] > 0)
    df["has_famous_food"] = df["famous_food"].notna()

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(OUTPUT, index=False)

    print(f"Rows written: {len(df):,}")
    print(f"Output: {OUTPUT}")
    print(f"Usable ratings: {df['has_rating'].sum():,}")
    print(f"Usable positive cost values: {df['has_cost'].sum():,}")
    print(f"Valid India coordinates: {df['coordinate_valid'].sum():,}")


if __name__ == "__main__":
    main()
