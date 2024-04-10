---
title: WPF apps don't receive touch input events
description: Full-screen WPF applications might not receive touch input events on the right or bottom edges of the window.
ms.date: 05/11/2020
ms.reviewer: davean
---
# Full-screen WPF applications may not receive touch input events

This article helps you resolve the problem where full-screen Windows Presentation Foundation (WPF) applications don't receive touch input events.

_Original product version:_ &nbsp; Windows Presentation Foundation  
_Original KB number:_ &nbsp; 2652967

## Symptoms

You may see one of the following issues:

- Full-screen WPF applications might not receive touch input events on the right or bottom edges of the window.
- Windowed WPF applications that extend beyond the bottom or right edges of the desktop might not receive touch input events on the right or bottom of the desktop.

## Cause

Windows incorrectly reports touch input coordinates to WPF. WPF ignores touch input when the reported coordinates are outside the bounds of the WPF window.

## Status

Microsoft has confirmed that it's a problem in the Microsoft products.
