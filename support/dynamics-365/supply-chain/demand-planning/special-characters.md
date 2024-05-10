---
title: Import profile job fails due to special characters
description: Provides a resolution for the invalid character error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/10/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---
# An import profile job fails due to special characters

This article provides a resolution for the "invalid character" error that occurs when an import profile job fails in Microsoft Dynamics 365 Supply Chain Management.

## Symptoms

The Dynamics 365 Finance and Operations job execution details contains an error mentioning "invalid character."

## Resolution

1. Locate the data with invalid characters. Most often the special characters are coming from external integrations and are invisible. However, in Dynamics 365 Finance and Operations, those characters are usually replaced with a square symbol and therefore can be easily noticed.
2. Select the corresponding Demand Planning data management project with a name that looks like **DP-XML-NameOfEntity-NameOfProfile**.
3. Make sure you're in enhanced view and then select the filter button.
4. Filter out the data with the special characters.

In this case, when you run the import profiles job from the Demand Planning app, the filters are respected and therefore the data will be filtered out.

## More information

- [Demand planning import profile troubleshooting guide](import-landing-page.md)
- [Import profile job fails because of time-out.](project-time-out.md)
- [Import profile job fails because of special characters.](special-characters.md)
- [Import profile job fails because of insufficient permissions.](user-insufficient-permissions.md)
- [Import data into Demand planning](/dynamics365/supply-chain/demand-planning/import-data)
