---
title: Missing field settings when item model groups are copied to another legal entity
description: Provides a resolution for the issue that field settings are missing when item model groups are copied to another legal entity.
author: JennySong-SH
ms.date: 04/11/2021
ms.topic: troubleshooting
ms.search.form: InventModelGroup
audience: Application User
ms.reviewer: kamaybac
ms.search.region: Global
ms.author: yanansong
ms.search.validFrom: 2021-04-11
ms.dyn365.ops.version: 10.0.19
---

# Missing field settings when item model groups are copied to another legal entity

KB number: 4612800

## Symptoms

When you copy item model groups to another legal entity (company) by using the *Item model group inventory policies* entity, some field settings (for example, the inventory model and description) are missing in the new model group in the destination legal entity.

## Resolution

To create a complete copy of an item model group to another legal entity, you must also select both the item model group inventory policies (`InventInventoryPolicyEntity`) and the cost flow assumption policies (`InventCostFlowAssumptionPolicyEntity`) that are associated with the item model group.
