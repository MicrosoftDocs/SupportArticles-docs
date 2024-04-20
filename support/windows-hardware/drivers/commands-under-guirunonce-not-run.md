---
title: commands under GuiRunOnce doesn't run
description: This article provides resolutions for the problem where the commands listed under the GuiRunOnce field in a sysprep.inf file may not run on first boot after sysprep is performed.
ms.date: 09/02/2020
ms.reviewer: twarwick, jtanner
ms.subservice: general
---
# GuiRunOnce in sysprep.inf not working in Windows POSReady

This article helps you resolve the problem where the commands listed under the **GuiRunOnce** field in a *sysprep.inf* file may not run on first boot after `sysprep` is performed.

_Original product version:_ &nbsp; File Based Write Filter, Windows Embedded POSReady  
_Original KB number:_ &nbsp; 2390828

## Symptoms

On a device running Windows Embedded POSReady with File Based Write Filter (FBWF) and Registry Filter enabled, the commands listed under the **GuiRunOnce** field in a *sysprep.inf* file may not run on first boot after `sysprep` is performed.

This may be due to the missing registry key: `HKCU\Software\Microsoft\Windows\CurrentVersion\RunOnce`.

## Cause

The Registry key may be missing because it's not getting written to the Registry database. When the Registry Filter Driver service is enabled, it can prevent a Registry key from being written to the Registry database. The Registry Filter Driver is used to protect the registry database of an Embedded device. It prevents a user from making changes to the registry of a device. Registry Filter Driver service supplements the FBWF service and both should be turned off to allow the Registry key to be written to the Registry database. Unfortunately, both Registry Filter Driver service and FBWF service are not visible in the "Services" MMC snap-in. To control their settings, related Registry settings may need to be modified.

## Resolution

The following Registry key changes may be required prior to running Sysprep file, to enable `GUIRunOncen` commands to work in *Sysprep.ini* file. The Registry change disables Registry Filter Driver service and the FBWF service. Start the Registry Editor (Go to **start**, **Run**, type *Regedit.exe*, press **enter**) and create the following regnodes if not present, or if present set the values as outlined below.

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RegFilter] "Start"=dword:00000004`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FBWF] "Start"=dword:00000004`

Now, `Sysprep` can be run.

Registry Filter Driver service and the FBWF service can be enabled by making the following Registry changes:

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\RegFilter] "Start"=dword:00000001`

`[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\FBWF] "Start"=dword:00000000`

> [!IMPORTANT]
> This step directs you to modify the registry. However, serious problems might occur if you modify the registry incorrectly. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

Adding these registry keys can be done several ways. You can use RegEdit, as shown in the example below. Alternatively you can also use Registry Entries (*.reg*) files to remotely distribute registry changes to several Windows-based computers. When you run a *.reg* file, the file contents merge into the local registry. Therefore, you must distribute *.reg* files with caution. The following article provides advanced information on the Registry with several editing methods described, including Regedit and *.reg* files:

[Windows registry information for advanced users](https://support.microsoft.com/help/256986)

Example using Regedit:

1. Click on the **Start** menu, Select **Run...**
2. Type: *Regedit*
3. Press the **Enter** key or click **OK**
4. Add the following keys to the Software section of the Registry:

    `[HKEY_LOCAL_MACHINE\software\Microsoft\Windows Embedded POSReady] "Version"=(REG_SZ)"2.0"`

## More information

Registry Filter Driver service is a service complimentary to an FBWF service and both should be turned off for a Sysprep scenario. Registry Filter Driver service and FBWF service are not visible from "Services" MMC snap-in. This requires to control service start type through Registry manipulation (either directly or through REG files).
