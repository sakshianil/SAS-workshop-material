%include "&project_root/shared/setup.sas";

data sdtm.dm(label="Demographics");
  length studyid $7 domain $2 usubjid $15 subjid $7 siteid $3
         rfstdtc rfendtc $10 sex $1 race $40 ethnic $30 armcd $8 arm $20;
  set raw.demographics;
  studyid="AOM-301";
  domain="DM";
  subjid=subject_id;
  usubjid=catx("-",studyid,subjid);
  siteid=put(site_id,3.);
  rfstdtc=rand_date;
  rfendtc=end_date;
  sex=upcase(sex);
  race=upcase(race);
  if race="OTHER" then race="OTHER";
  ethnic=upcase(ethnicity);
  if treatment="Active" then do; armcd="ACTIVE"; arm="Active 100 mg"; end;
  else if treatment="Placebo" then do; armcd="PBO"; arm="Placebo"; end;
  else do; armcd="SCRNFAIL"; arm="Screen Failure"; end;
  keep studyid domain usubjid subjid siteid rfstdtc rfendtc sex race
       ethnic armcd arm;
run;
proc sort data=sdtm.dm;
  by studyid usubjid;
run;

data sdtm.ae(label="Adverse Events");
  length studyid $7 domain $2 usubjid $15 aeterm $40 aedecod $40
         aebodsys $40 aesev $8 aeser $1 aerel $12 aeacn $20
         aestdtc aeendtc $10;
  set raw.adverse_events;
  studyid="AOM-301";
  domain="AE";
  usubjid=catx("-",studyid,subject_id);
  aeseq=ae_seq;
  aeterm=reported_term;
  aedecod=upcase(preferred_term);
  aebodsys=upcase(soc);
  aesev=upcase(severity);
  aeser=upcase(serious);
  aerel=upcase(related);
  aeacn=upcase(action);
  aestdtc=start_date;
  aeendtc=end_date;
  keep studyid domain usubjid aeseq aeterm aedecod aebodsys aesev
       aeser aerel aeacn aestdtc aeendtc;
run;
proc sort data=sdtm.ae;
  by studyid usubjid aeseq;
run;

proc freq data=sdtm.ae;
  tables aesev aeser / missing;
run;

