---
title: Setup fails when rollback is disabled
description: An error appears when you install or remove the .NET Framework. This article provides a resolution.
ms.date: 05/06/2020
ms.custom: sap:Installation
ms.reviewer: CWOJA
---
# Error when you install or remove .NET Framework: You must enable rollback to continue with setup

This article helps you fix an error (You must enable rollback to continue with setup) when you install or remove the Microsoft .NET Framework.

_Original product version:_ &nbsp; .NET Framework  
_Original KB number:_ &nbsp; 312499

## Symptoms

When you install or remove the .NET Framework, you might receive the following error message:

> You must enable rollback to continue with setup.

## Cause

This error occurs because the rollback feature of the Microsoft Windows Installer is disabled. The .NET Framework Setup program requires commit custom actions for proper installation. Rollback and commit custom actions don't run when rollback is disabled.

Rollback is disabled in the `DisableRollback` policy in the registry. The `DisableRollback` policy value may have been set by an administrator. Microsoft recommends that administrators don't disable rollback unless it's necessary.

## Resolution

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. So make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information, visit [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

There are two places in the registry where the `DisableRollback` policy value can be set. To resolve this problem, you must find out where the `DisableRollback` policy was set and remove or disable the setting.

To find out whether this property exists in your registry, run `C:\Regedit.exe` and check the following locations:

- `HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\Installer\DisableRollback`

- `HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Installer\DisableRollback`

If the `DisableRollback` key exists and has a value of 1, delete the key or set the value of the key to 0. (You can also set `DisableRollback` through command-line instructions.) Microsoft recommends that administrators and developers not set this property if they use command-line instructions to run Setup, or Setup won't work.

## Status

This behavior is by design.

## More information

For more information about the `DisableRollback` policy value, visit [Machine Policies](/windows/win32/msi/machine-policies)
