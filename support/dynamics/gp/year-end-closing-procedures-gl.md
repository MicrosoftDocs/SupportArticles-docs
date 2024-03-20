---
title: Year-end closing procedures for GL
description: Describes the recommended year-end closing procedures for General Ledger in Microsoft Dynamics GP.
ms.reviewer: theley
ms.date: 03/20/2024
ms.custom: sap:Financial - General Ledger
---
# Year-end closing procedures for General Ledger in Microsoft Dynamics GP

This article outlines the recommended year-end closing procedures for Microsoft Dynamics GP. This article contains a checklist of the steps in the procedure, detailed information for each step, and a series of frequently asked questions.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 888003

## Summary

Read this article before you follow any steps, and be sure to have a current backup of both the company and Dynamics databases. For information about technical support for the General Ledger year-end closing procedures, Microsoft Partners can visit [Microsoft Support for business](https://serviceshub.microsoft.com/supportforbusiness) to open a support incident.

> [!NOTE]
> During the year-end closing routine, all the records that will be moved are put in a temporary table before they are moved to the GL30000 table. You must have free disk space that is equal to the size of the GL20000 table to perform the routine.

## Year-end closing checklist

1. [Complete the posting procedures and the closing procedures for other modules.](#step-1-complete-the-posting-procedures-and-the-closing-procedures-for-other-modules-see-suggested-order-below)

    > [!NOTE]
    > This step is only required if General Ledger is integrated with other modules.

1. [Post the final adjusting entries in General Ledger.](#step-2-post-the-final-adjusting-entries-in-general-ledger)
1. [Print an account list to verify the posting type of each account.](#step-3-print-an-account-list-to-verify-the-posting-type-of-each-account)
1. [Close the last period of the fiscal year.](#step-4-optional-close-the-last-period-of-the-fiscal-year)

    > [!NOTE]
    > This step is optional.

1. [Optional: Do file maintenance on the Financial series group of modules.](#step-5-optional-do-file-maintenance-on-the-financial-series-group-of-modules)
1. [Verify the settings in the General Ledger Setup window.](#step-6-verify-the-settings-in-the-general-ledger-setup-window)
1. [Make a backup.](#step-7-make-a-backup)
1. [Print a final Detailed Trial Balance report.](#step-8-print-a-final-detailed-trial-balance-report)
1. [Print the year-end financial statements.](#step-9-print-the-year-end-financial-statements)
1. [Set up a new fiscal year.](#step-9-print-the-year-end-financial-statements)
1. [Close the fiscal year.](#step-11-close-the-year)
1. [Close all the fiscal periods for all the series.](#step-12-optional-close-all-the-fiscal-periods-for-all-the-series-tools--setup--company--fiscal-periods)

    > [!NOTE]
    > This step is optional.

1. [Adjust the budget figures for the new year, and then print the financial statements.](#step-13-adjust-the-budget-figures-for-the-new-year-and-then-print-the-financial-statements)
1. [Make a backup.](#step-14-make-a-backup)

### Step 1: Complete the posting procedures and the closing procedures for other modules. (See suggested order below.)

Only follow this step if General Ledger is integrated with other modules. If General Ledger isn't integrated with other modules, skip this step.

1. Post final transactions in all the modules except in General Ledger.
2. Complete the month-end procedures and the quarter-end procedures for all the modules except for General Ledger.
3. Complete the year-end closing procedures for each module in the following order:

    1. Inventory

        For more information, see [Year-End Closing procedures in Inventory Control in Microsoft Dynamics GP](year-end-closing-inventory-control.md).

    2. Receivables Management

        For more information, see [Year-end closing procedures for Receivables Management in Microsoft Dynamics GP](year-end-closing-procedures-for-receivables-management.md).

    3. Payables Management

        For more information, see [Year-end closing procedures for the Payables Management module in Microsoft Dynamics GP](year-end-closing-payables-management.md).

    4. Fixed Asset Management

        For more information, see [The year-end closing procedures for the Fixed Asset Management module in Microsoft Dynamics GP](the-year-end-closing-procedures.md).

    5. Analytical Accounting

        Functionality was added to consolidate balances for dimensions in Analytical Accounting (Back on GP 10.0 SP2). Review [The Year-end close procedures for Analytical Accounting in Microsoft Dynamics GP](https://support.microsoft.com/help/960356) to make sure you've properly marked the dimensions that you want to be consolidated during the year-end process. (So AA dimension codes are linked to the balance brought forward entries.)

        > [!NOTE]
        > There is no separate year-end process that needs to be run in the Analytical Accounting module. When the year-end close process is run for General Ledger, it will automatically consolidate the balances and move the transactions in Analytical Accounting for dimensions that were properly marked (to link AA codes to the BBF entries in the AA tables [not GL tables]).

        For more information, see [The Year-end close procedures for Analytical Accounting in Microsoft Dynamics GP](https://support.microsoft.com/help/960356).

### Step 2: Post the final adjusting entries in General Ledger

The adjusting entries include all the entries that correct errors that were made when transactions were recorded. The adjusting entries also include journal entries that are used to assign revenues or expenses to the period in which the revenues were earned or in which the expenses were incurred.

If you must make any adjusting entries to give revenue, expenses, or depreciation to the year that you're closing, use the Transaction Entry window or the Quick Journal Entry window to make adjusting entries in General Ledger.

If you have to track initial adjusting entries or post audit entries separate from other fiscal periods, auditing periods can be set up in General Ledger. This feature enables separate tracking of the adjusting entries that are made after the year is closed. For more information about how to create auditing periods, see [How to set up an adjusting period in General Ledger in Microsoft Dynamics GP](set-up-adjusting-period-general-ledger.md).

> [!NOTE]
> If you're using closing periods and you reconcile, the transactions all move to the first period with the start date.

### Step 3: Print an account list to verify the posting type of each account

The posting type determines whether an account is closed to the retained earnings account or whether an account brings a balance forward to the next fiscal year. If the account balance will be brought forward at the end of the year, the posting type must be set to **Balance Sheet**. If the account balance will be closed to a retained earnings account at the end of the year, the posting type must be set to **Profit and Loss**. Use the Account Maintenance window if you must change the posting type for an account.

Follow these steps to print an account list:

1. On the **Reports** menu, point to **Financial**, and then select **Account**.
2. In the **Reports** list, select **All Accounts**, and then select **New**.
3. In the **Option** box, type all accounts.
4. Select the **Inactive Accounts** check box.

    > [!NOTE]
    > The year-end close process is designed to delete inactive General Ledger accounts that have no current year activity. For more information, see Q17 in the [Frequently Asked Questions](#frequently-asked-questions) section.
5. Select **Destination** to specify a report destination, and then select **OK**.
6. Select **Print**.

### Step 4: (Optional) Close the last period of the fiscal year

Closing the last period of the fiscal year (under **Tools | setup | company | Fiscal periods**) to prevent users from posting to the prior year while you're closing it and rolling forward balances.

You can use the Fiscal Periods Setup window to close all fiscal periods that are still open for the year. It prevents transactions from being posted to the wrong period or to the wrong year.

> [!NOTE]
> Make sure that you post all the transactions for the period and for the year for all modules before you close the fiscal periods. Later, if you have to post transactions to a fiscal period that you already closed, you must return to the Fiscal Periods Setup window to reopen the period.

### Step 5: (Optional) Do file maintenance on the Financial series group of modules

Run the check links procedure on the Financial series group of modules. (To do this, select **Microsoft Dynamics GP** > **Maintenance** > **Check links** > **Financial series**. Note that check links can't be reversed, so you should always run it in a TEST company first and review the report to make sure you agree with all the changes it made and don't have any surprises.)

### Step 6: Verify the settings in the General Ledger Setup window

If you want to keep historical records, you must select the **Accounts** check box and the **Transactions** check box in the **Maintain History** area of the General Ledger Setup window. The account history lets you print financial statements and calculated budgets from historical information. The transaction history lets you print detailed historical trial balances. The transaction history also lets you view the transaction details. If these check boxes are selected, both the account history and the transaction history are updated during the year-end closing routine.

### Step 7: Make a backup

Make a backup of all company data, and then put the backup in safe permanent storage. The backup gives you a permanent record of the company's financial position at the end of the year. The backup can then be restored later if it's required.

### Step 8: Print a final Detailed Trial Balance report

Use the Trial Balance Report window to print a year-end Detailed Trial Balance report.

> [!NOTE]
> We recommend that you post all transactions for the period and for the year for all modules before you print the Detailed Trial Balance report. If you post additional transactions later, we recommend that you print a new Detailed Trial Balance report.

### Step 9: Print the year-end financial statements

Print any year-end financial statements that are required. The most common financial statements include the following statements:

- Balance Sheet
- Profit and Loss Statement
- Statement of Cash Flows
- Statement of Retained Earnings

### Step 10: Set up a new fiscal year

Before you can do the year-end closing routine, you must set up the next fiscal year by using the **Fiscal Periods Setup** window (under **Microsoft Dynamics GP** > **Tools** > **Setup** > **Company** > **Fiscal Periods**.).

### Step 11: CLOSE THE YEAR

To close the fiscal year, follow these steps:

1. In Microsoft Dynamics GP, select **Microsoft Dynamics GP** > **Tools** > **Routines** > **Financial** > **Year-End Closing**.
2. Specify an account in the **Retained Earnings Account** box.

    The account that you specify in the Retained Earnings Account box is the account to which the year's profit and loss accounts are closed. The default account is the account that you specified in the General Ledger Setup window (under **Microsoft Dynamics GP** > **Tools** > **Setup** > **Financial** > **General Ledger**.).

    All current-year earnings or current-year losses are transferred to the account that you specify in the **Retained Earnings Account** box. If you want to distribute the retained earnings for the year to more than one account, you can specify an allocation account to distribute the retained earnings amount to the appropriate accounts. For example, you could set up an allocation account to divide the earnings between several departments in the business.

    Or, you could transfer the year's profit or loss to accounts that contain a specific account segment. This process is known as closing to a divisional retained earnings account. For more information, see [How to use divisional retained earnings accounts in General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/help/850615).

    For more information about how to close to divisional retained earnings accounts, see the [Frequently asked questions](#frequently-asked-questions) section.

3. Specify the number that you want to use as the first journal entry number for the next fiscal year in the **Starting Journal Entry** box.

    You can accept the default number. The default number is one more than the highest journal entry number that is posted for the current year. Or, you can specify a new number. The journal entry number that you specify is used as the journal entry number for the Year-End Closing report.

4. To start the routine, select **Close Year**.

    > [!IMPORTANT]
    > Select **Close Year** one time. If you select more than one time, you will close more than one year during the process. Also, if the progress window appears to stop at 50 percent, don't restart the routine. As long as the hard disk is processing, let the process continue.

If you're maintaining the account history, the year-end closing routine transfers all current-year information for each account in the chart of accounts to the account history. If you're maintaining the transaction history, the year-end closing routine also transfers all current-year information for each account in the chart of accounts to the transaction history. The process then prepares the accounting system for a new fiscal year. In addition to transferring current-year figures to the transaction history and to the account history, the year-end closing routine does the following steps:

- The year-end closing routine reconciles and summarizes the general ledger balances that accumulated throughout the year.
- The year-end closing routine removes accounts that are marked as inactive if the accounts match the criteria for deleting a posting account. Inactive accounts that have been set up as budget accounts can also be deleted if they have no activity for the year. These accounts can be deleted even if budget amounts from past years are associated with these accounts.
- The year-end closing routine moves all profit and loss account balances to the retained earnings account.
- The year-end closing routine summarizes balance sheet accounts and brings the balances forward as the beginning balances of the account in the new fiscal year.
- The year-end closing routine prints the Year-End Closing report.

When the year-end closing routine is complete, the Year-End Closing report is printed. This report lists the accounts that were closed and the transactions that were created to close those accounts. The Year-End Closing report is part of the audit trail. Save this report for the company's permanent records. The Year-End Closing report can't be reprinted.

### Step 12: (Optional) Close all the fiscal periods for all the series. (Tools | setup | company | Fiscal periods)

After you complete the closing procedures for all the modules, use the Fiscal Periods Setup window to mark all the periods for all the series as closed. We recommend that you do it to prevent transactions from being posted from any module to any period that you closed. After a period is marked as closed, transactions can't be posted to the period unless you reopen the period. Later, if you must post a transaction to a closed period, return to the Fiscal Periods Setup window to reopen the period.

### Step 13: Adjust the budget figures for the new year, and then print the financial statements

Adjust the budget figures by using one of the following windows:

- Excel-Based Budgeting (Select **Cards** > **Financial** > **Budgets** > select a budget ID > select **Open** > **using Excel**)
- Budget Maintenance (Select **Cards** > **Financial** > **Budgets** > select a budget ID > **OPEN** > **using Microsoft Dynamics GP**)
- Single-Account Budget Maintenance

Print the Profit and Loss statement to verify that profit and loss accounts were closed to the retained earnings account. Print the balance sheet to verify that the balance sheet accounts indicate that the balances were brought forward.

If you're using Advanced Financial Analysis (AFA) to print the financial statements, you must update the report layout to reflect the current fiscal year. To do it, follow these steps:

1. On the **Reports** menu, point to **Financial**, and then select **Advanced Financial**.
2. In the **Reports** list, select the financial statement, select **Open**, and then select **Layout**.
3. Double-click each column button to verify the Column Definition for the column. For example, double-click the **C1** button or the **C2** button.
4. If the column type is set to **Period Range**, to **Year-to-Date**, or to **Variable Year-to-Date**, select the current fiscal year in the **Year** list, and then select **OK**.
5. Repeat steps 13-1 through 13-4 for each column of each report.

### Step 14: Make a backup

Make a backup of all the company data, and then put the backup in safe permanent storage. The backup gives you a permanent record of the company's financial position at the start of the new year. This backup can be restored later if it's required.

## Frequently Asked Questions

**Q1: Do I have to close the fiscal year before the first day of the next fiscal year?**

A1: The year-end closing routine for General Ledger doesn't have to be completed before you start the next fiscal year. However, we recommend that you close the year as soon as possible.

**Q2: Can I make adjusting entries after I close the year?**

A2: You can post an entry to the most recent historical year if the **Posting to History** check box is selected in the General Ledger Setup window. You're allowed to post one historical year back. If you post an entry to a closed year, a second entry is automatically made that updates the beginning balances for the current fiscal year.

The following tables show an adjusting entry and the way the entry appears in the General posting journal. In this example, an adjusting entry was posted to a P&L account to the most recently closed year. (The 20XX represents the most recently closed year that you posted to.) You can see the original entry is listed on the General Posting Journal, and a separate entry to the Retained Earnings Account dated 12/31.

Adjusting entry

|12/20/20XX|Administration Expenses|$500|-|
|---|---|---|---|
|-|Cash|-|$500|

General Posting journal

|12/20/20XX|Administration Expenses|$500|-|
|---|---|---|---|
|-|Cash|-|$500|
|12/31/20XX|Retained Earnings|$500|-|
|-|Cash|-|$500|

**Q3: After I done the year-end closing routine, beginning balances were brought forward for some of my sales and expense accounts. Some of my asset accounts also closed to the retained earnings account. Why did this problem occur, and what can I do to correct it?**

A3: The posting type that is specified in the Account Maintenance window for the account determines whether a balance is brought forward for the account or whether the account is closed to the retained earnings account. Accounts that use the **Balance Sheet** posting type carry a balance forward. Accounts that use a **Profit and Loss** posting type close to the retained earnings account. To resolve this problem, use the appropriate method:

METHOD 1: Restore from a backup, correct the posting type, and then run the Year End Closing routine again.

METHOD 2: For more information about how to correct accounts that had an incorrect posting type without restoring to a backup, see [Changing the posting type on an account after you close the year in General Ledger for Microsoft Dynamics GP](changing-the-posting-type-an-account.md).

METHOD 3: For Microsoft Dynamics GP 2013 R2 (12.00.1745) and later versions, you can go to the Year End Closing Routine window and select the button for Reverse Historical Year, verify the Year to Open displayed and select **Process**. The year will be reopened as if it was never closed in the first place, so you can change the posting type on the account and then run the Year End Closing routine again.

**Q4: I tried to run the year-end closing routine by using a divisional retained earnings account, but I received the following error message:**
> Retained Earnings account not found.

**What can I do to resolve the problem that causes this error message?**

A4: Before the routine can continue, the year-end closing routine must validate that all the required divisional retained earnings accounts exist. For example, the Fabrikam, Inc. demonstration company uses an account format of **nnn-nnnn-nn**. The first segment represents the department. A retained earnings account must exist for each department that has a profit and loss account. For example, if sales account 400-4100-00 exists, but no 400- **nnnn-nn** retained earnings account exists, you receive this error message. For more information about how to close to divisional retained earnings accounts, see:

- [How to use divisional retained earnings accounts in General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/help/850615)

- [Error message when you try to perform the year-end closing process in General Ledger in Microsoft Dynamics GP: "Retained Earnings account not found"](error-when-performing-year-end-closing-process-in-general-ledger.md)

**Q5: What happens to unit accounts during the year-end closing routine**?

A5: Unit accounts are treated as balance sheet accounts. Unit accounts have a balance that is brought forward when the year is closed. For more information about how to clear the beginning balances for unit accounts, see [How to clear beginning balances for unit accounts in General Ledger in Microsoft Dynamics GP](clear-beginning-balances-for-unit-accounts-in-general-ledger.md).

**Q6: I'm preparing to close the year in General Ledger. Must everyone exit Microsoft Dynamics GP before I do the year-end routine?**

A6: We recommend that client computer users stop working in Microsoft Dynamics GP while the year-end closing routine is processing. If users continue to work in the program, their work may be lost if you have problems with the year-end closing routine and need to restore to the last backup.

**Q7: I want to allocate the net profit to the retained earnings account or to the capital accounts each month. Also, net profit is supposed to be allocated to three retained earnings accounts or capital accounts. Can I do it?**

A7: No, you can't do it. However, you can specify a non-financial account in the Account Maintenance window. Use a number that isn't in your current account numbering scheme. This account acts as a suspense account for the net income or for the net loss. Every month, you can post an adjusting entry to the three capital accounts that you want to adjust. For the offset account, use the suspense account. When the year-end closing routine is finished, use the suspense account as the retained earnings account. This offsets all the manual adjustments that you made to the suspense account during the year. Make sure that the suspense account doesn't appear on reports.

If you're using Advanced Financial Analysis for financial statements, when you format the balance sheet, put the **NP** line as the last line on the Advanced Financial Analysis statement. Then, put a page break before the **NP** line. The balance sheet must have an **NP** line. However, this line makes the net income or the net loss appear two times. So format the **NP** line so that it's off the financial statement. You can also use a report type of **Other**.

**Q8: Why is the status of some of my financial reports set to Invalid?**

A8: If a report is configured to use the accelerator file, any changes that are made to accounts in any one of the following windows causes the status of the financial report printing options to change to **Invalid**:

- Account Maintenance
- Unit Account Maintenance
- Mass Modify Chart of Accounts
- Year-End Closing

Before you print financial statements, you must update the accelerator file. To do it, follow these steps:

1. On the **Reports** menu, point to **Financial**, and then select **Update Financial Accelerator**.
2. Select **Update**, and then select **Continue**.
3. Close the Update Financial Accelerator Information window.

**Q9: How are non-financial accounts closed during the year-end closing routine?**

A9: If the non-financial account is configured to use the **Balance Sheet** posting type, the account balance is brought forward during the year-end closing routine. If the non-financial account is configured to use the **Profit and Loss** posting type, the account balance is closed to the retained earnings account during the year-end closing routine.

**Q10: When I try to post a batch in the General Ledger module, I receive the following message:**
> Batches cannot be posted while the Year-End Close is in progress.

**The year-end closing routine isn't being run in General Ledger. What should I do?**

A10: To resolve this issue, have all users close all transaction entry windows. Then, delete the SY00800 file if you're running a Microsoft SQL Server database. To do it, run the following statement on the DYNAMICS database.

```sql
delete SY00800 where BACHNUMB = 'GL_Close'
```

For more information, see ["Year End Close is still in process and batches cannot be posted" error when posting a transaction in General Ledger after the year is closed](year-end-close-is-still-in-process-and-batches-cannot-be-posted-error.md).

**Q11: I receive the following message when I try to close the year in General Ledger:**
> Sorry, another user is closing the year.

**No one else is trying to close the year. What should I do?**

A11: To resolve this issue, delete the SY00800 file if you're using a Microsoft SQL Server database. To do it, run the following statement in SQL Server Management Studio against the DYNAMICS database.

```sql
delete SY00800 where BACHNUMB = 'GL_Close'
```

**Q12: I'm doing the year-end closing routine in General Ledger and it appears to be stopped at 50 percent. My workstation seems to have stopped responding. What should I do?**

A12: If the year-to-date transaction open file (GL20000) is large, it may take a long time for the year-end closing routine to finish. If the hard disk is still processing, the year-end closing routine hasn't stopped responding. We recommend that you let the routine run. If the hard disk isn't processing, we recommend that you restore from a backup. Then, follow the steps in this article again, starting at step 5.

**Q13: If an adjusting entry has been posted to a year that is closed, can I print a corrected Trial Balance report for that year?**

A13: Yes, you can print a corrected Trial Balance report for the year that is closed. To do it, follow these steps:

1. On the **Reports** menu, point to **Financial**, select **Trial Balance**, and then select **New**.
2. In the **Option** field, type With Adjustments.
3. In the **Include** area, select the **Posting Accounts** check box.
4. In the **Year** area, select the **History** check box, and then select the historical year in the **Year** list.
5. Select **Destination** to specify a report destination, and then select **OK**.
6. Select **Print**.

**Q14: How does Microsoft Dynamics GP determine the financial statement that is printed for the account that I'm adding?**

A14: The category determines the type of financial statement that is printed when you use quick financial statements for the account that you're adding. The category is either the Balance Sheet category or the "Profit and Loss" category. You must format the reports to print the accounts that you want in Advanced Financial Analysis. The posting type is used during the year-end closing routine to determine the accounts that close to the retained earnings account and to determine the account that carries a balance forward. The posting type doesn't affect the financial statements.

**Q15: When I tried to do the year-end closing routine, I received an error message that stated that a single-use batch or a quick journal transaction hadn't been posted. What does this error message mean?**

A15: When you try to do the year-end closing routine, you may receive the following error message:
> A single use batch or quick journal transaction has not been posted yet. Do you want to continue closing?

You receive this error message if an unposted single-use batch or an unposted quick journal transaction exists in General Ledger. This error message doesn't prevent you from continuing with the year-end closing routine. If you don't want to post the single-use batch or the quick journal transaction, continue with the year-end closing routine.

**Q16: When I try to do the year-end closing routine in General Ledger, why do I receive the following error message:**
> [Microsoft][ODBC SQL Server Driver][SQL Server]Violation of PRIMARY KEY constraint 'PK##0671112'. Cannot insert duplicate key in object '##0671112'

A16:The year-end closing transactions contain a currency that isn't assigned to an account. For more information about how to resolve this issue, see ["Violation of PRIMARY KEY constraint 'PK##0671112'" error when doing year-end closing routine in General Ledger](violation-of-primary-key-constraint-error-when-doing-year-end-closing.md).

**Q17: Why did the year-end closing process delete some GL accounts that may be tied to budgets?**

A17: Functionality was added (in GP 2015 and higher versions) in the Year-End Closing window with a checkbox for Maintain Inactive Accounts. With this option marked, you get to choose if you wish to maintain All inactive accounts, or only those with Budget Amounts. If you don't mark this option, then all inactive accounts will be removed from the system during the year-end close process.

For more information about inactive GL accounts and the year-end close process, see [Inactive GL accounts deleted during Year-End Close process for General Ledger in Microsoft Dynamics GP](inactive-gl-accounts-deleted-during-year-end-close.md).

**Q18:If I had a failed year end close, can I use theReverse Historical Year checkbox in the Year-End Closing window in Microsoft Dynamics GP 2013 R2 (and later versions), to try to fix it or un-do it?**

A18: The recommended and supported process is to restore immediately to a prior backup if the year-end close process fails. The **Reverse Historical Year** process was designed to reopen a GL year that was successfully closed. With that said, it works for some cases (but not all). So, you are really on your own to try it. If you prefer, make a current backup and test it in a TEST company to verify if it works correctly as it may not work for all data scenarios. If the year-end close process fails, the recommended process is to make screen prints any error messages, and then restore to your pre-close backup.
