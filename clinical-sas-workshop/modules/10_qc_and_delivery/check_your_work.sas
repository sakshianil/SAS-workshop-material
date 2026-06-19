%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=qc.adsl_flags);
%assert_exists(data=qc.adae_flags);
%assert_exists(data=qc.compare_adsl);
%assert_exists(data=qc.compare_adae);
%assert_exists(data=qc.delivery_checklist);
%assert_nobs(data=qc.compare_adsl, expected=0);
%assert_nobs(data=qc.compare_adae, expected=0);
%finish_check(label=MODULE 10 CHECK);

