---
title: Fail to void a sales order in Microsoft Dynamics GP
description: Describes a behavior that occurs because a manufacturing order is linked to an item on a sales order. A resolution is provided.
ms.topic: troubleshooting
ms.reviewer: beckyber, aeckman
ms.date: 03/13/2024
---
# Error message when you try to void a sales order in Microsoft Dynamics GP: You cannot void this sales order because manufacturing orders are attached to one or more line items

This article provides a solution to an error that occurs when you try to void a sales order in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 927331

## Symptoms

When you try to void a sales order in the Sales Transaction Entry window in Microsoft Dynamics GP, you receive the following error message:

> You cannot void this sales order because manufacturing orders are attached to one or more line items.

## Cause

This behavior occurs because a manufacturing order is linked to an item on the sales order. A sales order cannot be voided in this situation.

To resolve this behavior, use one of the following methods.

## Resolution 1: You want to keep the manufacturing orders

To void the sales order, remove the link between the manufacturing order and the item on the sales order. To do this, follow these steps:

1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transaction Entry**.
2. In the **Document No.** field, type the sales order document number that you want to void.
3. Click an item number.
4. On the **Extras** menu, point to **Additional**, and then click **Manufacturing Sales Item Detail**.
5. Note any manufacturing order numbers that are listed.
6. Repeat steps 3 through 5 for each item on the sales order.
7. On the **Transactions** menu, point to **Manufacturing**, point to **Manufacturing Orders**, and then click **MOP/SOP Xref**.
8. In the **Manufacturing Order** list, click the manufacturing order that you noted in step 5.
9. Click the sales order, and then click **Remove**.
10. Repeat steps 8 through 9 for each manufacturing order that you noted in step 5.
11. On the **Transactions** menu, point to **Sales**, and then click **Sales Transaction Entry**.
12. In the **Document No.** field, type the sales order document number that you want to void, and then click **Void**.

## Resolution 2: You do not want to keep the manufacturing orders

If you do not want to keep the manufacturing orders to which the items on the sales order are linked, you can use the Manufacturing Order Entry window to change the status of the manufacturing order to canceled.

To do this, point to **Manufacturing** on the **Transactions** menu, point to **Manufacturing Orders**, and then click **Entry**. In the **MO Status** list for the manufacturing order that you do not want to keep, click **Canceled**, and then click **Save**.
