%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=work.data_issues);
%assert_nobs(data=work.data_issues, expected=7);
%assert_var(data=work.data_issues, var=ISSUE);
%assert_var(data=work.data_issues, var=VALUE);
%finish_check(label=MODULE 01 CHECK);

