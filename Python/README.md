# Python Workflow

## Environment

Install dependencies from the repository root:

```bash
pip install -r requirements.txt
```

## Source preparation

The repository source is compressed as `.csv.zst`. Decompress it to the expected CSV path before running the scripts, or update the `SOURCE` path in each script.

## Execution order

```text
01_source_profile.py
        ↓
02_clean_restaurant_data.py
        ↓
03_eda_analysis.py
        ↓
04_restaurant_score.py
```

## Outputs

Generated analytical outputs belong in `Data/processed/` and should not overwrite the raw source.

## Reproducibility

The scripts are designed to preserve the raw dataset and make cleaning assumptions explicit. Run profiling before modifying cleaning rules.
