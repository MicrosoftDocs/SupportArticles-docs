---
title: Troubleshoot Windows Update Error 0x80070570
description: Learn how to resolve Windows Update error 0x80070570 (ERROR_FILE_OR_DIRECTORY_CORRUPTED) that occurs when update files are corrupted or unreadable.
manager: dcscontentpm
audience: itpro
ms.date: 04/15/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser
ms.custom:
- sap:windows servicing,updates and features on demand\Windows Update - Install errors starting with 0x8007 (Win32)
- pcy:WinComm Devices Deploy
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80070570

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

Error code 0x80070570 (`ERROR_FILE_OR_DIRECTORY_CORRUPTED`) indicates that the file or directory is corrupted and unreadable. This error occurs during Windows Update when downloaded update files, the component store, or disk sectors are corrupted.

## Prerequisites

For Microsoft Azure virtual machines (VMs) that run Windows, make sure that you back up the OS disk. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check the `CBS.log` for entries that resemble the following example:

```output
Error                 CBS    Failed to internally open package. [HRESULT = 0x80070570 - ERROR_FILE_OR_DIRECTORY_CORRUPTED]
Info                  CBS    Failed to resolve package [Package_for_KB5XXXXXX~31bf3856ad364e35~amd64~~XX.X.X.X] [HRESULT = 0x80070570]
```

You can also run the System File Checker to identify corruption:

```cmd
sfc /verifyonly
```

## Cause

This error occurs when one of the following conditions exists:

- Downloaded update files in the `%windir%\SoftwareDistribution\Download` folder are corrupted.
- The Windows component store (`%windir%\WinSxS`) contains corrupted manifests or files.
- Disk corruption affects the system volume (bad sectors, file system errors).
- An antivirus or security application interferes with update file extraction.
- The update was interrupted during download (partial or truncated files).

## Resolution

### Step 1: Clear the Windows Update cache

Delete corrupted download files and force Windows Update to re-download:

```cmd
net stop wuauserv
net stop bits
rd /s /q %windir%\SoftwareDistribution\Download
net start bits
net start wuauserv
```

### Step 2: Repair the component store

Use DISM to scan and repair the Windows component store:

```cmd
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
```

> [!NOTE]
> The `/RestoreHealth` command requires access to Windows Update or a Windows installation source. For Azure VMs without internet access, you might need to specify a source path using the `/Source` parameter.

### Step 3: Run the System File Checker

After repairing the component store, verify and repair system files:

```cmd
sfc /scannow
```

If `sfc` reports that it found and repaired files, restart the VM and retry the update.

### Step 4: Check disk integrity

Verify the disk doesn't have file system errors:

```cmd
chkdsk C: /f /r
```

> [!IMPORTANT]
> This command requires a restart to run on the system volume. Schedule the check and restart the VM.

### Step 5: For Azure VMs

Before attempting offline repair, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run it directly from the Azure portal via **Run Command** without needing RDP access. This tool resets the Windows Update servicing stack by clearing corrupted cache folders and re-registering DLLs.

If the reset tool doesn't resolve the issue or the VM is unresponsive, use an offline repair approach:

1. Use [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to create a repair VM.
2. Attach the affected OS disk.
3. Run `chkdsk`, `DISM`, and `sfc` against the offline disk.
4. Swap the repaired disk back to the original VM.
