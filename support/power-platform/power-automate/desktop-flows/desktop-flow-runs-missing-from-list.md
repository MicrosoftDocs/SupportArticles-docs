---
title: Desktop flow runs are not shown in the list
description: Provides a resolution for an issue that prevents you from seeing some desktop flow runs in Power Automate.
ms.reviewer: pefelesk
ms.date: 06/07/2024
ms.custom: sap:Desktop flows\Working with Power Automate for desktop
---
# Some desktop flow runs are missing in Power Automate

This article helps you troubleshoot situations in which some desktop flows aren't displayed in the list of all desktop flow runs in Microsoft Power Automate.

_Applies to:_ &nbsp; Power Automate  
_Original KB number:_ &nbsp; 4598418

## Symptoms

Consider the following scenario:

- You're working in the [Microsoft Power Automate portal](https://make.powerautomate.com/).
- You run a desktop flow.
- In the navigation pane, you select **Monitor** > **Desktop flow runs**.

In this scenario, you can't find your desktop flow runs in the list, or the list is empty.

## Cause
This issue might occur if you select the wrong environment or you set up filters that cause the desktop flow to be filtered out.

## Resolution
To verify and resolve the issue, follow these steps:

1. In the [Power Automate portal](https://make.powerautomate.com/), check the environment name in the upper-right corner. Make sure that you're using the same environment that's used by the desktop flows that you want to monitor.

    :::image type="content" source="media/desktop-flow-runs-missing-from-list/check-environment-for-flows.png" alt-text="Screenshot that shows how to check your environment when you troubleshoot missing desktop flows." lightbox="media/desktop-flow-runs-missing-from-list/check-environment-for-flows.png":::

2. Go to **My flows** > **Desktop flows** to check that the desktop flow wasn't deleted.

3. If the desktop flow exists, go to the **Monitor** > **Desktop flow runs** page to check whether column filters are active. This activity is indicated by funnel icons in the column headers.

    :::image type="content" source="media/desktop-flow-runs-missing-from-list/check-filters-on-desktop-flows.png" alt-text="Screenshot that hsows how to check whether some filters are configured." lightbox="media/desktop-flow-runs-missing-from-list/check-filters-on-desktop-flows.png":::

    The filters might be hiding the desktop flow run that you're expecting to see. If the filters are sufficiently aggressive, you might see a completely empty flow list.

    :::image type="content" source="media/desktop-flow-runs-missing-from-list/nothing-found-using-this-filter.png" alt-text="Screenshot that shows an overly filtered flow list that displays no flows." lightbox="media/desktop-flow-runs-missing-from-list/nothing-found-using-this-filter.png":::

4. If filters exist, clear the filters to show the hidden desktop flows again. To do this, select the column headers, and then select **Filter by** > **Clear filter** > **Apply**.

If these steps don't resolve the issue, check with your administrator to make sure that you meet the [prerequisites](/power-automate/desktop-flows/monitor-desktop-flow-runs#prerequisites) to view desktop flow runs.

## More information
* [Monitor desktop flow runs](/power-automate/desktop-flows/monitor-desktop-flow-runs)
* [Manage desktop flows](/power-automate/desktop-flows/manage)
