---
title: Troubleshoot Windows Update error code 0x80070070
description: Learn how to fix Windows Update error code 0x80070070, which typically indicates insufficient disk space.
ms.date: 12/01/2025
manager: dcscontentpm
ai-usage: ai-generated
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, dougking, v-appelgatet
ms.custom:
- sap:windows servicing, updates and features on demand\windows update - install errors unknown or code not listed
- pcy:WinComm Devices Deploy
appliesto:
- ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
- ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
- ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
---
# Troubleshoot Windows Update error code 0x80070070

This article describes how to fix Windows Update error code 0x80070070, which typically indicates insufficient disk space.

## Symptoms

When you try to install an update, the update process stops before Windows Update finishes downloading the update. You see an error message that resembles the following example:

> Updates are available, but we currently require additional space for downloading. Let's clear some space by removing any unnecessary files and apps, and we'll try again.

If you use Event Viewer to review the Microsoft-Windows-WindowsUpdateClient/Operational log, you find an event that lists the same message.

If you're working with an Azure virtual machine (VM), you can use Azure PowerShell cmdlets to collect Windows Update log information.

For example, to generate a WindowsUpdate.log file on the desktop, open the Azure Serial Console to a PowerShell command prompt and then run the `Get-WindowsUpdatelog` cmdlet.

To generate a log file that you can use offline, run the following cmdlet:

```azurepowershell
Get-Windowsupdatelog -etlpath <OfflineLogPath>
```

> [!NOTE]  
> In this cmdlet, \<OfflineLogPath> is the path to the offline folder where you want to place the log file.

In the log data, look for reports of failed downloads, and for error 0x80070070. Note the destination of the attempted download especially if you use a non-standard folder (other than C:\Windows) for the operating system. Check that the update was downloaded to the correct location.

```output
Windows failed to download from http://au.download.windowsupdate.com/c/msdownload/update/software/secu/2024/01/winreupdateinstaller_2401b_amd64_db08130ebf8845056f4677e8ef6d85ec048bf7b4.exe
to local path = C:\Windows\SoftwareDistribution\Download\f8c37f82eee991ffa34047ca3710154c\db08130ebf8845056f4677e8ef6d85ec048bf7b4 with error 0x80070070
```

## Cause

The error occurs because there's not enough disk space on your physical computer or VM to store Windows updates for installation.

## Resolution

For best results, your operating system disk should have at least 20 GB of available space.

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

1. If the affected computer is a VM, check the disk quota settings to make sure that the operating system disk doesn't have any quotas.
1. Check the amount of free space on your operating system disk (for example, open File Explorer, right-click **Local disk (C:)** and then select **Properties**).
1. Free up space on the operating system disk. For example, use the following techniques to increase the amount of available space:

   - Uninstall unused apps.
   - Delete or archive files that you don't need.
   - Move files to another disk, or to another computer entirely.

1. If you can't free up enough space by removing files and apps, consider the following approaches:

   - For a VM, extend the operating system disk.
   - For a physical computer, use an external drive during the update process. For more information, see [Updating Windows using an external storage device](https://support.microsoft.com/windows/updating-windows-using-an-external-storage-device-f980fac4-91b8-4225-b076-f66c28f21768).

If the issue persists, see [Collect data to analyze and troubleshoot Windows servicing, Updates, and Features on Demand scenarios](../../windows-client/windows-tss/collect-data-analyze-troubleshoot-windows-servicing-scenarios.md), and then contact Microsoft Support.
