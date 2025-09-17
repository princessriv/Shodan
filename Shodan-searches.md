# Shodan — Example Searches (sanitized)

> Disclaimer: These examples are for educational purposes only. Do not scan or attempt to access systems you do not own or have explicit authorization to test.

## Quick examples

### 1) Find web servers running Apache

```bash
shodan search "apache"
Description: Returns hosts whose service banner contains "apache". Use filters (country, port, org) to narrow results.

Sanitized example output (parsed):

ip_str: 203.0.113.10  | port: 80  | product: Apache httpd/2.4.29
2) Nginx servers in Japan

shodan search "nginx country:JP"

Description: Combines a product filter with a country filter.

Sanitized example output:

ip_str: 203.0.113.20  | port: 80  | product: nginx/1.14.0
3) Telnet-exposed devices in the US (legacy insecure service)

shodan search "port:23 country:US"

Description: Finds devices with port 23 (Telnet) exposed in the United States.

Sanitized example output:

ip_str: 203.0.113.30  | port: 23  | product: BusyBox telnetd
4) Industrial systems (Modbus)

shodan search "port:502"

Description: Finds devices that respond on port 502 — commonly Modbus TCP, an ICS protocol.

Sanitized example output:

ip_str: 203.0.113.40  | port: 502  | product: modbus
5) Search by organization (example)

shodan search "org:\"Example University\" port:22"

Description: Finds SSH hosts attributed to a specific organization in Shodan metadata.
Download & parse results

# Download large result sets to a file (gzipped JSON)
shodan download my-results "apache country:DE"

# Parse downloaded results for chosen fields
shodan parse --fields ip_str,port,product my-results.json.gz

Using the API (Python snippet)

from shodan import Shodan

api = Shodan('YOUR_API_KEY')
results = api.search('nginx country:JP')
print('Total results: {}'.format(results['total']))
for r in results['matches'][:5]:
    print(r['ip_str'], r.get('port'), r.get('product'))

Notes: Always sanitize outputs (mask private IPs or hostnames) before sharing publicly.

---

## FILE: examples/host-report-example.txt

```text
Host Reconnaissance Report (Sanitized Example)
=============================================

Report ID: SR-EX-001
Date: 2025-09-17
Target (sanitized): 203.0.113.5
Tools: Shodan CLI (shodan vX.X), manual triage
Analyst: [Your Name]

1) Summary
----------
A publicly reachable host (203.0.113.5) was identified with multiple open services. The host exposes web interfaces and an outdated service version that may indicate a known vulnerability. This report is sanitized; original findings used reserved/test-net addresses.

2) Discovery details
--------------------
- Method: Shodan query and host lookup
- Command(s) used:
  - `shodan search "product:nginx country:KR"`
  - `shodan host 203.0.113.5`

3) Host details
---------------
- IP (sanitized): 203.0.113.5
- Location (approx): Seoul, South Korea (based on Shodan geolocation metadata)
- Open ports & services:
  - 22/tcp  - ssh (OpenSSH 7.4)
  - 80/tcp  - http (nginx/1.14.0)
  - 8080/tcp - http-alt (custom camera web UI)

- Service banners (sanitized):
  - nginx/1.14.0
  - camera-product: ExampleCam v1.2.0

4) Vulnerability indicators
---------------------------
- Shodan returned metadata referencing possible CVE(s) for older versions of the camera web UI (see notes). Example placeholder: CVE-XXXX-YYYY (referenced in banner metadata).
- No active exploitation was attempted — this is passive reconnaissance only.

5) Risk rating
--------------
- Default credentials discovered (by banner metadata / public indicators): **High**
- Outdated firmware with referenced CVE(s): **Critical**
- Public web UI accessible without multi-factor protections: **High**

6) Recommended Remediation
--------------------------
1. Immediately restrict remote access to the device (block on perimeter firewall or place behind VPN).
2. Update firmware/software to the latest vendor release.
3. Disable default credentials; enforce unique, strong passwords.
4. If remote management is required, use access control lists and IP whitelisting.
5. Consider network segmentation to separate IoT devices from critical infrastructure.

7) Notes & limitations
----------------------
- This report contains sanitized data for public sharing. Replace sanitized placeholders with verified, real host details only when delivering to authorized stakeholders.
- All testing should be within scope and authorized. Unauthorized interaction with systems is illegal in many jurisdictions.

---

Prepared by: [Sarita Gurung]  


---
