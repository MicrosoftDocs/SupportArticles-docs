---
title: Void transactions in Payables Management
description: Describes how to void Payables Management transactions in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains.
ms.reviewer: lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to void transactions in Payables Management in Microsoft Dynamics GP

This article describes how to void Payables Management transactions in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0. Additionally, the article describes which transactions can be voided.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 858373

## Introduction

The following transactions can be voided in Microsoft Dynamics GP:

- Credit Memos
- Payments
- Returns

> [!NOTE]
> Transactions in the open tables and in the history tables can be voided.

## Documents that are in the open tables

Invoices and credit memos can be voided if they're unapplied. To void a document that is in the open tables, use the Void Open Payables Transaction window. To do it, select **Transactions**, point to **Purchasing**, and then select **Void Open Transactions**.

After you void a credit document, the debit document that was applied to the credit document becomes unapplied. Then, you can apply the debit document to another document. If the vendor of the transaction that you want to void is on hold, you can void the transaction. The hold limitation applies to documents on hold.

## Documents that are fully applied and in the history tables

To void a document that is in the history tables, use the Void Historical Payables Transactions window. To do it, select **Transactions**, point to **Purchasing**, and then select **Void Historical Transactions**.

## Documents that are partially applied or on hold

To void a transaction that is partially applied or on hold, follow these steps if the specified condition is true.

### Condition 1: The transaction to void is a credit document (payments or credit memos) that is partially applied

1. Create a new (dummy) invoice for the amount remaining of the partially applied document.

    > [!NOTE]
    > This new invoice will be voided at the end of this process. It's necessary because you can't void a credit document unless it's in the History status, which means that it's fully applied.

    To do it, follow these steps:

      1. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**.
      2. In the Payables Transaction Entry window, enter an invoice for the vendor with the partially applied document that you want to void, and then enter an amount for the invoice that is equal to the amount remaining of the document that you want to void.
      3. Select **Post**, and then close the window.
      4. Specify the report destination, and then print the posting journals.

2. Apply the new invoice to the partially applied document.

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Apply Payables Documents**.
    2. In the Apply Payables Documents window, enter the vendor ID in the **Vendor ID** box, and then enter the document number of the partially applied document that you want to void in the **Document No** box.
    3. Select the new invoice to apply the amount remaining of the partially applied document, and then select **OK**.

3. Void the partially applied document.

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Historical Transactions**.
    2. In the Void Historical Transactions window, select the partially applied document that you want to void, and then select the **Void** check box.
    3. Select **Void**, and then close the window.
    4. Specify the report destination, and then print the posting journals.

4. Void the new invoice that you created in step 1.

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Open Transactions**.
    2. In the Void Open Transactions window, enter the vendor ID in the **Vendor ID** box.
    3. Select the new invoice, and then select the **Void** check box.
    4. Select **Void**.
    5. Specify the report destination, and then print the posting journals.

5. Verify your general ledger transactions if you have to post the adjustments, or delete the general ledger transactions if they're in a batch. If you post the general ledger transactions, you won't lose the drill back capability.

> [!NOTE]
> The initial invoice that contains the voided partially applied document is left with the Open status. So you can void the new invoice that you created in step 1.

### Condition 2: The transaction to void is an invoice that is partially applied

1. Void the credit document that is applied to the invoice.

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Historical Transactions**.
    2. Select the partially applied document that is applied to the partially applied invoice, and then select the **Void** check box.
    3. Select **Void**.
    4. Specify the report destination, and then print the posting journals.

    > [!NOTE]
    > If the credit document that is applied to the invoice is also partially applied, follow the steps for condition 1 to void the partially applied document.

2. Void the invoice.

    1. On the **Transactions** menu, point to **Purchasing**, and then select **Void Open Transactions**.
    2. In the **Vendor ID** box, enter the vendor ID.
    3. Select the additional invoice, and then select the **Void** check box.
    4. Select **Void**.
    5. Specify the report destination, and then print the posting journals.

3. Verify your general ledger transactions if you have to post the adjustments, or delete the general ledger transactions if they are in a batch. If you post the general ledger transactions, you won't lose the drill back capability.
