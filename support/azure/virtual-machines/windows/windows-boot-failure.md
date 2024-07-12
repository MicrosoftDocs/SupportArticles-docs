---
title: Windows boot error (INACCESSIBLE_BOOT_DEVICE) or (Boot failure) in an Azure VM
description: Provides a solution to an issue where a Windows VM doesn't start with error INACCESSIBLE_BOOT_DEVICE or Boot failure.
ms.date: 07/12/2024
ms.reviewer: 
ms.service: virtual-machines
ms.collection: windows
ms.custom: sap:My VM is not booting
---
# Windows boot error INACCESSIBLE_BOOT_DEVICE in an Azure VM

**Applies to:** :heavy_check_mark: Windows VMs

_Original KB number:_ &nbsp; 4010143

This article provides a solution to an issue where a Windows virtual machine (VM) doesn't start with the error "INACCESSIBLE_BOOT_DEVICE" or "Boot failure".

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

[!INCLUDE [Verify that Windows partition is active](../../../includes/azure/windows-vm-verify-set-active-partition.md)]

## Repair the Boot Configuration Data

1. Run the following command line as an administrator to verifies the file system integrity and fixes logical file system errors.

    ```console
    chkdsk <Windows partition>: /f
    ```

2. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code and it looks like this: xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. You will use this identifier in the next step.

   1. For Generation 1 VMs:

       ```console
       bcdedit /store <Boot partition>:\boot\bcd /enum /v
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

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
