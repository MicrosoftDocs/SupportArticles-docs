---
# required metadata

title: Year-end close missing opening balances 
description: Explains why opening balances might be missing when you close a year, and how to rebuild those balances if they're missing in Microsoft Dynamics 365 Finance.
author: kweekley
ms.date:04/28/2024

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

## Symptoms

You have run the year end close but there are no opening balances shown in the next fiscal year where there should be amounts shown.

## Resolution

First, check the status of the batch job. Closing a year includes many separate tasks, but the most critical step is the batch task with the task description **Step 5.0.0**. Posting the opening transactions (and optionally the closing transactions) to General ledger takes place during this step. 

Alternatively, if the **Optimize year-end close** feature is enabled and you're viewing the **Year end close** page, check the **Posting opening account balance transactions** and **Processing opening account balance transactions**.

If this step completes successfully but you don't see opening balances on the **Trial balance inquiry** page (**General ledger** > **Inquires and reports** > **Trial balance**), review the results of the year-end close batch job to see if the Rebuild balances step completed successfully.

If the Rebuild balances step fails, the opening (and optionally closing) transactions were likely posted successfully. You can verify if the General ledger transactions were posted successfully using the **Voucher transactions inquiry** page by specifying the voucher number and date provided on the year-end close dialog for the year that you closed (**General Ledger** > **Inquiries and reports** > **Voucher transactions**).

If the opening (and optionally closing) vouchers are present, you don't need to run the year-end close again. You can run the process to rebuild the balances manually using the **Financial dimension sets** page (**General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimension sets**).

If this step takes a long time to process, see [Best practices for updating Financial dimension sets](https://community.dynamics.com/blogs/post/?postid=0864032e-99ee-461d-885b-f3d9de6b6bae).
