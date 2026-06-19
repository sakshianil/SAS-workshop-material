%include "&project_root/shared/setup.sas";

/* Left join SDTM.DM to ADAM.ADSL using STUDYID and USUBJID.
   Create DERIVED.SUBJECT_LINEAGE with:
   USUBJID, SDTM_ARM, TRT01P, TRT01A, SDTM_AGE, ADAM_AGE,
   SAFFL, ITTFL, EFFFL, and HAS_ADSL.
   Keep every DM subject. */
proc sql;
  create table derived.subject_lineage as
  select
    /* Select and rename variables here. */
  from sdtm.dm as d
  left join adam.adsl as a
    on d.studyid=a.studyid and d.usubjid=a.usubjid;
quit;

