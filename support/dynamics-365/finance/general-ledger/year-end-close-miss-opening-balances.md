---
# required metadata

title: Year-end close missing opening balances 
description: Explains why opening balances might be missing when you close a year, and how to rebuild those balances if they're missing in Microsoft Dynamics 365 Finance.
author: kweekley
ms.date: 11/30/2023
ms.prod: 
ms.technology: 

# optional metadata

ms.search.form: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
# ms.custom: 
ms.search.region: Global 
# ms.search.industry: 
ms.author: kweekley
ms.search.validFrom: 2020-12-14
ms.dyn365.ops.version: 10.0.14
---
# Year-end close missing opening balances

This article explains why opening balances might be missing when you close a year, and how to rebuild those balances if they're missing in Microsoft Dynamics 365 Finance.

## Issue 1 - No beginning balances after running the General ledger year-end close

### Resolution

Here are things to check if you've closed a year in General ledger, and then generated a trial balance that doesn't display opening balances for the next fiscal year.

If the **Undo previous close** field is set to **Yes**, the previous year-end close for the same fiscal year is being reversed. When running a process to reverse the year-end close, all entries for both closing and opening balances will be deleted, as if the year had never been closed. The vouchers are also deleted. The year-end close process won't run again automatically. You must start the process again, this time updating the **Undo previous close** option to **No**.

This scenario is covered in the year-end close FAQ article. For more information, see [Year-end activities FAQ](/dynamics365/finance/general-ledger/faq-year-end-activities).

## Issue 2 - Still missing opening balances for your fiscal year after running year-end close with "Undo previous close" set to "No"

### Resolution

First, check the status of the batch job. Closing a year includes many separate tasks, but the most critical step is the batch task with the task description **Step 5.0.0**. Posting the opening transactions, and optionally the closing transactions, to General ledger takes place during this step.

If this step ends successfully but you don't see opening balances on the **Trial balance inquiry** page (**General ledger** > **Inquires and reports** > **Trial balance**), review the results of the year-end close batch job to see if the Rebuild balances step completed successfully.

If this step fails, the opening (and optionally closing) transactions are likely posted successfully. You can verify that the General ledger transactions are posted successfully using the **Voucher transactions inquiry** page by specifying the voucher number and date provided on the year-end close dialog for the year that you closed, (**General Ledger** > **Inquiries and reports** > **Voucher transactions**).

If the opening (and optionally closing) vouchers are present, you don't need to run the year-end close again. Instead, refer to the next section for information about how to move forward.

## Issue 3 - The "Rebuild balances" step in the year-end close fails

### Resolution

The Rebuild balances step updates the General ledger balances that are used when the Trial balance inquiry is generated. It's the final step in the year-end close process. If this step is the only step that fails, the General ledger transactions have posted successfully. You don't need to run the year-end close again. You can run the process to rebuild the balances manually using the **Financial dimension sets** page (**General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimension sets**).

If this step takes a long time to process, see [Best practices for updating Financial dimension sets](https://community.dynamics.com/blogs/post/?postid=0864032e-99ee-461d-885b-f3d9de6b6bae).
