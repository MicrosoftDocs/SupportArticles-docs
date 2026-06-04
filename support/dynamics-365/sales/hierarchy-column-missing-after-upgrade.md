---
title: Fix Missing Hierarchy Column in Views
description: Learn why the Hierarchy column with the linked icon is missing from Dynamics 365 Sales views and how to use the new visual hierarchy instead.
ms.reviewer: ramakris
ms.date: 05/29/2026
ms.custom: sap:Visual hierarchy\Where did the old Hierarchy column go?
ai-usage: ai-assisted

#customer intent: As a Dynamics 365 Sales user, I want to understand why the Hierarchy column is missing from my views so that I can find the correct way to view hierarchical data.

---

# Hierarchy column is missing from views in Dynamics 365 Sales

## Summary

This article explains why the **Hierarchy** column that previously displayed a linked icon in table views is no longer available in Microsoft Dynamics 365 Sales, and how to view hierarchical data by using the new visual hierarchy feature instead. The change is the result of the legacy hierarchy control being retired in Power Platform.

## Symptoms

After you update or upgrade your Dynamics 365 Sales environment, the **Hierarchy** column no longer appears in table views. Previously, this column showed a linked icon that opened the record in the legacy hierarchy viewer.

## Cause

Power Platform retired the legacy hierarchy control, which removed the platform-level support for the linked icon in the **Hierarchy** column. The new visual hierarchy uses a different approach to show hierarchical data, so it doesn't include a column-level icon in views.

For more information about the retirement of the legacy hierarchy control, see [Deprecation of hierarchy control in model-driven apps](/power-platform/important-changes-coming#deprecation-of-hierarchy-control-in-model-driven-apps).

## Solution

Use the new visual hierarchy to view and work with hierarchical data. It offers customizable tiles, drill-down navigation, inline editing, and multitable support.

To open the visual hierarchy for a record:

1. Open the Dynamics 365 Sales app.
1. Go to the record you want to view (for example, an account or contact record).
1. On the command bar, select **View hierarchy**. The hierarchy viewer opens and shows the record and its parent-child relationships in a visual tree layout.

   > [!NOTE]
   > If the **View hierarchy** button isn't visible, select **More commands** (⋮) on the command bar to find it. If it's still not available, contact your administrator to enable visual hierarchies.

If your environment doesn't have visual hierarchies set up, ask your administrator to complete the following steps:

1. [Disable the legacy hierarchy control](/dynamics365/sales/create-activate-hierarchy-visualizations#prerequisites) if it's still enabled.
1. [Design and publish a hierarchy](/dynamics365/sales/create-activate-hierarchy-visualizations) for the tables your organization uses.
1. [Grant permissions](/dynamics365/sales/create-activate-hierarchy-visualizations#grant-permissions-to-visual-hierarchy-feature) to the appropriate security roles.

## Related content

- [Overview of visual hierarchies](/dynamics365/sales/hierarchy-visualization)
- [View and use a visual hierarchy](/dynamics365/sales/view-hierarchy-visualizations)
- [View hierarchy button is missing](view-hierarchy-button-missing.md)
