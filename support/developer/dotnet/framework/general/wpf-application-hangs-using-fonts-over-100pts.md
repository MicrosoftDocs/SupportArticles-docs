---
title: WPF application hangs when you use fonts over 100 pts in size
description: This article provides a resolution for the problem where application becomes unresponsive and hangs indefinitely.
ms.date: 01/07/2021
ms.reviewer: Tatkins
ms.topic: troubleshooting
---
# WPF application hangs when you use fonts over 100 pts in size

This article helps you resolve the problem where application becomes unresponsive and hangs indefinitely.

_Applies to:_ &nbsp; .NET Framework 3.5 Service Pack 1  
_Original KB number:_ &nbsp; 2712383

## Symptom

You have a Microsoft .NET 3.5 Window Presentation Framework (WPF) application, which uses large characters and/or fonts. The application becomes unresponsive and hangs indefinitely.

## Cause

The Windows Presentation Framework UI thread has entered a critical section called the composition lock. While the UI thread is holding this lock, it needs to synchronize communication with the Windows Presentation Framework render thread. The render thread is processing a large character when it needs to enter into the composition lock. Since the UI thread has the composition lock, the render thread waits for it and the threads become deadlocked.

We have confirmed this is a bug in the Microsoft .NET 3.5 Framework.

## Resolution

This bug has been fixed in Microsoft .NET 4.0 Framework. To work around this bug, avoid using large characters or fonts, or upgrade your application to target the Microsoft .NET 4.0 Framework.

## More information

In the above symptom, we define large to mean a character with an effective size of 100 pt or greater, 100 pt being the bug threshold. Effective refers to multiplying the font size by any transforms. The threshold takes into account any transformations that might be in effect, and the effect of your computer's DPI setting. For example, if you use a 60-point Arial font within the scope of a RenderTransform that scales up by a factor of 2, the effective size is 120 pt, which exceeds the 100-pt threshold limit.
