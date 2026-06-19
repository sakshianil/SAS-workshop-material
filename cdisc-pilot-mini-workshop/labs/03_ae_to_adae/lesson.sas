%include "&project_root/shared/setup.sas";

proc sql;
  create table derived.event_lineage as
  select
    e.studyid,
    e.usubjid,
    e.aeseq,
    e.aeterm,
    e.aedecod,
    e.aebodsys,
    e.aesev,
    e.aeser,
    e.aestdtc,
    e.aeendtc,
    a.astdt,
    a.astdtf,
    a.astdy,
    a.aendt,
    a.aendy,
    a.adurn,
    a.aduru,
    a.trta,
    a.trtan,
    a.trtsdt,
    a.trtedt,
    a.saffl,
    a.trtemfl,
    a.aoccfl,
    a.aoccsfl,
    a.aoccpfl,
    case when not missing(a.usubjid) then "Y" else "N" end
      as has_adae length=1
  from sdtm.ae as e
  left join adam.adae as a
    on e.studyid=a.studyid
   and e.usubjid=a.usubjid
   and e.aeseq=a.aeseq
  order by e.usubjid, e.aeseq;
quit;

proc freq data=derived.event_lineage;
  tables has_adae trtemfl*aeser / missing;
run;

proc print data=derived.event_lineage(obs=20) noobs;
  var usubjid aeseq aedecod aestdtc astdt astdtf astdy
      trta trtemfl aoccfl aoccsfl aoccpfl;
  format astdt aendt trtsdt trtedt date9.;
run;
