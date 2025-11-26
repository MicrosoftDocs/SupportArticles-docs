---
title: The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z
description: Inventory closing/recalculation/reverse errors out with -- The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z
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
ms.custom: sap:Cost management\The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z
---

# The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z

## Symptoms

Inventory closing, recalculation, or reverse fails with "The entry for category x on project y cannot be posted/approved because it would cause the cost budget to be exceeded by z" error during the ledger posting stage. The error can be traced from the Logs in Closing and Adjustment form, after selecting the specific voucher.

## Resolution

This issue can appear when inventory closing, recalculation or reverse adjusts/settles the project enabled inventory transactions, and such adjustments/settlements exceed the budget control price set for that specific project. As a temporary mitigation, please navigate to Project management and accounting -> Setup -> Project management and accounting parameters -> Cost control -> Budget control -> Disable “Use budget control” 

Once disabled, resume the inventory closing/recalculation/reverse voucher, and once the operation completes, enable the parameter back. 

For permanent mitigation, please try updating the project budget control cost as per the business requirement. 
