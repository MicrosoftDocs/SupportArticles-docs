---
title: Troubleshoot Windows Update network and proxy issues on Azure VMs
description: Learn how to diagnose and fix network connectivity, proxy, and firewall issues that block Windows Update on Azure virtual machines.
author: scotro
ms.author: scotro
ms.reviewer: jarrettr, macla, glimoli, azurevmcptcic
manager: dcscontentpm
ms.service: azure-virtual-machines
ms.collection: windows
ms.topic: troubleshooting
ms.date: 07/13/2026
ms.custom:
- sap:Windows Update and OS Upgrades
- pcy:WinComm Devices Deploy
---

# Troubleshoot Windows Update network and proxy issues on Azure VMs

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you diagnose and fix network and proxy configuration issues that prevent Windows Update from downloading or installing updates on Azure virtual machines (VMs). Azure VMs must reach specific Windows Update endpoints to scan for, download, and install updates. Network Security Group (NSG) rules, User Defined Routes (UDRs), proxy configurations, and firewall appliances can block these connections.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

## Symptoms

Network and proxy issues typically produce one of the following symptoms:

- Windows Update scans complete but no updates are found, even though updates are available.
- Windows Update fails during download with one of the following error codes:

  | Error code | Name | Description |
  |---|---|---|
  | 0x80072EE7 | WININET_E_NAME_NOT_RESOLVED | The server name or address can't be resolved. |
  | 0x80072EFD | WININET_E_CANNOT_CONNECT | A connection with the server can't be established. |
  | 0x80072F8F | WININET_E_DECODING_FAILED | SSL/TLS certificate validation failed. |
  | 0x80244022 | WU_E_PT_HTTP_STATUS_SERVICE_UNAVAIL | The HTTP request returned a 503 status. |
  | 0x8024401C | WU_E_PT_HTTP_STATUS_REQUEST_TIMEOUT | The HTTP request timed out. |
  | 0x8024402C | WU_E_PT_WINHTTP_NAME_NOT_RESOLVED | Same as 0x80072EE7 — DNS resolution failure. |
  | 0x80240438 | WU_E_NETWORK_ERROR | General network connectivity failure. |

- Updates download successfully but fail to install with authentication or proxy errors.
- The `WindowsUpdate.log` shows entries such as `WINHTTP_CALLBACK_STATUS_FLAG_CERT_REV_FAILED` or `Send failed with hr = 80072efd`.

## Cause

The most common causes of Windows Update network failures on Azure VMs are:

- **NSG rules blocking outbound traffic**: Restrictive NSG outbound rules that don't allow access to Windows Update endpoints.
- **UDR forcing traffic through a firewall appliance**: Routes that direct internet-bound traffic through a Network Virtual Appliance (NVA) that doesn't allow Windows Update URLs.
- **Proxy misconfiguration**: A proxy configured in WinHTTP or the system environment that doesn't pass through Windows Update traffic.
- **DNS resolution failures**: Custom DNS settings that can't resolve Windows Update hostnames.
- **TLS/certificate issues**: The VM's trusted root certificates are outdated, causing SSL/TLS validation failures when connecting to Windows Update.
- **WSUS misconfiguration**: Group Policy is pointing the VM to a Windows Server Update Services (WSUS) server that's inaccessible or not configured. For Azure VMs, [Azure Update Manager](/azure/update-manager/overview) is recommended instead of WSUS.

## Resolution

### Step 1: Test connectivity to Windows Update endpoints

Verify that the VM can reach the required Windows Update endpoints. Run the following commands from an elevated PowerShell session on the VM:

#### [Run Command (recommended)](#tab/runcommand)

```powershell
# Test DNS resolution
Resolve-DnsName "windowsupdate.microsoft.com" -ErrorAction SilentlyContinue | Format-Table Name, IPAddress

# Test HTTPS connectivity to key endpoints
$endpoints = @(
    "https://windowsupdate.microsoft.com",
    "https://update.microsoft.com",
    "https://download.windowsupdate.com",
    "https://dl.delivery.mp.microsoft.com"
)

foreach ($ep in $endpoints) {
    try {
        $response = Invoke-WebRequest -Uri $ep -UseBasicParsing -TimeoutSec 10 -ErrorAction Stop
        Write-Output "OK   $ep (Status: $($response.StatusCode))"
    }
    catch {
        Write-Output "FAIL $ep ($($_.Exception.Message))"
    }
}
```

#### [RDP session](#tab/rdp)

Open an elevated PowerShell session and run:

```powershell
Test-NetConnection -ComputerName "windowsupdate.microsoft.com" -Port 443
Test-NetConnection -ComputerName "download.windowsupdate.com" -Port 443
Test-NetConnection -ComputerName "dl.delivery.mp.microsoft.com" -Port 443
```

---

If any endpoint is unreachable, proceed to Step 2 to identify the blocking component.

### Step 2: Check NSG and firewall rules

Review the NSG rules on the VM's network interface and subnet:

