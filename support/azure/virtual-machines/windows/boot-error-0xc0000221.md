---
title: Windows boot error 0xc0000221 on an Azure VM
description: Fixes error 0xc0000221, which occurs when you try to boot an Azure virtual machine (VM).
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error 0xc0000221 on an Azure VM

This article provides a solution to an issue where Windows fails to start and generates error code 0xc0000221.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010132

## Symptoms

Windows fails to start and generates the following error:

> File: \Windows\system32\ntoskrnl.exe  
Status: 0xc0000221  
Info: The operating system couldn't be loaded because the kernel is missing or contains errors.

## Cause

This issue occurs if the file system is corrupted.

## Resolutions

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Step 1

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM, and then open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. Use the WinRE image located in every Windows installation (Recover console image) as a repository to try to fix the corruption. Volume G is the drive of the broken OS disk:

    ```console
    Dism /image:g:\ /cleanup-image /restorehealth /source:wim:g:\recovery\windowsRE\winre.wim:1
    ```

5. If the command-line states there's corruption but the required file cannot be found, download an ISO for the Windows version of that disk to the troubleshooting machine.
6. Extract the media ISO, and then locate the WIM file inside and use that as the repository:

    ```console
    Dism /image:g:\ /cleanup-image /restorehealth /source:wim:<WIM FILE FROM ISO>:1
    ```

7. Recreate the VM.
If the VM still doesn't boot, go to step 2.

### Step 2

1. Run DISM. On the sample line below, G is the drive of the broken OS disk:

    ```console
    dism.exe /image:g:\ /cleanup-image /restorehealth
    ```

2. Run System File Checker (SFC). On the sample line below, G is the drive of the broken OS disk:

    ```console
    sfc /scannow /offbootdir=g:\ /offwindir=g:\windows​​
    ```

3. If SFC detects corruption but cannot fix it, go to step 3.
4. If SFC states that the corruption is fixed, detach the OS disk from the troubleshooting VM, and wait until Azure updates the disk lease (3 minutes at most).
5. Recreate the VM.

### Step 3

SFC checks for corruption in the registry and the file system. If SFC states that the corrupted files were found but it cannot fix them, you can [boot the VM from the Last Known Good Configuration](start-vm-last-known-good.md). This is to make sure that you have a good registry. Then, check the file system again by running SFC to identify the potentially corrupted files.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
