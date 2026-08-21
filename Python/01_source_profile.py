"""Zomato restaurant source profiling.

Run after decompressing the source CSV. The script produces a concise
profiling report without modifying the source data.
"""

from pathlib import Path
import pandas as pd

SOURCE = Path("../Data/india_all_restaurants_details.csv")
OUTPUT = Path("../Documentation/source_profile_generated.csv")


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)

    report = pd.DataFrame({
        "column": df.columns,
        "dtype": [str(x) for x in df.dtypes],
        "null_count": df.isna().sum().values,
        "null_pct": (df.isna().mean().mul(100).round(2)).values,
        "unique_count": [df[c].nunique(dropna=True) for c in df.columns],
    })

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    report.to_csv(OUTPUT, index=False)

    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")
    print("\nColumn profile:")
    print(report.to_string(index=False))


if __name__ == "__main__":
    main()