1. In the [Azure portal](https://portal.azure.com), go to **Virtual machines** > your VM > **Networking** > **Network settings**.
1. Review the **Outbound port rules** for both the NIC-level and subnet-level NSGs.
1. Verify that outbound HTTPS (port 443) traffic to the internet or to the **WindowsUpdate** [service tag](/azure/virtual-network/service-tags-overview) is allowed.

If you use a firewall appliance or NVA, verify that it allows traffic to the following domains:

- `*.windowsupdate.microsoft.com`
- `*.update.microsoft.com`
- `*.download.windowsupdate.com`
- `*.dl.delivery.mp.microsoft.com`
- `*.delivery.mp.microsoft.com`
- `login.microsoftonline.com` (for authentication)

### Step 3: Check and fix proxy settings

Azure VMs might have proxy settings configured at the WinHTTP level or in environment variables.

#### Check WinHTTP proxy settings

```cmd
netsh winhttp show proxy
```

If a proxy is configured and it shouldn't be, reset it:

```cmd
netsh winhttp reset proxy
```

#### Check environment variables

```powershell
[System.Environment]::GetEnvironmentVariable("HTTP_PROXY", "Machine")
[System.Environment]::GetEnvironmentVariable("HTTPS_PROXY", "Machine")
```

If these variables are set incorrectly, remove them:

```powershell
[System.Environment]::SetEnvironmentVariable("HTTP_PROXY", $null, "Machine")
[System.Environment]::SetEnvironmentVariable("HTTPS_PROXY", $null, "Machine")
```

#### Check Group Policy proxy settings

```cmd
gpresult /h C:\Temp\gpresult.html
```

Open the generated report and search for proxy-related policies under **Computer Configuration** > **Administrative Templates** > **Windows Components** > **Internet Explorer** > **Proxy Settings**.

### Step 4: Check update source configuration (WSUS vs. Windows Update)

If the VM is configured to receive updates from a WSUS server, verify that the WSUS server is reachable and correctly configured.

#### Check the current update source

```powershell
$wuKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
if (Test-Path $wuKey) {
    Get-ItemProperty $wuKey | Select-Object WUServer, WUStatusServer, UseWUServer
} else {
    Write-Output "No WSUS policy configured - using Windows Update directly"
}
```

If `UseWUServer` is set to `1`, the VM uses WSUS. Verify that the `WUServer` URL is accessible from the VM.

#### Switch from WSUS to Windows Update

If the WSUS server is inaccessible and you need updates immediately, temporarily switch to Windows Update:

```powershell
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" -Name "UseWUServer" -Value 0
Restart-Service wuauserv
```

> [!IMPORTANT]
> For long-term management, configure [Azure Update Manager](/azure/update-manager/overview) instead of managing WSUS configuration manually. Azure Update Manager handles update scanning and installation natively without requiring WSUS infrastructure. See [Configure Windows Update settings for Azure Update Manager](/azure/update-manager/configure-wu-agent).

### Step 5: Fix TLS and certificate issues

If you see error 0x80072F8F (SSL/TLS error), the issue might be caused by expired or missing root certificates, or disabled TLS versions.

#### Check the system clock

An incorrect system clock causes certificate validation to fail:

```powershell
w32tm /query /status
w32tm /resync
```

#### Verify TLS 1.2 is enabled

```powershell
# Check TLS 1.2 client setting
$tlsPath = "HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client"
if (Test-Path $tlsPath) {
    Get-ItemProperty $tlsPath | Select-Object Enabled, DisabledByDefault
} else {
    Write-Output "TLS 1.2 not explicitly configured (enabled by default on Server 2016+)"
}
```

#### Update root certificates

If the VM has been isolated from the internet for an extended period, the root certificate store might be outdated:

```cmd
certutil -generateSSTFromWU C:\Temp\roots.sst
```

If this command fails because the VM can't reach the certificate distribution point, manually download the root certificates from another machine and import them.

### Step 6: Reset Windows Update components

After fixing network or proxy issues, reset Windows Update components to clear any cached error state:

Use the [Azure VM Windows Update Reset Tool](windows-vm-wureset-tool.md) to automate the reset.

Then retry Windows Update. If the update downloads and installs successfully, the network or proxy issue is resolved.

## Collect logs for further investigation

If you can't resolve the issue by using the steps in this article, collect the following logs before you contact Azure support:

- **WindowsUpdate.log:** On modern Windows versions, generate this log by running `Get-WindowsUpdateLog` in an elevated PowerShell session.
- **Proxy configuration:** Run `netsh winhttp show proxy` and save the output.
- **NSG rules:** Run `az network nsg rule list -g <resource-group> --nsg-name <nsg-name> -o table` and save the output.
- **DNS resolution test:** Run `Resolve-DnsName windowsupdate.microsoft.com` and save the output.

## References

- [Troubleshoot Windows Update failures on Azure VMs](troubleshoot-windows-update-azure-vm.md)
- [Configure Windows Update settings for Azure Update Manager](/azure/update-manager/configure-wu-agent)
- [Troubleshoot known issues with Azure Update Manager](/azure/update-manager/troubleshoot)
- [Azure virtual network service tags](/azure/virtual-network/service-tags-overview)
- [Fix Windows Update corruptions and installation failures](/troubleshoot/windows-server/installing-updates-features-roles/fix-windows-update-errors)
- [Azure VM Windows Update Reset Tool](windows-vm-wureset-tool.md)

[!INCLUDE [Third-party contact disclaimer](~/includes/third-party-contact-disclaimer.md)]
