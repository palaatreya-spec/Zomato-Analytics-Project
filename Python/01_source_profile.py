"""Basic source profiling for the Zomato restaurant dataset."""

from pathlib import Path
import pandas as pd

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
OUTPUT = ROOT / "Data" / "processed" / "source_profile_generated.csv"


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)

    profile = pd.DataFrame({
        "column": df.columns,
        "data_type": [str(dtype) for dtype in df.dtypes],
        "missing_count": df.isna().sum().values,
        "missing_pct": (df.isna().mean() * 100).round(2).values,
        "unique_count": [df[column].nunique(dropna=True) for column in df.columns],
    })

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    profile.to_csv(OUTPUT, index=False)

    print(f"Rows: {len(df):,}")
    print(f"Columns: {len(df.columns)}")
    print("Source profile saved to Data/processed/")


if __name__ == "__main__":
    main()
