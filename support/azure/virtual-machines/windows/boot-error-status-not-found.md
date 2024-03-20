---
title: Troubleshoot Windows Boot Manager error  - 0xC0000225 Status not found
description: Resolve issues in which the 0xC0000225 error code occurs in Windows Boot Manager on an Azure Virtual Machine.
services: virtual-machines, azure-resource-manager
author: JarrettRenshaw
ms.author: jarrettr
tags: azure-resource-manager
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
ms.workload: na
ms.tgt_pltfrm: vm-windows
ms.date: 11/08/2023
editor: v-jsitser
ms.reviewer: azurevmcptcic, v-leedennis
ms.topic: troubleshooting-general
---

# Troubleshoot Windows Boot Manager error  - 0xC0000225 "Status not found"

This article provides steps to resolve startup issues in which a `0xC0000225` error code occurs on Azure Virtual Machines. This error states that the status or object isn't found.

*Original product version:* &nbsp; Virtual Machine running Windows  
*Original KB number:* &nbsp; 4010138

## Symptoms

A Windows virtual machine (VM) doesn't start. When you use [boot diagnostics](./boot-diagnostics.md) to view a screenshot of the VM, you see that the screenshot of the Windows Boot Manager console includes the following text:

- A "Windows failed to start" error message
- A `0xc0000225` error code
- More information about the error

The file that's associated with this error code shows which steps to take so that you can resolve the issue. The errors that might be shown in the Windows Boot Manager console are displayed in the following sections.

### Symptom 1: Error in a system file within the \\Windows\\System32\\drivers directory

```console
████████████████████████████Windows Boot Manager████████████████████████████████

Windows failed to start. A recent hardware or software change might be the
cause. To fix the problem:

  1. Insert your Windows installation disc and restart your computer.
  2. Choose your language settings, and then click "Next."
  3. Click "Repair your computer."

If you do not have this disc, contact your system administrator or computer
manufacturer for assistance.

    File: \Windows\System32\drivers\<driver-name>.sys

    Status: 0xc0000225

    Info: The operating system couldn't be loaded because a critical system
          driver is missing or contains errors.



█ENTER=OS Selection███████████████████████████████████████████████ESC=Recovery██
```

### Symptom 2: Error without a displayed file

```console
████████████████████████████Windows Boot Manager████████████████████████████████

Windows failed to start. A recent hardware or software change might be the
cause. To fix the problem:

  1. Insert your Windows installation disc and restart your computer.
  2. Choose your language settings, and then click "Next."
  3. Click "Repair your computer."

If you do not have this disc, contact your system administrator or computer
manufacturer for assistance.



    Status: 0xc0000225

    Info: The boot selection failed because a required device is
          inaccessible.



█ENTER=Continue███████████████████████████████████████████████████████ESC=Exit██
```

> [!NOTE]  
> In the `Info` field, you might see the following alternative text:
>
> > An unexpected error has occurred.

### Symptom 3: Error in the \\WINDOWS\\system32\\config\\system file

```console
████████████████████████████Windows Boot Manager████████████████████████████████

Windows failed to start. A recent hardware or software change might be the
cause. To fix the problem:

  1. Insert your Windows installation disc and restart your computer.
  2. Choose your language settings, and then click "Next."
  3. Click "Repair your computer."

If you do not have this disc, contact your system administrator or computer
manufacturer for assistance.

    File: \WINDOWS\system32\config\system

    Status: 0xc0000225

    Info: The operating system couldn't be loaded because the system
          registry file is missing or contains errors.



█ENTER=OS Selection█████████████████████████████████████████████████████████████
```

> [!NOTE]  
> You might see a similar type of error message on a blue screen on the **Recovery** page:
>
> > **Recovery**
> >
> > **Your PC/Device needs to be repaired**
> >
> > The operating system couldn't be loaded because the system registry file is missing or contains errors.
> >
> > File: \\Windows\\system32\\config\\system  
> > Error code: 0xc0000225
> >
> > Choose one of the options below to address this problem.
> >
> >
> >
> > **Press Esc for recovery**  
> > **Press Enter to try again**  
> > **Press F8 for Startup Settings**  

