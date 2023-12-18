---
title: Missing business unit in unification
description: Provides a resolution for an issue where the business unit is missing in the unification steps in Microsoft Dynamics 365 Customer Insights - Data.
author: Scott-Stabbert
ms.author: sstabbert
ms.date: 12/18/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: bap-template
---
# Missing business unit in unification in Dynamics 365 Customer Insights - Data

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article provides a resolution for an issue where the **Business unit** dropdown list is empty in the **Business unit separator** step in the data unification process.

## Symptoms

During the unification process, the **Business unit** field in the **Business unit separator** step doesn't show any value.

## Resolution

Verify that the [business units has been added to the Dataverse](/power-platform/admin/create-edit-business-units) environment that's linked to the Customer Insights - Data instance.

> [!NOTE]
> The test and production environments have different environment IDs and names.

For more information about business units, see [Business unit data separation overview](/dynamics365/customer-insights/data/business-units-data-separation).
