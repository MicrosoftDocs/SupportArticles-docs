---
title: Troubleshoot PowerShell, Hyper-V, Storage, and Cluster Management Issues
description: Provides a comprehensive guide to troubleshooting common issues in managing Hyper-V, Storage Spaces Direct (S2D), Failover Clustering, and PowerShell tasks in Windows Server 2016, Windows Server 2019, Windows Server 2022, Windows Server 2025, and Windows 10 Enterprise/Education.
ms.date: 02/12/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, jeffhugh, v-lianna
ms.custom:
- sap:virtualization and hyper-v\powershell cmdlets
- pcy:WinComm Storage High Avail
ai-usage: ai-assisted
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Troubleshoot PowerShell, Hyper-V, storage, and cluster management issues in Windows Server

This article provides a comprehensive guide to troubleshooting common issues encountered in managing Hyper-V, Storage Spaces Direct (S2D), Failover Clustering, and PowerShell tasks in Windows Server 2016, Windows Server 2019, Windows Server 2022, Windows Server 2025, and Windows 10 Enterprise/Education. These issues often impact virtual machine operations, storage management, cluster communication, and automation, resulting in failures like VHD/VSS corruption and PowerShell cmdlet errors. This guide offers detailed solutions and diagnostic methodologies to resolve these challenges.

You might experience the following issues:

## Hyper-V/Virtualization issues

- Virtual machine (VM) import or migration failures without explicit error messages.
- Unbootable VMs after tasks such as Optimize-VHD, with error code 0x80070570:
  
  > The file or directory is corrupted and unreadable.
- Problems enabling processor compatibility or Promiscuous Mode via PowerShell.
- Concerns with VM live migration between cluster nodes with different CPU models.
- Failures in generating inventory or storage usage reports via PowerShell.
- Unexpected host reboots (blue screen of death) after applying configuration scripts.
- PowerShell cmdlets errors, such as:

  - > The property MonitorMode cannot be found on this object. Verify that the property exists and can be set.
  - > connect-VIServer: Failed to connect: Could not load file or assembly VMware.Vim, Version=8.3.0.399...

## Storage/S2D issues

- `Get-PhysicalDisk` and `Get-VirtualDisk` return no output or incorrect data from some cluster nodes.
- Disks appear as "unknown" or detached in PowerShell but show as healthy in Failover Cluster Manager.
- Files in App-V packages display as **offline** or reparse points, and applications fail to launch.
- Volume Shadow Copy Service (VSS) commands, such as `vssadmin list writers`, return empty or missing writer lists.

## Cluster/Permissions issues

- Scheduled tasks running PowerShell scripts with `Get-Cluster*` cmdlets fail on passive nodes with errors like:

  > Get-Cluster: You do not have administrative privileges on the cluster. Access is denied.
- Intermittent restoration of permissions after toggling settings or restarting services.

## General/Reporting issues

- Inability to enumerate disks, storage usage, or generate inventory reports via PowerShell.
- Issues connecting to Azure subscriptions using PowerShell.
- Need for guidance on adding registry keys or configuring storage/high availability on Windows 10 or Windows 11.

The root causes of these issues can be categorized as follows:

## Cause 1: Configuration or knowledge gaps

- Incorrect or incomplete PowerShell cmdlet syntax.
- Limited understanding of retrieving storage or VM information using built-in tools.
- Misunderstanding CPU compatibility requirements for VM migration across different hardware.

## Cause 2: Permission/Context issues

- Scheduled tasks or PowerShell scripts running as the SYSTEM account lack cluster permissions, especially on passive nodes.
- User Account Control (UAC) or Group Policy restrictions limit execution contexts.
- Insufficient privileges assigned to service accounts for cluster or storage cmdlets.

## Cause 3: Software/Driver bugs

- Bugs introduced by Windows Server updates (for example, the May 2025 update caused VHD corruption due to a **vhdmp.sys** issue).
- Defects in S2D or Failover Cluster PowerShell modules leading to inconsistent disk or virtual disk information.
- Failures to update file attributes or remove reparse points during App-V package operations.

## Cause 4: Environmental or third-party interference

- Security or antivirus software interfering with VSS writers or file system operations.
- Dependencies or feature blocks caused by third-party tools (such as VMware PowerCLI, Zscaler, or Crowdstrike).
- Non-persistent disks, nondomain joined systems, or unsupported server versions.

