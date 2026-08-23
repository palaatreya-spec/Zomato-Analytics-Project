"""Run the three simple Python analysis steps in order."""

from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
SCRIPTS = [
    ROOT / "Python" / "01_source_profile.py",
    ROOT / "Python" / "02_clean_restaurant_data.py",
    ROOT / "Python" / "03_eda_analysis.py",
]


def main() -> None:
    if not SOURCE.exists():
        raise FileNotFoundError(
            "Place the decompressed CSV in Data/ before running the pipeline."
        )

    for script in SCRIPTS:
        print(f"\n>>> Running {script.name}")
        subprocess.run([sys.executable, str(script)], cwd=ROOT, check=True)

    cleaned = ROOT / "Data" / "processed" / "zomato_restaurants_clean.csv"
    if not cleaned.exists():
        raise FileNotFoundError("The cleaned CSV was not created.")

    print("\nPython analysis completed successfully.")
    print(f"Cleaned dataset: {cleaned}")


if __name__ == "__main__":
    main()
