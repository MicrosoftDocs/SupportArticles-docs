---
title: Visual Studio 2012 crashes with StarDict-3
description: This article describes an issue where Visual Studio 2012 may crash with StarDict-3, and provides a workaround. 
ms.date: 05/16/2022
ms.custom: sap:Integrated Development Environment (IDE)\Other
---

# Visual Studio 2012 may crash with StarDict-3

This article provides a workaround for the issue where Microsoft Visual Studio 2012 crashes with StarDict-3.

_Original product version:_ &nbsp; Visual Studio Premium 2012, Visual Studio Ultimate 2012, Visual Studio Test Professional 2012  
_Original KB number:_ &nbsp; 2901613

## Summary

StarDict-3, cross-platform and international dictionary software, may cause Visual Studio 2012 to crash. However, information and data of this behavior is limited.

## Workaround

If you suspect that StarDict-3 is the cause, open **Task Manager** and verify that StarDict-3 is listed in the **Background process**. If so, stop the *StarDict-3.exe* process and launch Visual Studio 2012.

If this method resolves the issue, you're advised to remove StarDict-3 from the **Programs and features** applet in the Control Panel.

You can use StarDict-3.0.4 as the issue hasn't been seen with this version.
