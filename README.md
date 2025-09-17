# Shodan
# Shodan Reconnaissance (SODAN)

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)  
[![Topics](https://img.shields.io/badge/topics-Recon%20%7C%20Shodan%20%7C%20IoT-blueviolet.svg)](#)

> Professional notes and a small hands-on guide for reconnaissance using **Shodan** — formatted for inclusion in a GitHub portfolio and a Master’s application in Cybersecurity.

---

## Table of Contents
- [About](#about)  
- [Repository Structure](#repository-structure)  
- [Prerequisites](#prerequisites)  
- [Installation](#installation)  
- [Quick Start (Shodan CLI)](#quick-start-shodan-cli)  
- [Common Commands & Examples](#common-commands--examples)  
- [Sample Mini Case Study](#sample-mini-case-study)  
- [Use Cases in Cybersecurity](#use-cases-in-cybersecurity)  
- [Ethical & Legal Considerations](#ethical--legal-considerations)  
- [Further Reading & Resources](#further-reading--resources)  
- [Author / Contact](#author--contact)  
- [License](#license)

---

## About
**Shodan** is a search engine for Internet-connected devices (IoT). Unlike general web search engines that index pages, Shodan indexes service banners and metadata (open ports, service versions, headers) returned by devices. Security professionals use Shodan to discover exposed systems, assess attack surfaces, and prioritize remediation.

This repository (SODAN) documents concise, professional training notes and practical examples for reconnaissance using Shodan, demonstrating hands-on skills relevant to cybersecurity study and operations.

---

## Repository Structure

/ ├── README.md                # (this file) ├── examples/                # sample commands and sanitized outputs │   ├── shodan-searches.md │   └── host-report-example.txt ├── scripts/                 # helper scripts (optional) │   └── shodan-quickscan.sh ├── assets/                  # screenshots / diagrams (optional) └── LICENSE
## Prerequisites
- Python 3.x (for CLI install via pip)  
- A Shodan account (free or paid) — obtain API key from your dashboard at https://www.shodan.io  
- Internet access and familiarity with the command line  
- Optional: `jq` for JSON parsing

---

## Installation

1. Install the Shodan Python package and CLI:
```bash
pip install --user shodan

2. Create a Shodan account at https://www.shodan.io and copy your API key from your dashboard.


3. Initialize the CLI:



shodan init YOUR_API_KEY_HERE

4. Verify installation:



shodan version


---

Quick Start (Shodan CLI)

Basic searches and host queries:

# Basic keyword search
shodan search apache

# Search with filter (Nginx servers in Japan)
shodan search "nginx country:JP"

# Get host details for an IP
shodan host 203.0.113.5


---

Common Commands & Examples

Search for devices / services

# Web cameras or streaming software
shodan search "webcamxp"

# Telnet devices (port 23) in the United States
shodan search "port:23 country:US"

# Industrial Modbus devices (port 502)
shodan search "port:502"

Host information

# Detailed host report (open ports, banners, geolocation, CVE references)
shodan host 203.0.113.5

Download results and parse

# Download search result set
shodan download my-results "apache country:DE"

# Parse downloaded data (example fields)
shodan parse --fields ip_str,port,product my-results.json.gz


---

Sample Mini Case Study

Objective: Identify externally exposed web cameras and assess risk.

Steps

1. Targeted query for known camera software and titles:



shodan search "webcamxp title:'Live View' country:KR"

2. Inspect interesting results with shodan host <IP> to gather ports, banners, and references to CVEs.


3. Triage: verify service versions, default credentials, and exposure (public web UI).


4. Document findings: IP, product, open ports, probable risk, and remediation recommendations.



Example outcome (sanitized):

3 devices found with publicly accessible web UI.

2 devices used default credentials → High risk.

1 device had firmware version with a referenced CVE (remote code execution) → Critical.

Recommendations: Disable remote access, enforce strong credentials, apply firmware updates, and restrict access via firewall or VPN.


This mini case study demonstrates methodical reconnaissance, triage, and actionable reporting.


---

Use Cases in Cybersecurity

Attack surface mapping — discover what your organization unintentionally exposes.

Vulnerability reconnaissance — find services that reference known CVEs.

IoT posture assessment — evaluate prevalence and insecurity of deployed devices.

Incident response — verify whether an IP or service is visible externally during investigations.



---

Ethical & Legal Considerations

> ⚠️ Shodan is a powerful intelligence tool. Use responsibly.



Only query, scan, or probe systems you own or for which you have explicit written authorization.

Treat Shodan results as reconnaissance intelligence — do not attempt exploitation without permission.

Unauthorized access or probing can be illegal and unethical. When in doubt, obtain formal authorization (scope & rules of engagement).



---

Further Reading & Resources

Official Shodan: https://www.shodan.io

Shodan CLI docs: shodan --help and the Shodan website documentation

Responsible disclosure and local laws for digital investigations





