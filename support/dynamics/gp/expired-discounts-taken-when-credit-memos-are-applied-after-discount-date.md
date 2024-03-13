---
title: Expired discounts taken if apply credit memo after discount date
description: Expired discounts are still taken when credit memos are applied after discount date in Payables Management. Provides a resolution.
ms.reviewer:
ms.topic: troubleshooting
ms.date: 03/13/2024
---
# Expired discounts taken when credit memos are applied after discount date in Payables Management in Dynamics GP

This article provides a resolution for the issue that the expired discount was still taken when credit memos are applied after discount date in Payables Management in Dynamics GP.

_Applies to:_ &nbsp; Microsoft Dynamics GP  
_Original KB number:_ &nbsp; 4055716

## Symptoms

Your credit memo is dated before the discount date, but you didn't apply it until after the discount date, but the expired discount was still taken.

Consider these examples:

Discounts Available are being tracked.

- **EXAMPLE 1:** (credit memo dated before discount date and applied after discount date)

  **1/1/2017** Credit memo $100.00  (not applied)

  3/1/2017 Invoice $100.00 (with 2%10/net 30 payment terms) Discount due 3/11/2017

  Build checks on 4/1/2017 and automatically apply credits. **$2.00 put in 'Terms Taken'**

  **Result**: Invoice full paid, but $2.00 credit still available to be taken.

  Even though the records were applied on 4/1/2017, it still used the document date of 1/1/2017 as the apply date, so it qualified for the discount to the invoice.  

- **EXAMPLE 2:** (credit memo dated after discount date and applied after discount date)

   **4/1/2017** Credit memo $100.00  (not applied)

  3/1/2017 Invoice $100.00 (with 2%10/net 30 payment terms) Discount due 3/11/2017

  Build checks on 4/1/2017 and automatically apply credits. **$2.00 put in Terms Available (not taken)**

  **Result:** Invoice is fully applied and moved to history. No amount due, no discount taken. The applied date used was 4/1/2017, so it did not qualify for the discount.

## Cause

By design. The credit was received before the discount date, so the system is going to take the discount regardless of when the actually apply process was done.

## Resolution

The system will take the discount if the document date of the credit memo is before the discount date. This is the design of the automatic apply process. Manually applying the credit memo gives the user the opportunity to override the discount taken.

## Workaround

To have the discount not taken, you must manually apply the credit memo (under **Transactions** > **Purchasing** > **Apply Payables Documents**). Enter $0.00 for the **TERMS TAKEN** and enter the full amount for the **APPLY AMOUNT**. Select **OK**.
