---
title: You Don't Have Access To The Data Used For Case Summaries Error
description: Resolves the issues related to the Copilot case summary feature in Microsoft Dynamics 365 Customer Service.
ms.reviewer: ghoshsoham
author: Yerragovula
ms.author: srreddy
ai-usage: ai-assisted
ms.date: 04/14/2025
ms.custom: sap:Cases or Incidents, DFM
---
# "It looks like you don't have access to the data that's used for case summaries" error

This article provides a resolution for the issues related to the Copilot case summary feature in Microsoft Dynamics 365 Customer Service.

## Symptoms

When you try to use the [Copilot case summary](/dynamics365/contact-center/administer/copilot-enable-summary) feature, you might receive the following error message:

> It looks like you don't have access to the data that's used for case summaries.

Additionally, the feature fails to display properly for non-administrators who try to use a custom product table instead of the out-of-box (OOB) product table.

## Cause

Copilot case summaries rely on a relationship between the custom table and the OOB "case" table.

- Copilot uses data from tables related to the "case" table to generate summaries.
- Custom tables that lack a relationship with the "case" table are ineligible for use in generating case summaries.

## Resolution

To resolve this issue, establish a relationship between your custom table and the OOB "case" table. Follow these steps:

1. In [Power Apps](https://make.powerapps.com/), navigate to the environment where your custom table resides.
1. From the left navigation pane, select **Tables**.
1. Select your custom table (for example, the custom product table.)
1. Go to the **Relationships** tab.

1. Select **+ New relationship** and select the appropriate relationship type:
    - For a many-to-one relationship: Select **Lookup**.
    - For a one-to-many relationship: Select **One-to-Many**.
    - For a many-to-many relationship: Select **Many-to-Many** (if applicable).

1. In the **Related Table** dropdown, select **Case (incident)**.
1. Select **Done** and then select **Save**.
1. Publish the table to apply the changes.

1. Test the changes:
    - Navigate to the Copilot case summary feature in Dynamics 365.
    - Try to generate a case summary using the custom table.
    - Confirm that the summary displays correctly without any error.

Alternatively, if creating a relationship between the custom table and the OOB "case" table isn't feasible, you can resolve the issue by removing the product data reference from the case summaries configuration. Follow these steps:

1. Navigate to the **Copilot Configuration Settings** within Dynamics 365.
2. Remove the product data reference from the case summaries configuration. For more information, see [Manage fields Copilot uses for case summaries](/dynamics365/customer-service/administer/copilot-map-custom-fields).
3. Save the changes.
4. Retest the feature to confirm that the error no longer appears and that the case summary displays correctly.
