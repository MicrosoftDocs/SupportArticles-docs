---
title: Fix Disabled Processes Error in Sales Insights
description: Fix the "One or more processes are disabled" warning in Dynamics 365 Sales Insights to install features, enable email engagement, and use AI capabilities.
ms.date: 06/05/2026
ms.reviewer: shjais, ramakris, v-shaywood
ai-usage: ai-assisted
ms.custom: sap:Sales Insights
---

# "One or more processes are disabled" error in Dynamics 365 Sales Insights

## Summary

This article helps you fix the "One or more processes are disabled" warning that appears on the **Sales Insights settings** page in Microsoft Dynamics 365 Sales. This issue can block you from installing Sales Insights, enabling email engagement, or using other AI-driven features as expected.

## Symptoms

When you try to install Sales Insights or set up a Sales Insights feature like email engagement, you experience one or more of the following symptoms:

- The installation doesn't finish, or it fails with errors.
- The feature doesn't turn on, or you get errors during setup.
- The feature is enabled, but it doesn't work as expected.

The **Sales Insights settings** page might also show the following warning message:

> One or more processes are disabled. Please enable them.

:::image type="content" source="media/troubleshoot-sales-premium-issues/one-or-more-processes-are-disabled.png" alt-text="Screenshot of the Sales Insights settings page showing the 'One or more processes are disabled' warning message.":::

## Cause

Sales Insights and its features depend on several background processes. This issue occurs when either of the following conditions is true:

- A background process that's required to install Sales Insights is disabled.
- A background process that the affected feature (like email engagement) depends on is disabled.

## Solution

To fix this issue, activate the disabled Sales Insights processes:

1. In your app, select the **Settings** icon, and then select **Advanced Settings**.

    :::image type="content" source="media/troubleshoot-sales-premium-issues/advanced-settings-option.png" alt-text="Screenshot of the Settings menu in Dynamics 365 Sales with the Advanced Settings option highlighted." border="false":::

    The **Business Management** page opens.

1. On the navigation bar, select **Settings**, locate the **Process Center** section, and then locate and select **Processes**.

1. On the **Processes** page, select the **All Processes** view, and then search for *Sales Insights*.

1. Check the status of every Sales Insights process. Each one should be set to **Activated**. Any process that's in the **Draft** state is disabled.

1. Select each process that's in the **Draft** state, and then activate it.

1. Go back to the **Sales Insights settings** page, and try the installation or feature again.

## Related content

- [Welcome to Dynamics 365 Sales](/dynamics365/sales/overview)
- [Enable and configure Sales Insights features](/dynamics365/sales/intro-admin-guide-sales-insights)
- [Configure and enable email engagement](/dynamics365/sales/configure-email-engagement)
