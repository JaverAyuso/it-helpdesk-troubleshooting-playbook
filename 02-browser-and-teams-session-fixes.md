# SOP 02: Web Browser & Microsoft Teams Session Troubleshooting

**Category:** Web Applications & Collaboration Tools  
**Target Environment:** Windows 10/11 (Chrome, Edge, Brave, Microsoft Teams)  
**Estimated Resolution Time:** 5–10 minutes  

---

## 1. Symptoms
* User is stuck in an infinite sign-in redirect loop on Microsoft 365, Teams, or web portals.
* Web-based business/classroom applications load blank pages, freeze, or display `400 Bad Request` / `Session Expired` errors.
* Microsoft Teams desktop app fails to load channels, calendar, or status updates despite working internet connectivity.

## 2. Step-by-Step Resolution

### Step 1: Isolate Session vs. Network Issue (Incognito Test)
1. Open a private/incognito window (`Ctrl + Shift + N` in Chrome/Edge/Brave).
2. Have the user sign into the affected web application.
   * **If it works in Incognito:** The network and user account are healthy; the issue is corrupted local cookies, cached site data, or a conflicting browser extension.
   * **If it fails in Incognito:** Check network connectivity (see [SOP 01](01-network-connectivity-troubleshooting.md)) or verify whether the service is experiencing an outage.

### Step 2: Clear Site-Specific Cache & Cookies (Without Wiping All Passwords)
1. Click the **Padlock / View site information** icon on the left side of the browser address bar.
2. Select **Cookies and site data** → **Manage on-device site data**.
3. Click the **Trash** icon next to the affected domain(s) (e.g., `microsoftonline.com`, `teams.microsoft.com`, or internal portal URL).
4. Close all browser tabs for that service, reopen, and sign in fresh.

### Step 3: Check Browser Extensions & Hardware Acceleration
* Temporarily disable ad-blockers, script-blockers, or third-party VPN extensions on internal portals.
* If video calls or screen sharing flicker/lag in the browser, toggle **Use graphics acceleration when available** in browser settings and relaunch.

### Step 4: Reset Microsoft Teams Desktop Client Cache
If the Microsoft Teams desktop application remains stuck or fails to sync:
1. Right-click the **Teams** icon in the Windows system tray (bottom right) and click **Quit**.
2. Press `Win + R` to open the Run dialog, paste the path below, and press `Enter`:
```text
%localappdata%\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams
