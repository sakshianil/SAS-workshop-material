#!/usr/bin/env python3
"""Validate the compact CDISC SDTM/ADaM pilot workshop."""

from __future__ import annotations

import hashlib
import json
import re
import sys
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

SOURCE_FILES = {
    "source/cdisc/sdtm/dm.xpt": "7327baea97fd532d02385248da0c7240402e770099507e2c3a88e2ac706c02a6",
    "source/cdisc/sdtm/ae.xpt": "05cf23dadadf1b6a11f4474c76724f870de389ba6a4312c825b30e299cb1e4d9",
    "source/cdisc/adam/adsl.xpt": "c5139f873a93ef6add77bc4297beb6460a398bbdd036874382a9f39dfc92091d",
    "source/cdisc/adam/adae.xpt": "b8678e70946473a753bb01d002917f478bf51b59bdd0dc19587b97128059b6a0",
}

JSON_EXPECTATIONS = {
    "source/cdisc/sdtm/dm.json": ("DM", 306, "CDISC.SDTMIG.3.1.2"),
    "source/cdisc/sdtm/ae.json": ("AE", 1191, "CDISC.SDTMIG.3.1.2"),
    "source/cdisc/adam/adsl.json": ("ADSL", 254, "CDISC.ADaM.2.1"),
    "source/cdisc/adam/adae.json": ("ADAE", 1191, "CDISC.ADaM.2.1"),
}

LABS = [
    "01_submission_anatomy",
    "02_dm_to_adsl",
    "03_ae_to_adae",
    "04_occurrence_flags",
    "05_serious_ae_table_qc",
]


def fail(message: str) -> None:
    raise AssertionError(message)


def require(relative: str) -> Path:
    path = ROOT / relative
    if not path.is_file() or path.stat().st_size == 0:
        fail(f"missing or empty file: {relative}")
    return path


