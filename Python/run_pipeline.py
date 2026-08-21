"""Run the source-backed Zomato analytics pipeline in one command.

Usage from repository root:
    python Python/run_pipeline.py

The raw .zst file is not overwritten. The pipeline expects the decompressed
CSV at Data/india_all_restaurants_details.csv; this keeps source ingestion
separate from analytical transformations and avoids silently rewriting raw data.
"""

from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SCRIPTS = [
    ROOT / "Python" / "01_source_profile.py",
    ROOT / "Python" / "02_clean_restaurant_data.py",
    ROOT / "Python" / "03_eda_analysis.py",
    ROOT / "Python" / "04_restaurant_score.py",
]


def main() -> None:
    source = ROOT / "Data" / "india_all_restaurants_details.csv"
    if not source.exists():
        compressed = ROOT / "Data" / "india_all_restaurants_details.csv.zst"
        raise FileNotFoundError(
            f"Expected {source}. Decompress {compressed.name} into Data/ first."
        )

    for script in SCRIPTS:
        print(f"\n>>> Running {script.name}")
        subprocess.run([sys.executable, str(script)], cwd=ROOT, check=True)

    print("\nPipeline completed successfully.")


if __name__ == "__main__":
    main()
