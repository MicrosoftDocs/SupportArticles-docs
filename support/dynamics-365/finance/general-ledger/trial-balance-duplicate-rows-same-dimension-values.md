---
title: Fix trial balance shows duplicate rows for the same dimensions
description: Fix duplicate rows on the trial balance report in Dynamics 365 Finance by clearing and rebuilding balances after a financial dimension set definition is changed.
ms.date: 05/26/2026
ms.reviewer: ethankallett, anaborges, jowalker, setharvila, moaamer, nedavis, twheeloc, v-shaywood
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with financial dimensions and financial tags
---

# Trial balance shows duplicate rows with the same dimension values

## Summary

This article provides troubleshooting steps for an issue in Microsoft Dynamics 365 Finance in which a trial balance report shows two or more rows that have the same dimension values. The same issue can appear in the trial balance snapshot report as duplicate dimensions or incorrect balances. This issue typically occurs if you change a financial dimension set definition that uses existing balances without first rebuilding the balances.

## Symptoms

When you run a trial balance (or trial balance snapshot) report for a specific financial dimension set, you notice one or more of the following issues:

- The same combination of dimension values appears in two or more rows instead of a single consolidated row.
- The same account and dimension combination is split across multiple rows.
- Balances for a dimension combination look incorrect because they're spread across duplicate rows.

## Cause

This issue occurs if you change the definition of the [financial dimension set](/dynamics365/finance/general-ledger/financial-dimension-sets) after you calculate balances for it but don't clear and rebuild the balances to match the new definition. When you change the dimension set definition, Finance shows the following warning that recommends that you rebuild the balances:

> The dimension set \<DimensionSet> has changed; the dimension balances must be recalculated. It is recommended that you select to rebuild balances.

If you dismiss or miss this warning, the trial balance continues to read from balances that reflect the old dimension set definition. The mismatch between the old and new definitions causes the same dimension combination to appear in more than one row.

## Solution

To fix this issue, clear and rebuild the balances for the affected financial dimension set. It isn't sufficient to run the **Update balances** command because that action picks up only new transactions. The duplicate rows are caused by stored balances that still reference the previous dimension set definition. Therefore, you must remove and recalculate those balances.

To clear and rebuild balances:

1. Go to **General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimension sets**.
1. Select the financial dimension set that the trial balance report uses.
1. Select **Clear balances**, and verify the action.
1. After the clear operation finishes, select **Rebuild balances** for the same set.
1. Rerun the trial balance (or trial balance snapshot) report, and verify that the duplicate rows no longer appear.

> [!NOTE]
> The process to rebuild balances can take a long time on large datasets. Plan to run **Clear balances** and **Rebuild balances** during a maintenance window or off-peak hours.

To avoid this issue in the future, choose to rebuild the balances when you receive the warning that the dimension set changed and you must recalculate balances.

## Related content

- [Financial dimensions overview](/dynamics365/finance/general-ledger/financial-dimensions)
- [General ledger account balances](/dynamics365/finance/general-ledger/general-ledger-account-balances)
- [Best practices for managing financial dimension sets](/dynamics365/finance/general-ledger/dimension-set-balance-performance-best-practices)
