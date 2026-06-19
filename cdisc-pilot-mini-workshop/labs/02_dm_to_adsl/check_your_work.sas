%include "&project_root/shared/setup.sas";
%let check_fail=0;
%assert_exists(data=derived.subject_lineage);
%assert_nobs(data=derived.subject_lineage, expected=306);
%assert_var(data=derived.subject_lineage, var=HAS_ADSL);
%assert_var(data=derived.subject_lineage, var=TRT01A);

proc sql noprint;
  select sum(has_adsl="Y") into :linked trimmed
  from derived.subject_lineage;
quit;
%macro check_linked;
  %if &linked=254 %then
    %put NOTE: CHECK PASS - 254 DM subjects link to ADSL.;
  %else %do;
    %put ERROR: CHECK FAIL - &linked subjects link to ADSL, expected 254.;
    %let check_fail=1;
  %end;
%mend;
%check_linked;
%finish_check(label=LAB 02 CHECK);

