%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=sdtm.dm);
%assert_exists(data=sdtm.ae);
%assert_nobs(data=sdtm.dm, expected=60);
%assert_nobs(data=sdtm.ae, expected=74);
%assert_var(data=sdtm.dm, var=USUBJID);
%assert_var(data=sdtm.ae, var=AEDECOD);
%assert_var(data=sdtm.ae, var=AESEV);
%finish_check(label=MODULE 03 CHECK);

