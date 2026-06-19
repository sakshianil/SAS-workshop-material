%include "&project_root/shared/setup.sas";

data work.dm_sample;
  set raw.demographics;
  where not missing(rand_date);
  screendt=input(screen_date,yymmdd10.);
  randdt=input(rand_date,yymmdd10.);
  format screendt randdt date9.;
  keep subject_id treatment sex screendt randdt;
  if _n_ <= 5;
run;

proc print data=work.dm_sample noobs;
run;

