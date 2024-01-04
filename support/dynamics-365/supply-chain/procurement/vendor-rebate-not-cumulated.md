---
title: A vendor rebate isn't cumulated based on invoices
description: Provides more information about the issue that a vendor rebate isn't cumulated based on invoices.
author: Henrikan
ms.date: 05/31/2021
ms.search.form: PurchTable, PurchTablePart, PurchRFQTable
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: henrikan
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.13
---
# A vendor rebate isn't cumulated based on invoices

## Symptoms

If invoices that are posted have different due dates, those invoices aren't reflected in vendor rebates that are generated from them.

## Resolution

The due date isn't considered when the vendor rebate is calculated. Consider customizing the system so that the due date and the relation to the invoice are more apparent with respect to the actual vendor rebate.
