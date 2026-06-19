%include "&project_root/shared/setup.sas";

/* Create WORK.TRACEABILITY with four rows:
   RAW RAND_DATE -> SDTM RFSTDTC -> ADAM TRTSDT -> OUTPUT TRTSDT.
   Required variables: STAGE, DATASET, VARIABLE, RULE. */
data work.traceability;
  length stage $12 dataset $8 variable $12 rule $100;
  /* Add four OUTPUT statements. */
run;

