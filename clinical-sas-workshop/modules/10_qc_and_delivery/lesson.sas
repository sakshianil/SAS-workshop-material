%include "&project_root/shared/setup.sas";

/* Independent flag recreation from source-level data. */
proc sql;
  create table qc.adsl_flags as
  select d.usubjid,
         case when d.armcd in ("ACTIVE","PBO") then "Y" else "N" end as ittfl length=1,
         case when sum(e.exstat="DOSED") > 0 then "Y" else "N" end as saffl length=1
  from sdtm.dm as d
  left join sdtm.ex as e
    on d.usubjid=e.usubjid
  group by d.usubjid, d.armcd;

  create table qc.adae_flags as
  select a.usubjid, a.aeseq,
         case
           when input(a.aestdtc,yymmdd10.) between s.trtsdt and s.trtedt then "Y"
           else "N"
         end as trtemfl length=1
  from sdtm.ae as a
  inner join adam.adsl as s
    on a.usubjid=s.usubjid;
quit;

proc sort data=adam.adsl(keep=usubjid ittfl saffl) out=work.prod_adsl_flags;
  by usubjid;
run;
proc sort data=qc.adsl_flags;
  by usubjid;
run;
proc compare base=work.prod_adsl_flags compare=qc.adsl_flags
             out=qc.compare_adsl outnoequal noprint;
  id usubjid;
run;

proc sort data=adam.adae(keep=usubjid aeseq trtemfl) out=work.prod_adae_flags;
  by usubjid aeseq;
run;
proc sort data=qc.adae_flags;
  by usubjid aeseq;
run;
proc compare base=work.prod_adae_flags compare=qc.adae_flags
             out=qc.compare_adae outnoequal noprint;
  id usubjid aeseq;
run;

/* Delivery inventory and a compact log-review checklist. */
data qc.delivery_checklist;
  length item $60 status $8 evidence $100;
  item="Raw data imported"; status="CHECK"; evidence="Setup verification log"; output;
  item="SDTM-style domains created"; status="CHECK"; evidence="DM AE EX VS"; output;
  item="ADaM-style datasets created"; status="CHECK"; evidence="ADSL ADAE"; output;
  item="TLF outputs generated"; status="CHECK"; evidence="HTML and RTF in output/tlf"; output;
  item="Production and QC compared"; status="CHECK"; evidence="COMPARE_ADSL and COMPARE_ADAE"; output;
  item="Logs reviewed"; status="CHECK"; evidence="No unexplained ERROR/WARNING/conversion"; output;
run;
proc print data=qc.delivery_checklist noobs;
run;

%put NOTE: Review PROC COMPARE output datasets. Zero observations means no unequal values.;
%put NOTE: Pinnacle 21 conformance checks do not replace independent programming QC.;
%put NOTE: DEFINE.XML documents metadata and derivations; it is not generated in this workshop.;

