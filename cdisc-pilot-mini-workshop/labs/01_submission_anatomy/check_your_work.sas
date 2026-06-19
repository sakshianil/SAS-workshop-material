%include "&project_root/shared/setup.sas";
%let check_fail=0;
%assert_exists(data=work.metadata_inventory);
%assert_nobs(data=work.metadata_inventory, expected=4);
%assert_var(data=work.metadata_inventory, var=METADATA_VERSION);
%assert_var(data=work.metadata_inventory, var=RECORDS);
%finish_check(label=LAB 01 CHECK);

