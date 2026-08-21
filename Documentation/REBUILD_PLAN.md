# Zomato Analytics — Technical Rebuild Plan

## Objective

Turn the current repository into a single, traceable, interview-ready analytics case study without fabricating source relationships or business metrics.

## Workstream 1 — Source profiling

- Decompress the `.zst` source locally.
- Profile schema, grain, row count, nulls, duplicates, ranges and categorical values.
- Capture the results in a reproducible profiling artifact.

## Workstream 2 — Data model

- Define the actual source grain.
- Create a clean source-backed SQL table.
- Add normalized lookup/dimension structures only when justified by the data.
- Preserve raw values separately from cleaned values.

## Workstream 3 — Quality & cleaning

- Standardize text categories.
- Validate ratings and numeric ranges.
- Handle missing values explicitly.
- Measure duplicate candidates.
- Add QA checks that can be re-run after transformations.

## Workstream 4 — Analytics

Prioritize questions around:

- restaurant supply
- location performance
- cuisine performance
- pricing proxy
- ratings
- digital-order adoption
- table-booking adoption
- portfolio segmentation
- concentration / Pareto analysis

## Workstream 5 — Power BI

Build a model from the final source-backed analytical table(s) and align all measures with `KPI_DEFINITIONS.md`.

## Workstream 6 — Final portfolio QA

Before release:

- reconcile README claims with source fields
- reconcile SQL outputs with Power BI measures
- remove unsupported customer/order/review claims if their source cannot be verified
- verify every headline metric
- document limitations
- keep the project reproducible
