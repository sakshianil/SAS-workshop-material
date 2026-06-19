%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=adam.adae);
%assert_nobs(data=adam.adae, expected=74);
%assert_var(data=adam.adae, var=TRTEMFL);
%assert_var(data=adam.adae, var=ASTDY);
%assert_var(data=adam.adae, var=AESEVN);
%finish_check(label=MODULE 06 CHECK);

