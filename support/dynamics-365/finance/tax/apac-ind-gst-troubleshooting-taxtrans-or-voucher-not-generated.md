---

# required metadata

title: TaxTrans or voucher isn't generated
description: Provides troubleshooting information to help resolve an issue where the TaxTrans record or voucher isn't generated.
author: shaoling
manager: beya
ms.date: 04/18/2024

# optional metadata

# ms.search.form:
audience: Application user

# ms.devlang

ms.reviewer: kfend, maplnan

# ms.tgt_pltfrm

ms.custom: sap:Tax - India tax\Issues with India goods and service tax (IN GST)

ms.search.region: India

# ms.search.industry

ms.author: wangchen
ms.search.validFrom: 2021-04-01
ms.dyn365.ops.version: 10.0.1
---

# TaxTrans or voucher isn't generated

Complete the steps in this article if after posting tax there are records missing when you check the voucher and posted sales tax.

## Check if the subledger journal transferred

1. Go to **General ledger** \> **Periodic tasks** \> **Subledger journal entries not yet transferred**.
2. Transfer any record in the list, and then check the voucher and posted sales tax again.

## Check tax configuration

1. Check the posting profile of the expected measure. Select the posting type in the **Debit/Credit** column, and then select **Edit**.
2. In the **Posting type** page that opens, check the value in the **Tax accounting provider** field.

The following table lists the rule for posting tax transactions and vouchers that are decided by the tax accounting provider. Correct the configuration if it's not working as expected.

   |   Tax accounting provider   |   Posting tax transaction   |   Posting voucher   |
   | --------------------------- | --------------------------- | ------------------- |
   | Tax                         | Yes                         | Yes                 |
   | Ledger                      | No                          | Yes                 |
   | Other                       | No                          | No                  |

## Check the formula

1. Select **Condition** to open the formula.
2. Check the condition, and correct the tax configuration if it's not working as expected.

   :::image type="content" source="media/apac-ind-gst-troubleshooting-taxtrans-or-voucher-not-generated/check-condition.png" alt-text="Select the Condition check box to open the formula designer." lightbox="media/apac-ind-gst-troubleshooting-taxtrans-or-voucher-not-generated/check-condition.png":::

   :::image type="content" source="media/apac-ind-gst-troubleshooting-taxtrans-or-voucher-not-generated/formula-designer.png" alt-text="Check the condition and correct the tax configuration." lightbox="media/apac-ind-gst-troubleshooting-taxtrans-or-voucher-not-generated/formula-designer.png":::

## Check the posting code logic

Set a breakpoint in `TaxAccountingPostFacade::post()`, and debug for the logic of generating tax transaction and voucher.

:::image type="content" source="media/apac-ind-gst-troubleshooting-taxtrans-or-voucher-not-generated/post-code-logic.png" alt-text="Set a breakpoint in the posting code logic." border="false":::

## Determine whether customization exists

If you've completed the steps in the previous section but have found no issue, determine whether customization exists. If no customization exists, contact Microsoft Support for further assistance.
