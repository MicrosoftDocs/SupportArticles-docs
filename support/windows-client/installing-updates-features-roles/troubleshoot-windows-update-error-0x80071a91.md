---
title: Troubleshoot Windows Update Error 0x80071a91
description: Learn how to resolve Windows Update error 0x80071a91 (ERROR_RM_NOT_ACTIVE) that occurs when the transaction resource manager isn't active.
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

# Troubleshoot Windows Update error 0x80071a91

**Applies to:** :heavy_check_mark: Windows VMs

## Summary

Error code 0x80071a91 (`ERROR_RM_NOT_ACTIVE`) means the transaction resource manager isn't active. Windows Update uses the Kernel Transaction Manager (KTM) and the transactional NTFS subsystem for file operations during updates. When these components fail, the update process can't commit its changes.

## Prerequisites

For Microsoft Azure virtual machines (VMs) that run Windows, back up the OS disk before you begin. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check `CBS.log` for entries like the following example:

```output
Error                 CBS    Exec: Failed to commit CBS transaction. [HRESULT = 0x80071a91 - ERROR_RM_NOT_ACTIVE]
Error                 CBS    Perf: Failed to process single phase execution. [HRESULT = 0x80071a91]
```

You can also check for transaction-related errors in Event Viewer:

1. Open **Event Viewer** > **Applications and Services Logs** > **Microsoft** > **Windows** > **KtmRm**.
2. Look for errors near the time of the update failure.

## Cause

This error occurs when one of the following conditions exists:

- The NTFS transaction log on the system volume is corrupted.
- The KTM can't start or manage file transactions.
- A previous interrupted update left the transaction subsystem in a bad state.
- Disk errors block the transaction log from being written or read.
- An antivirus program or file system filter driver blocks transactional file operations.

## Resolution

### Step 1: Clear the transaction logs

Reset the NTFS transaction logs from an elevated command prompt:

```cmd
fsutil resource setautoreset true C:\
```

Restart the VM after you run this command. The system recreates the transaction logs on startup.

### Step 2: Repair the component store

Repair the component store with DISM. A corrupted store often causes this error:

```cmd
DISM /Online /Cleanup-Image /RestoreHealth
```

Restart the VM after the repair finishes.

### Step 3: Run SFC and retry

Verify system file integrity and retry the update:

```cmd
sfc /scannow
```

### Step 4: Reset Windows Update components

If the transaction error persists, reset all Windows Update components:

```cmd
net stop wuauserv
net stop bits
net stop cryptSvc

ren %windir%\SoftwareDistribution SoftwareDistribution.old
ren %windir%\System32\catroot2 catroot2.old

net start cryptSvc
net start bits
net start wuauserv
```

### Step 5: Check disk health

Verify the system disk doesn't have underlying issues:

```cmd
chkdsk C: /f
```

> [!IMPORTANT]
> This command requires a restart on the system volume. For Azure VMs, you can also check disk health in the Azure portal by opening the disk resource and reviewing **Disk health**.

### Step 6: For Azure VMs — use the Run Command reset tool

Try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md) before you attempt offline repair. Run it from the Azure portal through **Run Command** — no RDP access needed. It resets the servicing stack, which can fix transaction log conflicts.

If the reset tool doesn't fix the issue or the VM can't boot:

1. Create a repair VM by using [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands).
2. Attach the affected OS disk.
3. Run `fsutil resource setautoreset true <drive>:\` on the attached disk.
4. Run `DISM /Image:<drive>:\ /Cleanup-Image /RestoreHealth` on the offline image.
5. Swap the repaired disk back to the original VM.
