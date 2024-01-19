---
title: Azure VM cannot RDP - working on features
description: Troubleshoot Azure VM cannot RDP - working on features.
ms.date: 01/19/2024
ms.reviewer: trmaier, v-weizhu
ms.service: virtual-machines
ms.subservice: vm-cannot-start-stop
ms.collection: windows
---

# Azure VM cannot RDP - working on features

## Symptoms

1. When you pull the screenshot of the VM, the screenshot shows the message:

   - Working on features
   - ##% complete
   - Don't turn off your computer

   :::image type="content" source="media/azure-vm-cannot-rdp-working-features/working-on-features-error-message.png" alt-text="Screenshot of the Working on features error message.":::

## Cause

A role or feature was added or removed from Windows.

## Solution

Refresh the screenshot in boot diagnostics a few times to monitor if there's any progress or if the VM is stuck. Only intercede if the machine is indeed stuck otherwise, you could break the role/feature further.

### Process overview

1. [Create and Access a repair VM](#1)
2. [Use DISM to rollback the change](#2)
3. [Enable Serial Console and Memory Dump Collection](#3)
4. [Rebuild the VM](#4)

### Create and access a repair VM<a id="1"></a>

1. Use [steps 1-3 of the VM repair commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to prepare a repair VM.
2. Use Remote Desktop Connection connect to the repair VM.

### Use DISM to roll back the change<a id="2"></a>

1. To determine the changes that the machine is trying to apply, check the `setup.evtx` logs and look for events `ID: 7` as seen in this example:

   (these logs are located at `<drive letter>:\Windows\System32\winevt\Logs\Setup.evtx`)

   ```ps
   Time: 4/27/2020 6:16:51 AM
   ID: 7
   Level:Information
   Source: Microsoft-Windows-Servicing
   Machine: hostname.domain
   Message: Initiating changes to turn on update EnhancedStorage of package Enhanced Storage. Client id: DISM Package Manager Provider.
   ```

2. From this event, you will get the package name and then using DISM tool, you could remove it:

   ```ps
   Dism /Image:<OS Disk letter>:\ /Disable-Feature /FeatureName:<<Feature to remove>>
   ```

   For The example above, the syntax would be:

   ```ps
   Dism /Image:G:\ /Disable-Feature /FeatureName:EnhancedStorage
   ```

### Enable the Serial Console and memory dump collection<a id="3"></a>

**Recommended**: Before you rebuild the VM, enable the Serial Console and memory dump collection by running the following script:

1. Open an elevated command prompt session as an administrator.
1. Run the following commands:

   **Enable the Serial Console**:

   ```cmd
   bcdedit /store <VOLUME LETTER WHERE THE BCD FOLDER IS>:\boot\bcd /ems {<BOOT LOADER IDENTIFIER>} ON 
   bcdedit /store <VOLUME LETTER WHERE THE BCD FOLDER IS>:\boot\bcd /emssettings EMSPORT:1 EMSBAUDRATE:115200
   ```

1. Verify that the free space on the OS disk is larger than the memory size (RAM) on the VM.

   If there's not enough space on the OS disk, change the location where the memory dump file will be created, and refer that location to any data disk attached to the VM that has enough free space. To change the location, replace **%SystemRoot%** with the drive letter of the data disk, such as **F:**, in the following commands.

   Suggested configuration to enable OS Dump:

    **Load the broken OS Disk:**

   ```cmd
   REG LOAD HKLM\BROKENSYSTEM <VOLUME LETTER OF BROKEN OS DISK>:\windows\system32\config\SYSTEM 
   ```

   **Enable on ControlSet001**:

   ```cmd
   REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f 
   REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f 
   REG ADD "HKLM\BROKENSYSTEM\ControlSet001\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f
   ```

   **Enable on ControlSet002**:

   ```cmd
   REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v CrashDumpEnabled /t REG_DWORD /d 1 /f 
   REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v DumpFile /t REG_EXPAND_SZ /d "%SystemRoot%\MEMORY.DMP" /f 
   REG ADD "HKLM\BROKENSYSTEM\ControlSet002\Control\CrashControl" /v NMICrashDump /t REG_DWORD /d 1 /f
   ```

   **Unload Broken OS Disk**:

   ```cmd
   REG UNLOAD HKLM\BROKENSYSTEM
   ```

### Rebuild the VM<a id="4"></a>

Use [step 5 of the VM repair commands](repair-windows-vm-using-azure-virtual-machine-repair-commands.md#repair-process-example) to reassemble the VM.

[!INCLUDE [Azure Help Support](../../includes/azure-help-support.md)]
