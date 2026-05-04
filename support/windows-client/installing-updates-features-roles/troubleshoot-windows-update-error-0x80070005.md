---
title: Troubleshoot Windows Update Error 0x80070005
description: Discusses how to fix Windows Update error 0x80070005 (E_ACCESSDENIED). This error occurs if the update process can't access required files, folders, or registry entries.
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

Windows Update error `0x80070005 (E_ACCESSDENIED)` occurs if the update process can't access required files, folders, or registry entries. This error typically indicates a permissions problem that affects the Windows component store, the Software Distribution folder, or related system resources.

This article provides steps to resolve this issue on supported versions of Windows client, Windows Server, and Microsoft Azure Virtual Machines (VMs).

## Symptoms

You install a Windows update, but the installation fails, and you see error code `0x80070005 (E_ACCESSDENIED)` reported.

To get more information, review the following resources:

1. Review the WindowsUpdate.log file or the CBS.log file. Look for entries that resemble the following example:

```output
Error                 CBS    Failed to create file. [HRESULT = 0x80070005 - E_ACCESSDENIED]
Error                 CBS    Failed to internally open package. [HRESULT = 0x80070005 - E_ACCESSDENIED]
```

1. Review the Windows Update log. To generate a static copy of the log file, open a Windows PowerShell Command Prompt window, and then run the following cmdlet:

```powershell
Get-WindowsUpdateLog
```

Search the output for `0x80070005` entries. For more information about the log file, see [Windows Update log files](/windows/deployment/update/windows-update-logs).

## Cause

This error occurs if one of the following conditions exists:

- The TrustedInstaller service account doesn't have permissions on the %windir%\WinSxS folder or the %windir%\SoftwareDistribution folder.
- The permissions on the registry subkey `HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing` aren't correct.
- A third-party antivirus or security tool locked update-related files or folders.
- The SYSTEM account doesn't have the Full Control permission on the %windir% folder.
- A Group Policy setting or a management agent restricted write access to system directories.

> [!NOTE]  
> %windir% represents the Windows system folder. The default folder name and location is "C:\Windows."

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

### Step 1: Reset the permissions on the component store

To reset the default permissions on the Windows component store, open an administrative Command Prompt window, and then run the following commands:

```console
icacls "%windir%\WinSxS" /reset /t /c /q
icacls "%windir%\SoftwareDistribution" /reset /t /c /q
```

After you run these commands, restart the computer, and try again to install the update. If the update still doesn't install, go to step 2.

### Step 2: Make sure that TrustedInstaller owns the WinSxS folder

To designate that the TrustedInstaller account owns the WinSxS folder, run the following command at the command prompt:

```console
icacls "%windir%\WinSxS" /setowner "NT SERVICE\TrustedInstaller" /t /c /q
```

After you run these commands, restart the computer, and try again to install the update. If the update still doesn't install, go to step 3.

### Step 3: Reset Windows Update components

If the error persists, reset all Windows Update components. At the command prompt, run the following commands:

```console
net stop wuauserv
net stop bits
net stop cryptSvc

ren %windir%\SoftwareDistribution SoftwareDistribution.old
ren %windir%\System32\catroot2 catroot2.old

net start cryptSvc
net start bits
net start wuauserv
```

After you run these commands, restart the computer, and try again to install the update. If the update still doesn't install, go to step 5.

### Step 4: Repair the component store

To repair the component store, run the following command at the command prompt:

```console
DISM /Online /Cleanup-Image /RestoreHealth
```

> [!NOTE]  
> By default, DISM uses Windows Update as a repair source. For information about how to specify a different repair source, see [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

After you run this command, restart the computer, and try again to install the update. If the update still doesn't install, go to step 3.

### Step 5: Check system file integrity

To verify the integrity of the system files, run the following command at the command prompt:

```console
sfc /scannow
```

### Step 6: Check for third-party interference

To make sure that third-party applications or drivers don't interfere in the update process, follow these steps:

1. On the affected computer, temporarily disable real-time antivirus protection.
1. To list the file system filter drivers, run the following command at the command prompt:

   ```console
   fltmc
   ```

1. If the list includes a non-Microsoft filter driver, temporarily unload it by running the following command:

   ```console
   fltmc unload <DriverName>
   ```

   > [!NOTE]  
   > In this command, \<DriverName> represents the name of the driver as listed by the `fltmc` command.

1. After the tool finishes, restart the computer, and try again to install the update. If the update still doesn't install, take one of the following actions:

   - If the list includes more than one non-Microsoft filter driver, repeat step 6c to unload each of these drivers, and then try again to install the update.
   - If the affected computer is a VM, go to step 7.
   - Contact Microsoft Support for assistance.

### Step 7: Use the Run Command reset tool (Azure)

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run the tool directly from the VM's Azure portal page by using **Operations** > **Run command**. When you use this method, you don't have to sign in to the VM.

This tool resets the Windows Update servicing stack. This action clears memory-related lock states in the update agent.

After you run the tool, try again to install the update. If the update still doesn't install, go to step 8.

### Step 8: Use a repair VM (Azure)

If the reset tool doesn't fix the issue, or the VM can't start:

1. Create a repair VM by using [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands).

1. Attach the affected operating system disk to the repair VM.

1. To reset the default permissions on the Windows component store, open an administrative Command Prompt window, and then run the following commands:

   ```console
   icacls "%windir%\WinSxS" /reset /t /c /q
   icacls "%windir%\SoftwareDistribution" /reset /t /c /q
   ```

1. To designate that the TrustedInstaller account owns the WinSxS folder, run the following command at the command prompt:

   ```console
   icacls "%windir%\WinSxS" /setowner "NT SERVICE\TrustedInstaller" /t /c /q
   ```

1. Make sure that you have an offline operating system image available, and then run the following command at the command prompt:

   ```console
   DISM /Image:<Drive>:\ /Cleanup-Image /RestoreHealth
   ```

   > [!NOTE]  
   >
   > - In this command, \<Drive> represents the drive letter of the affected operating system disk.
   > - By default, DISM uses Windows Update as a repair source. For information about how to specify a different repair source, see [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

1. To make sure that third-party applications or drivers don't interfere in the update process, follow these steps:

   1. On the affected computer, temporarily disable real-time antivirus protection.
   1. To list the file system filter drivers, run the following command at the command prompt:

      ```console
      fltmc
      ```

   1. If the list includes non-Microsoft filter drivers, temporarily unload them by running the following command for each non-Microsoft driver in the list:

      ```console
      fltmc unload <DriverName>
      ```

      > [!NOTE]  
      > In this command, \<DriverName> represents the name of the driver as listed by the `fltmc` command.

1. Reattach the repaired disk to the original VM.

1. Try again to install the update. If the update still doesn't install, contact Microsoft Support for assistance.
