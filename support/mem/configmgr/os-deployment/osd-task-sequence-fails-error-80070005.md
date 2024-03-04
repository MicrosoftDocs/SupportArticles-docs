---
title: An OSD task sequence fails with error 80070005
description: Describes an issue where an OSD task sequence fails during the Setup Windows and ConfigMgr step. This issue occurs when the step still runs in Windows PE.
ms.date: 12/05/2023
ms.custom: sap:Task sequence tasks
ms.reviewer: kaushika
---
# Configuration Manager OSD task sequence fails with error code 80070005

This article fixes an issue in which an OSD task sequence fails during the **Setup Windows and ConfigMgr** step.

_Original product version:_ &nbsp; Configuration Manager  
_Original KB number:_ &nbsp; 4509131

## Symptoms

A Configuration Manager OSD task sequence fails during the **Setup Windows and ConfigMgr** step when the step still runs in Windows PE.

The following error messages are logged in the `X:\windows\temp\smstslog\smsts.log` file:

> OSDSetupWindows    Installing hook to 'C:\WINDOWS'  
> OSDSetupWindows    Command line for extension .EXE is "%1" %*  
> OSDSetupWindows    Set command line: "X:\sms\bin\x64\OSDSETUPHOOK.EXE" "/install:C:\WINDOWS" /version:10.0  
> OSDSetupWindows    Executing command line: "X:\sms\bin\x64\OSDSETUPHOOK.EXE" "/install:C:\WINDOWS" /version:10.0  
> OSDSetupHook    Installing OSD setup hook  
> OSDSetupHook    !shCmdFile.null(), HRESULT=80070005 (..\vistasetuphook.cpp,96)  
> OSDSetupHook    Failed to install the setup hook. Permissions on the requested may be configured incorrectly.  
> Access is denied. (Error: 80070005; Source: Windows)  
> OSDSetupHook    pHook->install(sWindowsDir), HRESULT=80070005 (..\osdsetuphook.cpp,385)  
> OSDSetupHook    Failed to install OSD setup hook (0x80070005)  
> OSDSetupWindows    Process completed with exit code 2147942405  
> OSDSetupWindows    exitCode, HRESULT=80070005 (setupwindows.cpp,785)  
> OSDSetupWindows    Install setup hook failed with error code (80070005).  
> OSDSetupWindows    this->installSetupHook(), HRESULT=80070005 (setupwindows.cpp,452)  
> OSDSetupWindows    Failed to install setup hook (80070005)  
> OSDSetupWindows    setup.run(), HRESULT=80070005 (setupwindows.cpp,1650)  
> OSDSetupWindows    Exiting with code 0x80070005  
> TSManager    Process completed with exit code 2147942405  
> TSManager    !-----------------------------------------------------------------------!  
> TSManager    Failed to run the action: Setup Windows and ConfigMgr. Permissions on the requested may be configured incorrectly.  
> Access is denied. (Error: 80070005; Source: Windows)

Here's the detail information about error code 80070005 (2147942405):

> Error Code: 0x80070005 (2147942405)  
> Error Name: E_ACCESSDENIED  
> Error Source: Windows  
> Error Message: General access denied error

## Cause

This issue occurs if a custom SetupComplete.cmd file is specified. OSD task sequences use the SetupComplete.cmd file to continue the task sequence after Windows Setup finishes. If a custom SetupComplete.cmd file is specified, the task sequence can't install its own SetupComplete.cmd file. And it returns the **Access is denied** error. So custom SetupComplete.cmd files aren't allowed with Configuration Manager OSD task sequences.

A custom SetupComplete.cmd file may be specified in one of the following ways:

- It's copied to the appropriate location in a task (usually a **Run Command Line** task) between the **Apply Operating System** and **Setup Windows and ConfigMgr** tasks. Below is an example of the command line in a **Run Command Line** task:

  `cmd.exe /c copy SetupComplete.cmd %OSDTargetSystemDrive%\Windows\Setup\Scripts`

- It's included as part of a custom OS WIM file.

The SetupComplete.cmd file is located in the `%WINDIR%\Setup\Scripts` folder, in either the offline OS or the OS WIM image.

For more information about the SetupComplete.cmd file, see [Add a Custom Script to Windows Setup](/windows-hardware/manufacture/desktop/add-a-custom-script-to-windows-setup).

## Resolution

To fix this issue, remove the custom SetupComplete.cmd file. In most cases, any actions being taken in the custom SetupComplete.cmd file can instead be moved as tasks in the task sequence.

Depending on how the custom SetupComplete.cmd file is specified, use one of the following methods to remove the file:

- If it's specified in a **Run Command Line** task between the **Apply Operating System** and **Setup Windows and ConfigMgr** tasks, remove the **Run Command Line** task from the task sequence.
- If it's part of a custom OS image, add a **Run Command Line** task between the **Apply Operating System** and **Setup Windows and ConfigMgr** tasks. In the command line of the **Run Command Line** task, enter the following command to delete the custom SetupComplete.cmd file:

  `cmd.exe /c del SetupComplete.cmd %OSDTargetSystemDrive%\Windows\Setup\Scripts /F /Q`
