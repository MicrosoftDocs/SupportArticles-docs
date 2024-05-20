---
title: Break on Memory Leaks check fails in WPF
description: Works around the problem where the Break on Memory Leaks runtime check fails in WPF applications.
ms.date: 05/09/2020
ms.reviewer: vamsp
---
# Break on Memory Leaks runtime check fails in WPF applications

This article provides workarounds for the problem where **Break on Memory Leaks** runtime check fails with Windows Presentation Foundation (WPF) applications.

_Original product version:_ &nbsp; Windows Presentation Foundation  
_Original KB number:_ &nbsp; 2643361

## Symptoms

Developers can install the DirectX SDK and use the DirectX Control Panel to enable an extra runtime check called **Break on Memory Leaks**. Direct3D9 is designed to call `DebugBreak` at few places during shut-down when such configuration is enabled and when there's an object leak detected. Such a configuration change impacts all the DirectX applications - including Windows Presentation Foundation (WPF) applications such as Visual Studio 2010.

## Cause

The native rendering engine in WPF doesn't shut down cleanly and so such runtime checks fail. These crashes happen only during shutdown and hence no loss of data or no permanent resource leaks are expected.

## Workarounds

Use one of the following workarounds:

- Unselect **Break on Memory Leaks** check box on the DirectX Control Panel.
- Force WPF applications to use software rendering mode. For more information, see [Graphics Rendering Registry Settings](/dotnet/desktop/wpf/graphics-multimedia/graphics-rendering-registry-settings?view=netframeworkdesktop-4.8&preserve-view=true).
