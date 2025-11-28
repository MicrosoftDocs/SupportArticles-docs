---
title: Inventory transactions posted at a different cost price
description: Inventory transactions posted at a different cost price
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
ms.custom: sap:Cost management\Inventory transactions posted at a different cost price
---

# Inventory transactions posted at a different cost price

## Symptoms

It is observed that some inventory transactions posted at a different cost price than the one mentioned during posting

## Resolution

Please note that issue transactions are always posted at the running average cost, and the receipt transactions are posted at the cost specified during posting the document line, or the latest activated cost price. 

The system estimates this running average cost price for an item by using the following formula: 

Estimated price = (Physical amount + Financial amount) ÷ (Physical quantity + Financial quantity) 

If the “Include physical value” option isn't selected for an item in its Item Model Group, the system uses 0 (zero) for both the physical amount and the physical quantity. 

For more understanding, [this](/dynamics365/supply-chain/cost-management/running-average-cost-price) can be referred.
