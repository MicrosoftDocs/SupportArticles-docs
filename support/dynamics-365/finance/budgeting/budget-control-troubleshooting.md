---
title: Budget Control Troubleshooting in Dynamics 365 Finance
description: "Budget control troubleshooting in Dynamics 365 Finance: fix data inconsistencies, budget check failures, and missing purchase orders during year-end processing."
ms.date: 04/23/2026
ms.reviewer: mibeinar, twheeloc, v-shaywood
ms.custom: sap:Budgeting\Issues with budget control setup
audience: Application User
ms.search.region: global
---

# Common budget control troubleshooting scenarios

## Summary

This article covers common [budget control](/dynamics365/finance/budgeting/budget-control-overview-configuration) troubleshooting scenarios in Microsoft Dynamics 365 Finance. If you're experiencing issues with budget control data, budget check failures, or purchase orders that don't appear during year-end processing, the following sections help you identify and fix the problem.

## Budget control data maintenance tool

If you experience data inconsistency with a specific budget-controlled document, start with the [Budget control data maintenance tool](/dynamics365/finance/budgeting/budget-control-tool). This tool includes a **Budget control dimension values provider** scenario that adjusts the dimension values in budget data. Typically, you use this scenario when you add a new segment to the ledger account structure. It finds all dimension values currently used in budget data and transfers them to match the current [account structure](/dynamics365/finance/general-ledger/configure-account-structures).

If you want to preserve historical data and keep the previous account structure, adjust the date range so that only data in the specified range is updated.

To run the **Budget control dimension values provider** scenario, follow these steps:

1. Go to **Budgeting** > **Periodic** > **Budget control data maintenance**.
1. Enter a date range. You can set the date range to years before go-live or several years in the future.
1. Select **Select scenarios**, and then select **Budget control dimension values provider**.

   If there are documents to process, the grid is populated with the records that must be updated. The grid shows only the unique combinations of budget control dimension values that must be updated. For each combination, there might be one or many transactions.

1. Select the records to update, and then select **Process documents**. This operation might take some time, depending on the number of records to process.

> [!NOTE]
> By default, the **Document status** field is set to **Confirmed**. If there's budget data in a draft state, repeat the steps and select **Draft**.

## Budget control check failure

You might experience issues with budget checks. For example, a budget check might fail because not enough funds are available. Review available funds for a dimension combination on the **Budget control statistics by period** page.

If reviewing the statistics doesn't fix the issue, or if the results are unexpected, review the following configurations:

- **Budget control threshold**: If budget use exceeds the defined threshold, the system either prevents posting or shows warnings. For example, the budget threshold on the **Budget control configuration** page is set to 80%, and the **Display a message when exceeding budget threshold** option is set to **Yes**. In this case, you receive a warning message if budget use exceeds 80%.
- **Budget group**: If a dimension combination runs out of budget, it might try to use funds from the budget group. In some scenarios, an overbudget dimension combination can pull budget from the budget group.
- **Overbudget permissions**: If overbudget permissions exist, an overbudget scenario might occur, but you don't experience a failure on the budget check.
- **Budget control interval setup on budget control configuration groups**: If the budget control interval on the **Budget control configuration** page is set to **Fiscal year to date**, the end date for funds validation might differ from the date defined on the **Budget control statistics by period** page.

## Purchase order can't be retrieved during the purchase order year-end process

If a purchase order doesn't appear on the **Purchase order year end** page, it's typically because budget control data wasn't created for that purchase order. If you experience one or more of the following issues, use the steps in the following sections to resolve the problem:

- A purchase order doesn't appear on the **Purchase order year end** page.
- The purchase order doesn't contain budget control or encumbrance data.
- Budget control statistics for the purchase order are missing or incomplete, even though year-end processing is expected to include the purchase order.

> [!NOTE]
> If you enable the **Enable non-retrievable purchase orders page for purchase year-end order process** feature, the new page checks why a purchase order might not be visible during the purchase order year-end process for the selected fiscal year.

Use the following sections to check the budget control configuration and restore any missing budget data so that the purchase order appears correctly during year-end processing.

### Review the budget control configuration

1. Go to **Budgeting** > **Setup** > **Budget control** > **Budget control configuration**.
1. Review the following areas:

   - **Account structures**: Make sure the [financial dimension](/dynamics365/finance/general-ledger/financial-dimensions) used for budget control is included in the account structure. If the dimension is missing or excluded by advanced rules, the purchase order isn't budget controlled.
   - **Budget control rules or budget groups**: Confirm that rules are defined for the applicable financial dimensions or that a relevant budget group is assigned. Without these rules or groups, budget control isn't applied.
   - **Documents and journals**: Check that **Purchase order** is selected as a budget-controlled document. If it's not selected, purchase orders don't generate budget data.
   - **Budget funds available**: Check whether **Budget reservations for encumbrances** is enabled. This setting determines whether purchase orders create encumbrance reservations.

### Fix the configuration and reprocess data

Based on your findings, take the appropriate action:

- If the purchase order isn't intended to be budget controlled, remove purchase orders from budget-controlled documents, activate the configuration, and reprocess the affected purchase order if needed.
- If the purchase order is intended to be budget controlled but encumbrances are missing, enable **Budget reservations for encumbrances**, activate the configuration, and reprocess the purchase order.
- If all settings are correct but budget data is still missing, run **Budget control data maintenance** by using **Source document reprocessing** to regenerate budget control data for the purchase order.

After reprocessing, the purchase order is re-evaluated under the current configuration.

### Check the fix

To confirm that the issue is fixed:

1. Open the **Purchase order year end** page and check that the purchase order now appears.
1. Review budget control statistics and confirm that encumbrance or budget reservation data exists for the purchase order.

## Related content

- [Budget funds available](/dynamics365/finance/budgeting/budget-funds-available)
- [Budgeting overview](/dynamics365/finance/budgeting/basic-budgeting-overview-configuration)
- [Purchase order year-end close](/dynamics365/finance/budgeting/purchase-order-year-end-process)
