/* Run this at the start of every SAS Studio session. */
%let project_root=/home/your-user-id/clinical-sas-workshop;

/* Create output folders if they do not already exist. */
options dlcreatedir;
libname _mk1 "&project_root/data/sas_raw";
libname _mk2 "&project_root/data/sdtm";
libname _mk3 "&project_root/data/adam";
libname _out "&project_root/output";
libname _mk4 "&project_root/output/tlf";
libname _mk5 "&project_root/output/qc";
libname _mk1 clear;
libname _mk2 clear;
libname _mk3 clear;
libname _out clear;
libname _mk4 clear;
libname _mk5 clear;
options nodlcreatedir;

%include "&project_root/shared/setup.sas";

%put NOTE: PROJECT_ROOT=&project_root;
%put NOTE: Workshop folders and libraries are ready.;
