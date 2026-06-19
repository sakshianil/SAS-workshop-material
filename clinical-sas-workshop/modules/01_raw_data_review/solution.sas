%include "&project_root/shared/setup.sas";

data work.data_issues;
  length source $20 subject_id $7 issue $80 value $40;
  set raw.demographics;
  source="DEMOGRAPHICS";
  if lengthn(birth_date) < 10 then do;
    issue="Partial birth date requires SAP imputation";
    value=birth_date;
    output;
  end;
  if missing(rand_date) then do;
    issue="Screened subject was not randomized";
    value=end_reason;
    output;
  end;
  keep source subject_id issue value;
run;

