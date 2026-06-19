/* Shared configuration. Run setup/00_create_folders.sas first each session. */
%macro require_project_root;
  %if not %symexist(project_root) %then %do;
    %put ERROR: PROJECT_ROOT is not defined.;
    %put ERROR: Run setup/00_create_folders.sas first.;
    %abort cancel;
  %end;
%mend;
%require_project_root;

options mprint mlogic symbolgen validvarname=upcase;
libname raw  "&project_root/data/sas_raw";
libname sdtm "&project_root/data/sdtm";
libname adam "&project_root/data/adam";
libname tlf  "&project_root/output/tlf";
libname qc   "&project_root/output/qc";

%include "&project_root/shared/formats.sas";
%include "&project_root/shared/utility_macros.sas";
