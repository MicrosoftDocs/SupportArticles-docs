---
title: Desktop flow runs do not show in Desktop flow runs 
description: Provides a resolution for the issue that you can't find your desktop flow runs in the Desktop flow runs page in Power Automate.
ms.reviewer: pefelesk
ms.date: 09/21/2022
ms.subservice: power-automate-desktop-flows
---
# Desktop flow runs don't appear in the list of all desktop flow runs

This article provides a resolution to an issue where your desktop flow runs don't show in the **Desktop flow runs** page in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4598409

## Symptoms

After you select **Monitor** > **Desktop flow runs** in the left navigation pane in Microsoft Power Automate, you can't find your desktop flow runs in the page.

## Verifying issue

1. Check that you are in the same environment as the flows and desktop flows you want to monitor.

    :::image type="content" source="media/desktop-flow-runs-not-show-monitor-runs/check-environment-for-flows-1.png" alt-text="Check that you're in the same environment as the flows and desktop flows you want to monitor." lightbox="media/desktop-flow-runs-not-show-monitor-runs/check-environment-for-flows-1.png":::

    :::image type="content" source="media/desktop-flow-runs-not-show-monitor-runs/check-environment-for-flows-2.png" alt-text="Make sure that you're in the same environment as the flows and desktop flows you want to monitor." lightbox="media/desktop-flow-runs-not-show-monitor-runs/check-environment-for-flows-2.png":::

2. Check that your list isn't empty because of column filters. The empty state below indicates that the list is filtered up to a point that nothing is visible anymore.

    :::image type="content" source="media/desktop-flow-runs-not-show-monitor-runs/nothing-found-using-this-filter.png" alt-text="Your list is empty because of the column filter.":::

## Resolution

To solve the issue, select the correct environment and check the following items:

- If the empty state states that some filters are active, select the **Remove filters** button to clear all the filters.
- If those steps don't solve the issue, check with your admin that you have all the [prerequisites](/power-automate/desktop-flows/setup#prerequisites) to use desktop flows, as the issue may be related to the lack of a CDS database or permissions to read CDS entities in the environment.
