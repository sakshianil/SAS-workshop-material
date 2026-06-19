# Runtime Outputs and Reproducibility Evidence

This directory is reserved for user-generated proof that the workshops execute
successfully in SAS OnDemand for Academics or another documented SAS
environment.

The repository's static validators confirm file integrity, expected source
scenarios, metadata, and programmed lineage rules. Runtime evidence adds the
missing operational proof: SAS logs, generated reports, screenshots, dataset
counts, and independent comparison results from an actual SAS execution.

## Data-safety rule

Only outputs generated from:

- the fully synthetic, hypothetical data in `clinical-sas-workshop`; or
- the attributed public CDISC test/pilot artifacts in
  `cdisc-pilot-mini-workshop`

may be committed here.

Never add real patient data, PHI, PII, confidential clinical-trial information,
sponsor material, credentials, or private account details.

## Directory structure

```text
outputs/
├── OUTPUT_MANIFEST_TEMPLATE.md
├── clinical-sas-workshop/
└── cdisc-pilot-mini-workshop/
```

Each completed run should use a dated folder:

```text
outputs/clinical-sas-workshop/2026-06-19-sas-ondemand/
outputs/cdisc-pilot-mini-workshop/2026-06-19-sas-ondemand/
```

Include a completed manifest and only the evidence needed to establish that the
workflow ran correctly.

## Minimum evidence for a verified run

- Git commit SHA
- SAS product/environment
- Execution date
- Setup and run order
- Final setup-check result
- Expected and observed source counts
- Final smoke-test log
- Key generated report files
- QC or `PROC COMPARE` evidence
- Confirmation that identifying paths and account information were redacted

Until such evidence is added, documentation should say that static validation
passed and SAS runtime verification remains to be supplied.
