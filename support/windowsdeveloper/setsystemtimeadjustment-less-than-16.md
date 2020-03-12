---
title: SetSystemTimeAdjustment loses time adjustment
description: SetSystemTimeAdjustment behaves differently in Vista and Windows 7 than it did in XP.
ms.date: 03/10/2020
ms.prod-support-area-path:
ms.reviewer: Franki, jlambert
---
# SetSystemTimeAdjustment May Lose Adjustments Less than 16

This article explains why the SetSystemTimeAdjustment API will lose time adjustments that are less than 16 in Windows 7 and Windows Vista.

_Original product version:_ &nbsp; Windows 7, Windows Vista  
_Original KB number:_ &nbsp; 2537623

Because of changes in the way Windows Vista and Windows 7 update the system time, the API SetSystemTimeAdjustment() will lose time adjustments that are less than 16. The time adjustment represents the number of 100-nanosecond units added to the system time-of-day for each lpTimeIncrement period of time that actually passes.

This issue is a known problem with Windows 7 and Vista. Time adjustments of 16 or greater still work as expected.
