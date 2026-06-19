# Expected Checkpoints

| Stage | Artifact | Expected checkpoint |
|---|---|---|
| Import | SDTM.DM | 306 records |
| Import | SDTM.AE | 1,191 records |
| Import | ADAM.ADSL | 254 records |
| Import | ADAM.ADAE | 1,191 records |
| Lab 1 | `WORK.METADATA_INVENTORY` | Four datasets with metadata versions |
| Lab 2 | `DERIVED.SUBJECT_LINEAGE` | 306 DM subjects; 254 linked to ADSL |
| Lab 3 | `DERIVED.EVENT_LINEAGE` | 1,191 AE-to-ADAE records |
| Lab 4 | `DERIVED.ADAE_FLAGS` | TRTEMFL and three first-occurrence flags |
| Lab 5 | `DERIVED.SERIOUS_AE_TABLE` | Subject incidence and event counts |
| QC | `QC.COMPARE_SERIOUS_AE` | Zero unequal observations |

The reference data contain three serious treatment-emergent event records in
three distinct subjects. Because some treatment groups have no such event, the
compact table reports only observed combinations rather than manufacturing
zero rows for every possible SOC/preferred-term/treatment combination.
