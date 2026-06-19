%include "&project_root/shared/setup.sas";

data work.traceability;
  length stage $12 dataset $8 variable $12 rule $100;
  stage="RAW"; dataset="DEMOG"; variable="RAND_DATE";
  rule="Captured ISO date from source system"; output;
  stage="SDTM"; dataset="DM"; variable="RFSTDTC";
  rule="Copy date as ISO character value"; output;
  stage="ADAM"; dataset="ADSL"; variable="TRTSDT";
  rule="Convert RFSTDTC to numeric SAS date"; output;
  stage="OUTPUT"; dataset="LISTING"; variable="TRTSDT";
  rule="Display numeric date using DATE9 format"; output;
run;

