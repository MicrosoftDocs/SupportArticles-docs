---
title: Troubleshoot posting errors
description: Access answers to frequently asked questions about posting issues in General ledger, including account type errors and other non-dimension-specific posting problems.
author: seth-arvila
ms.author: setharvila
ms.topic: faq
ms.date: 2/3/2026
ms.reviewer: 
audience: Application User
ms.search.region: Global
ms.search.validFrom: 2018-03-16
ms.search.form: LedgerJournalSetup, LedgerParameters, DimensionConfigureAccountStructure
ms.dyn365.ops.version: 8.0.2
ms.assetid: 
---


# Troubleshoot posting errors
This article answers frequently asked questions about posting issues in General ledger.

> [!NOTE]
> If you're experiencing a dimension-related posting error, see [Troubleshoot common dimension-related errors](common-dimension-related-errors.md).

## Why do I receive a "The account type for main account ... is not valid. The main account type must be Financial." error?

This error occurs when you try to post a transaction to a main account that has an account type of **Total** or **Reporting**. These account types are used for summarization and reporting purposes only—they don't allow direct transaction entry.

To check the main account type:

1. Go to **General ledger > Chart of accounts > Accounts > Main accounts**.
2. Select the main account referenced in the error.
3. On the **General** FastTab, review the **Main account type** field.

To resolve this issue:

- If you selected the wrong account, change the transaction to use an account with a valid type (such as **Profit and loss**, **Revenue**, **Expense**, **Asset**, or **Liability**).
- If the account type is incorrect, update the **Main account type** field. However, changing the account type might affect financial reporting, so review your chart of accounts design before making changes.

> [!NOTE]
> Total and Reporting accounts are typically used in row definitions for financial reports. They aggregate balances from other accounts and shouldn't receive direct postings.