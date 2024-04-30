---
title: Demand planning import profile troubleshooting guide
description: Provides a landing page for troubleshooting different import profile errors.
author: fistamos
ms.date: 02/29/2024
ms.topic: troubleshooting
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---

# Demand planning import profile troubleshooting guide

## Symptoms

The import profile has failed with the following message :
**We were unable to successfully import data from your provided D365 Finance and Operations instance. The Data Management Framework project was successfully created but there was an error encountered in its execution. Please check the execution log of the project in Data management workspace.**

or

**We were unable to successfully import data from the linked Finance & Operations app. Although the Data Management Framework project was created, it didn’t finish within the expected timeframe. Please review the project’s execution log in the Data Management workspace and consider applying filters before re-running the import profile**

## Resolution
1. Navigate to the **Dynamics 365 Finance and Operations Data Management Workspace**
2. Find the corresponding **Demand Planning Data Management project** looking like **DP-XML-NameOfEntity-NameOfProfile**
3. Select on the execution details and find the reason why the project failed.
4. Depending on the error message please follow one of the below links