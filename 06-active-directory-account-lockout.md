# SOP 06: Active Directory & Microsoft 365 Account Lockout Troubleshooting

**Category:** Identity & Access Management (IAM)  
**Target Environment:** Active Directory (ADUC), Microsoft 365 Entra ID, Windows 10/11  
**Estimated Resolution Time:** 5–10 minutes  

---

## 1. Symptoms
* User receives *"The referenced account is currently locked out and may not be logged on to"* at Windows login.
* Repeated password prompts in Outlook, Microsoft Teams, or mapped network drives immediately after a password reset.

## 2. Step-by-Step Resolution

### Step 1: Verify User Identity (Mandatory Security Check)
Before unlocking or resetting any account:
1. Confirm the caller's full name, employee/student ID, and manager or registered secondary contact method per company verification policy.

### Step 2: Check Lockout Status & Unlock Account
1. **On-Premises Active Directory (ADUC):**
   * Open **Active Directory Users and Computers** → locate the user → right-click **Properties** → **Account** tab.
   * Check **Unlock account** and click **Apply**.
2. **Microsoft 365 / Entra ID:**
   * Open **Microsoft Entra Admin Center** → **Users** → select user → confirm **Account enabled** is set to **Yes** and review **Sign-in logs** for repeated failure source IPs.

### Step 3: Identify & Clear the Root Cause (Prevent Repeat Lockouts)
Unlocking an account without removing cached old passwords causes an immediate re-lockout within minutes. Check these three common culprits on the user's devices:
1. **Windows Credential Manager:**
   * Open **Control Panel > Credential Manager > Windows Credentials**.
   * Expand any saved entries for `MicrosoftOffice16`, `Teams`, VPN, or internal file servers, and click **Remove** (or **Edit** with the new password).
2. **Mobile Devices (iOS / Android):**
   * Have the user open their phone's Mail/Outlook/Teams app and re-enter their updated password—background email sync with an old password is the #1 cause of repeat lockouts.
3. **Disconnected RDP or Secondary Sessions:**
   * Check if the user left an active session logged into a shared workstation, classroom PC, or Remote Desktop session prior to changing their password.

## 4. Escalation Criteria
Escalate immediately to Tier 2 / Information Security if:
* Sign-in logs show rapid failed login attempts originating from unfamiliar external IP addresses or foreign countries (potential brute-force / password-spray attack).
* An account continues locking out every few minutes after clearing Credential Manager and mobile devices.
