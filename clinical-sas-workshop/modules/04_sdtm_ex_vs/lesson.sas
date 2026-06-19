%include "&project_root/shared/setup.sas";

proc sort data=raw.exposure out=work.exposure;
  by subject_id ex_seq;
run;
proc sort data=raw.vital_signs out=work.vitals;
  by subject_id visit_num test_code;
run;
proc sort data=raw.demographics(keep=subject_id rand_date) out=work.refdates;
  by subject_id;
run;

data sdtm.ex(label="Exposure");
  length studyid $7 domain $2 usubjid $15 extrt $20 exdosu $2
         exstdtc $10 exstat $10 exreasnd $40;
  merge work.exposure(in=inex) work.refdates;
  by subject_id;
  if inex;
  studyid="AOM-301";
  domain="EX";
  usubjid=catx("-",studyid,subject_id);
  exseq=ex_seq;
  extrt=ifc(treatment="Active","AOM-101","PLACEBO");
  exdose=dose_mg;
  exdosu="mg";
  exstdtc=dose_date;
  exstat=upcase(dose_status);
  exreasnd=upcase(reason_not_dosed);
  exdt=input(exstdtc,yymmdd10.);
  refdt=input(rand_date,yymmdd10.);
  if exdt >= refdt then exdy=exdt-refdt+1;
  else exdy=exdt-refdt;
  keep studyid domain usubjid exseq extrt exdose exdosu exstdtc
       exdy exstat exreasnd;
run;
proc sort data=sdtm.ex;
  by studyid usubjid exseq;
run;

data sdtm.vs(label="Vital Signs");
  length studyid $7 domain $2 usubjid $15 visit $12 vstestcd $8
         vstest $40 vsorres $12 vsoru $12 vsstresu $12 vspos $8 vsdtc $10;
  merge work.vitals(in=invs) work.refdates;
  by subject_id;
  if invs;
  studyid="AOM-301";
  domain="VS";
  usubjid=catx("-",studyid,subject_id);
  visit=upcase(visit);
  visitnum=visit_num;
  vstestcd=upcase(test_code);
  vstest=test_name;
  vsorres=strip(put(result,best.));
  vsoru=unit;
  vsstresn=result;
  vsstresu=unit;
  if upcase(position) in ("SEATED","SITTING") then vspos="SITTING";
  vsdtc=measure_date;
  vsdt=input(vsdtc,yymmdd10.);
  refdt=input(rand_date,yymmdd10.);
  if vsdt >= refdt then vsdy=vsdt-refdt+1;
  else vsdy=vsdt-refdt;
  keep studyid domain usubjid visit visitnum vstestcd vstest vsorres
       vsoru vsstresn vsstresu vspos vsdtc vsdy;
run;
proc sort data=sdtm.vs;
  by studyid usubjid visitnum vstestcd;
run;

