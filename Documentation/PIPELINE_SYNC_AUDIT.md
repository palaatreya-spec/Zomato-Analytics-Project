# Pipeline Synchronization Audit

**Audit scope:** Raw data → Python → SQL → Unit Economics → Power BI → Documentation/README

**Status:** Audit checkpoint — no analytical logic changed.

## 1. What is currently present

- Raw compressed source dataset under `Data/`.
- Python pipeline: source profiling, cleaning, EDA, validation, and pipeline runner.
- SQL pipeline: table setup, data-quality checks, restaurant analysis, KPI analysis, and exploratory analysis through Q18.
- Separate source-backend SQL setup/analysis files.
- Unit-economics table and analysis are represented in the current workflow.
- Power BI `.pbix` and supporting model documentation.
- Documentation covering source profile, cleaning principles, data dictionary, business questions, EDA findings, KPI definitions, assumptions/limitations, reconciliation rules, SQL execution/learning notes, project journey, architecture, and interview story.

## 2. Synchronization issues to resolve

### A. Documentation duplication

There are two similarly named result-log files:
- `Documentation/ANALYSIS_RESULTS_LOG.md`
- `Documentation/Analysis_Results_Log.md`

These should eventually be consolidated into one canonical results log to avoid maintaining two sources of truth.

### B. Q1–Q18 cross-check

The exploratory SQL file is present, but the final results/documentation should be checked against the latest confirmed Q1–Q18 outputs before adding Q19+. In particular, the latest outputs include online-order analysis, financial contribution, city revenue ranking, and table-reservation analysis.

### C. Naming/terminology consistency

Check that `online_order_status`, `table_reservation_status`, estimated revenue, contribution margin, rating counts, and restaurant counts use the same definitions and labels across SQL, results logs, KPI definitions, Power BI documentation, and README.

### D. Result correctness issue to preserve and investigate

Some supplied result tables contained a duplicated/mislabeled status label (for example, both rows were displayed as `Online Order Not Available`). The underlying counts clearly distinguish two groups. Documentation should use the actual intended labels only after the SQL output is verified.

### E. Unit-economics assumptions

The unit-economics analysis uses estimated orders/revenue and contribution margin derived from assumptions/model logic rather than observed transaction-level sales. This must remain explicit in the assumptions/limitations and interview explanation.

### F. Power BI synchronization

The `.pbix` exists, but the final dashboard/model should be checked against the current SQL result definitions after Q18. Do not claim the dashboard is final until this reconciliation is complete.

### G. README synchronization

README should be treated as the final public-facing summary, not the working analysis log. It should be updated only after the SQL, Python, documentation, and Power BI layers are reconciled.

## 3. Current pipeline map

```text
Raw Data
  ↓
Source Profiling
  ↓
Python Cleaning
  ↓
Python EDA
  ↓
Python Validation
  ↓
MySQL Table Setup
  ↓
SQL Data Quality Checks
  ↓
SQL Restaurant / KPI Analysis
  ↓
SQL Exploratory Analysis Q1–Q18
  ↓
Unit Economics
  ↓
Power BI
  ↓
Final Insights / README
```

## 4. Next synchronization order

1. Reconcile the canonical Q1–Q18 SQL outputs with the results documentation.
2. Remove/merge duplicate result-log documentation.
3. Reconcile KPI definitions and assumptions with the actual SQL formulas.
4. Check Python outputs against the cleaned-table definitions used by SQL.
5. Check Power BI model/measures against the reconciled definitions.
6. Update README only after the above checks.
7. Then continue with Q19.

**Important:** This audit intentionally records gaps and synchronization work. It does not invent missing results or silently change analytical methodology.
