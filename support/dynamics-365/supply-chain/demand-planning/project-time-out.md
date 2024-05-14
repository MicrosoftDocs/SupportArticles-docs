---
title: Import profile job fails with a Timeout error
description: Provides a resolution for the Timeout error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/10/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---
#  An import profile job fails with a "Timeout" error

This article provides a resolution for the "Timeout" error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations job execution details contains an error mentioning "Timeout."

## Resolution 1

Make sure that all quality updates related to the Demand planning entities are installed.

For the available quality updates, see [Export of Historical Sales Demand and Demand planning Picking List Journal Entries never complete](https://fix.lcs.dynamics.com/Issue/Details?kb=0&bugId=900476&dbType=3&qc=88596efab831d21cd42a8cb8c261bd5bbc1e4b0bb4599458dbfce8a775d5c8da).

## Resolution 2

Filter out the dataset to make sure less data is exported by a profile job.

1. Select the corresponding Demand planning data management project with a name that looks like **DP-XML-NameOfEntity-NameOfProfile**.
2. Make sure you're in enhanced view and then select the filter button.
3. Add filters to reduce the size of the export. Good candidates for filtering are company related fields or date ranges (For references on dynamics data filter check this [learn site](/dynamics365/fin-ops-core/fin-ops/get-started/advanced-filtering-query-options#advanced-date-queries-that-use-sysqueryrangeutil-methods) .

In this case, when you run the import profiles job from the Demand Planning app, the filters are respected and therefore the data will be filtered out.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [Import profile job fails because of time-out.](project-time-out.md)
- [Import profile job fails because of special characters.](special-characters.md)
- [Import profile job fails because of insufficient permissions.](user-insufficient-permissions.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
