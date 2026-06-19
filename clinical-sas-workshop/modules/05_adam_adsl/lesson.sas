%include "&project_root/shared/setup.sas";

/* First/last actual dose dates establish treatment exposure. */
proc sql;
  create table work.ex_summary as
  select usubjid,
         min(input(exstdtc,yymmdd10.)) as trtsdt format=date9.,
         max(input(exstdtc,yymmdd10.)) as trtedt format=date9.,
         sum(exstat="DOSED") as doses
  from sdtm.ex
  group by usubjid;
quit;

proc sort data=sdtm.dm out=work.dm;
  by usubjid;
run;
data work.raw_dm;
  set raw.demographics;
  length usubjid $15;
  usubjid=catx("-","AOM-301",subject_id);
run;
proc sort data=work.raw_dm;
  by usubjid;
run;
proc sort data=work.ex_summary;
  by usubjid;
run;

data adam.adsl(label="Subject-Level Analysis Dataset");
  length trt01p trt01a $20 ittfl saffl $1 eosstt $16;
  merge work.dm(in=indm)
        work.raw_dm(keep=usubjid birth_date screen_date end_reason)
        work.ex_summary;
  by usubjid;
  if indm;

  randdt=input(rfstdtc,yymmdd10.);
  eosdt=input(rfendtc,yymmdd10.);
  format randdt trtsdt trtedt eosdt brthdt date9.;

  /* SAP partial-date imputation: full date, mid-month, or July 1. */
  source_birth=birth_date;
  if lengthn(source_birth)=10 then brthdt=input(source_birth,yymmdd10.);
  else if lengthn(source_birth)=7 then
    brthdt=input(cats(source_birth,"-15"),yymmdd10.);
  else if lengthn(source_birth)=4 then
    brthdt=input(cats(source_birth,"-07-01"),yymmdd10.);
  if not missing(brthdt) then age=intck("year",brthdt,input(screen_date,yymmdd10.),"c");

  trt01p=arm;
  trt01a=ifc(doses>0,arm,"");
  ittfl=ifc(armcd in ("ACTIVE","PBO"),"Y","N");
  saffl=ifc(doses>0,"Y","N");
  eosstt=propcase(end_reason);

  keep studyid usubjid subjid siteid sex race ethnic age arm armcd
       trt01p trt01a randdt trtsdt trtedt eosdt eosstt ittfl saffl;
run;
proc sort data=adam.adsl;
  by usubjid;
run;

proc freq data=adam.adsl;
  tables trt01p*(ittfl saffl) / missing;
run;
