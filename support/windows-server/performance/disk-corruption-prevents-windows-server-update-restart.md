---
title: After updates, disk corruption prevents Windows Server from starting
description: Discusses how to diagnose and fix disk corruption issues that prevent Windows Server from starting after you install updates.
ms.date: 03/04/2026
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, DIASMITH, simonw, v-appelgatet
ms.custom:
- sap:system performance\startup or pre-logon reliability (crash, errors, bug check or blue screen)
- pcy:WinComm Performance
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
---
# After updates, disk corruption prevents Windows Server from starting

## Summary

After you install updates and restart your Windows Server computer, the computer doesn't start. Instead, it enters a continuous restart loop. This issue might occur if disk corruption or bad clusters on the operating system (OS) disk prevent Windows Server from completing its startup processes. Use this article to identify the cause and fix the issue.

## Symptoms

After you install updates and restart your computer, you experience the following symptoms:

- The computer doesn't start. However, it tries repeatedly to restart.
- The startup process reports particular error codes that indicate disk read errors.
- A disk health check (for example, by running `chkdsk`) indicates that the disk has bad clusters or other corruption.
- If you run standard disk repair commands, the commands don't restore the computer to a point at which it can start.

## Cause

This issue occurs if the operating system (OS) disk is corrupted or has bad clusters. The following factors contribute to the issue:

- The OS disk doesn't have enough free space to allow the system files to function.
- Windows experienced disk read errors while it installed the updates.
- The system files that the computer requires for startup are corrupted.
- The disk has health issues that affect successful logging and normal startup operations.

If the OS disk is damaged or has bad sectors, Windows Server can't start. Although the system tries to restart, it enters a continuous loop of startup attempts.

## Resolution

> [!IMPORTANT]  
>
> - If the affected computer is a Windows virtual machine (VM) that can't restart correctly or that you can't access by using RDP or SSH, make sure that you can use the [Azure Serial Console](/troubleshoot/azure/virtual-machines/windows/serial-console-windows) to access the VM.
> - Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

To resolve the issue, follow these steps:

1. If the affected computer is a VM, make sure that the OS disk has enough free space by increasing the size of the OS disk. For more information, see [Expand virtual hard disks attached to a Windows virtual machine](/azure/virtual-machines/windows/expand-disks#expand-the-volume-in-the-operating-system).
1. On the affected computer, open an administrative Windows Command Prompt window.
1. To fix file system errors, locate bad sectors, and recover readable information, run the following command at the command prompt:

   ```console
   chkdsk /r /x
   ```

1. After `chkdsk` finishes, check the health of the disk. To check health, use any of the following methods:
   - The Disk Management tool
   - The PowerShell `Get-PhysicalDisk` command
   - The `chkdsk` command without flags (read-only check)
   - Azure portal diagnostics

1. Try to start the computer.
1. If the computer still doesn't start, try the following methods:

   - If the affected computer is a VM, detach the OS disk, and then attach it to a test VM. Verify that the disk mounts and functions correctly.
   - Contact your storage vendor (or your storage and system administration teams) for assistance in more in-depth troubleshooting. You might have to replace the disk hardware.

## Data collection

The following types of data can help you troubleshoot this issue. Additionally, if you contact Microsoft Support, you can attach this data to your support request.

- Exported data from the System and Application event logs.
- Output from the `chkdsk` operation, including the details of any repairs.
- Disk health reports from monitoring or troubleshooting tools (for VMs, include reports from Azure monitoring tools).
- Screenshots or logs that show startup errors and error codes.
- A description of the steps that you already used to try to fix the issue.

## References

- [chkdsk](/windows-server/administration/windows-commands/chkdsk)
- [Get-PhysicalDisk](/powershell/module/storage/get-physicaldisk)
- [Attach a managed data disk to a Windows VM by using the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal)
- [Troubleshoot Azure virtual machine boot errors](/troubleshoot/azure/virtual-machines/windows/boot-error-troubleshoot)
