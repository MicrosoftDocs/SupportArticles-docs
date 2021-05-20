---
title: Mouse wheel events don't work in Visual Basic 6.0 IDE
description: This article provides workarounds for the problem where you cannot use the mouse wheel to scroll in Visual Basic 6.0 IDE.
ms.date: 12/10/2020
ms.prod-support-area-path: Visual Basic
ms.prod: visual-basic-6
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

To work around this problem, return to an earlier version of Microsoft IntelliPoint software. To do this, follow these steps:

1. If the IntelliPoint software that is installed on your computer is version 4.9 or a later version, remove the IntelliPoint software from your computer.
2. Install IntelliPoint software version 4.12.

    For more information about how to download Microsoft support files, see [How to obtain Microsoft support files from online services](https://support.microsoft.com/help/119591).
  
## More information

Mouse wheel support in Visual Basic 6.0 is a function of the mouse driver. The `WM_MOUSEWHEEL` message is sent to the Focus window when you rotate the mouse wheel. Because the Visual Basic 6.0 IDE does not have built-in support for scrolling by using the mouse wheel, the IDE ignores the `WM_MOUSEWHEEL` message. However, IntelliPoint software version 4.12 provides mouse wheel support and converts the `WM_MOUSEWHEEL` message to `WM_SCROLL`. IntelliPoint software version 4.9 and later versions do not have this feature. Therefore, if you want to use the mouse wheel to scroll in the Visual Basic 6.0 IDE, you must use IntelliPoint software version 4.12.

## References

For additional information about `WM_MOUSEWHEEL` notification, see [WM_MOUSEWHEEL message](/windows/win32/inputdev/wm-mousewheel).

[!INCLUDE [Virus scan claim](../../includes/virus-scan-claim.md)]
