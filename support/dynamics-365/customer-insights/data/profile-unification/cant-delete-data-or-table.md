---
title: Can't delete a data source or remove a table in Dynamics 365 Customer Insights - Data
description: Provides a resolution for an issue where match or merge failures occur in Microsoft Dynamics 365 Customer Insights - Data.
ms.date: 02/26/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Match
---
# Can't delete a data source or remove a table

This article provides a resolution for an issue where you can't remove a data source or remove a table from unification.

## Symptoms

The following error message appears when you try to remove a data source in use or remove a table for unification.

> "Cannot delete data source" or "Cannot remove table from unification"

## Cause

Downstream dependencies exist.

## Resolution

To remove a unified table, remove segments, measures, or exports that reference the table first. Learn more in [Remove a unified table](/dynamics365/customer-insights/data/data-unification-update#remove-a-unified-table).

To remove a data source:

1. Remove all the unified tables by removing segments, measures, or exports that reference the table first. Learn more in [Remove a unified table](/dynamics365/customer-insights/data/data-unification-update#remove-a-unified-table).

1. After you remove all the unified tables, rerun unification.

1. After you run unification, [remove the data source](/dynamics365/customer-insights/data/data-sources-manage#remove-a-data-source-in-use).

