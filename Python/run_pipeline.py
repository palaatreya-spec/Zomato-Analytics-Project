"""Run the complete Python preparation and validation pipeline in order."""

from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "Data" / "india_all_restaurants_details.csv"
SCRIPTS = [
    ROOT / "Python" / "01_source_profile.py",
    ROOT / "Python" / "02_clean_restaurant_data.py",
    ROOT / "Python" / "03_eda_analysis.py",
    ROOT / "Python" / "04_validate_output.py",
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
    validation = ROOT / "Data" / "processed" / "python_validation_report.csv"

    if not cleaned.exists():
        raise FileNotFoundError("The cleaned CSV was not created.")
    if not validation.exists():
        raise FileNotFoundError("The Python validation report was not created.")

    print("\nPython pipeline completed successfully.")
    print(f"Cleaned dataset: {cleaned}")
    print(f"Validation report: {validation}")
    print("Python output is ready for final SQL review.")


if __name__ == "__main__":
    main()
