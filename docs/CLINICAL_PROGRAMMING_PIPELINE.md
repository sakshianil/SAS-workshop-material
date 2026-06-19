# Clinical Programming Pipeline

## 1. Study intent and analysis rules

The protocol defines the clinical study. The statistical analysis plan (SAP)
translates study objectives into analysis populations, endpoints, summaries,
models, and conventions. The annotated case report form and mapping
specifications connect collected fields to standardized variables.

A programmer should know which document owns a rule. Code is an implementation
of approved requirements, not the place where requirements are invented.

## 2. Source-data review

Source data are reviewed before transformation:

- structure, types, lengths, keys, and row counts;
- missing, partial, invalid, or inconsistent dates;
- terminology variants and units;
- duplicate or unexpected records;
- subject disposition and treatment exposure;
- repeated measurements and visit patterns.

Review findings may become data queries, specification questions, documented
assumptions, or programmed derivations.

## 3. SDTM tabulations

SDTM organizes submitted observations into consistent domains. This repository
focuses on:

- `DM`: one record per subject;
- `AE`: one record per adverse event;
- `EX`: treatment exposure;
- `VS`: vital signs.

Common responsibilities include identifiers, controlled terminology, ISO 8601
dates, sequence numbers, units, qualifiers, and study-day variables.

## 4. ADaM analysis datasets

ADaM supports analysis and traceability. The workshops emphasize:

- `ADSL`: one record per analysis subject, treatment dates, population flags,
  demographics, and disposition;
- `ADAE`: adverse-event records enriched with analysis dates, treatment,
  treatment-emergent status, duration, and occurrence flags;
- ADVS-style processing: baseline and change-from-baseline derivations for
  repeated vital signs.

Analysis datasets should carry documented variables needed by downstream
outputs so reporting programs do not repeatedly implement critical derivations.

## 5. Tables, listings, and figures

TLF programs apply population filters and summarize prepared analysis data:

- listings expose subject-level or event-level detail;
- tables summarize counts, percentages, descriptive statistics, confidence
  intervals, or model results;
- figures show distributions, trends, and treatment comparisons.

Professional report programming separates:

1. analysis input selection;
2. statistical summarization;
3. display-dataset assembly;
4. rendering and pagination.

## 6. Quality control

QC should challenge the result, not merely reread the production program.
Useful approaches include:

- independent programming using a different method;
- source-to-target row and variable checks;
- key and duplicate checks;
- controlled-terminology checks;
- `PROC COMPARE`;
- denominator and population reconciliation;
- manual review of selected records;
- clean-log review.

Conformance tools such as Pinnacle 21 test standards-related rules. They do not
replace statistical review, traceability review, programming QC, or sponsor
governance.

## 7. Delivery

A controlled delivery typically includes datasets, metadata, programs,
outputs, validation evidence, reviewer documentation, and issue resolution.
The exact package depends on the sponsor, study, regulatory region, standards
versions, and submission requirements.

The repository demonstrates the programming logic and review habits but does
not represent a complete regulatory submission process.

