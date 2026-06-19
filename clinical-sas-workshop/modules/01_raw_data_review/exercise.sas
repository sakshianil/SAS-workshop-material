%include "&project_root/shared/setup.sas";

/* Build WORK.DATA_ISSUES from RAW.DEMOGRAPHICS.
   Output one row for each partial BIRTH_DATE and each missing RAND_DATE.
   Required columns: SOURCE, SUBJECT_ID, ISSUE, VALUE. */
data work.data_issues;
  /* Write your review rules here. */
run;

