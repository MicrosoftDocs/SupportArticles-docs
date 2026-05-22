---
title: Fix missing View hierarchy button in Dynamics 365 Sales
description: Fix the missing View hierarchy button on the command bar in Dynamics 365 Sales by checking table configuration, published hierarchies, security permissions, and grid selection.
ms.reviewer: udag, ramakris, v-shaywood
ms.date: 05/21/2026
ms.custom: sap:Visual hierarchy\View hierarchy button is missing
ai-usage: ai-assisted
---
# View hierarchy button is missing

## Summary

This article provides solutions for scenarios in which the **View hierarchy** button doesn't appear on the command bar in Microsoft Dynamics 365 Sales. The visual hierarchy feature lets users explore parent-child relationships between records, but the button could be missing for several reasons: 

- [The View hierarchy button isn't configured for the table](#the-view-hierarchy-button-isnt-configured-for-the-table)
- [No hierarchy is published for the table](#no-hierarchy-is-published-for-the-table)
- [The user lacks the required permission.]
- [Multiple records are selected in a grid view.] 

Use the following sections to identify the cause and apply the matching solution.

## Symptoms

When you open a record in a form or select a record in a grid view in Dynamics 365 Sales, the **View hierarchy** button doesn't appear on the command bar.

## Cause

### The View hierarchy button isn't configured for the table

The **View hierarchy** button is preconfigured only for the Contact, Opportunity, Lead, and Account tables. For any other table, a Dynamics 365 Sales administrator must configure the forms or grids associated with the table to show the button.

#### Solution

To resolve this issue, ask your administrator to add the **View hierarchy** button to the form or grid command bar for the table you want. For more information, see [Add a view hierarchy button](/dynamics365/sales/add-hierarchy-visualization-custom-tables).

### No hierarchy is published for the table

If no hierarchy is published for the table, the **View hierarchy** button doesn't appear. An administrator must publish a hierarchy for the organization before users can view it.

#### Solution

To resolve this issue, ask your administrator to design and publish a hierarchy for the table. For more information, see [Design and publish hierarchy](/dynamics365/sales/create-activate-hierarchy-visualizations).

### The user doesn't have permission to view hierarchies

To view hierarchies, a user must have **Read** permission on the **Hierarchy configuration** table. Without this permission, the **View hierarchy** button doesn't appear.

#### Solution

To resolve this issue, grant **Read** permission on the **Hierarchy configuration** table to the user's [security role](/power-platform/admin/security-roles-privileges).

### More than one record is selected in a grid view

In a grid (list) view, the **View hierarchy** button is available only when a single record is selected. If you select no record or more than one record, the button doesn't appear.

#### Solution

To resolve this issue, select a single record in the grid view, and then check the command bar for the **View hierarchy** button.

## Related content

- [View and use a visual hierarchy](/dynamics365/sales/view-hierarchy-visualizations)
- [Overview of visual hierarchies](/dynamics365/sales/hierarchy-visualization)
- [Button in command bar doesn't appear after grid item selection](button-in-command-bar-not-appear-after-grid-item-selection.md)
