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

1. Select the corresponding Demand planning data management project with the **DP-XML-NameOfEntity-NameOfProfile** name.
2. Make sure you are in enhanced view and then select the filter button.
3. Filter out the data that contains special characters.

In this case, when you run the import profiles job from the Demand Planning app, the filters are respected and therefore the data will be filtered out.
