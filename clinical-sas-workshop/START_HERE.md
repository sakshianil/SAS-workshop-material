# Start Here: SAS OnDemand for Academics

## 1. Upload the workshop

1. Sign in at <https://welcome.oda.sas.com/> and launch SAS Studio.
2. In **Server Files and Folders**, open your home directory.
3. Upload `clinical-sas-workshop.zip`.
4. Extract the ZIP if your SAS Studio interface offers extraction. Otherwise,
   extract it locally and upload the `clinical-sas-workshop` folder.
5. Confirm that `README.md`, `setup`, `data`, and `modules` are visible.

## 2. Configure the current SAS session

Open `setup/00_create_folders.sas`. Change only this line:

```sas
%let project_root=/home/your-user-id/clinical-sas-workshop;
```

Use the exact path shown in SAS Studio properties. Run the whole program. The
macro variable remains available until you sign out or reset the SAS session.
Whenever you start a new session, run this program first.

## 3. Import and verify

Run these programs in order:

1. `setup/01_import_raw_data.sas`
2. `setup/02_verify_setup.sas`

Do not continue until the log contains `WORKSHOP SETUP CHECK: PASS`.

## 4. How to study each module

1. Read the module `README.md`.
2. Open `lesson.sas`; run one numbered section at a time.
3. Inspect **Log**, **Results**, and **Output Data** after every section.
4. Close the lesson and attempt `exercise.sas`.
5. Run `check_your_work.sas`.
6. Investigate failures before opening `solution.sas`.
7. Run the solution and compare its logic with yours.
8. Write three notes: what the program did, why the study needed it, and which
   log or output evidence proved it worked.

After finishing the course, `setup/03_run_all_solutions.sas` provides an
optional end-to-end smoke run. It is not a substitute for completing exercises.

## Important SAS Studio habits

- A red error in the log invalidates later results until investigated.
- Read notes about character-to-numeric conversion and uninitialized variables.
- Sort both datasets before using a DATA-step `MERGE ... BY`.
- Variable length is fixed when a SAS character variable is created.
- SAS dates are numeric values; formats control how they display.
- Rerun `setup/00_create_folders.sas` after restarting your SAS session.

## Recommended schedule

| Session | Modules | Approximate time |
|---|---|---:|
| 1 | Setup, 00, 01 | 1.5 h |
| 2 | 02, 03 | 2 h |
| 3 | 04, 05 | 2 h |
| 4 | 06, 07 | 2 h |
| 5 | 08, 09 | 2 h |
| 6 | 10 and review | 1.5–2.5 h |

See `expected_outputs/README.md` for checkpoints and
`transcript_notes/TRANSCRIPT_GUIDE.md` for watch-along references.
