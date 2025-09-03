---
title: Troubleshooting PowerShell, Hyper-V, Storage, and Cluster Management Issues
description: Provides a comprehensive guide to troubleshooting common issues encountered in managing Hyper-V, Storage Spaces Direct (S2D), Failover Clustering, and PowerShell tasks on Windows Server (2016–2025) and Windows 10 Enterprise/Education.
ms.date: 09/03/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\remote administration of the hyper-v role
- pcy:WinComm Storage High Avail
ai-usage: ai-assisted
---
# Troubleshooting PowerShell, Hyper-V, Storage, and Cluster Management Issues on Windows Server

This article provides a comprehensive guide to troubleshooting common issues encountered in managing Hyper-V, Storage Spaces Direct (S2D), Failover Clustering, and PowerShell tasks on Windows Server (2016–2025) and Windows 10 Enterprise/Education. These issues often impact virtual machine operations, storage management, cluster communication, and automation, resulting in failures like VHD/VSS corruption and PowerShell command errors. This guide offers detailed solutions and diagnostic methodologies to resolve these challenges.

## Symptoms

End-users and administrators may experience the following issues:

### Hyper-V / Virtualization
- Virtual machine (VM) import or migration failures without explicit error messages.
- Unbootable VMs after tasks such as Optimize-VHD, with error code **0x80070570**: "The file or directory is corrupted and unreadable."
- Problems enabling processor compatibility or Promiscuous Mode via PowerShell.
- Concerns with VM live migration between cluster nodes with different CPU models.
- Failures in generating inventory or storage usage reports via PowerShell.
- Unexpected host reboots (Blue Screen of Death) after applying configuration scripts.
- PowerShell command errors, such as:    - "The property MonitorMode cannot be found on this object. Verify that the property exists and can be set."
    - "connect-VIServer: Failed to connect: Could not load file or assembly VMware.Vim, Version=8.3.0.399..."

### Storage/S2D
- get-physicaldisk and get-virtualdisk return no output or incorrect data from some cluster nodes.
- Disks appear as "unknown" or detached in PowerShell but show as healthy in Failover Cluster Manager.
- Files in App-V packages display as ‘offline’ or reparse points, and applications fail to launch.
- Volume Shadow Copy Service (VSS) commands, such as vssadmin list writers, return empty or missing writer lists.

### Cluster/Permissions
- Scheduled tasks running PowerShell scripts with Get-Cluster\*cmdlets fail on passive nodes with errors like:    - "Get-Cluster: You do not have administrative privileges on the cluster. Access is denied."
- Intermittent restoration of permissions after toggling settings or restarting services.

### General/Reporting
- Inability to enumerate disks, storage usage, or generate inventory reports via PowerShell.
- Issues connecting to Azure subscriptions using PowerShell.
- Need for guidance on adding registry keys or configuring storage/high availability on Windows 10/11.

## Cause

The root causes of these issues can be categorized as follows:

### 1. Configuration or Knowledge Gaps
- Incorrect or incomplete PowerShell command syntax.
- Limited understanding of retrieving storage or VM information using built-in tools.
- Misunderstanding CPU compatibility requirements for VM migration across different hardware.

### 2. Permission/Context Issues
- Scheduled tasks or PowerShell scripts running as the SYSTEM account lack cluster permissions, especially on passive nodes.
- User Account Control (UAC) or Group Policy restrictions limit execution contexts.
- Insufficient privileges assigned to service accounts for cluster or storage cmdlets.

### 3. Software/Driver Bugs
- Bugs introduced by Windows Server updates (for example, the May 2025 update caused VHD corruption due to a vhdmp.sys issue).
- Defects in S2D or Failover Cluster PowerShell modules leading to inconsistent disk or virtual disk information.
- Failures to update file attributes or remove reparse points during App-V package operations.

### 4. Environmental or Third-Party Interference
- Security or antivirus software interfering with VSS writers or file system operations.
- Dependencies or feature blocks caused by third-party tools (such as VMware PowerCLI, Zscaler, or Crowdstrike).
- Non-persistent disks, non-domain joined systems, or unsupported server versions.

