#!/usr/bin/env python3
"""Structural and source-data checks for the Clinical SAS workshop."""

from __future__ import annotations

import csv
import re
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
MODULES = [
    "00_sas_foundations",
    "01_raw_data_review",
    "02_specs_and_traceability",
    "03_sdtm_dm_ae",
    "04_sdtm_ex_vs",
    "05_adam_adsl",
    "06_adam_adae",
    "07_patient_listing",
    "08_demographics_table",
    "09_ae_summary_and_figure",
    "10_qc_and_delivery",
]
MODULE_FILES = [
    "README.md",
    "lesson.sas",
    "exercise.sas",
    "solution.sas",
    "check_your_work.sas",
]
RAW_SCHEMAS = {
    "demographics.csv": {
        "subject_id", "site_id", "screen_date", "rand_date", "treatment",
        "sex", "race", "ethnicity", "birth_date", "end_date", "end_reason",
    },
    "adverse_events.csv": {
        "subject_id", "ae_seq", "reported_term", "preferred_term", "soc",
        "start_date", "end_date", "severity", "serious", "related", "action",
    },
    "exposure.csv": {
        "subject_id", "ex_seq", "dose_date", "treatment", "dose_mg",
        "dose_status", "reason_not_dosed",
    },
    "vital_signs.csv": {
        "subject_id", "visit", "visit_num", "measure_date", "test_code",
        "test_name", "result", "unit", "position",
    },
}


def fail(message: str) -> None:
    print(f"FAIL: {message}")
    raise AssertionError(message)


def require_file(path: Path) -> None:
    if not path.is_file() or path.stat().st_size == 0:
        fail(f"missing or empty file: {path.relative_to(ROOT)}")


def read_csv(path: Path) -> list[dict[str, str]]:
    require_file(path)
    with path.open(newline="", encoding="utf-8") as handle:
        return list(csv.DictReader(handle))


def validate_structure() -> None:
    for relative in [
        "README.md",
        "START_HERE.md",
        "setup/00_create_folders.sas",
        "setup/01_import_raw_data.sas",
        "setup/02_verify_setup.sas",
        "setup/03_run_all_solutions.sas",
        "shared/setup.sas",
        "shared/formats.sas",
        "shared/utility_macros.sas",
        "metadata/study_protocol_summary.md",
        "metadata/mock_sap.md",
        "metadata/mapping_specifications.csv",
        "metadata/controlled_terminology.csv",
        "transcript_notes/TRANSCRIPT_GUIDE.md",
        "expected_outputs/README.md",
    ]:
        require_file(ROOT / relative)

    for module in MODULES:
        for filename in MODULE_FILES:
            require_file(ROOT / "modules" / module / filename)


def validate_source_data() -> None:
    loaded: dict[str, list[dict[str, str]]] = {}
    for filename, required_columns in RAW_SCHEMAS.items():
        rows = read_csv(ROOT / "data" / "raw" / filename)
        loaded[filename] = rows
        columns = set(rows[0]) if rows else set()
        if not required_columns.issubset(columns):
            fail(f"{filename} is missing columns {sorted(required_columns - columns)}")

    dm = loaded["demographics.csv"]
    if not 55 <= len(dm) <= 65:
        fail(f"demographics must contain approximately 60 subjects, found {len(dm)}")
    if len({row["subject_id"] for row in dm}) != len(dm):
        fail("demographics subject_id values must be unique")
    if not any(not row["rand_date"] for row in dm):
        fail("demographics must include screened but non-randomized subjects")
    if not {"Placebo", "Active"}.issubset({row["treatment"] for row in dm}):
        fail("demographics must include Active and Placebo arms")
    if not any(re.fullmatch(r"\d{4}-\d{2}", row["birth_date"] or "") for row in dm):
        fail("demographics must include a partial YYYY-MM birth date")

    ae = loaded["adverse_events.csv"]
    if len(ae) < 45:
        fail("adverse_events must contain at least 45 records")
    if not any(row["serious"].upper() == "Y" for row in ae):
        fail("adverse_events must include a serious event")
    if not {"MILD", "MODERATE", "SEVERE"}.issubset(
        {row["severity"].upper() for row in ae}
    ):
        fail("adverse_events must include mild, moderate, and severe events")

    ex = loaded["exposure.csv"]
    if len(ex) < 200:
        fail("exposure must contain repeated dosing records")
    if not any(row["dose_status"] == "NOT DOSED" for row in ex):
        fail("exposure must include missed doses")

    vs = loaded["vital_signs.csv"]
    if len(vs) < 300:
        fail("vital_signs must contain repeated measurements")
    if not {"BASELINE", "WEEK 2", "WEEK 4"}.issubset(
        {row["visit"].upper() for row in vs}
    ):
        fail("vital_signs must include baseline and post-baseline visits")


def validate_sas_programs() -> None:
    sas_files = list(ROOT.rglob("*.sas"))
    if len(sas_files) < 50:
        fail(f"expected at least 50 SAS programs, found {len(sas_files)}")
    standalone_programs = [
        path for path in sas_files
        if "shared" not in path.parts and path.name != "00_create_folders.sas"
    ]
    for path in sas_files:
        text = path.read_text(encoding="utf-8")
        if path in standalone_programs and "%include" not in text.lower():
            fail(f"{path.relative_to(ROOT)} must include shared setup or another program")
        if "\t" in text:
            fail(f"{path.relative_to(ROOT)} contains tab characters")


def main() -> int:
    try:
        validate_structure()
        validate_source_data()
        validate_sas_programs()
    except AssertionError:
        return 1
    print(
        f"PASS: {len(MODULES)} modules, {len(list(ROOT.rglob('*.sas')))} SAS programs, "
        "and all source-data scenarios validated."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
