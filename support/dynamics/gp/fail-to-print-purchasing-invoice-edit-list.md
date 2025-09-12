---
title: Error when you print the Purchasing Invoice Edit list in Purchase Order Processing in Microsoft Dynamics GP 
description: Provides a solution to an error that occurs when you print the Purchasing Invoice Edit list in Purchase Order Processing in Microsoft Dynamics GP.
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.reviewer: theley
ms.custom: sap:Distribution - Purchase Order Processing
---
# Error message when you print the Purchasing Invoice Edit list in Purchase Order Processing in Microsoft Dynamics GP: "Line Items Are Not Fully Matched"

This article provides a solution to an error that occurs when you print the Purchasing Invoice Edit list in Purchase Order Processing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 864370

## Symptoms

When you print the Purchasing Invoice Edit list in Purchase Order Processing in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains, you receive the following error message:

> Line items are not fully matched.

## Cause

This problem occurs because you can invoice only a quantity that is equal to or less than what has already been entered and posted on a shipment. For example, a purchase order that has a quantity of 10 is entered for an item. Then, a shipment is entered for 7 of the 10 items that were ordered. When an invoice is entered to match to the shipment, only 7 or fewer items can be invoiced. If an invoice is entered for 8 or more items, you receive the error message that is mentioned in the "Symptoms" section.

## Resolution

To resolve this problem, follow these steps:

1. On the **Transactions** menu, point to **Purchasing**, and then click **Enter/Match Invoices**.
2. Click **Show Detail** to view the line information.

    > [!NOTE]
    > A warning icon is displayed in the **Matched to Shipment** field. The warning icon means that the number that you have in the **Quantity Invoiced** field is larger than the number in the **Invoice Quantity to Match** field.
3. Click the lookup button next to the **Matched to Shipment** field to open the **Match Shipments to Invoice** window.
4. The quantity in the **Match Shipments to Invoice** window is the quantity that is available to invoice. This quantity must be equal to or larger than the number in the Purchasing Invoice Entry window.