## Potential solution: Restore the VM from a backup

If you have a recent backup of the VM, you can try to [restore the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the startup problem. However, if restoring the VM from backup isn't possible, continue to the *Cause* sections.

## Cause 1: Missing or corrupted system binary file

The file that's associated with the error code is a system binary (*.sys*) file that's missing or corrupted.

### Solution 1: Repair the system binary file

Repair the system binary file by following these steps:

1. On the attached disk, browse to the location of the binary file that's displayed in the error message.
2. Rename the file to *\<BINARY.SYS>.OLD*.
3. On the attached disk, browse to the *\\Windows\\winsxs* folder. Then, search for the binary file that's displayed in the error message. To do this, run the following command at a command prompt:

   ```cmd
   dir <binary-name> /s
   ```

   The command lists all the different versions of the binary file together with the created date. Copy the latest version of the binary file to the *windows\\system32* folder by running the following command:

   ```cmd
   copy <drive>:\Windows\WinSxS\<directory-where-file-is>\<binary-with-extension> <drive>:\Windows\System32\Drivers\
   ```

   For example, see the following console output:

   ```console
   E:\Windows\WinSxS>dir ACPI.sys /s
    Volume in drive E has no label.
    Volume Serial Number is A0B1-C2D3
   
    Directory of E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_cdef0123456789ab
   
   11/21/2014  07:48 PM            94,989 acpi.sys
                  1 File(s)         94,989 bytes
   
    Directory of E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_89abcdef01234567
   
   11/21/2014  07:48 PM           119,547 acpi.sys
                  1 File(s)        119,547 bytes
   
    Directory of E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_456789abcdef0123
   
   11/21/2014  04:06 PM           533,824 acpi.sys
                  1 File(s)        533,824 bytes
   
        Total Files Listed:
                  3 File(s)        748,360 bytes
                  0 Dir(s)  123,967,512,576 bytes free

   E:\Windows\WinSxS>copy E:\Windows\WinSxS\amd64_acpi.inf_0123456789abcdef_6.3.9600.16384_none_cdef0123456789ab\acpi.sys E:\Windows\System32\Drivers\
           1 file(s) copied.

   E:\Windows\WinSxS>
   ```

   > [!NOTE]  
   > - The screenshot shows volume E as an example. The actual letter should reflect the faulty drive (the OS disk attached as a data disk on the troubleshooting VM).
   >
   > - If the latest binary doesn't work, you can try the previous file version to obtain an earlier system update level on that component.
   >
   > - If the only binary that's returned in this step matches the file that you're trying to replace on the affected VM, and if both files have the same size and time stamp, you can replace the corrupted file by copying it from another working VM that has the same OS and, if possible, the same system update level.
4. Detach the repaired disk from the troubleshooting VM. Then, create a VM from the OS disk.

## Cause 2: Corrupted boot configuration data or incorrectly prepared virtual hard drive

If a file name isn't shown in the error screen, and you see a message that states "The boot selection failed because a required device is inaccessible," then the cause of the problem is one of the following scenarios:

- The boot configuration data (BCD) is corrupted.

- The virtual hard drive (VHD) is migrated from on-premises, but it's prepared incorrectly.

### Solution 2: Repair the boot configuration data

Repair the boot configuration data by running [BCDEdit](/windows-server/administration/windows-commands/bcdedit) commands as an administrator. To do this, follow these steps:

1. Delete the VM.

   > [!IMPORTANT]  
   > When you're prompted to confirm the VM deletion, make sure that you clear the **Delete with VM** option that's associated with the OS disk resource type.

2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM.
4. Select **Start**, and then search for and select **Computer management**. In the console tree of the Computer Management app, select **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
5. Identify the Boot partition and the Windows partition. If there's only one partition on the OS disk, this partition is both the Boot partition and the Windows partition.

   If the OS disk contains more than one partition, you can identify them by viewing the folders in the partitions:  

   - The Windows partition contains a folder that's named *Windows*. This partition is larger than the others.  

   - The Boot partition contains a folder that's named *Boot*. This folder is hidden by default. To see the folder in File Explorer, open the **Folder Options** dialog box, select to display hidden files and folders, and then clear the **Hide protected operating system files (Recommended)** option. The boot partition is typically 300 MB to 500 MB.  

6. Run the following [BCDEdit /enum](/windows-hardware/drivers/devtest/bcdedit--enum) command as an administrator, and then record the identifier of Windows Boot Loader (not Windows Boot Manager). The identifier is a 32-character code in GUID format (xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx). You have to use this identifier in the next step.

   ```cmd
   bcdedit /store <Boot partition>:\boot\bcd /enum /v
   ```

   > [!NOTE]  
   > If there isn't a *bcd* store file in the *boot* folder of the Boot partition, restore the file by following the steps in [Solution 1: Repair the system binary file](#solution-1-repair-the-system-binary-file), but for *\\boot\\bcd* file.

7. Repair the Boot Configuration data by running the following [BCDEdit /set](/windows-hardware/drivers/devtest/bcdedit--set) commands. Change the placeholders to the actual values, as described in the following table.

   | Placeholder              | Value                                                                     |
   |--------------------------|---------------------------------------------------------------------------|
   | **\<Windows partition>** | The partition that contains a folder that's named *Windows*               |
   | **\<Boot partition>**    | The partition that contains a hidden system folder that's named *Boot*    |
   | **\<Identifier>**        | The identifier of Windows Boot Loader that you found in the previous step |

   ```cmd
   bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} OSDEVICE BOOT
   ```

   ```cmd
   bcdedit /store <Boot partition>:\boot\bcd /set {<Identifier>} OSDEVICE partition=<Windows partition>:
   ```

8. Detach the repaired OS disk from the troubleshooting VM. Then, create a VM from the OS disk.

## Cause 3: Registry hive corruption

The file that's associated with the error is a registry file, such as *\\WINDOWS\\system32\\config\\system*.

These errors occur because the registry hive is corrupted. A registry hive can become corrupted if any of the following scenarios occur:

- The hive fails.
- The hive mounts but is empty.
- The hive wasn't closed correctly.

### Solution 3: Fix the corrupted hive

[!INCLUDE [Registry important alert](../../../includes/registry-important-alert.md)]

Fix the corrupted hive by following these steps:

1. Delete the VM.

   > [!IMPORTANT]  
   > When you're prompted to confirm the VM deletion, make sure that you clear the **Delete with VM** option that's associated with the OS disk resource type.

2. Attach the OS disk as a data disk to another VM (a troubleshooting VM). For more information, see [How to attach a data disk to a Windows VM in the Azure portal](/azure/virtual-machines/windows/attach-managed-disk-portal).
3. Connect to the troubleshooting VM.
4. Select **Start**, and then search for and select **Computer management**. In the console tree of the Computer Management app, select **Disk management**. Make sure that the OS disk is online and that its partitions have drive letters assigned.
5. On the OS disk that you attached, navigate to the *\\windows\\system32\\config* directory. Copy all the files to a backup folder in case a rollback is required.
6. Select **Start**, and then search for and select **Registry Editor** (*regedit.exe*).
7. In the Registry Editor app, select the `HKEY_USERS` subtree, select **File** > **Load Hive** on the menu, and then load the *\\windows\\system32\\config\SYSTEM* file.
8. If the hive loads without issues, this means that the hive was not closed correctly. In this situation, unload the hive to unlock the file and fix the issue.

   > [!NOTE]  
   > If you receive the following error message, [contact Azure Support](https://portal.azure.com/?#blade/Microsoft_Azure_Support/HelpAndSupportBlade):
   >
   > > Cannot load \<drive>:\\Windows\\System32\\config\\SYSTEM: Error while loading hive

9. Detach the repaired OS disk from the troubleshooting VM. Then, create a new VM from the OS disk.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
