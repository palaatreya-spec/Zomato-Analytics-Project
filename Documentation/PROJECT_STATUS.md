# Project Upgrade Status

## Current status

The repository is being upgraded from a learning/capstone project into a recruiter-facing Data Analyst case study.

### Completed

- Fixed a broken alias in the review summary view.
- Added data dictionary.
- Added assumptions and limitations.
- Added business-question framework.
- Added portfolio analysis SQL.
- Added expanded data-quality SQL.
- Rebuilt README around analyst workflow and business questions.
- Added KPI definitions and metric governance.
- Added SQL execution / QA guide.

### In progress

- Reconcile the SQL relational model with the actual compressed restaurant source.
- Validate whether revenue, order, customer and review fields exist in the source or are from an extended relational dataset.
- Remove or clearly label unsupported analyses.
- Align Power BI measures with the final KPI definitions.

### Final target

The final portfolio project should have one clearly traceable analytical lineage:

**Source → QA → Cleaning → Transformation → KPI → Analysis → Power BI → Insight**

No metric should be presented as an official Zomato financial figure unless it is directly supported by the source.
