---
title: 32-bit browser applications not working as expected
description: Describes an issue in which some Internet Explorer 10 or 11 applications do not work as expected when the TabProcGrowth registry entry is set to 0 in 64-bit versions of Windows 8. Provides a workaround.
ms.date: 10/13/2020
ms.reviewer: ramakoni
---
# 32-bit browser applications may not work as expected in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides a workaround to solve the issue that some 32-bit browser applications not working as expected in Internet Explorer.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Windows 8, Windows 8 Enterprise  
_Original KB number:_ &nbsp; 2716529

## Symptoms  

When you run Internet Explorer 10 or Internet Explorer 11 in the desktop on a 64-bit version of Windows, add-ons that are written for the 32-bit browser (for example, Browser Helper Objects (BHOs), Toolbars, and ActiveX controls) do not work as expected.

This issue occurs when the following registry entry is set to **0**:

`HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\TabProcGrowth`

## Cause

The Internet Explorer Manager process is always a 64-bit process in 64-bit versions of Windows 8 or later operating systems. This is an architecture change in Internet Explorer 10. By default, tab processes can be either 32-bit or 64-bit processes, except when the `TabProcGrowth` registry entry is set to **0**. When this registry entry is set to **0**, the tabs run in the same process as the manager process, which in this case is 64-bit. However, some browser add-ons do not have a 64-bit version. Therefore, they do not work as expected.

## Workaround

> [!IMPORTANT]
> This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see [How to back up and restore the registry in Windows](https://support.microsoft.com/help/322756).

To work around this issue, change the value of the `TabProcGrowth` registry entry to an integer number that is greater than **0**. To do this, follow these steps:

1. Swipe in from the right edge of the screen, and then tap **Search**. Or, if you are using a mouse, point to the lower-right corner of the screen, and then select **Search**.

2. In the search box, type *regedit*.

3. Tap or select the displayed Regedit icon. Locate and then select the following registry entry:

   `HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\TabProcGrowth`

4. Change the value of the registry entry.

> [!NOTE]
> If you do not want to change the registry setting, you may have to run add-ons that are written for 64-bit browsers. Contact the software vendor to check whether a 64-bit version of the add-on is available.
