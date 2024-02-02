---
title: Environment doesn't show in Power BI
description: Learn how to address issues with relationships in the Power BI connection for Dynamics 365 Customer Insights.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 09/25/2023
---
# Environment doesn't show in Power BI

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves issues with the Power BI connector for Dynamics 365 Customer Insights - Data.

## Prerequisites

You need the Administrator permissions in Customer Insights - Data.

## Symptoms

If an environment has more than one [relationship](/dynamics365/customer-insights/relationships) defined between two identical entities in Customer Insights - Data, it won't be available in the Power BI connector.

## Resolution

To solve this issue, you need to identify and remove the duplicated relationships.

1. Go to **Data** > **Relationships** in the environment you're missing in Power BI.
1. Identify duplicated relationships:

   - Check if more than one relationship is defined between the same two entities.
   - Check if there's a relationship created between two entities that are both included in the unification process. There's an implicit relationship defined between all entities included in the unification process.

1. Remove any duplicate relationships identified.
