---
title: Enable Tablet press-and-hold gesture in MFC
description: Tablet Windows will send WM_TABLET_QUERYSYSTEMGESTURESTATUS message to inquire about gestures desired. By default, MFC will disable the press-and-hold gesture. There is an easy way to enable that.
ms.date: 04/22/2020
ms.prod-support-area-path: Microsoft Foundation Classes (MFC)
ms.reviewer: scotbren
ms.topic: how-to
---
# Enable Tablet press-and-hold gesture in MFC applications

This article provides information about how to enable press-and-hold gesture in a Microsoft Foundation Class (MFC) application.

_Original product version:_ &nbsp; Visual Studio 2010 and later versions  
_Original KB number:_ &nbsp; 2846829

## Summary

On a Tablet PC running Windows, the system will send a
[WM_TABLET_QUERYSYSTEMGESTURESTATUS](/windows/win32/tablet/wm-tablet-querysystemgesturestatus-message) message to active windows that could receive user input. In an MFC application, all windows are typically derived from the `CWnd` class, and this base class handles this message in its `OnTabletQuerySystemGestureStatus` method. This method calls the virtual function `CWnd::GetGestureStatus`, which will then return `TABLET_DISABLE_PRESSANDHOLD`, for performance reasons. If your application wants to enable the press-and-hold gesture, you must override this method in your derived window class and return something that doesn't include the `TABLET_DISABLE_PRESSANDHOLD` flag.

## Default behavior: Disable press and hold gesture

To enable the right-click concept that usually means *display the context menu*, and comes in the form of `WM_RBUTTONDOWN`, `WM_RBUTTONUP`, and `WM_CONTEXTMENU` messages and `ISG_HOLDENTER` and `ISG_RIGHTTAP` events, the press and hold gesture must be enabled for that window. In order to detect this gesture, by necessity some delay is introduced to distinguish between a simple press (treated as a left-click) and a press and hold (right-click). Thus, it will take longer for left click events to be raised, and the application will seem less responsive. So, for this reason, the default behavior is to disable the press and hold gesture.

## Enable Tablet press-and-hold gesture

If your MFC application needs this gesture to implement right-click handling, you must override the virtual `GetGestureStatus` function for any derived window classes that need to implement a right-click handler. Let's assume that it is a view class named *CMyView* defined in *MyView.h*, and implemented in *MyView.cpp*. In *MyView.h*, add the following:

```cpp
virtual ULONG GetGestureStatus(CPoint ptTouch);
```

In *MyView.cpp*, add the following:

```cpp
ULONG CMyView::GetGestureStatus(CPoint /*ptTouch*/)
{
    return 0;
}
```

The return value `0` could be replaced by a combination of other flags as described in the [WM_TABLET_QUERYSYSTEMGESTURESTATUS](/windows/win32/tablet/wm-tablet-querysystemgesturestatus-message) documentation, but if you wish to enable press and hold, don't include the `TABLET_DISABLE_PRESSANDHOLD` flag.
