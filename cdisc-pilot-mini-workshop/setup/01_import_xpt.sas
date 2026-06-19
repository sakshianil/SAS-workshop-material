%include "&project_root/shared/setup.sas";

%macro import_xpt(relative=, member=, out=);
  libname _xpt xport "&project_root/&relative";
  data &out;
    set _xpt.&member;
  run;
  libname _xpt clear;
%mend;

%import_xpt(relative=source/cdisc/sdtm/dm.xpt, member=DM, out=sdtm.dm);
%import_xpt(relative=source/cdisc/sdtm/ae.xpt, member=AE, out=sdtm.ae);
%import_xpt(relative=source/cdisc/adam/adsl.xpt, member=ADSL, out=adam.adsl);
%import_xpt(relative=source/cdisc/adam/adae.xpt, member=ADAE, out=adam.adae);

proc contents data=sdtm._all_ nods;
run;
proc contents data=adam._all_ nods;
run;

%put NOTE: XPT IMPORT FINISHED. REVIEW RECORD COUNTS AND THE LOG.;
