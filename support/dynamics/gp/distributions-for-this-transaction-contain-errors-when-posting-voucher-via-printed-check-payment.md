---
title: Distributions for this transaction contain errors when posting voucher via printed check payment
description: Describes a problem that occurs when you try to post a voucher by using a printed check payment in Microsoft Dynamics GP. A resolution is provided.
ms.reviewer: theley, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "Distributions for this transaction contain errors" when posting a voucher via a printed check payment

This article provides a resolution for the issue that you can't post a voucher by using a printed check payment in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 968051

## Symptom 1

When you try to post a voucher where a printed check payment exists in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains 8.0, you receive the following error message:

> Distributions for this transaction contain errors.  
The accounts payable distribution(s) does not equal the actual amount.  
The purchases distribution(s) does not equal the actual amount.

See cause 1.

## Symptom 2

You experience the following issues if Microsoft Dynamics GP becomes unresponsive after a check was printed in the Payables Transaction Entry window for a voucher that still remains in the Payables Transaction Entry window:

- The voucher cannot be viewed in the WORK status, the OPEN status, or the HISTORY status in the Payables Transaction Inquiry - Vendor window.
- When you log on to Microsoft Dynamics GP or Microsoft Great Plains 8.0 again and then try to open the Payables Transaction Entry window, you receive the following error message:

  > A Payables Management transaction that was interrupted during normal processing has been recovered. Use the Payables Management transaction entry windows to continue processing the transaction.

See cause 2.

## Cause 1

The following conditions are true:

- The voucher was paid with a check printed in the Payables Transaction Entry window.
- You change the **Purchases** amount of the voucher before you post the voucher.

> [!NOTE]
>
> - After you print a check payment from the Payables Transaction Entry window, the **Check** field becomes disabled. Therefore, if you change the value in the **Purchases** field after the check is printed, you receive the error message that is mentioned in the Symptoms section.
> - When the value of the **Purchases** field is equal to value in the **Check** field, the distribution is set to the following:
>
>   - Debit: Purchases Account
>
>     This default value is obtained from the vendor account card or the Posting Accounts Setup window under the Purchasing series.
>
>   - Credit: Cash account
>
>     This default value is obtained from the vendor account card or the checkbook that is used on the payment.

See resolution 1.

## Cause 2

You close the Payables Transaction Entry window after you print a check in the Payables Transaction Entry window for a voucher that was entered in Payables Management. Therefore, if you want to reenter the voucher and reuse the same document number for the check, this problem occurs. See resolution 2.

## Resolution 1

If you change the value in the **Purchases** field, and the Payables Transaction Entry window is not closed, follow these steps:

1. Select **Distributions**.
2. In the Payables Transaction Entry Distribution window, select **Default**.
3. Select **Change** when you receive the following warning message:

   > Resetting these defaults will delete all current entries. Are you sure you want to delete the existing entries?  
   After you do this, you can manually change the accounts to your preferred distributions.

## Resolution 2

If you closed Microsoft Dynamics GP, follow these steps:

1. Sign in to the company database in which you encounter the problem again.
2. Select **OK** when you receive the following error message:

    > A Payables Management transaction that was interrupted during normal processing has been recovered. Use the Payables Management transaction entry windows to continue processing the transaction.

3. On the **Transactions** menu, point to **Purchasing**, and then select **Transaction Entry**. When you do this, you receive the following error message:

   > This transaction was recovered during normal processing. You may continue processing the transaction.

4. Select **OK**. When you do this, the Payables Transaction Entry window appears.
5. Select **Distributions**.
6. In the Payables Transaction Entry Distribution window, select **Default**.
7. Select **Change** when you receive the following warning message:

   > Resetting these defaults will delete all current entries. Are you sure you want to delete the existing entries?  
   After you do this, you can manually change the accounts to your preferred distributions.
