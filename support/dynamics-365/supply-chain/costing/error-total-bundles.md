---
title: Close stock - processing level x with a total of y bundles
description: Error during inventory closing or recalculation -- Close stock - processing level x with a total of y bundles
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
ms.custom: sap:Cost management\Close stock - processing level x with a total of y bundles
---

# Close stock - processing level x with a total of y bundles

## Symptoms

Inventory closing or recalculation errors out with "Close stock - processing level x with a total of y bundles".

## Resolution

This is a generic error thrown mostly in cases on business data corruption due to manual database interventions, manual changes in the decimal precision in the customized version, incorrect exchange rate configurations while posting source documents, etc. Try to trace the exact item, inventory transactions for which would be responsible for this error. Then execute the consistency check for that item for on-hand and inventory transactions (from System administration -> Periodic tasks -> Database -> Check/Fix error -> Inventory management -> Item -> Enable checkbox for Inventory transactions and On-hand, then filter the exact item from the dialog), to verify whether there are data inconsistencies which can be corrected autonomously. If the issue persists, please reach out to Microsoft Support or your Partner. 
