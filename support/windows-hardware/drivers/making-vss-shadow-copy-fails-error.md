---
title: Making VSS shadow copy fails with error
description: This article provides a workaround for the problem that occurs when you try to make a VSS shadow copy.
ms.date: 01/04/2021
ms.reviewer: danielwh
ms.topic: troubleshooting
ms.subservice: general
---
# VSS_WS_FAILED_AT_FREEZE error when you try to make a VSS shadow copy

This article helps you work around the problem that occurs when you try to make a VSS shadow copy.

_Applies to:_ &nbsp; Windows Server 2016, Windows Server 2012 R2  
_Original KB number:_ &nbsp; 4460135

## Symptoms

Applications that rely on a transactional registry operation that is set to an interval of less than 90 seconds can cause the Volume Shadow Copy Service (VSS) to time out and return a **VSS_WS_FAILED_AT_FREEZE** error.

## Cause

The time-out occurs because VSS sends the first thaw notification to third-party backup software, and that software is stuck at the stage of acquiring a transaction mutex.

The transaction is in the PrePrepare phase of a commit. The PrePrepare then goes to the system RM - registry. The system RM - registry is,  in turn, frozen by VSS. Therefore, the whole process is deadlocked until the registry writer times out after 60 seconds. Most writers also time out.

> [!NOTE]
> PrePrepare processing is allowed while third-party software is frozen because PrePrepare processing throttles transactions at the final phase of commit.

## Workaround

Contact the third-party vendor to determine whether it is possible to increase the registry transaction interval. We suggest that you increase the timing of the registry event to at least 120 seconds by using Kernel Transaction Manager (KTM).

## Status

This issue is scheduled to be fixed in the next version of Windows Server 2016.

[!INCLUDE [Third-party disclaimer](../../includes/third-party-disclaimer.md)]
