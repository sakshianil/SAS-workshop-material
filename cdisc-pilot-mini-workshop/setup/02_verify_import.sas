%include "&project_root/shared/setup.sas";
%let check_fail=0;

%assert_exists(data=sdtm.dm);
%assert_exists(data=sdtm.ae);
%assert_exists(data=adam.adsl);
%assert_exists(data=adam.adae);
%assert_nobs(data=sdtm.dm, expected=306);
%assert_nobs(data=sdtm.ae, expected=1191);
%assert_nobs(data=adam.adsl, expected=254);
%assert_nobs(data=adam.adae, expected=1191);

%macro report_import;
  %if &check_fail=0 %then
    %put NOTE: PILOT IMPORT CHECK: PASS;
  %else
    %put ERROR: PILOT IMPORT CHECK: FAIL;
%mend;
%report_import;

