---
title: How to determine what cost is used for an inventory item in Microsoft Dynamics GP
description: How to determine what cost is used for an inventory item in Microsoft Dynamics GP.
ms.topic: how-to
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Distribution - Inventory
---
# How to determine what cost is used for an inventory item in Microsoft Dynamics GP

This article discusses what cost is used when you sell an inventory item in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 866289

## For perpetual valuation methods

When you sell an item by using a perpetual valuation method, the cost value for each quantity that is sold comes from the appropriate purchase receipts layer in the Inventory module. You can view the purchase receipts layers in the Purchase Receipts Inquiry window.

To open the Purchase Receipts Inquiry window, point to **Inventory** on the **Inquiry** menu, and then click **Receipts**.

## For periodic valuation methods

When you sell an item by using a periodic valuation method, the cost for each quantity that is sold is the value that is displayed in the **Standard Cost** field in the Item Maintenance window.

## For average perpetual valuation methods

- Microsoft Dynamics GP 10.0 and Microsoft Dynamics GP 9.0

    When you sell an item by using an average perpetual valuation method, the current cost amount appears on the transaction. However, this cost may not be the cost that is used at the time of posting. At the time of posting, the system takes the quantities from the first available receipt layer. The cost that is used is pulled from the layer that has the closest date to the transaction.

- Microsoft Business Solutions - Great Plains 8.0

    When you sell an item by using an average perpetual valuation method, the cost for each quantity that is sold is the value that is displayed in the **Current Cost** field in the Item Maintenance window.
