---
title: Windows boot error 0xc00000ba in the Azure VM
description: Provides a solution to an issue where Windows VM doesn't start with error code 0xc00000ba
ms.date: 07/21/2020
ms.reviewer: 
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---
# Windows boot error 0xc00000ba in the Azure VM

This article provides a solution to an issue where Windows VM doesn't start with error code 0xc00000ba.

_Original product version:_ &nbsp; Virtual Machine running Windows  
_Original KB number:_ &nbsp; 4010136

## Symptom

Windows doesn't start. Instead, the system generates an error that resembles the following:

> File: \Windows\System32\drivers\\\<filename>  
> Status: 0xc00000ba  
> Info:  The operating system couldn't be loaded because a critical system driver is missing or contains errors.

## Cause

This issue occurs because that the Windows system files are corrupt. This may occur if one of the following conditions is true:

- An unfinished installation
- An unfinished file erasure
- Bad deletion of application or equipment
- The laptop of desktop is contaminated with a Trojan attack
- A poor shutdown of the computer system

The damaged system file causes absent, incorrectly linked documents, and archives essential for the correct operation of the program.

## Resolution

> [!TIP]
> If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps.

### Step 1 Uninstall the recently installed software or service

If the boot issue occurs after you installed software or services, try to disable the service. If the issue still occurs, fully uninstall the software.

- To disable a service, follow these steps:

    1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks** option when you do this.
    2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
    3. Connect to the troubleshooting VM. Open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
    4. On the OS disk you attached, navigate to **\windows\system32\config**. Copy all the files as a backup in case a rollback is required.
    5. On the troubleshooting VM, open Registry Editor (regedit.exe).
    6. Click the **HKEY_LOCAL_MACHINE** key, and then select **File>Load Hive**  on the menu.
    7. Navigate to **\windows\system32\config\SYSTEM**, type a name for the hive, such as **ProblemSystem**. After you do this, you will see the registry hive under **HKEY_LOCAL_MACHINE**.
    8. Navigate to `HKEY_LOCAL_MACHINE\ProblemSystem\ControlSet001\services\<ServiceNname>`, change the value data of **Start** to 4, which means disable the service.
    9. Detach the repaired disk from the troubleshooting VM. Then, create a VM from the OS disk.

- To fully uninstall the software, you need to download the OS disk in on-premises and uninstall the software.

### Step 2 Repair the corrupted file system

1. Delete the virtual machine (VM). Make sure that you select the **Keep the disks**  option when you do this.
2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM, and then open **Computer management** > **Disk management**. Make sure that the OS disk is online and that its partitions have drive letter assigned.
4. You have two options at this point,  you can either use the recovery console images that come with every OS installation and try to use it as a repository or else you can download full ISO of the Windows version of the VM.

    If you want to use the recovery console image, note that it is a small and compact image, which may not have the binary that you need to use, if that's the case, SFC could ended up saying that there's corruption but the binary that you need is not on this image. If that's the case, you still need to go to the second option using a full ISO image. Use the WinRE image located in every Windows installation (Recover console image) as a repository to try to fix the corruption.

    - To use the recovery console image, run the following commands in elevated a CMD instance:

        ```console
        Dism <Drive letter of the broken OSdisk>:\ /cleanup-image /restorehealth /source:wim: <Drive letter of the broken OSdisk>:\recovery\windowsRE\winre.wim:1
        ```

        The following example assumes G is the letter assigned to the OS disk:

        ```console
        Dism /image:g:\ /cleanup-image /restorehealth /source:wim:g:\recovery\windowsRE\winre.wim:1
        ```

    - To download a full ISO for that windows version, extract files from the media ISO, and then locate the WIM file inside and use it as the repository:

        ```console
        Dism /image:<Drive letter of the broken OSdisk>:\ /cleanup-image /restorehealth /source:<Wim file from ISO>:1
        ```

5. Recreate the VM.
6. If the VM still doesn't boot, then reattach the OS disk on a troubleshooting VM and run an SFC command over the image:

    ```console
    sfc /scannow /offbootdir=<Drive letter of the broken OS>:\ /offwindir=<Drive letter of the broken OS>:\windows
    ```

7. If SFC states that the corruption is fixed, detach the OS disk from the troubleshooting VM, and wait until Azure updates the disk lease (3 minutes at most).
8. Recreate the VM.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
