---
# required metadata

title: Year-end close missing opening balances 
description: Explains why opening balances might be missing when you close a year, and how to rebuild those balances if they're missing in Microsoft Dynamics 365 Finance.
author: kweekley
ms.date: 04/28/2024

# optional metadata

ms.search.form: 
audience: Application User
# ms.devlang: 
ms.reviewer: twheeloc
# ms.tgt_pltfrm: 
# ms.custom: sap:General ledger - Period end and year-end tasks\Issues with year-end close
ms.search.region: Global 
# ms.search.industry: 
ms.author: kweekley
ms.search.validFrom: 2020-12-14
ms.dyn365.ops.version: 10.0.14
---
# Year-end close missing opening balances

This article explains why opening balances might be missing when you close a year, and how to rebuild those balances if they're missing in Microsoft Dynamics 365 Finance.

## Symptoms

You have run a year-end close, but  the opening balance doesn't show an amount for the next fiscal year.

## Resolution

First, check the status of the batch job. Closing a year includes many separate tasks, but the most critical step is the batch task with the task description **Step 5.0.0**. Posting the opening transactions (and optionally the closing transactions) to General ledger takes place during this step. 

:::image type="content" source="media/year-end-close-miss-opening-balances/batch-task-step-5-0-0.png" alt-text="Screenshot that shows a batch task with the task description Step 5.0.0.":::

Alternatively, if the **Optimize year-end close** feature is enabled and you're viewing the **Year-end close** page, check the **Posting opening account balance transactions** and **Processing opening account balance transactions**.

If this step completes successfully but you don't see opening balances on the **Trial balance inquiry** page (**General ledger** > **Inquires and reports** > **Trial balance**), review the results of the year-end close batch job to see if the Rebuild balances step completed successfully.

:::image type="content" source="media/year-end-close-miss-opening-balances/rebuild-balances-step.png" alt-text="Screenshot that shows the status of the Rebuild balances step.":::

If the Rebuild balances step fails, the opening (and optionally closing) transactions were likely posted successfully. You can verify if the General ledger transactions were posted successfully using the **Voucher transactions inquiry** page by specifying the voucher number and date provided in the year-end close dialog for the year that you closed (**General Ledger** > **Inquiries and reports** > **Voucher transactions**).

:::image type="content" source="media/year-end-close-miss-opening-balances/voucher-transactions-inquiry.png" alt-text="Screenshot that shows the Voucher transactions inquiry page.":::

If the opening (and optionally closing) vouchers are present, you don't need to run the year-end close again. You can run the process to rebuild the balances manually using the **Financial dimension sets** page (**General ledger** > **Chart of accounts** > **Dimensions** > **Financial dimension sets**).

:::image type="content" source="media/year-end-close-miss-opening-balances/financial-dimension-sets.png" alt-text="Screenshot that shows the Financial dimension sets page.":::

If this step takes a long time to process, see [Best practices for updating Financial dimension sets](https://community.dynamics.com/blogs/post/?postid=0864032e-99ee-461d-885b-f3d9de6b6bae).
