# IT Help Desk & Tier 1 Troubleshooting Playbook

A structured collection of Standard Operating Procedures (SOPs) and step-by-step troubleshooting runbooks designed for Tier 1 IT Support and Help Desk operations. These guides focus on fast root-cause isolation, minimizing end-user downtime, and clear documentation.

## Repository Contents

| Guide | Topic | Key Areas Covered |
| :--- | :--- | :--- |
| [01 - Network Connectivity](01-network-connectivity-troubleshooting.md) | Basic Network Diagnostics | `ipconfig`, `ping`, `nslookup`, DNS cache, physical link checks |
| [02 - Browser & Teams Fixes](02-browser-and-teams-session-fixes.md) | Web Apps & Collaboration | Cache/cookie corruption, incognito isolation, Microsoft Teams login loops |
| [03 - Printers & Projectors](03-printer-and-projector-troubleshooting.md) | Office & Classroom Hardware | Print spooler resets, driver/queue clearing, display projection modes |
| [04 - User Onboarding Checklist](04-new-hire-onboarding-checklist.md) | Account & Workstation Setup | Account provisioning, MFA setup, software baseline, access verification |

## Troubleshooting Methodology
Every runbook in this repository follows a standard Tier 1 escalation workflow:
1. **Verify & Reproduce:** Confirm the exact error message and scope (single user vs. department-wide).
2. **Check Physical & Session Basics:** Verify cables, power, network connection, and clean browser sessions before changing configurations.
3. **Isolate & Resolve:** Apply targeted fixes from least disruptive to most invasive.
4. **Document & Escalate:** Log resolution steps clearly or escalate to Tier 2/Network Administration with diagnostic outputs attached.