## Cause 5: Unsupported scenarios

- Running commands on unsupported Windows Server versions or using scripts designed for other platforms (for example, VMware cmdlets on Hyper-V).
- Attempting advanced configuration changes (such as NIC/SR-IOV or registry tweaks) without proper testing.

Follow these step-by-step solutions to address the described issues.

## Resolution for PowerShell cmdlet and reporting issues

1. Validate cmdlet syntax:

   - Always verify PowerShell cmdlet syntax using official Microsoft documentation.
   - Examples for disk and storage usage:

     On Hyper-V host:

     ```powershell
     Get-Volume | Select-Object DriveLetter, Size, SizeRemaining
     ```

     Within a VM:

     ```powershell
     Get-Volume | Select-Object -Property DriveLetter, Size, SizeRemaining
     ```

   - Export inventory:

     ```powershell
     Get-VM | Select-Object -Property * | Export-Csv -Path "C:\VMInventory.csv" -NoTypeInformation
     ```

2. Enable VM processor compatibility:

    ```powershell
    Set-VMProcessor -VMName <VMName> -CompatibilityForMigrationEnabled $true
    Set-VMProcessor -VMName <VMName> -CompatibilityForOlderOperatingSystemsEnabled $true
    Get-VMProcessor -VMName <VMName> # Confirm settings
    ```

3. Promiscuous mode/Monitor mode:

   - Use correct property names (for example, AllowPacketDirect instead of MonitorMode for Hyper-V vSwitches).
   - Cross-check third-party documentation with official Microsoft sources.

4. Azure PowerShell authentication:

    ```powershell
    Install-Module Az -Scope CurrentUser
    Import-Module Az
    Connect-AzAccount
    Set-AzContext -Subscription "<subscription-name-or-id>"
    ```

5. Resolve VMware PowerCLI errors.

   Ensure PowerCLI is installed from the official source and check VMware support for missing assembly issues.

## Resolution for cluster and permission issues

1. Resolve access denied errors:

    - Use a domain service account with appropriate permissions for cluster management scripts.
    - If using SYSTEM, toggle permissions in Failover Cluster Manager:
        - Remove and re-add SYSTEM account with "Allow" permissions.
        - Restart cluster-related services.
2. Fix storage cmdlet failures:

    - Reboot all cluster nodes to reset states and clear inconsistencies.
    - Collect diagnostic logs:

      ```powershell
      Get-SddcDiagnosticInfo -Path
      ```

## Resolution for storage, file system, and VHD issues

1. VHD corruption:

   - Install the June 2025 cumulative update to fix the **vhdmp.sys** bug.
   - Disable scheduled `Optimize-VHD` tasks until updates are applied.
   - Review installed updates:

     ```powershell
     Get-HotFix | Sort-Object InstalledOn -Descending
     ```

2. App-V Package File Issues:

   - Analyze file attributes:

     ```powershell
     Get-ChildItem -Path <package-path> -Recurse | Select-Object FullName, Attributes
     ```

   - Disable third-party software causing interference.

3. Resolve missing VSS writers by restarting the VSS service:

   ```powershell
   Restart-Service -Name VSS
   ```

## Resolution for general configuration/registry/high availability issues

1. Add registry keys:

   ```powershell
   Set-ItemProperty -Path "HKLM:\Software\<Path>" -Name "<Key>" -Value "<Value>"
   ```

2. Handle cluster nodes with different CPUs.

   Enable CPU compatibility for VMs during migration: VM **Settings** > **Processor** > **Migrate to a physical computer with a different processor version**.

3. Avoid advanced configuration risks:

   - Test advanced NIC properties (such as SR-IOV) thoroughly before deployment.
   - Use modern browsers instead of disabling Internet Explorer Enhanced Security.

## Data collection

Gather the following data if further assistance is needed:

- PowerShell outputs (for example, `Get-Volume`, `Get-VM`, or `Get-PhysicalDisk`).
- Diagnostics from the TSS tool.
- Logs using `Get-SddcDiagnosticInfo`.
- VSS status with `vssadmin list writers`.
- Installed hotfixes using `Get-HotFix`.

For more information, see the official Microsoft documentation for Hyper-V, S2D, PowerShell, and Failover Clustering. Always ensure your environment is fully patched and your configuration is tested in a nonproduction environment before making substantial changes.
