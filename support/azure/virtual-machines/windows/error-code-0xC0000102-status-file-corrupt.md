---
title: Windows stop error 0xC0000102 Status File Corrupt
description: Understand how to fix error 0xC0000102 (Status File Corrupt) that occurs on an Azure virtual machine (VM).
ms.date: 10/09/2023
ms.reviewer: jarrettr, v-leedennis
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---

# Windows stop error 0xC0000102 Status File Corrupt

This article provides steps to resolve issues where the Windows operating system (OS) encounters the stop error 0xC0000102, which keeps an Azure virtual machine (VM) from booting.

## Symptoms

When you use [boot diagnostics](/azure/virtual-machines/troubleshooting/boot-diagnostics) to view the screenshot of the VM, the screenshot displays the message that the OS encountered error code 0xC0000102 during startup.

:::image type="content" source="media/error-code-0xC0000102-status-file-corrupt/error-code-0xc0000102.png" alt-text="Screenshot shows the detailed information about Error 0xC0000102.":::

:::image type="content" source="media/error-code-0xC0000102-status-file-corrupt/0xc0000102-status.png" alt-text="Error 0xC0000102 on a CMD screen.":::

## Cause

Error 0xC0000102 is a STATUS_FILE_CORRUPT_ERROR, which means a corrupted file is preventing your VM from starting correctly. There are two possible causes for this error code:

- The file displayed in the error message is corrupt.
- The disk structure has become corrupt and unreadable.

## Solution

### Try restoring the VM from a backup

If you have a recent backup of the VM, you may try [restoring the VM from the backup](/azure/backup/backup-azure-arm-restore-vms) to fix the start problem. If restoring the VM from backup isn't possible, follow these steps:

1. Create and Access a Repair VM
2. Repair or replace the corrupt file
3. Enable serial console and memory dump collection
4. Rebuild the VM

> [!NOTE]
> When encountering this error, the Guest OS isn't operational. You'll be troubleshooting in offline mode to resolve this issue.

### Step 1: Create and access a repair VM

1. Follow steps 1-3 of the VM [repair process example](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands#repair-process-example) to prepare a Repair VM.
2. Use Remote Desktop Connection connect to the Repair VM.

### Step 2: Repair or replace the corrupt file

- **Repair the corrupt file**

   Open an elevated CMD prompt and run **chkdsk** on the disk:

   ```cmd
   chkdsk <<DRIVE LETTER>: /F
   ```

- **Replace the corrupt file**

1. Use boot diagnostics to view the screenshot of the VM. Note the file that is displayed in the error.
2. To replace the corrupt binary, take the following steps:

    1. Browse to the location of the binary that was displayed in the screenshot.
    1. Note the version of the file. (Right-click **Properties** and select the **Details** tab.)

        :::image type="content" source="media/error-code-0xC0000102-status-file-corrupt/file-version.png" alt-text="Screenshot shows the information under the Details tab. File version is highlighted.":::

    1. Rename the file as <FILENAME.EXT>.OLD. For example, the file shown in the image above would be renamed from ***\windows\system32\drivers\cng.sys*** to ***\windows\system32\drivers\cng.sys.old***.

3. Restore this file from the internal repository.

    1. Launch a CMD session and locate the volume holding your Windows directory.
    1. Browse to **\windows\winsxs** and search for the binary displayed on your screenshot:

        ```cmd
        dir <<binary from the screenshot with extension>> /s
        ````

    1. The following command will list all the different versions of the specified file that the VM contains and will give you the path history of that component. You should choose the most recent of the same version from the list and proceed to copy that file to the folder path described in the screenshot.

        ```cmd
        copy
                
        <<drive>>:\Windows\WinSxS\<<directory_where_file_is>>\<<binary_with_extension>> <<drive>>:\Windows\System32\Drivers\ 
        ```

### Step 3: Enable the Serial Console and memory dump collection

Before rebuilding the VM, it is recommended to enable memory dump collection and Serial Console. To do so, run the following script:

1. Open an elevated command prompt session (run as administrator).
2. List the BCD store data and determine the boot loader identifier, which you'll use in the next step.
    1. For a **Generation 1 VM**, enter the following command and note the identifier listed:

        ```console
        bcdedit /store <BOOT PARTITON>:\boot\bcd /enum
        ```

        In the command, replace `<BOOT PARTITON>` with the letter of the partition in the attached disk that contains the boot folder.

        :::image type="content" source="media/error-code-0xC0000102-status-file-corrupt/identifier.png" alt-text="Screenshot shows the output of listing the BCD store in a Generation 1 VM, which lists the identifier number under Windows Boot Loader .":::

    2. For a **Generation 2 VM**, enter the following command and note the identifier listed:

        ```console
        BCDEDIT /store <LETTER OF THE EFI SYSTEM PARTITION>:EFI\Microsoft\boot\bcd /enum 
        ```

        - In the command, replace `<LETTER OF THE EFI SYSTEM PARTITION>` with the letter of the EFI System Partition.
        - It may be helpful to launch the Disk Management console to identify the appropriate system partition labeled as *EFI System Partition*.
        - The identifier may be a unique GUID or it could be the default *bootmgr*.

3. Run the following commands to enable Serial Console:

    ```console
    BCDEDIT /store <VOLUME LETTER WHERE THE BCD FOLDER IS>:\boot\bcd /ems {<BOOT LOADER IDENTIFIER>} ON  
    BCDEDIT /store <VOLUME LETTER WHERE THE BCD FOLDER IS>:\boot\bcd /emssettings EMSPORT:1 EMSBAUDRATE:115200 
    ```

    - In the command, replace `<VOLUME LETTER WHERE THE BCD FOLDER IS>` with the letter of the BCD folder.
    - In the command, replace `<BOOT LOADER IDENTIFIER>` with the identifier you found in the previous step.

4. Verify that the free space on the OS disk is greater than the memory size (RAM) on the VM.
    1. If there's not enough space on the OS disk, you should change the location where the memory dump file will be created. Rather than creating the file on the OS disk, you can refer it to any other data disk attached to the VM that has enough free space. To change the location, replace **%SystemRoot%** with the drive letter (for example **F:**) of the data disk in the commands listed below.
    2. Enter the commands below (suggested dump configuration):

    **Load Registry Hive from the broken OS Disk:**

    ```console
    REG LOAD HKLM\BROKENSYSTEM <VOLUME LETTER OF BROKEN OS DISK>:\windows\system32\config\SYSTEM
    ```

    **Enable on ControlSet001:**

    ```console
    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f 
    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f 
    REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f 
    ```

    **Enable on ControlSet002:**

    ```console
    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f 
    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f 
    REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f 
    ```

    **Unload Broken OS Disk:**

    ```console
    REG UNLOAD HKLM\BROKENSYSTEM
    ```

### Step 4: Rebuild the VM

Use [step 5 of the VM Repair Commands](/azure/virtual-machines/troubleshooting/repair-windows-vm-using-azure-virtual-machine-repair-commands) to rebuild the VM.

[!INCLUDE [Azure Help Support](../../../includes/azure-help-support.md)]
