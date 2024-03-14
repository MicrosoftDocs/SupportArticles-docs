---
title: Cannot select a project number in the Billing Entry window
description: Explains that you receive the A billing transaction with an earlier cutoff date exists for this project error message when you select a project in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains 8.0.
ms.reviewer: theley, ppeterso
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# "A billing transaction with an earlier cutoff date exists..." error when you select a project number in Billing Entry

This article provides a resolution for the **A billing transaction with an earlier cutoff date exists for this project** error that may occur when you select a project number in the Billing Entry window in Project Accounting in Microsoft Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 941260

## Symptoms

In Project Accounting in Microsoft Dynamics GP and in Microsoft Business Solutions - Great Plains, you select a project number in the Billing Entry window. When you do this, you receive the following error message:

> A billing transaction with an earlier cutoff date exists for this project.

## Cause

This issue occurs if the billing transaction that you enter has an earlier cutoff date than a previous billing transaction for the project. The previous billing transaction may include a fee billing.

Consider the following example:

On February 28, a billing transaction was entered and posted for a project fee. You try to enter a billing transaction for January 31. In this example, you receive the error message that is mentioned in the Symptoms section.

To view the previous billing transactions, point to **Project** on the **Inquiry** menu, point to **PA Transaction Documents**, and then select **Billed Projects**.

## Resolution

To enter the billing transaction, enter a date that is the same as or later than the most recent billing cutoff date. In the previous example, use February 28 or a later date as the cutoff date on the billing transaction.

If you want to post the billing transaction by using January 31, change the posting date to January 31. Therefore, General Ledger in Microsoft Dynamics GP is updated by using January 31, and the cutoff date stays February 28.
