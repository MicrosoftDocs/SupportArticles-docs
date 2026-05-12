---
title: View hierarchy button is missing in Dynamics 365 Sales
description: Provides resolutions for the issue where the View hierarchy button doesn't appear on the command bar in Microsoft Dynamics 365 Sales.
ms.reviewer: udag
ms.date: 05/12/2026
ms.custom: sap:Opportunity
ms.collection:
  - ai-assisted
---
# View hierarchy button is missing in Dynamics 365 Sales

This article provides resolutions for scenarios where the **View hierarchy** button doesn't appear on the command bar in Microsoft Dynamics 365 Sales.

_Applies to:_ &nbsp; Microsoft Dynamics 365 Sales

## Symptoms

When you open a record in a form or select a record in a grid view in Dynamics 365 Sales, the **View hierarchy** button doesn't appear on the command bar.

## Cause 1: The View hierarchy button isn't configured for the table

The **View hierarchy** button is preconfigured for the following four tables only: **Contact**, **Opportunity**, **Lead**, and **Account**. For all other tables, a Dynamics 365 Sales administrator must configure the forms or grids associated with the table to display the button.

### Resolution for Cause 1

Ask your administrator to add the **View hierarchy** button to the desired table's form or grid command bar. For steps, see [Add a view hierarchy button](/dynamics365/sales/add-hierarchy-visualization-custom-tables).

## Cause 2: No hierarchy is published for the table

An administrator must first design and publish a hierarchy for the organization before users can view it. If no hierarchy is published for the table, the **View hierarchy** button doesn't appear.

### Resolution for Cause 2

Ask your administrator to design and publish a hierarchy for the table. For steps, see [Design and publish hierarchy](/dynamics365/sales/create-activate-hierarchy-visualizations).

## Cause 3: The user doesn't have permission to view hierarchies

The user must have **Read** permission on the **Hierarchy configuration** table to view hierarchies. Without this permission, the **View hierarchy** button doesn't appear.

### Resolution for Cause 3

Ask your administrator to grant **Read** permission on the **Hierarchy configuration** table to the user's security role.

## Cause 4: More than one record is selected in a grid view

In a grid (list) view, the **View hierarchy** button is only available when a single record is selected. If more than one record or no record is selected, the button doesn't appear.

### Resolution for Cause 4

Select only one record in the grid view, and then check the command bar for the **View hierarchy** button.

## More information

- [View and use a visual hierarchy](/dynamics365/sales/view-hierarchy-visualizations)
- [Add a view hierarchy button](/dynamics365/sales/add-hierarchy-visualization-custom-tables)
- [Overview of visual hierarchies](/dynamics365/sales/hierarchy-visualization)