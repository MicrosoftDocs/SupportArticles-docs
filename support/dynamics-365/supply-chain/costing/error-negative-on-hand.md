---
title: Inventory closing cannot proceed because available physical on-hand inventory on item is currently negative, which is not allowed according to its item model group
description: Error during inventory closing or recalculation -- Inventory closing cannot proceed because available physical on-hand inventory on item is currently negative, which is not allowed according to its item model group
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
ms.custom: sap:Cost management\Inventory closing cannot proceed because available physical on-hand inventory on item is currently negative, which is not allowed according to its item model group
---

# Inventory closing cannot proceed because available physical on-hand inventory on item XXX is currently negative, which is not allowed according to its item model group

## Symptoms

Inventory closing or recalculation errors out with "Inventory closing cannot proceed because available physical on-hand inventory on item abc is currently negative, which is not allowed according to its item model group". The error can be viewed from the closing logs.

## Resolution

This can happen because of data corruption in the posted inventory transactions, when the on-hand physical/financial inventory becomes negative which is otherwise not allowed as per the item’s Item Model Group configuration. Ideally this error should be flagged while posting transactions for an item which results in negative on-hand, and not during inventory closing/recalculation process. But if any manual intervention or data migration or direct database updates are done, these checks are skipped and hence the error is thrown during the stock closing process. In those cases, this error is thrown during the stock closing process.  

As the error already mentions the specific item, please go through the inventory transactions for that item and try to figure out the actual issue. If required, enable the negative physical/financial inventory, but final call should be taken as per your business requirements. Else manual adjustments can also be posted to balance out the inventory transactions resulting in negative inventory. Once these transactions are fixed, execute consistency check fix for that item from System administration -> Periodic tasks -> Database -> Fix error -> Inventory management -> Item -> Enable checkbox for Inventory transactions and On-hand, then filter the exact item from the dialog. If required, this process can be executed as a batch process in the background. The final fix logs can be viewed from the batch job logs. Upon completion of this process, resume the closing/recalculation operation.
