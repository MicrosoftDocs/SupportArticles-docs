---
title: Match failed error in Dynamics 365 Customer Insights - Data
description: Provides a resolution for an issue where match failures occur in Microsoft Dynamics 365 Customer Insights - Data.
author: Scott-Stabbert
ms.author: sstabbert
ms.date: 12/21/2023
ms.reviewer: v-wendysmith, mhart
ms.custom: sap:Data Unification\Match
---
# "Merge job failed" or "Match job failed. Please try again" error occurs on the System status page

This article provides a resolution for an issue where data unification fails due to a job taking too long or skipped. 

The following error message appears on the **System** > **Status** page under the match or merge job.

> Merge job failed or Match job failed. Please try again

## Symptom 1: Error on saving unification changes

## Symptom 2: Match canceled after running for hours




| Symptom | Likely cause | Resolution |
|---------|-------------|------------|
| Error on saving unification changes | Dataverse dependencies on unified columns | Go to Power Apps > Tables > find the referenced column > remove flows, views, or forms that depend on it, then retry |
| Match canceled after running for hours | Dataset too large for allocated resources | Reduce match rule complexity or contact support for scaling |
| Backstamping job skipped | Prerequisites for automatic linking not met | Verify requirements at [Link to a customer profile](/dynamics365/customer-insights/data/integrate-d365-apps#link-to-a-customer-profile) |
| Backstamping takes many hours | Multiple factors affect duration | Backstamping usually runs incrementally, but certain operations trigger a full refresh (see [Link to a customer profile](/dynamics365/customer-insights/data/integrate-d365-apps#link-to-a-customer-profile)). Duration also depends on custom plugins hooked to the Contact entity update operation, since the data migration service (DMS) processes updates synchronously. No action needed unless duration significantly exceeds previous runs |
| "Cannot delete data source" or "Cannot remove table from unification" | Downstream dependencies exist | Remove segments, measures, or exports that reference the table first |
