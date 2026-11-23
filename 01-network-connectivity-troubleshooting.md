# SOP 01: Network Connectivity & "No Internet" Troubleshooting

**Category:** Network & Connectivity  
**Target Environment:** Windows 10/11 Workstations (Office & Remote)  
**Estimated Resolution Time:** 5–15 minutes  

---

## 1. Symptoms
* User reports "No Internet, secured" or "Unidentified network" in the Windows system tray.
* Websites or internal cloud applications (Microsoft Teams, Google Workspace, CRM) fail to load.
* Error messages such as `DNS_PROBE_FINISHED_NXDOMAIN` or `ERR_INTERNET_DISCONNECTED`.

## 2. Scope Check (First 60 Seconds)
Before changing workstation settings, determine if the issue is isolated or widespread:
* **Single User:** Proceed with workstation steps below.
* **Multiple Users / Entire Office:** Check the local switch/router power and ISP modem status; notify Tier 2 / Network Admin immediately.

## 3. Step-by-Step Resolution

### Step 1: Verify Physical & Wireless Layer (OSI Layer 1)
1. **Wired:** Confirm the Ethernet cable is firmly seated at both the PC NIC and the wall jack/dock; check for solid/blinking link lights.
2. **Wireless:** Confirm Wi-Fi is toggled **On**, Airplane Mode is **Off**, and the device is connected to the correct corporate SSID (not a guest or neighboring network).

### Step 2: Inspect IP Configuration (`ipconfig`)
Open **Command Prompt** (`Win + R` → type `cmd` → press `Enter`) and run:
```cmd
ipconfig /all
