---
title: Boot error code 0xC000000F in an Azure VM
description: Fixes a Boot error code 0xc000000f that occurs on an Azure virtual machine (VM).
ms.date: 06/21/2024
ms.reviewer: jarrettr, v-leedennis
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---
# Boot error code 0xC000000F in an Azure VM

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010130

This article provides solutions to an issue where Windows VM doesn't start and generates errors.

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

First, follow the instructions in the [Attach the OS disk of the VM to another VM (troubleshooting VM) as a data disk](#step-1-attach-the-os-disk-of-the-vm-to-another-vm-troubleshooting-vm-as-a-data-disk) section. (This section is from the first part of the [Resolution for errors 1 and 2](#resolution-for-error-1-and-error-2).) Then, repair the system binary (*.sys*) file by following these steps:

[!INCLUDE [Replace system binary file procedure](../../../includes/azure/virtual-machines-windows-replace-system-binary-file.md)]

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
