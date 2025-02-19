---
title: MFC application can't redraw controls
description: MFC Windows application fails to redraw the control when it is resized if the control is multiply nested.
ms.date: 04/22/2020
ms.custom: sap:Language or Compilers\C++
ms.reviewer: gaurap, hihayak, juesaigo
---
# MFC Windows application may fail to redraw the control when it is resized if the control is multiply nested

This article helps you resolve the problem where MFC Windows application can't redraw the resized control if the windows have a deep nested hierarchy.

_Original product version:_ &nbsp; Visual C++  
_Original KB number:_ &nbsp; 2724997

## Symptoms

An MFC application having a deep nested hierarchy of windows, fails to receive `WM_SIZE` for nested child windows. As a result, controls won't get resized once the nesting hierarchy of windows exceeds a certain depth on x64.

## Cause

The root cause of the issue is a design architecture of the application that has a deeply nested windows hierarchy causing the application to hit a design limitation of the kernel stack space. In user mode, if deep recursive calls to a function are made, we end up with a stack overflow exception. The same thing happens in kernel mode. However, kernel has to be smart and handle the exception and somehow avoid a blue screen while still allowing the application to run.

Consider an MFC application having a deep nested windows hierarchy. Now consider, someone trying to resize the window and so its child windows has to be resized too. Now, function like `SetWindowPos` API would be used to resize the windows. `WM_SIZE` is sent to the message queue and the window procedure associated with the window will be called. In MFC, overloads like `CWnd::OnSize()` will be called. Now, since the windows are nested, this has to be done recursively for all the child windows.

In below example, we see `CMyView` has a child window with wrapper `CMyChildView1`.

```cpp
// Resize the Child View 1
void CMyView::OnSize(UINT nType, int cx, int cy)
{
    CView::OnSize(nType, cx, cy);
    m_ChildView1.MoveWindow(0, 0, cx, cy);
}
// Resize the Child View 2
void CMyChildView1::OnSize(UINT nType, int cx, int cy)
{
    CView::OnSize(nType, cx, cy);
    // Resize list to fill the whole view.
    m_ChildView2.MoveWindow(0, 0, cx, cy);
}
// Resize the Child View 3
void CMyChildView2::OnSize(UINT nType, int cx, int cy)
{
    CView::OnSize(nType, cx, cy);
    // Resize list to fill the whole view.
    m_ChildView3.MoveWindow(0, 0, cx, cy);
}
```

You would see, a callstack similar to below logical snapshot of callstack.

```console
...[Snip]
CMyChildView3::OnSize()
USER32!UserCallWinProcCheckWow
USER32!DispatchClientMessage
USER32!__fnINLPWINDOWPOS
ntdll!KiUserCallbackDispatcherContinue
USER32!ZwUserSetWindowPos
CMyChildView2::OnSize()
USER32!UserCallWinProcCheckWow
USER32!DispatchClientMessage
USER32!__fnINLPWINDOWPOS
ntdll!KiUserCallbackDispatcherContinue
USER32!ZwUserSetWindowPos
CMyChildView1::OnSize()
USER32!UserCallWinProcCheckWow
USER32!DispatchClientMessage
USER32!__fnINLPWINDOWPOS
ntdll!KiUserCallbackDispatcherContinue
USER32!ZwUserSetWindowPos
CMyView::OnSize()
USER32!UserCallWinProcCheckWow
USER32!DispatchClientMessage
USER32!__fnINLPWINDOWPOS
ntdll!KiUserCallbackDispatcherContinue
USER32!ZwUserSetWindowPos
...[Snip]
```

Now, a `SetWindowPos` call will transition into kernel mode in order to make changes to the specified window's position. There is then a callback from kernel mode into user mode to call the window procedure of the window to process the `WM_WINDOWPOSCHANGING` or `WM_WINDOWPOSCHANGED` messages. Once the messages are handled, the `SetWindowPos` call returns.

Because of the deep hierarchy, kernel mode restricts growing the stack to some extent and has a depth level check. And, when it encounters the limit, it simply ignores the `WM_SIZE` processing of windows and causes the problem. This is not a bug in Windows OS, but a limitation that the application should never rely on.

## Resolution

Redesign the application to avoid a deep nested hierarchy of windows.

Try using `PostMessage` for the `WM_SIZE` message instead of `SendMessage` API. This will have an unblocking call, which would not necessary increase the stack to the limit and will give somewhat asynchrony function call. Because for `SendMessage`, until the message is processed the callstack will grow for its successive nested windows.

## More information

This problem is not limited to x64 Windows as it can also occur on x86. Windows, although it would take a deeper window hierarchy for the problem to occur in x86 Windows. Why the difference? Well, the size of pointers doubled from 32-bit to 64-bit and the size of the kernel mode stack did not.
