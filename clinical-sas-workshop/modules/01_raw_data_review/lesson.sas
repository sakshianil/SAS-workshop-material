%include "&project_root/shared/setup.sas";

/* Structure, row counts, and value distributions. */
proc contents data=raw.demographics varnum;
run;
proc freq data=raw.demographics;
  tables treatment sex race end_reason / missing;
run;
proc means data=raw.vital_signs n nmiss min max mean;
  class test_code visit;
  var result;
run;

/* One table that records source-data observations requiring attention. */
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

data work.ae_issues;
  length source $20 subject_id $7 issue $80 value $40;
  set raw.adverse_events;
  source="ADVERSE_EVENTS";
  if severity ne upcase(severity) then do;
    issue="Severity source value needs controlled terminology mapping";
    value=severity;
    output;
  end;
  if missing(end_date) then do;
    issue="Ongoing adverse event has no end date";
    value=reported_term;
    output;
  end;
  keep source subject_id issue value;
run;

proc append base=work.data_issues data=work.ae_issues force;
run;
proc sort data=work.data_issues;
  by source subject_id issue;
run;
proc print data=work.data_issues noobs;
run;

