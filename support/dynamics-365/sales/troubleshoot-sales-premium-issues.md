---
title: Troubleshoot issues with Sales Premium 
description: Provides resolutions for the known issues that are related to the Sales Premium features.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Sales Insights

---

# Troubleshoot issues with the Sales Premium features

This article helps you troubleshoot and resolve issues related to the Sales Premium features.

## Issue: Can't install or Sales Insights features doesn't work as defined

### Cause

This issue could occur when some of the processes that are related to Sales Insights are disabled in your organization and a warning message is displayed in the **Sales Insights settings** page as shown below:

> One or more processes are disabled. Please enable them.

:::image type="content" source="media/troubleshoot-sales-premium-issues/one-or-more-processes-are-disabled.png" alt-text="Sales insights processes are disabled warning message.":::

### Resolution

To solve this issue, enable the Sales Insights processes that are disabled. Follow these steps:

1. In your app, select the **Settings** icon, and then select **Advanced Settings**.

    :::image type="content" source="media/troubleshoot-sales-premium-issues/advanced-settings-option.png" alt-text="Advanced Settings option on the Settings menu." border="false":::

    The **Business Management** page opens.

2. On the navigation bar, select **Settings**, and then under **Process Center**, select **Processes**.

3. On the **Processes** page, choose the **All Processes** view and the search for sale insights.

    A list of Sales Insights processes is displayed.

4. Verify that the statuses of all Sales Insights processes are in **Activated** state. In this example, you can see that the **Sales Insights ActionCard stat aggregator**, **Sales Insights CES API Handler**, and **Sales Insights create similar opportunity prediction model** processes are in draft state.

    :::image type="content" source="media/troubleshoot-sales-premium-issues/sales-insights-processes.png" alt-text="View all Sales Insights processes." lightbox="media/troubleshoot-sales-premium-issues/sales-insights-processes.png":::

5. Select the processes that are in **Draft** state and activate.
