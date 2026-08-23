"""Clean the Zomato restaurant dataset for analysis."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
OUTPUT = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)

    if "Unnamed: 0" in df.columns:
        df = df.drop(columns=["Unnamed: 0"])

    # Clean ratings and convert them to numbers.
    df["rating_clean"] = pd.to_numeric(
        df["rating"].replace({"NEW": pd.NA, "Nové": pd.NA, "0": pd.NA}),
        errors="coerce",
    )

    # Clean listed cost-for-two.
    df["cost_for_two_clean"] = pd.to_numeric(
        df["cost_for_two"].astype("string").str.replace(",", "", regex=False),
        errors="coerce",
    )

    # Clean rating count if it contains text or commas.
    df["rating_count"] = pd.to_numeric(
        df["rating_count"].astype("string").str.replace(",", "", regex=False),
        errors="coerce",
    )

    # Split latitude and longitude from the coordinate field.
    coordinates = df["coordinates"].astype("string").str.split(",", n=1, expand=True)
    df["latitude"] = pd.to_numeric(coordinates[0].str.strip(), errors="coerce")
    df["longitude"] = pd.to_numeric(coordinates[1].str.strip(), errors="coerce")

    # Create clean analyst-friendly fields.
    df["city"] = df["city"].astype("string").str.strip()
    df["cuisine"] = df["cusine"].astype("string").str.strip()
    df["name"] = df["name"].astype("string").str.strip()
    df["area"] = df["area"].astype("string").str.strip()

    # Convert Yes/No fields to 1/0 for simple analysis.
    df["online_order"] = (
        df["online_order"].astype("string").str.strip().str.lower().map({"yes": 1, "no": 0})
    )
    df["table_reservation"] = (
        df["table_reservation"].astype("string").str.strip().str.lower().map({"yes": 1, "no": 0})
    )

    # Basic data-quality flags.
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
