# SAS OnDemand Troubleshooting

## PROJECT_ROOT is not defined

Run `setup/00_create_folders.sas`. It must be rerun after a SAS session reset.

## Physical file does not exist

Right-click the uploaded workshop folder, inspect **Properties**, and copy its
exact server path into `PROJECT_ROOT`. Paths are case-sensitive.

## Library does not exist or cannot be assigned

Run the entire folder-creation program. Confirm `data/sas_raw`, `data/sdtm`,
`data/adam`, `output/tlf`, and `output/qc` exist under the workshop folder.

## PROC IMPORT changed a variable type

Delete the four datasets from the RAW library and rerun the supplied import
program with the original CSV files. `GUESSINGROWS=MAX` is intentional.

## A module check fails

Read the first error—not only the last one. Confirm prerequisite modules were
run in order and permanent datasets exist. Compare variable names and types
with the module solution using `PROC CONTENTS`.

## Output file is not visible

Refresh **Server Files and Folders**, then inspect `output/tlf`. Some browser
settings download RTF files rather than previewing them.

## SAS log contains a warning

Do not automatically ignore it. Record the message, affected program step,
cause, and why it is acceptable—or correct the program. A clean log means no
unexplained messages, not merely no red text.

