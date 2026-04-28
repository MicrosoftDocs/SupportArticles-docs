---
title: Troubleshoot Windows Update error 0x80071A91
description: Learn how to resolve Windows Update error 0x80071a91 (ERROR_RM_NOT_ACTIVE) that occurs when the transaction resource manager isn't active.
manager: dcscontentpm
audience: itpro
ms.date: 04/29/2026
ms.topic: troubleshooting
ms.reviewer: scotro, jarretr, v-gsitser, kaushika, v-appelgatet
ms.custom:
- sap:Windows Servicing, Updates and Features on Demand\Windows Update - Install errors starting with 0x8007 (ERROR)
- pcy:WinComm Devices Deploy
appliesto:
  - ✅ <a href=https://learn.microsoft.com/lifecycle/products/azure-virtual-machine target=_blank>Supported versions of Azure Virtual Machine</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
  - ✅ <a href=https://learn.microsoft.com/windows/release-health/windows-server-release-info target=_blank>Supported versions of Windows Server</a>
---

# Troubleshoot Windows Update error 0x80071A91

## Summary

Error code 0x80071A91 (`ERROR_RM_NOT_ACTIVE`) means the transaction resource manager isn't active. Windows Update uses the Kernel Transaction Manager (KTM) and the transactional NTFS subsystem for file operations during updates. When these components fail, the update process can't commit its changes.

## Symptoms

You install a Windows update, but the installation fails, and you see error code 0x80071A91 reported.

To get more information, review the following resources:

1. Review the WindowsUpdate.log file or the CBS.log file. Look for entries that resemble the following example:

```output
Error                 CBS    Exec: Failed to commit CBS transaction. [HRESULT = 0x80071a91 - ERROR_RM_NOT_ACTIVE]
Error                 CBS    Perf: Failed to process single phase execution. [HRESULT = 0x80071a91]
```

1. Open Event Viewer, and go to **Applications and Services Logs** > **Microsoft** > **Windows** > **KtmRm**. Look for events that occurred around the time of the update failure.

## Cause

This error occurs when one of the following conditions exists:

- The NTFS transaction log on the system volume is corrupted.
- The KTM can't start or manage file transactions.
- A previous interrupted update left the transaction subsystem in a bad state.
- Disk errors block the transaction log from being written or read.
- An antivirus program or file system filter driver blocks transactional file operations.
- The Windows component store is corrupted.

## Resolution

> [!IMPORTANT]  
>
> - Before you troubleshoot this issue, back up the operating system disk. For information about this process for VMs, see [About Azure Virtual Machine restore](/azure/backup/about-azure-vm-restore).
> - If the affected computer is a VM that can't start, go to [step 7](#step-7).

### Step 1: Request a reset of the transaction logs

To reset the NTFS transaction logs, follow these steps:

1. Open an administrative Command Prompt window and then run the following command:

   ```console
   fsutil resource setautoreset true C:\
   ```

1. Restart the computer. When Windows starts, it recreates the transaction logs.

### Step 2: Repair the component store

To repair the component store, run the following command at the command prompt:

```console
DISM /Online /Cleanup-Image /RestoreHealth
```

This command uses Windows Update as the source for repair information.

After you run this command, restart the computer, and then try again to install the update. If it still doesn't install, continue to step 3.

### Step 3: Check system file integrity

To verify the integrity of the system files, run the following command at the command prompt:

```console
sfc /scannow
```

If this command identifies issues, see [Use the System File Checker tool to repair missing or corrupted system files](https://support.microsoft.com/topic/use-the-system-file-checker-tool-to-repair-missing-or-corrupted-system-files-79aa86cb-ca52-166a-92a3-966e85d4094e).

After you run this command and it completes without errors, restart the computer. Try again to install the update. If it still doesn't install, continue to step 4.

### Step 4: Reset Windows Update components

If the transaction error persists, reset all Windows Update components. At the command prompt, run the following commands:

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

After you run these command, restart the computer, and then try again to install the update. If it still doesn't install, continue to step 5.

### Step 5: Check disk health

To check for disk issues, follow these steps:

1. On the affected computer, open a Command Prompt window and then run the following command:

   ```console
   chkdsk C: /f
   ```

   The tool automatically repairs any problems that it finds.

   > [!IMPORTANT]
   > If the affected computer is an Azure VM and you use the Azure portal to monitor and remediate disk health, continue to the next step of this procedure. You still have to restart the VM that uses the disk.

1. After the tool finishes, restart the computer and then try again to install the update. If the update still doesn't install, take one of the following actions:

   - If the affected computer is a VM, continue to step 6.
   - Contact Microsoft Support for assistance.

### Step 6: Use the Run Command reset tool (Azure)

If the previous steps don't resolve the issue on an Azure VM, try the [Azure VM Windows Update Reset Tool](../../azure/virtual-machines/windows/windows-vm-wureset-tool.md). You can run it directly from the VM's Azure portal page by using **Operations** > **Run Command**. When you use this method, you don't have to sign in to the VM.

This tool resets the Windows Update servicing stack, which can clear memory-related lock states in the update agent.

After you run the tool, try to install the update again. If it still doesn't install, continue to step 7.

### Step 7

If the reset tool doesn't fix the issue or the VM can't boot:

1. Create a repair VM by using [Azure VM repair commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands).

1. Attach the affected operating system disk to the repair VM.

1. To reset the NTFS transaction logs, follow these steps:
   1. open an administrative Command Prompt window on the repair VM and then run the following command:

      ```console
      fsutil resource setautoreset true <drive>:\
      ```

      > [!NOTE]  
      > In this command, \<drive> represents the drive letter of the affected operating system disk.

   1. Restart the computer. When Windows starts, it recreates the transaction logs.

1. Make sure that you have an offline operating system image available, and then run the following command at the command prompt:

   ```console
   DISM /Image:<drive>:\ /Cleanup-Image /RestoreHealth
   ```

      > [!NOTE]  
      > In this command, \<drive> represents the drive letter of the offline image.

1. Swap the repaired disk back to the original VM.

1. try again to install the update. If the update still doesn't install, contact Microsoft Support for assistance.
