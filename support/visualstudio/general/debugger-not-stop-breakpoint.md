---
title: Visual Studio debugger doesn't stop on breakpoints
description: Describes the debugger may not stop on breakpoints when you debug ASP.NET applications in Visual Studio .NET.
ms.date: 04/20/2020
ms.prod-support-area-path: Debuggers and analyzers
ms.reviewer: V-KIMWA
---
# Visual Studio .NET debugger doesn't stop on breakpoints when you debug ASP.NET pages

This article helps you resolve a problem where the debugger doesn't stop on breakpoints when you debug ASP.NET applications in Microsoft Visual Studio .NET.

_Original product version:_ &nbsp; Visual Studio, ASP.NET  
_Original KB number:_ &nbsp; 306169

## Symptoms

When you debug ASP.NET applications in Visual Studio .NET, the debugger might not stop on breakpoints.

## Cause

This problem occurs because ASP.NET debugging isn't enabled on the application.

## Resolution

To resolve this problem, follow these steps in Visual Studio .NET:

1. In Solution Explorer, select the project name.
2. From the **Project** menu, click **Properties**.
3. Click to expand the **Configuration Properties** node.
4. Under **Debugging**, in the **Enable ASP.NET Debugging** list, click **True**.
