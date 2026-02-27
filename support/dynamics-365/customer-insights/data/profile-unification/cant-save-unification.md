---
title: Can't save data unification changes
description: Provides a resolution for an issue where data unification changes can't be saved in Dynamics 365 Customer Insights - Data.
ms.date: 02/26/2026
ms.reviewer: sstabbert, v-wendysmith
ms.custom: sap:Data Unification\Match
---
# Can't save data unification changes

This article provides a resolution for an issue where you can't save data unification changes due to a dependency on the data.

## Symptom

An error occurs when you try to save your unification changes because Dataverse dependencies exist on one or more of the unified columns.

## Resolution

1. Go to [https://make.powerapps.com/](https://make.powerapps.com/) and select your environment.

1. Select **Tables** in the left pane.

1. Find the referenced column and remove any flows, views, or forms that depend on it.

1. Retry the unification.