def sha256(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for block in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def validate_structure() -> None:
    for relative in [
        "README.md",
        "START_HERE.md",
        "ATTRIBUTION_AND_TERMS.md",
        "TROUBLESHOOTING.md",
        "SOURCE_MANIFEST.sha256",
        "setup/00_configure.sas",
        "setup/01_import_xpt.sas",
        "setup/02_verify_import.sas",
        "setup/03_run_all_solutions.sas",
        "setup/04_verify_source_files.sas",
        "shared/setup.sas",
        "shared/utility_macros.sas",
        "reference_programs/adae_original.sas",
        "reference_programs/at14-5-02_original.sas",
        "reference_docs/CDISC_REPOSITORY_README.md",
        "reference_docs/CDISC.Pilot Project Data.Website Disclaimer.v1.pdf",
        "source/cdisc/sdtm/define.xml",
        "source/cdisc/adam/define.xml",
    ]:
        require(relative)
    for lab in LABS:
        for filename in [
            "README.md",
            "lesson.sas",
            "exercise.sas",
            "solution.sas",
            "check_your_work.sas",
        ]:
            require(f"labs/{lab}/{filename}")


def validate_source_integrity() -> None:
    manifest = require("SOURCE_MANIFEST.sha256").read_text(encoding="utf-8")
    manifest_entries = {}
    for line in manifest.splitlines():
        if not line.strip():
            continue
        expected, relative = line.split(maxsplit=1)
        manifest_entries[relative] = expected
    for relative, expected in manifest_entries.items():
        actual = sha256(require(relative))
        if actual != expected:
            fail(f"manifest hash mismatch: {relative} ({actual})")

    for relative, expected in SOURCE_FILES.items():
        actual = sha256(require(relative))
        if actual != expected:
            fail(f"CDISC source changed: {relative} ({actual})")

    for relative, (name, records, metadata_version) in JSON_EXPECTATIONS.items():
        payload = json.loads(require(relative).read_text(encoding="utf-8"))
        if payload.get("name") != name:
            fail(f"{relative} name must be {name}")
        if payload.get("records") != records:
            fail(f"{relative} records must be {records}")
        if payload.get("metaDataVersionOID") != metadata_version:
            fail(f"{relative} metadata version must be {metadata_version}")
        if payload.get("metaDataRef") != "define.xml":
            fail(f"{relative} must reference define.xml")


def json_records(relative: str) -> list[dict[str, object]]:
    payload = json.loads(require(relative).read_text(encoding="utf-8"))
    columns = [column["name"] for column in payload["columns"]]
    return [dict(zip(columns, row)) for row in payload["rows"]]


def validate_reference_lineage() -> None:
    dm = json_records("source/cdisc/sdtm/dm.json")
    ae = json_records("source/cdisc/sdtm/ae.json")
    adsl = json_records("source/cdisc/adam/adsl.json")
    adae = json_records("source/cdisc/adam/adae.json")

    dm_keys = {(row["STUDYID"], row["USUBJID"]) for row in dm}
    adsl_keys = {(row["STUDYID"], row["USUBJID"]) for row in adsl}
    if len(dm_keys) != 306 or len(adsl_keys) != 254:
        fail("DM/ADSL subject keys are not unique")
    if len(dm_keys & adsl_keys) != 254:
        fail("expected all 254 ADSL subjects to trace to DM")

    ae_keys = {(row["STUDYID"], row["USUBJID"], row["AESEQ"]) for row in ae}
    adae_keys = {
        (row["STUDYID"], row["USUBJID"], row["AESEQ"]) for row in adae
    }
    if ae_keys != adae_keys or len(ae_keys) != 1191:
        fail("expected a one-to-one 1,191-record AE-to-ADAE lineage")

    for row in adae:
        expected = (
            "Y"
            if row["ASTDT"] and row["TRTSDT"] and row["ASTDT"] >= row["TRTSDT"]
            else "N"
        )
        if row["TRTEMFL"] != expected:
            fail(f"TRTEMFL derivation mismatch for {row['USUBJID']} AESEQ={row['AESEQ']}")

    treatment_emergent = [row for row in adae if row["TRTEMFL"] == "Y"]
    expected_any = set()
    expected_soc = set()
    expected_pt = set()
    grouped_any: dict[tuple[object, ...], list[dict[str, object]]] = defaultdict(list)
    grouped_soc: dict[tuple[object, ...], list[dict[str, object]]] = defaultdict(list)
    grouped_pt: dict[tuple[object, ...], list[dict[str, object]]] = defaultdict(list)
    for row in treatment_emergent:
        grouped_any[(row["USUBJID"],)].append(row)
        if row["AEBODSYS"]:
            grouped_soc[(row["USUBJID"], row["AEBODSYS"])].append(row)
        if row["AEDECOD"]:
            grouped_pt[
                (row["USUBJID"], row["AEBODSYS"], row["AEDECOD"])
            ].append(row)

    def first_keys(groups: dict[tuple[object, ...], list[dict[str, object]]]) -> set:
        result = set()
        for rows in groups.values():
            first = min(rows, key=lambda row: (row["ASTDT"], row["AESEQ"]))
            result.add((first["USUBJID"], first["AESEQ"]))
        return result

    expected_any = first_keys(grouped_any)
    expected_soc = first_keys(grouped_soc)
    expected_pt = first_keys(grouped_pt)
    for row in adae:
        key = (row["USUBJID"], row["AESEQ"])
        expected_flags = {
            "AOCCFL": "Y" if key in expected_any else "",
            "AOCCSFL": "Y" if key in expected_soc else "",
            "AOCCPFL": "Y" if key in expected_pt else "",
        }
        for variable, expected in expected_flags.items():
            if row[variable] != expected:
                fail(f"{variable} mismatch for {row['USUBJID']} AESEQ={row['AESEQ']}")

    serious = [
        row
        for row in adae
        if row["SAFFL"] == "Y" and row["TRTEMFL"] == "Y" and row["AESER"] == "Y"
    ]
    if len(serious) != 3 or len({row["USUBJID"] for row in serious}) != 3:
        fail("expected three serious treatment-emergent events in three subjects")
    for groups, flag in [
        (["TRTAN"], "AOCC02FL"),
        (["TRTAN", "AEBODSYS"], "AOCC03FL"),
        (["TRTAN", "AEBODSYS", "AEDECOD"], "AOCC04FL"),
    ]:
        buckets = defaultdict(list)
        for row in serious:
            buckets[tuple(row[name] for name in groups)].append(row)
        for rows in buckets.values():
            distinct_subjects = len({row["USUBJID"] for row in rows})
            flag_sum = sum(row[flag] == "Y" for row in rows)
            if distinct_subjects != flag_sum:
                fail(f"serious-event QC flag {flag} does not reproduce subject counts")


def validate_learning_programs() -> None:
    sas_files = list(ROOT.rglob("*.sas"))
    if len(sas_files) < 29:
        fail(f"expected at least 29 SAS programs, found {len(sas_files)}")
    for path in sas_files:
        text = path.read_text(encoding="utf-8", errors="replace")
        if path.parts[-2] in {"reference_programs", "shared"}:
            continue
        if path.name != "00_configure.sas" and "%include" not in text.lower():
            fail(f"{path.relative_to(ROOT)} must include shared setup or another program")
        if "\t" in text:
            fail(f"{path.relative_to(ROOT)} contains tab characters")

    combined = "\n".join(
        (ROOT / "labs" / lab / "lesson.sas").read_text(encoding="utf-8")
        for lab in LABS
    ).upper()
    for concept in [
        "LIBNAME",
        "XPORT",
        "TRTEMFL",
        "AOCCFL",
        "AOCCSFL",
        "AOCCPFL",
        "COUNT(DISTINCT USUBJID)",
        "PROC COMPARE",
    ]:
        if concept not in combined:
            fail(f"lessons do not demonstrate required concept: {concept}")


def validate_attribution() -> None:
    text = require("ATTRIBUTION_AND_TERMS.md").read_text(encoding="utf-8")
    for phrase in [
        "CDISC",
        "sdtm-adam-pilot-project",
        "https://github.com/cdisc-org/sdtm-adam-pilot-project",
        "AS IS",
        "attribution",
    ]:
        if phrase.lower() not in text.lower():
            fail(f"attribution file must include {phrase}")
    if re.search(r"submission[- ]ready", text, re.I):
        fail("attribution must not describe the workshop as submission-ready")


def main() -> int:
    try:
        validate_structure()
        validate_source_integrity()
        validate_reference_lineage()
        validate_learning_programs()
        validate_attribution()
    except (AssertionError, json.JSONDecodeError) as exc:
        print(f"FAIL: {exc}")
        return 1
    print(
        f"PASS: {len(LABS)} labs, {len(list(ROOT.rglob('*.sas')))} SAS programs, "
        "and all selected CDISC source hashes/metadata validated."
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
