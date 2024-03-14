---
title: An attendance transaction does not exist in Human Resources warning during payrun build
description: You may receive a warning message that states an attendance transaction does not exist in Human Resources during the payrun build process in Microsoft Dynamics GP. Provides a resolution.
ms.reviewer: theley, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Human Resources
---
# "An attendance transaction does not exist in Human Resources" warning occurs during payrun build

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2892399

## Symptoms

The following warning message appears during the payrun build process in Microsoft Dynamics GP:

> An attendance transaction does not exist in Human Resources *****WARNING*****

## Cause

This warning message means that the system has found a transaction(s) in the payroll batch that does not exist on the HR side. If the paycode is linked to a timecode, the transaction should exist in both the HR and payroll tables, and will happen automatically if you hand-key the transactions with a linked timecode/paycode. However, only the payroll table will be updated if the following happens:

- The transactions were *imported* directly into the payroll batch. This process may update the Payroll table only and not HR.
- The payroll batch was keyed first, and then the paycode was linked to a timecode in HR after the fact.

## Resolution

If you need to update the Human Resources table with the transactions in the unposted payroll batch, there is a reconcile process in Human Resources that will do this:

1. Under Microsoft Dynamics GP, select **Tools**, point to **Utilities**, point to **Human Resources** and select **Reconcile**.
2. Mark the checkbox for **Reconcile Attendance Transactions**.
3. Select **Process**.
4. Rebuild the payrun batch and verify that the warning message is now gone.

> [!NOTE]
>
> 1. If you are importing in transactions directly to a payroll batch, you will need to run this reconcile utility each time before you build the payrun. There steps should be added to your payrun procedures if you import in payroll transactions on a regular basis.
>
> 2. This reconcile option will only look at *unposted* batches in payroll. It will update the HR transaction table (TATX1030) with the corresponding transaction(s) from the Payroll Work table (UPR10302) where the paycode is linked to a timecode. It will not update the HR table with transactions that were already posted and in payroll history. So once the batch is posted in payroll, it is too late to run this reconcile utility.
>
> 3. You can run this reconcile option as many times as you wish (before the batch is posted in payroll). It will skip over transactions that already exist on both the HR and Payroll tables, and update the HR table only for transactions where a matching record is not found. For example, if you import in 3 payroll batches to be included in the same checkrun, you can run this reconcile utility after each import for a total of three times, or you can import in all 3 batches and just run it one time after the last import, and before you build the payrun.
