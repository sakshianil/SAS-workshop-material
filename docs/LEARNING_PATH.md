# Learning Path

## Audience

This repository is intended for:

- SAS beginners who want clinical-research context;
- programmers moving from general SAS into clinical trials;
- data professionals preparing for junior clinical-programming roles;
- experienced analysts who want a compact SDTM/ADaM reference exercise.

It assumes no previous CDISC experience. Basic familiarity with tables,
variables, dates, and percentages is helpful.

## Stage 1 — Understand the work

Begin with the synthetic workshop:

1. Read the study protocol summary and mock SAP.
2. Configure SAS libraries and import the four CSV source datasets.
3. Inspect source structure, terminology, missingness, dates, and repeated
   observations.
4. Document data-quality findings before transforming data.

At this stage, focus on the relationship between a study requirement and a
programming task.

## Stage 2 — Build standardized and analysis-ready data

Continue through the synthetic SDTM-style and ADaM-style modules:

- DM and AE introduce identifiers, controlled values, and ISO dates.
- EX and VS introduce repeated records, units, status variables, and study day.
- ADSL introduces treatment variables, dates, population flags, and one-record-
  per-subject analysis structure.
- ADAE introduces analysis dates, treatment-emergent logic, duration, and
  severity ordering.

After every module, explain one variable using four statements:

1. Where did it come from?
2. What rule created it?
3. Why does analysis or reporting need it?
4. What evidence shows the derivation worked?

## Stage 3 — Produce and QC outputs

Complete the listing, demographics table, adverse-event summary, and
vital-sign figure. Pay particular attention to:

- subject-level versus event-level counts;
- treatment denominators;
- baseline and change derivations;
- display-ready datasets;
- independent QC and `PROC COMPARE`.

## Stage 4 — Inspect the CDISC reference package

Move to `cdisc-pilot-mini-workshop`:

1. Inspect XPT, Dataset-JSON, and Define-XML roles.
2. Compare SDTM DM with ADaM ADSL.
3. Trace SDTM AE into ADaM ADAE.
4. Reproduce treatment-emergent and first-occurrence flags.
5. Produce and independently QC a serious adverse-event table.

The goal is not to memorize the reference code. The goal is to recognize the
same workflow principles in more realistic artifacts.

## Suggested schedule

| Week | Focus | Estimated effort |
|---|---|---:|
| 1 | Setup, SAS foundations, source review | 2–3 hours |
| 2 | Specifications and SDTM-style domains | 3 hours |
| 3 | ADSL and ADAE | 2–3 hours |
| 4 | TLFs and QC | 3 hours |
| 5 | CDISC pilot mini-workshop | 4–6 hours |
| 6 | Repeat exercises without solutions and explain traceability | 2–4 hours |

## Completion standard

You have completed the learning path when you can:

- run both projects from a clean SAS session;
- explain the purpose of raw, SDTM, ADaM, and TLF layers;
- trace a demographic variable and an adverse event from source to output;
- identify the analysis population and denominator for a table;
- distinguish incidence from number of events;
- interpret a `PROC COMPARE` result;
- explain why conformance validation does not replace programming QC.

