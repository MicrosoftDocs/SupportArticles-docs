---
# required metadata

title: Troubleshoot issues with tax engine (GTE)
description: Provides information about the issues you might encounter while using the tax engine (GTE) and explains how to fix them.
author: EricWangChen
ms.date: 04/30/2024

# optional metadata

ms.search.form: ERSolutionTable, ERDataModelDesigner, ERModelMappingTable
audience: Application User
# ms.devlang:
ms.reviewer: kfend, maplnan
# ms.tgt_pltfrm:
ms.search.region: India
# ms.search.industry:
ms.author: wangchen
ms.search.validFrom: 07/30/2019
ms.dyn365.ops.version: 7.3
ms.custom: sap:Tax - India tax\Issues with generic tax engine (GTE)
---

# Troubleshoot issues with tax engine (GTE)

The tax engine (also referred to as GTE) is a highly configurable engine that handles tax applicability, calculation, posting, and settlement in Microsoft Dynamics 365. This article lists issues that users typically encounter while they use the tax engine, and it explains how to fix those issues.

> [!NOTE]
> The tax engine functionality is available only for legal entities that have their primary address in India.

For a quick overview of the tax engine, see [Tax engine overview (YouTube video)](https://www.youtube.com/watch?v=jAFpEBOtNWI&feature=youtu.be).

## Debug mode

Familiarity with the tax engine's debug mode can help you to identify the root causes of issues that are related to the tax engine.

To turn on debug mode, add *&debug=vs%2CconfirmExit&* to the end of the URL for Microsoft Dynamics 365 Finance.

:::image type="content" source="media/troubleshoot-tax-engine-gte-issues/turn-on-gte-debug-mode.png" alt-text="An example of how to turn on debug mode by changing the URL." lightbox="media/troubleshoot-tax-engine-gte-issues/turn-on-gte-debug-mode.png":::

After debug mode is turned on, when you open the tax document, the system generates a dump file that contains runtime details.

The structure of the dump file is shown here. The **Data model mapping mismatch** section is available only if the **Check model mapping discrepancies** option is set to **Yes**.

```output
======Tax engine calculation parameter======
...
===========Taxable document JSON===========
...
=====Tax engine runtime posting profiles=====
...
========Data model mapping mismatch========
Unmatched data provider fields
...
Unmatched taxable document fields
...

=====Tax engine runtime posting profiles=====
Header - TaxDocLine: TableId=6791 RecId=68719507754:
Line - TaxDocLine: TableId=13307 RecId=68719685245:
Path of the tax component 1:
-"Posting profile 1 description(Hit)"
-"Posting profile 2 description"
...
Path of the tax component 2:
-"Posting profile 1 description(Hit)"
-"Posting profile 2 description"
...
Line - TaxDocLine: TableId=13307 RecId=68719685245:
...
```

## Possible issues

### Imbalanced voucher with GST

This issue can occur after you extend the GST configuration by adding or modifying the posting profile.

In the current design, each tax component has a set of posting profiles to handle all possible tax postings. At runtime, the tax engine picks up the first matched posting profile.

Sometimes, if you add or modify posting profiles without carefully handling the condition of each, unexpected posting profiles might be picked up at runtime.

When debug mode is turned on, you can find the selected posting profiles in the **Tax engine runtime posting profiles** section of the dump file.

### Incorrect tax rate or tax component

To work correctly, the tax engine relies on input from taxable documents, such as sales and purchase invoices. If you extend the configuration by adding new fields, fields might be incorrectly mapped, or the writing to the data provider might be incorrect. To identify the issue, set the **Check model mapping discrepancies** option to **Yes**. You can view another section to show the discrepancies.

### Incorrect tax component

If you don't see the expected tax components, the transaction can't satisfy the [applicability](/dynamics365/finance/general-ledger/tax-engine-applicability) rules of the tax component or the tax type. If you extended the configuration, verify that there are no discrepancies, and then compare the field value in the **Taxable document JSON** section of the dump file with the applicability rules of the tax component.

### Incorrect tax rate

If you don't see the expected tax rate, check the field values that are used in the [tax setup](/dynamics365/finance/localizations/apac-ind-GST-set-up-rate-percentage-tables), and compare them with the field value in the **Taxable document JSON** section of the dump file.

## You can't post the voucher with GST

You might receive an error message that resembles the following message:

> Unable to find \#\# in the setoff hierarchy \#\# version \#\#, check and try again.

Typically, this error occurs because the configuration was extended by adding a new tax component or modifying the credit pool.

To work around this issue, follow these steps.

1. Add a newer version to the current sales tax hierarchies, select **Synchronize**, and then activate the new version.
2. On the **Maintain setoff hierarchy profiles** page, make the new version available by following the steps in [Set up a sales tax hierarchy](/dynamics365/finance/localizations/apac-ind-gst-set-up-activate-tax-hierarchy-tree).
