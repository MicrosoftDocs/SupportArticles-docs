---
title: Import profile job fails with a Timeout error
description: Provides a resolution for the Timeout error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/15/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
ms.custom: sap:Master planning\Issues with demand planning
---
# An import profile job fails with a "Timeout" error

This article provides a resolution for the "Timeout" error that occurs when an [import profile job](/dynamics365/supply-chain/demand-planning/import-data#create-an-import-profile-for-importing-directly-from-supply-chain-management) fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations import profile job fails, and the job execution details contain an error mentioning "Timeout."

## Resolution 1

Make sure all quality updates related to the Demand planning entities are installed.

For the available quality updates, see [Export of Historical Sales Demand and Demand planning Picking List Journal Entries never complete](https://fix.lcs.dynamics.com/Issue/Details?kb=0&bugId=900476&dbType=3&qc=88596efab831d21cd42a8cb8c261bd5bbc1e4b0bb4599458dbfce8a775d5c8da).

## Resolution 2

Filter out the dataset to make sure an import profile job exports less data.

1. Select the corresponding Demand planning data management project with a name that looks like **DP-XML-NameOfEntity-NameOfProfile**.
2. Make sure you're in enhanced view and select the filter button.
3. Add filters to reduce the size of the export. Good candidates for filtering are company-related fields or date ranges.

    For more information about Dynamics 365 data filters, see [Advanced date queries that use SysQueryRangeUtil methods](/dynamics365/fin-ops-core/fin-ops/get-started/advanced-filtering-query-options#advanced-date-queries-that-use-sysqueryrangeutil-methods).

In this case, when you run the import profile job from the Demand Planning app, the filters are respected, and therefore, the data is filtered out.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [Import profile job fails with a "Forbidden" error]( import-profile-fails-with-forbidden-error.md)
- [Import profile job fails due to special characters](special-characters.md)
- [Import profile job fails due to insufficient permissions](user-insufficient-permissions.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
