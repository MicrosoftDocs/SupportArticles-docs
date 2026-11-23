---
title: Merge Failed Error in the Unified Data View Page
description: Helps resolve an issue where data unification fails due to a merge error in Microsoft Dynamics 365 Customer Insights - Data.
ms.date: 11/16/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Match
---
# "Merge failed" error occurs on the "Unified data view" page in Dynamics 365 Customer Insights - Data

## Summary

This article helps you resolve an issue where data unification fails due to a merge error.

## Symptoms

The following error message appears on the **Unified data view** page.

> Merge failed.

## Solution

1. Verify upstream dependencies.

   Ensure the data sources are refreshed and the *Match* processes complete successfully without any errors. Check the logs or status reports of these dependencies to ensure they're functioning as expected. Resolve any issues encountered in these upstream processes. For more information, see [Define matching rules for data unification](/dynamics365/customer-insights/data/data-unification-match-tables).

1. Retry the *Merge* process by going to **Data** > **Unify** > **Unify customer profiles**.
