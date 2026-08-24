"""Validate the final Python output before it is loaded into SQL."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
RAW = ROOT / "Data" / "india_all_restaurants_details.csv"
CLEAN = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"
OUTPUT = ROOT / "Data" / "processed" / "python_validation_report.csv"

REQUIRED_CLEAN_COLUMNS = {
    "rating_clean",
    "cost_for_two_clean",
    "rating_count",
    "latitude",
    "longitude",
    "coordinate_valid",
    "city",
    "cuisine",
    "name",
    "area",
    "online_order",
    "table_reservation",
    "delivery_only",
    "has_rating",
    "has_cost",
}

REQUIRED_ANALYSIS_OUTPUTS = [
    "source_profile_generated.csv",
    "dataset_kpis.csv",
    "city_kpis.csv",
    "cuisine_kpis.csv",
    "descriptive_statistics.csv",
    "correlation_matrix.csv",
]


def add_check(checks, name, passed, detail):
    checks.append({
        "check": name,
        "status": "PASS" if passed else "FAIL",
        "detail": detail,
    })


def main() -> None:
    if not RAW.exists():
        raise FileNotFoundError(f"Raw source file not found: {RAW}")
    if not CLEAN.exists():
        raise FileNotFoundError(f"Cleaned output not found: {CLEAN}")

    raw = pd.read_csv(RAW, low_memory=False)
    clean = pd.read_csv(CLEAN, low_memory=False)
    checks = []

    add_check(
        checks,
        "Row count preserved",
        len(raw) == len(clean),
        f"raw={len(raw):,}, cleaned={len(clean):,}",
    )

    missing_columns = REQUIRED_CLEAN_COLUMNS.difference(clean.columns)
    add_check(
        checks,
        "Required cleaned columns present",
        not missing_columns,
        "missing=" + (", ".join(sorted(missing_columns)) if missing_columns else "none"),
    )

    for column in ["online_order", "table_reservation", "delivery_only", "has_rating", "has_cost", "coordinate_valid"]:
        if column not in clean.columns:
            continue
        values = set(clean[column].dropna().unique().tolist())
        add_check(
            checks,
            f"{column} contains only 0/1",
            values.issubset({0, 1}),
            f"observed={sorted(values)}",
        )

    ratings_valid = clean["rating_clean"].dropna().between(1, 5).all()
    add_check(
        checks,
        "Ratings are within 1-5",
        ratings_valid,
        f"invalid_count={(~clean['rating_clean'].dropna().between(1, 5)).sum():,}",
    )

    rating_counts_valid = clean["rating_count"].dropna().ge(0).all()
    add_check(
        checks,
        "Rating counts are non-negative",
        rating_counts_valid,
        f"invalid_count={(clean['rating_count'].dropna() < 0).sum():,}",
    )

    costs_valid = clean["cost_for_two_clean"].dropna().gt(0).all()
    add_check(
        checks,
        "Cost values are positive",
        costs_valid,
        f"invalid_count={(clean['cost_for_two_clean'].dropna() <= 0).sum():,}",
    )

    lat_valid = clean["latitude"].dropna().between(6, 38).all()
    lon_valid = clean["longitude"].dropna().between(68, 98).all()
    add_check(
        checks,
        "Latitude values are within India-focused bounds",
        lat_valid,
        f"invalid_count={(~clean['latitude'].dropna().between(6, 38)).sum():,}",
    )
    add_check(
        checks,
        "Longitude values are within India-focused bounds",
        lon_valid,
        f"invalid_count={(~clean['longitude'].dropna().between(68, 98)).sum():,}",
    )

    coordinate_flag_expected = (
        clean["latitude"].between(6, 38) & clean["longitude"].between(68, 98)
    ).astype("int8")
    coordinate_flag_consistent = clean["coordinate_valid"].astype("int8").eq(coordinate_flag_expected).all()
    add_check(
        checks,
        "Coordinate validity flag is consistent",
        coordinate_flag_consistent,
        f"mismatches={(~clean['coordinate_valid'].astype('int8').eq(coordinate_flag_expected)).sum():,}",
    )

    add_check(
        checks,
        "has_rating flag is consistent",
        clean["has_rating"].astype("int8").eq(clean["rating_clean"].notna().astype("int8")).all(),
        "flag matches rating_clean availability",
    )
    add_check(
        checks,
        "has_cost flag is consistent",
        clean["has_cost"].astype("int8").eq(clean["cost_for_two_clean"].notna().astype("int8")).all(),
        "flag matches cost_for_two_clean availability",
    )

    if "sno" in clean.columns:
        duplicate_sno = int(clean["sno"].duplicated().sum())
        add_check(
            checks,
            "SNO is unique",
            duplicate_sno == 0,
            f"duplicate_rows={duplicate_sno:,}",
        )

    for filename in REQUIRED_ANALYSIS_OUTPUTS:
        path = OUTPUT.parent / filename
        add_check(
            checks,
            f"Analysis output exists: {filename}",
            path.exists(),
            str(path.relative_to(ROOT)) if path.exists() else "missing",
        )

    report = pd.DataFrame(checks)
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    report.to_csv(OUTPUT, index=False)

    failures = int((report["status"] == "FAIL").sum())
    print("\nPython validation report")
    print("=" * 28)
    print(report[["check", "status", "detail"]].to_string(index=False))
    print(f"\nChecks: {len(report)} | Failures: {failures}")

    if failures:
        raise SystemExit("Python validation FAILED. Fix the issues before loading MySQL.")

    print("Python validation PASSED. The cleaned dataset is ready for SQL review.")


if __name__ == "__main__":
    main()
