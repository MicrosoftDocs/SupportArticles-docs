---
title: This document cannot be marked for voiding error when voiding a payables transaction
description: Explains a problem that occurs even though you have not applied a transaction or put the transaction on hold. Describes how to resolve this problem.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Payables Management
---
# "This document cannot be marked for voiding, It has been either partially applied or is on hold" error when voiding a payables transaction

This article provides a resolution for the issue that you can't void a payables transaction in the Void Open Payables Transactions window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 856474

## Symptoms

When you try to void a transaction in the Void Open Payables Transactions window in Microsoft Dynamics GP, you receive the following error message:

> This document cannot be marked for voiding, It has been either partially applied or is on hold.

This problem occurs even though the following conditions are true:

- You have not applied any payments to the transaction.
- The transaction is not on hold.

> [!NOTE]
>
> - To verify that no payments were applied to the transaction, follow these steps:
>    1. On the **Inquiry** menu, point to **Purchasing** and then select **Transaction by Document**.
>    2. Enter the document number.
>    3. No documents have been applied to this transactions if the Unapplied Amount for the document is the same as the Original Amount.
> - To verify that the transaction is not on hold, follow these steps:
>    1. Select the **Transactions** menu, point to **Purchasing** and then select **Holds**.
>    2. Select **Vendor ID**.
>    3. Find the transactions and verify if the checkbox is marked as **Hold** for this transaction.

## Resolution

> [!NOTE]
> Before you follow the instructions in this article, make sure that you have a current restorable backup copy of the database that you can restore if a problem occurs.

To resolve this problem, run the Check Links process. To do this, follow these steps:

1. Have all users exit Microsoft Dynamics GP.
2. Run the Check Links process. To do this, follow these steps:
   1. Use the appropriate method:
      - In Microsoft Dynamics GP 10.0 and later versions, point to **Maintenance** on the **Microsoft Dynamics GP** menu, and then select **Check Links**.
      - In Microsoft Dynamics GP 9.0 and earlier versions, point to **Maintenance** on the **File** menu, and then select **Check Links**.
   2. In the **Series** list, select **Purchasing**.
   3. Insert the following tables into the **Selected Tables** list:
      - **Payables History Logical Files**  
      - **Payables Transaction Logical File**  
   4. Select **OK**.
3. In the Void Open Payables Transactions window, try to void the transaction.

> [!NOTE]
> The third-party products that this article discusses are manufactured by companies that are independent of Microsoft. Microsoft makes no warranty, implied or otherwise, about the performance or reliability of these products.
