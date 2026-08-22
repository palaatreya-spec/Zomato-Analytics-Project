"""Clean the Zomato restaurant dataset for analysis."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
OUTPUT = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)

    # Remove the unnamed index column created by the source export.
    if "Unnamed: 0" in df.columns:
        df = df.drop(columns=["Unnamed: 0"])

    # Clean ratings and convert them to numbers.
    df["rating_clean"] = pd.to_numeric(
        df["rating"].replace({"NEW": pd.NA, "Nové": pd.NA, "0": pd.NA}),
        errors="coerce",
    )

    # Clean cost for two and convert it to a numeric column.
    df["cost_for_two_clean"] = pd.to_numeric(
        df["cost_for_two"].astype("string").str.replace(",", "", regex=False),
        errors="coerce",
    )

    # Split latitude and longitude from the coordinate field.
    coordinates = df["coordinates"].astype("string").str.split(",", n=1, expand=True)
    df["latitude"] = pd.to_numeric(coordinates[0].str.strip(), errors="coerce")
    df["longitude"] = pd.to_numeric(coordinates[1].str.strip(), errors="coerce")

    # Basic text cleaning.
    for column in ["name", "city", "area", "cusine"]:
        df[f"{column}_clean"] = df[column].astype("string").str.strip()

    # Simple data-quality flags.
    df["has_rating"] = df["rating_clean"].notna()
    df["has_cost"] = df["cost_for_two_clean"].notna() & (df["cost_for_two_clean"] > 0)
    df["coordinate_valid"] = (
        df["latitude"].between(6, 38)
        & df["longitude"].between(68, 98)
    )

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(OUTPUT, index=False)

    print(f"Rows written: {len(df):,}")
    print(f"Usable ratings: {df['has_rating'].sum():,}")
    print(f"Usable cost values: {df['has_cost'].sum():,}")
    print(f"Valid coordinates: {df['coordinate_valid'].sum():,}")


if __name__ == "__main__":
    main()
