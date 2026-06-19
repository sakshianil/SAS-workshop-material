# Expected Checkpoints

| Module | Main artifact | Key checkpoint |
|---|---|---|
| Setup | RAW libraries | 60 demographics, 74 AE, 223 EX, 492 VS rows |
| 00 | `WORK.DM_SAMPLE` | SAS dates display with `DATE9.` |
| 01 | `WORK.DATA_ISSUES` | Partial birth dates and screen failures identified |
| 02 | `WORK.TRACEABILITY` | Raw-to-SDTM-to-ADaM-to-output chain visible |
| 03 | `SDTM.DM`, `SDTM.AE` | 60 DM rows; controlled severity values |
| 04 | `SDTM.EX`, `SDTM.VS` | Missed doses retained; position standardized |
| 05 | `ADAM.ADSL` | One row per subject; ITTFL and SAFFL derived |
| 06 | `ADAM.ADAE` | TRTEMFL separates pre-treatment events |
| 07 | HTML/RTF listing | One row per subject with population flags |
| 08 | Demographics table | Treatment and total columns |
| 09 | AE tables and VS figure | Subject counts, not event-record counts |
| 10 | `QC.COMPARE_*` | `PROC COMPARE` reports no unequal values |

Exact counts can be confirmed by running each `check_your_work.sas`.