### 5. Unsupported Scenarios
- Running commands on unsupported Windows Server versions or using scripts designed for other platforms (for example, VMware cmdlets on Hyper-V).
- Attempting advanced configuration changes (such as NIC/SR-IOV or registry tweaks) without proper testing.

## Resolution

Follow these step-by-step solutions to address the described issues.

### A. PowerShell Command and Reporting Issues
1. **Validate Command Syntax**    - Always verify PowerShell command syntax using official Microsoft documentation.
    - Example for disk and storage usage:
powershell

# On Hyper-V host

        Get-Volume | Select-Object DriveLetter, Size, SizeRemaining

# Within a VM

        Get-Volume | Select-Object -Property DriveLetter, Size, SizeRemaining
    - Export inventory:```powershellGet-VM | Select-Object -Property \* | Export-Csv -Path "C:\VMInventory.csv" -NoTypeInformation
2. **Enable VM Processor Compatibility**

    ```plaintext
    Set-VMProcessor -VMName <VMName> -CompatibilityForMigrationEnabled $true
    Set-VMProcessor -VMName <VMName> -CompatibilityForOlderOperatingSystemsEnabled $true
    Get-VMProcessor -VMName <VMName> # Confirm settings
    ```
3. **Promiscuous Mode/Monitor Mode**    - Use correct property names (for example, AllowPacketDirect instead of MonitorMode for Hyper-V vSwitches).
    - Cross-check third-party documentation with official Microsoft sources.
4. **Azure PowerShell Authentication**

    ```plaintext
    Install-Module Az -Scope CurrentUser
    Import-Module Az
    Connect-AzAccount
    Set-AzContext -Subscription "<subscription-name-or-id>"
    ```
5. **Resolve VMware PowerCLI Errors**    - Ensure PowerCLI is installed from the official source and check VMware support for missing assembly issues.

### B. Cluster and Permission Issues
1. **Resolve Access Denied Errors**    - Use a domain service account with appropriate permissions for cluster management scripts.
    - If using SYSTEM, toggle permissions in Failover Cluster Manager:        - Remove and re-add SYSTEM account with "Allow" permissions.
        - Restart cluster-related services.
2. **Fix Storage Cmdlet Failures**    - Reboot all cluster nodes to reset states and clear inconsistencies.
    - Collect diagnostic logs:```powershellGet-SddcDiagnosticInfo -Path

### C. Storage, File System, and VHD Issues
1. **VHD Corruption**    - Install the June 2025 cumulative update to fix the vhdmp.sys bug.
    - Disable scheduled Optimize-VHD tasks until updates are applied.
    - Review installed updates:```powershellGet-HotFix | Sort-Object InstalledOn -Descending
2. **App-V Package File Issues**    - Analyze file attributes:

        ```plaintext
        Get-ChildItem -Path <package-path> -Recurse | Select-Object FullName, Attributes
        ```
    - Disable third-party software causing interference.
3. **Resolve Missing VSS Writers**    - Restart the VSS service:```powershellRestart-Service -Name VSS

### D. General Configuration/Registry/High Availability
1. **Add Registry Keys**

    ```plaintext
    Set-ItemProperty -Path "HKLM:\Software\<Path>" -Name "<Key>" -Value "<Value>"
    ```
2. **Handle Cluster Nodes with Different CPUs**    - Enable CPU compatibility for VMs during migration:        - VM Settings > Processor > "Migrate to a physical computer with a different processor version."
3. **Avoid Advanced Configuration Risks**    - Test advanced NIC properties (such as SR-IOV) thoroughly before deployment.
    - Use modern browsers instead of disabling Internet Explorer Enhanced Security.

## Data Collection

Gather the following data if further assistance is needed:
- PowerShell outputs (for example, Get-Volume, Get-VM, Get-PhysicalDisk).
- Diagnostics from the TSS tool.
- Logs using Get-SddcDiagnosticInfo.
- VSS status with vssadmin list writers.
- Installed hotfixes using Get-HotFix.

## References

For additional guidance, consult the official Microsoft documentation for Hyper-V, S2D, PowerShell, and Failover Clustering. Always ensure your environment is fully patched and your configuration is tested in a non-production environment before making substantial changes.