---
title: Solution upgrade fails due to a previously pending upgrade
description: Works around the solution upgrade failure due to a previously pending upgrade in Power Apps.
ms.reviewer: jdaly
ms.date: 10/10/2023
author: swatimadhukargit
ms.author: swatim
---
# Solution upgrade fails due to a previously pending upgrade

_Applies to:_ &nbsp; Power Platform, Solutions

This article provides a workaround for an issue where a [solution upgrade](/power-apps/maker/data-platform/update-solutions) fails due to a previously pending upgrade in Microsoft Power Apps.

## Symptoms

A solution upgrade fails when a previous upgrade doesn't complete successfully.

The solution history page shows the following exception message for the failed upgrade:

> Solution manifest import: FAILURE: Holding solution \<Solution name\>_Upgrade exists. Cannot update solution.

You might see a notification error: The imported solution and the existing solution must both be managed for upgrade.

## Cause

This issue occurs because the environment has a pending upgrade solution `<Solution name>_Upgrade` from a previous attempt, and you're trying to apply a new upgrade solution. When a pending upgrade exists, applying a new upgrade or a new patch is blocked until the pending upgrade is resolved.

## Workaround

To work around the issue, it's necessary to complete the previously pending upgrade by resolving any errors. Or, you can delete the previous upgrade solution. However, this might lead to data loss if new data comes through tables and relationships in the upgrade. Once the pending upgrade is either completed or deleted, you can proceed with the new upgrade.

> [!TIP]
> Don't leave pending upgrades.
> If an upgrade fails, consider immediately deleting the upgrade. Then, go back to the source environment to fix the problem, and reapply the upgrade.
