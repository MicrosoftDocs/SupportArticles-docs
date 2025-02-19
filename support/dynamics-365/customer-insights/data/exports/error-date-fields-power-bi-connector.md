---
title: Errors on date fields when loading entities in Power BI Desktop
description: Learn how to address issues with loading errors in the Power BI connection for Dynamics 365 Customer Insights - Data.
author: m-hartmann
ms.author: mhart
ms.reviewer: mhart
ms.date: 09/25/2023
ms.custom: sap:Export destinations or Outbound connectors\Microsoft connectors
---
# Errors on date fields when loading entities in Power BI Desktop

[!INCLUDE [consolidated-sku](../../includes/consolidated-sku.md)]

This article resolves an issue in Power BI Desktop related to the Power BI connector for Dynamics 365 Customer Insights - Data.

## Prerequisites

You need the Administrator permissions in Customer Insights - Data.

## Symptoms

Entities that contain fields with a date format might cause issues due to mismatched locale formats. Date fields are in US format. Ensure your Power BI file uses the English (United States) locale.

## Resolution

To solve this issue, change the locale. The Power BI Desktop file has a single locale setting applied when retrieving data. To fix the date errors, [set the locale of the .BPI file](/power-bi/fundamentals/supported-languages-countries-regions#choose-the-language-or-locale-of-power-bi-desktop) to English (United States).
