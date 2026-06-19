%include "&project_root/shared/setup.sas";

/* Independently recreate:
   QC.ADSL_FLAGS: USUBJID ITTFL SAFFL.
   QC.ADAE_FLAGS: USUBJID AESEQ TRTEMFL.
   Compare each with production using PROC COMPARE and ID variables.
   Then complete QC.DELIVERY_CHECKLIST. */

proc sql;
  /* Write alternate flag derivations. */
quit;

proc compare base=work.prod_adsl_flags compare=qc.adsl_flags;
  id usubjid;
run;

