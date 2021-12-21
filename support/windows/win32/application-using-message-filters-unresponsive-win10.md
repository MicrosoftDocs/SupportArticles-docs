---
title: A user-defined application that uses message filters may become unresponsive in Windows 10 20H1/20H2/21H1/21H2
description: This article discusses the problem when an application using its own message filters stops responding in Windows 10 because Windows can't receive the messages to process the Text Services Framework (TSF).  
ms.date: 12/20/2021
ms.prod-support-area-path: Windows 10
ms.reviewer: hihayak
ms.technology: windows-dev-apps-networking-dev
---

# A user-defined application that uses message filters may become unresponsive in Windows 10 20H1/20H2/21H1/21H2

This article helps you resolve the problem when an application using its own message filters stops responding in Windows 10 because Windows can't receive the messages to process the Text Services Framework (TSF).

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1, Windows 10, version 21H2

_Original KB number:_ &nbsp;

## Symptoms

Consider the scenario where you run an application on Windows 10 version 2004, 20H2, 21H1, or 21H2, and your application is using message filters.
In this scenario, the application may become unresponsive.

> [!NOTE]
> Windows 11 has not observed this problem.

## Cause

Windows 10 20H1/20H2/21H1/21H2 adds Windows messages used by the text input systems or Text Services Framework (TSF).

> [!NOTE]
> Windows 10 version 2004 introduced the new version of TSF.

If the `PeekMessage` API or `GetMessage` API has removed the Windows messages used by the TSF and Windows can't receive the messages to process the TSF, the application that uses message filters may stop responding.

This problem may occur if you run commands similar to the following example, which dispatch `WM_LBUTTONUP` messages only and remove other messages.

```powershell
----
while(::PeekMessage(&msg,NULL,0,0,PM_REMOVE))
{
::TranslateMessage(&msg);

// Dispatch only specific messages.
if (msg.message == WM_LBUTTONUP) {
::DispatchMessage(&msg);
}
}
-----
```

## Workaround 1

Run the following commands to only process the required messages and to dispatch other messages through the `DispatchMessage` API:

```powershell
-----
while(::PeekMessage(&msg,NULL,0,0,PM_REMOVE))
{
::TranslateMessage(&msg);

if (msg.message == WM_ WM_LBUTTONDOWN) {

}
else {
// Dispatches all non-filtered messages
::DispatchMessage(&msg);
}
}
-----
```

## Workaround 2

Enable the previous version of the Microsoft IME by turning on the **Use previous version of \<Microsoft IME\>** toggle for your language in the **Language settings**, if you're using the new Microsoft IME in Windows 10.

> [!NOTE]
> We recommend that you use the IME compatibility setting as a temporary workaround.
