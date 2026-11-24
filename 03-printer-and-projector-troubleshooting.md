# SOP 03: Office Printer & Classroom Projector Troubleshooting

**Category:** Peripherals & Presentation Hardware  
**Target Environment:** Windows 10/11 Workstations, Network Printers, HDMI/USB-C Projectors  
**Estimated Resolution Time:** 5–15 minutes  

---

## 1. Symptoms
* Print jobs remain stuck in the queue with status **"Printing"**, **"Error"**, or **"Offline"**.
* Printer does not respond despite being powered on and connected to the network.
* Classroom or conference room projector displays **"No Signal"**, a black screen, or cuts off presentation slides.

## 2. Part A: Network & USB Printer Resolution

### Step 1: Verify Power, Paper & Network Status
1. Confirm the printer display is awake, free of paper jam alerts, and loaded with paper/toner.
2. **Network Printer:** Print a Network Configuration page from the printer panel (or check its IP address) and verify it is on the same subnet as the user's PC.
3. **USB Printer:** Reseat the USB cable at both ends and test a different USB port on the PC.

### Step 2: Check Windows Printer Status
1. Open **Settings > Bluetooth & devices > Printers & scanners** (or **Control Panel > Devices and Printers**).
2. Select the affected printer and click **Open print queue**.
3. Click **Printer** in the top menu bar and ensure neither **Pause Printing** nor **Use Printer Offline** is checked.

### Step 3: Restart the Print Spooler Service & Clear Stuck Jobs
If jobs remain stuck in the queue:
1. Open **Command Prompt as Administrator** (`Win + X` → **Terminal (Admin)** or **Command Prompt (Admin)**).
2. Run the following commands in order to stop the spooler, clear corrupted queue files, and restart the service:
```cmd
net stop spooler
del /Q /F %systemroot%\System32\spool\PRINTERS\*.*
net start spooler
