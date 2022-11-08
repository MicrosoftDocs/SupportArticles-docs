---
title: Windows boot error 0xc0000098 on an Azure VM
description: Provides the resolution for the error code 0xc0000098.
ms.date: 11/15/2021
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error 0xc0000098 on an Azure VM

This article provides a solution to an issue where Windows VM doesn't start with error code 0xc0000098.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010137

## Symptoms

Windows doesn't start. Instead, the system generates an error that resembles the following:

> File: \\\<BINARY>  
Status: 0xc0000098  
Info: Windows failed to load because a critical system driver is missing or corrupt.

In this message, \<BINARY> represents the actual binary file that's found.

## Cause

This issue occurs if a binary is from a different version of Windows than the operating system of the virtual machine.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Step 1: Attach the OS disk of the VM to another VM as a data disk

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.

### Step 2: Replace the binary file

1. On the attached disk, browse to the location of the binary file that's displayed in the error message.
2. Rename the file to `<BINARY.SYS>.OLD`. If the file cannot be renamed, [take ownership of the file](https://www.bing.com/search?q=take+ownership+of+a+file+windows). Then you will get full access to this file.
3. On the attached disk, browse to the `\Windows\winsxs` folder. Then, search for the binary file that's displayed in the error message. To do this, run the following command at a command prompt:

    ```console
    dir <binaryname> /s
    ```

    The command lists all the different versions of the binary file together with the created date. Copy the latest version of the binary file to the windows\system32 folder by running the following command:

    ```console
    copy <drive>:\Windows\WinSxS\<directory_where_file_is>\<binary_with_extension> <drive>:\Windows\System32\Drivers\
    ```

    For example, see the following screenshot.

    :::image type="content" source="media/boot-error-0xc0000098/dir-command-output.png" alt-text="Screenshot of the sample of the DIR command." border="false":::

    **Notes**:

    - The screenshot shows volume E. However, the actual letter will appropriately reflect the one of the faulty drives (the OS disk attached as a data disk on the troubleshooting VM).
    - If the latest binary doesn't work, you can try the previous file version to obtain an earlier system update level on that component.
    - If the only binary that's returned in this step matches the file that you're trying to replace on the affected VM, and if both files have the same size and time stamp, you can replace the corrupted file by copying it from another working VM that has the same OS and, if possible, the same system update level.

4. Detach the repaired disk from the troubleshooting VM. Then, [create a VM from the OS disk](/azure/virtual-machines/windows/create-vm-specialized-portal).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
