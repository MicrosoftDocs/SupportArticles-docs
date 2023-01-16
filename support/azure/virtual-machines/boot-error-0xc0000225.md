---
title: Windows boot error 0xc0000225 on an Azure VM
description: Fixes an issue that triggers error 0xc0000225 when you try to start an Azure-based virtual machine.
ms.date: 07/21/2020
ms.reviewer: jarrettr
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error 0xc0000225 on an Azure VM

This article provides three solutions to an issue where Windows VM doesn't start with error code 0xc0000225.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010138

## Symptoms

Windows doesn't start, and it generates one of the following error messages. **Error message 1** File: \Windows\System32\config\system

**Error message 1**

> File: \Windows\System32\config\system  
Status: 0xc0000225  
Info: The operating system couldn't be loaded because the system registry file is missing or contains errors.

**Error message 2**

> Status: 0xc0000225  
Info: An unexpected error has occurred.

**Error message 3**

> File: \Windows\System32\driver\\\<Brinary>  
Status: 0xc0000225  
Info: The operating system couldn't be loaded because a critical system driver is missing or contains errors.

In this message, \<BINARY> represents the actual binary file that's found.

## Cause

This issue occurs for one of the following reasons:

- The hive is corrupted or was not closed correctly.
- The Boot Configuration Data (BCD) is corrupted.
- The binary that's displayed in the error message is corrupted or missing.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps, based on the error message that you received.

### Error 1: Fix the corrupted hive

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM.
4. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
5. On the OS disk that you attached, navigate to **\windows\system32\config**. Copy all the files to a backup folder in case a rollback is required.
6. Start Registry Editor (regedit.exe).
7. Select the `HKEY_USERS` key, select **File** > **Load Hive** on the menu, and then load `\windows\system32\config\SYSTEM`.
8. If the hive loads without issues, this means that the hive was not closed correctly. In this situation, unload the hive to unlock the file and fix the issue.

    If you receive the following error message, [contact Azure Support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade).

    > Cannot load \<drive>:\Windows\System32\config\SYSTEM: Error while loading hive

9. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.

### Error 2: Repair the boot configuration data

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM.
4. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
5. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is the Boot partition and the Windows partition.

    If the OS disk contains more than one partition, you can identify them by viewing the folders in the partitions:  

    The Windows partition contains a folder named "Windows," and this partition is larger than the others.  

    The Boot partition contains a folder named "Boot." This folder is hidden by default. To see the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.  

6. Run the following command as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code and it resembles "xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx." You will use this identifier in the next step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /enum /v
    ```

7. Repair the Boot Configuration data by running the following commands after you replace the placeholders by the actual values:

    - **\<Windows partition>** is the partition that contains a folder that is named "Windows."
    - **\<Boot partition>** is the partition that contains a hidden system folder that is named "Boot."
    - **\<Identifier>** is the identifier of Windows Boot Loader that you found in the previous step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} OSDEVICE BOOT
    ```

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} OSDEVICE partition=<Windows partition>:
    ```

8. Detach the repaired OS disk from the troubleshooting VM. Then, create a VM from the OS disk.

### Error 3: Repair the corrupted or missing binary file

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. On the attached disk, browse to the location of the binary file that's displayed in the error message.
5. Rename the file to \<BINARY.SYS>.OLD.
6. On the attached disk, browse to the `\Windows\winsxs` folder. Then, search for the binary file that's displayed in the error message. To do this, run the following command at a command prompt: `dir <binaryname> /s`.

    The command lists all the different versions of the binary file together with the created date. Copy the latest version of the binary file to the windows\system32 folder by running the following command:

    ```console
    copy <drive>:\Windows\WinSxS\<directory_where_file_is>\<binary_with_extension> <drive>:\Windows\System32\Drivers\
    ```

    For example, see the following screenshot.

    :::image type="content" source="media/boot-error-0xc0000225/dir-command-output.png" alt-text="Screenshot of the sample of the DIR command." border="false":::

    **Notes**:

    - The screenshot shows volume E. However, the actual letter will appropriately reflect the one of the faulty drives (the OS disk attached as a data disk on the troubleshooting VM).
    - If the latest binary doesn't work, you can try the previous file version to obtain an earlier system update level on that component.
    - If the only binary that's returned in this step matches the file that you're trying to replace on the affected VM, and if both files have the same size and time stamp, you can replace the corrupted file by copying it from another working VM that has the same OS and, if possible, the same system update level.
7. Detach the repaired disk from the troubleshooting VM. Then, create a VM from the OS disk.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
