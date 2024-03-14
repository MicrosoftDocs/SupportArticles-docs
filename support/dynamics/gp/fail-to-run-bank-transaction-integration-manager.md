---
title: Error when you run Bank Transaction integration in Integration Manager
description: Provides a solution to an error that occurs when you run the Bank Transaction integration in Integration Manager for Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Developer - Customization and Integration Tools
---
# Error message when you run the Bank Transaction integration in Integration Manager for Microsoft Dynamics GP: "The Transaction Amount is Not Fully Distributed"

This article provides a solution to an error that occurs when you run the Bank Transaction integration in Integration Manager for Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 867318

## Symptoms

When you run the Bank Transaction integration in Integration Manager for Microsoft Dynamics GP 10.0 or for Microsoft Dynamics GP 9.0, you receive the following error message:

> DOC X ERROR: The Transaction Amount is Not Fully Distributed

## Cause

This problem occurs for the following reasons:

- The transaction type is set to "Check" and the Credit Amount in the Distributions folder is being mapped.
- The transaction type is set to "Withdrawal" and the Credit Amount in the Distributions folder is being mapped.
- The transaction type is set to "Decrease Adjustment" and the Credit Amount in the Distributions folder is being mapped.
- The transaction type is set to "Increase Adjustment" and the Debit Amount in the Distributions folder is being mapped.
- A default Cash Account is assigned to the Checkbook ID that is used.

This configuration automatically defaults the Credit Amount when you enter transactions. The Credit Amount is doubled if it is mapped in the integration. When this occurs, the distributions are unbalanced.

## Resolution

To resolve this problem, open Integration Manager for Microsoft Dynamics GP and then follow the instructions appropriate for your Integration type.

### Option 1: Remove the mapping from the credit amount  

1. Open the integration.
2. On the toolbar, click **Mapping** to open the Destination Mapping window.
3. Click the Distributions folder in the upper-left part of this window.
4. In the **Rule** column of the **Credit Amount** line, change the value to **Use Default**.
5. Save the integration.
6. Click **Run**.

### Option 2: Remove the mapping from the debit amount

1. Open the integration.
2. On the toolbar, click **Mapping** to open the Destination Mapping window.
3. Click the Distributions folder in the upper-left part of this window.
4. In the **Rule** column of the **Debit Amount** line, change the value to **Use Default**.
5. Save the integration.
6. Click **Run**.

### Option 3: Map the transaction type, debit amount and credit amount

1. Open the integration.
2. On the toolbar, click **Mapping** to open the Destination Mapping window.
3. Click the Bank Transaction Entry folder in the upper-left part of this window.
4. In the **Rule** column of the **Type** line, change the value to **Use Source Field**, and then map the **Type** column.
5. Click the Distributions folder in the upper-left part of this window.
6. In the **Rule** column of the **Debit Amount** line, change the value to **Use Source Field**, and then map the **Debit** column.
7. In the **Rule** column of the **Credit Amount** line, change the value to **Use Source Field**, and then map the **Credit** column.
8. Save the integration.
9. Click **Run**.

> [!NOTE]
> For option 3, your source file has to contain blank entries for either the Debits or Credits as needed by the transaction type. This means that for transaction types of "Check," "Withdrawal," and "Decrease Adjustment," you have to include a credit column in your source file that has no data in it. For a transaction type of "Increase Adjustment," you have to include a debit column in your source file that has no data in it.
