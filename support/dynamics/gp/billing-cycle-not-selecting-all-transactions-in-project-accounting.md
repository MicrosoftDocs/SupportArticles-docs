---
title: Billing cycle not selecting all transactions
description: When running the billing cycle in Project Accounting, some of the transactions were not selected to be billed. Provides a resolution.
ms.reviewer: 
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Billing cycle not selecting all transactions in Project Accounting

This article provides a resolution for the issue that billing cycle doesn't select all transactions in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 861888

## Symptoms

When running the process billing cycle in Project Accounting, nothing is created in the batch even though there are items to bill.

## Cause

1. The Billing Cycles are not assigned correctly.
2. The Cutoff date is before the transaction date.
3. The Transaction is Non-Billable.
4. The Project or contract is Closed to Billings.
5. Your Actual Billings are not permitted to Exceed Projected Billings.

## Resolution

1. The location that billing cycles must be assigned depends on the selection that you make for One Invoice Per Customer, Contract, or Project under **Transactions** > **Project** > **Billing** > **Cycle Biller**.

    If you mark **Customer**, Microsoft Dynamics GP will compare the billing cycle on the Customer (**Cards** > **Sales** > **Customer** > **Project**) with the billing cycle on the Project (**Cards** > **Project** > **Project** > **Billing Settings**).

    If you mark **Contract**, Microsoft Dynamics GP will compare the billing cycle on the Contract (**Cards** > **Project** > **Contract** > **Contract Settings**) with the billing cycle on the Project (**Cards** > **Project** > **Project** > **Billing Settings**).

    If you mark **Project**, the billing cycle must only be set up on the Project (**Cards** > **Project** > **Project** > **Billing Settings**).

    If Great Plains does not find a match to the billing cycle that you are doing in Cycle Biller, it will not pick up those transactions.

2. Make sure your transactions occur before the cutoff date. You can view the transactions in **Inquiry** > **Project** > **Trx Documents** > **Timesheets** or whatever transaction type is applicable.

3. Check to see if the transaction is non-billable. A non-billable transaction will not be selected in a process billing cycle. You can view the transactions in **Inquiry** > **Project** > **Trx Documents** > **Timesheets** or whatever transaction type is applicable.

4. Check to see that **Closed to Billings** is not marked in **Cards** > **Project** > **Contract** or **Cards** > **Project** > **Project**.

5. Select **Setup**, select **Project**, select **Billing**, select **Options**, and then check to see if Allow Actual Billings to Exceed Projected Billings is marked. If this is unmarked and you have exceeded your projected billings, a bill will not be created for you in process billing cycle.
