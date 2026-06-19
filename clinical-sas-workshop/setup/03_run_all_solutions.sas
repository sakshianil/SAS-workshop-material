%include "&project_root/shared/setup.sas";

/* Optional end-to-end smoke run after setup/import succeeds.
   This intentionally runs completed lessons, not learner exercises. */
%include "&project_root/modules/00_sas_foundations/solution.sas";
%include "&project_root/modules/01_raw_data_review/solution.sas";
%include "&project_root/modules/02_specs_and_traceability/solution.sas";
%include "&project_root/modules/03_sdtm_dm_ae/solution.sas";
%include "&project_root/modules/04_sdtm_ex_vs/solution.sas";
%include "&project_root/modules/05_adam_adsl/solution.sas";
%include "&project_root/modules/06_adam_adae/solution.sas";
%include "&project_root/modules/07_patient_listing/solution.sas";
%include "&project_root/modules/08_demographics_table/solution.sas";
%include "&project_root/modules/09_ae_summary_and_figure/solution.sas";
%include "&project_root/modules/10_qc_and_delivery/solution.sas";

%put NOTE: END-TO-END SOLUTION RUN FINISHED. REVIEW THE COMPLETE LOG.;

