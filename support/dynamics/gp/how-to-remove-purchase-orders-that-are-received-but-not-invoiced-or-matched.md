---
title: How to remove purchase orders that are received but not invoiced or matched from the Received Not Invoiced report
description: Describes how to remove purchase orders from the Received/Not Invoiced report in Purchase Order Processing in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Distribution - Purchase Order Processing
---
# How to remove purchase orders that have been received but not invoiced or matched from the "Received/Not Invoiced" report in Purchase Order Processing

This article describes how to remove purchase orders that have been received but not invoiced or matched from the Received/Not Invoiced report in Purchase Order Processing in Microsoft Dynamics GP. The invoices for these purchase orders are entered and then posted manually in Payables Management. The invoices don't have to be entered and then posted from the **Purchasing Invoice Entry** window.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 929212

## How to remove the purchase orders

To remove the purchase orders from the Received/Not Invoiced report, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then select **Edit Purchase Orders**.
2. In the **Edit Purchase Orders Status** window, select the purchase order that you want to remove in the **PO Number** list.
3. In the **Purchase Order Status** list, select **Closed**.
4. Repeat steps 1 through 3 for all the purchase orders that you want to remove from the Received/Not Invoiced report.

## How to move the purchase orders from the work tables to the history tables

If you want to move the closed purchase orders from the work tables to the history tables, run the Remove Completed Purchase Orders routine.

> [!NOTE]
> To avoid any data loss, you must back up the database and have all users log out of Microsoft Dynamics GP before you follow these steps:

1. On the **Microsoft Dynamics GP** menu, point to **Tools** > **Routines** > **Purchasing**, and then select **Remove Completed Purchase Orders**.
 
2. In the **Remove Completed Purchase Orders** window, select the range of purchase order numbers that you want to remove, and then select **Insert**.
3. Select **Process**.

## How to print the report

If you want to print the Received/Not Invoiced report, follow these steps:

1. On the **Reports** menu, point to **Purchasing**, and then select **Analysis**.
2. In the **Purchasing Analysis Reports** window, select **Received/Not Invoiced** in the **Reports** list.
