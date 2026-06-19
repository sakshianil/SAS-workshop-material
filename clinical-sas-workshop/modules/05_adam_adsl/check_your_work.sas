%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=adam.adsl);
%assert_nobs(data=adam.adsl, expected=60);
%assert_var(data=adam.adsl, var=AGE);
%assert_var(data=adam.adsl, var=ITTFL);
%assert_var(data=adam.adsl, var=SAFFL);
%assert_var(data=adam.adsl, var=TRTSDT);
%finish_check(label=MODULE 05 CHECK);

