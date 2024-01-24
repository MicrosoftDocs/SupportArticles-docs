---
title: Disabling File Based Write Filter causes a crash
description: This article provides resolutions for the problem that occurs when you disable File Based Write Filter.
ms.date: 09/02/2020
ms.subservice: general
---
# Disabling File Based Write Filter causes a crash

This article helps you resolve the problem that occurs when you disable File Based Write Filter (FBWF).

_Original product version:_ &nbsp; File Based Write Filter  
_Original KB number:_ &nbsp; 2390775

## Symptoms

Disabling FBWF produces a crash. When this situation occurs, FBWF cannot be disabled.

## Cause

FBWFMBR /disable produces a crash if executed after SYSPREP has been performed.

## Resolution

Disable System Restore before enabling FBWF, post SYSPREP. Use the following steps to disable System Restore:

1. Click **Start**, right-click **My Computer**, and then click **Properties**.
2. In the **System Properties** dialog box, click the **System Restore** tab.
3. Click to select the **Turn off System Restore** check box. Or, click to select the **Turn off System Restore** on all drives check box.
4. Click **OK**.
5. Click **Yes** when you receive the following message, to confirm that you want to turn off System Restore:

    > You have chosen to turn off System Restore. If you continue, all existing restore points will be deleted, and you will not be able to track or undo changes to your computer.

Do you want to turn off System Restore?

After a few moments, the **System Properties** dialog box closes.

## More information

You can also use Registry Editor to disable System Restore. To use this alternative, perform the following steps:

1. Start the registry editor (regedit.exe).

1. Go to `[HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\sr]`.

1. If a **DisableSR** value doesn't exist, go to the **Edit** menu, select **New**, **DWORD** value, and create the value. Set the value to **4** to disable System Restore or **0** to enable System Restore.

1. Go to `[HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\srservice]`

1. Double-click **Start**, and set the value to **4** to stop the service from starting or to **0** for normal startup.

1. Close the Registry Editor.
