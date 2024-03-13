---
title: Error message when you import budgets
description: Error message when you import budgets in Analytical Accounting in Microsoft Dynamics GP.
ms.reviewer: cwaswick
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# "The import failed because the spreadsheet is in an incorrect format" Error message when you import budgets in Analytical Accounting in Microsoft Dynamics GP

This article provides a solution to an error that occurs when you import budgets in Analytical Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 2815557

## Symptoms

Error message when you import budgets in Analytical Accounting in Microsoft Dynamics GP:

> "The import failed because the spreadsheet is in an incorrect format"

## Cause

If you export an existing AA budget and don't make any changes, you should be able to reimport it back in to GP without an error. If it doesn't import, then Excel autoformatted some of the fields.

## Resolution

Export an existing budget and then try to reimport it back into GP without making any changes to it. You should get this reimport to work first when no changes have been made to it. Once it works, then you can copy and paste in other amounts and use this spreadsheet as a template going forward.

Requirements: The import file needs to follow certain requirements:

- The budget tree ID in the Budget Tree column of the Excel spreadsheet should match the budget tree ID entered against the budget ID in the Analytical Accounting Budget Maintenance window.

- The budget totals entered on each level of the tree within the spreadsheet should be less than or equal to the budget totals on the level above. They shouldn't exceed the totals on the level above.

- The amounts in the opening balance and period columns for the root node of the spreadsheet, that is the budget tree ID, should be exactly equal to the totals of all the budget amounts entered against the next level nodes.

## More Troubleshooting steps

- Don't delete any transaction codes that don't have any amounts. The budget spreadsheet in Excel needs to contain all the dimensions and in the same order as the Budget Tree. So don't delete any dimensions that you don't want to enter amounts in for. The Budget Tree is expecting the same number of dimensions and in the same order. If any nodes are missing from the Excel spreadsheet as compared to the budget tree in GP, the import will fail.

- Make sure you don't have the same dimension/account listed more than once in each level.

- Make sure the Budget Tree ID and Budget ID values are in Text format, and preceded with a single quote or apostrophe. Excel may autoformat these fields, and they need to remain as Text. Key a single quote or apostrophe in front of these fields if needed to keep them in Text format.

- Review all the columns and look for differences. For example, if one amount column has a dollar sign and decimals, and another doesn't, it could be an issue. Export an existing budget to see how these columns should look. Amount fields should be set to Currency format, rather than Number.

- Make sure that any accounts used are assigned to the Accounting Class.

- Test first that an untouched export file will import right back into GP successfully.  If you add/remove lines in a file, you most likely will need to edit the sequence numbers in the hidden rows A and B.  Refer to the untouched file to see how the sequencing works in each column.
- Create a new Budget Tree ID and use that to build a new budget and export it.  Sometimes the Budget Tree ID may be damaged (or a dimension in it has since been deleted, and so on)
- Best to export a budget and then import it right back in.  Use that as your template.  If an untouched export doesn't import right back in, then try creating a new Budget Tree ID. (See Quality issue in NOTE below.)

> [!NOTE]
> If you exported an existing budget, and used the 'Methods' button to calculate the period amounts at the ACCOUNT level and marked not to include beginning balances (BB), the tables may still have records for BB lines for each account.  So if you export it, there are BB lines in-between the dimension and first dimension code on the exported file.  If you try to import it right back into GP, the import will fail.  You'll need to delete the BB row(s) completely at the top of the file in-between the dimension and first dimension code that include the Beginning balances, and then the file will import in successfully.
