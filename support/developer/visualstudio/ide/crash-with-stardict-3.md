---
title: Visual Studio 2012 crashes with StarDist-3
description: This article helps you resolve a situation where Visual Studio 2012 might crash because of StarDist-3. 
ms.date: 05/11/2022
ms.custom: sap:Language or compilers
ms.technology: vs-language-compilers
---
# Visual Studio 2012 might crash with StarDict-3

This article provides a workaround when Microsoft Visual Studio 2012 crashes with StarDict-3.

_Original product version:_ &nbsp; Visual Studio Premium 2012, Visual Studio Ultimate 2012, Visual Studio Test Professional 2012  
_Original KB number:_ &nbsp; 2901613

## Summary

StarDict-3, a cross-platform and international dictionary software, might cause Visual Studio 2012 to crash. However, information and data of this behavior is limited.

## Workaround

If you suspect that StarDict-3 is the cause, open **Task Manager** and verify that StarDict-3 is listed in the **Background process**. If so, stop the *StarDict-3.exe* process and launch Visual Studio 2012.

If this method resolves the issue, you're advised to remove StarDict-3 from the **Programs and features** applet in the Control Panel.

You can use StarDict-3.0.4 as the issue hasn't been seen with this version.
