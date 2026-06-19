%include "&project_root/shared/setup.sas";

proc import datafile="&project_root/metadata/mapping_specifications.csv"
  out=work.mapping dbms=csv replace;
  guessingrows=max;
  getnames=yes;
run;

proc import datafile="&project_root/metadata/controlled_terminology.csv"
  out=work.terminology dbms=csv replace;
  guessingrows=max;
  getnames=yes;
run;

proc print data=work.mapping noobs;
run;

data work.traceability;
  length stage $12 dataset $8 variable $12 rule $100;
  stage="RAW"; dataset="DEMOG"; variable="RAND_DATE";
  rule="Captured ISO date from source system"; output;
  stage="SDTM"; dataset="DM"; variable="RFSTDTC";
  rule="Copy randomized subject date as ISO character value"; output;
  stage="ADAM"; dataset="ADSL"; variable="TRTSDT";
  rule="Convert RFSTDTC to numeric SAS date"; output;
  stage="OUTPUT"; dataset="LISTING"; variable="TRTSDT";
  rule="Display first treatment date using DATE9 format"; output;
run;

proc print data=work.traceability noobs;
run;

