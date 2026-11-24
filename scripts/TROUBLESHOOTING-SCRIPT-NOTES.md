### Sample Diagnostic Output (Sanitized Example)

```text
TIER 1 WORKSTATION DIAGNOSTIC REPORT
====================================
Generated:  11/24/2026 12:50:00
Hostname:   WORKSTATION-01
User:       helpdesk-user
OS Version: Microsoft Windows 11 Pro (10.0.26200)
Uptime:     1d 20h 57m

--- NETWORK CONFIGURATION ---
Adapter:    Wi-Fi
IPv4:       192.168.1.25
Gateway:    192.168.1.1
DNS Servers: 1.1.1.1, 8.8.8.8

--- CONNECTIVITY TESTS ---
1. Gateway Ping (192.168.1.1): PASS
2. External Ping (8.8.8.8):    PASS
3. DNS Resolution (example):   PASS

--- TOP 5 MEMORY-CONSUMING PROCESSES ---
browser-proc - 640.5 MB
browser-proc - 412.0 MB
code-editor  - 310.2 MB
```

# Complete Guide: Running, Reading & Troubleshooting `Get-WorkstationDiagnostics.ps1`

This guide explains how to download `Get-WorkstationDiagnostics.ps1`, run it in Windows PowerShell on any computer, view the generated report using a universal wildcard command, understand every command and symbol, and resolve common errors.


## 1. Download the Actual Script File

- **Simple Mistake to Avoid:** Clicking the copy button on a commit header or file path copies text like `scripts/Get-WorkstationDiagnostics.ps1`, not the PowerShell code inside the file.
- **Steps:**
  1. Open `scripts/Get-WorkstationDiagnostics.ps1` in GitHub.
  2. Click **Download raw file** (the downward-arrow icon at the top right of the code viewer) so `Get-WorkstationDiagnostics.ps1` saves to your `Downloads` folder.

---

## 2. Run the Script & View the Report on Any Computer :)

Open **Windows PowerShell** and run the following commands one by one:

### Step-by-Step Commands for Any Windows PC

1. Move into your `Downloads` folder:
   ```powershell
   cd "$env:USERPROFILE\Downloads"
   ```
2. Allow script execution for this PowerShell window only:
   ```powershell
   Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
   ```
   Type `Y` and press **Enter** if prompted.
3. Run the diagnostics script:
   ```powershell
   ./Get-WorkstationDiagnostics.ps1
   ```
4. Print the newest report directly in PowerShell on any computer:
   ```powershell
   Get-Content (Get-ChildItem "$env:USERPROFILE\Desktop\IT_Diagnostics_*.txt" | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName
   ```

## Universal Workflow on Any Computer (Wildcard & Environment Variables)

Earlier versions of these notes used example paths from a specific machine and username (such as `C:\Users\ayuso\Desktop\IT_Diagnostics_ROG_...txt`). Because every computer has a different logged-in user, hostname, and timestamp, hardcoding a path only works on one machine.

Instead, the current workflow uses:
- **`$env:USERPROFILE`** to resolve the active user's profile folder automatically on any Windows PC.
- **A wildcard (`*`)** with `Get-Content` so PowerShell finds the generated report regardless of computer name or timestamp.

---

## Command, Flag & Symbol Reference

