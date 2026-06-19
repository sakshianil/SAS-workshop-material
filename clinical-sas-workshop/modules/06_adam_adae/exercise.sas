%include "&project_root/shared/setup.sas";

/* Build ADAM.ADAE by merging SDTM.AE with ADAM.ADSL.
   Derive ASTDT, AENDT, ASTDY, ADURN, TRTEMFL, and AESEVN.
   TRTEMFL=Y only when ASTDT is between TRTSDT and TRTEDT inclusive. */
data adam.adae;
  /* Write your analysis mapping here. */
run;

