---
title: Isolate issues in model-driven apps
description: Learn about techniques to narrow down the cause of errors in model-driven apps.
author: tahoon

ms.subservice: troubleshoot
ms.topic: conceptual
ms.custom:
ms.reviewer:
ms.date: 06/15/2022
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---

# Isolate issues in model-driven apps

Model-driven apps are driven by configuration. You can give high-level instructions to generate an app. You can also introduce custom components that affect multiple parts of the app. When an app is not behaving as expected, it may not be obvious if it is a customization error or a bug in the Power Apps system.

Here are some techniques to isolate problems in a model-driven app.


## Remove customizations

The following can affect normal operation. Try disabling or removing them and check whether the problem still occurs. [Learn more about finding and disabling customizations on forms](../../developer/model-driven-apps/troubleshoot-forms.md#use-url-parameters-to-disable-various-form-components).

### Business rules

**Affects**: Form pages

[Business rules](create-business-rules-recommendations-apply-logic-form.md) change a form's behavior based on the state of a record. Try disabling or simplifying the rules and check if the form still works as expected.

### Client scripts

**Affects**: Form pages

[Client scripts](../../developer/model-driven-apps/client-scripting.md) contain JavaScript code that can conflict with the Power Apps system or change it in unexpected ways. If disabling the script solves the issue, you should [isolate which part of the custom script causes the issue](#simplify-custom-scripts).

### Custom commands

**Affects**: Form pages, Table-based view pages

If a problem happens after selecting a [command in the command bar](../../developer/model-driven-apps/command-bar-ribbon-presentation.md), check if it is a [custom command](command-designer-overview.md). Custom commands can contain JavaScript code that cause unexpected behavior. Modern commands can have [custom actions defined with Power Fx](commanding-use-powerfx.md). In either case, try simplifying the command to find out if there is an error in how the custom command is defined.

### Custom controls

**Affects**: Form pages, Table-based view pages, Custom pages

You can [replace controls on form pages](add-move-configure-or-delete-components-on-form.md#configure-components-on-a-form) or [replace the grid control used on table-based view pages](make-grids-lists-editable-custom-control.md) with [Power Apps components](../../developer/component-framework/overview.md). These are custom controls with JavaScript and CSS code that can affect other parts of the page. Try switching to an out-of-the-box control to see if the custom control is the problem.

### Server plugins and processes

**Affects**: All pages

Administrators can [install plugins and create processes that modify the business logic of an app](../../developer/data-platform/apply-business-logic-with-code.md). Check with your administrator if there are any relevant server-side customizations.


## Compare with out-of-the-box configurations

Tp help determine if something is a configuration error, it can be useful to check other parts of the app.

For example, does the problem happen with a different…

* Table (entity)
* View
* App with the same table
* Form about the same table
* Control referencing the same column (attribute)

Ideally, compare with an out-of-the-box one that has not been customized. For example, if the issue is with a table (entity) you created, check an out-of-the-box table.

If the problem does not happen elsewhere, compare the differences with how they are configured. Perhaps table relationships and permissions are set up differently. Or a table is not enabled for Unified Client.

## Re-create items

Creating an item from scratch not only allows you to examine and compare default configurations, it can also fix corrupted configurations.

If any of the following are not working, try re-creating them. It can be a simplified version, to narrow down which part isn't working.

* Custom table (entity)
* View
* Form
* Custom script


## Find out if an issue is with getting data or showing data

When data is not showing correctly in an app, it could either be a server issue in providing the data, or an app issue in processing and displaying it. To narrow down the cause, you can try [general methods for isolating the problematic layer](../common/isolate-issues.md#data-issues).

Model-driven apps have a complex data flow. Here are more advanced things to try.

* Examine the [fetchXML](../../developer/data-platform/use-fetchxml-construct-query.md) of network requests and check if the app is making the right network requests and receiving data correctly from the server. You can use [Monitor](../monitor-modelapps.md) to view network requests.
* If the [app has an offline profile](../../mobile/setup-mobile-offline.md#enable-your-app-for-offline-use-preview), try removing the user from the profile or the profile entirely. Even when there is an internet connection, the data flow is different for apps that can work offline.
* Check for permission issues by trying a different user or table.


## Simplify custom scripts

Custom scripts are an advanced feature for developers. They can be used on [forms]((../../developer/model-driven-apps/client-scripting.md), [custom commands](command-designer-overview.md), [Power Apps components](../../developer/component-framework/overview.md), and [webpage (HTML) web resources](../../developer/model-driven-apps/webpage-html-web-resources.md). There is enormous flexibility in what scripts can do, but there is also a high chance that they can accidentally break the system.

If you suspect that a script is causing an issue,

1. Disable all custom scripts and see if the issue still happens.

2. If it does not, enable scripts one by one to see which one causes the issue.

3. Once the script(s) are found that cause the issue, remove irrelevant code from them. For example, if only one field has a problem, remove code that interacts with other form fields.

4. By progressively simplifying the script, you should be able to determine if the problem is caused by custom code or incorrect behavior of [Client API](../../developer/model-driven-apps/clientapi/reference.md) features.
  * If the error is from custom code, contact the developer who wrote the script for assistance.
  * If a Client API feature is not working as documented, you can report it to Microsoft. Attach a copy of the simplified script and mention which API feature isn't working.


## Next steps

[Troubleshoot commands](/troubleshoot/power-platform/power-apps/ribbon-issues)
[Troubleshoot forms](../../developer/model-driven-apps/troubleshoot-forms.md)
[Troubleshoot plug-ins](../../developer/data-platform/troubleshoot-plug-in.md)
[Troubleshoot permission issues with Microsoft Dataverse](/power-platform/admin/troubleshooting-user-needs-read-write-access-organization)
[Debugging model-driven apps with Monitor](../monitor-modelapps.md)
[Debugging model-driven apps forms with Monitor](monitor-form-checker.md)
[Isolate issues in Custom pages](../canvas-apps/isolate-issues.md)


### See also

[Think like a debugger](../common/isolate-issues.md)

[!INCLUDE[footer-include](../../includes/footer-banner.md)]