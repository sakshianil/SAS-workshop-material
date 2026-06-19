%include "&project_root/shared/setup.sas";

/* XPT is a transport file. The setup program used this pattern to import DM. */
libname dmxpt xport "&project_root/source/cdisc/sdtm/dm.xpt";
proc contents data=dmxpt._all_ varnum;
run;
libname dmxpt clear;

/* Dataset-JSON exposes metadata and records through the JSON library engine. */
filename dmjson "&project_root/source/cdisc/sdtm/dm.json";
libname dmmeta json fileref=dmjson;
proc datasets library=dmmeta;
  contents data=_all_;
quit;
libname dmmeta clear;
filename dmjson clear;

data work.metadata_inventory;
  length layer $5 dataset $4 label $40 format $12
         metadata_version $24 records 8;
  layer="SDTM"; dataset="DM"; label="Demographics";
  format="XPT + JSON"; metadata_version="CDISC.SDTMIG.3.1.2";
  records=306; output;
  layer="SDTM"; dataset="AE"; label="Adverse Events";
  format="XPT + JSON"; metadata_version="CDISC.SDTMIG.3.1.2";
  records=1191; output;
  layer="ADAM"; dataset="ADSL"; label="Subject-Level Analysis";
  format="XPT + JSON"; metadata_version="CDISC.ADaM.2.1";
  records=254; output;
  layer="ADAM"; dataset="ADAE"; label="Adverse Events Analysis";
  format="XPT + JSON"; metadata_version="CDISC.ADaM.2.1";
  records=1191; output;
run;

proc print data=work.metadata_inventory noobs;
run;

proc contents data=sdtm.dm varnum;
run;
proc contents data=adam.adsl varnum;
run;
