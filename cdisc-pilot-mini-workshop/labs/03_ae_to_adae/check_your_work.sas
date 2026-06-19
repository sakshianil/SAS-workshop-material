%include "&project_root/shared/setup.sas";
%let check_fail=0;
%assert_exists(data=derived.event_lineage);
%assert_nobs(data=derived.event_lineage, expected=1191);
%assert_var(data=derived.event_lineage, var=ASTDT);
%assert_var(data=derived.event_lineage, var=TRTEMFL);
%assert_var(data=derived.event_lineage, var=HAS_ADAE);
%finish_check(label=LAB 03 CHECK);

