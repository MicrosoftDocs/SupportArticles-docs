---
title: Posting Troubleshooting
description: Access answers to frequently asked questions about posting issues in General ledger, including account structure errors and dimension validation problems.
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


# Posting Troubleshooting
This article answers frequently asked questions about posting issues in General ledger. These questions address common errors related to account structures, advanced rules, and dimension values.

## Why do I receive an "Invalid value in ledger account" error?

This error occurs when an account doesn't follow the account structure or advanced rules configured for the ledger.

To review your account structure and advanced rule setup:

1. Go to **General ledger > Ledger setup > Ledger**.
2. Verify the account structures assigned to the ledger.
3. Confirm that your account combination complies with the configured rules.

If you didn't manually enter the segment that's causing the error, the value might come from default or derived dimensions. Review the following settings:

- **Main account fixed dimensions** – Check whether the main account has fixed dimension values that conflict with your account structure.
- **Journal header default dimensions** – Verify the default dimensions set on the journal header.
- **Derived dimensions** – Review the derived dimension rules that might apply segments automatically.

If you identify the source of the issue, update your default dimension setup accordingly.

> [!NOTE]
> The error message typically specifies which account structure or advanced rule was violated. [![An image of the error message displayed when an account structure or advanced rule was violated](./media/posting-faq-rule-violation.png)](./media/posting-faq-rule-violation.png)

## Why do I receive a "MainAccount is not a valid dimension value in account structure" error?

This error occurs when the main account or another entity isn't recognized as valid within the assigned account structure.

To resolve this issue:

1. Activate the account structure:
    1. Go to **General ledger > Chart of accounts > Structures > Configure account structures**.
    2. Select the account structure.
    3. Select **Activate** on the Action Pane.

2. Verify that the account structure is assigned to the ledger:
    1. Go to **General ledger > Ledger setup > Ledger**.
    2. Confirm that the account structure appears in the list.

For more information, see [Configure account structures](configure-account-structures.md).

## Why do I receive an "Entity does not exist" error for a dimension value?

This error typically means that the dimension value you entered doesn't exist in the system.

To verify that the dimension value exists:

1. Go to **General ledger > Chart of accounts > Dimensions > Financial dimensions**.
2. Select the relevant dimension.
3. Select **Dimension values** to search for the value.

If the dimension value exists but you still receive this error, a synchronization issue might exist.

To resolve the synchronization issue:

1. Rename the dimension value to a temporary name.
2. Wait for the rename process to complete.
3. Rename the dimension value back to its original name.

> [!IMPORTANT]
> The rename process runs as a background job and might take time to complete. To monitor progress, go to **System administration > Periodic tasks > Data maintenance**, and check the status of the **Dimension value rename and modify chart of accounts delimiter process** job.

## Why do I receive a "Missing value in ledger account" error?

This error occurs when there's a blank value in the ledger account that violates your account structure or advanced rules.

If you didn't enter a blank value for the specified segment, check whether the main account has fixed dimensions that are blank. Blank fixed dimensions overwrite the values that you enter, which causes this error.

To resolve this issue:

1. Go to **General ledger > Chart of accounts > Main accounts**.
2. Select the main account.
3. Review the **Legal entity overrides** FastTab for fixed dimension values.
4. If a fixed dimension is blank, update it to a valid value or remove the fixed dimension.

> [!NOTE]
> The error message typically specifies which account structure or advanced rule was violated.

## Why do I receive a "Suspended value" error?

This error occurs when a dimension value is suspended, either at the dimension value level or as a legal entity override.

To review the dimension value status:

1. Go to **General ledger > Chart of accounts > Dimensions > Financial dimensions**.
2. Select the relevant dimension.
3. Select **Dimension values**.
4. Check whether the dimension value is marked as **Suspended**.
5. If applicable, select the dimension value and review the **Legal entity overrides** tab for entity-specific suspension.

If you didn't manually enter the suspended segment, the value might come from default or derived dimensions. Review the following settings:

- **Main account fixed dimensions** – Check whether the main account has fixed dimension values that are suspended.
- **Journal header default dimensions** – Verify the default dimensions set on the journal header.
- **Derived dimensions** – Review the derived dimension rules that might apply suspended segments automatically.

If you identify the source of the issue, update your default dimension setup accordingly.

## Why do I receive an "Inactive value" error?

This error occurs when a dimension value is inactive on the date of the transaction. The value might be inactive at the dimension value level or as a legal entity override.

To review the dimension value status:

1. Go to **General ledger > Chart of accounts > Dimensions > Financial dimensions**.
2. Select the relevant dimension.
3. Select **Dimension values**.
4. Select the dimension value that's causing the error.
5. Review the **From date** and **To date** fields to verify that the value is active for your transaction date.
6. If applicable, review the **Legal entity overrides** tab for entity-specific date restrictions.

If you didn't manually enter the inactive segment, the value might come from default or derived dimensions. Review the following settings:

- **Main account fixed dimensions** – Check whether the main account has fixed dimension values that are inactive.
- **Journal header default dimensions** – Verify the default dimensions set on the journal header.
- **Derived dimensions** – Review the derived dimension rules that might apply inactive segments automatically.

If you identify the source of the issue, update your default dimension setup accordingly.

## Why do I receive a derived dimension error with "Prevent changes" enabled?

This error occurs when a derived dimension rule has **Prevent changes** enabled for the segment that's causing the error. When this option is enabled, the derived dimension automatically populates the segment and prevents manual changes.

To resolve this issue:

1. Go to **General ledger > Chart of accounts > Dimensions > Financial dimensions**.
2. Select each dimension used in your account structure.
3. Review the derived dimension rules for each dimension.
4. If you don't want the derived dimension to automatically populate the specified segment, disable the **Prevent changes** option.

## Why do I receive a "The combination was not validated beyond the financial dimension" error?

This error occurs when a segment in the account combination isn't valid. There are several reasons why this situation might occur:

- **Account structure or advanced rule violation** – The segment doesn't follow the account structure or advanced rules configured for the ledger. To review your setup, go to **General ledger > Ledger setup > Ledger**.
- **Suspended or inactive segment** – The segment is either suspended or inactive. To review the dimension value status, go to **General ledger > Chart of accounts > Dimensions > Financial dimensions**.
- **Default or derived dimensions** – If you didn't manually enter the invalid segment, the value might come from default or derived dimensions.

Review the following settings:

- **Main account fixed dimensions** – Check whether the main account has fixed dimension values that are invalid.
- **Journal header default dimensions** – Verify the default dimensions set on the journal header.
- **Derived dimensions** – Review the derived dimension rules that might apply invalid segments automatically.

If you identify the source of the issue, update your default dimension setup accordingly.

> [!NOTE]
> The error message typically specifies which account structure or advanced rule was violated.

## Why do I receive a "Total account or Reporting account" error?

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