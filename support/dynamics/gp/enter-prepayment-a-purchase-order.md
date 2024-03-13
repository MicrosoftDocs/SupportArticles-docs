---
title: Enter a prepayment for a purchase order
description: Describes how to enter a prepayment for a purchase order that isn't yet an invoice in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to enter a prepayment for a purchase order that isn't yet an invoice in Payables Management in Microsoft Dynamics GP

This article describes how to enter a prepayment for a purchase order that isn't yet an invoice in Payables Management in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856772

## Steps to enter a prepayment

To enter a prepayment for a purchase order that isn't yet an invoice in Payables Management, follow these steps:

1. After a purchase order is entered in Purchase Order Processing, use the Edit Payables Checks window to enter a prepayment so that a check can be printed. To do it, follow these steps:

    1. Open the Edit Payables Checks window. To do it, point to **Purchasing** on the **Transactions** menu, and then select **Edit Check**.
    1. In the **Batch ID** field, type a batch ID.
    1. In the **Vendor ID** list, select the vendor ID on the purchase order.
    1. In the **Unapplied** field, enter the prepayment amount.
    1. Save the batch, and then print the checks. To do it, point to **Purchasing** on the **Transactions** menu, and then select **Print Checks**.

2. After the purchase order is received and invoiced in Purchase Order Processing, use the Apply Payables Documents window to apply the prepayment to the invoice. To do it, follow these steps:

    1. Open the Apply Payables Documents window. To do it, point to **Purchasing** on the **Transactions** menu, and then select **Apply Payables Documents**.
    1. In the **Vendor ID** list, select the appropriate vendor ID.
    1. In the **Document No** list, select the appropriate document number.
    1. In the **Apply Posting Date** field, type the posting date for the General Ledger module.
    1. Select the check box next to the invoice to which you want the document to apply.
    1. Select **OK**.

3. After the prepayment is applied to the invoice, use the Select Payables Checks window to select the checks for the remaining amount in the invoice. To do it, follow these steps:

    1. Open the Select Payables Checks window. To do it, point to **Purchasing** on the **Transactions** menu, and then select **Select Checks**.
    1. In the **Batch ID** list, type a new batch ID.
    1. In the **Origin** field, select **Computer Check**.
    1. In the **Frequency** list, select **Single Use**.
    1. In the **Checkbook ID** list, select a checkbook ID to use for all the checks in the batch.
    1. Select **Transactions**.
    1. In the Go To window, select **Select Payables Checks**, and then select **Go To**.
    1. In the **Select Vendor by** area, select **All**, or enter a range of vendors to pay.
    1. In the **Select Document by** area, select **All**, or enter a range of documents to pay.
    1. In the **Due Date Cutoff** area, select **None** or **Due Date**.
    1. In the **Select Documents** list, select the appropriate option.
    1. Make the appropriate selections in the **Automatically Apply Existing Unapplied** area and in the **Remittance** area.
    1. Select **Build Batch** to create the batch of checks to process.
