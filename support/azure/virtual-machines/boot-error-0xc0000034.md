---
title: Windows boot error 0xc0000034 on an Azure VM
description: Fixes an issue that triggers Boot or BCD error 0xc0000034 when you try to start Windows on an Azure virtual machine (VM).
ms.date: 10/20/2023
ms.reviewer: jarrettr
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error 0xc0000034 on an Azure VM

This article provides a solution to an issue where Windows VM doesn't start with error code 0xc0000034.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010140

## Symptoms

Windows doesn't start. Instead, the system generates an error that resembles the following:

> File: \Boot\BCD  
Error Code: 0xc0000034  
Info: You'll need to use the recovery tools on your installation media. if you don't have any installation media contact your system administrator or PC manufacturer.

## Cause

There's BCD corruption that is not allowing the boot partition to find where the \Windows folder is.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Step 1: Attach the OS disk of the VM to another VM as a data disk

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is the Boot partition and the Windows partition.

    If the OS disk contains more than one partition, you can identify them by viewing the folders in the partitions:  

    - The Windows partition contains a folder named "Windows", and this partition is larger than the others.  
    - The Boot partition contains a folder named "Boot." This folder is hidden by default. To see the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.  

### Step 2: Repair the Boot Configuration data

1. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code and it looks like this: xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. You will use this identifier in the next step.  

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /enum /v
    ```

2. Repair the Boot Configuration data by running the following command lines. You must replace these placeholders by the actual values:

    - \<Windows partition> is the partition that contains a folder named "Windows."
    - \<Boot partition> is the partition that contains a hidden system folder named "Boot."
    - \<Identifier> is the identifier of Windows Boot Loader you found in the previous step. For example: {9f25ee7a-e7b7-11db-94b5-f7e662935912}

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /create {bootmgr}

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} description "Windows Boot Manager"

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} locale en-us

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} inherit {globalsettings}

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} displayorder <Identifier>

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} timeout 30
    ```

3. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
