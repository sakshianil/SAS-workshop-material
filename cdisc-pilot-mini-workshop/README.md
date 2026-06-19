# CDISC SDTM/ADaM Pilot Mini-Workshop

This compact SAS OnDemand project uses selected, unchanged artifacts from the
public [CDISC SDTM/ADaM Pilot Project](https://github.com/cdisc-org/sdtm-adam-pilot-project).
It focuses on one traceable safety-programming chain:

`SDTM DM + AE → ADaM ADSL + ADAE → serious adverse-event table → QC`

The original repository contains a much larger eCTD-style package. This
workshop narrows it to four datasets, their Dataset-JSON metadata, Define-XML,
and two published SAS reference programs so a learner can understand the
lineage in roughly four to six hours.

← [Back to the repository overview](../README.md)

The original reference programs are preserved for comparison but contain
legacy local Windows paths. Run the portable programs under `labs`, not the
files under `reference_programs`.

## Five labs

1. Submission anatomy, XPT import, Dataset-JSON, and Define-XML.
2. Subject lineage from DM to ADSL.
3. Event lineage from AE to ADAE.
4. Treatment-emergent and first-occurrence flags.
5. Serious-AE incidence/event-count table with independent QC.

Start with [START_HERE.md](START_HERE.md). Read
[ATTRIBUTION_AND_TERMS.md](ATTRIBUTION_AND_TERMS.md) before using the data.
The [reference map](docs/REFERENCE_MAP.md) shows how each selected repository
artifact is used and which parts of the original programs were simplified.

## Selected data and lineage

| Layer | Dataset | Records | Workshop role |
|---|---|---:|---|
| SDTM | DM | 306 | Source subject demographics |
| SDTM | AE | 1,191 | Source adverse-event records |
| ADaM | ADSL | 254 | Analysis subjects, treatment and population flags |
| ADaM | ADAE | 1,191 | Analysis dates, treatment-emergent and occurrence flags |

All 254 ADSL subjects trace to DM. All 1,191 AE records trace one-to-one to
ADAE using study, subject, and event sequence identifiers. The workshop
validator also independently recreates treatment-emergent status and the
general first-occurrence flags.

## Pipeline practiced

```text
XPT / Dataset-JSON / Define-XML inspection
→ DM-to-ADSL subject lineage
→ AE-to-ADAE event lineage
→ treatment-emergent and first-occurrence flags
→ serious-AE subject incidence and event counts
→ independent QC with alternate methods and PROC COMPARE
```

This is an educational companion, not a regulatory deliverable. It does not
replace current CDISC standards, sponsor specifications, statistical review,
conformance validation, or controlled production processes.
