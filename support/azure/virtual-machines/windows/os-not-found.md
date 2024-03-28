---
title: Windows can't boot with (An operating system wasn't found) error 
description: Provides a solution to an issue where Windows VM doesn't start with (An operating system wasn't found) error.
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error in an Azure VM: An operating system wasn't found

This article provides a solution to an issue where Windows VM doesn't start with error "An operating system wasn't found".

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010142

## Symptoms

Windows doesn't start, and it returns the following error message:

> An operating system wasn't found. Try disconnecting any drivers that don't contain an operating system. Press Ctrl+Alt+Del to restart

## Cause

This issue occurs for one of the following reasons:

- The startup process can't locate an active system partition.
- The disk is corrupted.
- The disk isn't presented to the Hyper-V host.
- The host can't access the storage in which the disk is hosted.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix this issue, stop (de-allocate) and restart the VM. Then, check whether the issue persists. If the issue persists, follow these steps.

### Step 1: Verify whether the Windows partition is marked as active

1. Delete the VM. Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is both the Boot partition and the Windows partition.

    If the OS disk contains more than one partition, you can identify the partitions by viewing the folders in them:  

    - The Windows partition contains a folder that is named "Windows," and this partition is larger than the others.  
    - The Boot partition contains a folder that is named "Boot." This folder is hidden by default. To see the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.  

5. Run the following command as an administrator. This creates a boot record.

    ```console
    bcdboot <Windows partition>:\Windows /S <windows partition>:
    ```

6. Use DISKPART to check whether the Windows partition is active. To do this, follow these steps:

    1. Run the following command to open DISKPART:

        ```console
        diskpart
        ```

    2. List the disks on the system, and then select the OS disk that you attached:

        ```console
        list disk
        sel disk <number of the disk>
        ```

    3. List the volume, and then select the volume that contains Windows folder.

        ```console
        list vol
        sel vol <number of the volume>
        ```

    4. List the partition on the disk, and then select the partition that contains the Windows folder.

        ```console
        list partition
        sel partition <number of the Windows partition>
        ```

    5. View the status of the partition:

        ```console
        detail partition
        ```

        :::image type="content" source="media/os-not-found/detail-partition.png" alt-text="Screenshot of disk partition output, showing partition 1 is not active.":::

        If the partition is active, go to "Step 2: Repair the Boot Configuration data."

        If the partition is not active, run the `active` command to activate it.

        Then, run **detail partition** again to check whether the partition is active.

    6. Detach the repaired disk from the troubleshooting VM. Then, create a VM from the OS disk.

### Step 2: Repair the Boot Configuration data

1. Run the following command line as an administrator to verify the file system integrity and fix logical file system errors.

    ```console
    chkdsk <Windows partition>: /f
    ```

2. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code that resembles "xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx." You will use this identifier in the next step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /enum /v
    ```

3. Repair the Boot Configuration data by running the following commands. Replace the placeholders by using the actual values.

    > [!NOTE]
    > This step is applied to most corruption issues that affect startup configuration data. You must perform this step even if the **Device** and **OSDevice** values are pointing to the correct partition.

    - \<Windows partition> is the partition that contains a folder that is named "Windows."
    - \<Boot partition> is the partition that contains a hidden system folder that is named "Boot."
    - \<Identifier> is the identifier of Windows Boot Loader that you found in the previous step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} device partition=<boot partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} integrityservices enable

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} device partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} integrityservices enable

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} recoveryenabled Off

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} osdevice partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} bootstatuspolicy IgnoreAllFailures
    ```

4. Detach the repaired OS disk from the troubleshooting VM. Then, create a VM from the OS disk.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
