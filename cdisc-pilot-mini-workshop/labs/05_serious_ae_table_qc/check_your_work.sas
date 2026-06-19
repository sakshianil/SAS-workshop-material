%include "&project_root/shared/setup.sas";
%let check_fail=0;
%assert_exists(data=derived.serious_ae_table);
%assert_exists(data=qc.serious_ae_table);
%assert_exists(data=qc.compare_serious_ae);
%assert_var(data=derived.serious_ae_table, var=SUBJECTS);
%assert_var(data=derived.serious_ae_table, var=EVENTS);
%assert_var(data=derived.serious_ae_table, var=PERCENT);
%assert_nobs(data=qc.compare_serious_ae, expected=0);
%finish_check(label=LAB 05 CHECK);

