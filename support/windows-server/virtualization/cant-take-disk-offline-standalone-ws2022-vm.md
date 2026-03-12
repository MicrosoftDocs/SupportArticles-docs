---
title: Can't take a disk offline in a standalone Windows Server 2022 VM
description: 
ms.date: 03/13/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, simonw, v-appelgate
ai-usage: ai-assisted
ms.custom:
- sap:virtualization and hyper-v\storage configuration
- pcy:WinComm Storage High Avail
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---
# Can't take a disk offline in a standalone Windows Server 2022 VM

This article describes an issue where you cannot take a disk offline in a standalone virtual machine (VM) that runs Windows Server 2022. The issue can cause the system to hang during the process, which affects critical workloads. Use this information to identify the symptoms, understand the possible causes, and follow the recommended steps to resolve the issue.

## Symptoms

You're running a standalone (non-clustered) Windows Server 2022 VM, and you haven't made any recent changes to the VM or its hypervisor platform. You repeatedly try to manually take a disk offline. However, the disk remains online. Additionally, you experience the following symptoms:

- If you try to use the Disk Management or DiskPart tools to take the disk offline, the VM becomes unresponsive or hangs.
- The issue persists over multiple days.

## Possible causes

The underlying cause of this issue is likely to be one or more of the following factors:

- Disk configuration issues that cause the system to become unresponsive when it processes the offline request.
- An issue in the virtual machine's storage subsystem or virtual disk controller.
- Corruption or errors on the disk.

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the affected disk. For information about backup options, see the documentation for your VM platform. For example, if you are using Azure VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

To fix this issue, follow these steps:

1. Check for Windows Server 2022 updates, and install any pending updates. Notice if any of the updates address disk management or storage subsystem issues.
1. To assess the disk health and fix underlying issues, see the [Troubleshooting checklist](troubleshoot-data-corruption-and-disk-errors.md#troubleshooting-checklist) section of "Data corruption and disk errors troubleshooting guidance." In particular, follow the steps in the following checklist sections:

   1. **Scan the health of the storage system**. Scan for issues without making any changes.
   1. **Review the event log for relevant events**. Review event log entries that cover the period when the issue occurred. This section provides a list of events that correspond to specific issues that the troubleshooting guide addresses.
   1. **Scan and repair NTFS volumes**. Perform a more intensive investigation of the disk, and run repair tools.

1. If you still can't isolate the issue, create an identical VM and disk configuration in a test environment, and try to reproduce the symptoms.
1. If the disk is not the system disk and can be safely detached, remove it from the VM and attach it to a different VM. Check the health of the disk again in the new configuration.
1. After you make changes, continue to monitor the disk. If the issue persists or reoccurs, [collect data for further troubleshooting](#data-collection) and then contact Microsoft Support.

## Data collection

If you need assistance from Microsoft Support, prepare the following information to speed up the investigation:

- Windows Server 2022 version and build details
  > [!NOTE]  
  > To see the exact version and build number, run `winver` to open the Windows version dialog, or run the following PowerShell cmdlet:
  > ```powershell
  > (Get-ComputerInfo).OsVersion
  > ```

- Detailed description of the VM environment, including hypervisor platform and version.
- List of storage devices and their configurations (physical and virtual).
- Event data that covers the period when the issue occurred. You can export this information from Event Viewer. Include data from the following logs:
  - System log
  - Application log
  - Microsoft-Windows-Storage-Diagnostics/Operational log (if available)
- Output from the following Windows PowerShell cmdlet:

  ```powershell
  Get-Disk | Format-List
  ```
