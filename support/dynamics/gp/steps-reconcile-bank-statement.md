---
title: Steps to reconcile bank statement
description: Steps to reconcile bank statement with no activity in Bank Reconciliation using Microsoft Dynamics GP.
ms.reviewer: theley, lmuelle, cwaswick
ms.topic: troubleshooting
ms.date: 04/17/2025
ms.custom: sap:Financial - Bank Reconciliation
---
# Steps to reconcile bank statement with no activity in Bank Reconciliation using Microsoft Dynamics GP

This article describes the steps to reconcile a bank statement with no activity in Bank Reconciliation using Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2621512

## Symptoms

When you select **Reconcile**, you receive the following message because there are no items to mark in the window:

> Enter or select the items you want to reconcile.

## Cause

The reconcile option needs to have activity to process the reconcile.

## Resolution

Follow one of these resolutions to resolve this problem:

### Resolution 1 - Enter offsetting adjustments to trick the system into having activity for this month as follows

1. Enter the cutoff date in the Reconcile Bank Statements window.

2. Select **Transactions** button.

3. Select the **Adjustments** button.

4. Enter two adjustments in the Reconcile Bank Adjustments window for $.01 that offset each other. Enter one as an Interest Income and the other as an Other Expense for $.01 each and hit the same GL account. Select **OK**. (They won't post to GL since it's a zero dollar transaction.)

5. Select **Reconcile**. The process should now run and update the Last reconciled date for the checkbook.

### Resolution 2 - Update the displayed date directly in the SQL table

Go into SQL Server Management Studio and manually run a script to update the LAST_RECONCILED_DATE field in the Checkbook Master (CM00100) table for that checkbook ID.

```sql
update CM00100 set Last_Reconciled_Date = '2011-09-30' where CHEKBKID = 'XX'
```

(Change the date as appropriate in the script above and replace the *XX* placeholder with the checkbook ID before executing against the company database.)
