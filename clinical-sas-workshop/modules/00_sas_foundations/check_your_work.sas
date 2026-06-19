%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=work.dm_sample);
%assert_nobs(data=work.dm_sample, expected=5);
%assert_var(data=work.dm_sample, var=SCREENDT);
%assert_var(data=work.dm_sample, var=RANDDT);
%finish_check(label=MODULE 00 CHECK);

