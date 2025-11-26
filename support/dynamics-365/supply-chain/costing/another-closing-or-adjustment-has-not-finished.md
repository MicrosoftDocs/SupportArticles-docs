---
title: Another closing or adjustment has not finished yet
description: Error during inventory closing or recalculation -- Another closing or adjustment has not finished yet
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
ms.custom: sap:Cost management\Another closing or adjustment has not finished yet
---

# Another closing or adjustment has not finished yet

## Symptoms

Inventory closing or recalculation errors out with "Another closing or adjustment has not finished yet" and a new closing or recalculation voucher is not created in the Closing and Adjustment form.

## Resolution

This justifies that some other closing or recalculation voucher execution might be in progress when you are trying to execute another closing or recalculation. Please wait for the previous closing voucher to complete execution and post that, you can execute another fresh closing or recalculation. 
