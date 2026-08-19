#!/usr/bin/env bash
# Runs the headless Python debugger integration test against the project nvim config.
#
# Usage: tests/run_python_debug_test.sh
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
results_file="$(mktemp)"

cleanup() {
  rm -f "$results_file"
}
trap cleanup EXIT

if ! python3 -c "import debugpy" 2>/dev/null; then
  echo "ERROR: debugpy is not installed (pip3 install --break-system-packages debugpy)" >&2
  exit 1
fi

set +e
timeout 120 \
  nvim --headless \
    -u "$repo_root/config/nvim/init.lua" \
    -l "$repo_root/tests/python_debug_test.lua" \
    "$repo_root/tests/fixtures/hello_debug.py" \
    "$results_file"
code=$?
set -e

if [[ -f "$results_file" ]]; then
  cat "$results_file"
fi

echo "----------------------------------------"
if [[ $code -eq 0 ]]; then
  echo "Python debugger test: PASSED"
else
  echo "Python debugger test: FAILED (exit code $code)" >&2
fi
exit "$code"