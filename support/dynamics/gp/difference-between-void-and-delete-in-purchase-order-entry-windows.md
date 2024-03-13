---
title: Difference between void and delete in the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP
description: Describes information about the difference between void and delete in the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP.
ms.reviewer:
ms.date: 03/13/2024
---
# Information about the difference between void and delete in the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP

This article discusses the difference between void and delete in the Purchase Order Entry window in Purchase Order Processing in Microsoft Dynamics GP. To open the Purchase Order Entry window, click **Transactions**, point to **Purchasing**, and then click **Purchase Order Entry**.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874059

You can void a purchase order only if it has a status of New. If you keep purchase order history, the purchase order will be transferred to history. If you do not keep purchase order history, the purchase order will be removed from Microsoft Dynamics GP.

You cannot void purchase orders that have sales document commitments. If the purchase order is on hold, you cannot void the purchase order unless you have enabled the **Allow Editing of Purchase Orders on Hold** option in the Purchase Order Processing Setup window. To open the Purchase Order Setup window, follow the appropriate step:

- In Microsoft Dynamics GP 10.0 and later versions, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Purchasing**, and then click **Purchase Order Processing**.

- In Microsoft Dynamics GP 9.0, point to **Setup** on the **Tools** menu, point to **Purchasing**, and then click **Purchase Order Processing**.

If you keep purchase order history and if you want to remove a purchase order that has a Released status or a Change Order status, close or cancel the purchase order in the Edit Purchase Order Status window. To access this window, click **Transactions**, point to **Purchasing**, and then click **Edit Purchase Orders**.

If you delete a purchase order, it will be removed from Microsoft Dynamics GP and will not be transferred to history. If a purchase order has sales document commitments, you must remove the commitments before you can delete the purchase order. If the purchase order is on hold, you must remove the hold before you can delete the purchase order. The DELETE button will be disabled for purchase orders that have a status of Released or of Change Order. The DELETE button will also be disabled for purchase orders that have a status of New if there are unposted receipts or invoices.
