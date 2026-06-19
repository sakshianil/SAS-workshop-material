%include "&project_root/shared/setup.sas";

/* Exercise: create WORK.DM_SAMPLE with the first five randomized subjects.
   1. Read RAW.DEMOGRAPHICS.
   2. Exclude missing RAND_DATE.
   3. Convert SCREEN_DATE and RAND_DATE with INPUT(...,YYMMDD10.).
   4. Format both numeric dates DATE9.
   5. Keep SUBJECT_ID, TREATMENT, SEX, SCREENDT, RANDDT.
   6. Stop after five output observations. */

data work.dm_sample;
  /* Write your code here. */
run;

proc print data=work.dm_sample noobs;
run;

