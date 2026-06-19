# Reference-to-Workshop Map

## Selected source artifacts

| Reference artifact | Workshop use |
|---|---|
| `tabulations/sdtm/dm.xpt` | SDTM subject-level source for Lab 02 |
| `tabulations/sdtm/ae.xpt` | SDTM event-level source for Lab 03 |
| `analysis/adam/datasets/adsl.xpt` | Analysis subjects and denominators |
| `analysis/adam/datasets/adae.xpt` | Analysis dates, flags, and AE summaries |
| Corresponding `.json` files | Dataset/column metadata and row counts |
| SDTM and ADaM `define.xml` | Broader metadata and derivation context |
| `analysis/adam/programs/adae.sas` | Reference for Lab 03–04 derivations |
| `analysis/adam/programs/at14-5-02.sas` | Reference for Lab 05 table logic |

## Deliberate simplifications

- The workshop imports only four datasets rather than the full study package.
- Lab 04 teaches the general first-occurrence flags, not every customized query
  or serious-event flag in the reference ADAE program.
- Lab 05 omits Fisher exact tests and complex final display styling so the
  denominator, subject count, event count, and QC methods remain visible.
- Portable programs use `PROJECT_ROOT` and SAS Studio server paths instead of
  the legacy local paths in the original reference programs.

## Traceability path

```text
DM.USUBJID ───────────────┐
                         ├─> ADSL population/treatment attributes
AE.USUBJID + AESEQ ───────┤
                         └─> ADAE dates, TRTEMFL, occurrence flags
                                      │
                                      └─> Serious-AE table and QC
```

