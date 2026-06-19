%include "&project_root/shared/setup.sas";

/* Build SDTM.DM and SDTM.AE from the mapping specification.
   Minimum DM variables: STUDYID DOMAIN USUBJID SUBJID RFSTDTC SEX RACE ARM.
   Minimum AE variables: STUDYID DOMAIN USUBJID AESEQ AETERM AEDECOD
                         AEBODSYS AESEV AESER AESTDTC AEENDTC.
   Standardize controlled values with UPCASE(). */

data sdtm.dm;
  /* Write DM mapping here. */
run;

data sdtm.ae;
  /* Write AE mapping here. */
run;

