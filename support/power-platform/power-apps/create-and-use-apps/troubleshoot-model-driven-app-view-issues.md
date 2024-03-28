---
title: Troubleshoot view issues in model-driven apps
description: Helps troubleshoot view issues in Power Apps model-driven apps.
author: grosiles3
ms.date: 03/28/2024
ms.author: gurosile
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - gurosile
ms.custom: sap:Display and use views in model-driven apps\Changing views, sap:Display and use views in model-driven apps\Saving personal views, sap:Display and use views in model-driven apps\Sharing personal views
---
# Troubleshoot view issues in model-driven apps

Model-driven apps use [views](/power-apps/maker/model-driven-apps/create-edit-views) to define how a list of records for a specific table are displayed in the application.

A view defines:

- The columns to display.
- The order of the columns.
- The width each column should be.
- The default sorting for the list of records.
- The default filters applied to restrict the records that appear.

Once a view is made available in the app, the user can select it.

Below you can find some of the most common issues encountered with views:

- [View selector is rendering incorrectly.](#view-selector-is-rendering-incorrectly)
- [Public view isn't shown in the view selector.](#public-view-isnt-shown-in-the-view-selector)
- [View selector is blank after navigating from a dashboard.](#view-selector-is-blank-after-navigating-from-a-dashboard)
- [Personal views aren't shown in the view selector.](#personal-views-arent-shown-in-the-view-selector)
- [Column doesn't appear in the column editor "Add columns" list.](#column-doesnt-appear-in-the-column-editor-add-columns-list)
- [Shared personal views are missing from the view selector.](#shared-personal-views-are-missing-from-the-view-selector)
- [The "Save changes to current view" option is missing.](#the-save-changes-to-current-view-option-is-missing)

## View selector is rendering incorrectly

If the view selector isn't rendering correctly, check if there's a third-party CSS library on the form. Because that library's styles operate on the global style, that is, there's no namespace, these styles affect all elements on the page. Our CRM controls, including the view selector, weren't designed for libraries like [Bootstrap](/power-pages/configure/bootstrap-overview), which often cause these issues. So, if you're using Bootstrap or similar CSS libraries, consider removing them. They're not supported in CRM and we advise against using them.

## Public view isn't shown in the view selector

If a public view isn't shown in the view selector, check in the app designer to verify that the view is included in the app. If it isn't included in the app, use the app designer to [add the missing view to the app](/power-apps/maker/model-driven-apps/create-add-remove-forms-views-dashboards#manage-views-and-charts).

## View selector is blank after navigating from a dashboard

If the view selector is blank when you navigate to any entity from a dashboard using "see all records," this could mean that the view used on the dashboard isn't included in the model-driven app. To solve this issue, [add the missing view to the app](/power-apps/maker/model-driven-apps/create-add-remove-forms-views-dashboards#manage-views-and-charts).

## Personal views aren't shown in the view selector

You intermittently don't see personal views in the grid selector. This could be because when a subgrid on a form is configured to show all views, it renders the **My Views** selections, which conflict with the homepage grid view (sample UI):

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/user-view-missing.png" alt-text="You might see some user views are missing in the view selector.":::

To fix this issue, you can modify the default entity form such that none of the subgrids are using **Show All Views**.

The following screenshot shows an example of the case form containing a subgrid with **Show All Views** enabled:

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/subgrid-with-show-all-views-enabled.png" alt-text="Example of case form containing a subgrid with Show All Views enabled.":::

If the subgrid configuration is changed to **Off** or **Show Selected Views** as shown in the following screenshots, the issue with the missing views should no longer occur.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/sub-grid-view-selector-off.png" alt-text="The View Selector option is set to Off.":::

Or

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/sub-grid-view-selector-show-selected-views.png" alt-text="The View Selector option is set to Show Selected Views.":::

## Column doesn't appear in the column editor "Add columns" list

Sometimes you might expect a certain column to appear in the column editor **Add columns** list, but you can't find it.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/column-missing-in-column-editor.png" alt-text="Screenshot that shows an example of the Add columns list in the column editor.":::

This issue usually happens because the attribute has `isValidForGrid` set to false. You can get the metadata for the attribute by adding the following path to the organization url (replacing `account` and `address1_longitude` with the desired entity and attribute name):

`/api/data/v9.2/EntityDefinitions(LogicalName='account')/Attributes(LogicalName='address1_longitude')?$select=SchemaName,IsValidForGrid`

If `isValidForGrid` is set to false, this attribute can't show up in the grid, and therefore doesn't show up in the column editor. To solve this issue, set `IsValidForGrid` to true.

## Shared personal views are missing from the view selector

You might see specific users that can't see personal views shared with them in the view selector, even though they appear in the **Manage and share views** dialog.

This behavior could be because the user doesn't have the "Direct User (Basic)" access to the "Saved Views" entity. Access provided by an owner team that has the "Team privileges only" inheritance setting isn't sufficient.

You should provide the impacted users with the "Direct User (Basic)" access to the "Saved View" entity instead of the "Team privileges only" access.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/direct-user-basic-access.png" alt-text="Screenshot that shows the options of the Member's privilege inheritance setting.":::

## The "Save changes to current view" option is missing

The **Save changes to current view** option only shows in the command bar when the [modern advanced find](/power-platform/admin/settings-features) is turned off; otherwise, it only shows in the view selector.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/save-changes-to-current-view.png" alt-text="Screenshot that shows the Save changes to current view option that might not be shown.":::

Furthermore, this option is only shown for personal views. When you select a system view using **All Accounts** > **My Active Contacts**, the option isn't shown, as a system view can't be updated. This is a by design behavior.

## See also

- [General Power Apps troubleshooting strategies](~/power-platform/power-apps/isolate-and-troubleshoot-common-issues/isolate-common-issues.md)
- [Isolate issues in model-driven apps - Power Apps](~/power-platform/power-apps/isolate-and-troubleshoot-common-issues/isolate-model-app-issues.md)
- [Understand model-driven app views](/power-apps/maker/model-driven-apps/create-edit-views)
- [FAQ for grid views](/power-apps/user/faq-for-grids-views)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]