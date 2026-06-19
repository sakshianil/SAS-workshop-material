%include "&project_root/shared/setup.sas";

/* Build ADAM.ADSL.
   One row per DM subject.
   Required derivations: numeric RANDDT/TRTSDT/TRTEDT/EOSDT, AGE,
   TRT01P, TRT01A, ITTFL, SAFFL, EOSSTT.
   Use the mock SAP rules for partial birth dates. */
data adam.adsl;
  /* Write your subject-level analysis mapping here. */
run;

