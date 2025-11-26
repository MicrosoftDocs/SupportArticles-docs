---
title: Duplicate reverse is not allowed
description: Duplicate reverse is not allowed while trying to reverse a closing or recalculation voucher
author: Soumyamoy Das
ms.date: 11/26/2025
ms.topic: troubleshooting
ms.search.form: InventClosing, InventoryReveresal, InventoryRecalculation, DuplicateReverse
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: soumyamoydas
ms.search.validFrom: 2021-05-31
ms.dyn365.ops.version: 10.0.43
ms.custom: sap:Cost management\Duplicate reverse is not allowed
---

# Duplicate reverse is not allowed

## Symptoms

Inventory reverse fails with the following error as "Another Inventory %1 reverse for voucher %2 is running. Duplicate reverse is not allowed.". 

## Resolution

This issue mainly occurs when user tries to execute the reversal/cancellation of multiple closing/recalculation vouchers at the same time. As shared in the best practices for Inventory Reverse, always execute the reversal of one voucher at a time, and only after its completion, proceed with further reversals i.e. reversals should be carried out sequentially. This is a check used to prevent multiple reversals and thereby avoid any inventory & ledger data corruption due to concurrent updates of adjustments/settlements/postings. 

This issue can rarely occur if the previous reversal execution has not completed successfully, but the batch job has ended with error, and user tries to execute a fresh reverse of the original voucher. This can be due to system issues, sudden crashes, system or SQL server unavailability, etc. In such cases, you can reach out to Microsoft Support or your Partner. 
