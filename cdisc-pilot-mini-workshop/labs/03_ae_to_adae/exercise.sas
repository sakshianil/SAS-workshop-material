%include "&project_root/shared/setup.sas";

/* Create DERIVED.EVENT_LINEAGE by left joining AE to ADAE on
   STUDYID, USUBJID, and AESEQ.
   Include source dates, analysis dates/day/duration, treatment, safety flag,
   TRTEMFL, AOCCFL, AOCCSFL, AOCCPFL, and HAS_ADAE. */
proc sql;
  create table derived.event_lineage as
  select
    /* Add traceability variables. */
  from sdtm.ae as e
  left join adam.adae as a
    on e.studyid=a.studyid
   and e.usubjid=a.usubjid
   and e.aeseq=a.aeseq;
quit;

