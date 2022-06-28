---
title: Hook procedure doesn’t receive the VK_CONVERT message
description: This article helps you resolve the problem when an application is using a keyboard hook that doesn’t receive the VK_CONVERT messages.
ms.date: 06/28/2022
author: Shweta-Sohu
ms.author: v-shwetasohu
manager: dcscontentpm
ms.custom: sap:Desktop app UI development
ms.reviewer: junyoshi
ms.technology: windows-dev-apps-desktop-app-ui-dev
---

# Hook procedure doesn’t receive the VK_CONVERT message

This article helps you resolve the problem when an application is using a keyboard hook to detect and modify user input that doesn’t receive the `VK_CONVERT` messages.

_Applies to:_ &nbsp; Windows 11, Windows 10 version 20H2, Windows 10 version 21H1, 21H2

## Symptoms

Consider the scenario:

1. You’re using Windows 11, Windows 10 version 20H2, 21H1, 21H2.
1. You’ve set a hook with `SetWindowsHookEx` (`WH_KEYBOARD`) for an application.
In this scenario, the hook procedure doesn’t receive the `VK_CONVERT` (0x001C) `WM_KEYDOWN` message and the
procedure only receives the `WM_KEYUP` message.

## Cause

The new Text Services Framework (TSF) assigns another action to the `WM_KEYDOWN` message for `VK_CONVERT` that bypasses the hook procedure.

> [!NOTE]
> Windows 10, version 2004 introduced the new version of TSF.

## Workaround

Use the previous version of Microsoft Input Method Editor (IME) on Windows to revert this behavior.
For more information about how to use previous version of the Microsoft IME, see [Revert to a previous version of an IME](https://support.microsoft.com/en-us/windows/revert-to-a-previous-version-of-an-ime-input-method-editor-adcc9caa-17cb-44d8-b46e-f5b473b4dd77).

> [!NOTE]
> We recommend that you use the IME compatibility setting as a temporary workaround.

## Status

Microsoft has confirmed that this is a problem in the TSF in Windows 11, Windows 10 version 20H2, 21H1, 21H2.
