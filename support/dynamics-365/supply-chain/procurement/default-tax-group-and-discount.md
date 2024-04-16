---
title: Default tax group and cash discount aren't filled in from the invoice account
description: Introduces a by-design behavior where a default tax group and a default cash discount aren't filled in from the invoice account.
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
# Default tax group and cash discount aren't filled in from the invoice account

## Symptoms

If you're using an invoice account that differs from the customer account, a default tax group and a default cash discount aren't filled in from the invoice account when a purchase order is created.

## Resolution

This behavior is by design. The default values for the tax group, cash discounts, and other price information are based on the customer account, not the invoice account.
