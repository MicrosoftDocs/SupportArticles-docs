---
title: Troubleshoot Windows Update Error 0x80070570
description: Discusses how to fix Windows Update error 0x80070570 (ERROR_FILE_OR_DIRECTORY_CORRUPTED). Windows can't read or process the files that are required to install an update.
manager: dcscontentpm
audience: itpro
ms.date: 05/05/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser, kaushika, v-applegatet
ai.usage: ai-assisted
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80070570

## Summary

Windows Update error `0x80070570 (ERROR_FILE_OR_DIRECTORY_CORRUPTED)` indicates that Windows can't read or process the files that are required to install an update. This error typically occurs because of corrupted update cache files, a damaged Windows component store, disk errors, or interference from security software. This article describes the symptoms and causes of this error, and provides steps to resolve it on supported versions of Windows client, Windows Server, and Microsoft Azure Virtual Machines (VMs).

## Symptoms

You install a Windows update, but the installation fails, and you see error code `0x80070570` reported.

To get more information, review the following resources:

1. Review the WindowsUpdate.log file or the CBS.log file. Look for entries that resemble the following example:

   ```output
   Error         CBS    Failed to internally open package. [HRESULT = 0x80070570 - ERROR_FILE_OR_DIRECTORY_CORRUPTED]
   Info          CBS    Failed to resolve package [Package_for_KB5XXXXXX~31bf3856ad364e35~amd64~~XX.X.X.X] [HRESULT = 0x80070570]
   ```

1. To scan the system files for issues, open a Command Prompt window, and then run the following command:

   ```console
   sfc /verifyonly
   ```

## Cause

This error occurs if one of the following conditions exists:

- Downloaded update files in the %windir%\SoftwareDistribution\Download folder are corrupted.
- The Windows component store (in the %windir%\WinSxS folder) contains corrupted manifests or files.
- The system volume is corrupted (for example, the disk might have bad sectors or file system errors).
- An antivirus or security application interferes when Windows Update extracts files from downloaded update packages.
- The update files are truncated or partial because the download process was interrupted.

> [!NOTE]  
> %windir% represents the Windows system folder. The default folder name and location is "C:\Windows."

## Resolution

> [!IMPORTANT]  
> Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).

### Step 1: Clear the Windows Update cache

To delete corrupted download files and force Windows Update to download new copies, open a Command Prompt window, and then run the following commands:

```console
net stop wuauserv
net stop bits
rd /s /q %windir%\SoftwareDistribution\Download
net start bits
net start wuauserv
```

After you run these commands, restart the computer, and try again to install the update. If the update still doesn't install, go to step 2.

### Step 2: Repair the component store

To repair the component store, run the following command at the command prompt:

```console
DISM /Online /Cleanup-Image /RestoreHealth
```

> [!NOTE]  
> By default, DISM uses Windows Update as a repair source. For information about how to specify a different repair source, see [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

After you run this command, restart the computer, and try again to install the update. If the update still doesn't install, go to step 3.

### Step 3: Check system file integrity

To verify the integrity of the system files, run the following command at the command prompt:

```console
sfc /scannow
```

If this command identifies issues, see [Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e).

After this command finishes without errors, restart the computer. Try again to install the update. If the update still doesn't install, go to step 4.

### Step 4: Check disk integrity

To check for disk issues, follow these steps:

1. On the affected computer, open a Command Prompt window, and run the following command:

   ```console
   chkdsk C: /f /r
   ```

1. When prompted, confirm that you want to scan the operating system disk when the computer restarts.
1. Restart the computer.
   The tool automatically repairs any problems that it finds.

   > [!IMPORTANT]
   > If the affected computer is an Azure VM, and you use the Azure portal to monitor and remediate disk health, go to the next step of this procedure. You still have to restart the VM that uses the disk.

1. After the tool finishes, restart the computer, and try again to install the update. If the update still doesn't install, take one of the following actions:

   - If the affected computer is a VM, go to step 5.
   - Contact Microsoft Support for assistance.


### Step 5: Use the Run Command reset tool (Azure)

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run the tool directly from the VM's Azure portal page by using **Operations** > **Run command**. When you use this method, you don't have to sign in to the VM.

This tool resets the Windows Update servicing stack. This action clears memory-related lock states in the update agent.

After you run the tool, try again to install the update. If it still doesn't install, go to step 6.

### Step 6: Use a repair VM (Azure)

If the reset tool doesn't fix the issue, or the VM can't start:

1. Create a repair VM by using [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands).

1. Attach the affected operating system disk to the repair VM.

1. Make sure that you have an offline operating system image available, and then run the following command at the command prompt:

   ```console
   DISM /Image:<Drive>:\ /Cleanup-Image /RestoreHealth
   ```

   > [!NOTE]  
   > - In this command, \<Drive> represents the drive letter of the affected operating system disk.
   > - By default, DISM uses Windows Update as a repair source. For information about how to specify a different repair source, see [Repair a Windows Image](/windows-hardware/manufacture/desktop/repair-a-windows-image).

1. Run the following command at the command prompt:

   ```console
   chkdsk <Drive>: /f /r
   ```

   > [!NOTE]  
   > In this command, \<Drive> represents the drive letter of the affected operating system disk.

1. To verify the integrity of the system files, run the following command at the command prompt:

   ```console
   sfc /scannow /offwindir \<Drive>:%windir%


1. Reattach the repaired disk to the original VM.

1. Try again to install the update. If the update still doesn't install, contact Microsoft Support for assistance.
