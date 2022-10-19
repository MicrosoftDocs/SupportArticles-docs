---
title: Use the General ledger adjustments page to troubleshoot
description: This article explains reasons why you might use the General ledger adjustments page to troubleshoot issues.
author: RyanCCarlson2
ms.date: 10/19/2022
ms.topic: troubleshooting
ms.search.form: 
audience: Application User
ms.reviewer: kfend
ms.search.region: Global
ms.author: rcarlson
ms.search.validFrom: 2022-08-30
ms.dyn365.ops.version: 10.0.30
---

# Use the General ledger adjustments page to troubleshoot

[!include [banner](../includes/banner.md)]

## Symptom

Because of a serious system error that occurred in your environment, or a necessary data correction to the general ledger, Microsoft asked you to review possible ledger adjustments for your system.

## Resolution

Use the **General ledger adjustments** page to view possible corrections or adjustments to the general ledger.

Microsoft Technical Support will direct you to use the **General ledger adjustments** page to view suggested general ledger adjustments and create a general journal to post adjustments accordingly. Use the suggested general ledger adjustment only when a catastrophic failure has occurred and direct general ledger adjustments are required to bring the general ledger back into balance. The **General ledger adjustments** page is used when internal Microsoft checks have found inconsistencies and recorded them for review on this page.

After you've reviewed any adjustments that you intend to make in your general ledger, mark the appropriate adjustments, and then select **Create journal from marked records**. A daily journal is created for you to review before posting in your general ledger. Records can be copied or deleted from the page before a daily journal is created.

## Frequently asked questions

### Where do I find the General ledger adjustments page?

Go to **General Ledger** \> **Periodic tasks** \> **General ledger adjustments**.

### Why can't I enter data on the General ledger adjustments page?

Data is created on the **General ledger adjustments** page only when a catastrophic event has occurred. In this case, Microsoft adds possible correction entries for your review.

### Will I be notified if an issue has occurred and I must use the General ledger adjustments page?

The **General ledger adjustments** page is intended for assistance in technical support cases that you already have with Microsoft. Technical specialists will give you direction about when you should use this page to make a correction to your general ledger. The **General ledger adjustments** page provides an isolated mechanism for fixing issues aside from the general ledger journal.
