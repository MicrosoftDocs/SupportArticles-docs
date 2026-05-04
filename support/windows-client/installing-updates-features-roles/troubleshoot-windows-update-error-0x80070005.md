---
title: Troubleshoot Windows Update Error 0x80070005
description: Learn how to resolve Windows Update error 0x80070005 (E_ACCESSDENIED) that occurs when the update process lacks required permissions.
manager: dcscontentpm
audience: itpro
ms.date: 05/05/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser, kaushika, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
ai.usage: ai-assisted
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80070005

## Summary

Error code 0x80070005 (`E_ACCESSDENIED`) means the Windows Update process lacks the permissions it needs to access update-related files, registry keys, or services. This common error has multiple root causes.

## Prerequisites

For Microsoft Azure virtual machines (VMs) that run Windows, back up the OS disk before you begin. For more information, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

## How to identify the issue

Check `CBS.log` or `WindowsUpdate.log` for entries like the following example:

```output
Error                 CBS    Failed to create file. [HRESULT = 0x80070005 - E_ACCESSDENIED]
Error                 CBS    Failed to internally open package. [HRESULT = 0x80070005 - E_ACCESSDENIED]
```

You can also check the Windows Update log:

```powershell
Get-WindowsUpdateLog
```

Search the output for `0x80070005` entries.

## Cause

This error occurs when one of the following conditions exists:

- The `TrustedInstaller` service account lacks permissions on `%windir%\WinSxS` or `%windir%\SoftwareDistribution`.
- Registry permissions on the `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing` key are wrong.
- A third-party antivirus or security tool locked update-related files or folders.
- The `SYSTEM` account lacks Full Control on the Windows directory.
- Group Policy or a management agent restricted write access to system directories.

## Resolution

### Step 1: Reset permissions on the component store

Reset the default permissions on the Windows component store:

```cmd
icacls "%windir%\WinSxS" /reset /t /c /q
icacls "%windir%\SoftwareDistribution" /reset /t /c /q
```

### Step 2: Verify TrustedInstaller ownership

Set `TrustedInstaller` as the owner of the `WinSxS` folder:

```cmd
icacls "%windir%\WinSxS" /setowner "NT SERVICE\TrustedInstaller" /t /c /q
```

### Step 3: Reset Windows Update components

Stop the services, clear the cache, and restart:

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

### Step 4: Repair the component store

Repair the component store with DISM. This restores correct permissions on servicing files:

```cmd
DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
```

### Step 5: Check for third-party interference

1. Disable antivirus real-time protection temporarily.
2. List file system filter drivers:

   ```cmd
   fltmc
   ```

3. If a non-Microsoft filter driver appears, unload it temporarily and retry the update.

### Step 6: For Azure VMs — use the Run Command reset tool

Try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md) before you attempt offline repair. Run it from the Azure portal through **Run Command** — no RDP access needed. It stops services, renames cache folders, and re-registers core DLLs.

If the reset tool doesn't fix the issue or the VM is unresponsive:

1. Create a repair VM by using [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands).
2. Attach the affected OS disk.
3. Reset permissions on the offline `WinSxS` and `SoftwareDistribution` folders.
4. Run `DISM /Image:<drive>:\ /Cleanup-Image /RestoreHealth` against the offline image.
5. Swap the repaired disk back to the original VM.
