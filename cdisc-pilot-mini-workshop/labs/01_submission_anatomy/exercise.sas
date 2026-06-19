%include "&project_root/shared/setup.sas";

/* Create WORK.METADATA_INVENTORY with one row each for DM, AE, ADSL, ADAE.
   Include LAYER, DATASET, LABEL, FORMAT, METADATA_VERSION, and RECORDS.
   Then use LIBNAME JSON to inspect source/cdisc/adam/adae.json. */

data work.metadata_inventory;
  length layer $5 dataset $4 label $40 format $12
         metadata_version $24 records 8;
  /* Add four records from START_HERE.md and the JSON metadata. */
run;

filename adaejson "&project_root/source/cdisc/adam/adae.json";
/* Assign a JSON library and inspect its members. */
filename adaejson clear;

