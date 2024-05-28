---
title: Desktop flow runs are not shown in the list
description: Provides a resolution for the issue that you can't see some desktop flow runs when viewing the list of all desktop flow runs in Power Automate.
ms.reviewer: pefelesk
ms.date: 05/30/2024
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Some desktop flow runs are missing from the list

This article helps you troubleshoot instances when some desktop flows aren't displayed in the list of all desktop flow runs in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4598418

## Symptoms

When you select **Monitor** > **Desktop flow runs** in the left navigation pane in Microsoft Power Automate, you can't find your desktop flow runs in the list or the list is empty.

## Cause
This scenario might occur if you have selected the wrong environment, or if you have set up filters that result in the desktop flow getting filtered out.

## Resolution
Follow these steps to verify and resolve the issue:
1. Check that you are in the same environment as the flows and desktop flows you want to monitor.

    :::image type="content" source="media/desktop-flow-runs-missing-from-list/check-environment-for-flows.png" alt-text="Check that you're in the same environment as the flows and desktop flows you want to monitor." lightbox="media/desktop-flow-runs-missing-from-list/check-environment-for-flows.png":::

2. Check that the desktop flow hasn't been deleted.

     :::image type="content" source="media/desktop-flow-runs-missing-from-list/check-my-flows.png" alt-text="Check that your desktop flows are shown in the list.":::

3. If the desktop flow is still present, check if some filters are active in the **Monitor** > **Desktop flow runs** page, indicated by the presence of funnel icons in the column headers.

    :::image type="content" source="media/desktop-flow-runs-missing-from-list/check-filters-on-desktop-flows.png" alt-text="Check if some filters are configured." lightbox="media/desktop-flow-runs-missing-from-list/check-filters-on-desktop-flows.png":::

## Resolution

To solve the issue, you can clear the filters to show the hidden desktop flow runs again. To do that, select the column headers, and then select **Filter by** > **Clear filter** > **Apply**.
