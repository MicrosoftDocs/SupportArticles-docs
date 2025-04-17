---
title: Reconcile process handles a transaction
description: Discusses how a Reconcile handles a voided transaction in Bank Reconciliation in Microsoft Dynamics GP and in Microsoft Business Solution - Great Plains.
ms.reviewer: theley
ms.date: 04/17/2025
ms.custom: sap:Financial - Bank Reconciliation
---
# Information about how the Reconcile process handles a voided transaction in Bank Reconciliation in Microsoft Dynamics GP

This article describes how the Reconcile process handles a voided transaction in Bank Reconciliation in Microsoft Dynamics GP or in Microsoft Business Solutions - Great Plains.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 860765

## In Microsoft Dynamics GP

Checks are date sensitive. So the date that you entered for the Void will determine whether the transaction will appear in the Select Bank Transactions window.

Consider the following example. The transaction date on a check is April 21, 2007. The check is then voided by using a date of May 1, 2007. If the Cutoff Date is April 15, 2007, the check will appear on the reconcile. However, if the cutoff date is May 2, 2007, then the check doesn't appear in the reconcile.

> [!NOTE]
> To start the Reconcile process, click **Transactions**, click **Financial**, and then click **Reconcile Bank Statement**.

If a transaction is voided after it's reconciled, a check will be created that is either negative or positive, depending on the Transaction Type of the voided transaction.

## In Microsoft Business Solutions - Great Plains 8.0 and earlier versions

Bank Reconciliation isn't date sensitive. So the date that you enter during the Reconcile process doesn't affect whether the voided transactions will appear.

When a transaction is voided before it's reconciled, the transaction won't be available to select in the **Select Bank Transactions** window when you do a Reconcile.

If a transaction is voided after it's reconciled, a check will be created that is either negative or positive, depending on the Transaction Type of the voided transaction.
