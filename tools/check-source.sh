#!/usr/bin/env bash
# Run existing asset-free source checks in a fresh host test workspace.
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
command -v python3 >/dev/null
command -v clang++-18 >/dev/null
test_home="$(mktemp -d "${TMPDIR:-/tmp}/ttt2-source-check.XXXXXX")"
export HOME="$test_home"
for test in test_progress_gate.py test_ps5_keyboard.py test_compiler_heartbeat.py; do
    python3 "$repo/source/port/tests/ps5/$test"
done
printf 'PASS source checks. Fixtures retained at %s\n' "$test_home"

