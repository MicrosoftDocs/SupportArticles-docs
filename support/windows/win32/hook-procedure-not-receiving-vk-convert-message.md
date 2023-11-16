---
title: Hook procedure doesn't receive the VK_CONVERT message
description: This article helps you resolve the problem when an application is using a keyboard hook that doesn't receive the VK_CONVERT messages.
ms.date: 07/21/2022
ms.custom: sap:Desktop app UI development
ms.reviewer: junyoshi, v-jayaramanp
ms.technology: windows-dev-apps-desktop-app-ui-dev
---

# Hook procedure doesn't receive the VK_CONVERT message

This article helps you resolve the problem when an application that uses a keyboard hook doesn't receive `WM_KEYDOWN` messages for the `VK_CONVERT` virtual key.

_Applies to:_ &nbsp; Windows 11, Windows 10 version 20H2, Windows 10 version 21H1, Windows 10 version 21H2

## Symptoms

Keyboard hooks don't receive `WM_KEYDOWN` messages for the `VK_CONVERT` virtual key. This issue can cause unexpected behavior in the applications that call `SetWindowsHookEx`(`WH_KEYBOARD`) to set a keyboard hook which monitors the keyboard input.

## Cause

The Text Services Framework (TSF) assigns another action to the `WM_KEYDOWN` message for the `VK_CONVERT` virtual key and doesn't call the keyboard hook in this scenario.

## Workaround

Turn on the previous version of Microsoft Input Method Editor (IME) in Windows to revert this behavior.
For more information about how to use the previous version of the Microsoft IME, see [Revert to a previous version of an IME](https://support.microsoft.com/en-us/windows/revert-to-a-previous-version-of-an-ime-input-method-editor-adcc9caa-17cb-44d8-b46e-f5b473b4dd77).

## Status

Microsoft has confirmed that this is a problem in the TSF in Windows 11 and Windows 10 version 20H2/21H1/21H2.
