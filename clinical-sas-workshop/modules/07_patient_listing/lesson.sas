%include "&project_root/shared/setup.sas";

data work.population_listing;
  set adam.adsl;
  where ittfl="Y";
  label usubjid="Unique Subject ID"
        trt01p="Planned Treatment"
        age="Age"
        sex="Sex"
        randdt="Randomization"
        ittfl="ITT"
        saffl="Safety"
        eosstt="End of Study Status";
run;

ods html path="&project_root/output/tlf" file="listing_16_1_1.html";
ods rtf file="&project_root/output/tlf/listing_16_1_1.rtf" style=journal;
%report_header(title=Listing 16.1.1 - Analysis Populations);
proc report data=work.population_listing nowd split="|";
  columns usubjid trt01p age sex randdt ittfl saffl eosstt;
  define usubjid / display;
  define trt01p / display;
  define age / display;
  define sex / display;
  define randdt / display format=date9.;
  define ittfl / display;
  define saffl / display;
  define eosstt / display;
run;
ods rtf close;
ods html close;
title;
footnote;

