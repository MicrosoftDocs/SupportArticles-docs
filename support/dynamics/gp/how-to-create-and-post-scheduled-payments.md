---
title: How to create and post scheduled payments
description: Explains that when you post scheduled payments, they function like an invoice. They are displayed as open invoices that are waiting for payment.
ms.reviewer: theley, lmuelle
ms.topic: how-to
ms.date: 03/13/2024
---
# How to create and post scheduled payments in Microsoft Dynamics GP

This article describes how to create and to post scheduled payments in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains. The Payables Scheduled Payments Entry window lets you divide a large invoice into small ones, depending on the number of payments you want to make. When you post scheduled payments, they function like an invoice. They are displayed as open invoices that are waiting for payment.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860543

To create and post scheduled payments in Microsoft Dynamics GP, follow these steps:

1. Open the Payables Scheduled Payments Entry window. To do this, point to **Purchasing** on the **Transactions** menu, and then select **Scheduled Payments**.

2. In the Payables Scheduled Payments Entry window, specify the following fields:

   - **Original Document Number**: Select the invoice on which you want to make payments.
   - **Payables Offset**: Specify the payables offset account.

   - **Interest Expense**: Specify the interest expense offset account.
   - **Schedule Interest Rate**: Specify the interest rate.

   - **Number of Payments**: Enter the number of payments into which this schedule is to be divided.

3. Select **Calculate** to divide the original invoice amount into the number of payments that you want to make.
4. Select **Amortization** to verify the payment amounts and the due dates.

    > [!NOTE]
    > In this step, you can make changes and then select **OK** to save the changes.

5. Post the scheduled payment to move the original invoice to history and to create an open payment schedule.

    > [!NOTE]
    > A credit memo that has the same amount will be applied to the invoice.

    After the invoice is posted, the payment schedule is created. Then, the posted invoice debits the Accounts Payable accounts and credits the clearing account.

6. Post the scheduled payment amount. To do this, take one of the following actions.

   Microsoft Dynamics GP 10.0 and later versions:

   - On the **Microsoft Dynamics GP** menu, point to **Tools**, point to **Routines**, point to **Purchasing**, and then select **Post Scheduled Payments**.

   Microsoft Dynamics GP 9.0 and Microsoft Business Solutions - Great Plains 8.0

   - On the **Tools** menu, point to **Routines**, point to **Purchasing**, and then select **Post Scheduled Payments**.

7. In the Post Payables Scheduled Payments window, select the scheduled payment that you want post.

   The clearing account is debited, and the Accounts Payable account is credited for the actual payment amount.

   > [!NOTE]
   >
   > - A new open scheduled payment is created for the vendor. The document number has a trailing three-digit number. For example, the document number may be SCHED00000000001001.
   > - If you post smaller scheduled payments, the unapplied amount of the original scheduled payment is also decreased. When all the smaller scheduled payments (SCHED00000000001xxx) are posted, the original scheduled payment (SCHED00000000001) moves to history.
   > - If a check is applied to the scheduled payment, the Accounts Payable account is debited, and the Cash account is credited.
