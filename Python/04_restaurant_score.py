"""Create a transparent restaurant performance score.

The score is a descriptive prioritization tool, not a profitability or causal
model. Components are percentile-ranked so that scale differences do not make
raw rating_count or cost dominate the result.
"""

from pathlib import Path
import numpy as np
import pandas as pd

SOURCE = Path("../Data/zomato_restaurants.csv")
OUTPUT = Path("../Data/processed/restaurant_scores.csv")


def percentile(series: pd.Series) -> pd.Series:
    return series.rank(pct=True, method="average") * 100


def main() -> None:
    df = pd.read_csv(SOURCE, low_memory=False)
    df["rating_clean"] = pd.to_numeric(
        df["rating"].replace({"NEW": np.nan, "Nové": np.nan}), errors="coerce"
    )
    df.loc[df["rating_clean"] == 0, "rating_clean"] = np.nan
    df["rating_count_num"] = pd.to_numeric(df["rating_count"], errors="coerce")

    valid = df[df["rating_clean"].notna()].copy()

    valid["quality_pct"] = percentile(valid["rating_clean"])
    valid["engagement_pct"] = percentile(np.log1p(valid["rating_count_num"].clip(lower=0)))
    valid["digital_pct"] = (
        valid["online_order"].astype(int) * 0.7
        + valid["table_reservation"].astype(int) * 0.3
    ) * 100

    valid["performance_score"] = (
        valid["quality_pct"] * 0.50
        + valid["engagement_pct"] * 0.35
        + valid["digital_pct"] * 0.15
    ).round(2)

    valid["performance_segment"] = pd.cut(
        valid["performance_score"],
        bins=[-np.inf, 25, 50, 75, np.inf],
        labels=["Developing", "Established", "Strong", "Top Performer"],
    )

    cols = [
        "zomato_url", "name", "city", "area", "rating_clean", "rating_count_num",
        "online_order", "table_reservation", "quality_pct", "engagement_pct",
        "digital_pct", "performance_score", "performance_segment"
    ]
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    valid[cols].sort_values("performance_score", ascending=False).to_csv(OUTPUT, index=False)

    print(f"Scored restaurants: {len(valid):,}")
    print(f"Output: {OUTPUT}")


if __name__ == "__main__":
    main()
