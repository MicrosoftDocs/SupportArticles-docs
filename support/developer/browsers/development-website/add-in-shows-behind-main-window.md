---
title: Add-in window appears behind the main window
description: Fixes an issue in which an add-in for Internet Explorer displays its window behind the main window.
ms.date: 04/26/2020
ms.reviewer: bachoang, joelba
---
# Add-in window appears behind the main window in Internet Explorer

[!INCLUDE [](../../../includes/browsers-important.md)]

This article provides the information to solve the issue that an add-in window appears behind the main window in Internet Explorer 9 and later versions.

_Original product version:_ &nbsp; Internet Explorer 11, Internet Explorer 10, Internet Explorer 9  
_Original KB number:_ &nbsp; 3109244

## Symptoms

In Internet Explorer 9 and later versions, when an add-in creates a window, the window might be positioned behind the main browser window. This issue occurs when you navigate to a webpage from the address bar.

## Cause

An architectural change in the address bar was introduced in Internet Explorer 9. The change establishes focus and foreground presence when web content loads completely.

## More information

Windows that are provided by an Internet Explorer add-in can share the same message input queue as the primary Internet Explorer window. In such scenarios, any component can use the [SetWindowsPos](/windows/win32/api/winuser/nf-winuser-setwindowpos) API to change the z-index order and request that its window is brought to the foreground.

To make sure that an add-in window is always positioned in front of the primary Internet Explorer window, the add-in window must designate its owner as the IEFrame window.

For more information about programmatic window management, see [Window Features](/windows/win32/winmsg/window-features).
