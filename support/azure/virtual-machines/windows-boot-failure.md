---
title: Windows boot error (INACCESSIBLE_BOOT_DEVICE) or (Boot failure) in an Azure VM
description: Provides a solution to an issue where a Windows VM doesn't start with error INACCESSIBLE_BOOT_DEVICE or Boot failure.
ms.date: 05/18/2023
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error INACCESSIBLE_BOOT_DEVICE in an Azure VM

This article provides a solution to an issue where a Windows virtual machine (VM) doesn't start with the error "INACCESSIBLE_BOOT_DEVICE" or "Boot failure".

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010143

## Symptoms

A Windows VM doesn't start and generates one of the following errors:

> Boot failure. Reboot and Select proper Boot device or Insert Boot Media in selected Boot device.

> Your PC ran into a problem and needs to restart. We'll restart for you.
If you'd like to know more, you can search online later for this error: INACCESSIBLE_BOOT_DEVICE

## Cause

This issue occurs for one of the following reasons:

- The Boot Configuration Data (BCD) is corrupted.
- The partition that contains the Windows installation is inactive.

## Stop (de-allocate) and start the VM

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, stop (de-allocate) and start the VM then recheck to see if issue persists. If the issue persists, follow these steps:

## Verify if the Windows partition is marked as active

> [!NOTE]
> This section applies only to Generation 1 VMs because Generation 2 VMs that use UEFI don't use an active partition.

1. Delete the VM. Make sure that you select the **Keep the disks** option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is the Boot partition and the Windows partition.

    If the OS disk contains more than one partition, you can identify them by viewing the folders in the partitions:  

    The Windows partition contains a folder named "Windows," and this partition is larger than the others.  

    The Boot partition contains a folder named "Boot." This folder is hidden by default. To see the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.  

5. Run the following command as an administrator, which will create a boot record.

    ```console
    bcdboot <Windows partition>:\Windows /S <windows partition>:
    ```

6. Use DISKPART to check if the Windows partition is active:

    1. Run the following command to open diskpart:

        ```console
        diskpart
        ```

    2. List the disks on the system, and then select the OS disk you attached:

        ```console
        list disk  
        sel disk <number of the disk>
        ```

    3. List the volume, and then select the volume that contains the Windows folder.

        ```console
        list vol
        sel vol <number of the volume>
        ```

    4. List the partition on the disk, and then select the partition contains the Windows folder.

        ```console
        list partition
        sel partition <number of the Windows partition>
        ```

    5. View the status of the partition:

        ```console
        detail partition
        ```

        :::image type="content" source="media/windows-boot-failure/detail-partition.png" alt-text="Screenshot of diskpart output, showing partition 1 is the selected partition but not active.":::

        If the partition is active, go to the step 2.

        If the partition isn't active, run the following command line to active it:

        ```console
        active
        ```

        Then run `detail partition` again to check if the partition is active.

7. Detach the repaired disk from the troubleshooting VM. Then, create a VM from the OS disk.

## Repair the Boot Configuration Data

1. Run the following command line as an administrator to verifies the file system integrity and fixes logical file system errors.

    ```console
    chkdsk <Windows partition>: /f
    ```

2. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code and it looks like this: xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. You will use this identifier in the next step.

   1. For Generation 1 VMs:

       ```console
       bcdedit /store <Boot partition>:\boot\bcd /enum
       ```  
   2. For Generation 2 VMs:
 
       ```console
       bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /enum /v
       ``` 

3. Repair the Boot Configuration Data by running the following command lines. You must replace these placeholders by the actual values:

    > [!NOTE]
    > This step is applied to most Boot Configuration Data corruption issues. You need perform this step even if you see the **Device** and **OSDevice** are pointing to the correct partition.  

    - `<Windows partition` is the partition that contains a folder named "Windows."
    - `<Boot partition>` is the partition that contains a hidden system folder named "Boot."
    - `<Identifier>` is the identifier of Windows Boot Loader you found in the previous step.

   1. For Generation 1 VMs:

      ```console
      bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} device partition=<boot partition>:
      bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} integrityservices enable
      bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} device partition=<Windows partition>:
      bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} integrityservices enable
      bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} recoveryenabled Off
      bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} osdevice partition=<Windows partition>:
      bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} bootstatuspolicy IgnoreAllFailures
      ```

      If the VHD has a single partition and both the BCD folder and Windows folder are in the same volume, and if the previous setup didn't work, then try replacing the partition values with `boot`, as shown below:

      ```console
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {bootmgr} device boot
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {bootmgr} integrityservices enable
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} device boot
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} integrityservices enable
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} recoveryenabled Off
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} osdevice boot
      bcdedit /store <BCD FOLDER - DRIVE LETTER>:\boot\bcd /set {<IDENTIFIER>} bootstatuspolicy IgnoreAllFailures
      ```
   2. For Generation 2 VMs:

     ```console
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {bootmgr} device partition=<Volume Letter of EFI System Partition>:
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {bootmgr} integrityservices enable
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} device partition=<WINDOWS FOLDER - DRIVE LETTER>:
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} integrityservices enable
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} recoveryenabled Off
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} osdevice partition=<WINDOWS FOLDER - DRIVE LETTER>:
     bcdedit /store <Volume Letter of EFI System Partition>:EFI\Microsoft\boot\bcd /set {<IDENTIFIER>} bootstatuspolicy IgnoreAllFailures
     ```

4. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
