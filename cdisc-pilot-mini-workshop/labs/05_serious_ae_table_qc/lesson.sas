%include "&project_root/shared/setup.sas";

proc sql;
  create table work.denominators as
  select trt01an as trtan,
         trt01a as trta,
         count(distinct usubjid) as denominator
  from adam.adsl
  where saffl="Y"
  group by trt01an, trt01a;

  create table work.any_subjects as
  select trtan, count(distinct usubjid) as subjects
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan;

  create table work.any_events as
  select trtan, count(*) as events
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan;

  create table work.soc_subjects as
  select trtan, aebodsys, count(distinct usubjid) as subjects
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan, aebodsys;

  create table work.soc_events as
  select trtan, aebodsys, count(*) as events
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan, aebodsys;

  create table work.pt_subjects as
  select trtan, aebodsys, aedecod,
         count(distinct usubjid) as subjects
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan, aebodsys, aedecod;

  create table work.pt_events as
  select trtan, aebodsys, aedecod, count(*) as events
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan, aebodsys, aedecod;
quit;

proc sql;
  create table work.any_result as
  select 1 as summarylevel, d.trtan, d.trta,
         "" as aebodsys length=80, "" as aedecod length=80,
         coalesce(s.subjects,0) as subjects,
         coalesce(e.events,0) as events,
         d.denominator
  from work.denominators as d
  left join work.any_subjects as s on d.trtan=s.trtan
  left join work.any_events as e on d.trtan=e.trtan;

  create table work.soc_result as
  select 2 as summarylevel, d.trtan, d.trta,
         s.aebodsys, "" as aedecod length=80,
         s.subjects, e.events, d.denominator
  from work.soc_subjects as s
  inner join work.denominators as d on s.trtan=d.trtan
  left join work.soc_events as e
    on s.trtan=e.trtan and s.aebodsys=e.aebodsys;

  create table work.pt_result as
  select 3 as summarylevel, d.trtan, d.trta,
         s.aebodsys, s.aedecod,
         s.subjects, e.events, d.denominator
  from work.pt_subjects as s
  inner join work.denominators as d on s.trtan=d.trtan
  left join work.pt_events as e
    on s.trtan=e.trtan
   and s.aebodsys=e.aebodsys
   and s.aedecod=e.aedecod;
quit;

data derived.serious_ae_table;
  set work.any_result work.soc_result work.pt_result;
  percent=100*subjects/denominator;
  length display $40;
  display=cats(put(subjects,8.)," (",put(percent,5.1),"%) [",
               put(events,8.),"]");
run;
proc sort data=derived.serious_ae_table;
  by summarylevel aebodsys aedecod trtan;
run;

/* Independent QC: sum the submitted first-serious-occurrence flags. */
proc sql;
  create table work.qc_any as
  select trtan, sum(aocc02fl="Y") as subjects, count(*) as events
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan;

  create table work.qc_soc as
  select trtan, aebodsys,
         sum(aocc03fl="Y") as subjects, count(*) as events
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan, aebodsys;

  create table work.qc_pt as
  select trtan, aebodsys, aedecod,
         sum(aocc04fl="Y") as subjects, count(*) as events
  from adam.adae
  where saffl="Y" and trtemfl="Y" and aeser="Y"
  group by trtan, aebodsys, aedecod;
quit;

data qc.serious_ae_table;
  length aebodsys aedecod $80;
  set work.qc_any(in=any)
      work.qc_soc(in=soc)
      work.qc_pt(in=pt);
  if any then do;
    summarylevel=1;
    aebodsys="";
    aedecod="";
  end;
  else if soc then do;
    summarylevel=2;
    aedecod="";
  end;
  else if pt then summarylevel=3;
  keep summarylevel trtan aebodsys aedecod subjects events;
run;
proc sort data=qc.serious_ae_table;
  by summarylevel aebodsys aedecod trtan;
run;

proc compare
    base=derived.serious_ae_table(
      keep=summarylevel trtan aebodsys aedecod subjects events)
    compare=qc.serious_ae_table
    out=qc.compare_serious_ae outnoequal;
  id summarylevel aebodsys aedecod trtan;
run;

ods html path="&project_root/output" file="serious_ae_table.html";
title "Serious Treatment-Emergent Adverse Events";
footnote "n (%) [number of events]; CDISC pilot educational adaptation";
proc report data=derived.serious_ae_table nowd;
  columns summarylevel aebodsys aedecod trta,display;
  define summarylevel / group noprint;
  define aebodsys / group "System Organ Class";
  define aedecod / group "Preferred Term";
  define trta / across "Actual Treatment";
  define display / display "n (%) [E]";
run;
ods html close;
title;
footnote;

