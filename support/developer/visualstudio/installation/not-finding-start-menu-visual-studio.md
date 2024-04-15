---
title: Can't find Visual Studio 2015 on the Start menu
description: Provides a resolution for not finding the Visual Studio icon on the Start menu.
ms.date: 04/15/2024
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee, jagbal
ms.custom: sap:Installation\Other
---

# Can't find Visual Studio 2015 on the Start menu

This article helps you resolve the issue where Microsoft Visual Studio icon is not visible on the Start menu.

_Applies to:_&nbsp;Visual Studio 2015

## Symptoms

The Visual Studio icon no longer appears on the **Start** menu. Although your Visual Studio installation is not corrupted, you find that the Visual Studio 2015 application icon is moved out of the Visual Studio 2015 installation folder.

## Resolution

If you are running Windows 7, you can find the Visual Studio 2015 application at the top of the **All Programs** list grouped with other application icons. If you are running Windows 10, Windows 8.1, Windows 8 or Windows 11, you can find the icon listed under the **V** grouping. If you still can not find the icon, use Windows search (press the Windows logo key, and then enter *Visual Studio 2015*).

 > [!NOTE]
 > The application icon will no longer be in the Visual Studio 2015 folder.

If you still can not find Visual Studio after a successful installation, open File Explorer, and then navigate to the following path:

`C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe`

Double-click the *devenv.exe* file. If you installed Visual Studio to a drive other than the C drive, go to the folder where you installed Visual Studio, and then locate *Common7\IDE\devenv.exe*.
