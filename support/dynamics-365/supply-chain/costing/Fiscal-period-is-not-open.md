---
title: Fiscal period is not open
description: Encountering error fiscal period is not open during inventory closing, recalculation or reverse or during journal postings
author: Soumyamoy Das
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing, JournalPosting, InventoryReverse, InventoryRecalculation
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Fiscal period is not open
---

# Fiscal period is not open

## Symptoms

Inventory closing, recalculation or reverse or journal postings (like inventory journal, production orders, purchase orders, sales orders, etc.) errors out with the following message as "Fiscal period for XXX is not open". 

## Resolution

Please verify the ledger calendar period status from General Ledger -> Calendars -> Ledger calendars -> Select the required ledger period and then verify the period status for specific legal entities. Ideally, the period status should be “Open” to allow the posting of any adjustments. 
