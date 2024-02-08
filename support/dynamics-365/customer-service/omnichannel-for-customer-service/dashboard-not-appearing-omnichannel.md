---
title: Dashboards don't show in Omnichannel for Customer Service active dashboards view
description: Provides a resolution for the issue where dashboards don't appear in Omnichannel for Customer Service.
ms.reviewer: nenellim
ms.author: vamullap
ms.date: 05/23/2023
---
# Dashboards don't appear in Omnichannel for Customer Service active dashboards view

This article provides a resolution for the issue where some dashboards aren't shown in the active dashboards view in Omnichannel for Customer Service.

## Symptoms

When you use the Omnichannel for Customer Service app on Unified Service Desk or the web, the **Active Omnichannel Agent Dashboard** view doesn't show certain dashboards like Tier 1 Dashboard, Tier 2 Dashboard, Knowledge Manager, and My Knowledge Dashboard.

## Cause

The dashboards haven't been added.

## Resolution

As a system customizer or administrator, you must manually add these dashboards by using App Designer.

To add the dashboards using App Designer, follow these steps:

1. Go to `https://<orgURL>.dynamics.com/apps`.
2. Select the ellipsis (**...**) button in the **Omnichannel for Customer Service** app tile.

    :::image type="content" source="media/dashboard-not-appearing-omnichannel/omnichannel-sign-in.png" alt-text="Screenshot that shows how to sign in to Omnichannel for Customer Service.":::

3. Select **OPEN IN APP DESIGNER**. App Designer opens in a new tab.
4. Select **Dashboards** in the canvas area. The **Components** pane on the right side shows the list of **Classic Dashboards** and **Interactive Dashboards**.
5. Select the following dashboards under **Interactive Dashboards**.
    - Knowledge Manager
    - My Knowledge Dashboard
    - Tier 1 Dashboard
    - Tier 2 Dashboard

    :::image type="content" source="media/dashboard-not-appearing-omnichannel/omnichannel-app-designer-add-dashboard.png" alt-text="Screenshot that shows how to add dashboards in the app designer canvas area.":::

6. Select **Save** and then select **Publish**.
