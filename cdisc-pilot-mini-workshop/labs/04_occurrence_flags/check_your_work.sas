%include "&project_root/shared/setup.sas";
%let check_fail=0;
%assert_exists(data=derived.adae_flags);
%assert_exists(data=qc.compare_occurrence_flags);
%assert_nobs(data=derived.adae_flags, expected=1191);
%assert_var(data=derived.adae_flags, var=TRTEMFL_CALC);
%assert_var(data=derived.adae_flags, var=AOCCFL_CALC);
%assert_var(data=derived.adae_flags, var=AOCCSFL_CALC);
%assert_var(data=derived.adae_flags, var=AOCCPFL_CALC);
%assert_nobs(data=qc.compare_occurrence_flags, expected=0);
%finish_check(label=LAB 04 CHECK);

