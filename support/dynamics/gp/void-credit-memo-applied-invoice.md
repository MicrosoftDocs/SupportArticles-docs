---
title: Void a credit memo is applied incorrectly to an invoice
description: This article describes how to correct a situation where a credit memo is applied incorrectly to an invoice in Payables Management in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 02/16/2024
---
# Void a credit memo that is applied incorrectly to an invoice in Payables Management in Microsoft Dynamics GP

This article describes how to correct a situation where a credit memo is applied incorrectly to an invoice in Payables Management in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 953223

## Introduction

Sometimes credit memos are applied incorrectly to an invoice. This can occur manually when you apply a credit memo to a specific invoice, and then discover that the credit memo should have been applied to a different invoice. This can also occur automatically when you perform a check run with the option to automatically apply existing unapplied credit memos. In addition, frequently users incorrectly assume that when a check is voided, the credit memos are automatically unapplied.

## A credit memo is fully applied to a single invoice or to multiple invoices

1. On the **Transactions** menu, point to **Purchasing**, and then click **Void Historical Transactions**.

2. In the Void Historical Payables Transactions window, click to select the **Void** check box for the credit memo that you want to void.

3. Click **Void**.

4. 4.When you are prompted to print posting journals, select the appropriate destination, and then click **OK**.

5. Close the Void Historical Payables Transactions window.

## A credit memo is partially applied to a single invoice or to multiple invoices

1. Create a dummy invoice for the amount remaining on the apply document. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then click **Transaction Entry**.

    2. In the Payables Transaction Entry window, create an invoice for the vendor with the credit memo that you want to void. Enter a value in the **Purchases** field for the amount remaining on the credit memo, and then leave the **Batch ID** field blank.

    3. Click **Post**.

    4. Close the Payables Transaction Entry window. When you are prompted to print posting journals, select the appropriate destination, and then click **OK**.

2. Apply the dummy invoice to the credit memo. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then click **Apply Payables Documents**.

    2. In the **Vendor ID** list, click the vendor with the dummy invoice.

    3. In the **Document No.** list, click the appropriate credit memo.

    4. Click to select the apply check box that is next to the dummy invoice that you created.

    5. Click **OK**.

3. Void the credit memo. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then click **Void Historical Transactions**.
  
    2. In the Void Historical Payables Transactions window, click to select the **Void** check box for the credit memo that you want to void.

    3. Click **Void**.

    4. When you are prompted to print posting journals, select the appropriate destination, and then click **OK**.

    5. Close the **Void Historical Payables Transactions** window.

4. Void the dummy invoice. To do this, follow these steps:

    1. On the **Transactions** menu, point to **Purchasing**, and then click **Void Open Transactions**.

    2. In the **Vendor ID** list, click the vendor with the invoice that you want to void.

    3. Click to select the **Void** check box for the dummy invoice that you want to void.

    4. Click **Void**.

    5. When you are prompted to print posting journals, select the appropriate destination, and then click **OK**.

    6. Close the **Void Open Payables Transactions** window.

5. Remove the dummy invoice from the history tables (optional). To do this, follow these steps:

   1. Follow the appropriate step:

      - In Microsoft Dynamics GP, on the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Utilities**, point to **Purchasing**, and then click **Remove Transaction History**.

   2. In the **Ranges** list, click **Voucher Number** or **Document Number** to create a restriction for the specific dummy invoice.

   3. In the **From** field and the **To** field, type the voucher number or document number for the dummy invoice.

   4. Click to select the following check boxes in the **Remove** section:

      - **Transactions**  
      - **Distributions**  

   5. Click to select the **Report** check box, and then click **Process**.

   6. When you are prompted to print the report, select the appropriate destination, and then click **OK**.

   7. Close the **Remove Payables Transaction History** window.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]

[!INCLUDE [Rapid publishing disclaimer](../../includes/rapid-publishing-disclaimer.md)]
