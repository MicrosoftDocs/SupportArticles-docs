---
title: How to change Adjusted Bank Balance in Select Bank Transactions reconciliation
description: Introduces how to change Adjusted Bank Balance in Select Bank Transactions reconciliation.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# How to change the Adjusted Bank Balance in Select Bank Transactions reconciliation window in Microsoft Dynamics GP

This article provides a resolution for the scenario that you may want to change the Adjusted Bank Balance in the reconciliation window in your Select Bank Transactions reconciliation window without affecting the checkbook balance or GL cash account.

_Applies to:_ &nbsp; Microsoft Dynamics SL Bank Reconciliation, Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4088914

## Symptoms

Consider the following scenario:

You have been reconciling in Bank Reconciliation and achieving a 3-way match between your Adjusted Bank Balance on the recon, with the Checkbook Balance, and also your GL account for quite some time. However, you're carrying an amount on your recon that you would like to get rid of.

in this scenario, you may want to know how can you change the Adjusted Bank Balance in the reconciliation window in your Select Bank Transactions reconciliation window without affecting the checkbook balance or GL cash account.

## Cause

Basically, you can't. The bank is always right. If you are carrying a transaction that shouldn't be there, then it has affected the Adjusted Bank Balance during that time, and **you have been reconciling to an incorrect number**.

The Adjusted Bank Balance may be incorrect if either of the following is true:

- You did not key in the Bank Statement Ending Balance directly as shown on your Bank Statement when you entered the window.
- You are carrying transactions in the Reconciliation window that you shouldn't be there, or you are missing outstanding items in the window that should be there. (Outstanding items not marked as cleared affect the Adjusted Book Balance in the recon window.)

If you have achieved the 3-way match for a period of time with an extra (or missing) transaction being carried in the reconciliation window, then the Adjusted Bank Balance has been adjusted by this amount and you have reconciled to an incorrect number. To get the transaction off of your reconciliation window, you will also need to affect your checkbook balance and GL cash account as well.

> [!NOTE]
>
> - If you are carrying a **negative check**, you should clean this up right away, whether you balance with GL or not. A negative check is created when you **void** a check that has already been **reconciled**. You can't reconcile AND void a check, so the negative check is created by the system to let you know there is a problem that needs to be corrected. You should clean this up right away, and usually will also need a journal entry to your GL cash account as well to clean it up on both sides (ie. Bank Rec and GL) so you can match the bank.
> - Just because your GL cash account matches your Checkbook balance, does not mean they are right. It just shows that you have balanced one number in GP against another number in GP.  Your GL and checkbook balances are only right when they match the Adjusted Bank Balance in the recon, and there are no extra or missing transactions being carried.
> - Many customers carry a transaction for several years, and then want to know how to clean it up. You have been reconciling to an incorrect Adjusted Bank Balance during this time, so your GL cash account will also need to be adjusted in order to reconcile the true bank balance.

## Resolution

To remove a transaction from the reconciliation window, will result in the Adjusted Book Balance being changed. If you have reconciled to this number in the past, then you will most likely also need to fix this in your GL as well.

1. Key an **Increase Adjustment or Decrease Adjustment** in Bank Rec, as needed. Use a transaction date that is within the date range you are trying to reconcile. You will use this adjustment to offset the transaction that you are trying to remove from your Reconciliation window.

2. Let that Increase/Decrease Adjustment also flow to the **General Ledger**. One side of the entry will be to the GL cash account, and the other side will be to a GL account of your choice. Consult your own Accounting team for guidance on where they want you to record the amount to. (Typically customers use a write-off or over-and-short account.)  Do not book both the debit and credit to the same GL cash account.

3. Now you should be able to complete your next Bank Reconciliation by marking the transactions as cleared, and also marking the increase/decrease adjustment to offset it, so you still balance.
