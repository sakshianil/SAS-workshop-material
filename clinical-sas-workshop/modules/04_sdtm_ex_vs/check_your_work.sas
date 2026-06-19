%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=sdtm.ex);
%assert_exists(data=sdtm.vs);
%assert_nobs(data=sdtm.ex, expected=223);
%assert_nobs(data=sdtm.vs, expected=492);
%assert_var(data=sdtm.ex, var=EXDY);
%assert_var(data=sdtm.vs, var=VSSTRESN);
%assert_var(data=sdtm.vs, var=VSPOS);
%finish_check(label=MODULE 04 CHECK);

