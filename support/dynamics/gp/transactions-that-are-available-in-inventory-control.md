---
title: Available transactions in Inventory Control
description: Description of the transactions that are available in Inventory Control in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# Description of the transactions that are available in Inventory Control in Microsoft Dynamics GP

The article describes the transactions that are available in Inventory Control in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865959

## The Item Transaction Entry window

The Item Transaction Entry window is used to create and to post Variance transactions and Adjustment transactions.

Variance transactions record changes to current inventory quantities when a physical count reveals a difference between the recorded quantity that is on hand and the actual quantity that is on hand. Variance transactions are posted to Inventory accounts and to Variance accounts.

Adjustment transactions record miscellaneous increases and decreases in quantities. Adjustment transactions are posted to Inventory accounts and to Inventory Offset accounts.

> [!NOTE]
> If you use Purchase Order Processing in Microsoft Dynamics GP, quantities are automatically updated in the inventory when shipments are posted. If you use Sales Order Processing in Microsoft Dynamics GP, quantities are also automatically updated in the inventory when invoices and returns are posted.

## The Item Transfer Entry window

The Item Transfer Entry window is used to enter transactions that record the following transfers:

- A transfer of inventory items from one quantity type to another quantity type
- A transfer of inventory items from one site to another site

If you have multiple sites, it is frequently necessary to transfer inventory to maintain an optimal quantity at all the sites.

To open the Item Transfer Entry window, point to **Inventory** on the **Transactions** menu, and then select **Transfer Entry**.

## Beginning quantities

Use the Inventory Batch Entry window and the Item Transaction Entry window to enter beginning quantities so that you can establish a starting point for your inventoried items. Before you enter an increase adjustment for your beginning quantities, make sure that the **Post to General Ledger** option is not selected in the Inventory Batch Entry window. Beginning balances are for your inventory records only. Beginning balances should not be distributed to the general ledger.

## Adjusting entries

Use the Item Transaction Entry window or the Item Transfer Entry window to make adjusting entries to correct quantity errors. An adjusting entry is a transaction that backs out a transaction that was posted incorrectly. Then, you can enter the new information correctly. To make an adjusting entry, you must know how the initial transaction was entered and posted. This includes dates, quantities, and the posting accounts that were debited and credited. For example, if you mistakenly posted a quantity of 8 when you should have posted a quantity of 10, you can enter an adjusting transaction to increase the amount by 2.
