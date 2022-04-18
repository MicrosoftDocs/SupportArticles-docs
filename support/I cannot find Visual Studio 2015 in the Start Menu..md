---
title: I cannot find Visual Studio 2015 in the Start Menu.
description: Provides a resolution and reason why you cannot find the Visual Studio icon in the Start Menu.
ms.date: 04/18/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
---

# I cannot find Visual Studio 2015 in the Start Menu.

This article provides resolutions and explination to why the Visual Studio icon is not in the Start Menu.

_Applies to:_&nbsp;Visual Studio 2015

## Symptom

Visual Studio install is not corrupt. The Visual Studio 2015 application icon has been moved outside of the Visual Studio 2015 folder. 

## Resolution

If you’re running Windows 7, you can find the application at the top of the “All Programs” list grouped with other application icons. If you are running Windows 8, 8.1 or 10, you can find the application listed under the ‘V’ grouping. If you are still unable to find it, use Windows search (press the Windows key, then type “Visual Studio 2015”).

> Note: The application icon will no longer be located in the Visual Studio 2015 folder.

If you are still unable to find Visual Studio after a successful install, open File Explorer and navigate to the following path. C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe and double click on the devenv.exe. If you have installed Visual Studio to a drive other than C, go to the location where you installed Visual Studio and navigate to Common7\IDE\devenv.exe. 
