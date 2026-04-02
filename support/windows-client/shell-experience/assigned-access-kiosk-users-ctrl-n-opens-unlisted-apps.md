---
title: Assigned access kiosk users can use CTRL + N to open File Explorer although it isn't an allowed app
description: Assigned access users can press CTRL + N to open a File Explorer window even when File Explorer isn't included in the list of allowed applications.
ms.date: 04/03/2026
manager: dcscontentpm
ms.topic: troubleshooting
ms.custom:
- sap:windows desktop and shell experience\kiosk mode
- pcy:WinComm User Experience
ms.reviewer: kaushika, warrenw, v-appelgatet
audience: itpro
ai.usage: ai-assisted
appliesto:
  - <a href=https://learn.microsoft.com/windows/release-health/supported-versions-windows-client target=_blank>Supported versions of Windows Client</a>
---
# Assigned access kiosk users can use CTRL + N to open File Explorer although it isn't an allowed app

## Summary

In a kiosk environment, assigned access users can press CTRL + N to open a File Explorer window even when File Explorer isn't included in the list of allowed applications. This article explains why this behavior occurs and how to prevent it by using the keyboard filter feature.

## Symptom

You create a kiosk environment by applying an [assigned access configuration XML file](/windows/configuration/assigned-access/configuration-file) that includes a list of allowed applications. That list doesn't include File Explorer.

While signed in to the kiosk environment, an assigned access user presses CTRL + N. A File Explorer window opens.

## Cause

This behavior is by design. The CTRL + N shortcut isn't specific to File Explorer. This shortcut opens a new window of the currently active process or service (in this case, explorer.exe). The shortcut works together with any application that supports it.

Because the explorer.exe process provides the Windows shell experience, it always runs even if File Explorer isn't on the list of allowed applications. Therefore, it's possible for CTRL + N to open new File Explorer windows.

## Workaround

To block the CTRL + N shortcut in a kiosk environment, use the keyboard filter feature. For more information, see [Keyboard Filter](/windows/configuration/keyboard-filter/).

> [!IMPORTANT]  
> Keyboard filter doesn't block CTRL + N in Remote Desktop Services (RDS) environments.

## References

- [Create an Assigned Access configuration XML file](/windows/configuration/assigned-access/configuration-file)
- [Keyboard Filter](/windows/configuration/keyboard-filter/)
