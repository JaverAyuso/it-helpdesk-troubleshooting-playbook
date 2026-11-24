<#
.SYNOPSIS
    Collects Tier 1 system, network, and DNS diagnostic data for rapid triage and Tier 2 escalation.
.DESCRIPTION
    Gathers OS version, uptime, IPv4/Gateway/DNS settings, and tests connectivity to the local gateway,
    external IP (8.8.8.8), and DNS resolution, exporting a timestamped report to the user's Desktop.
#>

$Timestamp = Get-Date -Format "yyyy-MM-dd_HH-mm"
$OutputPath = "$env:USERPROFILE\Desktop\IT_Diagnostics_$env:COMPUTERNAME`_$Timestamp.txt"

$OS = Get-CimInstance Win32_OperatingSystem
$Uptime = (Get-Date) - $OS.LastBootUpTime
$NetConfig = Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null }
$Gateway = $NetConfig.IPv4DefaultGateway.NextHop

$Report = @()
$Report += "=========================================="
$Report += " TIER 1 WORKSTATION DIAGNOSTIC REPORT"
$Report += "=========================================="
$Report += "Generated:   $(Get-Date)"
$Report += "Hostname:    $env:COMPUTERNAME"
$Report += "User:        $env:USERNAME"
$Report += "OS Version:  $($OS.Caption) ($($OS.Version))"
$Report += "Uptime:      $($Uptime.Days)d $($Uptime.Hours)h $($Uptime.Minutes)m"
$Report += ""
$Report += "--- NETWORK CONFIGURATION ---"
$Report += "Adapter:     $($NetConfig.InterfaceAlias)"
$Report += "IPv4:        $($NetConfig.IPv4Address.IPAddress)"
$Report += "Gateway:     $Gateway"
$Report += "DNS Servers: $($NetConfig.DNSServer.ServerAddresses -join ', ')"
$Report += ""
$Report += "--- CONNECTIVITY TESTS ---"

# Test 1: Local Default Gateway
$PingGW = Test-Connection -ComputerName $Gateway -Count 2 -Quiet -ErrorAction SilentlyContinue
$Report += "1. Gateway Ping ($Gateway):   $(if ($PingGW) {'PASS'} else {'FAIL'})"

# Test 2: External Internet IP
$PingExt = Test-Connection -ComputerName 8.8.8.8 -Count 2 -Quiet -ErrorAction SilentlyContinue
$Report += "2. External Ping (8.8.8.8):   $(if ($PingExt) {'PASS'} else {'FAIL'})"

# Test 3: DNS Resolution
try {
    $null = Resolve-DnsName -Name "google.com" -ErrorAction Stop
    $Report += "3. DNS Resolution (google):   PASS"
} catch {
    $Report += "3. DNS Resolution (google):   FAIL"
}

$Report += ""
$Report += "--- TOP 5 MEMORY-CONSUMING PROCESSES ---"
$TopProcs = Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 5
foreach ($Proc in $TopProcs) {
    $MemMB = [math]::Round($Proc.WorkingSet64 / 1MB, 1)
    $Report += "$($Proc.ProcessName) - $MemMB MB"
}

$Report | Out-File -FilePath $OutputPath -Encoding UTF8
Write-Host "Diagnostic report saved to: $OutputPath" -ForegroundColor Green
