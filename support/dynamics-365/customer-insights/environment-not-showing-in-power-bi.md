---
title: Customer Insights environment doesn't show in Power BI
description: Learn how to address issues with relationships in the Power BI connection for Dynamics 365 Customer Insights.
author: m-hartmann
ms.author: mhart
ms.date: 01/23/2023
---

# Customer Insights environment doesn't show in Power BI

Resolve issues with the Power BI connector for Dynamics 365 Customer Insights.

## Prerequisites

- Administrator permissions in Customer Insights.

## Symptoms

If an environment has more than one [relationship](/dynamics365/customer-insights/relationships.md) defined between two identical entities in Customer Insights, it won't be available in the Power BI connector.

### Resolution

Identify and remove the duplicated relationships.

1. Go to **Data** > **Relationships** on the environment you're missing in Power BI.
1. Identify duplicated relationships:
   - Check if there's more than one relationship defined between the same two entities.
   - Check if there's a relationship created between two entities that are both included in the unification process. There's an implicit relationship defined between all entities included in the unification process.
1. Remove any duplicate relationships identified.
