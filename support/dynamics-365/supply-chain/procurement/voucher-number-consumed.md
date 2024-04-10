---
title: A product receipt voucher number is consumed even when not generating a voucher
description: Provides a resolution for the issue that a product receipt voucher number is consumed even if no financial voucher is created in the product receipt.
author: Henrikan
ms.date: 05/31/2021
ms.search.form: PurchTable, PurchTablePart
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
---
# A product receipt voucher number is consumed even when not generating a voucher

## Symptoms

A product receipt voucher number is consumed even if no financial voucher is generated during product receipt.

## Resolution

If the **Accrue liability on product receipt** option is set to **No** for the item model group, no postings to the general ledger will occur. However, a physical event will be recorded for the purpose of accounting in a subledger, and that event requires a voucher number. This voucher number is the voucher number that is referenced in the inventory transactions.

We recommend that you set the **Accrue liability on product receipt** option to **Yes**, as described in [Post Misc. charges at time of product receipt](https://cloudblogs.microsoft.com/dynamics365/no-audience/2014/11/11/post-misc-charges-at-time-of-product-receipt/).
