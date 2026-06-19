%include "&project_root/shared/setup.sas";
%let setup_fail=0;
%assert_exists(data=work.population_listing);
%assert_nobs(data=work.population_listing, expected=56);
%assert_var(data=work.population_listing, var=ITTFL);
%assert_var(data=work.population_listing, var=EOSSTT);
%finish_check(label=MODULE 07 CHECK);

