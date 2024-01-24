---
title: Event handles may leak
description: This article provides resolutions for the problem where ASP_PERFMON_- [XX] event handles may leak when you query performance counter objects on a local computer.
ms.date: 12/11/2020
ms.custom: sap:Site Behavior and Performance
ms.reviewer: nmallick, bariscag
ms.technology: site-behavior-performance
---
# ASP_PERFMON_- [XX] event handles may leak when you query performance counter objects on a local computer

This article helps you resolve the problem where `ASP_PERFMON_- [XX]` event handles may leak when you query performance counter objects on a local computer.

_Original product version:_ &nbsp; Internet Information Services  
_Original KB number:_ &nbsp; 2962962

## Symptoms

When you read performance monitor objects on your local computer by using the `PDHEnumObjects` API together with the bRefresh parameter set to *true*, you may notice a leak of `ASP_PERFMON_-[XXX]` event handles. This leak can also be observed if you query performance counter objects in .NET code by using `System.Diagnostics.PerformanceCounter` and you make a call to the `System.Diagnostics.PerformanceCounter.CloseSharedResources()` method.

## Cause

This leak occurs when the application code continuously closes and recreates the ASP performance counter object.

## Workaround

To work around this issue, use one of the following methods:

- Instead of closing and reopening the ASP performance counter object repeatedly, create a global instance of the ASP performance counter object, and then have your code read values from this global instance.
- If you do not intend to query the ASP performance counter object, you may disable it by adding a **Disable Performance Counters** DWORD registry entry that has a value of *1* to the registry subkey: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\ASP\Performance`.
