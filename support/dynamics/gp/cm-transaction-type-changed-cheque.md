---
title: CM Transaction type changed to Cheque
description: The CM Transaction Type changes to cheque type when clearing the Bank Transaction window after selecting Void Transaction.
ms.reviewer: theley, deeptivu, cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# CM Transaction type for an Increase Adjustment incorrectly changed to Cheque (CHQ) after selecting Void Transaction in Bank Reconciliation

This article provides a solution to an issue where CM Transaction type for an Increase Adjustment incorrectly changed to Cheque (CHQ) after selecting **Void Transaction** in Bank Reconciliation for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2522239

## Symptoms

If a posted increase adjustment transaction is pulled up in the Bank Transaction Entry window (by typing in the Chequebook ID and the number) with the Option as Void Transaction, and then the window is closed instead of posting the void or the **Clear** button is used, rather than voiding the selected transaction, then this transaction is changed from **Increase Adjustment** (IAJ) to **Cheque** (CHQ).

> [!NOTE]
> This behavior is seen only when the Checkbook ID and Number fields are manually typed in the Bank Transaction window, instead of selecting them from the **Lookup** button.

Furthermore, in the Chequebook Balance Inquiry window, the amount for this transaction appears in the Payment column, instead of the Deposit column, which makes the balance on the particular transaction appear incorrect since the Balance field in this inquiry window is dynamically calculated. The window will treat the amount as a reduction to the balance instead of an increase. (However, the actual Current Chequebook Balance is correct.)

When the type of the transaction is changed from IAJ (Increase adjustment) to CHQ (Cheque), the systems see it as a cheque now and if it's voided, the chequebook balance will be incorrectly increased instead of reduced.

## Cause

When a transaction type other than Cheque is selected for voiding in the Bank Transaction Entry window and the **Clear** button is used, or the window is closed rather than voiding the selected transaction, the Transaction Type is changed to a type of Cheque (CHQ) in the CM20200 table, if the Transaction Number was manually entered in the Number field of the Bank Transaction Entry window, instead of selecting it from the **Lookup** button. If the lookup is used to locate the transaction, then the Transaction Type isn't updated when the window is closed or the **Clear** button is used. It makes the Balance appear incorrect in the Checkbook Inquiry window.

> [!NOTE]
> This issue only occurs when Canadian Payroll is installed in a Canadian GP installation. It's logged as CR #8627.

## Resolution

This issue only happens when you manually type in the Chequebook ID or Number in the Bank Transactions window. So, to work around this issue, don't type in the Transaction Number and instead, use the **Lookup** button (magnifying glass) to select the Chequebook ID and Transaction Number from the list.

Don't void the transaction after the IAJ type has changed to CHQ or the chequebook balance will be incorrectly increased. Depending on what type of transaction it was, you can just update the Transaction Type (CMTRXTYPE) directly in the CM20200 table before voiding it, but it should be tested in a test environment first. If further assistance is needed with this issue, you may open a case with Microsoft Dynamics GP Support and refer to CR #8627.
