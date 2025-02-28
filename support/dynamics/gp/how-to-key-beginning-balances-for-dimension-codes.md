---
title: How to key Beginning Balances for Dimension Codes
description: Introduces how to enter or offset Beginning Balances for Dimension Codes in Analytical Accounting for Microsoft Dynamics GP.
ms.reviewer: theley, cwaswick
ms.topic: how-to
ms.date: 03/20/2024
ms.custom: sap:Financial - Analytical Accounting
---
# How to key Beginning Balances for Dimension Codes in Analytical Accounting for Microsoft Dynamics GP

This article explains how to change or offset the beginning balance for Analytical Accounting codes in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2966091

## Introduction

As of Microsoft Dynamics GP 10.0 SP2, you have the option to consolidate balances for AA dimension codes in Analytical Accounting. Basically when the GL year-end close process is performed for General Ledger, the same journal entry is posted to the Analytical Accounting tables, and AA dimension codes are tied to this journal entry to roll the balance forward for the AA dimension codes at the same time.

However, there are times that you may want to enter new beginning balances, edit beginning balances, or offset existing balances for the AA dimension codes.

## Cause

Edit Analysis only allows you to change AA dimension codes on current year transactions. You aren't able to change AA codes on historical year transactions. This is by design.

## More information

To change beginning balances for AA codes, consider the following options:

### Option 1 - Reopen GL year and edit AA codes on transactions from prior year

Since Edit Analysis only allows you to change AA codes on current year transactions, you can reopen the GL year, which will automatically move the corresponding transactions in the AA tables at the same time. You can then use Edit Analysis  to add/delete/edit the AA codes on transactions in any transactions in an open year status. When finished, you can reclose the GL year again to have the balances consolidated and carried forward to the next year.

To edit transactions in an open year status, follow these steps:

1. Reopen the GL year(s) using one of these methods: (that is, move data from the historical GL/AA tables back to the open GL/AA tables)

    - For Microsoft Dynamics GP 10.0, Microsoft Dynamics GP 2010, and Microsoft Dynamics GP 2013 SP2 and prior (12.00.1570 and prior versions), you will need to open an advisory service to have a Microsoft Support Engineer reopen the GL year for you via SQL scripting.
    - For Microsoft Dynamics GP 2013 R2 (12.00.1745) **and higher versions**, new functionality is available to reopen the year(s) yourself. To do this, select **Tools** under Microsoft Dynamics GP, point to **Routines**, point to **Financial** and select **Year-End Closing**. In the Year-End Closing window, select the **Reverse Historical Year** button, the latest historical year will be listed and select **Process**. You must reopen the years back to the year that you need.

2. Once the year is in open status, select **Transactions**, point to **Financial**, point to **Analytical Accounting**, and select **Edit Analysis**.
3. Enter the respective open Year for the journal entry.
4. Select the Journal Entry number to edit.
5. Use the **Look Up** button next to the Distribution line number to edit.
6. Edit the Analytical Accounting codes as needed. You can add/edit/remove AA information on transactions.
7. Select **Post**.

8. Once the AA codes are edited as needed, reclose the GL year to have the data move back to history again and roll the balances forward. (See [The Year-end close procedures for Analytical Accounting in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-the-year-end-close-procedures-for-analytical-accounting-in-microsoft-dynamics-gp-41f3e9d4-d3c7-95b2-e144-0e8b640ddb44) for more information how to mark the dimension codes to be consolidated during the year-end process.)

### Option 2 - Key Offsetting journal entry to affect the balance brought forward for the AA dimension

If you do not have transactional detail, or you simply need to offset the current balance, you can key an offsetting journal entry as follows:

1. Select **Transactions**, point to **Financial** and select **General**.
2. Enter a general journal entry that will debit and credit the same GL account, so these entries offset each other in General Ledger.
3. Enter the AA codes to the respective debit or credit as needed.

4. You can date the journal entry to be the last day of the last closed year. (If you use the last day of the prior year, the system will let you post to the most recent historical year, and it will roll that balance forward for the AA code, but you will not be able to make any changes to the AA data once it is posted. Or you can choose to use the first day of the new year or any date in the new year, but then it will be a part of a period balance and you will need to remember that for reporting purposes. However, since it's an open year, you can continue to edit the AA data on it until the year is closed.)

5. Verify the balance for the AA code is now correct.

> [!NOTE]
> The debit and credit will offset each other in reporting, but the AA data is only tied to one side which provides the AA code balance. The distribution record is needed in the AA and GL tables, so that the AA codes have a header record and supporting transaction for it, but yet offset the GL account at the same time. Any recent SQL scripts (fix scripts for [Financial Reports from Management Reporter do not match the General Ledger Trial Balance Reports in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-financial-reports-from-management-reporter-do-not-match-the-general-ledger-trial-balance-reports-in-microsoft-dynamics-gp-386fa248-6460-e156-08ea-aaff0531c97b)) or check links for AA will require a supporting transaction in both AA and GL, or else these processes will remove the AA data completely.
