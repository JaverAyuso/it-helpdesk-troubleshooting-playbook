<#
.SYNOPSIS
    Collects Tier 1 system, network, and DNS diagnostic data for rapid triage and Tier 2 escalation.
.DESCRIPTION
    Gathers OS version, uptime, C: drive storage, IPv4/Gateway/DNS settings, and tests connectivity
    to the local gateway, external IP (8.8.8.8), and DNS resolution, exporting a timestamped report.
#>

param(
    [string]$OutputPath = "$env:USERPROFILE\Desktop\IT_Diagnostics_$($env:COMPUTERNAME)_$(Get-Date -Format 'yyyy-MM-dd_HH-mm').txt"
)

$OS = Get-CimInstance Win32_OperatingSystem
$Uptime = (Get-Date) - $OS.LastBootUpTime
$DriveC = Get-PSDrive -Name C -ErrorAction SilentlyContinue
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
if ($DriveC) {
    $FreeGB  = [math]::Round($DriveC.Free / 1GB, 1)
    $TotalGB = [math]::Round(($DriveC.Used + $DriveC.Free) / 1GB, 1)
    $Report += "C: Storage:  $FreeGB GB free of $TotalGB GB"
} else {
    $Report += "C: Storage:  Unavailable"
}
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

$OutputDir = Split-Path -Path $OutputPath -Parent
if (-not (Test-Path -Path $OutputDir)) {
    New-Item -Path $OutputDir -ItemType Directory -Force | Out-Null
}

$Report | Out-File -FilePath $OutputPath -Encoding UTF8
Write-Host "Diagnostic report saved to: $OutputPath" -ForegroundColor Green
