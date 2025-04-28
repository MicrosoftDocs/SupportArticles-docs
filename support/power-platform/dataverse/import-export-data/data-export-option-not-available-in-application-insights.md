---
title: Data Export Option Not Available in Azure Application Insights
description: Solves an issue where you can't find the data export option while setting up Application Insights for log analytics and observability in a new environment. It explains the cause of this issue and outlines steps to resolve it.
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 03/25/2025
ms.custom: sap:Importing and exporting data, DFM
---
# Data export option isn't available in Azure Application Insights

This article provides a resolution for the issue where the [data export](/power-platform/admin/set-up-export-application-insights) option isn't available while setting up Application Insights for log analytics and observability in a new environment.

## Symptoms

The data export option isn't available when setting up Azure Application Insights for log analytics and observability in a new environment.

## Cause

The data export feature is only supported in managed environments. If the environment is unmanaged, the feature won't be available. Additionally, premium licenses are required to enable the capabilities associated with data export.

## Resolution

To enable the data export feature, follow these steps:

1. Confirm the environment type:

   1. Navigate to the [Power Platform admin center](https://admin.powerplatform.microsoft.com/).
   2. Check the environment settings to determine if it's set to managed.

      If the environment is unmanaged, convert it to managed. For detailed instructions, see [Enable or edit Managed Environments in the admin center](/power-platform/admin/managed-environment-enable#enable-or-edit-managed-environments-in-the-admin-center).

2. Ensure all necessary licenses are in place before proceeding. For more information, see [Licensing overview for Microsoft Power Platform](/power-platform/admin/pricing-billing-skus).

3. Confirm the user has one of the required administrative roles:

   - Power Platform administrator
   - Dynamics 365 administrator
   - Microsoft 365 Global administrator

4. After converting the environment to managed, check if the data export option is now available in Azure Application Insights.

5. Manually schedule data exports. For more information, see [Export data to Application Insights](/power-platform/admin/set-up-export-application-insights).

   > [!NOTE]
   > Currently, Azure Application Insights doesn't support automatic scheduling for data exports. Users need to manually schedule exports.

## More information

[Conversation diagnostics in Azure Application Insights (preview)](/power-platform/admin/conversation-diagnostics-application-insights)
