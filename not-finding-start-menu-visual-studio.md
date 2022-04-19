---
title: I cannot find Visual Studio 2015 in the Start menu.
description: Provides a resolution for not finding the Visual Studio icon in the Start menu.
ms.date: 04/18/2022
author: jasonchlus
ms.author: jasonchlus
ms.reviewer: terry.g.lee
---

# Cannot find Visual Studio 2015 icon in the Start menu.

This article helps you resolve the issue why the Visual Studio icon is not present in the Start menu.

_Applies to:_&nbsp;Visual Studio 2015

## Symptom

Your Visual Studio installation is not corrupted. The Visual Studio 2015 application icon is moved out of the Visual Studio 2015 folder. 

## Resolution

If you are running Windows 7, you can find the Visual Studio 2015 application at the top of the “All Programs” list grouped with other application icons. If you are running Windows 8, 8.1 or 10, you can find it listed under the ‘V’ grouping. If you are still unable to find it, use Windows search (press the Windows key, then type “Visual Studio 2015”).

> Note: The application icon will no longer be in the Visual Studio 2015 folder.

If you are still unable to find Visual Studio after a successful install, open File Explorer and navigate to the following path. C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe and double click on the devenv.exe. If you have installed Visual Studio to a drive other than C:\, go to the folder where you installed Visual Studio and navigate to Common7\IDE\devenv.exe. 
