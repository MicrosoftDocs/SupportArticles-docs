---
title: Refund a payment to a customer
description: Describes how to refund a payment to a customer without using the Refund Checks module in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: dbader
ms.topic: how-to
ms.date: 03/13/2024
---
# How to refund a payment to a customer without using the Refund Checks module in Microsoft Dynamics GP

This article describes how to manually return a credit amount to a customer by using Receivables Management and Payables Management in Microsoft Dynamics GP and Microsoft Business Solutions - Great Plains 8.0.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 954626

## Introduction

Follow these steps when the Refund Checks module isn't registered. Refund Check is a module that is purchased separately that lets you issue refund checks to customers.

## More Information

1. Determine the value of the credit for which you want to create a refund:
    1. On the **Inquiry** menu, point to **Sales**, and then select **Transaction By Customers**.
    2. Select the customer ID with a credit balance in the **Customer ID** list.
    3. Note the value of the credit document, and then select **OK**.

2. Create and post a debit memo equal to the amount you want to refund the customer:

    1. On the **Transactions** menu, point to **Sales**, and then select **Transaction Entry**.
    2. In the **Document Type** list, select **Debit Memos**.
    3. In the **Customer ID** list, select the appropriate customer ID.
    4. Create a debit memo using the value that you noted in step 1.
    5. Select **Post** to post the debit memo.

3. Apply the debit memo to the overpaid amount:
    1. On the **Transactions** menu, point to **Sales**, and then select **Apply Sales Documents**.
    2. In the **Customer ID** list, select the appropriate customer ID.
    3. In the **Document No.** list, select the credit document from step 1.
    4. Select the check box next to the debit memo you created in step 2.
    5. Select **OK.**  

4. Create a vendor ID. If a vendor ID already exists for this customer, go to step 5.

    1. On the **Cards** menu, point to **Purchasing**, and then select **Vendor**.
    2. Create a vendor ID that corresponds to the customer ID.
    3. Select **Save**.

5. Enter and post a miscellaneous charge for the vendor:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.
    2. In the **Document Type** list, select **Misc Charge**.
    3. In the **Vendor ID** list, select the vendor ID that corresponds to the customer ID.
    4. Create a document that has the value that you want to refund to the customer.
    5. Select **Post** to post the miscellaneous charge document.

6. Print a check in Payables Management and apply it to the miscellaneous Charge document:

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Edit Check**.
    2. In the **Vendor ID** list, select the vendor ID that corresponds to the customer ID.
    3. In the **Batch ID** field, type the name of the batch that will contain the check.
    4. Select **Apply**.
    5. In the Apply Payables Documents window, select the check box next to the miscellaneous charge document from step 5, and then select **OK**.
    6. In the Edit Payables Checks window, select **Print Checks**. When you are prompted to save changes, select **Save**.
    7. Select **Print** to print the check.
    8. In the Post Payables Checks window, select **Process**. When you are prompted, select a destination for the posting journal reports.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
