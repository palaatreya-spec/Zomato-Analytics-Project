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

    # Clean ratings and convert them to numeric values.
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

    # Create a coordinate-quality flag and remove invalid coordinate values
    # from the numeric latitude/longitude fields so SQL does not receive
    # placeholder values such as 9999.999999.
    coordinate_valid = (
        df["latitude"].between(6, 38)
        & df["longitude"].between(68, 98)
    )
    df["coordinate_valid"] = coordinate_valid.astype("int8")
    df.loc[~coordinate_valid, ["latitude", "longitude"]] = pd.NA

    # Create clean analyst-friendly fields.
    df["city"] = df["city"].astype("string").str.strip()
    df["cuisine"] = df["cusine"].astype("string").str.strip()
    df["name"] = df["name"].astype("string").str.strip()
    df["area"] = df["area"].astype("string").str.strip()

    # Source fields are boolean in the current dataset. Convert them to 0/1.
    for column in ["online_order", "table_reservation", "delivery_only"]:
        df[column] = (
            df[column]
            .astype("boolean")
            .fillna(False)
            .astype("int8")
        )

    # Basic data-quality flags. Store them explicitly as numeric 0/1.
    df["has_rating"] = df["rating_clean"].notna().astype("int8")
    df["has_cost"] = (
        df["cost_for_two_clean"].notna() & (df["cost_for_two_clean"] > 0)
    ).astype("int8")

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(OUTPUT, index=False)

    print(f"Rows written: {len(df):,}")
    print(f"Usable ratings: {df['has_rating'].sum():,}")
    print(f"Usable cost values: {df['has_cost'].sum():,}")
    print(f"Valid coordinates: {df['coordinate_valid'].sum():,}")


if __name__ == "__main__":
    main()
