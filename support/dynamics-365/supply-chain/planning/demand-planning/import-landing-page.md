---
title: Demand planning import profile troubleshooting guide
description: A troubleshooting summary of different import profile errors that might occur in Microsoft Dynamics 365 Supply Chain Management.
author: fistamos
ms.date: 05/16/2024
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
ms.custom: sap:Master planning\Issues with demand planning
---
# Demand planning import profile troubleshooting guide

This article provides resolutions for errors that may occur when an import profile job for importing data from Microsoft Dynamics 365 Supply Chain Management fails.

## Symptoms

When you [create an import profile job](/dynamics365/supply-chain/demand-planning/import-data#create-an-import-profile-for-importing-directly-from-supply-chain-management) from Supply Chain Management or other Finance and Operations apps and run it, the import profile job fails with one of the following messages:

> - We were unable to successfully import data from your provided D365 Finance and Operations instance. The Data Management Framework project was successfully created but there was an error encountered in its execution. Please check the execution log of the project in Data management workspace.

> - We were unable to successfully import data from the linked Finance & Operations app. Although the Data Management Framework project was created, it didn't finish within the expected timeframe. Please review the project's execution log in the Data Management workspace and consider applying filters before re-running the import profile.

## Resolution

1. Navigate to the **Data management** workspace in Dynamics 365 Finance and Operations.
2. Find the corresponding Demand Planning Data Management project with a name that looks like **DP-XML-NameOfEntity-NameOfProfile**.
3. Select the execution details to find the error that explains why the project failed.

For more information about the errors and related resolutions, see:

- [An import profile job fails with a "Forbidden" error](import-profile-fails-with-forbidden-error.md)
- [An import profile job fails with a "Timeout" error](project-time-out.md)
- [An import profile job fails due to special characters](special-characters.md)
- [An import profile job fails due to insufficient permissions](user-insufficient-permissions.md)
