---
title: Desktop flow runs list is not updated
description: Provides a resolution for the issue that the list of desktop flow runs doesn't update even though you run a new desktop flow in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Desktop flow runs list isn't updated

This article provides a resolution to an issue where the list of desktop flow runs doesn't update as expected in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4598422

## Symptoms

The list of desktop flow runs doesn't change, even after you run new desktop flows in Microsoft Power Automate.

## Verifying issue

You need to check that **Live updates** auto-refresh feature is set to **On**.

:::image type="content" source="media/desktop-flow-runs-list-not-updated/live-updates-feature.png" alt-text="Check that the live updates feature is set to On.":::

## Resolution

Take the following steps to solve this issue:

1. The **Live updates** feature stops after some time and the run details can be cached by the browser. Reactivate the **Live updates** feature again to request new auto-updates.

2. Check that the run details match the current state of your desktop flow runs after the list is refreshed once (for example, the **Status** is correctly updated) to make sure everything is back to normal.
