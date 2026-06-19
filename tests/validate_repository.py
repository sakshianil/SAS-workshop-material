#!/usr/bin/env python3
"""Publication checks for the SAS Clinical Programming Workshop repository."""

from __future__ import annotations

import subprocess
import sys
from urllib.parse import unquote
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]

REQUIRED_FILES = [
    "README.md",
    "LICENSE",
    "LICENSES.md",
    "CONTRIBUTING.md",
    "CITATION.cff",
    "docs/LEARNING_PATH.md",
    "docs/CLINICAL_PROGRAMMING_PIPELINE.md",
    "docs/RESOURCES.md",
    ".github/workflows/validate.yml",
    "clinical-sas-workshop/README.md",
    "clinical-sas-workshop/START_HERE.md",
    "cdisc-pilot-mini-workshop/README.md",
    "cdisc-pilot-mini-workshop/START_HERE.md",
]

REQUIRED_README_PHRASES = [
    "SAS OnDemand for Academics",
    "clinical-sas-workshop",
    "cdisc-pilot-mini-workshop",
    "Raw clinical data",
    "SDTM",
    "ADaM",
    "tables, listings, and figures",
    "Educational",
]

FORBIDDEN_NAMES = {".DS_Store"}


def fail(message: str) -> None:
    raise AssertionError(message)


def require_file(relative: str) -> Path:
    path = ROOT / relative
    if not path.is_file() or path.stat().st_size == 0:
        fail(f"missing or empty publication file: {relative}")
    return path


def validate_structure() -> None:
    for relative in REQUIRED_FILES:
        require_file(relative)

    readme = require_file("README.md").read_text(encoding="utf-8")
    for phrase in REQUIRED_README_PHRASES:
        if phrase.lower() not in readme.lower():
            fail(f"root README must explain: {phrase}")

    for path in ROOT.rglob("*"):
        if ".git" in path.parts:
            continue
        if path.name in FORBIDDEN_NAMES:
            fail(f"OS-generated file must not be published: {path.relative_to(ROOT)}")
        if path.is_file() and path.suffix.lower() == ".zip":
            fail(f"duplicate ZIP must not be committed: {path.relative_to(ROOT)}")
        if path.is_file() and path.name.startswith("www.youtube.com_watch"):
            fail(f"raw transcript export must not be committed: {path.relative_to(ROOT)}")


def validate_local_markdown_links() -> None:
    link_pattern = re.compile(r"\[[^\]]+\]\(([^)]+)\)")
    for markdown in ROOT.rglob("*.md"):
        if ".git" in markdown.parts:
            continue
        text = markdown.read_text(encoding="utf-8")
        for target in link_pattern.findall(text):
            target = target.strip().strip("<>")
            if (
                not target
                or target.startswith(("#", "http://", "https://", "mailto:"))
            ):
                continue
            relative = unquote(target.split("#", 1)[0])
            destination = (markdown.parent / relative).resolve()
            if not destination.exists():
                fail(
                    f"broken local link in {markdown.relative_to(ROOT)}: {target}"
                )


def run_validator(relative: str) -> None:
    path = require_file(relative)
    completed = subprocess.run(
        [sys.executable, str(path)],
        cwd=ROOT,
        text=True,
        capture_output=True,
    )
    if completed.returncode:
        fail(
            f"{relative} failed:\n{completed.stdout}{completed.stderr}".rstrip()
        )
    print(completed.stdout.strip())


def main() -> int:
    try:
        validate_structure()
        validate_local_markdown_links()
        run_validator("clinical-sas-workshop/tests/validate_workshop.py")
        run_validator("cdisc-pilot-mini-workshop/tests/validate_pilot.py")
    except AssertionError as exc:
        print(f"FAIL: {exc}")
        return 1
    print("PASS: repository structure, documentation, and both workshops validated.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
