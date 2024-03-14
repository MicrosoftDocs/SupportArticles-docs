---
title: Posting transactions for a stock count
description: Describes the effects of taking a snapshot of inventory when a stock count has been started in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/13/2024
ms.custom: sap:Distribution - Inventory
---
# Information about posting transactions for a stock count that has been started in Inventory in Microsoft Dynamics GP

This article describes the effects of taking a snapshot of inventory when a stock count has been started in Microsoft Dynamics GP. In addition, the article explains what transactions you can enter, and how counted quantities will take new transactions into consideration.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950020

## Introduction

When you select **Start Count** in the Stock Count Schedule window on a specific date, the system will take a "snapshot" of the inventory quantity as of that date and time. This snapshot stores the **Captured Qty** field in the Stock Count Entry window. The value in the **Captured Qty** field will then be reconciled with the manual inventory count done by the warehouse personnel for those items in the site that is entered in the **Counted Qty** field.

If you enter an amount in the **Counted Qty** field that differs from the captured quantity for an item-site combination, the Inventory module calculates the default variance amount as the absolute difference between the two values, as long as the resulting default variance transaction is a valid transaction. The default variance transaction might vary if it would otherwise cause an invalid transaction. That is, if posting the transaction would cause the on hand quantity to be less than the allocated quantity.

When a stock count is processed, the Inventory module creates default inventory variance transactions to adjust inventory for the variance amounts. It's helpful if the variance is a legitimate finding of differences between the captured and counted amounts. However, if a variance exists because of transactions that haven't been posted yet, or because transactions were posted after the stock count was started, then the default inventory variance transactions can cause extra discrepancies. We don't recommend posting extra transactions unless the stock count entry has already been posted.

The ability to restrict users from allocating and posting transactions for the stock count items by tracing the items in the stock count and by restricting the users from allocating or posting to this Item/Site combination isn't a feature that is available in Microsoft Dynamics GP. So every time that a variance amount is identified, you should check the unposted transactions and the transaction history for the item-site combination. If it's necessary, you can adjust the variance amount accordingly before processing the stock count.

If transactions are posted after the stock count is started, the **On Hand Quantity** field in the Stock Count Entry window will no longer equal the captured quantity. You may have to adjust the variance amount accordingly based on this field. In this case, use the Item Transaction Inquiry by Date window to view transaction history. You could find that another user has posted a transaction since the stock count was started, for example. Additionally, you can use the Unposted Item Transactions window to view unposted inventory transactions.

## More information

To verify variance amounts in the Inventory module, follow these steps:

1. Open the Stock Count Entry window. To do it, select **Transactions**, point to **Inventory**, and then select **Stock Count Entry**.

2. Type a stock count ID. The stock count must have a status of **Entered**.

3. Select an item-site combination that has a variance amount.

4. Select **Unposted Trx** and **Trx History** to determine the reason for the inventory variance. To view information about the quantities for specific transactions, select a document and then select **Document Number**.

5. If you find an unposted transaction or a transaction in inventory history that accounts for all or a part of the variance, select the variance amount for the item-site combination and change it as needed.

6. Select **Save**, and then close the windowTo view transaction history, select the **Trx History** button in the Stock Count Entry window to open the Item Transaction Inquiry by Date window. Information about transactions for the item-site combination posted after the stock count was started and before the stock count results were entered is displayed in the scrolling window. Review the information as needed. To view information about the quantities for specific transactions, select a document and then select the Document Number label.

[!INCLUDE [Publishing Disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
