---
title: Power management setting on a network adapter
description: This article talks about the power management setting on a network adapter. Provides resolutions to disable the network adapter power management on a single computer.
ms.date: 12/26/2023
manager: dcscontentpm
audience: ITPro
ms.topic: troubleshooting
localization_priority: medium
ms.reviewer: kaushika, scottmca, partset, pachary
ms.custom: sap:Network Connectivity and File Sharing\TCP/IP Connectivity (TCP Protocol, NLA, WinHTTP), csstroubleshoot
---
# Information about power management setting on a network adapter

This article provides a resolution to disable network adapter power management on a single computer.

_Applies to:_ &nbsp; Windows 7 Service Pack 1, Windows Server 2008 R2 Service Pack 1  
_Original KB number:_ &nbsp; 2740020

## Summary

The enhancements made to Windows 7 for managing power settings for network adapters greatly reduces the number of spurious wakes. It allows computers to sleep for longer periods of time when idle. Furthermore, you can configure the power management settings to meet the needs of your users through device properties, standard registry settings.

When deploying Windows 7 or Windows Server 2008 R2, you may want to disable the following network adapter power management setting on some computers:

**Allow the computer to turn off this device to save power**

> [!IMPORTANT]
> This article does not apply to NetAdapterCx drivers. For more information about NetAdapterCx drivers, see [User Control of Device Idle and Wake Behavior](/windows-hardware/drivers/wdf/user-control-of-device-idle-and-wake-behavior).

## More information

The **Allow the computer to turn off this device to save power** setting controls how the network card is handled when the computer enters sleep. This setting can be used if a driver misrepresents how it handles sleep states.

Windows never turns off the network card due to inactivity. When this setting is checked(enabled), Windows puts the network card to sleep and when it resumes it puts it back to D0. When this setting isn't checked(disabled), Windows completely halts the device and on resume reinitializes it. This setting is useful if a network card driver says it supports going to different sleep states and back to D0 but it ultimately doesn't support this functionality.

You can use Device Manager to change the power management settings for a network adapter. To disable this setting in **Device Manager**, expand **Network Adapters**, right-click the adapter, select **Properties**, select the **Power Management** tab, and then clear the **Allow the computer to turn off this device to save power** check box.

In Windows 7 or Windows Server 2008 R2, you have two additional check boxes on the **Power Management** tab for the Network Adapter that defines whether this device can wake the computer:

- Allow this device to wake the computer
- Only allow a magic packet to wake the computer

> [!NOTE]
> For above mentioned settings to work, you may also have to enable BIOS settings to enable WOL. The specific BIOS settings depend on the manufacturer of the computer.

However, with some Windows 7 or Windows Server 2008 R2 installations, you may want to use the registry to disable the **Allow the computer to turn off this device to save power** network adapter power management setting. Or you may want to use the registry to configure the wake options described above.

## How to use Registry Editor to disable network adapter power management on a single computer

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To disable the network adapter power management setting for a single computer, follow these steps:

1. Select **Start**, select **Run**, type *regedit* in the **Open** box, and then select **OK**.
2. Locate and then select the following registry subkey:  
   `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002bE10318}\DeviceNumber`

    > [!NOTE]
    > **DeviceNumber** is the network adapter number. If a single network adapter is installed on the computer, the **DeviceNumber** is **0001**.

3. Select **PnPCapabilities**.
4. On the **Edit** menu, select **Modify**.
5. In the **Value data** box, type *24*, and then select **OK**.

    > [!NOTE]
    > By default, a value of **0** indicates that power management of the network adapter is enabled. A value of **24** will prevent Windows 7 from turning off the network adapter or let the network adapter wake the computer from standby.

6. On the **File** menu, select **Exit**.

## Additional information

You have three options for the power management properties of the Network Card:

- Option 1: Allow the computer to turn off this device to save power
- Option 2: Allow this device to wake the computer
- Option 3: Only allow a magic packet to wake the computer

The different possible combinations that exist along with their DWORD values (in decimal and hex) are:

- Option 1 and option 2 are checked, Option 3 is unchecked: This combination is default and hence its value is **0**.
- Option 1, option 2, and option 3 are all checked: The value becomes **0x100 (256)**.
- Only option 1 is checked: The value becomes **0x110 (272)**.
- Option 1 is unchecked (Note that option 2 and option 3 will be greyed out as a result): The value becomes **0x118 (280)**.

A conflict happens for the DWORD value for the last step where Option 1 is only checked, if the following steps are done exactly as mentioned below:

- If you check all the boxes, then the value is **256 (0x100)**.
- If you uncheck the box 1, the other two will be greyed out, and the value becomes **280 (0x118)**.
- If you check all the boxes except, the third one, PNPCapabilities value becomes **0**.
- If step 2 is repeated, the value becomes **24 (0x18)**.

Now, the values are different for the same setting because the way it has been achieved.

For deployment purpose, to keep option 1 cleared, one needs to use the value **24 (0x18)**. By default, option 1 and 2 are checked. It's the same as DWORD value **0** of this key, even though the key doesn't exist in the registry by default. Hence, creating this key with a value **24 (0x18)** in the deployment script/build process will inject this entry in the registry, which in turn should uncheck the first box during server startup.

In the same way, if you want to keep option 1 checked while option 2 and 3 cleared, the required value would be **10 (0x16)**.

> [!NOTE]
> This is entirely by design.
