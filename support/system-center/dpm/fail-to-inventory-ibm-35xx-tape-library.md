---
title: DPM fails to inventory IBM 35XX Tape Library
description: Works around an issue that occurs when you perform a fast inventory with Data Protection Manager.
ms.date: 12/05/2022
ms.reviewer: jarrettr, scdpmcsscontent, v-weizhu
---
# Fast inventory fails when you use IBM 35XX Series mainframe with Data Protection Manager

This article provides a workaround for an issue where Data Protection Manager (DPM) fails to inventory the IBM 35XX Tape Library.

_Original product version:_ &nbsp; System Center Data Protection Manager  
_Original KB number:_ &nbsp; 978901

## Symptoms

When you try to perform a fast inventory with the Microsoft System Center Data Protection Manager (DPM), you receive the following error message:

> Type: Fast inventory
>
> Status: Failed
>
> Description: DPM failed to inventory the Tape Library IBM 35**XX** Tape Library. This is possibly due to a hardware issue. (ID 25011 Details: Internal error code: 0x80990C1B)
>
> End time: **MM/DD/YYYYh:mm:ssAM_PM**  
> Start time: **MM/DD/YYYYh:mm:ssAM_PM**  
> Library: IBM 35**XX** Tape Library

## Cause

This issue occurs when you have tape cleaner media in an IBM 35XX series library, and you use DPM to try to run a fast inventory. When there is tape cleaner media in a slot or drive, and you try to run the fast inventory, this slot or drive returns an unhandled error message. In this scenario, the fast inventory fails.

> [!NOTE]
>
> - A DPM fast inventory will work as expected when auto cleaning is enabled, and the tape cleaner media is loaded only in special cleaning slots. If the cleaner media is present in a regular slot, the status of the slot is reported as an exception. If the cleaner media is in drive, the status of the drive is also reported as an exception.
> - Similar errors may occur when you try to clean a tape drive by using the DPM GUI, and there is cleaning tape media in the library.

## Workaround

[!INCLUDE [Registry important alert](../../includes/registry-important-alert.md)]

To work around this issue, on the DPM server that contains the tape library, you can add `RSMCompatMode` as a DWORD value to the following registry subkey:

`HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Agent`

The `RSMCompatMode` registry value is used to specify multiple flags for DPM. The following are the flags that are set by this registry value:

- 1 = RSM_COMPAT_INIT_ELEMENT_STATUS

- 4 = RSM_COMPAT_IGNORE_TAPE_INVENTORY_RESULT

- 8 = RSM_COMPAT_CLEANER_EXCEPTION

To add this registry value, follow these steps:

1. Stop the DPM Library Agent (DPMLA) service. To do this, follow these steps:

    1. Select **Start** > **All Programs** > **Accessories**, and then right-click **Command Prompt**.

    2. Select **Run as administrator**.

        If you are prompted for an administrator password or for confirmation, type the password, or provide confirmation.

    3. At the command prompt, type `net stop dpmla`, and then select <kbd>ENTER</kbd>.

2. Select **Start** > **Run**, type `regedit`, and then select **OK**.

3. Locate and then select the following key in the registry:

    `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Microsoft Data Protection Manager\Agent`

4. On the **Edit** menu, point to **New**, and then select the **DWORD Value**.

5. Type `RSMCompatMode`, and then select <kbd>ENTER</kbd>.

6. On the **Edit** menu, select **Modify**.

7. Type *8* or *13* (decimal), and then select **OK**.

8. Exit Registry Editor.

9. Start the DPMLA service. To do this, follow these steps:

    1. Select **Start** > **All Programs** > **Accessories**, and then right-click **Command Prompt**.

    2. Select **Run as administrator**.

        If you are prompted for an administrator password or for confirmation, type the password, or provide confirmation.

    3. At the command prompt, type `net start dpmla`, and then <kbd>ENTER</kbd>.
