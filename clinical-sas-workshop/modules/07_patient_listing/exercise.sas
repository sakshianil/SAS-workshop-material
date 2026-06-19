%include "&project_root/shared/setup.sas";

/* Create WORK.POPULATION_LISTING from ADAM.ADSL for ITT subjects.
   Use PROC REPORT to display USUBJID TRT01P AGE SEX RANDDT ITTFL SAFFL EOSSTT.
   Write HTML to &project_root/output/tlf/m07_exercise_listing.html. */

data work.population_listing;
  /* Select and label listing records. */
run;

ods html path="&project_root/output/tlf" file="m07_exercise_listing.html";
/* Add PROC REPORT. */
ods html close;

