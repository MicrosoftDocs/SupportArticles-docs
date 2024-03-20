---
title: The status of a purchase order that comes from the Requisition Management module is automatically set to unapproved
description: Documents a problem that occurs when a purchase order is created in the Requisition Management module in Business Portal 2.5. Because the Business Portal user doesn't exist in Great Plains, the status of the purchase order is set to unapproved.
ms.reviewer: theley, kyouells, rolso
ms.topic: troubleshooting
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# The status of a purchase order that comes from the Requisition Management module is automatically set to unapproved

This article fixes an issue that occurs when a purchase order is created in the Requisition Management module in Business Portal 2.5.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887123

## Symptoms

In Microsoft Great Plains 8.0, the status of a purchase order that's generated in the Business Portal 2.5 Requisition Management module is automatically set to unapproved. This problem affects customers who use the Purchase Order Enhancement module with approvals.

## Cause

Great Plains is set up to use the Purchase Order Approvals part of the Purchase Order Enhancements module. The Business Portal 2.5 Requisition Management module uses a different approval hierarchy. When a purchase order is created from a requisition in Business Portal, the purchase order comes to Great Plains with a status of unapproved. The POP10100 purchase order header table assigns the Business Portal user as the creator of the purchase order. Because the Business Portal user doesn't exist in Great Plains, the status of the purchase order is automatically set to unapproved.

## Steps to reproduce the problem

1. Create a purchase request in Business Portal.
      1. Click **Employee** > **Purchase Requests**.
      2. Click **New Request**.
      3. Type a title in the Purchase Request Details Page page.
      4. Click **New Item** to add an item to your purchase request.
      5. On the Add Item page, type the correct information in the appropriate fields, and then click **Save and Close**.
      6. On the Purchase Request Details page, click **Submit** to send the purchase request to the approver.
2. Approve the requisition.
      1. Click **Manager** > **Purchase Requests**.
      2. Select the purchase request, and then click **Edit Request**.
      3. Click **Approve** > **OK**.
3. Transfer the purchase request to Great Plains so that you can create a purchase order.
      1. Click **Purchasing** > **Requisitions**.
      2. In the **Filter By** list, select the vendor for this purchase request.
      3. Select the item or items that you want to transfer to Great Plains.
      4. Click **Create**.
4. In Great Plains, click **Transaction**, select **Purchasing**, and then click **Purchase Order Entry**.
5. Select the purchase order that you created.
6. The purchase order uses the Business Portal user, and the status is set to unapproved.

> [!NOTE]
> The purchase order from Business Portal should be set to approved because the purchase request already went through the approval process in the Requisition Management module.
