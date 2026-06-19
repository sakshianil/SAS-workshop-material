# Clinical SAS Hands-On Workshop

This is a beginner-friendly, 10–12 hour workshop for SAS OnDemand for
Academics. You will work as the programmer for a fictional Phase III trial and
move the same synthetic records through the clinical programming lifecycle:

`CSV source data → review/QC → SDTM-style domains → ADaM-style datasets → TLFs → QC`

The materials are original and use no patient data. The SDTM and ADaM datasets
are intentionally simplified teaching examples—not submission-ready CDISC
deliverables.

← [Back to the repository overview](../README.md)

## What you will practice

- Reading a protocol summary, SAP, terminology list, and mapping specification.
- Importing and reviewing clinical source data.
- Building DM, AE, EX, VS, ADSL, and ADAE datasets.
- Deriving analysis flags, study days, age, and treatment-emergent events.
- Producing listings, demographic and adverse-event tables, and a vital-sign figure.
- Reading SAS logs, independently QCing results, and using `PROC COMPARE`.

Start with [START_HERE.md](START_HERE.md). Complete modules in numeric order.

## Study data

The fictional study contains approximately 60 screened subjects and four source
files:

| Source | Grain | Learning purpose |
|---|---|---|
| `demographics.csv` | One row per screened subject | Randomization, treatment, partial birth dates, disposition |
| `adverse_events.csv` | One row per reported event | Terminology, severity, seriousness, dates and treatment-emergent logic |
| `exposure.csv` | Repeated dose records | First/last treatment dates, missed doses and safety population |
| `vital_signs.csv` | Test by subject and visit | Baseline, post-baseline values and change |

Intentional complications make the exercises realistic: screen failures,
partial dates, early discontinuations, ongoing events, missed doses,
inconsistent terminology, and incomplete Week 4 measurements.

## Design approach

The curriculum follows the way a study is programmed rather than teaching SAS
syntax as an isolated topic:

```text
Study documents → source review → specifications → SDTM-style domains
→ ADaM-style datasets → TLFs → independent QC and delivery review
```

Every module contains a guided lesson, an exercise, an automated checkpoint,
and a solution. Base SAS techniques are introduced only when the workflow needs
them.

## Training-video context

The workshop structure was informed by public long-form clinical SAS training:

- [CDISC SDTM ADaM TLF's Training for Beginners](https://www.youtube.com/watch?v=MOp9Q9mt2RI)
- [SAS Clinical Programming Training — CDISC, SDTM & ADaM Full Course](https://www.youtube.com/watch?v=XweS2i9ZdNY)
- [Clinical SAS Real-Time Projects — CDISC Tutorial](https://www.youtube.com/watch?v=Q1P-FG69jf8)

The code and teaching materials in this workshop are original. See the
[watch-along guide](transcript_notes/TRANSCRIPT_GUIDE.md) for topic-level
timings.

## Study disclaimer

The study, subjects, events, and results are synthetic. Controlled terminology,
domain structures, and validation examples are educational approximations.
Consult current licensed CDISC standards, sponsor standards, and validated
tools for regulated production work.
