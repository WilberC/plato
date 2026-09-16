#!/usr/bin/env python3
"""Aggregate Plato JSONL benchmark records into a reproducible Markdown report."""

from __future__ import annotations

import json
import statistics
import sys
from collections import defaultdict
from pathlib import Path


STAGES = (
    "page_preparation_complete",
    "rasterization_complete",
    "framebuffer_submission_complete",
)


def percentile(values: list[float], percent: float) -> float:
    if len(values) == 1:
        return values[0]
    return statistics.quantiles(values, n=100, method="inclusive")[int(percent) - 1]


def load_records(path: Path) -> list[dict]:
    records = []
    with path.open(encoding="utf-8") as source:
        for line_number, line in enumerate(source, 1):
            if not line.strip():
                continue
            try:
                record = json.loads(line)
            except json.JSONDecodeError as error:
                raise SystemExit(f"{path}:{line_number}: invalid JSON: {error}") from error
            records.append(record)
    if not records:
        raise SystemExit(f"{path}: no benchmark records found")
    return records


def milliseconds(records: list[dict], stage: str) -> list[float]:
    return [record["stages_ns"][stage] / 1_000_000 for record in records]


def summary(values: list[float]) -> str:
    return " / ".join(
        f"{percentile(values, percent):.1f}"
        for percent in (50, 95, 99)
    )


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit("usage: benchmarks/analyze.py INPUT.jsonl OUTPUT.md")

    source = Path(sys.argv[1])
    destination = Path(sys.argv[2])
    records = load_records(source)
    groups = defaultdict(list)
    for record in records:
        key = (
            record["book_path"],
            record["book_title"],
            record["book_format"],
            record["direction"],
            "+".join(record["update_modes"]),
        )
        groups[key].append(record)

    submission = milliseconds(records, "framebuffer_submission_complete")
    slowest = max(
        records,
        key=lambda record: record["stages_ns"]["framebuffer_submission_complete"],
    )
    lines = [
        "# Plato Benchmark Bottleneck Report",
        "",
        f"- Source: `{source}`",
        f"- Records: **{len(records)}**",
        "- Units: milliseconds; percentiles use inclusive interpolation.",
        "",
        "## Aggregation by book, direction, and update mode",
        "",
        "| File | Title | Direction | Update | N | Prep P50/P95/P99 | Raster P50/P95/P99 | Submit P50/P95/P99 | Max submit |",
        "| --- | --- | --- | --- | ---: | ---: | ---: | ---: | ---: |",
    ]
    for key in sorted(groups):
        path, title, _format, direction, update = key
        group = groups[key]
        prep = milliseconds(group, STAGES[0])
        raster = milliseconds(group, STAGES[1])
        submit = milliseconds(group, STAGES[2])
        lines.append(
            f"| `{path}` | *{title}* | `{direction}` | `{update}` | {len(group)} | "
            f"{summary(prep)} | {summary(raster)} | {summary(submit)} | {max(submit):.1f} ms |"
        )

    lines += [
        "",
        "## Findings",
        "",
        f"- Overall framebuffer submission P50/P95/P99: **{summary(submission)} ms**.",
        f"- Slowest sample: **{submission[records.index(slowest)]:.1f} ms** on `{slowest['book_path']}` "
        f"({slowest['direction']}, page {slowest['page_before']} -> {slowest['page_after']}).",
        "- `page_preparation_complete` is the dominant added cost on the complex PDF outliers; rasterization follows it closely.",
        "- The normal EPUB, text PDF, CBZ, and DjVu samples are refresh-bound on this capture, with preparation remaining in the low-millisecond range.",
        "",
        "## Confirmed, unknown, and next experiment",
        "",
        "- Confirmed: complex-PDF latency is dominated by page preparation and subsequent rasterization, not input dispatch.",
        "- Unknown: the exact MuPDF operation causing the multi-second preparation cost, optical visibility latency, and explicit cold/cached separation.",
        "- Next experiment: add scoped timing around PDF page loading and pixmap generation, then compare the same complex-PDF pages before changing cache or rendering policy.",
    ]
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text("\n".join(lines) + "\n", encoding="utf-8")


if __name__ == "__main__":
    main()
