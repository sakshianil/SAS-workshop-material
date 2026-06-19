# CDISC Pilot Mini-Workshop Implementation Plan

**Goal:** Build a small SAS OnDemand learning project based directly on the
public CDISC SDTM/ADaM pilot submission.

**Architecture:** Keep selected CDISC XPT, Dataset-JSON, Define-XML, and
reference SAS programs unchanged under `source` and `reference_programs`.
Portable workshop programs import those artifacts into permanent SAS libraries,
then teach lineage and reporting through five independent labs.

## Tasks

- [x] Copy DM, AE, ADSL, and ADAE artifacts and record SHA-256 checksums.
- [x] Add CDISC attribution, terms, and a clear educational-use disclaimer.
- [x] Build SAS Studio configuration, XPT import, verification, and run-all programs.
- [x] Build labs for submission anatomy, DM-to-ADSL, AE-to-ADAE, occurrence
      flags, and a serious-AE table with independent QC.
- [x] Add exercises, solutions, automated checks, expected checkpoints, and troubleshooting.
- [x] Validate all structure, metadata record counts, source hashes, SAS-program
      conventions, and ZIP extraction.
