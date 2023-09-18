---
title: Upgrade fails due to previous pending upgrade.
description: Works around the upgrade failure due to previous pending upgrade.
ms.reviewer: jdaly
ms.date: 09/18/2023
author: swatimadhukargit
ms.author: swatim
---
# Upgrade fails due to previous pending upgrade

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue that occurs when you attemp an upgrade but it fails due to pending upgrade from a previous attempt.

## Symptoms

When you try to attempt an upgrade it fails due to an already pending upgrade which did not complete successfully.

## Cause

The reason behind this kind of failure is that the environment has the old solution, pending upgrade solution from previous attempt and also the new upgrade solution(_upgrade). When a pending upgrade exist, bringing in a new upgrade or a new patch is blocked until the pending upgrade is resolved.

## Workaround

In order to work around the issue, it is necessary to either complete the previous pending upgrade by resolving any dependency issue. Or you can delete the previous uupgrade solution, this might result is loss of data if new data came through table and relationships in the upgrade. Once the pending upgrade is either completed or deleted, you can attempt the new upgrade successfully.

### Best Practices

- Do not leave pending upgrades, it will get difficult to finish that in future.  
- This can sometime result in circular dependencies on upgrade.  
- If failed to upgrade, consider immediately deleting the upgrade. And go back to source environment to fix the problem and try the upgrade again.