# Lab 04 — Treatment-Emergent and First-Occurrence Flags

**Time:** 75 minutes  
**Work product:** `DERIVED.ADAE_FLAGS`

Reproduce four important ADAE variables from the reference program:

- `TRTEMFL`: event began on or after treatment start.
- `AOCCFL`: first treatment-emergent AE for a subject.
- `AOCCSFL`: first treatment-emergent AE within a system organ class.
- `AOCCPFL`: first treatment-emergent AE within SOC and preferred term.

First-occurrence flags allow report programs to sum flags rather than repeatedly
deduplicate subjects. The check compares your recreated flags with the
published ADAE flags.

