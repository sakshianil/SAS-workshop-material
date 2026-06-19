%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=work.teae_unique);
%assert_exists(data=work.soc_pt_counts);
%assert_exists(data=work.teae_summary);
%assert_exists(data=work.advs);
%assert_exists(data=work.vs_mean);
%assert_var(data=work.advs, var=CHG);
%assert_var(data=work.soc_pt_counts, var=SUBJECTS);
%finish_check(label=MODULE 09 CHECK);

