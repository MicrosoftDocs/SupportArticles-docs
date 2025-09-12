---
title: Change the mouse pointer for a window in MFC
description: Explains that the window class identifies several characteristics of the windows that are based on the window class including the default mouse pointer. Describes three methods for changing the mouse pointer for a window in MFC by using Visual C++.
ms.date: 04/22/2020
ms.custom: sap:C and C++ Libraries\Microsoft Foundation Classes (MFC)
ms.reviewer: anurags
ms.topic: how-to
---
# Change the mouse pointer for a window in MFC by using Visual C++

This article introduces how to change the mouse pointer for a window in MFC by using Visual C++. The information in this article applies only to unmanaged Visual C++ code.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 131991

## Summary

In a Windows-based application, a window is always created based on a window class. The window class identifies several characteristics of the windows based on it, including the default mouse pointer (cursor). In some cases, an application may want to change the pointer associated with certain windows that it creates. This article describes three methods an MFC application can use to display different pointers at different times.

## Situations where MFC applications display different pointers

Here are some situations when you might want an MFC application to display different pointers at different times:

- When the default pointer isn't a good user-interface object for a particular application. For example, an I-beam pointer is more suitable than the arrow for a text editor window in NotePad. This could involve changing the pointer for the entire run of the application.
- When an application performs a lengthy operation, such as disk I/O, an hourglass pointer is more appropriate than the arrow. By changing the pointer to an hourglass, you provide good visual feedback to the user. This could involve changing the pointer for a limited period of time.

## Three methods to change mouse pointer in a window

Here are three ways an application can change the mouse pointer in a window:

- [Method 1](#code-for-the-method-1): override the `CWnd::OnSetCursor()` function. Call Windows API `SetCursor()` function to change the pointer.
- [Method 2](#code-for-the-method-2): register your own window class with the desired mouse pointer, override the `CWnd::PreCreateWindow()` function, and use the newly registered window class to create the window.
- [Method 3](#code-for-the-method-3): to show the standard hourglass pointer, an application can call the `CCmdTarget::BeginWaitCursor()`, which displays the hourglass, and call `CmdTarget::EndWaitCursor()` to revert back to the default pointer. This scheme works only for the duration of a single message. If the mouse is moved before a call to `EndWaitCursor` is made, Windows sends a `WM_SETCURSOR` message to the window underneath the pointer. The default handling of this message resets the pointer to the default type, the one registered with the class, so you need to override `CWnd::OnSetCursor()` for that window, and reset the pointer back to the hourglass.

The following code samples show by example how to change the mouse pointer of a `CView` derived class window by using the three methods.

`m_ChangeCursor` is a member variable of `CMyView` class and is of type `BOOL`. It indicates whether a different pointer type needs to be displayed.

## Code for the method 1

Change the mouse pointer for the `CMyView` object by overriding `CWnd::OnSetCursor()` function. Use the Class Wizard to establish the message map function `CMyView::OnSetCursor()` for Windows message `WM_SETCURSOR` and supply the body of the function as follows:

```cpp
BOOL CMyView::OnSetCursor(CWnd *pWnd, UINT nHitTest, UINT message)
{
    if (m_ChangeCursor)
    {
        ::SetCursor(AfxGetApp()->LoadStandardCursor(IDC_WAIT));
        return TRUE;
    }
    return CView::OnSetCursor(pWnd, nHitTest, message);
}
```

## Code for the method 2

Register your own window class containing the desired mouse pointer by using either the `AfxRegisterClass()` or `AfxRegisterWndClass()` function. Then create the view window based on the registered window class. For more information on registering window classes in MFC, see **Window Class Registration** in MFC Tech Note 1.

```cpp
BOOL CMyView::PreCreateWindow(CREATESTRUCT &cs)
{
    cs.lpszClass = AfxRegisterWndClass(
        CS_DBLCLKS | CS_HREDRAW | CS_VREDRAW, // use any window styles
        AfxGetApp()->LoadStandardCursor(IDC_WAIT),
        (HBRUSH)(COLOR_WINDOW + 1)); // background brush
    return CView::PreCreateWindow(cs)
}
```

## Code for the method 3

Call the `BeginWaitCursor()` and `EndWaitCursor()` functions to change the mouse pointer.

> [!NOTE]
> `CWinApp::DoWaitCursor(1)` and `CWinApp::DoWaitCursor(-1)` work similarly to `BeginWaitCursor()` and `EndWaitCursor()`, respectively.

```cpp
void CMyView::PerformLengthyOperation()
{
    BeginWaitCursor(); // or AfxGetApp()->DoWaitCursor(1)
    //...
    EndWaitCursor(); // or AfxGetApp()->DoWaitCursor(-1)
}
```

If calls to `BeginWaitCursor()` and `EndWaitCursor()` are not in the same handler, you must override `OnSetCursor` as follows:

```cpp
BOOL CMyView::OnSetCursor(CWnd *pWnd, UINT nHitTest, UINT message)
{
    if (m_ChangeCursor)
    {
        RestoreWaitCursor();
        return TRUE;
    }
    return CView::OnSetCursor(pWnd, nHitTest, message);
}
```

In this example, set `m_ChangeCursor` to **TRUE** just before the call to `BeginWaitCursor()`, and set it back to **FALSE** after the call to `EndWaitCursor()`.
