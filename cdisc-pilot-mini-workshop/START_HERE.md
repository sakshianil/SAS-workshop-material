# Start Here in SAS OnDemand

## Upload and configure

1. Sign in at <https://welcome.oda.sas.com/> and launch SAS Studio.
2. Upload and extract `cdisc-pilot-mini-workshop.zip`.
3. Open `setup/00_configure.sas`.
4. Replace the example root with the exact server path shown by SAS Studio:

```sas
%let project_root=/home/your-user-id/cdisc-pilot-mini-workshop;
```

5. Run the entire program at the start of every new SAS session.
6. Run `setup/01_import_xpt.sas`.
7. Run `setup/02_verify_import.sas`.
8. Continue only when the log says `PILOT IMPORT CHECK: PASS`.

`setup/04_verify_source_files.sas` is an optional preflight if an import path
fails. It checks that all selected XPT, JSON, and Define-XML files are present.

## Work through a lab

For each folder under `labs`, use this order:

1. Read `README.md`.
2. Run `lesson.sas` in sections and inspect Log, Results, and Output Data.
3. Complete `exercise.sas`.
4. Run `check_your_work.sas`.
5. Diagnose failures before opening `solution.sas`.
6. Record the source variables, derived variables, population rule, and
   denominator used by the lab.

After all five labs, run `setup/03_run_all_solutions.sas` as an end-to-end smoke
test and review the entire log.

## What the imported libraries contain

| Library | Dataset | Reference records |
|---|---|---:|
| SDTM | DM | 306 |
| SDTM | AE | 1,191 |
| ADAM | ADSL | 254 |
| ADAM | ADAE | 1,191 |

The XPT files are copied unchanged from the reference repository. The import
program creates ordinary SAS datasets so later exercises are easier to inspect.
