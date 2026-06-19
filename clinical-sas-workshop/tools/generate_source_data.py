#!/usr/bin/env python3
"""Generate deterministic, wholly synthetic CSV inputs for the workshop."""

from __future__ import annotations

import csv
from datetime import date, timedelta
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "data" / "raw"


def write_csv(name: str, fieldnames: list[str], rows: list[dict[str, object]]) -> None:
    OUT.mkdir(parents=True, exist_ok=True)
    with (OUT / name).open("w", newline="", encoding="utf-8") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        writer.writerows(rows)


def iso(value: date | None) -> str:
    return value.isoformat() if value else ""


def demographics() -> list[dict[str, object]]:
    races = ["WHITE", "BLACK OR AFRICAN AMERICAN", "ASIAN", "Other"]
    rows = []
    for i in range(1, 61):
        subject = f"101-{i:03d}"
        screen = date(2025, 1, 2) + timedelta(days=i - 1)
        screen_failure = i in {7, 19, 33, 48}
        randomized = not screen_failure
        rand = screen + timedelta(days=2) if randomized else None
        treatment = "" if screen_failure else ("Active" if i % 2 == 0 else "Placebo")
        discontinued = i in {11, 22, 37, 52}
        end = (
            rand + timedelta(days=18 + i % 8)
            if discontinued and rand
            else (rand + timedelta(days=28) if rand else screen + timedelta(days=3))
        )
        birth = f"{1960 + (i * 7) % 38}-{(i % 12) + 1:02d}-{(i % 27) + 1:02d}"
        if i in {5, 26}:
            birth = birth[:7]
        if i == 41:
            birth = "1978"
        rows.append(
            {
                "subject_id": subject,
                "site_id": 101 + (i - 1) // 15,
                "screen_date": iso(screen),
                "rand_date": iso(rand),
                "treatment": treatment,
                "sex": "F" if i % 3 else "M",
                "race": races[i % len(races)],
                "ethnicity": "HISPANIC OR LATINO" if i % 9 == 0 else "NOT HISPANIC OR LATINO",
                "birth_date": birth,
                "end_date": iso(end),
                "end_reason": (
                    "SCREEN FAILURE"
                    if screen_failure
                    else ("ADVERSE EVENT" if discontinued else "COMPLETED")
                ),
            }
        )
    return rows


def adverse_events() -> list[dict[str, object]]:
    dictionary = [
        ("Head ache", "HEADACHE", "NERVOUS SYSTEM DISORDERS"),
        ("Nausea", "NAUSEA", "GASTROINTESTINAL DISORDERS"),
        ("Dizzy", "DIZZINESS", "NERVOUS SYSTEM DISORDERS"),
        ("Tiredness", "FATIGUE", "GENERAL DISORDERS"),
        ("High BP", "HYPERTENSION", "VASCULAR DISORDERS"),
        ("Rash", "RASH", "SKIN DISORDERS"),
        ("Fever", "PYREXIA", "GENERAL DISORDERS"),
    ]
    rows = []
    seq_by_subject: dict[str, int] = {}
    event_number = 0
    for i in range(1, 61):
        if i in {7, 19, 33, 48}:
            continue
        rand = date(2025, 1, 2) + timedelta(days=i - 1 + 2)
        count = 1 + (i % 3 == 0)
        for j in range(count):
            event_number += 1
            subject = f"101-{i:03d}"
            seq_by_subject[subject] = seq_by_subject.get(subject, 0) + 1
            reported, preferred, soc = dictionary[(i + j) % len(dictionary)]
            # Selected events begin before first dose to teach treatment-emergent logic.
            offset = -2 if i in {10, 24, 44} and j == 0 else 2 + ((i + j * 3) % 20)
            start = rand + timedelta(days=offset)
            ongoing = i in {14, 28} and j == 0
            severity = ["Mild", "MODERATE", "severe"][(i + j) % 3]
            serious = "Y" if i in {22, 37, 52} and j == 0 else "N"
            rows.append(
                {
                    "subject_id": subject,
                    "ae_seq": seq_by_subject[subject],
                    "reported_term": reported,
                    "preferred_term": preferred,
                    "soc": soc,
                    "start_date": iso(start),
                    "end_date": "" if ongoing else iso(start + timedelta(days=2 + i % 6)),
                    "severity": severity,
                    "serious": serious,
                    "related": "RELATED" if i % 4 == 0 else "NOT RELATED",
                    "action": "DRUG WITHDRAWN" if serious == "Y" else "NONE",
                }
            )
    return rows


def exposure() -> list[dict[str, object]]:
    rows = []
    for i in range(1, 61):
        if i in {7, 19, 33, 48}:
            continue
        subject = f"101-{i:03d}"
        rand = date(2025, 1, 2) + timedelta(days=i - 1 + 2)
        treatment = "Active" if i % 2 == 0 else "Placebo"
        last_day = 18 + i % 8 if i in {11, 22, 37, 52} else 28
        for seq, study_day in enumerate(range(1, last_day + 1, 7), start=1):
            missed = (i + study_day) % 17 == 0
            rows.append(
                {
                    "subject_id": subject,
                    "ex_seq": seq,
                    "dose_date": iso(rand + timedelta(days=study_day - 1)),
                    "treatment": treatment,
                    "dose_mg": 0 if treatment == "Placebo" or missed else 100,
                    "dose_status": "NOT DOSED" if missed else "DOSED",
                    "reason_not_dosed": "SUBJECT FORGOT" if missed else "",
                }
            )
    return rows


def vital_signs() -> list[dict[str, object]]:
    rows = []
    tests = [
        ("SYSBP", "Systolic Blood Pressure", "mmHg", 122),
        ("DIABP", "Diastolic Blood Pressure", "mmHg", 78),
        ("PULSE", "Pulse Rate", "beats/min", 72),
    ]
    visits = [("BASELINE", 0, 0), ("WEEK 2", 2, 14), ("WEEK 4", 4, 28)]
    for i in range(1, 61):
        if i in {7, 19, 33, 48}:
            continue
        subject = f"101-{i:03d}"
        rand = date(2025, 1, 2) + timedelta(days=i - 1 + 2)
        treatment = "Active" if i % 2 == 0 else "Placebo"
        for visit, visit_num, day_offset in visits:
            if i in {11, 22, 37, 52} and visit == "WEEK 4":
                continue
            for test_code, test_name, unit, base in tests:
                effect = -4 if treatment == "Active" and visit != "BASELINE" and test_code == "SYSBP" else 0
                value = base + (i % 9) - 4 + effect + visit_num
                rows.append(
                    {
                        "subject_id": subject,
                        "visit": visit,
                        "visit_num": visit_num,
                        "measure_date": iso(rand + timedelta(days=day_offset)),
                        "test_code": test_code,
                        "test_name": test_name,
                        "result": value,
                        "unit": unit,
                        "position": "SITTING" if i % 10 else "Seated",
                    }
                )
    return rows


def main() -> None:
    datasets = [
        ("demographics.csv", demographics()),
        ("adverse_events.csv", adverse_events()),
        ("exposure.csv", exposure()),
        ("vital_signs.csv", vital_signs()),
    ]
    for name, rows in datasets:
        write_csv(name, list(rows[0]), rows)
        print(f"Wrote {name}: {len(rows)} rows")


if __name__ == "__main__":
    main()
