# Contributing

Contributions that improve correctness, teachability, portability, or
traceability are welcome.

## Before proposing a change

1. Keep the two learning tracks distinct:
   - synthetic beginner workflow;
   - unchanged CDISC reference artifacts with workshop-authored labs.
2. Do not modify files covered by
   `cdisc-pilot-mini-workshop/SOURCE_MANIFEST.sha256`.
3. Do not add real patient data, proprietary sponsor materials, licensed
   standards text, or copied training transcripts.
4. Keep SAS programs compatible with SAS OnDemand for Academics where possible.
5. Explain the clinical purpose of a programming technique, not only its syntax.

## Lesson convention

Every new lesson should normally include:

- `README.md`
- `lesson.sas`
- `exercise.sas`
- `check_your_work.sas`
- `solution.sas`

Exercises should be achievable using concepts introduced earlier. Checks should
test concrete outputs such as dataset existence, observation counts, required
variables, derivation flags, or independent comparison results.

## Validation

Run:

```bash
python3 tests/validate_repository.py
```

For SAS changes, also run the affected lesson and its check in SAS Studio.
Review the complete log for errors, warnings, implicit conversions,
uninitialized variables, and unexpected row counts.

## Pull requests

Describe:

- the learner problem being addressed;
- the clinical-programming behavior that changed;
- the datasets or outputs affected;
- how the change was validated;
- whether any expected count or screenshot changed.

