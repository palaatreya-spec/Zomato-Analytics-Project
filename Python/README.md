# Python Workflow

The Python stage prepares and validates the restaurant dataset before any SQL loading.

## Environment

Install dependencies from the repository root:

```bash
pip install -r requirements.txt
```

## Source preparation

The repository source is compressed as `.csv.zst`. Decompress it to:

```text
Data/india_all_restaurants_details.csv
```

The raw source is never overwritten by the Python scripts.

## Execution order

```text
01_source_profile.py
        ↓
02_clean_restaurant_data.py
        ↓
03_eda_analysis.py
        ↓
04_validate_output.py
```

Or run the complete workflow with:

```bash
python Python/run_pipeline.py
```

## What each step does

### 01 — Source profiling

Profiles the raw dataset for:

- row and column counts
- data types
- missing values
- missing percentages
- unique values

Output:

```text
Data/processed/source_profile_generated.csv
```

### 02 — Cleaning and standardization

Creates the analyst-ready dataset while preserving the raw source. Key transformations include:

- numeric rating, rating count, and cost fields
- invalid ratings outside 1–5 converted to missing
- non-positive costs converted to missing
- negative rating counts converted to missing
- latitude/longitude extraction and India-focused validity checks
- service fields standardized to 0/1 where the source value is known
- clean `city`, `cuisine`, `name`, and `area` fields
- explicit `has_rating`, `has_cost`, and `coordinate_valid` quality flags

Output:

```text
Data/processed/zomato_restaurants_clean.csv
```

### 03 — EDA and descriptive statistics

Generates practical analyst-level outputs:

- overall dataset KPIs
- city-level KPIs
- cuisine-level KPIs
- descriptive statistics
- Pearson correlation matrix

Cost-based metrics use only valid positive listed costs. Service percentages use known 0/1 values and do not treat unknown values as false.

### 04 — Final validation gate

Checks the cleaned output before SQL loading, including:

- row-count preservation
- required columns
- binary quality/service flags
- rating and cost ranges
- geographic ranges
- quality-flag consistency
- SNO uniqueness when available
- required analytical output files

The pipeline stops if any validation check fails.

Output:

```text
Data/processed/python_validation_report.csv
```

## Reproducibility

The workflow follows a clear analyst pipeline:

```text
Raw data → Profile → Clean → Analyze → Validate → SQL
```

The raw dataset remains untouched, and SQL loading should begin only after the Python validation report shows **PASS** for every check.
