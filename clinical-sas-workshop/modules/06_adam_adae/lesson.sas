%include "&project_root/shared/setup.sas";

proc sort data=sdtm.ae out=work.ae;
  by usubjid;
run;
proc sort data=adam.adsl(keep=usubjid trt01p trt01a trtsdt trtedt saffl)
          out=work.adsl;
  by usubjid;
run;

data adam.adae(label="Adverse Event Analysis Dataset");
  length trtemfl $1 aesevn 8;
  merge work.ae(in=inae) work.adsl(in=inadsl);
  by usubjid;
  if inae and inadsl;

  astdt=input(aestdtc,yymmdd10.);
  aendt=input(aeendtc,yymmdd10.);
  format astdt aendt trtsdt trtedt date9.;
  if not missing(astdt) then do;
    if astdt >= trtsdt then astdy=astdt-trtsdt+1;
    else astdy=astdt-trtsdt;
  end;
  if not missing(aendt) and not missing(astdt) then adurn=aendt-astdt+1;
  trtemfl=ifc(not missing(astdt) and astdt>=trtsdt and astdt<=trtedt,"Y","N");
  select (aesev);
    when ("MILD") aesevn=1;
    when ("MODERATE") aesevn=2;
    when ("SEVERE") aesevn=3;
    otherwise aesevn=.;
  end;
run;
proc sort data=adam.adae;
  by usubjid aeseq;
run;

proc freq data=adam.adae;
  tables trtemfl*aesev / missing;
run;

