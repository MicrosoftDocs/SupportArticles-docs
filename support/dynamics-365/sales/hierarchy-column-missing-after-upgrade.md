---
title: Hierarchy column is missing from views in Dynamics 365 Sales
description: Provides a resolution for the issue where the Hierarchy column with a linked icon no longer appears in views after the legacy hierarchy control is retired.
author: ramakris
ms.author: ramakris
ms.reviewer: ramakris
ms.topic: troubleshooting-problem-resolution
ms.date: 05/29/2026
ms.custom: sap:Customization
ai-usage: ai-assisted

#customer intent: As a Dynamics 365 Sales user, I want to understand why the Hierarchy column is missing from my views so that I can find the correct way to view hierarchical data.

---

# Hierarchy column is missing from views in Dynamics 365 Sales

This article helps you resolve an issue where the **Hierarchy** column that previously displayed a linked icon in views is no longer available in Microsoft Dynamics 365 Sales.

## Symptoms

After updating or upgrading your Dynamics 365 Sales environment, you notice that the **Hierarchy** column is no longer visible in table views. Previously, this column displayed a linked hierarchy icon that, when selected, opened the record in the legacy hierarchy viewer.

## Cause

The legacy hierarchy control provided by Power Platform included platform-level support that displayed a column with a linked hierarchy icon in views. This icon opened the associated record in the legacy hierarchy viewer. This platform-level support was removed when the legacy hierarchy control was retired. The new Visual Hierarchy control doesn't include this column-level icon in views because it uses a different approach to display hierarchical data.

For more information about the retirement of the legacy hierarchy control, see [Deprecation of hierarchy control in model-driven apps](/power-platform/important-changes-coming#deprecation-of-hierarchy-control-in-model-driven-apps).

## Solution

Use the new Visual Hierarchy feature to view and work with hierarchical data. The Visual Hierarchy provides enhanced capabilities including customizable tiles, drill-down navigation, inline editing, and multi-table support.

To access hierarchical data with the new Visual Hierarchy control, follow these steps:

1. Open the Dynamics 365 Sales app.
1. Navigate to the record you want to view in the hierarchy (for example, an account or contact record).
1. Select the **View hierarchy** button on the command bar.

   > [!NOTE]
   > If the **View hierarchy** button isn't visible, select **More commands** (⋮) on the command bar to find it. If it's still not available, contact your administrator to enable visual hierarchies.

1. The hierarchy viewer opens and displays the selected record and its related parent-child relationships in a visual tree layout.

If your administrator hasn't yet set up visual hierarchies, ask them to:

1. [Disable the legacy hierarchy control](/dynamics365/sales/create-activate-hierarchy-visualizations#prerequisites) if it's still enabled.
1. [Design and publish a hierarchy](/dynamics365/sales/create-activate-hierarchy-visualizations) for the tables your organization uses.
1. [Grant permissions](/dynamics365/sales/create-activate-hierarchy-visualizations#grant-permissions-to-visual-hierarchy-feature) to the appropriate security roles.

## Related content

- [Overview of visual hierarchies](/dynamics365/sales/hierarchy-visualization)
- [Design and publish hierarchies](/dynamics365/sales/create-activate-hierarchy-visualizations)
- [View and use a visual hierarchy](/dynamics365/sales/view-hierarchy-visualizations)
