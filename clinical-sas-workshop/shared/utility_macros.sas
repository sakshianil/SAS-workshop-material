%macro assert_exists(data=);
  %if %sysfunc(exist(&data)) %then
    %put NOTE: CHECK PASS - &data exists.;
  %else %do;
    %put ERROR: CHECK FAIL - &data does not exist.;
    %let setup_fail=1;
  %end;
%mend;

%macro assert_nobs(data=, expected=);
  %local dsid nobs rc;
  %let dsid=%sysfunc(open(&data));
  %if &dsid %then %do;
    %let nobs=%sysfunc(attrn(&dsid,nobs));
    %let rc=%sysfunc(close(&dsid));
    %if &nobs=&expected %then
      %put NOTE: CHECK PASS - &data has &expected observations.;
    %else %do;
      %put ERROR: CHECK FAIL - &data has &nobs observations, expected &expected.;
      %let setup_fail=1;
    %end;
  %end;
%mend;

%macro assert_min_nobs(data=, minimum=);
  %local dsid nobs rc;
  %let dsid=%sysfunc(open(&data));
  %if &dsid %then %do;
    %let nobs=%sysfunc(attrn(&dsid,nobs));
    %let rc=%sysfunc(close(&dsid));
    %if &nobs >= &minimum %then
      %put NOTE: CHECK PASS - &data has &nobs observations.;
    %else %do;
      %put ERROR: CHECK FAIL - &data has &nobs observations, minimum &minimum.;
      %let setup_fail=1;
    %end;
  %end;
%mend;

%macro assert_var(data=, var=);
  %local dsid varnum rc;
  %let dsid=%sysfunc(open(&data));
  %if &dsid %then %do;
    %let varnum=%sysfunc(varnum(&dsid,&var));
    %let rc=%sysfunc(close(&dsid));
    %if &varnum > 0 %then
      %put NOTE: CHECK PASS - &data contains &var.;
    %else %do;
      %put ERROR: CHECK FAIL - &data does not contain &var.;
      %let setup_fail=1;
    %end;
  %end;
%mend;

%macro finish_check(label=);
  %if &setup_fail=0 %then
    %put NOTE: &label: PASS;
  %else
    %put ERROR: &label: FAIL;
%mend;

%macro report_header(title=, footnote=Educational synthetic data);
  title "&title";
  footnote "&footnote";
%mend;

