---
title: Checkbook Balance Inquiry window in Microsoft Dynamics GP
description: Provides more information about the Checkbook Balance Inquiry window in Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Bank Reconciliation
---
# Checkbook Balance Inquiry window in Microsoft Dynamics GP

This article provides some troubleshooting tips for using the Checkbook Balance Inquiry window in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP, Microsoft Dynamics SL Bank Reconciliation  
_Original KB number:_ &nbsp; 3100541

## Symptoms

Why is there a Beginning Balance in the Checkbook Balance Inquiry window when you didn't key one?

> [!NOTE]
> The get to this window, select **Inquiry**, point to **Financial** and select **Checkbook Balance**.

## Cause

Having a balance in the first line of the Checkbook Balance Inquiry window doesn't necessarily mean that is the beginning balance that was entered. The window calculates from the bottom up. The calculation starts with the current Checkbook balance, and then adds back Payments and subtracts out deposits from the bottom of the window and works upwards. So whatever is leftover is listed as the remaining balance in the first line. Hopefully it does match any beginning balance you keyed. But if not, it could be caused by more recent issues and data is damaged.

Example:

Current checkbook balance today is $20,000.00  
No Beginning Balance was keyed.

The Checkbook Balance Inquiry may show:

line 1 - Payment $5,000, Deposit - none, Balance $33,000  
line 2 - Payment $6,000, Deposit - none, Balance $28,000  
line 3 - Payment $4,000, Deposit - none, Balance $22,000  
line 4 - Payment - none, Deposit $2,000, Balance $18,000 << calculation starts at the bottom and goes upward

The window above makes it appear that a beginning balance of $33,000 was keyed and that isn't the case. The calculation in the window started with the $20,000 balance of today, and then started with line 4 and subtracted the $2,000 deposit to get a new balance of $18,000. Then it went up to line 3 and added back the $4,000 payment to get $22,000 and works its way adding and subtracting upwards. When it got to line 1, $33,000 is the amount that is *leftover* because of how the window calculates, as no beginning balance was keyed for this scenario. To the user, they may wrongly wonder where the $33,000 beginning balance came from, and that isn't the case. It just appears on the Balance line for line 1 because of how the window calculates upwards in this window. The user will now need to review current data to see if they can find an issue with damaged data for this amount. Tips are provided in the next section.

## Resolution

To find why your Balance amount in the first line of the Checkbook Balance Inquiry window is wrong, you'll need to dig through the data, and some troubleshooting tips are provided below. But if you need help with this from a support engineer, it borders what we will do in a regular support case since it's caused by damaged data. Open a support case and we'll take one look, but the engineer may need to send you to consulting, which is a billable expense.

### Troubleshooting tips

- If you have a problem in the Checkbook Balance Inquiry window, you more than likely also have a problem in the Reconcile Bank Statement window as well since the Adjusted Book Balance calculates the same way. So the first step would be to determine the last time your Bank Reconciliation was balanced. The damaged date more than likely happened between now and the last time you reconciled. So if you last reconciled your checkbook balance to the bank as of August 31, and it is now October, you'll need to review the September and October data to look for the discrepancy.

- Here are some SQL Scripts that you can run to help look for damaged data in the Bank Rec table. Run these against the company database in SQL Server Management Studio. Any results from these scripts should be investigated further:

  ```sql
  select * from CM20200 where GLPOSTDT = '1900-01-01'
  ```

  ```sql
  SELECT CHEKBKID, CMTRXNUM, CMTRXTYPE, TRXDATE, TRXAMNT from CM20200 
  group by CHEKBKID, CMTRXNUM, CMTRXTYPE, TRXDATE, TRXAMNT having count (*) > 1
  ```

  ```sql
  select * from CM20200 where Checkbook_Amount = '0.00000' and TRXAMNT <> '0.00000'
  ```

- Ask the users if they remember having any posting issues with any batches in Payables, Payroll, GL, or Deposits in Bank Rec. Often they can remember a posting interruption that you can further investigate, or even a maintenance issue that they tried to correct and keyed additional increase/decrease adjustments or voids (and maybe didn't get it right). The users are often a great place to find out issues to further investigate.
