"""Clean and standardize the Zomato restaurant dataset for analysis."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
OUTPUT = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"

REQUIRED_COLUMNS = {
    "rating",
    "cost_for_two",
    "rating_count",
    "coordinates",
    "city",
    "cusine",
    "name",
    "area",
    "online_order",
    "table_reservation",
    "delivery_only",
}


def clean_flag(series: pd.Series) -> pd.Series:
    """Convert common boolean-like source values to numeric 0/1."""
    normalized = series.astype("string").str.strip().str.lower()
    true_values = {"true", "1", "yes", "y", "t"}
    false_values = {"false", "0", "no", "n", "f"}

    result = pd.Series(pd.NA, index=series.index, dtype="Int8")
    result[normalized.isin(true_values)] = 1
    result[normalized.isin(false_values)] = 0
    return result


def main() -> None:
    if not SOURCE.exists():
        raise FileNotFoundError(f"Raw source file not found: {SOURCE}")

    df = pd.read_csv(SOURCE, low_memory=False)

    missing_columns = REQUIRED_COLUMNS.difference(df.columns)
    if missing_columns:
        raise ValueError(
            "Raw dataset is missing required columns: "
            + ", ".join(sorted(missing_columns))
        )

    if "Unnamed: 0" in df.columns:
        df = df.drop(columns=["Unnamed: 0"])

    # Ratings: keep only numeric values in the expected 1-5 range.
    df["rating_clean"] = pd.to_numeric(
        df["rating"].astype("string").str.strip().replace(
            {"NEW": pd.NA, "Nové": pd.NA, "0": pd.NA, "": pd.NA}
        ),
        errors="coerce",
    )
    df.loc[~df["rating_clean"].between(1, 5), "rating_clean"] = pd.NA

    # Listed cost for two: remove separators/non-numeric symbols and reject non-positive values.
    df["cost_for_two_clean"] = pd.to_numeric(
        df["cost_for_two"]
        .astype("string")
        .str.replace(r"[^0-9.\-]", "", regex=True)
        .str.strip(),
        errors="coerce",
    )
    df.loc[df["cost_for_two_clean"] <= 0, "cost_for_two_clean"] = pd.NA

    # Rating count: remove separators/non-numeric symbols and reject negatives.
    df["rating_count"] = pd.to_numeric(
        df["rating_count"]
        .astype("string")
        .str.replace(r"[^0-9.\-]", "", regex=True)
        .str.strip(),
        errors="coerce",
    )
    df.loc[df["rating_count"] < 0, "rating_count"] = pd.NA

    # Split latitude and longitude safely, even when a source coordinate is malformed.
    coordinates = df["coordinates"].astype("string").str.extract(
        r"^\s*([^,]+)\s*,\s*(.+?)\s*$"
    )
    df["latitude"] = pd.to_numeric(coordinates[0], errors="coerce")
    df["longitude"] = pd.to_numeric(coordinates[1], errors="coerce")

    # India-focused geographic bounds. Invalid or placeholder coordinates become missing.
    coordinate_valid = (
        df["latitude"].between(6, 38)
        & df["longitude"].between(68, 98)
    )
    df["coordinate_valid"] = coordinate_valid.astype("int8")
    df.loc[~coordinate_valid, ["latitude", "longitude"]] = pd.NA

    # Create clean analyst-friendly text fields while preserving the source columns.
    for source_column, clean_column in [
        ("city", "city"),
        ("cusine", "cuisine"),
        ("name", "name"),
        ("area", "area"),
    ]:
        df[clean_column] = df[source_column].astype("string").str.strip()
        df.loc[df[clean_column].eq(""), clean_column] = pd.NA

    # Standardize service availability fields to 0/1. Unknown source values remain missing.
    for column in ["online_order", "table_reservation", "delivery_only"]:
        df[column] = clean_flag(df[column])

    # Explicit data-quality indicators used by later analysis and SQL.
    df["has_rating"] = df["rating_clean"].notna().astype("int8")
    df["has_cost"] = df["cost_for_two_clean"].notna().astype("int8")

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    df.to_csv(OUTPUT, index=False)

    print(f"Rows written: {len(df):,}")
    print(f"Usable ratings: {df['has_rating'].sum():,}")
    print(f"Usable cost values: {df['has_cost'].sum():,}")
    print(f"Valid coordinates: {df['coordinate_valid'].sum():,}")


if __name__ == "__main__":
    main()
