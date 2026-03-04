---
title: "General Ledger Posting Error: Invalid Main Account Type"
description: Resolve the account type for main account is not valid error in Dynamics 365 Finance. Learn how to fix posting issues in General ledger transactions.
ms.date: 03/04/2026
ms.reviewer: anaborges, setharvila, ethankallett, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting/Issues with financial dimensions and financial tags
audience: Application User
ms.search.region: Global
ms.search.validFrom: 2018-03-16
ms.search.form: LedgerJournalSetup, LedgerParameters, DimensionConfigureAccountStructure
ms.dyn365.ops.version: 8.0.2
---

# "The account type for main account... is not valid" error when posting in General ledger

## Summary

This article provides a solution for an error that occurs when you try to post a transaction to a main account in General ledger in Microsoft Dynamics 365 Finance. The error states that the account type for the main account isn't valid and must be of type _Financial_. This problem typically involves a main account that has an account type of _Total_ or _Reporting_.

> [!NOTE]
> If you experience a dimension-related posting error, see [Common dimension-related errors](common-dimension-related-errors.md).

## Symptoms

When you try to post a transaction in General ledger, you receive the following error message:

> The account type for main account...  is not valid. The main account type must be Financial.

## Cause

This error occurs when a transaction references a main account that has an account type set to _Total_ or _Reporting_. These account types are for summarization and [financial reporting](/dynamics365/finance/general-ledger/financial-reporting-getting-started) purposes only and don't permit direct transaction entry.

## Solution

To resolve this issue, check the main account type and either correct the transaction or update the account type:

1. Go to **General ledger** > **Chart of accounts** > **Accounts** > **Main accounts**.
1. Select the main account that's referenced in the error message.
1. On the **General** FastTab, review the **Main account type** field.
1. Take one of the following actions:
   - If you selected the wrong account, change the transaction to use an account that has a valid type, such as **Profit and loss**, **Revenue**, **Expense**, **Asset**, or **Liability**.
   - If the account type is incorrect, update the **Main account type** field.

> [!NOTE]
> _Total_ and _Reporting_ accounts are typically used in row definitions for financial reports. They aggregate balances from other accounts and shouldn't receive direct postings. Changing the account type might affect financial reporting, so review your [chart of accounts](/dynamics365/finance/general-ledger/plan-chart-of-accounts) design before you make changes.

## Related content

- [Can't post a journal due to imbalance](posting-fail-imbalance.md)
- [Main account types](/dynamics365/finance/general-ledger/main-account-types)
- [Create a main account](/dynamics365/finance/general-ledger/tasks/create-main-account)
