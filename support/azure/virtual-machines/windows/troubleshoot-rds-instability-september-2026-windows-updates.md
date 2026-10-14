---
title: Troubleshoot Remote Desktop Services instability after September 2026 Windows security updates
description: Diagnose and resolve Remote Desktop Services instability caused by the September 2026 Windows security updates on Azure Windows virtual machines.
manager: dcscontentpm
author: kaushika-msft
ms.author: kaushika
ms.date: 09/28/2026
ms.reviewer: dougking, scotro, jdickson
ms.service: azure-virtual-machines
ms.topic: troubleshooting
ms.collection: windows
ai-usage: ai-assisted
---

# Troubleshoot Remote Desktop Services instability after the September 2026 Windows security updates

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

This article helps you diagnose and resolve Remote Desktop Services instability caused by the September 2026 Windows security updates on Azure Windows virtual machines.

After you install a September 2026 Windows security update, Remote Desktop Services (RDS) might become unstable. Remote Desktop Protocol (RDP) connections, sign-in, and related management tools might stop responding. Install the latest available Windows cumulative update, or the matching September 2026 out-of-band (OOB) update, to resolve the issue.

> [!NOTE]
> This issue doesn't affect Windows 365 or Azure Virtual Desktop.

## Prerequisites

Ensure you meet the following prerequisites before attempting to troubleshoot the issue:

- Use an account that has local admin permissions on the affected virtual machine (VM).
- If RDP isn't available, make sure that you have permission to use [Run Command on a Windows VM](/azure/virtual-machines/windows/run-command).
- Before you perform an offline repair, create a snapshot or backup of the operating system (OS) disk.

## How to identify the issue

### Symptoms

An affected device might show one or more of the following symptoms:

- RDP connections fail or stay at **Connecting**.
- Sign-in fails or stays at **Welcome**.
- The server stays at **Please wait for the Remote Desktop Configuration**.
- RDS becomes unstable or stops responding.
- Microsoft Management Console (MMC), RDS Licensing Diagnoser, or File Explorer stops responding.
- The Windows Update page stops responding and continuously shows a loading indicator.

You might receive one of the following errors:

```output
The task you are trying to do can't be completed because Remote Desktop Services is currently busy.
```

```output
A licensing error occurred while the client was attempting to connect (licensing timed out).
```

```output
This computer can't connect to the remote computer.
```

### Affected updates and corresponding OOB updates

The following table maps each affected September 2026 update to the corresponding OOB update.

| Operating system | Affected update | OOB update |
| --- | --- | --- |
| Windows 11, version 26H1 | KB5124012 | KB5129194 |
| Windows 11, versions 24H2 and 25H2 | KB5122880 | KB5129195 |
| Windows 11, versions 24H2 and 25H2 with hotpatch | KB5122880 | KB5129241 |
| Windows 11, version 23H2 | KB5122880 | KB5129242 |
| Windows Server 2025 | KB5122871 | KB5129235 |
| Windows Server 2022 | KB5122882 | KB5129237 |
| Windows 10, version 22H2, and Windows 10 Enterprise LTSC 2021 | KB5122878 | KB5129236 |
| Windows Server 2019 and Windows 10 Enterprise LTSC 2019 | KB5122876 | KB5129238 |
| Windows Server 2016 and Windows 10 Enterprise LTSB 2016 | KB5123099 | KB5129239 |
| Windows Server 2012 R2 | KB5123066 | KB5129243 |
| Windows Server 2012 | KB5123065 | KB5129244 |

> [!IMPORTANT]
> KB5129241 applies only to eligible Windows 11, versions 24H2 and 25H2, devices that use hotpatch updates. Verify the hotpatch prerequisites before you deploy this update.

> [!NOTE]
> Windows Server 2012 and Windows Server 2012 R2 devices require the applicable servicing stack prerequisites. Windows might not offer the OOB update if a prerequisite is missing.

