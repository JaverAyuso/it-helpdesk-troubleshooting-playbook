# Complete Guide: Running, Reading & Troubleshooting `Get-WorkstationDiagnostics.ps1`

This guide explains how to download `Get-WorkstationDiagnostics.ps1`, run it in Windows PowerShell, understand every command, flag, and symbol, fix every error encountered, read the report, and use Markdown on GitHub.

---

## 1. Download the Actual Script File

* **Mistake to avoid:** Clicking the copy button on a commit header or file path copies text like `scripts/Get-WorkstationDiagnostics.ps1`, not the PowerShell code inside the file.
* **Steps:**
  1. Open `scripts/Get-WorkstationDiagnostics.ps1` in GitHub.
  2. Click **Download raw file** (the downward-arrow icon at the top right of the code viewer) so `Get-WorkstationDiagnostics.ps1` saves to your `Downloads` folder.

---

## 2. Run the Script in PowerShell

Open **Windows PowerShell** and run:

````powershell
cd $HOME\Downloads
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\Get-WorkstationDiagnostics.ps1
````

### What Each Command, Flag & Symbol Means Here

* `cd` — **Change Directory**. Moves your current working folder in the terminal (for example, from `C:\WINDOWS\system32` to your `Downloads` folder).
* `$HOME` — A built-in PowerShell variable holding your user profile path (such as `C:\Users\ayuso`).
* `~` (Tilde) — A shorthand symbol that also represents your home/user folder in paths (typed with **Shift + `** on a US QWERTY keyboard, or `Alt + 126` with numpad).
* `\` (Backslash) — Folder/path separator on Windows (for example, separating `Downloads` from `Get-WorkstationDiagnostics.ps1`). Note: `/` (forward slash) often works in PowerShell paths too, while `\` is standard on Windows.
* `Set-ExecutionPolicy` — A PowerShell cmdlet that controls whether scripts are allowed to run and under what safety rules.
* `-Scope Process` — A parameter/flag limiting the change to **only this current PowerShell window/session**. Once you close that window, it resets automatically.
* `-ExecutionPolicy Bypass` — Tells PowerShell not to block scripts with execution policy restrictions for that scope.
* `[Y] Yes [A] Yes to All [N] No ...` — Confirmation prompt asking if you want to apply the execution policy change. Type `Y` and press **Enter** before running the script.
* `.\` (Dot-Slash) — Explicitly tells PowerShell to run a script located in your **current directory** (`.` = current folder, `\` = path separator). PowerShell requires `.\` before a local script name so scripts don't run accidentally from the current folder.
* `.ps1` — File extension for a PowerShell script file.

---

## 3. Errors Encountered & How to Fix Them

### Error 1: `The term './Get-WorkstationDiagnostics.ps1' is not recognized...` or `scripts/Get-WorkstationDiagnostics.ps1` not found
* **Why it happens:** PowerShell is still in a folder like `C:\WINDOWS\system32` or the file is not in that folder yet.
* **Fix:** Move into the folder containing the script (`cd $HOME\Downloads`), then run `.\Get-WorkstationDiagnostics.ps1`.

### Error 2: Misspelled Commands (`CommandNotFoundException`, e.g., `Set-excecutionpolicy`)
* **Why it happens:** A command name or parameter has a typo, so PowerShell cannot find a matching cmdlet or program.
* **Fix:** Check spelling (`Set-ExecutionPolicy`), or type the first few letters and press **Tab** to auto-complete.

### Error 3: Typing `.\Get-WorkstationDiagnostics.ps1` at the `[Y]/[N]` Prompt
* **Why it happens:** When PowerShell asks `[Y] Yes [A] Yes to All [N] No...`, it is waiting for your reply to that prompt rather than a normal command.
* **Fix:** Type `Y` and press **Enter** first, wait for `PS ...>` to return, and then run `.\Get-WorkstationDiagnostics.ps1`.

### Error 4: `Out-File : Could not find a part of the path 'C:\Users\<User>\Desktop\IT_Diagnostics_...txt'`
* **Why it happens:** The report saves to `<UserProfile>\Desktop`, and that local `Desktop` folder did not exist yet.
* **Fix:** Create the `Desktop` folder and run the script again:
  ````powershell
  New-Item -Path "$env:USERPROFILE\Desktop" -ItemType Directory -Force
  .\Get-WorkstationDiagnostics.ps1
  ````
  * `New-Item` — Creates a new file, folder, or item.
  * `-Path "$env:USERPROFILE\Desktop"` — Sets the target path (`$env:` reads a Windows environment variable like `USERPROFILE`; double quotes `"..."` expand variables inside the text).
  * `-ItemType Directory` — Creates a folder.
  * `-Force` — Forces creation when needed.

### Error 5: `The term 'notepad' is not recognized...`
* **Why it happens:** Calling bare `notepad` did not resolve in that PowerShell session's `PATH`.
* **Fix:** Print the report in PowerShell with `Get-Content` or open `notepad.exe` using its full path:
  ````powershell
  Get-Content "$env:USERPROFILE\Desktop\IT_Diagnostics_ROG_2026-11-24_12-49.txt"
  ````
  or:
  ````powershell
  & "C:\Windows\System32\notepad.exe" "$env:USERPROFILE\Desktop\IT_Diagnostics_ROG_2026-11-24_12-49.txt"
  ````
  * `Get-Content` — Reads and prints a file's contents in the console.
  * `&` — Call operator; runs a command or file path inside quotes.

---

## 4. How the Script Works & What Each Symbol Means

* `<# ... #>` — Multi-line comment block (ignored when run; used for script documentation like `.SYNOPSIS` and `.DESCRIPTION`).
* `$VariableName = ...` — Variable assignment (`=` sets a variable to a value; `-ne` means not equal).
* `|` — Pipeline operator; passes output from the command on the left into the command on the right.
* `+=` — Appends/adds onto an existing variable (used to build `$Report` line by line).
* `$(...)` — Subexpression inside double quotes (`"..."`); runs an expression or property lookup and inserts the result into the string.
* `if (...) { } else { }` — Conditional branch based on whether a condition is true or false.
* `@()` — Creates an empty array (list).

### Pipeline Example
````powershell
$TopProcs = Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5
````
1. `Get-Process` gets running processes.
2. `|` passes them to `Sort-Object WorkingSet64 -Descending` to sort from highest memory usage to lowest.
3. `|` passes them to `Select-Object -First 5` to keep the top 5, saved into `$TopProcs`. Type `$TopProcs` on its own line to view it.

### Reading the Report
* **Uptime:** Time since last boot (`(Get-Date) - $OS.LastBootUpTime`).
* **Network & Connectivity (`PASS` / `FAIL`):** Checks local gateway ping, external ping (`8.8.8.8`), and DNS resolution (`google`). A gateway ping `FAIL` while external ping and DNS `PASS` can mean the router/AP drops ICMP pings or uses another gateway address.
* **Top 5 Memory-Consuming Processes:** Shows the five highest-memory processes at that moment (such as `brave` or `chrome` processes).
* **Saving:** `Out-File -FilePath $OutputPath -Encoding UTF8` writes `$Report` to `$OutputPath`.

---

## 5. Markdown Formatting Symbols on GitHub

| Syntax / Symbol | What It Does | Example |
| :--- | :--- | :--- |
| `#`, `##`, `###` | Headings (`#` largest, `##` section, `###` sub-section) | `## Section` |
| `---` | Horizontal rule / divider line | `---` |
| `**text**` | **Bold** text | `**Note:**` |
| `* text` or `- text` | Bullet list item | `- Item` |
| `- [ ]` / `- [x]` | Checkbox (unchecked / checked) | `- [ ] Check step` |
| `` `text` `` | Inline code | `` `Get-Process` `` |
| ```` ``` ```` | Fenced code block | Multi-line code box |
| `|` | Table column separator (`\|` escapes inside tables) | `\| A \| B \|` |
| `[Label](path.md)` | Link to a file, section, or URL | `[README](../README.md)` |
