---
title: Import failing because of special characters
description: Provides a way to filter out the special products.
author: fistamos
ms.date: 02/29/2024
ms.topic: troubleshooting
audience: Application User
ms.search.region: Global
ms.author: fistamos
ms.search.validFrom: 2024-03-01
---

# Import failing because of special characters

## Symptoms

The **Dynamics 365 Finance and Operations job execution** contains an error mentioning an **invalid character**.

## Resolution

1. Locate the data with invalid characters. Most often the special characters are coming from external integrations and are invisible. However in  **Dynamics 365 Finance and Operations** those characters are usually replaced with a square symbol and therefore can be easily noticed.
2. Select on the corresponding **Demand Planning** data management project looking like **DP-XML-NameOfEntity-NameOfProfile**
3. Make sure you are on enhanced view and select the filter button.
4. Filter out the data with the special characters.
5. When running the import profile from the **Demand planning** app the filters will be respected and therefore the data will be filtered out.