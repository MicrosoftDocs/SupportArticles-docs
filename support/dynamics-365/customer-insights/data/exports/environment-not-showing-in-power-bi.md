---
title: Environment Doesnt Show in Power BI
description: Power BI connector environments can disappear when duplicate relationships exist. Learn how to identify and remove them in Customer Insights - Data.
ms.reviewer: sstabbert, v-wendysmith
ms.date: 11/16/2026
ms.custom: sap:Export destinations or Outbound connectors\Microsoft connectors
---
# Environment doesn't show in Power BI

## Summary

This article helps you resolve issues with the Power BI connector environments not showing in Dynamics 365 Customer Insights - Data.

## Prerequisites

You need the Administrator permissions in Customer Insights - Data.

## Symptoms

If an environment has more than one [relationship](/dynamics365/customer-insights/relationships) defined between two identical entities in Customer Insights - Data, it doesn't appear in the Power BI connector.

## Solution

To solve this issue, identify and remove the duplicated relationships.

1. Go to **Data** > **Relationships** in the environment that doesn't appear in Power BI.
1. Identify duplicated relationships:

   - Check if more than one relationship is defined between the same two entities.
   - Check if there's a relationship created between two entities that are both included in the unification process. There's an implicit relationship defined between all entities included in the unification process.

1. Remove any duplicate relationships you identified.
