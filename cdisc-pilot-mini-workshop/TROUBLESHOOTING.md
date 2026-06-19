# Troubleshooting

## PROJECT_ROOT is not defined

Run `setup/00_configure.sas`. The macro variable is lost when the SAS session
is reset.

## XPORT engine cannot open the file

Confirm the ZIP was extracted and the exact lowercase paths exist:

- `source/cdisc/sdtm/dm.xpt`
- `source/cdisc/sdtm/ae.xpt`
- `source/cdisc/adam/adsl.xpt`
- `source/cdisc/adam/adae.xpt`

SAS OnDemand paths are case-sensitive.

## Imported record count differs

Delete the copied SAS dataset from the SDTM or ADAM library and rerun
`setup/01_import_xpt.sas`. Do not edit the XPT files.

## A check reports missing prerequisite data

Run the setup programs, then complete earlier labs in numeric order. Use
`PROC CONTENTS` to compare variable names and types with the solution.

## PROC COMPARE reports differences

Check sorting, `ID` variables, population filters, and whether you counted
subjects or event rows. Differences are evidence to investigate, not merely
messages to suppress.

## Define-XML does not render in the browser

This workshop includes XML without its external stylesheet. Read it as text and
use the Dataset-JSON files for a more approachable metadata view.

