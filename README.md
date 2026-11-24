# IT Help Desk & Tier 1 Troubleshooting Playbook

A structured collection of Standard Operating Procedures (SOPs) and step-by-step troubleshooting runbooks designed for Tier 1 IT Support and Help Desk operations. These guides focus on fast root-cause isolation, minimizing end-user downtime, and clear documentation.

## Repository Contents

| Guide / Tool | Topic | Key Areas Covered |
| :--- | :--- | :--- |
| [01 - Network Connectivity](01-network-connectivity-troubleshooting.md) | Basic Network Diagnostics | `ipconfig`, `ping`, `nslookup`, DNS cache, physical link checks |
| [02 - Browser & Teams Fixes](02-browser-and-teams-session-fixes.md) | Web Apps & Collaboration | Cache/cookie corruption, incognito isolation, Microsoft Teams login loops |
| [03 - Printers & Projectors](03-printer-and-projector-troubleshooting.md) | Office & Classroom Hardware | Print spooler resets, driver/queue clearing, display projection modes |
| [04 - User Onboarding Checklist](04-new-hire-onboarding-checklist.md) | Account & Workstation Setup | Account provisioning, MFA setup, software baseline, access verification |
| [05 - Ticket Triage & SLA Matrix](05-ticket-triage-and-escalation-matrix.md) | Service Desk Operations | P1–P4 severity classification, structured ticket notes, Tier 2 handoff rules |
| [06 - AD Account Lockout SOP](06-active-directory-account-lockout.md) | Identity & Access Management | AD/Entra unlock workflow, Credential Manager cleanup, repeat lockout isolation |
| [Get-WorkstationDiagnostics.ps1](scripts/Get-WorkstationDiagnostics.ps1) | PowerShell Automation | Automated OS, uptime, IP/DNS check, and top memory process export script |

## Quick Start: Workstation Diagnostics Script

Run `scripts/Get-WorkstationDiagnostics.ps1` on any Windows workstation to generate a Tier 1 diagnostic snapshot (OS, uptime, `C:` storage, IP/gateway/DNS config, connectivity checks, and top 5 memory-consuming processes):

```powershell
cd "$env:USERPROFILE\Downloads"
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
./Get-WorkstationDiagnostics.ps1
Get-Content (Get-ChildItem "$env:USERPROFILE\Desktop\IT_Diagnostics_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
```

- **Full Step-by-Step Guide & Sample Report:** See [`scripts/TROUBLESHOOTING-SCRIPT-NOTES.md`](scripts/TROUBLESHOOTING-SCRIPT-NOTES.md)
  
## Troubleshooting Methodology
Every runbook in this repository follows a standard Tier 1 escalation workflow:
1. **Verify & Reproduce:** Confirm the exact error message and scope (single user vs. department-wide).
2. **Check Physical & Session Basics:** Verify cables, power, network connection, and clean browser sessions before changing configurations.
3. **Isolate & Resolve:** Apply targeted fixes from least disruptive to most invasive.
4. **Document & Escalate:** Log resolution steps clearly or escalate to Tier 2/Network Administration with diagnostic outputs attached.
