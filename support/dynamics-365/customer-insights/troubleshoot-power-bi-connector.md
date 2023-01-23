---
title: Troubleshoot issues with the Power BI connector in Customer Insights
description: Learn how to address issues with the Power BI connection in Dynamics 365 Customer Insights.
author: m-hartmann
ms.author: mhart
ms.date: 01/23/2023
---

# Troubleshoot issues with the Power BI connector in Customer Insights

Resolve issues with the Power BI connector for Dynamics 365 Customer Insights.

## Prerequisites

- Administrator permissions in Customer Insights.

## Cause 1: Customer Insights environment doesn't show in Power BI

Environments that have more than one [relationship](/dynamics365/customer-insights/relationships.md) defined between two identical entities in Customer Insights will not be available in the Power BI connector.

### Solution 1: Identify and remove the duplicated relationships

1. Go to **Data** > **Relationships** on the environment you're missing in Power BI.
1. Identify duplicated relationships:
   - Check if there is more than one relationship defined between the same two entities.
   - Check if there is a relationship created between two entities that are both included in the unification process. There is an implicit relationship defined between all entities included in the unification process.
1. Remove any duplicate relationships identified.

## Cause 2: Errors on date fields when loading entities in Power BI Desktop

When loading entities that contain fields with a date format like MM/DD/YYYY, you might encounter errors due to mismatched locale formats. This mismatch happens when your Power BI Desktop file is set to another locale than English (United States), because date fields in Customer Insights are saved in US format.

### Solution 2: Change the locale

The Power BI Desktop file has a single locale setting, which is applied when retrieving data. To fix the date errors, [set the locale of the .BPI file](/power-bi/fundamentals/supported-languages-countries-regions#choose-the-language-or-locale-of-power-bi-desktop) to English (United States).
