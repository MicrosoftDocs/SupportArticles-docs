---
title: When a catch-weight quantity is split, minimum quantity is used instead of nominal quantity
description: Introduces a by-design behavior where the Pick qty field uses the minimum quantity that is set for the item when a catch-weight quantity is being split into batches.
author: sherry-zheng
ms.date: 04/11/2021
ms.topic: troubleshooting
ms.search.form: WMSPickingRegistration
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: chuzheng
ms.search.validFrom: 2021-04-11
ms.dyn365.ops.version: 10.0.19
---
# When a catch-weight quantity is split, minimum quantity is used instead of nominal quantity

KB number: 4612073

## Symptoms

When a catch-weight quantity is being split into batches, the **Pick qty** field uses the minimum quantity that is set for the item, not the nominal quantity.

## Resolution

The system is behaving as designed. The system uses each item's minimum quantity setup for picking.
