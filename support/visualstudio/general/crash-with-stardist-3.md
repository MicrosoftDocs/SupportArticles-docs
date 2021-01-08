---
title: Visual Studio 2012 crashes with StarDist-3
description: This article describes a problem where Visual Studio 2012 may crash with StarDist-3, and provides a workaround.
ms.date: 04/27/2020
ms.prod-support-area-path: Language or compilers
---
# Visual Studio 2012 may crash with StarDist-3

This article helps you resolve the problem where Microsoft Visual Studio 2012 crashes with StarDist-3.

_Original product version:_ &nbsp; Visual Studio Premium 2012, Visual Studio Ultimate 2012, Visual Studio Test Professional 2012  
_Original KB number:_ &nbsp; 2901613

## Summary

Stardict-3, cross-platform and international dictionary software, may cause Visual Studio 2012 to crash. However, information and data of this behavior is limited.

## Workaround

If you suspect that Stardict-3 is the cause, open Task Manager and verify that Stardict-3 is listed in the **Background process**. If so, stop the Stardict-3.exe process and launch Visual Studio 2012.

If this method resolves the issue, you're advised to remove StarDict-3 from the **Programs and features** applet in the Control Panel.

You can use StarDict-3.0.4 as the issue has not been seen with this version.