For the public status and resolution summary, see [Resolved issues in Windows Server 2025](/windows/release-health/resolved-issues-windows-server-2025#issue-details).

### Confirm the operating system

If RDP isn't available, run the following commands through Azure VM Run Command.

```powershell
Get-ComputerInfo |
    Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
```

### Confirm the installed updates

The following example checks a Windows Server 2022 device for the affected September update and its corresponding OOB update. Run the following command.

```powershell
Get-HotFix -Id KB5122882,KB5129237
```

To list installed hotfixes, run the following command.

```powershell
Get-HotFix
```

If `Get-HotFix` doesn't return the package, use Deployment Image Servicing and Management (DISM) cmdlets. The following Windows Server 2022 example searches for both package numbers. Run the following command.

```powershell
Get-WindowsPackage -Online |
    Where-Object PackageName -Match '5122882|5129237' |
    Select-Object PackageName, PackageState, ReleaseType, InstallTime
```

### Identify the affected server role

On a Windows Server device, list the installed RDS roles. Run the following command.

```powershell
Get-WindowsFeature RDS-* |
    Where-Object InstallState -EQ 'Installed'
```

Determine whether the affected system is one of the following endpoints. This step helps you identify which servers need the corrective update. These endpoints include the following:

- Remote Desktop Session Host
- Remote Desktop Connection Broker
- Remote Desktop Gateway
- Remote Desktop Licensing
- Remote Desktop Web Access
- A server that uses RDP only for administration
- A domain controller that also serves as an RDP endpoint
- A device that uses only the outbound RDP client

Install the corrective update on every affected endpoint. Updating a client, domain controller, or separate RDS role doesn't correct an affected host that hasn't received the update.

### Check RDS services, sessions, and event logs

Check the RDS services to ensure they're running correctly. Run the following command.

```powershell
Get-Service -Name TermService,SessionEnv,UmRdpService
```

List the sessions to see which users are currently connected. Run the following command.

```powershell
quser
```

> [!CAUTION]
> `quser` output can contain usernames and session identifiers. Redact personal or organization-specific information before you share the output.

Review the following event logs:

- `Microsoft-Windows-TerminalServices-LocalSessionManager/Operational`
- `Microsoft-Windows-TerminalServices-RemoteConnectionManager/Operational`
- `Microsoft-Windows-RemoteDesktopServices-RdpCoreTS/Operational`
- `System`
- `Application`

## Root cause

The September 2026 Windows security updates introduced an issue that can destabilize RDS and related Windows management components. Microsoft resolved the issue in OOB cumulative updates released on September 14, 2026, and in later cumulative updates.

## Resolution

### Install the latest cumulative update

Install the latest cumulative update available for the affected operating system. The latest cumulative update contains the RDS correction and subsequent security and quality improvements.

If your update-management policy requires the September 2026 OOB update, use the table in this article to select the update that matches the affected operating system.

Follow these steps:

1. Identify the affected September 2026 update.
1. Select the matching OOB update.
1. Verify the operating system and update prerequisites.
1. Install the OOB update directly. You don't have to uninstall the September update first.
1. Restart the device if the update requires a restart.
1. Repeat these steps on every affected RDS or RDP endpoint.

You can obtain standalone packages from the [Microsoft Update Catalog](https://catalog.update.microsoft.com/).

### Deploy the update through WSUS

The OOB updates synchronize with Windows Server Update Services (WSUS). Approve the matching update for the affected device groups, and then monitor installation compliance.

If you must import an update manually, follow [WSUS and the Microsoft Update Catalog](/windows-server/administration/windows-server-update-services/manage/wsus-and-the-catalog-site).

#### Troubleshoot a manual-import Transport Layer Security failure

If a manual import fails, review the following log:

```text
%ProgramFiles%\Update Services\LogFiles\SoftwareDistribution.log
```

The log might contain the following error:

```output
ProcessWebServiceProxyException found Exception was WebException. Action: Retry.
Exception Details: System.Net.WebException:
The underlying connection was closed:
An unexpected error occurred on a send.
---> System.IO.IOException:
Unable to read data from the transport connection:
An existing connection was forcibly closed by the remote host.
```

Before you change the registry, verify the following items:

- Custom Transport Layer Security (TLS) cipher ordering
- Schannel restrictions
- TLS inspection devices
- Corporate proxies and firewalls

> [!WARNING]
> Incorrect registry changes can cause serious problems. Follow your organization's change-control and registry-backup requirements before you continue.

To configure the .NET Framework to use system-default TLS versions and strong cryptography, run the following PowerShell commands in an elevated session.

```powershell
$paths = @(
    'HKLM:\SOFTWARE\Microsoft\.NETFramework\v2.0.50727',
    'HKLM:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v2.0.50727',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v4.0.30319'
)

foreach ($path in $paths) {
    New-Item -Path $path -Force | Out-Null
    Set-ItemProperty -Path $path -Name 'SystemDefaultTlsVersions' -Value 1 -Type DWord
    Set-ItemProperty -Path $path -Name 'SchUseStrongCrypto' -Value 1 -Type DWord
}
```

To validate TLS 1.2 in the current PowerShell process, run the following command.

```powershell
[Net.ServicePointManager]::SecurityProtocol =
    [Net.SecurityProtocolType]::Tls12
```

Depending on the operating system, you can request an update scan by using one of the following commands.

```cmd
wuauclt /detectnow
```

```cmd
UsoClient StartScan
```

If the import still fails, contact the support team that manages your WSUS or Microsoft Configuration Manager environment.

### Repair the VM offline

Use offline repair only if both RDP and Azure VM Run Command are unavailable.

Follow these steps:

1. Create a snapshot of the affected OS disk.
1. Stop and deallocate the affected VM.
1. Use [Azure Virtual Machine repair commands](./repair-windows-vm-using-azure-virtual-machine-repair-commands.md) to create a repair VM and attach a copy of the OS disk.
1. Install the matching OOB update on the offline OS disk. If the OOB update can't be installed, remove the affected September update as a temporary recovery action.
1. Restore the repaired disk to the original VM.
1. Start the VM, and then complete the validation steps.
1. Remove the snapshot only after you confirm that the VM works as expected.

## Validate the resolution

Confirm all the following conditions:

- The matching OOB update or a later cumulative update is installed.
- `TermService`, `SessionEnv`, and `UmRdpService` are running when the server role requires them.
- New RDP connections succeed.
- Interactive sign-in and sign-out succeed.
- Existing sessions remain responsive.
- MMC opens and remains responsive.
- File Explorer opens and remains responsive.
- The Windows Update page opens and remains responsive.
- RDS Licensing Diagnoser opens and remains responsive.
- Remote Desktop Gateway, Connection Broker, and Licensing paths work as expected.
- The RDS and Windows event logs don't show new occurrences of the original failure.

## Next steps

If the issue continues after you install the corrective update, follow these steps:

1. Record the OS edition, version, and build.
1. Record the affected September update and the corrective update.
1. Record the installed RDS roles and whether the VM is a domain controller.
1. Note whether users connect directly or through Remote Desktop Gateway or Connection Broker.
1. Record the exact error text and failure timestamps.
1. Export the relevant event logs.
1. Remove or redact usernames, session identifiers, tenant details, and other organization-specific information before you share diagnostic data.
1. Contact Microsoft Support.
