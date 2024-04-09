---
title: Troubleshoot view issues in model-driven apps
description: Helps troubleshoot view issues in Power Apps model-driven apps.
author: grosiles3
ms.date: 04/02/2024
ms.author: gurosile
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - gurosile
ms.custom: sap:Display and use views in model-driven apps\Changing views
---
# Troubleshoot view issues in model-driven apps

Model-driven apps use [views](/power-apps/maker/model-driven-apps/create-edit-views) to define how a list of records for a specific table is displayed in the application.

A view defines:

- The columns to display.
- The order of the columns.
- The width of each column.
- The default sorting of record lists.
- The default filters applied to restrict the records displayed.

Once a view is available in the app, users can select it.

This article describes some of the most common issues related to views and suggestions to resolve them.

- [View selector renders incorrectly](#view-selector-renders-incorrectly).
- [Public view isn't shown in the view selector](#public-view-isnt-shown-in-the-view-selector).
- [View selector is blank after navigating from a dashboard](#view-selector-is-blank-after-navigating-from-a-dashboard).
- [Personal views aren't shown in the view selector](#personal-views-arent-shown-in-the-view-selector).
- [Column doesn't appear in the column editor's "Add columns" list](#column-doesnt-appear-in-the-column-editors-add-columns-list).
- [Shared personal views are missing from the view selector](#shared-personal-views-are-missing-from-the-view-selector).
- [The "Save changes to current view" option is missing](#the-save-changes-to-current-view-option-is-missing).

## View selector renders incorrectly

If the view selector isn't rendering correctly, check if there's a third-party CSS library on the form. Because the library's styles operate on the global style (that is, there's no namespace), these styles affect all elements on the page. Our CRM controls, including the view selector, weren't designed for libraries like [Bootstrap](/power-pages/configure/bootstrap-overview), thus often causing these issues. If you're using Bootstrap or similar CSS libraries, consider removing them.

## Public view isn't shown in the view selector

If a public view isn't shown in the view selector, check the app designer to verify that the view is included in the app. If it isn't included in the app, use the app designer to [add the missing view to the app](/power-apps/maker/model-driven-apps/create-add-remove-forms-views-dashboards#manage-views-and-charts).

## View selector is blank after navigating from a dashboard

If the view selector is blank when you navigate to any entity from a dashboard using "see all records," this might mean that the view used on the dashboard isn't included in the model-driven app. To solve this issue, [add the missing view to the app](/power-apps/maker/model-driven-apps/create-add-remove-forms-views-dashboards#manage-views-and-charts).

## Personal views aren't shown in the view selector

If you don't see personal views in the grid selector, it might be because when a subgrid on a form is configured to show all views, it renders the **My Views** selections. This configuration conflicts with the homepage grid view (sample UI):

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/user-view-missing.png" alt-text="Screenshot that shows some user views are missing in the view selector.":::

To fix this issue, you can modify the default entity form so that all subgrids don't use **Show All Views**.

The following screenshot shows an example case form containing a subgrid with **Show All Views** enabled:

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/subgrid-with-show-all-views-enabled.png" alt-text="Example of a case form containing a subgrid with Show All Views enabled." lightbox="media/troubleshoot-model-driven-app-view-issues/subgrid-with-show-all-views-enabled.png":::

If the subgrid configuration is changed to **Off** or **Show Selected Views**, as shown in the following screenshots, the issue with the missing views should no longer occur.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/sub-grid-view-selector-off.png" alt-text="Screenshot that shows the View Selector option is set to Off." border="false":::

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/sub-grid-view-selector-show-selected-views.png" alt-text="Screenshot that shows the View Selector option is set to Show Selected Views." border="false":::

## Column doesn't appear in the column editor's "Add columns" list

Sometimes, you might expect a specific column to appear in the column editor's **Add columns** list, but you can't find it.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/column-missing-in-column-editor.png" alt-text="Screenshot that shows an example of the Add columns list in the column editor.":::

This issue usually happens because the [isValidForGrid](/dotnet/api/microsoft.xrm.sdk.metadata.attributemetadata.isvalidforgrid) attribute is set to false. You can get the metadata for the attribute by adding the following path to the organization URL (replacing `account` and `address1_longitude` with the desired entity and attribute name):

`/api/data/v9.2/EntityDefinitions(LogicalName='account')/Attributes(LogicalName='address1_longitude')?$select=SchemaName,IsValidForGrid`

If `isValidForGrid` is set to false, this attribute can't show up in the grid and, therefore, doesn't show up in the column editor. To solve this issue, set `IsValidForGrid` to true.

## Shared personal views are missing from the view selector

Some users might not see personal views shared with them in the view selector, even though they appear in the **Manage and share views** dialog.

This behavior might be because the users don't have the "Direct User (Basic)" access to the "Saved Views" entity. The access provided by an owner team that has the "Team privileges only" inheritance setting isn't sufficient.

To solve this issue, provide the impacted users with the "Direct User (Basic)" access to the "Saved View" entity instead of the "Team privileges only" access.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/direct-user-basic-access.png" alt-text="Screenshot that shows the options of the Member's privilege inheritance setting.":::

## The "Save changes to current view" option is missing

The **Save changes to current view** option only appears in the command bar when [modern advanced find](/power-platform/admin/settings-features) is turned off; otherwise, it only appears in the view selector.

:::image type="content" source="media/troubleshoot-model-driven-app-view-issues/save-changes-to-current-view.png" alt-text="Screenshot that shows the Save changes to current view option shown in the command bar.":::

Furthermore, this option is only shown for personal views. When you select a system view using **All Accounts** > **My Active Contacts**, the option isn't shown, as a system view can't be updated. This behavior is by design.

## See also

- [General Power Apps troubleshooting strategies](~/power-platform/power-apps/isolate-and-troubleshoot-common-issues/isolate-common-issues.md)
- [Isolate issues in model-driven apps - Power Apps](~/power-platform/power-apps/isolate-and-troubleshoot-common-issues/isolate-model-app-issues.md)
- [Understand model-driven app views](/power-apps/maker/model-driven-apps/create-edit-views)
- [FAQ for grid views](/power-apps/user/faq-for-grids-views)

[!INCLUDE [Third-party disclaimer](../../../includes/third-party-disclaimer.md)]
