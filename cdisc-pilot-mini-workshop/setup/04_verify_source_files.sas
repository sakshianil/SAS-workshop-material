%include "&project_root/shared/setup.sas";

%let check_fail=0;
%macro assert_file(relative=);
  %if %sysfunc(fileexist(&project_root/&relative)) %then
    %put NOTE: CHECK PASS - &relative exists.;
  %else %do;
    %put ERROR: CHECK FAIL - &relative is missing.;
    %let check_fail=1;
  %end;
%mend;

%assert_file(relative=source/cdisc/sdtm/dm.xpt);
%assert_file(relative=source/cdisc/sdtm/ae.xpt);
%assert_file(relative=source/cdisc/sdtm/dm.json);
%assert_file(relative=source/cdisc/sdtm/ae.json);
%assert_file(relative=source/cdisc/sdtm/define.xml);
%assert_file(relative=source/cdisc/adam/adsl.xpt);
%assert_file(relative=source/cdisc/adam/adae.xpt);
%assert_file(relative=source/cdisc/adam/adsl.json);
%assert_file(relative=source/cdisc/adam/adae.json);
%assert_file(relative=source/cdisc/adam/define.xml);

%finish_check(label=SOURCE FILE CHECK);

