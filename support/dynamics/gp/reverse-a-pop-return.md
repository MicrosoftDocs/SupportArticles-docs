---
title: Reverse a POP Return
description: Provides a solution to an issue where a POP Return was entered and posted in error or was entered and posted with the incorrect quantities or price.
ms.reviewer: Beckyber
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How to reverse a POP Return in Microsoft Dynamics GP

This article provides a solution to an issue where a POP Return was entered and posted in error or was entered and posted with the incorrect quantities or price.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2730001

## Symptoms

A POP Return was entered and posted in error or was entered and posted with the incorrect quantities or price.

## Cause

A POP Return was entered and posted in error or was entered and posted with the incorrect quantities or price.

## Resolution

Currently in Microsoft Dynamics GP there is no way to void a return document generated in Purchase Order Processing. To reverse a POP return, you may follow the steps below.

1. Enter a transaction to bring the quantities back into inventory using one of the following options:

    1. Create a new Shipment without a purchase order for the same quantity you returned using the Receivings Transaction Entry window. To get to this window select **Transactions**, then **Purchasing**, and then **Receivings Transaction Entry**.

    1. Create an Inventory increase adjustment for the quantity you returned using the Item Transaction Entry window. To get to this window select **Transactions**, then **Inventory**, and then **Transaction Entry**.

2. Correct the Payables Management module if the PO Return was done as a Return with Credit type:

    1. If the Payables Management document is open, use the Void Open Payables Transaction window, select **Transactions**, then **Purchasing**, then **Void Open Transactions** to void it.

    1. If the Payables Management document has been fully applied and moved to history, use the Void Historical Payables Transactions window, select **Transactions**, then **Purchasing**, then **Void Historical Transactions** to void it.

3. Remove the POP Return from history:

    1. Navigate to the **Remove Purchasing History** window by going to Microsoft Dynamics GP, select on **Tools**, select on **Utilities**, then select **Purchasing**, and finally **Remove Purchasing History**.
    1. Select **Receipt** under **History Type**.
    1. Mark **Include Account Distributions** check box.
    1. Under **Options**, mark **Remove History** and then mark the **Print Report** check box.
    1. Enter the return number in the Receipt Number From and To fields.
    1. Select **Process** and print the report.
