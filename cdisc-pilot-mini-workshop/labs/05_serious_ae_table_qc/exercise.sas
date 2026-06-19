%include "&project_root/shared/setup.sas";

/* Build a serious TEAE table.

   Production method:
   1. Derive safety denominators by TRT01AN from ADSL.
   2. Filter ADAE to SAFFL=Y, TRTEMFL=Y, AESER=Y.
   3. Count distinct subjects and all events at Any, SOC, and SOC/PT levels.

   Independent QC method:
   4. Sum AOCC02FL, AOCC03FL, and AOCC04FL for subject counts.
   5. Compare production and QC counts using PROC COMPARE. */

proc sql;
  /* Create denominators and the three production summary levels. */
quit;

data derived.serious_ae_table;
  /* Stack summary levels and derive percentage/display. */
run;

proc sql;
  /* Create independent QC summaries from first-occurrence flags. */
quit;

proc compare;
  /* Compare counts using the full row key. */
run;

