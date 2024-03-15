---
title: Inactive GL accounts deleted during Year-End Close process
description: The year-end close process deletes any accounts that are marked as inactivate if there is no history for these accounts.
ms.reviewer: theley, cwaswick, lmuelle
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Inactive GL accounts deleted during Year-End Close process for General Ledger in Microsoft Dynamics GP

This article provides a resolution for the issue that inactive General Ledger accounts are deleted unexpectedly during the Year-End Close process for General Ledger in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2452542

## Symptoms

The Year End Closing process for General Ledger will delete a GL account marked as Inactive in the Account Maintenance window and has met the following criteria for an account to be deleted:

- No balance
- No activity for an open period
- No account history amounts
- Not part of an allocation account
- Not part of an unposted transaction
- No multicurrency data
- No transaction history records

> [!NOTE]
> Inactive accounts that have been set up as budget accounts can also be deleted if there was no activity for the year. These accounts can be deleted even if budget amounts from past years are associated with these accounts. This may also cause trial balance reports from previous years to be out of balance.

## Cause

Inactive accounts are deleted by design in Microsoft Dynamics GP during the GL year-end close process.

## Resolution

- Microsoft Dynamics GP 2010 and prior versions

  The only work-around is to set the account(s) to Active status before you run the year-end closing routine for General Ledger. Then mark the accounts as inactive again after the GL closing routine is completed.

  Follow these steps to print a list of all your GL accounts *before* you perform the year-end close process:

  1. On the Reports menu, point to **Financial** and then select **Account**.
  2. In the **Reports** list, select **All Accounts**, and then select **New**.
  3. In the **Option** field, type *All Accounts*.
  4. Select select the **Inactive Accounts** checkbox.
  5. Select **Destination** to specific a report destination (such as your printer) and then select **OK**.
  6. Select **Print**. The Account List report will print showing all GL accounts. Note the Active column that will display a Yes or No to indicate the status of the account.
  7. Select **Save** to save the report option.

- Microsoft Dynamics GP 2013 and later versions

  There is new functionality in the Year-End Closing window in Microsoft Dynamics GP 2013 and later versions where you can mark the checkbox for Maintain Inactive Accounts.

  - With this option marked, it will enable other options to maintain All Inactive Accounts or just those With Budget Amounts associated with them. Mark the option you prefer.
  - If this checkbox isn't marked, then ALL inactive accounts will be deleted by design that meet the criteria outlined above, whether or not they were used in a budget.

## More information

The checklist for the Year-End closing routine for General Ledger is outlined in Knowledge Base article 888003. The above steps to print the report are in Step 3 in the checklist. If you have this report from last year, you can look at it to see what accounts were inactive at that time and may have been deleted.

For more information about the year-end closing routine for General Ledger, see [Year-end closing procedures for General Ledger in Microsoft Dynamics GP](https://support.microsoft.com/topic/kb-year-end-closing-procedures-for-general-ledger-in-microsoft-dynamics-gp-4447f7bb-7143-60e2-882a-c7ae86f5792e).
