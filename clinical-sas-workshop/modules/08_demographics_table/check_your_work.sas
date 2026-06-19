%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=work.age_stats);
%assert_exists(data=work.sex_counts);
%assert_exists(data=work.demog_display);
%assert_var(data=work.age_stats, var=MEAN);
%assert_var(data=work.demog_display, var=VALUE);
%finish_check(label=MODULE 08 CHECK);

