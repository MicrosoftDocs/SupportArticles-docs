---
title: Void or delete sales documents in Receivables Management
description: This article describes how to void or delete sales documents in Receivables Management and Sales Order Processing in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Receivables Management
---
# Void or delete sales documents in Receivables Management and Sales Order Processing in Microsoft Dynamics GP

This article describes how to void or delete sales documents in Receivables Management and Sales Order Processing in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 950706

## Introduction

This article describes how to void or delete saved and posted Receivables Management (RM) transactions and Sales Order Processing (SOP) transactions. It also describes which documents are voidable.

## More Information

There are two sections, one for saved sales documents and one for posted sales documents.

## Saved sales documents

- How to delete Receivables Management (RM) documents

    You can delete all saved RM documents. There is no option to void. To delete all saved RM documents, follow these steps:

    1. On the **Transactions** menu, point to **Sales**, and then click **Transaction Entry**.

    1. Select the document that you want to delete.

    1. Use the appropriate step:

       - In Microsoft Dynamics GP 10.0, click **Actions**, and then click **Delete**.

       - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, click **Delete**.

- How to void Sales Order Processing (SOP) documents

  When you post a sales invoice, the document is posted to the Sales Order Processing history tables. You can void the following unposted or saved SOP documents:

  - Quote
  - Order
  - Invoice
  - Return
  - Back Order

    To void these saved SOP documents, follow these steps:

    1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transaction Entry**.

    1. Select the document that you want to void.

    1. Use the appropriate step:

       - In Microsoft Dynamics GP 10.0, click **Actions**, and then click **Void**.

       - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, click **Void**.

## Posted sales documents

- How to void Receivables Management documents

  You can void the following posted Receivables Management documents:

  - Invoice
  - Debit Memo
  - Finance Charges
  - Service and Repairs
  - Credit on Account
  - Returns
  - Payments

  You can void both posted transactions that were created in Receivables Management and posted transactions that were created in Sales Order Processing.

  To void posted transactions that were created in Receivables Management, follow these steps:

    1. On the **Transactions** menu, point to **Sales**, and then click **Posted Transactions**.

    1. Enter the customer ID in the **Customer ID** field, select document type in the **Document Type** field, and then enter the document number in the Number field.

    1. Use the appropriate step:

       - In Microsoft Dynamics GP 10.0, click **Actions**, and then click **Void**.

       - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, click **Void**.

  When you try to void documents in Receivables Management that are originated in Sales Order Processing, you will receive the following message:

  > This transaction didn't originate in Receivables Management. Reversing entries will be made in Receivables Management and General Ledger only. Do you want to continue?

  To correctly reverse the effect of posting the Sales Order Processing invoice, follow these steps:

    1. Create a Return transaction in Sales Order Processing. To do this, follow these steps:

        1. On the **Transactions** menu, point to **Sales**, and then click **Sales Transaction Entry**.

        1. Use the appropriate step:

           - In Microsoft Dynamics GP 10.0, click **Create Return** on the **Additional** menu of the Sales Transaction Entry window.

           - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, point to **more** on the **Extras** menu, and then click **Create Return**.

             > [!NOTE]
             > Click OK if you receive an error message resembles the following:
             >
             > The RMA Type selected is invalid for this process.

        1. In the **Create Return** window, clear the **Create RMA** check box, and then click **OK**.

        1. Enter the required information to create a SOP Return transaction.

    1. Use the appropriate step:

       - In Microsoft Dynamics GP 10.0, click **Actions**, and then click **Post**.

       - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, click Post.

    1. Apply the Return transaction to the original invoice. To do this, follow these steps:

       1. On the **Transactions** menu, point to **Sales**, and then click Apply Sales Documents.

       1. Enter the customer ID in the **Customer ID** field, select **Returns** in the **Type** field, select the newly created return transaction in the **Document No.** field, and then select the invoice that you voided in Receivables Management.

       1. Click **OK**.

       This will reverse the effect of posting to General Ledger, Inventory (if registered), and Receivables Management.

- How to handle Sales Order Processing documents

  When an invoice has been posted, it cannot be voided in Sales Order Processing. The return is the recommended way to reverse an invoice that has been created in error.

    1. Create an SOP Return in SOP. To do this, follow these steps:

        1. On the Transactions menu, point to Sales, and then click Sales Transaction Entry.

        1. Use the appropriate step:

           - In Microsoft Dynamics GP 10.0, click **Create Return** on the **Additional** menu of the **Sales Transaction Entry** window.

           - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, point to **more** on the **Extras** menu, and then click **Create Return**.

                > [!NOTE]
                > Click **OK** if you receive an error message resembles the following:
                >
                > The RMA Type selected is invalid for this process.

        1. In the **Create Return** window, clear the **Create RMA** check box, and then click **OK**.

        1. Enter the required information to create a SOP Return transaction.

    1. Select Return in the **Type/Type ID** field, select the sales invoice document number in the Document No. field, and then select the customer ID in the **Customer ID** field.

    1. Set the items to return.

    1. Use the appropriate step:

        - In Microsoft Dynamics GP 10.0, click **Actions**, and then click **Post**.

        - In Microsoft Dynamics GP 9.0 or Microsoft Business Solution – Great Plains 8.0, click **Post**.

    1. Post the return or save it to a batch.

    1. Apply the Return transaction to the RM invoice. To do this, follow these steps:

        1. On the **Transactions** menu, point to **Sales**, and then click **Apply Sales Document**.

        1. Enter the customer ID in the **Customer ID** field, select **Returns** in the **Type/Type ID** field, select the newly created return transaction in the **Document No.** field, and then select the invoice that you voided in Receivables Management.

        1. Click **OK**. This will zero out the amount remaining for the Invoice.

    > [!NOTE]
    > This process will increase inventory, an SLSTE batch will be created in General Ledger and a return will be created in RM which was applied in step 7.

[!INCLUDE [Publishing disclaimer](../../includes/publishing-disclaimer.md)]
