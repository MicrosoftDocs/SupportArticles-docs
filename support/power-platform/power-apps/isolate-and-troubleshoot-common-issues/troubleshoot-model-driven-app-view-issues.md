---
title: Troubleshoot view issues in model-driven apps
description: Helps troubleshoot view issues in Power Apps model-driven apps.
author: gurosile
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
- How wide each column should be.
- How the list of records should be sorted by default.
- The default filters applied to restrict the records that will appear.

Once a view has been made available in the app, the user can select it.

Below you can find some of the most common issues encountered with views:

- [View selector is rendering incorrectly.](#view-selector-is-rendering-incorrectly)
- [Public view is not showing in the view selector.](#public-view-is-not-showing-in-the-view-selector)
- [View selector is blank after navigating from a dashboard.](#view-selector-is-blank-after-navigating-from-a-dashboard)
- [User views are not appearing in view selector.](#user-views-are-not-appearing-in-view-selector)
- [Column does not appear in the column editor 'add-columns' list.](#column-does-not-appear-in-the-column-editor-add-columns-list)
- [Shared personal views are missing from view selector.](#shared-personal-views-are-missing-from-view-selector)
- [Save changes to current view option is missing.](#save-changes-to-current-view-option-is-missing)

## View selector is rendering incorrectly

If the View Selector fails to render correctly, ensure that third-party CSS library is not present on the form. Because that library's styles operate on the global style, that is, there is no namespace, all elements on the page are affected by these styles. The View Selector, like all of our CRM controls, was not built with Bootstrap in mind and therefore may appear incorrectly rendered. More often than not, it's the popular Bootstrap CSS library causing the problem.

In summary, remove Bootstrap or other third-party CSS libraries. These are not only unsupported in CRM, but their use is strongly discouraged.

## Public view is not showing in the view selector

If some public view is not showing in the view selector, then please check in the app designer to verify that the view is included in the app. If it is not included in the app, then please use the app designer to add the missing view to the app.

## View selector is blank after navigating from a dashboard

If the view selector is blank when navigating to any entity from a dashboard via "see all records", this could potentially mean that the view used on the dashboard is not included in the model driven app.

To add (or remove) one or more views or charts for a model-driven app, follow these steps:

  1. In the app designer, on the left navigation pane, select pages and then select the table you want to update, such as the account view.

  2. On the right properties pane, select manage views or manage charts.

  3. On the flyout, select the views or charts you want to add or remove, and then select save.

  4. Select publish to make the changes available to other users.

## User views are not appearing in view selector

If users intermittently do not see user views (personal views) in the grid selector, this could be because when a subgrid on a form is configured to 'show all views', it renders the my views selections, which conflicts with the homepage grid view (sample UI below):

![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/3a79bd6e-2211-41b1-90a9-b21bb2ef8705)

To fix this, you can modify the default entity form such that none of the subgrids are using "show all views".

This is an example of the case form containing a subgrid with 'show all views' enabled:
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/12bef098-d551-4494-8331-8eaafc496597)

If the subgrid configuration is changed to "off" or "show selected views" instead, then the issue with the missing views should no longer occur as shown below:

![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/4950382d-44d4-4055-a0db-a9e4b2e03ea5)

Or

![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/17dd9ddd-1fc8-4d3e-9bde-bf034c656b4a)

## Column does not appear in the column editor 'add columns' list

Sometimes you might expect a certain column to appear in the column editor "add columns" list, but cannot find it.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/e0761099-c34c-4de0-8359-02b80ebbb3cd)

This usually happens because the attribute has 'isValidForGrid' set to false. You can look at the metadata for the attribute by adding this to the org url (replacing Account and address1_longitude with the desired entity and attribute name) /api/data/v9.2/EntityDefinitions(LogicalName='account')/Attributes(LogicalName='address1_longitude')?$select=SchemaName,IsValidForGrid

If isValidForGrid is set to false, then this attribute cannot show up in the grid, and therefore will not show up in the column editor either. Please update the field IsValidForGrid to true.

## Shared personal views are missing from view selector

You might see specific users that are not able to see personal views shared with them in the view selector, even though they appear in the manage and share views dialog.

This could be because the user does not have "Direct User (Basic)" access to the "Saved Views" entity. Access provided by an owner team that has the "Team privileges only" inheritance setting is not sufficient.

You should provide the impacted users with "Direct User (Basic)" access to the "Saved View" entity instead of just "Team privileges only" access.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/07ed92b9-0ded-4e4e-86c9-9caf91f97519)

## Save changes to current view option is missing

The "save changes to current view" option will only show in the command bar when modern advanced find is turned off; otherwise, it will only show in the view selector.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/2deec3c7-aa6c-405c-95f2-032bb21378fb)

Furthermore, this option is only shown for personal views. When a system view (i.e. All Accounts, My Active Contacts, ...) is selected, the option - by design - is not shown, as a system view cannot be updated.

## See also

- [General Power Apps troubleshooting strategies](isolate-common-issues.md)
- [Isolate issues in model-driven apps - Power Apps](isolate-model-app-issues.md)
- [Work with views](https://learn.microsoft.com/en-us/power-apps/maker/model-driven-apps/create-edit-views)
- [FAQ for grid views](https://learn.microsoft.com/en-us/power-apps/user/faq-for-grids-views)
