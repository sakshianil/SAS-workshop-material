%include "&project_root/shared/setup.sas";

%let setup_fail=0;
%assert_exists(data=raw.demographics);
%assert_exists(data=raw.adverse_events);
%assert_exists(data=raw.exposure);
%assert_exists(data=raw.vital_signs);
%assert_nobs(data=raw.demographics, expected=60);
%assert_min_nobs(data=raw.adverse_events, minimum=45);
%assert_min_nobs(data=raw.exposure, minimum=200);
%assert_min_nobs(data=raw.vital_signs, minimum=300);

%macro report_setup_result;
  %if &setup_fail=0 %then
    %put NOTE: WORKSHOP SETUP CHECK: PASS;
  %else
    %put ERROR: WORKSHOP SETUP CHECK: FAIL. Review messages above.;
%mend;
%report_setup_result;
