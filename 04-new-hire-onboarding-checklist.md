# SOP 04: New Hire IT Onboarding & Workstation Setup Checklist

**Category:** Identity, Access & Endpoint Provisioning  
**Target Environment:** Windows 10/11 Workstations, Microsoft 365 / Google Workspace  
**Estimated Completion Time:** 30–45 minutes  

---

## 1. Pre-Arrival Account Provisioning
* [ ] Confirm approved HR onboarding ticket with full name, job title, department, start date, and manager.
* [ ] Create corporate user account in Active Directory / Microsoft 365 Admin Center / Google Admin Console.
* [ ] Assign required license tier (e.g., Microsoft 365 Business Standard / Google Workspace).
* [ ] Add user to department security groups, distribution lists, and shared drives/folders.
* [ ] Generate a temporary initial password and enable **Require password change at first sign-in**.

## 2. Workstation Hardware & OS Preparation
* [ ] Verify physical condition of laptop/desktop, charger, docking station, headset, and peripherals.
* [ ] Run Windows Update (`Settings > Windows Update`) and install all pending OS and driver patches.
* [ ] Verify endpoint antivirus/EDR agent is active and reporting healthy status.
* [ ] Confirm corporate Wi-Fi profile and VPN client (if remote/hybrid) are configured.
* [ ] Record device serial number, hostname, and asset tag in the IT inventory log.

## 3. Standard Software Baseline
* [ ] Install and verify approved web browsers (Chrome / Edge) with corporate bookmarks/policies.
* [ ] Install collaboration & productivity suite (Microsoft Teams, Office desktop apps, PDF reader).
* [ ] Install role-specific tools (CRM access, ticketing system, or remote support agent).

## 4. Day-One Handover & Security Verification
* [ ] Walk user through first-time login and custom password creation.
* [ ] Enroll user in **Multi-Factor Authentication (MFA)** via Authenticator app and verify backup recovery method.
* [ ] Test email send/receive, calendar access, Teams audio/video, and shared drive permissions.
* [ ] Have user sign the **Acceptable Use & Equipment Receipt Policy** and close the onboarding ticket.

## 5. Escalation Criteria
Escalate to Tier 2 / Systems Administration if:
* License assignment fails due to tenant seat limits or directory sync errors.
* Role requires custom firewall exceptions, elevated local admin rights, or specialized software licensing.
