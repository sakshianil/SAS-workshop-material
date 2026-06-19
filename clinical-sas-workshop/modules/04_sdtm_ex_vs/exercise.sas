%include "&project_root/shared/setup.sas";

/* Build SDTM.EX and SDTM.VS.
   Preserve NOT DOSED exposure rows.
   Map both SEATED and SITTING source values to VSPOS="SITTING".
   Derive EXDY and VSDY relative to RAND_DATE with no Day 0. */
data sdtm.ex;
  /* Write exposure mapping. */
run;

data sdtm.vs;
  /* Write vital-sign mapping. */
run;

