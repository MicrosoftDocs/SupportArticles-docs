---
title: Only users in user group x can post in module y in the period containing the date z
description: Error during inventory closing or recalculation -- Only users in user group x can post in module y in the period containing the date z
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
ms.custom: sap:Cost management\Only users in user group x can post in module y in the period containing the date z
---

# Only users in user group x can post in module y in the period containing the date z

## Symptoms

Inventory closing or recalculation errors out with "Only users in user group x can post in module y in the period containing the date z".

## Resolution

Please verify the ledger calendar period access level from General Ledger -> Calendars -> Ledger calendars -> Select the required ledger period and then verify the access level for specific modules and legal entities. Default access level for all the modules is “<All>”. 
