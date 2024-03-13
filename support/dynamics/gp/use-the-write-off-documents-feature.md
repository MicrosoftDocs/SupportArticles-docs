---
title: Use the Write Off Documents feature
description: Describes how the Write Off Documents feature works.
ms.reviewer: theley, angelag, krasmuss
ms.topic: how-to
ms.date: 03/13/2024
---
# How to use the Write Off Documents feature in Microsoft Dynamics GP

This article describes how the Write Off Documents feature works.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 887948

## Introduction

When a customer overpays or underpays, you can use the Write Off Documents feature in Microsoft Dynamics GP to create a credit memo or a debit memo that will be applied to the document that you're writing off. Examples of different scenarios are provided. The posting accounts that are used can come either from Customer Account Maintenance or from Posting Account Setup.

## More information

You can use the Write Off Documents feature to write off outstanding credit or debit balance amounts for one or more customers. To use this feature, use the appropriate method:

- In Microsoft Dynamics GP 10.0, select **Tools** on the **Microsoft Dynamics GP** menu, point to **Routines**, point to **Sales**, and then select **Write Off Documents**.
- In Microsoft Dynamics GP 9.0, select **Tools**, point to **Routines**, select **Sales**, and then select **Write Off Documents**.

In the Write Off Documents window, you can specify a write-off limit and a cut-off date, and you can also specify whether to create one credit or debit memo for each customer or document. The debit or credit memos that you create will be posted and applied to the documents that you're writing off balances for.

You can use the Write-off Limit field in the **Write Off Documents** window to enter the maximum outstanding balance for documents that are to be included in the write-off. Documents that have an outstanding balance that is less than or equal to the write-off limit that you enter will be included.

To enter the maximum amount that you can write off for a customer, use the Maximum Write-off box in the Customer Maintenance Options window. To open the **Customer Maintenance Options** window, select **Cards**, select **Sales**, select **Customer**, and then select **Options**.

## Examples

1. Customer A has a **Maximum Write-off Amount** of $2.00 in the **Customer Maintenance Options** window. An invoice was posted for $1.90. No payments have been applied to this invoice. You want to write off the whole document. To do it, enter a write-off limit that is more than or equal to $1.90 when you process underpayments in the **Write Off Document** window.
2. Customer A has a **Maximum Write-off Amount** of $1.00 in the **Customer Maintenance Options** window. An invoice was posted for $1.90. No payments have been applied to this invoice. You want to write off the whole document. To do it, adjust the **Maximum Write-off Amount** in the **Customer Maintenance** window because the $1.90 invoice exceeds the current maximum of $1.00.

3. Customer A has a **Maximum Write-off Amount** of $2.00 in the **Customer Maintenance Options** window. An invoice was posted for $1.90. A payment for $2.00 was received from the customer and was applied to this invoice. You want to write off the amount that remains on the payment. To do it, enter a write-off limit that is more than or equal to $0.10 when you process overpayments in the **Write Off Document** window.

## Posting Accounts

The posting accounts for write-offs default first from the **Customer Maintenance Accounts** window. To open this window, select **Cards**, select **Sales**, select **Customer**, and then select **Accounts**. If the posting account that is listed in the Write-offs field is blank, the system looks next to the Posting Account Setup window for the Sales Series. To open the Posting Account Setup, point to **Tools** on the **Microsoft Dynamics GP** menu, point to **Setup**, point to **Posting**, and then select **Posting Accounts**. The two headings that are used are either **Write-offs**, for underpayments, or **Overpayment Write-offs**, for overpayments.
