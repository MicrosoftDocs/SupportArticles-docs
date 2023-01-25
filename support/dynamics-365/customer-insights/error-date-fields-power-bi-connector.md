---
title: Errors on date fields when loading Customer Insights entities in Power BI Desktop
description: Learn how to address issues with loading errors in the Power BI connection for Dynamics 365 Customer Insights.
author: m-hartmann
ms.author: mhart
ms.date: 01/23/2023
---

# Errors on date fields when loading Customer Insights entities in Power BI Desktop

Resolve an issue in Power BI Desktop relate to the Power BI connector for Dynamics 365 Customer Insights.

## Prerequisites

- Administrator permissions in Customer Insights.

## Symptoms

Entities that contain fields with a date format might cause issues due to mismatched locale formats. Date fields in Customer Insights are in US format. Ensure your Power BI file uses the English (United States) locale.

## Resolution

Change the locale. The Power BI Desktop file has a single locale setting, which is applied when retrieving data. To fix the date errors, [set the locale of the .BPI file](/power-bi/fundamentals/supported-languages-countries-regions#choose-the-language-or-locale-of-power-bi-desktop) to English (United States).
