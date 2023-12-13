---
title: Missing business unit in unification
description: Provides a resolution for an issue where the business unit is missing in the unification steps in Microsoft Dynamics 365 Customer Insights - Data.
author: Scott-Stabbert
ms.author: sstabbert
ms.date: 12/13/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# Missing business unit in unification

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where the **Business unit** drop-down is empty on the **Business unit separator** step in the data unification process.

## Symptoms

During the unification process, the **Business unit** field on the **Business unit separator** step doesn't show any value.

## Resolution

Verify that the [business units were added to the Dataverse](/power-platform/admin/create-edit-business-units) environment links to the Customer Insights - Data instance.

> [!NOTE]
> The test and prod environments have different environment IDs and names.

For more information about business units, see [Business unit data separation overview](/dynamics365/customer-insights/data/business-units-data-separation).
