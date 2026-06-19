/* Run at the start of each SAS Studio session. */
%let project_root=/home/your-user-id/cdisc-pilot-mini-workshop;

options dlcreatedir;
libname _data "&project_root/data";
libname _sdtm "&project_root/data/sdtm";
libname _adam "&project_root/data/adam";
libname _derived "&project_root/data/derived";
libname _qc "&project_root/data/qc";
libname _output "&project_root/output";
libname _data clear;
libname _sdtm clear;
libname _adam clear;
libname _derived clear;
libname _qc clear;
libname _output clear;
options nodlcreatedir;

%include "&project_root/shared/setup.sas";
%put NOTE: CDISC PILOT PROJECT_ROOT=&project_root;

