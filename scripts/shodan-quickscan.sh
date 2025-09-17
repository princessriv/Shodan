#!/usr/bin/env bash
# shodan-quickscan.sh
# Safe example script that runs Shodan searches and produces a parsed CSV-like output.
# This script uses the Shodan CLI. It performs only search/download/parse operations - no active scanning or exploitation.

set -euo pipefail

if ! command -v shodan >/dev/null 2>&1; then
  echo "Error: shodan CLI not found. Install via: pip install --user shodan" >&2
  exit 2
fi

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 \"<shodan query>\" <output-prefix>" >&2
  echo "Example: $0 \"nginx country:JP\" results/nginx-jp" >&2
  exit 1
fi

QUERY="$1"
OUTPREFIX="$2"

# Create output directory
OUTDIR=$(dirname "$OUTPREFIX")
mkdir -p "$OUTDIR"

# Download results (gzipped JSON)
JSON_GZ="$OUTPREFIX.json.gz"
CSV_OUT="$OUTPREFIX.csv"

echo "Running Shodan query: $QUERY"
shodan download "$OUTPREFIX" "$QUERY"

# Parse important fields into a simple CSV (ip,port,product)
# Note: 'shodan parse' outputs to stdout by default; adjust fields as needed.
shodan parse --fields ip_str,port,product "$JSON_GZ" > "$CSV_OUT"

echo "Results saved to: $JSON_GZ and parsed CSV: $CSV_OUT"

echo "Done. Remember: use this script only on authorized targets."
