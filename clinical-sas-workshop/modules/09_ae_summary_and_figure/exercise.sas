%include "&project_root/shared/setup.sas";

/* 1. Deduplicate TEAEs by treatment, subject, SOC, and preferred term.
   2. Count distinct subjects by SOC/PT.
   3. Derive SYSBP baseline and change for post-baseline visits.
   4. Plot mean change by visit and treatment. */

proc sort data=adam.adae out=work.teae_unique nodupkey;
  /* Add WHERE, KEEP, and BY logic. */
run;

proc sql;
  /* Create WORK.SOC_PT_COUNTS. */
quit;

data work.advs;
  /* Merge baseline, post-baseline VS, and ADSL. */
run;

