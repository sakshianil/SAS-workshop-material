# Runtime Evidence Manifest

## Run identification

- Workshop: `clinical-sas-workshop`
- Evidence folder: `outputs/clinical-sas-workshop/2026-06-19-sas-ondemand`
- Git repository: `https://github.com/sakshianil/SAS-workshop-material`
- Git commit SHA associated with the supplied run:
  `73d2bb3409cb893f9a6c8713dc2f8a0e8200b95d`
- Execution date: `2026-06-19`
- Evidence supplied by: repository owner

The output modification times were after commit `73d2bb3`, and the SAS
programming files were unchanged by that documentation-only commit.

## SAS environment

- Product: SAS
- Generator reported by HTML: `SAS Software Version 9.4`
- Interface: consistent with SAS Studio / SAS OnDemand server output
- Operating environment: server environment
- Project root: redacted

The original HTML referenced an account-specific `/home/...` path. That path is
not published.

## Program represented by the evidence

The filenames and figure title correspond to:

```text
clinical-sas-workshop/modules/09_ae_summary_and_figure/lesson.sas
```

The supplied artifacts establish that the systolic-BP figure portion executed.
They do not independently prove that every preceding setup or module program
ran successfully.

## Source and imported record counts

No SAS log or count report was supplied with this evidence package.

| Dataset | Expected | Observed in supplied evidence | Result |
|---|---:|---:|---|
| RAW.DEMOGRAPHICS | 60 | Not supplied | Not assessed |
| RAW.ADVERSE_EVENTS | 74 | Not supplied | Not assessed |
| RAW.EXPOSURE | 223 | Not supplied | Not assessed |
| RAW.VITAL_SIGNS | 492 | Not supplied | Not assessed |

## Log review

- Setup check: not supplied
- Errors: not assessable without the SAS log
- Warnings: not assessable without the SAS log
- Uninitialized variables: not assessable without the SAS log
- Character/numeric conversion messages: not assessable without the SAS log
- Other unexpected notes: not assessable without the SAS log

## Outputs produced

| File | Purpose | Review result |
|---|---|---|
| `SGPlot1.png` | Figure 14.2.1 — mean systolic-BP change from baseline | Opened and visually inspected |
| `table_14_3_1_and_figure.html` | HTML presentation of the figure | Privacy-redacted and changed to a relative image path |

The supplied HTML contains the figure image but no adverse-event table markup.
Despite the filename, this artifact does not prove that Table 14.3.1 rendered.

## Figure observations

- Active 100 mg: Week 2 approximately `-2`; Week 4 approximately `0`.
- Placebo: Week 2 approximately `+2`; Week 4 approximately `+4`.
- Y-axis: mean change from baseline in `mmHg`.
- Footnote: `Educational synthetic data`.

## QC evidence

- `PROC COMPARE` output: not supplied
- Independent reproduction: not supplied
- Difference resolution: not assessed

## File integrity and redaction

### Original supplied files

```text
91e5de37e9cf051277c3a3e6eaa3cce66db2b067ea1e675ab405f62b43c84abc  table_14_3_1_and_figure.html
b3f4995513a35a3762dfb8d6aa7e73c0aec952c42f3de991741efcdc32ebdd8f  SGPlot1.png
```

### Published files

The PNG remains unchanged. The HTML checksum changed because the absolute
server path and generic alt text were replaced before publication. See
`SHA256SUMS.txt` for the final published hashes.

## Privacy and confidentiality review

- [x] Evidence uses only the repository's artificially generated,
      hypothetical study data.
- [x] No real patient or participant data are present.
- [x] No PHI, PII, sponsor-confidential information, or credentials are present.
- [x] The account-specific SAS server path was removed from the published HTML.
- [x] The image was visually reviewed before publication.

## Conclusion

- Overall result: **Partial PASS — figure generation and export demonstrated**
- Known limitations: no SAS log, setup verification, count output, rendered AE
  table, or QC comparison supplied
- Publication review date: `2026-06-19`
