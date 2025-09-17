#!/usr/bin/env python3
"""
Simple, safe Shodan host report fetcher.

Usage:
  python3 scripts/shodan_report.py 1.2.3.4 --out report.json
  python3 scripts/shodan_report.py 1.2.3.4 --dry-run
Note: set SHODAN_API_KEY environment variable before running real queries.
"""

import os
import argparse
import json
from shodan import Shodan, APIError

def main():
    parser = argparse.ArgumentParser(description="Fetch Shodan host report (safe)")
    parser.add_argument("host", help="IP address or hostname (only query authorized targets)")
    parser.add_argument("--out", "-o", default="host_report.json", help="Output filename")
    parser.add_argument("--dry-run", action="store_true", help="Do not call Shodan API; just show intent")
    args = parser.parse_args()

    if args.dry_run:
        print(f"[DRY-RUN] Would query Shodan for: {args.host}")
        print(f"[DRY-RUN] Would save to: {args.out}")
        return

    api_key = os.getenv("SHODAN_API_KEY")
    if not api_key:
        raise SystemExit("ERROR: Set SHODAN_API_KEY environment variable before running live queries.")

    api = Shodan(api_key)
    try:
        report = api.host(args.host)
    except APIError as e:
        raise SystemExit(f"Shodan API error: {e}")

    # Sanitize minimal fields in case user later shares report
    sanitized = {
        "ip_str": report.get("ip_str"),
        "org": report.get("org"),
        "hostnames": report.get("hostnames"),
        "data_count": report.get("data", None) and len(report.get("data", []))
    }

    with open(args.out, "w") as f:
        json.dump({"sanitized": sanitized, "raw": report}, f, indent=2)

    print(f"Saved report to {args.out} (raw + sanitized).")

if __name__ == "__main__":
    main()
  Notes: script includes --dry-run and requires SHODAN_API_KEY for live runs. It writes both sanitized summary and raw JSON — you can remove raw if you prefer not to store full output.

Make the script executable:

chmod +x scripts/shodan_report.py

