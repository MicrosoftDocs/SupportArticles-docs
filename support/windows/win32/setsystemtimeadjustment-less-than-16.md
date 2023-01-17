---
title: SetSystemTimeAdjustment loses time adjustment
description: SetSystemTimeAdjustment behaves differently in Vista and Windows 7 than it did in XP.
ms.date: 03/10/2020
ms.custom: sap:System services development
ms.reviewer: Franki, jlambert
ms.topic: article
ms.technology: windows-dev-apps-system-services-dev
---
# SetSystemTimeAdjustment may lose adjustments less than 16

This article explains why the `SetSystemTimeAdjustment` function loses time adjustments that are less than 16 in Windows 7 and Windows Vista.

_Original product version:_ &nbsp; Windows 7, Windows Vista  
_Original KB number:_ &nbsp; 2537623

## Summary

Because of changes in the way Windows Vista and Windows 7 update the system time, the API `SetSystemTimeAdjustment()` will lose time adjustments that are less than 16. The time adjustment represents the number of 100-nanosecond units added to the system time-of-day for each `lpTimeIncrement` period of time that actually passes.

## Status

This issue is a known problem with Windows 7 and Vista. Time adjustments of 16 or greater still work as expected.
