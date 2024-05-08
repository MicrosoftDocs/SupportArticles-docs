---
title: Import failing because of time-out
description: Provides a way to solve the time-out problems.
author: fistamos
ms.date: 02/29/2024
ms.topic: troubleshooting
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---

# Import failing because of time-out

## Symptoms

The **Dynamics 365 Finance and Operations job execution** contains an error mentioning a **Timeout**.

## Resolution 1

Make sure you that all quality updates related to the **Demand planning** entities are installed.
Known quality updates:
 [Export of Historical Sales Demand and Demand planning Picking List Journal Entries never complete.](https://fix.lcs.dynamics.com/Issue/Details?kb=0&bugId=900476&dbType=3&qc=88596efab831d21cd42a8cb8c261bd5bbc1e4b0bb4599458dbfce8a775d5c8da)

## Resolution 2

Filter out the dataset to make sure less data is exported on one profile job.

1. Select on the corresponding **Demand planning data management project** the project with name **DP-XML-NameOfEntity-NameOfProfile**
2. Make sure you are on enhanced view and select the filter button.
4. Filter out the data with the special characters.
5. When running the import profile, from the **Demand planning app**, the filters are respected and therefore the data will be filtered out.
