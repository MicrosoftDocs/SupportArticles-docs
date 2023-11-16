---
title: Late selection isn't respected when production orders are reset via a batch job
description: Introduces a by-design behavior where late selections aren't respected when you use a recurring batch job to reset the status of a production order.
author: johanhoffmann
ms.date: 04/11/2021
ms.topic: troubleshooting
ms.search.form: ProdTableListPage
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: johanho
ms.search.validFrom: 2021-04-11
ms.dyn365.ops.version: 10.0.19
---

# Late selection isn't respected when production orders are reset via a batch job

KB number: 4614634

## Symptoms

When you use a recurring batch job to reset the status of a production order, late selections aren't respected.

## Resolution

The current design doesn't support the use of late selections for the *Reset status* process.
