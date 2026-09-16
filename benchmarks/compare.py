#!/usr/bin/env python3
"""Compare page-turn records from two instrumented benchmark runs."""

import json
import statistics
import sys


def read_records(path):
    with open(path, encoding="utf-8") as source:
        return [json.loads(line) for line in source if line.strip()]


def duration(record):
    stages = record["stages_ns"]
    return stages["framebuffer_submission_complete"] - stages["input_received"]


def summarize(path):
    records = read_records(path)
    values = [duration(record) for record in records]
    return len(records), statistics.median(values) if values else None


if len(sys.argv) != 3:
    raise SystemExit(f"usage: {sys.argv[0]} RUN_A.jsonl RUN_B.jsonl")

for path in sys.argv[1:]:
    count, median = summarize(path)
    value = "n/a" if median is None else f"{median / 1_000_000:.2f} ms"
    print(f"{path}: {count} page turns, median submission latency {value}")
