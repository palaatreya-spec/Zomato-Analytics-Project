"""Create a source-backed cleaned restaurant dataset.

The raw source is never overwritten. Cleaning rules are explicit and
focused on analytical usability rather than deleting legitimate records.
"""

from pathlib import Path
import numpy as np
import pandas as pd

SOURCE = Path("../Data/india_all_restaurants_details.csv")
OUTPUT = Path("../Data/processed/zomato_restaurants_clean.csv")


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

    # Remove export-only index columns; retain the source sequence number for lineage.
    if "Unnamed: 0" in df.columns:
        df = df.drop(columns=["Unnamed: 0"])

    # Preserve source columns while creating analytical fields.
    df["rating_clean"] = parse_rating(df["rating"])
    df["cost_for_two_clean"] = parse_cost(df["cost_for_two"])

    coords = parse_coordinates(df["coordinates"])
    df = pd.concat([df, coords], axis=1)

    # India bounding-box flag for geographic QA; do not delete invalid rows.
    df["coordinate_valid"] = (
        df["latitude"].between(6, 38)
        & df["longitude"].between(68, 98)
    )

    # Standardized text fields.
    for column in ["name", "city", "area", "cusine"]:
        df[f"{column}_clean"] = df[column].astype("string").str.strip()

    # Missing-value flags are useful for QA and Power BI.
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
