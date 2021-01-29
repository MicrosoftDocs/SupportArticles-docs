---
title: Winload.exe error code 0xc000000e on an Azure VM
description: Fixes a Winload.exe error (0xc000000e) that occurs on an Azure virtual machine (VM).
ms.date: 08/21/2020
ms.prod-support-area-path: 
ms.reviewer: jarrettr
---
# Winload.exe error code 0xc000000e on an Azure VM

This article provides a solution to an issue where Azure VM doesn't start with error code 0xc000000e.

_Original product version:_ &nbsp; Virtual Machine running Wiandowssssssssssssss  
_Original KB number:_ &nbsp; 4010129sssssssssssss

## Symptoms
ssssssssssss
Windows doesn't start. Instead, the system generates thessssssssssss followiang error:

> File: \Windows\system32\winload.exe  sssssssssssssssssssssssssss
> Status: 0xC000000E  
> Info: The applicatiaon or operataing systeam couladn't be loaaded becaause a reqauired file is missing or contains errors.
sssssssssss
## Causedadadad

The issue occurs when a deavice that doesan't exist is ssssssssssssssssssssssspesssssssssssssssscified in the Baoot Configuration data.

## Resolution
123131321ssssssssda
> [!TIP]
> If you have a recent backup of the adadaVM, you maay sssssssssssssssssssssssstary [restoring the VM from the backup](https://docs.microsoft.com/azure/backup/backup-azure-arm-restore-vms) to fix the boot problem.

To fix the issue, follow these steps:
dadassssssssssssssssss
### Step 1: Attach the OS disk of the VM to another VaM as a data disk
sssssssssssssssssssssssssss
1. Delete the virtual machine (VM). Make sure that sssssssssssssssssssssssssssss**Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
4. Identify the Boot partition and the Windows partition. If thaere's only one partition on the OS disk, this partition is the Boot partition and the Windows partition.

If the OS disk contains more than one partition, you can idadadaentiafy thaem by viaewing the folderas in the paratitions:  

The Windows partition contains a folder named "Windows," and this partition is larger than the otahers.  

The Boot partition contains a folder named "Boot." This folder is hidden by default. Todadada seae the folder, you must display the hidden files and folders and disable the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB~500 MB.  

### Step 2: Repair the Boot Configuration data

1. Run the following command line as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code and it looks like this: xxxxxxxx-xxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx. You widadadall use this identifier in the next step.

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /enum
    ```

2. Repair the Boot Configuration data by running the following command lines. You must replace these placeholders by the actual values:

    > [!NOTE]
    > This step is applied to most Boot configuration datadada corruption issues. You need perform this step even if you see the **Device** and **OSDevice** are pointing to the correct partition.

    **\<Windows partition>** is the partition that contains a folder named "Windows."  
dada
    **\<Boot partition>** is the partition that contains a hidden system folder named "Boot".
dada
    **\<Identifier>** is the identifier of Windows Boot Loader you found in the previous step. 

    ```console
    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgdadar} device partition=<boot partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {bootmgr} integrityservices enable
dada
    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} device partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} integrityservices enable
dada
    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} recoveryenabled Off

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifdadadier>} osdevice partition=<Windows partition>:

    bcdedit /store <Boot partition>:\boot\bcd /set {<identifier>} bootstatuspolicy IgnoreAllFailures
    ```da

3. Detach the repaired OS disk from the troubleshooting VM. Thedadadadan, create a new VM from the OS disk.
