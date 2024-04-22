---
title: Troubleshoot with the General ledger adjustments page 
description: This article explains why you might use the General ledger adjustments page to fix issues.
author: RyanCCarlson2
ms.date: 04/18/2024
ms.topic: troubleshooting
ms.search.form: 
audience: Application User
ms.reviewer: kfend
ms.search.region: Global
ms.author: rcarlson
ms.search.validFrom: 2022-08-30
ms.dyn365.ops.version: 10.0.30
ms.custom: sap:General ledger - Setup, transactions and reporting\Issues with general journals
---

# Troubleshoot issues with the General ledger adjustments page

## Symptoms

Because of a serious system error that occurred in your environment, or a necessary data correction to the general ledger, Microsoft asked you to review possible ledger adjustments for your system.

## Resolution

You may need to use the **General ledger adjustments** page to view possible corrections or adjustments to the general ledger.

Microsoft Support will direct you to use the **General ledger adjustments** page to view suggested general ledger adjustments and create a general journal to post adjustments accordingly. Use the suggested general ledger adjustments only when a catastrophic failure has occurred, and direct general ledger adjustments are required to bring the general ledger back into balance. The **General ledger adjustments** page is used when Microsoft internal checks have found inconsistencies and recorded them for review on this page.

After you've reviewed any adjustments that you intend to make to your general ledger, mark the appropriate adjustments, and then select **Create journal from marked records**. A daily journal is created for you to review before posting to your general ledger. Records can be copied or deleted from the page before a daily journal is created.

## Frequently asked questions

1. Where do I find the General ledger adjustments page?

   Go to **General Ledger** \> **Periodic tasks** \> **General ledger adjustments**.

2. Why can't I enter data on the General ledger adjustments page?

   Data is created on the **General ledger adjustments** page only when a catastrophic event has occurred. In this case, Microsoft adds possible correction entries for your review.

3. Will I be notified if an issue has occurred and I must use the General ledger adjustments page?

   The **General ledger adjustments** page is intended for assistance in technical support cases that you already have with Microsoft. Technical specialists will give you directions about when you should use this page to make a correction to your general ledger. The **General ledger adjustments** page provides an isolated mechanism for fixing issues aside from the general ledger journal.
