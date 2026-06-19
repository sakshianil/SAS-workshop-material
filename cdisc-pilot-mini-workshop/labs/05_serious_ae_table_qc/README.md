# Lab 05 — Serious Adverse-Event Table and QC

**Time:** 90 minutes  
**Work products:** `DERIVED.SERIOUS_AE_TABLE`, HTML output, and QC comparison

Adapt the reference `at14-5-02.sas` concepts into a smaller portable table:

- Safety-population treatment denominators come from ADSL.
- The analysis population is `TRTEMFL="Y"` and `AESER="Y"`.
- Subject incidence uses distinct subjects.
- Event count uses all qualifying ADAE rows.
- Results are produced at Any SAE, SOC, and SOC/preferred-term levels.

Independent QC uses the submitted serious first-occurrence flags
`AOCC02FL`, `AOCC03FL`, and `AOCC04FL` rather than `COUNT(DISTINCT ...)`.

