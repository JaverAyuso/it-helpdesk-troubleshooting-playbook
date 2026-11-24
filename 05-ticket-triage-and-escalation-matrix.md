# SOP 05: Help Desk Ticket Triage, SLA Priority & Escalation Matrix

**Category:** Service Desk Operations & ITSM Workflow  
**Target Environment:** Tier 1 Help Desk / Ticketing Systems (ServiceNow, Jira, Zendesk, Freshdesk)  
**Estimated Triage Time:** 2–5 minutes per ticket  

---

## 1. Priority & SLA Classification Matrix

| Priority | Severity Level | Scope & Business Impact | Target First Response | Examples |
| :--- | :--- | :--- | :--- | :--- |
| **P1** | **Critical** | Entire office, core server, or critical production service offline; work completely halted. | **15 minutes** | Office-wide internet outage, email server down, ransomware alert |
| **P2** | **High** | Single department affected or VIP/executive unable to perform core duties with no workaround. | **30 minutes** | Classroom projector down during live lecture, department shared drive inaccessible |
| **P3** | **Medium** | Single user impacted by a software, peripheral, or access issue; partial workaround exists. | **2 hours** | Local printer spooler stuck, Microsoft Teams login loop, single workstation slow |
| **P4** | **Low** | Routine service request, informational question, or minor non-blocking inconvenience. | **1 business day** | New software request, distribution list addition, equipment upgrade inquiry |

## 2. Standard Ticket Documentation Template
Every ticket must contain four structured fields before closing or escalating:

1. **Reported Issue:** Exact error message and what the user was attempting to do.
2. **Scope & Impact:** Single user vs. multiple users; whether a workaround is active.
3. **Troubleshooting Steps Performed:** Ordered list of checks completed (e.g., incognito test, `ipconfig /renew`, spooler restart).
4. **Resolution / Escalation Handoff:** Exact fix applied, or diagnostic outputs attached for Tier 2.

### Good vs. Poor Ticket Notes
* **Poor Note (Avoid):** *"User couldn't log into Teams. Fixed it."*
* **Good Note (Standard):** *"User experienced infinite sign-in redirect loop in Microsoft Teams desktop client. Verified credentials worked in browser Incognito mode (`Ctrl + Shift + N`), confirming local client cache corruption. Quit Teams, cleared `%localappdata%\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams`, and relaunched. User signed in and confirmed channel/calendar sync."*

## 3. Tier 2 Escalation Rules
Escalate to Tier 2 / Systems or Network Administration when:
* **Permission Boundary:** Fix requires Domain Admin, firewall rule changes, or server-side configuration.
* **Time Threshold:** Tier 1 isolation steps exceed 20–30 minutes without root-cause progress on a P2/P3 ticket.
* **Mandatory Handoff Attachment:** Always attach the output of `scripts/Get-WorkstationDiagnostics.ps1` (or `ipconfig /all` + error screenshots) before reassigning the ticket.
