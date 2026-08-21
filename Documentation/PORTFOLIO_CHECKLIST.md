# Portfolio QA Checklist

## Data

- [x] Raw source retained
- [x] Source profile documented
- [x] Rating placeholders identified
- [x] Cost parsing rule documented
- [x] Geographic QA identified
- [ ] Final processed CSV committed or reproducibly generated

## Python

- [x] Profiling script
- [x] Cleaning script
- [x] EDA script
- [x] Performance scoring script
- [ ] Final script execution validated in a clean environment

## SQL

- [x] Source-backed table definition
- [x] Source-backed business analysis
- [x] QA gates
- [x] Performance scoring
- [ ] Import/load instructions tested on MySQL
- [ ] SQL outputs reconciled with Python outputs

## Power BI

- [x] Model specification
- [x] DAX specification
- [x] Page architecture
- [ ] Rebuilt `.pbix` connected to the cleaned source-backed table
- [ ] Measures reconciled against SQL
- [ ] Screenshots refreshed

## Documentation

- [x] README
- [x] Business questions
- [x] KPI definitions
- [x] Data dictionary
- [x] Source profile
- [x] Assumptions/limitations
- [x] Cleaning principles
- [x] Interview story
- [x] Repository architecture

## Final release gate

Do not call the project final until all unchecked execution/reconciliation items are completed.
