---
title: Boot error code 0xC000000F in an Azure VM
description: Fixes a Boot error code 0xc000000f that occurs on an Azure virtual machine (VM).
ms.date: 10/09/2023
ms.reviewer: jarrettr, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Boot error code 0xC000000F in an Azure VM

This article provides solutions to an issue where Windows VM doesn't start and generates errors.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010130

## Symptom

Windows doesn't start and generates the one of the following errors:

**Error 1**：

> File: \Windows\system32\winload.exe  
Status: 0xc000000f  
Info: The application or operating system couldn't be loaded because a required file is missing or contains errors.

**Error 2**:

> File: \Boot\BCD  
Status: 0xc000000f  
Info: The Boot Configuration Data for your PC is missing or contains errros

**Error 3**:

> File: \Windows\System32\drivers\\\<Binary>  
Status: 0xc000000f  
Info: The operating system couldn't be loaded because a critical system driver is missing or contains errors.

In this message, \<BINARY> represents the actual binary file that's found.

## Cause

This issue occurs when one of following conditions is true:

- The Boot Configuration Data (BCD) is corrupted.
- The reference to DEVICE and OSDEVICE on the boot configuration data is missing or unknown.
- The binary displayed on the screenshot (other than winload.exe or \boot\BCD) is missing from the operating system disk.

## Resolution

### Try restoring the VM from a backup

 If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem. If restoring the VM from backup isn't possible, follow the steps in [Resolution for error 1 and error 2](#resolution-for-error-1-and-error-2).

### Resolution for error 1 and error 2

#### Step 1: Attach the OS disk of the VM to another VM (troubleshooting VM) as a data disk

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is the Boot partitionandthe Windows partition.

    If the OS disk contains more than one partition, you can identify them by viewing the folders in the partitions:  

    - The Windows partition contains a folder named "Windows," and this partition is larger than the others.  
    - The Boot partition contains a folder named "Boot." This folder is hidden by default. To see the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.  

#### Step 2: Repair the Boot Configuration data

1. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is either the tag {default} or a 32-character code and it looks like this: xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. You will use this identifier in the next step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /enum /v
    ```

2. Repair the Boot Configuration data by running the following command lines. You must replace these placeholders by the actual values:

    > [!NOTE]
    > This step is applied to most Boot configuration data corruption issues. You need perform this step even if you see the **Device**  and **OSDevice**  are pointing to the correct partition.

    **\<Windows partition>** is the partition that contains a folder named "Windows."  
    **\<Boot partition>** is the partition that contains a hidden system folder named "Boot."  
    **\<Identifier>** is the identifier of Windows Boot Loader you found in the previous step.  

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} device partition=<boot partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} integrityservices enable

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} device partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} integrityservices enable

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} recoveryenabled Off

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} osdevice partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} bootstatuspolicy IgnoreAllFailures
    ```

3. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.

### Resolution for error 3

1. Attach the OS disk of the VM to another VM (troubleshooting VM) as a data disk.
2. On the attached disk, browse to the location of the binary file that's displayed in the error message.
3. Rename the file to `<BINARY.SYS>.OLD`.
4. On the attached disk, browse to the `\Windows\winsxs` folder. Then, search for the binary file that's displayed in the error message. To do this, run the following command at a command prompt:

    ```console
    dir <binaryname> /s
    ```

    The command lists all the different versions of the binary file together with the created date. Copy the latest version of the binary file to the windows\system32 folder by running the following command:

    ```console
    copy <drive>:\Windows\WinSxS\<directory_where_file_is>\<binary_with_extension> <drive>:\Windows\System32\Drivers\
    ```

    For example, see the following screenshot.

    :::image type="content" source="media/boot-error-code-0xc000000f/dir-command-output.png" alt-text="Screenshot of the sample of the DIR command." border="false":::

    **Notes**:

    - The screenshot shows volume E. However, the actual letter will appropriately reflect the one of the faulty drives (the OS disk attached as a data disk on the troubleshooting VM).
    - If the latest binary doesn't work, you can try the previous file version to obtain an earlier system update level on that component.
    - If the only binary that's returned in this step matches the file that you're trying to replace on the affected VM, and if both files have the same size and time stamp, you can replace the corrupted file by copying it from another working VM that has the same OS and, if possible, the same system update level.
5. Detach the repaired disk from the troubleshooting VM. Then, [create a VM from the OS disk](/azure/virtual-machines/windows/create-vm-specialized-portal).

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
