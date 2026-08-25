# Pipeline Synchronization Audit

**Audit scope:** Raw data → Python → SQL → Unit Economics → Power BI → Documentation/README

**Status:** Active synchronization checkpoint. Analytical logic is not changed by this audit.

## 1. What is currently present

- Raw compressed source dataset under `Data/`.
- Python pipeline: source profiling, cleaning, EDA, validation, and pipeline runner.
- SQL pipeline: table setup, data-quality checks, restaurant analysis, KPI analysis, and exploratory analysis through Q19.
- Separate source-backend SQL setup/analysis files.
- Unit-economics table and analysis are represented in the current workflow.
- Power BI `.pbix` and supporting model documentation from an earlier dashboard version.
- Documentation covering source profile, cleaning principles, data dictionary, business questions, EDA findings, KPI definitions, assumptions/limitations, reconciliation rules, SQL execution/learning notes, project journey, architecture, and interview story.

## 2. Synchronization issues to resolve

### A. Documentation duplication

There are two similarly named result-log files:
- `Documentation/ANALYSIS_RESULTS_LOG.md`
- `Documentation/Analysis_Results_Log.md`

These should eventually be consolidated into one canonical results log to avoid maintaining two sources of truth.

### B. Q1–Q19 cross-check

The exploratory SQL analysis is now at Q19. The latest confirmed user-provided outputs should remain the source of truth for the results documentation. Q19 adds cost-band segmentation and compares average estimated revenue, contribution margin and rating.

### C. Naming/terminology consistency

Check that `online_order_status`, `table_reservation_status`, cost bands, estimated revenue, contribution margin, rating counts, and restaurant counts use the same definitions and labels across SQL, results logs, KPI definitions, Power BI documentation, and README.

### D. Result correctness issue to preserve and investigate

Some supplied result tables contained a duplicated/mislabeled status label (for example, both rows were displayed as `Online Order Not Available`). The underlying counts clearly distinguish two groups. Documentation records the intended labels using the validated counts, but the original SQL/output should be checked before final publication.

### E. Unit-economics assumptions

The unit-economics analysis uses estimated orders/revenue and contribution margin derived from assumptions/model logic rather than observed transaction-level sales. This must remain explicit in the assumptions/limitations and interview explanation.

### F. Q19 schema lesson

The first Q19 attempt referenced `cost_for_two_clean` while querying `zomato_unit_economics`. That column belongs to `zomato_restaurants_clean`; the actual unit-economics field is `COST_FOR_TWO`.

The query was corrected after checking the table schema. This is retained as a relevant data-model/SQL learning point: verify the actual schema before assuming a column is available in another table.

### G. Power BI — intentionally deferred

The current `.pbix` and screenshots are **old working artifacts** and should not be treated as the current analytical output. Python EDA, validation and SQL analysis have since been updated.

**Do not spend time reconciling or polishing the current Power BI dashboard yet.** After the SQL analysis is complete and the final SQL findings are validated, the Power BI model, measures, visuals and screenshots will be rebuilt/updated against the finalized pipeline.

Therefore Power BI is **not considered a current pipeline failure**; it is an intentionally deferred stage.

### H. README synchronization

README should be treated as the final public-facing summary, not the working analysis log. It should be updated only after the SQL/Python layers are reconciled and the Power BI dashboard has been rebuilt from the finalized analysis.

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
SQL Exploratory Analysis Q1–Q19
  ↓
Unit Economics
  ↓
[Power BI rebuild — deferred until SQL is finalized]
  ↓
Final Insights / README
```

## 4. Current project checkpoint

**Completed:** raw data → Python profiling → cleaning → EDA → validation → MySQL → SQL exploratory analysis Q1–Q19 → results/learning documentation.

**Deferred intentionally:** final Power BI rebuild and screenshots.

**Not yet final:** public README and final portfolio presentation.

## 5. Next synchronization order

1. Continue/complete useful intermediate-level SQL analysis.
2. Reconcile the canonical Q1–Q19+ SQL outputs with the results documentation.
3. Consolidate duplicate result-log documentation.
4. Reconcile KPI definitions and assumptions with the actual SQL formulas.
5. Check Python outputs against the cleaned-table definitions used by SQL.
6. Rebuild Power BI from the finalized SQL/Python pipeline.
7. Replace old screenshots with final dashboard screenshots.
8. Update README and interview story using only finalized findings.

**Important:** This audit intentionally records gaps and synchronization work. It does not invent missing results or silently change analytical methodology.
