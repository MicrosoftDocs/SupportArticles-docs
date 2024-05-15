---
title: Import profile job fails due to invalid characters
description: Provides a resolution for the invalid character error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/15/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
ms.custom: sap:Master planning\Issues with demand planning
---
# An import profile job fails due to special characters

This article provides a resolution for the "invalid character" error that occurs when an [import profile job](/dynamics365/supply-chain/demand-planning/import-data#create-an-import-profile-for-importing-directly-from-supply-chain-management) fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations import profile job fails, and the job execution details contain an error mentioning "invalid character."

## Resolution

1. Locate the data with invalid characters. Most often, the special characters come from external integrations and are invisible. However, in Dynamics 365 Finance and Operations, those characters are usually replaced with a square symbol and therefore can be easily noticed.
2. Select the corresponding Demand Planning data management project with a name that looks like **DP-XML-NameOfEntity-NameOfProfile**.
3. Make sure you're in enhanced view and select the filter button.
4. Filter out the data with the special characters.

In this case, when you run the import profile job from the Demand Planning app, the filters are respected, and therefore, the data is filtered out.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [Import profile job fails with a "Timeout" error](project-time-out.md)
- [Import profile job fails with a "Forbidden" error]( import-profile-fails-with-forbidden-error.md)
- [Import profile job fails due to insufficient permissions](user-insufficient-permissions.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
