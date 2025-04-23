---
title: Inventory value doesn't match inventory balance in Microsoft Dynamics GP
description: Discusses why the inventory value does not match the inventory balance in the general ledger when you use the LIFO/FIFO Perpetual valuation method in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Distribution - Inventory
---
# Issue where inventory value does not match the inventory balance in Microsoft Dynamics GP

This article describes reasons why the inventory value on the Purchase Receipts Report does not match the Inventory balance in the general ledger in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861686

The following assumptions are made in this article:

- The Inventory items use the FIFO valuation method or the LIFO Perpetual valuation method. The Average Perpetual valuation method or the FIFO/LIFO Periodic valuation method will cause an out-of-balance condition between the general ledger and the inventory.

- The Purchase Receipts report must be printed for all items, for all sites, and for all quantity types. The Stock Status inventory value on the Stock Status report only includes On Hand items and does not include any quantities in the Damaged status, in the In Use status, in the In Service status, or in the Returned status. The Purchase Receipts report includes all quantity types.

The following are some reasons why inventory can become out of balance with the general ledger:

- Adjustments to inventory were entered directly into the general ledger and were not reflected in Inventory in Microsoft Dynamics GP.

- An Increase Adjustment batch was posted in Inventory, but the **Post to GL** check box was not selected on the batch. When the batch was posted, it did not post to the general ledger.

- A Decrease Adjustment batch was posted in Inventory, but the **Post to GL** check box was not selected on the batch. When the batch was posted, it did not post to the general ledger.

- An Increase or Decrease Adjustment batch was posted in Inventory. The **Post to GL** check box was selected on the batch. However, the batch has not yet been posted through to the general ledger.

- In Microsoft Business Solutions - Great Plains 8.0, Inventory Adjust Costs were created in the Inventory Adjust Cost utility and the manual adjustment for Inventory/Cost of Goods sold was not created in the general ledger.

    > [!NOTE]
    > in Microsoft Dynamics GP 10.0 and in Microsoft Dynamics GP 9.0, an automatic adjustment for Inventory/Cost of Goods sold is created during the Adjust Cost process.

- An override existed for an item. An Increase adjustment in Inventory was entered. A cost difference existed between the original sale and the new shipment. The cost variance was not manually posted to the general ledger.

- An override of a Serial Type item in Sales Order Processing or in Invoicing was entered. A new Serial Number was added automatically. Then, the transaction was posted. This will not create a Purchase Receipt in Inventory or update the general ledger with the inventory shipment.

- An override of a Lot Type item in Sales Order Processing or in Invoicing was entered. A new lot number was added automatically. Then, the transaction was posted. This will not create a Purchase Receipt in Inventory or update the general ledger with the inventory shipment.

> [!NOTE]
> If you have multiple inventory accounts in the general ledger, you must total all these accounts.
