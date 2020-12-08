---
title: Modern apps are blocked by security software when you start the applications on Windows 10
description: Describes an issue in which Modern apps are blocked by security software when you start the applications on Windows 10. Provides a workaround.
ms.date: 12/07/2020
ms.prod-support-area-path: 
ms.technology: [Replace with your value]
ms.reviewer: 
---
# Modern apps are blocked by security software when you start the applications on Windows 10

_Original product version:_ &nbsp; Windows 10, version 1903, all editions, Windows 10, version 1809, all editions, Windows 10, version 1607, all editions  
_Original KB number:_ &nbsp; 4016973

## Symptoms

When you start a Modern app, such as Microsoft.MSN.Money.exe or Microsoft.Photos.exe, on Windows 10, version 1607, Windows 10, version 1809 or Windows 10, version 1903, you notice that the application is blocked by your security software. 

## Cause

This issue occurs because the individual files within an application package are not digitally signed even though the packages are catalog-signed. 

## Workaround

To work around this issue, add the affected applications to the white lists of your security software.
