"""Run the three simple Python analysis steps in order."""

from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SCRIPTS = [
    ROOT / "Python" / "01_source_profile.py",
    ROOT / "Python" / "02_clean_restaurant_data.py",
    ROOT / "Python" / "03_eda_analysis.py",
]


def main() -> None:
    source = ROOT / "Data" / "india_all_restaurants_details.csv"
    if not source.exists():
        raise FileNotFoundError(
            "Place the decompressed CSV in Data/ before running the pipeline."
        )

    for script in SCRIPTS:
        print(f"\n>>> Running {script.name}")
        subprocess.run([sys.executable, str(script)], cwd=ROOT, check=True)

    print("\nPython analysis completed successfully.")


if __name__ == "__main__":
    main()
