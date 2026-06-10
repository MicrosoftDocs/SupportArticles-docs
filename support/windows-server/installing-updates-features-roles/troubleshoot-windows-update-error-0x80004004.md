---
title: Troubleshoot Windows Update error 0x80004004
description: Describes how to diagnose the underlying cause of error code 0x80004004 and restore Windows Update functionality. The troubleshooting steps in this article apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.
ms.date: 06/08/2026
ms.reviewer: scotro, jdickson, kaushika, v-appelgatet
ai.usage: ai-assisted
ms.custom:
- sap:windows servicing, updates and features on demand\windows update fails - installation stops with error
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Azure Virtual Machines</a>
---

# Troubleshoot Windows Update error 0x80004004

## Summary

Windows Update error `0x80004004` (E_ABORT) occurs when a servicing operation stops because of an underlying error. This article describes how to diagnose the underlying cause of the error and restore Windows Update functionality.

The troubleshooting steps in this article apply to physical computers, on-premises virtual machines (VMs), and Azure VMs.

## Symptoms

When you try to install a Windows update, you might encounter one or more of the following symptoms:

- Windows Update fails and returns error `0x80004004`.
- During or after the update attempt, the computer restarts unexpectedly.
- After the update attempt, the computer starts and then stops at a black screen.
- The CBS.log file or the CbsPersist\_\*.log file contains entries that list error code `0x80004004`.

## Cause

Error `0x80004004` indicates that a service or platform operation encountered an error and then stopped. Common causes of such errors include the following issues:

- The servicing stack is corrupted.
- The component store is corrupted.
- The update payload is missing or invalid.
- Disk capacity or I/O issues occurred during servicing operations.
- Third-party filter drivers or security software interfered with servicing operations.

## Resolution

To find and fix the underlying issue, follow these steps.

[!INCLUDE [Azure VM Windows Update / Windows OS Upgrade Diagnostic Tools](~/includes/azure/virtual-machines-runcmd-wu-tools.md)]

### Step 1: Review the Windows Update logs

1. Collect these files from the affected computer:

   - C:\Windows\Logs\CBS\CBS.log
   - C:\Windows\Logs\CBS\CbsPersist\_\*.log

1. In both log files, search for the `0x80004004` string.

1. For each occurrence of `0x80004004`, review the 50 to 200 log entries that precede `0x80004004`. Look for error codes such as the following strings:

   - `0x8007000D`
   - `0x80070070`
   - `0x800F081F`
   - `0x800F0831`

1. Troubleshoot the error codes that precede `0x80004004`.

1. After you resolve the issue that caused the preceding error code, try again to install the update.

1. To verify that the issue is resolved, check the log files again for error code `0x80004004`. Make sure that the computer restarts correctly, and that workloads perform as expected.

If the update doesn't install correctly, or the logs still contain error codes, go to Step 2.

### Step 2: Repair the servicing stack

1. On the affected computer, open an administrative Command Prompt window, and then run the following commands:

   ```cmd
   DISM /Online /Cleanup-Image /ScanHealth
   DISM /Online /Cleanup-Image /RestoreHealth
   ```

   If the `RestoreHealth` process reports issues that affect the source image, provide a valid image to use for repair, and then run `DISM /Online /Cleanup-Image /RestoreHealth` again.

1. After `RestoreHealth` finishes, restart the computer, reopen the command prompt, and then run `sfc /scannow`.

1. After `sfc /scannnow` `finishes, try again to install the update.

1. To verify that the issue is resolved, check the log files again for error code `0x80004004`. Make sure that the computer restarts correctly, and that workloads perform as expected.

1. If the update doesn't install correctly, or the logs still contain error codes, go to Step 3.

### Step 3: Check free disk space and restart the computer

1. Make sure that the operating system disk has at least 20 GB of free disk space.

1. Restart the computer. A restart removes any stale update states.

1. Try again to install the update.

1. To verify that the issue is resolved, check the log files again for error code `0x80004004`. Make sure that the computer restarts correctly, and that workloads perform as expected.

1. If the update doesn't install correctly, or if the logs still contain error codes, go to Step 4.

### Step 4: Use in-place upgrade for persistent servicing failures

If updates still fail and logs show repeated servicing corruption patterns, perform an in-place upgrade. An in-place upgrade repairs the servicing stack while preserving applications and data.

- If the affected computer is a VM, see [In-place upgrade for VMs running Windows Server in Azure](/azure/virtual-machines/windows-in-place-upgrade?context=/troubleshoot/azure/virtual-machines/windows/context/context).
- For a physical computer that runs Windows Server or Windows Client, download the latest appropriate operating system image from Microsoft. Use your management system to deploy the image, or follow these steps:
  1. Mount the new image on the affected computer.
  1. In the new image, run the `Setup.exe` application.

To verify that the issue is resolved, check the log files again for error code `0x80004004`. Make sure that the computer restarts correctly, and that workloads perform as expected.

If the issue persists, see [Collect data to analyze and troubleshoot Windows servicing, Updates, and Features on Demand scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-windows-servicing-scenarios.md), and then contact Microsoft Support.

## References

- [Windows Server update troubleshooting guidance](troubleshoot-windows-server-update-guidance.md)
- [Windows Update troubleshooting guidance](../../windows-client/installing-updates-features-roles/troubleshoot-windows-update-issues.md)
- [Troubleshoot Windows Update errors that require in-place upgrades for Azure VMs](../../azure/virtual-machines/windows/windows-update-errors-requiring-in-place-upgrade.md)
- [Windows Update log files](/windows/deployment/update/windows-update-logs)
