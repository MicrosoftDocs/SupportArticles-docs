---
title: Troubleshoot View issues in model-driven apps
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
# Troubleshoot View issues in model-driven apps

Model-driven apps use views to define how a list of records for a specific table are displayed in the application.

A view defines:

The columns to display.
The order of the columns.
How wide each column should be.
How the list of records should be sorted by default.
The default filters applied to restrict the records that will appear.
Once a view has been made available in the app, the user can select it.

Below you can find some of the most common issues encountered with views:

- [View selector is rendering incorrectly](#view-selector-is-rendering-incorrectly)
- [Public view is not showing in the view selector.](#public-view-is-not-showing-in-the-view-selector)
- [View selector is blank after navigating from a dashboard.](#view-selector-is-blank-after-navigating-from-a-dashboard)
- [User views are not appearing in view selector.](#user-views-are-not-appearing-in-view-selector)

## View selector is rendering incorrectly

If the View Selector fails to render correctly, ensure that third-party CSS library is not present on the form. Because that library's styles operate on a the global style -- that is, there is no namespace -- all elements on the page are affected by these styles. The ViewSelector, like all of our CRM controls, was not built with Bootstrap in mind and therefore may appear incorrectly rendered. More often than not, it's the popular Bootstrap CSS library causing the problem.

In summary, remove Bootstrap or other third-party CSS libraries. These are not only unsupported in CRM, but their use is strongly discouraged.

## Public view is not showing in the view selector

If some public view is not showing in the view selector, then Please check in the app designer to verify that the view is included in the app. If it is not included in the app, then please Use app designer to add the missing view into the app.

## View selector is blank after navigating from a dashboard

If when navigating to any entity from a dashboard via "See all records", the view selector is blank, this could potentially mean that the view used on the dashboard is not included in the model driven app.

To add (or remove) one or more views or charts for a model-driven app, follow these steps:

  1. In the app designer, on the left navigation pane, select Pages and then select the table you want to update, such as the Account view.

  2. On the right properties pane, select Manage views or Manage charts.

  3. On the flyout, select the views or charts you want to add or remove, and then select Save.

  4. Select Publish to make the changes available to other users.

## User views are not appearing in view selector

Users intermittently do not see user views (personal views) in the grid selector (sample UI below):
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/3a79bd6e-2211-41b1-90a9-b21bb2ef8705)

When a subgrid on a form is configured for 'Show All Views', it renders the My Views selections which conflicts with the homepage grid views when the form GCM caching feature is enabled. One way to mitigate this is to Modify the default entity form such that none of the subgrids are using "Show All View".

The missing user views (on the grid page) occur when the default form of the entity (the initial form that loads when opening a record) contains a subgrid that is configured to "Show All Views".
This is an example of the case form containing a subgrid with Show All Views enabled:
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/12bef098-d551-4494-8331-8eaafc496597)

If the subgrid configuration is changed to "Off" or "Show Selected Views" instead, then the issue with the missing views should no longer occur.
![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/4950382d-44d4-4055-a0db-a9e4b2e03ea5)

Or

![image](https://github.com/MicrosoftDocs/SupportArticles-docs-pr/assets/100440855/17dd9ddd-1fc8-4d3e-9bde-bf034c656b4a)

## See also

- [General Power Apps troubleshooting strategies](isolate-common-issues.md)
- [Isolate issues in model-driven apps - Power Apps](isolate-model-app-issues.md)
- [Work with views](https://learn.microsoft.com/en-us/power-apps/maker/model-driven-apps/create-edit-views)
- [FAQ for grid views](https://learn.microsoft.com/en-us/power-apps/user/faq-for-grids-views)
