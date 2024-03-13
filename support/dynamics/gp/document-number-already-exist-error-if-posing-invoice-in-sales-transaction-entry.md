---
title: This document number already exists error when selecting invoices
description: When you try to select an invoice in the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP, you receive an error that states the document number already exists. 
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "This document number already exists" error when selecting an invoice in the Sales Transaction Entry window

This article provides a resolution for the issue that you can't select an invoice in the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 865449

## Symptoms

When you try to select an invoice in the Sales Transaction Entry window in Sales Order Processing in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains, you receive the following error message:

> This document number already exists.

## Cause

This problem may occur if the network connection is closed when you post a sales invoice.

## Resolution

To resolve this problem, follow these steps:

1. On the **Inquiry** menu, point to **Sales**, and then select **Sales Documents**.
2. To determine whether the same document also appears in history, select **Unposted**, select the document that you entered, and then select **History**.

3. If the transaction appears in unposted and in history, make sure that the transaction is posted in the general ledger. If the transaction was posted correctly in the general ledger, continue to step 4. If the transaction was not posted correctly in the general ledger, go to step 7.

4. On the **Transactions** menu, point to **Sales**, and then select **Sales Batches**.
5. Select the lookup button next to the **Batch ID** field, and then double-click the batch that the document is in.
6. Select **Delete**, and then select **Yes** when you are prompted to delete the batch.
7. Perform a complete backup of the database that you can restore if a problem occurs.
8. Make sure that all users log off from Microsoft Dynamics GP.
9. Use the appropriate step:

   - In Microsoft Dynamics GP 10.0 or Microsoft Dynamics GP 2010, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Utilities**, point to **Sales**, and then select **Remove Sales History**.
   - In Microsoft Dynamics GP 9.0 and in Microsoft Business Solutions - Great Plains 8.0, point to **Utilities** on the **Tools** menu, point to **Sales**, and then select **Remove Sales History**.

10. In the **Ranges** area, type the document number in the **From** field and in the **To** field.
11. Select **Insert** to insert the restriction, and then select **Process**. Select the **Screen** check box to print the report to the screen, and then select **OK**.
