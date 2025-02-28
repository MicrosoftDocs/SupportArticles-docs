---
title: Refundable charges are miscalculated based on the quantity returned in Dynamics 365 Commerce
description: Resolves an issue where cashiers see incorrect refundable charges in point of sale (POS) for the quantity of items returned in Microsoft Dynamics 365 Commerce.
author: josaw1 
ms.author: josaw
ms.reviewer: brstor
ms.date: 09/08/2023
ms.custom: sap:Payments\Issues with refund transactions
---
# Refundable charges are miscalculated based on the quantity returned

This article provides a resolution for an issue where cashiers see incorrect refundable charges in point of sale (POS) for the quantity of items that are returned in Microsoft Dynamics 365 Commerce.

## Symptoms

A customer returns a partial quantity of the items that were purchased for a sales order that has line-level refundable charges. However, instead of showing a partial refund, POS shows all charges as refundable.

For example, a customer purchases five items at $5 per item for a total charge of $25. The customer then returns three of the five items. However, the cashier is shown a $25 refundable charge in POS, instead of the expected $15 refundable charge for the three items that were returned.

## Resolution

To solve this issue, turn on the **Enable refunding charges based on the refunded quantity** feature.

As of Microsoft Dynamics 365 Commerce version 10.0.26, the **Enable refunding charges based on the refunded quantity** feature enables line-level refundable charges to be calculated based on the quantity of items that are returned.

To enable the **Enable refunding charges based on the refunded quantity** feature in Commerce headquarters, follow these steps:

1. Navigate to **System administrator** > **Workspaces**> **Feature management** to open the **Feature management** workspace.
1. In the list of available features, search for and select the **Enable refunding charges based on the refunded quantity** feature.
1. In the right pane, select **Enable now**.
