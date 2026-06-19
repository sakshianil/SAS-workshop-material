%macro require_project_root;
  %if not %symexist(project_root) %then %do;
    %put ERROR: PROJECT_ROOT is not defined.;
    %put ERROR: Run setup/00_configure.sas first.;
    %abort cancel;
  %end;
%mend;
%require_project_root;

options mprint mlogic symbolgen validvarname=upcase;
libname sdtm "&project_root/data/sdtm";
libname adam "&project_root/data/adam";
libname derived "&project_root/data/derived";
libname qc "&project_root/data/qc";

%include "&project_root/shared/utility_macros.sas";

