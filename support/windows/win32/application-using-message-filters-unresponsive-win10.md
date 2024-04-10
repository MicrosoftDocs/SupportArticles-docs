---
title: Apps using message filters may not respond in Windows 10
description: This article discusses the problem when an application using its own message filters stops responding in Windows 10.
ms.date: 12/19/2023
author: HaiyingYu
ms.author: haiyingyu
manager: dcscontentpm
ms.custom: sap:Desktop app UI development\Windows management (User32) API and Windows messages
ms.reviewer: hihayak
---

# A user-defined application using message filters may become unresponsive in Windows 10, version 2004/20H2/21H1/21H2

This article helps you resolve the problem when an application using its own message filters stops responding in Windows 10.

_Applies to:_ &nbsp; Windows 10, version 2004, Windows 10, version 20H2, Windows 10, version 21H1, Windows 10, version 21H2

## Symptoms

Consider the scenario where you run an application on Windows 10, version 2004/20H2/21H1/21H2 and your application is using message filters.
In this scenario, the application may become unresponsive.

> [!NOTE]
> This issue is not observed in Windows 11.

## Cause

Windows 10 adds Windows messages used by text input systems or Text Services Framework (TSF).

> [!NOTE]
> Windows 10, version 2004 introduced the new version of TSF.

If the message filter of the application removes Window messages using `PeekMessage` API or `GetMessage` API and doesn't pass messages to `DispatchMessage` API, TSF can't complete processing the messages and the application may stop responding.

This problem may occur if the application has the message filter similar to the following example, which dispatches `WM_LBUTTONUP` messages only and removes other messages.

```cpp

while(::PeekMessage(&msg,NULL,0,0,PM_REMOVE))
{
    ::TranslateMessage(&msg);
    
    // Dispatch only specific messages.
    if (msg.message == WM_LBUTTONUP) {
        ::DispatchMessage(&msg);
    }
}

```

## Workaround 1

Modify the message filter to only filter the required messages and to dispatch other messages through `DispatchMessage` API.

```cpp

while(::PeekMessage(&msg,NULL,0,0,PM_REMOVE))
{
    ::TranslateMessage(&msg);
    
    if (msg.message == WM_LBUTTONDOWN) {
    
    }
    else {
        // Dispatches all non-filtered messages
        ::DispatchMessage(&msg);
    }
}

```

## Workaround 2

Enable the compatibility mode of the Microsoft IME (Input Method Editor), if you're using the new Microsoft IME in Windows 10.

For more information about how to use previous version of the Microsoft IME, see
[Revert to a previous version of an IME (Input Method Editor)](https://support.microsoft.com/windows/revert-to-a-previous-version-of-an-ime-input-method-editor-adcc9caa-17cb-44d8-b46e-f5b473b4dd77).

> [!NOTE]
> We recommend that you use the IME compatibility setting as a temporary workaround.
