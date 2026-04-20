---
title: Troubleshoot budget control issues
description:  Provides resolutions for the common issues that can occur when you use budget control in Microsoft Dynamics 365 Finance.
author: music727
ms.author: mibeinar
ms.topic: how-to
ms.date: 04/17/2026
ms.reviewer: twheeloc
audience: Application User
ms.search.region: global
ms.search.validFrom: 
ms.search.form: 
ms.dyn365.ops.version: 
ms.assetid: 
---

# Troubleshoot budget control issues

This article lists common issues that can occur when you use budget control in Microsoft Dynamics 365 Finance. It also explains how to fix these issues. 


## Budget control data maintenance

If you experience data inconsistency with a specific budget-controlled document, start with the **Budget control data maintenance** tool. 
The **Budget control data maintenance** tool can:
 - delete and recreate existing budget data from a source document
 - review the budget to find documents that weren't previously budget-checked but should be checked now, either because of configuration changes or because budget control was turned on or off.
 - uses the accounting distributions to determine the correct budget amounts. If there are problems with the distributions, the budget data is incorrect.

To run the **Budget control data maintenance** tool, follow these steps:

1. Go to **Budgeting** > **Periodic** > **Budget control data maintenance**.
1. Define a date range.
1. Select **Select scenarios**, and then select **Source document reprocessing provider**.
1. In the dialog box that appears, specify the document type and document number. To retrieve multiple documents at the same time, use wildcard characters in the **Document number** field. Alternatively, specify
  a comma-separated list of document numbers.

The tool finds all documents that relieve each other. For example, you specify document PO00123, which relieves document PR005678. In this case, both documents appear in the grid, and they're processed as a group.

1. To process the documents that the tool finds, select **Process documents**.
1. Complete the remaining dialog boxes.

### Budget control dimension values provider

The **Budget control data maintenance** tool includes a **Budget control dimension values provider** scenario that adjusts the dimension values in budget data. Typically, you use this scenario when you add a new segment to the ledger account structure. It finds all dimension values that are currently used in budget data and transfers them to match the current account structure.

If you want to preserve historical data and keep the previous account structure, adjust the date range so that only data in the specified range is updated.

To run the **Budget control dimension values provider** scenario, follow these steps:

1. Go to **Budgeting** > **Periodic** > **Budget control data maintenance**.
1. Enter a date range. You can set the date range to years before go-live or several years in the future.
1. Select **Select scenarios**, and then select **Budget control dimension values provider**.

 If there are documents to process, the grid is populated with the records that must be updated. The records that appear in the grid are only the unique combinations of budget control dimension values that
 must be updated. For each combination, there might be one or many transactions.

1. Select the records to update, and then select **Process documents**. The operation might take some time, depending on the number of records that must be processed.

> [!NOTE]
> By default, the **Document status** field is set to **Confirmed**. If there's budget data in a draft state, complete the steps again and select **Draft**.

## Budget control check failure

You might experience an issue with budget checks. Alternatively, budget checks might fail because not enough funds are available, the **Budget control statistics by period** page displays available funds for the
dimension combination.

If the previously mentioned steps don't apply, or if they produce unexpected results, review the following configurations:

- Budget control threshold – If budget use exceeds the defined threshold, the system either prevents posting or shows warnings. For example, the budget threshold on the **Budget control configuration** page
   is set to 80%, and the **Display a message when exceeding budget threshold** option is set to **Yes**. In this case, you receive a warning message if budget use exceeds 80%.
- Budget group – If a dimension combination runs out of budget, it might try to use funds from the budget group. In some scenarios, an overbudget dimension combination might be able to pull budget from the
  budget group.
- Overbudget permissions – If there are any overbudget permissions, an overbudget scenario might occur, but you don't experience a failure on the budget check.
- Budget control interval setup on Budget control configuration groups – If the budget control interval on the **Budget control configuration** page is set to **Fiscal year to date**, the end date for funds
  validation might differ from the date that is defined on the **Budget control statistics by period** page.

### Purchase order can't be retrieved during Purchase order year end process

If a purchase order doesn't appear on the **Purchase order year end** page, it's typically because budget control data wasn't created for that purchase order.
If you experience one or more of the following issues, follow the guidance shared in this article:

- A purchase order doesn't appear in the **Purchase order year end** page
- The purchase order doesn't contain budget control or encumbrance data
- Budget control statistics for the purchase order are missing or incomplete, even though year‑end processing is expected to include the purchase order

> [!NOTE]
> If you enable the **Enable non-retrievable purchase orders page for purchase year-end order process** feature, the new page validates why a purchase order might not be visible during the Purchase order year end for the selected fiscal year.

To verify the relevant budget control configuration and, where appropriate, restore missing budget data so the purchase order can be evaluated and displayed correctly during year‑end processing, follow these 
steps.

Step 1: Review budget control configuration

1. Go to **Budgeting** > **Setup** > **Budget control** > **Budget control configuration**.
1. Review the following areas:

- Account structures - Ensure that the financial dimension used for budget control is included in the account structure. If the dimension is missing or excluded by advanced rules, the purchase order isn't budget controlled.
- Budget control rules or budget groups - Confirm that rules are defined for the applicable financial dimensions or that a relevant budget group is assigned. Without these rules or groups, budget control isn't applied.
- Documents and journals - Verify that **Purchase order** is selected as a budget‑controlled document. If it's not selected, purchase orders don't generate budget data.
- Budget funds available - Check whether **Budget reservations for encumbrances** is enabled. This setting determines whether purchase orders create encumbrance reservations.

Step 2: Correct the configuration and reprocess data
Take the appropriate action based on your findings:

- If the purchase order isn't intended to be budget controlled - Remove purchase orders from budget‑controlled documents, activate the configuration, and reprocess the affected purchase order if needed.
- If the purchase order is intended to be budget controlled but encumbrances are missing - Enable **Budget reservations for encumbrances**, activate the configuration, and reprocess the purchase order.
- If all settings are correct but budget data is still missing - Run **Budget control data maintenance** by using **Source document reprocessing** to regenerate budget control data for the purchase order.
After reprocessing, the purchase order is re‑evaluated under the current configuration.

Step 3: Validation
To confirm that the issue is resolved:

1. Open the **Purchase order year end** page and verify that the purchase order is now displayed.
1. Review budget control statistics and confirm that encumbrance or budget reservation data exists for the purchase order.
