%include "&project_root/shared/setup.sas";

/* From safety subjects, create:
   WORK.AGE_STATS with N MEAN SD MEDIAN MIN MAX by TRT01A.
   WORK.SEX_COUNTS with subject counts by TRT01A and SEX.
   WORK.DEMOG_DISPLAY containing display-ready character values. */

proc sql;
  /* Write summary queries. */
quit;

data work.demog_display;
  /* Assemble display rows. */
run;

