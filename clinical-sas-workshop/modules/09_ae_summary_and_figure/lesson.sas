%include "&project_root/shared/setup.sas";

/* Subject-level incidence: deduplicate before counting. */
proc sort data=adam.adae(
    where=(saffl="Y" and trtemfl="Y")
    keep=usubjid trt01a aebodsys aedecod aeser)
    out=work.teae_unique nodupkey;
  by trt01a usubjid aebodsys aedecod;
run;

proc sql;
  create table work.denominators as
  select trt01a, count(*) as denominator
  from adam.adsl
  where saffl="Y"
  group by trt01a;

  create table work.soc_pt_counts as
  select trt01a, aebodsys, aedecod, count(distinct usubjid) as subjects
  from work.teae_unique
  group by trt01a, aebodsys, aedecod;

  create table work.any_teae as
  select trt01a, count(distinct usubjid) as subjects
  from work.teae_unique
  group by trt01a;
quit;

data work.teae_summary;
  merge work.any_teae work.denominators;
  by trt01a;
  percent=100*subjects/denominator;
  display=cats(subjects," (",put(percent,5.1),"%)");
run;

/* Create ADVS-like working data for the Week 2/Week 4 figure. */
proc sort data=sdtm.vs(where=(vstestcd="SYSBP")) out=work.sysbp;
  by usubjid visitnum;
run;
proc transpose data=work.sysbp(where=(visitnum=0))
               out=work.baseline(drop=_name_) prefix=base_;
  by usubjid;
  id vstestcd;
  var vsstresn;
run;
proc sort data=adam.adsl(keep=usubjid trt01a saffl) out=work.adsl_v;
  by usubjid;
run;
data work.advs;
  merge work.sysbp(in=invs) work.baseline work.adsl_v;
  by usubjid;
  if invs and saffl="Y";
  base=base_sysbp;
  chg=vsstresn-base;
run;

proc means data=work.advs(where=(visitnum>0)) noprint;
  class trt01a visitnum visit;
  var chg;
  output out=work.vs_mean(where=(_type_=7)) mean=mean_change;
run;

ods html path="&project_root/output/tlf" file="table_14_3_1_and_figure.html";
%report_header(title=Table 14.3.1 - Treatment-Emergent Adverse Events);
proc print data=work.teae_summary noobs;
  var trt01a subjects denominator percent display;
run;
title "Figure 14.2.1 - Mean Systolic BP Change from Baseline";
proc sgplot data=work.vs_mean;
  series x=visitnum y=mean_change / group=trt01a markers;
  xaxis values=(2 4) label="Visit";
  yaxis label="Mean change from baseline (mmHg)";
run;
ods html close;
title;
footnote;

