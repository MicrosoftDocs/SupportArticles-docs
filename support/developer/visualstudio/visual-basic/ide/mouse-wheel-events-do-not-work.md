---
title: Mouse wheel events don't work in Visual Basic 6.0 IDE
description: This article provides workarounds for the problem where you cannot use the mouse wheel to scroll in Visual Basic 6.0 IDE.
ms.date: 12/10/2020
ms.custom: sap:Visual Basic
---
# Mouse wheel events do not work in the Visual Basic 6.0 IDE

This article helps you work around the problem where you cannot use the mouse wheel to scroll in Visual Basic 6.0 IDE.

_Original product version:_ &nbsp; Visual Basic  
_Original KB number:_ &nbsp; 837910

## Symptoms

You cannot scroll by using the mouse wheel in the Microsoft Visual Basic 6.0 IDE.

## Cause

This problem occurs because the Visual Basic 6.0 IDE does not have built-in support for scrolling by using the mouse wheel.

## Workaround

To work around this problem, use one of the following methods:

## Method 1

Download the VB6 Mouse Wheel.exe file that includes the add-in DLL and the code that is used to create the add-in DLL.

1. Download the VB6 Mouse Wheel.exe file.
2. Click **Start**, click **Run**, type `regsvr32 <path>\VB6IDEMouseWheelAddin.dll`, and then click **OK**.
3. Start Visual Basic 6.0.
4. Click **Add-Ins**, and then click **Add-in Manager**.
5. In the **Add-in Manager** list, click **MouseWheel Fix**.
6. Click to select the **Loaded/Unloaded** check box, and then click to select the **Load on Startup** check box.
7. Click **OK**.

You can also build the add-in DLL in Visual Basic 6.0. If you do this, the add-in DLL is automatically registered. You can then follow steps 4 through 7 to enable the add-in DLL. To build the add-in DLL, click **Make VB6IDEMouseWheelAddin.dll** on the **File** menu.

> [!NOTE]
> You can also use this add-in in most VBA environments. Install the add-in as described earlier, create a .reg file with the following values, and merge it with your registry.

Windows Registry Editor Version 5.00

`HKEY_CURRENT_USER\Software\Microsoft\VBA\VBE\6.0\Addins\VB6IDEMouseWheelAddin.Connect`

- "FriendlyName"="MouseWheel Fix"
- "CommandLineSafe"=dword:00000000
- "LoadBehavior"=dword:00000000

> [!NOTE]
> These keys may be ignored if you put them under `HKEY_LOCAL_MACHINE`.

## Method 2

Return to an earlier version of Microsoft IntelliPoint software. To do this, follow these steps:

1. If the IntelliPoint software that is installed on your computer is version 4.9 or a later version, remove the IntelliPoint software from your computer.
2. Install IntelliPoint software version 4.12.

## More information

Mouse wheel support in Visual Basic 6.0 is a function of the mouse driver. The `WM_MOUSEWHEEL` message is sent to the Focus window when you rotate the mouse wheel. Because the Visual Basic 6.0 IDE does not have built-in support for scrolling by using the mouse wheel, the IDE ignores the `WM_MOUSEWHEEL` message. However, IntelliPoint software version 4.12 provides mouse wheel support and converts the `WM_MOUSEWHEEL` message to `WM_SCROLL`. IntelliPoint software version 4.9 and later versions do not have this feature. Therefore, if you want to use the mouse wheel to scroll in the Visual Basic 6.0 IDE, you must use IntelliPoint software version 4.12.

## References

For additional information about `WM_MOUSEWHEEL` notification, see [WM_MOUSEWHEEL message](/windows/win32/inputdev/wm-mousewheel).

[!INCLUDE [Virus scan claim](../../../../includes/virus-scan-claim.md)]
