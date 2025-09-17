# Shodan Reconnaissance (SODAN) — Educational Repo

**Purpose.** Short, ethical demo of using Shodan for reconnaissance and asset discovery.  
This repository is for a learning purpose.

**Important — Legal & Ethical**
- Only run these scripts against hosts you own or are explicitly authorized to test.
- Never attempt to exploit vulnerabilities. This repo is for discovery, reporting and defensive learning only.

## What is included
- `scripts/shodan_report.py` — small Python script to fetch a host report (safe defaults).
- `scripts/shodan_quickscan.sh` — tiny bash wrapper with `--dry-run` and limit.
- `examples/` — (optional) sanitized example outputs (never include real IPs).

## Quick setup
1. Create a Shodan account and get an API key (only if you will run live queries).
2. Set environment variable (Linux/macOS):
   ```bash
   export SHODAN_API_KEY="your_api_key_here"

  3. Install dependencies:

python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt



Examples (safe)

Dry run (no network):

bash scripts/shodan_quickscan.sh --dry-run "nginx country:JP" --limit 10

Get a host report (replace with a host you are authorized to query):

python3 scripts/shodan_report.py 1.2.3.4 --out demo_report.json --dry-run
## License
This project is licensed under the [MIT License](LICENSE).











