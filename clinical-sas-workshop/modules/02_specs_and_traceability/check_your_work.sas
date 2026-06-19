%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=work.traceability);
%assert_nobs(data=work.traceability, expected=4);
%assert_var(data=work.traceability, var=STAGE);
%assert_var(data=work.traceability, var=RULE);
%finish_check(label=MODULE 02 CHECK);

