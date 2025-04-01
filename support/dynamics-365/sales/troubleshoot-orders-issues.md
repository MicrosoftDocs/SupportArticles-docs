---
title: Troubleshoot issues with an order
description: Provides resolutions for the issues that may occur when working with orders in Dynamics 365 Sales.
author: sbmjais
ms.author: shjais
ms.topic: troubleshooting
ms.date: 02/28/2022
ms.custom: sap:Order
---

# Troubleshoot issues with orders

Follow the instructions in this article to troubleshoot the issues you might face when working with orders.

## Issue: Can't see the Create invoice button on order forms

Sales order processing integration connects Dynamics 365 Sales with an external, back-office order-processing application. When enabled, it allows a sales order created in Dynamics 365 Sales to be submitted and then synchronized with an external order processing application, where the lifecycle of the order continues.

### Cause

When the sales order processing integration is enabled, users don't see the **Create Invoice** button on order records.

### Resolution

To resolve this issue, you must disable sales order processing integration. If the integration is enabled unintentionally, you can disable it by taking the following steps:

1. In the Sales Hub app, at the bottom of the site map, select **Change area** :::image type="icon" source="media/troubleshoot-orders-issues/change-area-icon.png":::, and then select **App Settings**.

2. Under **General Settings**, select **Overview**.

    When sales order processing is already enabled, users with the System Administrator role or equivalent permissions will see the **Back office order processing integration** setting on the **Overview** page.

    :::image type="content" source="media/troubleshoot-orders-issues/back-office-order-processing-integration-option.png" alt-text="Setting to disable back-office order-processing integration.":::

3. Select **Manage**.
4. To disable the integration, switch **Sales order processing** to **Off**, and then select **Save**.

    :::image type="content" source="media/troubleshoot-orders-issues/sales-order-processing-setting.png" alt-text="Set the Sales order processing option to Off if you want to disable the integration.":::

    > [!IMPORTANT]
    >
    > - The **Back office order processing integration** setting is visible only when sales order processing is already enabled.
    > - After the setting is disabled, users will no longer see this setting.
    > - This setting can be used only to disable sales order processing in case it was turned on unintentionally through some solution installation. This setting can't be used to turn _on_ sales order processing. To learn about turning on sales order processing, see [Enable sales order processing integration](/dynamics365/sales/developer/enable-sales-order-processing-integration).
