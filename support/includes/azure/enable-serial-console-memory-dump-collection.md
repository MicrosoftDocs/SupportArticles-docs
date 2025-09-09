---
author: JarrettRenshaw
ms.author: jarrettr
ms.service: azure-virtual-machines
ms.topic: include
ms.date: 01/16/2024
ms.reviewer: jarrettr
---
1. Open an elevated command prompt session as an administrator.
1. Run the following [BCDEdit](/windows-server/administration/windows-commands/bcdedit) commands using the [/ems](/windows-hardware/drivers/devtest/bcdedit--ems) and [/emssettings](/windows-hardware/drivers/devtest/bcdedit--emssettings) options:

   **Enable the serial console:**

   ```cmd
   bcdedit /store <volume-letter-containing-the-bcd-folder>:\boot\bcd /ems {<boot-loader-identifier>} ON
   bcdedit /store <volume-letter-containing-the-bcd-folder>:\boot\bcd /emssettings EMSPORT:1 EMSBAUDRATE:115200
   ```

1. Verify that the free space on the OS disk is larger than the memory size (RAM) on the VM.

   If there isn't enough space on the OS disk, change the location where the memory dump file is created, and refer that location to any data disk attached to the VM that has enough free space. To change the location, replace `%SystemRoot%` with the drive letter of the data disk, such as `F:`, in the following commands.

   To enable the OS dump file, run the following [load](/windows-server/administration/windows-commands/reg-load), [add](/windows-server/administration/windows-commands/reg-add), and [unload](/windows-server/administration/windows-commands/reg-unload) commands to implement the suggested configuration using the [reg](/windows-server/administration/windows-commands/reg) tool:

   **Load the registry hive from the broken OS disk:**

   ```cmd
   reg load HKLM\<broken-system> <volume-letter-of-broken-os-disk>:\windows\system32\config\SYSTEM
   ```

   **Enable on ControlSet001:**

   ```cmd
   reg add "HKLM\<broken-system>\ControlSet001\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f
   reg add "HKLM\<broken-system>\ControlSet001\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f
   reg add "HKLM\<broken-system>\ControlSet001\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f
   ```

   **Enable on ControlSet002:**

   ```cmd
   reg add "HKLM\<broken-system>\ControlSet002\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f
   reg add "HKLM\<broken-system>\ControlSet002\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f
   reg add "HKLM\<broken-system>\ControlSet002\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f
   ```

   **Unload the broken OS disk:**

   ```cmd
   reg unload HKLM\<broken-system>
   ```

