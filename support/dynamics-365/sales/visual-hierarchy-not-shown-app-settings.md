---
title: Fix missing Visual hierarchy option in Dynamics 365 Sales
description: Troubleshoot the missing Visual hierarchy option under General Settings in the App Settings area of Microsoft Dynamics 365 Sales.
ms.date: 05/21/2026
ms.reviewer: tapanm, udag, ramakris, v-shaywood
ms.custom: sap:Visual hierarchy\Visual hierarchy not shown on the App Settings menu
ai-usage: ai-assisted
---
# Visual hierarchy isn't visible on App Settings in Dynamics 365 Sales

## Summary

This article helps administrators fix an issue in which the **Visual hierarchy** option is missing under **General Settings** in the **App Settings** area of [Microsoft Dynamics 365 Sales](/dynamics365/sales/overview). The [Visual hierarchy](/dynamics365/sales/hierarchy-visualization) feature ships in the `LinkedInExtensions` solution. It's available in the Sales Hub and other Dynamics 365 Sales apps. Use the checks in this article to review your app, the `LinkedInExtensions` solution, Hierarchy configuration table permissions, and the site map so that you can restore the **Visual hierarchy** option by fixing the configuration that's blocking the menu item.

## Symptoms

When you go to **App Settings** in Dynamics 365 Sales, the **Visual hierarchy** option doesn't appear in the left menu under **General Settings**.

The following screenshot shows where the **Visual hierarchy** option should appear in the App Settings menu.

:::image type="content" source="media/visual-hierarchy-not-shown-app-settings/visual-hierarchy-app-settings-menu.png" alt-text="Screenshot that shows the Visual hierarchy option under General Settings in the App Settings area of Dynamics 365 Sales.":::

## Solution

If the **Visual hierarchy** option doesn't appear, work through the following checks in the given order.

### Verify that you're using a Dynamics 365 Sales app

The Visual hierarchy feature ships in the `LinkedInExtensions` solution. It's available only in Dynamics 365 Sales apps, across all SKUs. It isn't available in other Dynamics 365 apps.

Make sure that you're using a Dynamics 365 Sales app.

### Verify that the LinkedInExtensions solution is installed and up to date

The Visual hierarchy feature requires the `LinkedInExtensions` solution at a supported version. If the solution isn't installed or is an older version, the **Visual hierarchy** menu item doesn't appear.

To check the solution and update it if it's necessary:

1. Check whether the `LinkedInExtensions` solution is installed in your environment.
1. Check the solution version. It must be version 10.3 or later.
1. If the solution is missing or is an older version, update it through the [Power Platform admin center](https://admin.powerplatform.microsoft.com).

### Check the user's permissions on the Hierarchy configuration table

By default, only users who have the System Administrator [security role](/power-platform/admin/security-roles-privileges) see the **Visual hierarchy** menu item. Other users don't see it unless you grant access to them.

To grant access, a system administrator assigns **Full Control** permissions on the **Hierarchy configuration** table:

1. Sign in to the [Power Platform admin center](https://admin.powerplatform.microsoft.com).
1. Open the environment settings.
1. Select **Security roles**.
1. Open the security role that you want to update.
1. Select **Permission settings** for the **Hierarchy configuration** table.
1. Grant **Full Control** to the role for the table.

### Verify that the Hierarchy configuration table is in the custom app's site map

If you're working in a custom app instead of the standard Sales Hub, the **Visual hierarchy** option doesn't appear if the **Hierarchy configuration** table isn't included in your app's site map.

Add the **Hierarchy configuration** table to your custom app's site map. For more information, see [Create a site map for a model-driven app](/power-apps/maker/model-driven-apps/create-site-map-app).

## Related content

- [Design and publish hierarchies](/dynamics365/sales/create-activate-hierarchy-visualizations)
- [Manage hierarchies](/dynamics365/sales/manage-hierarchy-visualizations)
