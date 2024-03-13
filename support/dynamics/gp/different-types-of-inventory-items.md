---
title: Different types of inventory items in Microsoft Dynamics GP
description: Information about the different types of inventory items in Microsoft Dynamics GP.
ms.reviewer:
ms.date: 03/13/2024
---
# Information about the different types of inventory items in Microsoft Dynamics GP

This article discusses the different types of inventory items that are available in Inventory Control in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. Additionally, the article describes which accounts inventory items use when they are posted. To view the item type, point to **Inventory** on the **Cards** menu, and then click **Item**.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 871642

The different types of inventory items are as follows.

## Sales Inventory

- Quantities can be tracked. Both increase and decrease adjustments can be entered.
- Transaction amounts will post to both inventory and inventory offset accounts in the Item Maintenance window.

> [!NOTE]
> To open the Item Maintenance window, point to **Inventory** on the **Cards** menu, and then click **Item**. Then, click **Accounts** to open the Item Account Maintenance window.

## Discontinued

Transaction amounts will post to Inventory and Inventory Offset accounts in the Item Account Maintenance window.

## Miscellaneous

- Quantities and current costs are not tracked. For example, labor or inventory freight expense is not tracked.
- Transaction amounts will post to Sales and Cash/Accounts Receivables accounts.

## Kit

- Items that consist of the component items are grouped together at the time of sales. Component items can be services, sales inventory, discontinued, miscellaneous, and flat-fee items. Amounts are posted to the accounts that are specified for each component item in each kit.

- Quantities are maintained for components. However, quantities are not maintained for the kit.

## Services

- Current cost and quantities will not be tracked.
- They can be sold individually or as kits.
- Transaction amounts will post to Sales and Cash/Accounts Receivables Accounts.

## Flat Fee

- Current cost and quantities will not be tracked.
- They can be sold individually or as kits.
- Transaction amounts will post to Sales and Cash/Accounts Receivables Accounts.

## References

For more information about where each account comes from, see [Usage of Posting Accounts for Invoicing and Sales Order Processing](https://support.microsoft.com/topic/usage-of-posting-accounts-for-invoicing-and-sales-order-processing-87ccdd21-98d8-4079-a77a-704124473763).
