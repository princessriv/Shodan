#!/usr/bin/env bash
# Small safe wrapper for `shodan search`
# Usage:
#   bash scripts/shodan_quickscan.sh --dry-run "nginx country:JP" --limit 10

set -euo pipefail

DRY_RUN=false
LIMIT=20
QUERY="apache"

# parse args simply
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run) DRY_RUN=true; shift ;;
    --limit) LIMIT="$2"; shift 2 ;;
    *) QUERY="$1"; shift ;;
  esac
done

echo "Query: $QUERY"
echo "Limit: $LIMIT"
echo "Dry-run: $DRY_RUN"

if $DRY_RUN; then
  echo "[DRY-RUN] No network action taken."
  exit 0
fi

if [[ -z "${SHODAN_API_KEY:-}" ]]; then
  echo "ERROR: set SHODAN_API_KEY environment variable" >&2
  exit 1
fi

# Use the shodan CLI if installed; the example saves JSON results.
shodan search --limit "$LIMIT" --fields ip_str,port,org,product "$QUERY" > results.json
echo "Saved results.json (ensure results are sanitized before sharing)."
Make it executable too:

chmod +x scripts/shodan_quickscan.sh




.gitignore

# Virtualenv and python
.venv/
__pycache__/
*.pyc

# Local env keys / secrets
.env
.envrc
secrets.*
