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


def add_info(checks, name, detail):
    checks.append({
        "check": name,
        "status": "INFO",
        "detail": detail,
    })


def write_report(checks):
    report = pd.DataFrame(checks)
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    report.to_csv(OUTPUT, index=False)

    failures = int((report["status"] == "FAIL").sum())
    print("\nPython validation report")
    print("=" * 28)
    print(report[["check", "status", "detail"]].to_string(index=False))
    print(f"\nChecks: {len(report)} | Failures: {failures}")
    return failures


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

    if missing_columns:
        failures = write_report(checks)
        raise SystemExit("Python validation FAILED because required columns are missing.")

    for column in [
        "online_order",
        "table_reservation",
        "delivery_only",
        "has_rating",
        "has_cost",
        "coordinate_valid",
    ]:
        values = set(clean[column].dropna().unique().tolist())
        add_check(
            checks,
            f"{column} contains only 0/1",
            values.issubset({0, 1}),
            f"observed={sorted(values)}",
        )

    ratings = clean["rating_clean"].dropna()
    add_check(
        checks,
        "Ratings are within 1-5",
        ratings.between(1, 5).all(),
        f"invalid_count={(~ratings.between(1, 5)).sum():,}",
    )

    rating_counts = clean["rating_count"].dropna()
    add_check(
        checks,
        "Rating counts are non-negative",
        rating_counts.ge(0).all(),
        f"invalid_count={(rating_counts < 0).sum():,}",
    )

    costs = clean["cost_for_two_clean"].dropna()
    add_check(
        checks,
        "Cost values are positive",
        costs.gt(0).all(),
        f"invalid_count={(costs <= 0).sum():,}",
    )

    latitudes = clean["latitude"].dropna()
    longitudes = clean["longitude"].dropna()
    add_check(
        checks,
        "Latitude values are within India-focused bounds",
        latitudes.between(6, 38).all(),
        f"invalid_count={(~latitudes.between(6, 38)).sum():,}",
    )
    add_check(
        checks,
        "Longitude values are within India-focused bounds",
        longitudes.between(68, 98).all(),
        f"invalid_count={(~longitudes.between(68, 98)).sum():,}",
    )

    coordinate_flag_expected = (
        clean["latitude"].between(6, 38) & clean["longitude"].between(68, 98)
    ).astype("int8")
    coordinate_flag_actual = clean["coordinate_valid"].astype("int8")
    add_check(
        checks,
        "Coordinate validity flag is consistent",
        coordinate_flag_actual.eq(coordinate_flag_expected).all(),
        f"mismatches={(~coordinate_flag_actual.eq(coordinate_flag_expected)).sum():,}",
    )

    rating_flag_actual = clean["has_rating"].astype("int8")
    rating_flag_expected = clean["rating_clean"].notna().astype("int8")
    add_check(
        checks,
        "has_rating flag is consistent",
        rating_flag_actual.eq(rating_flag_expected).all(),
        "flag matches rating_clean availability",
    )

    cost_flag_actual = clean["has_cost"].astype("int8")
    cost_flag_expected = clean["cost_for_two_clean"].notna().astype("int8")
    add_check(
        checks,
        "has_cost flag is consistent",
        cost_flag_actual.eq(cost_flag_expected).all(),
        "flag matches cost_for_two_clean availability",
    )

    if "sno" in clean.columns:
        duplicate_sno = int(clean["sno"].duplicated().sum())
        add_info(
            checks,
            "SNO uniqueness",
            "SNO is retained as a source field and is not treated as a unique business key; "
            f"duplicate_rows={duplicate_sno:,}",
        )

    duplicate_rows = int(clean.duplicated().sum())
    add_check(
        checks,
        "Exact duplicate rows are absent",
        duplicate_rows == 0,
        f"duplicate_rows={duplicate_rows:,}",
    )

    for filename in REQUIRED_ANALYSIS_OUTPUTS:
        path = OUTPUT.parent / filename
        add_check(
            checks,
            f"Analysis output exists: {filename}",
            path.exists(),
            str(path.relative_to(ROOT)) if path.exists() else "missing",
        )

    failures = write_report(checks)

    if failures:
        raise SystemExit("Python validation FAILED. Fix the issues before loading MySQL.")

    print("Python validation PASSED. The cleaned dataset is ready for SQL review.")


if __name__ == "__main__":
    main()
