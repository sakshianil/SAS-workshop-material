%include "&project_root/shared/setup.sas";

/* Recalculate treatment-emergent status without using the submitted flag. */
data work.flag_base;
  set adam.adae;
  length trtemfl_calc $1;
  if not missing(astdt) and not missing(trtsdt) and astdt>=trtsdt
    then trtemfl_calc="Y";
  else trtemfl_calc="N";
  keep studyid usubjid aeseq astdt trtsdt aebodsys aedecod trtemfl_calc;
run;

proc sort data=work.flag_base(where=(trtemfl_calc="Y"))
          out=work.any_sorted;
  by usubjid astdt aeseq;
run;
data work.any_flag(keep=usubjid aeseq aoccfl_calc);
  set work.any_sorted;
  by usubjid astdt aeseq;
  length aoccfl_calc $1;
  if first.usubjid then do;
    aoccfl_calc="Y";
    output;
  end;
run;

proc sort data=work.flag_base(
    where=(trtemfl_calc="Y" and not missing(aebodsys)))
    out=work.soc_sorted;
  by usubjid aebodsys astdt aeseq;
run;
data work.soc_flag(keep=usubjid aeseq aoccsfl_calc);
  set work.soc_sorted;
  by usubjid aebodsys astdt aeseq;
  length aoccsfl_calc $1;
  if first.aebodsys then do;
    aoccsfl_calc="Y";
    output;
  end;
run;

proc sort data=work.flag_base(
    where=(trtemfl_calc="Y" and not missing(aedecod)))
    out=work.pt_sorted;
  by usubjid aebodsys aedecod astdt aeseq;
run;
data work.pt_flag(keep=usubjid aeseq aoccpfl_calc);
  set work.pt_sorted;
  by usubjid aebodsys aedecod astdt aeseq;
  length aoccpfl_calc $1;
  if first.aedecod then do;
    aoccpfl_calc="Y";
    output;
  end;
run;

proc sort data=work.flag_base;
  by usubjid aeseq;
run;
proc sort data=work.any_flag;
  by usubjid aeseq;
run;
proc sort data=work.soc_flag;
  by usubjid aeseq;
run;
proc sort data=work.pt_flag;
  by usubjid aeseq;
run;

data derived.adae_flags;
  merge work.flag_base work.any_flag work.soc_flag work.pt_flag;
  by usubjid aeseq;
  if missing(aoccfl_calc) then aoccfl_calc="";
  if missing(aoccsfl_calc) then aoccsfl_calc="";
  if missing(aoccpfl_calc) then aoccpfl_calc="";
run;

proc sort data=adam.adae(
    keep=usubjid aeseq trtemfl aoccfl aoccsfl aoccpfl)
    out=work.submitted_flags;
  by usubjid aeseq;
run;

data work.calculated_flags;
  set derived.adae_flags;
  trtemfl=trtemfl_calc;
  aoccfl=aoccfl_calc;
  aoccsfl=aoccsfl_calc;
  aoccpfl=aoccpfl_calc;
  keep usubjid aeseq trtemfl aoccfl aoccsfl aoccpfl;
run;

proc compare base=work.submitted_flags compare=work.calculated_flags
             out=qc.compare_occurrence_flags outnoequal;
  id usubjid aeseq;
run;

