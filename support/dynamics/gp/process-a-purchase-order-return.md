---
title: Process a purchase order return
description: Describes how to process a purchase order return in which the original supplier's invoice is paid by a credit card vendor.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# How to process a purchase order return in which the original supplier's invoice is paid by a credit card vendor

This article describes how to process a purchase order return in which the original supplier's invoice is paid by a credit card vendor.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 933644

## Step 1: Process the return by using credit in Purchase Order Processing

1. Process the return as you typically do in Purchase Order Processing in Microsoft Dynamics GP. To do it, select **Transactions**, point to **Purchasing**, and then select **Returns Transaction Entry**.
2. In the **Type** list, select **Return w/Credit**.
3. Enter the purchase order number, the receipt number, and the item number. Change the amount to the amount that is being returned. This step creates a credit memo in Payables Management in Microsoft Dynamics GP for the vendor from whom you purchased the items.

## Step 2: Void the first credit memo

To apply the credit to the correct vendor in Payables Management, void the credit memo that you created in step 3 in the [Step 1: Process the return by using credit in Purchase Order Processing](#step-1-process-the-return-by-using-credit-in-purchase-order-processing) section. To do it, follow these steps:

1. Select **Transactions**, point to **Purchasing**, and then select **Void Open Transactions**.
2. Select the vendor from whom you purchased the inventory items, and then select the credit memo that was created in step 3 in the [Step 1: Process the return by using credit in Purchase Order Processing](#step-1-process-the-return-by-using-credit-in-purchase-order-processing) section.
3. Select the **Void** check box next to the credit memo that you want to void, and then select **Void**.

## Step 3: Create a new credit memo for the credit card vendor

1. Select **Transactions**, point to **Purchasing**, and then select **Transaction Entry**.
2. In the **Document Type** list, select **Credit Memo**.
3. In the **Vendor ID** field, enter the credit card vendor ID.
4. In the **Doc. Date** field, enter the date.
5. If this transaction is to be saved and not immediately posted, enter a batch number in the **Batch ID** field.
6. In the **Credit Memos** field, type the credit amount.
7. In the **Document Number** field, type a document number.
8. If you want to immediately apply this credit, select **Apply**.
9. In the Apply Payables Documents window, locate the invoice that was created by the payment that was made by the credit card vendor. It's the payment that was made for the purchase of inventory items from the supplier.
10. Select **OK**.
11. Use one of the following steps:

    - If the transaction is in a batch that is to be posted later, select **Save**.
    - If the transaction is to be posted immediately, select **Post**.
    - If the transaction is in a batch that is to be posted immediately, select **Transactions**, point to **Purchasing**, and then select **Batches**. To locate the batch, select the lookup button, and then select **Post** to post the batch.
    - To apply the credit memo to the credit card vendor later, follow these steps:

        1. Select **Transactions**, point to **Purchasing**, and then select **Apply Payables Documents**.
        1. In the **Vendor ID** field, enter the vendor ID.
        1. In the **Document No.** field, enter the document number, or find the credit memo by using the left-arrow button or the right-arrow button.
        1. Find the invoice transaction, and then select the check box next to the credit memo that should be applied.
        1. Select **OK**.
