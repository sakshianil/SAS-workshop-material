%include "&project_root/shared/setup.sas";

/* Recreate TRTEMFL, AOCCFL, AOCCSFL, and AOCCPFL without reading the submitted
   versions as inputs.

   Hints:
   - TRTEMFL uses ASTDT and TRTSDT.
   - Sort treatment-emergent rows by subject/date for AOCCFL.
   - Add AEBODSYS for AOCCSFL.
   - Add AEBODSYS and AEDECOD for AOCCPFL.
   - Merge the one-row flag datasets back by USUBJID and AESEQ. */

data work.flag_base;
  set adam.adae;
  /* Derive TRTEMFL_CALC and keep required ordering variables. */
run;

/* Create WORK.ANY_FLAG, WORK.SOC_FLAG, WORK.PT_FLAG. */

data derived.adae_flags;
  /* Merge the base and three flag datasets. */
run;

