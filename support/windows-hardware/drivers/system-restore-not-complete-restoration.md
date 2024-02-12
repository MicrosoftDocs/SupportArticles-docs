---
title: System Restore is unable to complete Restoration
description: This article provides resolutions for the problem where System Restore is unable to complete restoration and terminates.
ms.date: 09/01/2020
ms.reviewer: twarwick
ms.subservice: general
---
# System Restore is unable to complete Restoration

This article helps you resolve the problem where System Restore is unable to complete restoration and terminates.

_Original product version:_ &nbsp; File Based Write Filter  
_Original KB number:_ &nbsp; 2390760

## Symptoms

System Restore is unable to complete restoration and terminates with the following error:

> This restoration is incomplete. It was interrupted by an improper shutdown. You should undo this restore or choose another restore point.

## Cause

The System Restore and the combination of File Based Write Filter (FBWF) with Registry Filter cannot be used at the same time. System Restore is unable to restore to an earlier point in time correctly with Registry Filter enabled.

## Resolution

FBWF and Registry Filter must be disabled for system restore to work properly:

1. FBWF and Registry Filter should be disabled anytime System Restore is used to create a restore point or restore the system to an earlier point in time.

2. System Restore should be disabled when FBWF and Registry Filter are in use.

Using Registry Editor (Go to **start**, **Run**, type *Regedit.exe*, press **enter**) create the following regnodes if not present, or if present set the values as outlined below to disable FBWF & Registry Filter in order to create a restore point or restore the system to an earlier point in time.

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RegFilter] "Start"=dword:00000004`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FBWF] "Start"=dword:00000004`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\srservice] "Start"=dword:00000002`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sr] "Start"=dword:00000000`

Conversely set the following Registry Keys as appropriate to enable FBWF and Registry filter and disable System Restore:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RegFilter] "Start"=dword:00000001`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FBWF] "Start"=dword:00000000`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\srservice] "Start"=dword:00000004`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\sr] "Start"=dword:00000004`

> [!IMPORTANT]
> This step directs you to modify the registry. However, serious problems might occur if you modify the registry incorrectly. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756/how-to-back-up-and-restore-the-registry-in-windows).

Adding these registry keys can be done several ways. You can use RegEdit, as shown in the example below. Alternatively you can also use Registry Entries (*.reg*) files to remotely distribute registry changes to several Windows-based computers. When you run a *.reg* file, the file contents merge into the local registry. Therefore, you must distribute *.reg* files with caution. The following article provides advanced information on the Registry with several editing methods described, including Regedit and *.reg* files:

[Windows registry information for advanced users](https://support.microsoft.com/help/256986/windows-registry-information-for-advanced-users)

Example using Regedit:

1. Click on the **Start** menu, Select **Run...**
2. Type: *Regedit*
3. Press the **Enter** key or click **OK**.
4. Add the following keys to the Software section of the Registry:

    `[HKEY_LOCAL_MACHINE\software\Microsoft\Windows Embedded POSReady] "Version"=(REG_SZ)"2.0"`

## More information

Registry Filter provides functionality required to persist specific registry values when connected to a Network Domain and FBWF is enabled and protecting the system volume. FBWF correctly disables the System Restore service and it is in fact disabled in POSReady by default. Running Sysprep on the POSReady runtime or invoking System Restore manually can enable the System Restore service.
