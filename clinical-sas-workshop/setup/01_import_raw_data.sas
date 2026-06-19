%include "&project_root/shared/setup.sas";

%macro import_csv(file=, out=);
  proc import datafile="&project_root/data/raw/&file..csv"
    out=raw.&out dbms=csv replace;
    guessingrows=max;
    getnames=yes;
  run;
%mend;

%import_csv(file=demographics, out=demographics);
%import_csv(file=adverse_events, out=adverse_events);
%import_csv(file=exposure, out=exposure);
%import_csv(file=vital_signs, out=vital_signs);

proc contents data=raw._all_ nods;
run;

%put NOTE: RAW IMPORT COMPLETE. Review the log before continuing.;

