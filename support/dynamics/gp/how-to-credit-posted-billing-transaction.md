---
title: How to credit a posted billing transaction
description: Introduces how to credit a billing transaction that has been posted in Microsoft Dynamics GP.
ms.reviewer: theley
ms.topic: troubleshooting
ms.date: 03/13/2024
ms.custom: sap:Project Accounting
---
# How to do credits in Project Accounting Billing Entry in Microsoft Dynamics GP

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 874076

How to credit a billing transaction that has been posted depends on the type of project that was billed.

## For Time and Materials projects

Take the following steps:

1. In **Billing Entry** (Transactions-Project-Billing-Billing Entry), change the **Type** to **TM Return**.
2. Tab past the document number field so that a document number defaults in.
3. Use the lookup in the **Reference Document No.** field to select the billing document that you want to credit.
4. The customer and date information will automatically fill in for you.
5. Select the project that you want to credit.
6. Select the expansion box next to **Billings** to open the **Time and Materials Billing** window.
7. All line items that were previously billed will be available to **Return** in this window. Check all line items to be returned.
8. After this TM Return transaction is posted, you can go back in the billing window and rebill the line items you just returned.

## For Price or Cost Plus projects

Take the following steps:

1. In **Billing Entry** (Transactions-Project-Billing-Billing Entry), the type should still be **Invoice**.
2. Enter the customer and date information.
3. Select the project that you want to credit.
4. Select the expansion box next to **Billings** to open the **Progress Billings** window.
5. To credit the project, enter the amount to bill as a negative number. You must have already billed an amount to enter the negative.
6. After this is posted, the billing invoice has been credited.

## How to credit fees for any project type

Take the following steps:

1. In **Billing Entry** (Transactions-Project-Billing-Billing Entry), the type should still be **Invoice**.
2. Enter the customer and date information.
3. Select the project that you want to credit.
4. Select the expansion box next to **Fees** to open the **Billable Fees** window.
5. If the previously billed fee isn't listed automatically, use the lookup on **Fee ID** to select the fee.
6. To credit the fee, enter the billing amount as a negative number. To enter the negative that will appear in the **Previously Billed** field, you must have already billed an amount.
7. After this is posted then the billing invoice has been credited.
