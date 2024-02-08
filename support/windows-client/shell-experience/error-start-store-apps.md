---
title: Fail to start Microsoft Store apps
description: You receive an error message when you try to start a Windows Store app in Windows 8 or Windows Server 2012.
ms.date: 09/08/2020
author: Deland-Han
ms.author: delhan
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.service: windows-client
localization_priority: medium
ms.reviewer: kaushika
ms.custom: sap:modern-inbox-and-microsoft-store-apps, csstroubleshoot
ms.subservice: shell-experience
---
# Error when you start Microsoft Store apps: This app has been blocked by your system administrator

This article helps fix an error (This app has been blocked by your system administrator) that occurs when you to start Microsoft Store apps.

_Applies to:_ &nbsp; Windows 10 - all editions, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 2750770

## Symptoms

When you try to start a Microsoft Store app in Windows 8 or in Windows Server 2012, the operation fails. Additionally, you receive the following error message:

> This app has been blocked by your system administrator.

:::image type="content" source="media/error-start-store-apps/app-blocked-by-system-administrator-error.png" alt-text="Screenshot of the Microsoft Store apps error message." border="false":::

## Cause

This issue occurs because an administrator has deployed an application control policy (AppLocker) on the computer. By design, all Microsoft Store apps are blocked if an AppLocker policy is applied.

## Resolution

To allow the Microsoft Store app to run, a domain administrator can use AppLocker to edit application control policies. To do so, use one of the following methods, whichever is most appropriate to their situation:

1. Create a default rule that allows all Microsoft Store apps.
2. Create rules that allow individual Microsoft Store apps.

> [!NOTE]
> The rules must be edited from a Windows Server 2012-based domain controller or from a Windows 8-based computer that has the Remote Server Administration Tools installed.

## More information

For more information about AppLocker, see the following articles:

- [AppLocker overview](/previous-versions/windows/it-pro/windows-8.1-and-8/hh831409(v=ws.11))

- [Create a rule for packaged apps](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh994588(v=ws.11))
