---
title: Modern apps are blocked by security software when you start the applications on Windows 10
description: Describes an issue in which Modern apps are blocked by security software when you start the applications on Windows 10. Provides a workaround.
ms.date: 01/15/2025
manager: dcscontentpm
audience: itpro
ms.topic: troubleshooting
ms.reviewer: kaushika, squin, v-jesits
ms.custom:
- sap:windows desktop and shell experience\modern,inbox and microsoft store apps
- pcy:WinComm User Experience
---
# Modern apps are blocked by security software when you start the applications on Windows 10

This article provides a workaround for an issue where modern apps are blocked by security software when you start the applications on Windows 10.

_Applies to:_ &nbsp; Windows 10, version 1903, Windows 10, version 1809, Windows 10, version 1607  
_Original KB number:_ &nbsp; 4016973

## Symptoms

When you start a Modern app, such as Microsoft.MSN.Money.exe or Microsoft.Photos.exe, on Windows 10, version 1607, Windows 10, version 1809 or Windows 10, version 1903, you notice that the application is blocked by your security software.

## Cause

This issue occurs because the individual files within an application package are not digitally signed even though the packages are catalog-signed.

## Workaround

To work around this issue, add the affected applications to the allow lists of your security software.
