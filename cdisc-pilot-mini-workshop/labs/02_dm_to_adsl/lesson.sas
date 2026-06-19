%include "&project_root/shared/setup.sas";

proc sql;
  create table derived.subject_lineage as
  select
    d.studyid,
    d.usubjid,
    d.subjid,
    d.siteid,
    d.arm as sdtm_arm,
    d.actarm as sdtm_actual_arm,
    d.rfstdtc,
    d.rfendtc,
    d.age as sdtm_age,
    d.sex as sdtm_sex,
    d.race as sdtm_race,
    a.trt01p,
    a.trt01pn,
    a.trt01a,
    a.trt01an,
    a.trtsdt,
    a.trtedt,
    a.age as adam_age,
    a.sex as adam_sex,
    a.race as adam_race,
    a.saffl,
    a.ittfl,
    a.efffl,
    case when not missing(a.usubjid) then "Y" else "N" end
      as has_adsl length=1
  from sdtm.dm as d
  left join adam.adsl as a
    on d.studyid=a.studyid and d.usubjid=a.usubjid
  order by d.usubjid;
quit;

proc freq data=derived.subject_lineage;
  tables has_adsl*sdtm_arm / missing;
run;

proc print data=derived.subject_lineage(obs=20) noobs;
  var usubjid sdtm_arm trt01p trt01a sdtm_age adam_age
      saffl ittfl efffl has_adsl;
run;

proc sql;
  select count(*) as dm_subjects,
         sum(has_adsl="Y") as linked_adsl_subjects,
         sum(has_adsl="N") as dm_without_adsl
  from derived.subject_lineage;
quit;

