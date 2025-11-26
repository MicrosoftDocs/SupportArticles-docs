---
title: Already closed inventory transactions being reopened and adjusted again
description: Already closed inventory transactions being reopened and adjusted again
author: soumyamoydas
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Already closed inventory transactions being reopened and adjusted again
---

# Already closed inventory transactions being reopened and adjusted again

## Symptoms

It is observed that already closed inventory transactions being reopened and settles/adjusted again in the subsequent closings or recalculations.

## Resolution

This behavior is by design and might be observed for items using Weighted Average (Date) as the valuation model.  

As per the design of carrying out settlements/adjustments through inventory closing/recalculation, a summarized transaction is created each for all issues and receipts separately, and these summarized transactions settle/adjust issues to receipts. Now, post-closing, if any manual adjustment is posted to any inventory transaction which was involved in any of the previous summarized transactions, and a fresh closing/recalculation is executed, then correspondingly all the inventory transactions which made up the summarized transaction contributing to the settlement/adjustment process, would be reopened and re-settled/re-adjusted.  