- `cd "$env:USERPROFILE\Downloads"` — **Change Directory**. Moves your active terminal path into the current user's `Downloads` folder.
- `$env:USERPROFILE` — Reads the Windows `USERPROFILE` environment variable (for example, `C:\Users\<Username>`), making paths portable across different user accounts. - `$HOME` / `~` — Built-in PowerShell variable and shorthand symbol that also reference your user profile directory.
- `\` and `/` — Path separators in Windows/PowerShell. Use a slash after `.` (`.\` or `./`) when running a script in the current directory.
- `Set-ExecutionPolicy` — PowerShell cmdlet that controls script execution rules.
- `-Scope Process` — Limits the policy change to **only the current PowerShell window**; it resets automatically when you close the window.
- `-ExecutionPolicy Bypass` — Temporarily skips execution policy blocks for the chosen scope.
- `[Y] Yes [A] Yes to All [N] No ...` — Confirmation prompt for changing execution policy. Reply `Y` and press **Enter** before running the script.
- `./Get-WorkstationDiagnostics.ps1` (or `.\Get-WorkstationDiagnostics.ps1`) — Runs the `.ps1` PowerShell script located in your current folder.
- `*` (Wildcard) — Matches any characters in a filename (`IT_Diagnostics_*.txt` matches any hostname and date/time suffix).
- `Get-Content` — Reads and prints file contents in the PowerShell console.
- `Get-ChildItem ... | Sort-Object LastWriteTime -Descending | Select-Object -First 1).FullName` — Finds matching report files on the user's Desktop, sorts newest first, selects the top result, and passes its full file path to `Get-Content`.

---

## How the Script Works

1. **System & Network Info:** Collects timestamp, hostname, username, OS version, uptime, network adapter alias, IPv4 address, default gateway, and DNS servers into `$Report`.
2. **Connectivity Tests:**
   - **Gateway Ping:** Tests reachability to the local default gateway (`Test-Connection`).
   - **External Ping:** Tests reachability to `8.8.8.8`.
   - **DNS Resolution:** Tests domain name resolution (`Resolve-DnsName` for `google.com`) inside a `try / catch` block.
3. **Top 5 Memory-Consuming Processes:** Queries `Get-Process`, sorts by `WorkingSet64` descending (`| Sort-Object WorkingSet64 -Descending`), takes the top 5 (`| Select-Object -First 5`), converts bytes to megabytes (`WorkingSet64 / 1MB`), and appends each entry to `$Report` using `+=`. 4. **Automatic Directory Guard & Save:** Uses `Split-Path -Path $OutputPath -Parent` and `Test-Path` to check if the destination folder exists, runs `New-Item -ItemType Directory -Force | Out-Null` if missing, and writes `$Report` with `Out-File -FilePath $OutputPath -Encoding UTF8`.

---

## Errors Encountered & How to Fix Them

### 1. Running from the wrong folder or missing the slash (`./` or `.\`)
- **Symptom:** `The term './Get-WorkstationDiagnostics.ps1' is not recognized...` or `.Get-WorkstationDiagnostics.ps1` fails.
- **Cause:** PowerShell is in another folder (such as `C:\WINDOWS\system32`), the file is not in that folder yet, or the slash after `.` was omitted.
- **Fix:** Run `cd "$env:USERPROFILE\Downloads"` (after downloading the raw `.ps1` file) and run `./Get-WorkstationDiagnostics.ps1` or `.\Get-WorkstationDiagnostics.ps1`.

### 2. Typo in a command name
- **Symptom:** `CommandNotFoundException` (for example, `Set-excecutionpolicy`).
- **Cause:** Misspelled cmdlet or flag name.
- **Fix:** Check spelling (`Set-ExecutionPolicy`) or type the first letters and press **Tab** for auto-complete.

### 3. Typing the script command at the `[Y]/[N]` prompt
- **Symptom:** Execution policy prompt stays unanswered or rejects input.
- **Cause:** PowerShell is waiting for `Y` (or `A`/`N`) before returning to the command prompt.
- **Fix:** Type `Y` and press **Enter** first, then run `./Get-WorkstationDiagnostics.ps1` once the prompt returns.

### 4. Missing output folder during `Out-File`
- **Symptom:** `Out-File : Could not find a part of the path...`
- **Cause:** The parent folder for `$OutputPath` did not exist yet on a first-time run.
- **Fix:** Added `Split-Path`, `Test-Path`, and `New-Item -ItemType Directory -Force` right above `Out-File` so the folder is created automatically.

### 5. Extra closing brace (`}`) or duplicate lines in the script
- **Symptom:** `Unexpected token '}' in expression or statement` or duplicate lines at the bottom of the script.
- **Cause:** Extra `}` or repeated lines left behind during editing.
- **Fix:** Keep only one closing `}` for the `foreach` loop and one `Out-File` + `Write-Host` pair at the end.

### 6. Editor turns grey / raw in GitHub Markdown
- **Symptom:** Headings and bold text stay grey instead of formatting in GitHub's Markdown editor/preview.
- **Cause:** An unclosed triple-backtick (` ``` `) fence or mismatched backtick count (` ```` ` vs ` ``` `) wraps the rest of the file in a code block.
- **Fix:** Ensure every opening ` ``` ` or ` ```` ` has a matching closing fence on its own line.
