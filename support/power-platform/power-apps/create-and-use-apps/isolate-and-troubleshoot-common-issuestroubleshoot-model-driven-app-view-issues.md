---
title: Troubleshoot view issues in model-driven apps
description: Helps troubleshoot view issues in Power Apps model-driven apps.
author: grosiles3
ms.date: 03/22/2024
ms.author: gurosile
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - gurosile
---
# Troubleshoot view issues in model-driven apps

Model-driven apps use views to define how a list of records for a specific table are displayed in the application.

A view defines:

- The columns to display.
- The order of the columns.
- The width each column should be.
- The default sorting for the list of records.
- The default filters applied to restrict the records that appear.

Once a view is made available in the app, the user can select it.

Below you can find some of the most common issues encountered with views:

- [View selector is rendering incorrectly.](#view-selector-is-rendering-incorrectly)
- [Public view isn't showing in the view selector.](#public-view-isnt-showing-in-the-view-selector)
- [View selector is blank after navigating from a dashboard.](#view-selector-is-blank-after-navigating-from-a-dashboard)
- [User views aren't appearing in view selector.](#user-views-arent-appearing-in-view-selector)
- [Column doesn't appear in the column editor 'add-columns' list.](#column-doesnt-appear-in-the-column-editor-add-columns-list)
- [Shared personal views are missing from view selector.](#shared-personal-views-are-missing-from-view-selector)
- [Save changes to current view option is missing.](#save-changes-to-current-view-option-is-missing)

## View selector is rendering incorrectly

If the view selector fails to render correctly, ensure that third-party CSS library isn't present on the form. Because that library's styles operate on the global style, that is, there's no namespace, these styles affect all elements on the page. The view selector, like all of our CRM controls, wasn't built with Bootstrap in mind and therefore may appear rendered incorrectly. More often than not, it's the popular Bootstrap CSS library causing the problem.

In summary, remove Bootstrap or other third-party CSS libraries. These CSS libraries are unsupported in CRM and their use is discouraged.

## Public view isn't showing in the view selector

If some public view isn't showing in the view selector, then check in the app designer to verify that the view is included in the app. If it isn't included in the app, then use the app designer to add the missing view to the app.

## View selector is blank after navigating from a dashboard

If the view selector is blank when your navigate to any entity from a dashboard via "see all records", this could potentially mean that the view used on the dashboard isn't included in the model driven app.

To add (or remove) one or more views or charts for a model-driven app, follow these steps:

  1. In the app designer, on the left navigation pane, select pages and then select the table you want to update, such as the account view.

  2. On the right properties pane, select manage views or manage charts.

  3. On the flyout, select the views or charts you want to add or remove, and then select save.

  4. Select publish to make the changes available to other users.

## User views aren't appearing in view selector

If users intermittently don't see user views (personal views) in the grid selector, this could be because when a subgrid on a form is configured to show all views, it renders 'My Views' selections, which conflict with the homepage grid view (sample UI):

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/user-view-missing.png" alt-text="User may see some user views missing in the view selector.":::

To fix this issue, you can modify the default entity form such that none of the subgrids are using "show all views".

The following image shows an example of the case form containing a subgrid with 'show all views' enabled:

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/subgrid-with-show-all-views-enabled.png" alt-text="Example of case form containing a subgrid with show all views enabled.":::

If the subgrid configuration is changed to "off" or "show selected views" instead, then the issue with the missing views should no longer occur as shown in the following image:

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/sub-grid-view-selector-off.png" alt-text="Configuration changed to off.":::

Or

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/sub-grid-view-selector-show-selected-views.png" alt-text="Configuration changed to show selected views.":::

## Column doesn't appear in the column editor 'add columns' list

Sometimes you might expect a certain column to appear in the column editor "add columns" list, but can't find it.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/column-missing-in-column-editor.png" alt-text="User may see column missing in the column editor.":::

This issue usually happens because the attribute has 'isValidForGrid' set to false. You can look at the metadata for the attribute by adding this to the org url (replacing Account and address1_longitude with the desired entity and attribute name) /api/data/v9.2/EntityDefinitions(LogicalName='account')/Attributes(LogicalName='address1_longitude')?$select=SchemaName,IsValidForGrid

If isValidForGrid is set to false, then this attribute can't show up in the grid, and therefore doesn't show up in the column editor either. Update the field IsValidForGrid to true.

## Shared personal views are missing from view selector

You might see specific users that aren't able to see personal views shared with them in the view selector, even though they appear in the manage and share views dialog.

This behavior could be because the user doesn't have "Direct User (Basic)" access to the "Saved Views" entity. Access provided by an owner team that has the "Team privileges only" inheritance setting isn't sufficient.

You should provide the impacted users with "Direct User (Basic)" access to the "Saved View" entity instead of just "Team privileges only" access.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/direct-user-basic-access.png" alt-text="Must provide Direct User (Basic) access.":::

## Save changes to current view option is missing

The "save changes to current view" option only shows in the command bar when modern advanced find is turned off; otherwise, it only shows in the view selector.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/save-changes-to-current-view.png" alt-text="User may see save changes to current view missing.":::

Furthermore, this option is only shown for personal views. When a system view (that is, All Accounts, My Active Contacts, ...) is selected, the option - by design - isn't shown, as a system view can't be updated.

## See also

- [General Power Apps troubleshooting strategies](isolate-common-issues.md)
- [Isolate issues in model-driven apps - Power Apps](isolate-model-app-issues.md)
- [Work with views](/power-apps/maker/model-driven-apps/create-edit-views)
- [FAQ for grid views](/power-apps/user/faq-for-grids-views)
