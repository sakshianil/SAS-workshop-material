%include "&project_root/shared/setup.sas";

/* 1. Explore a permanent SAS dataset imported from CSV. */
proc contents data=raw.demographics varnum;
run;

proc print data=raw.demographics(obs=8) noobs;
  var subject_id screen_date rand_date treatment sex birth_date;
run;

/* 2. Convert ISO character dates to numeric SAS dates. */
data work.dm_sample;
  length subject_id $7 treatment $12 sex $1;
  set raw.demographics;
  where not missing(rand_date);
  screendt=input(screen_date,yymmdd10.);
  randdt=input(rand_date,yymmdd10.);
  format screendt randdt date9.;
  keep subject_id treatment sex screendt randdt;
run;

/* 3. Sort before a BY-group operation. */
proc sort data=work.dm_sample;
  by treatment subject_id;
run;

proc freq data=work.dm_sample;
  tables treatment*sex / missing;
run;

/* 4. PROC SQL creates a compact treatment summary. */
proc sql;
  create table work.arm_counts as
  select treatment, count(*) as subjects
  from work.dm_sample
  group by treatment;
quit;

/* 5. Macro variables make repeated report text reusable. */
%let report_title=Foundation Check: Randomized Subjects;
ods html path="&project_root/output/tlf" file="m00_foundations.html";
%report_header(title=&report_title);
proc print data=work.dm_sample(obs=10) label noobs;
  label subject_id="Subject" randdt="Randomization Date";
run;
ods html close;
title;
footnote;

