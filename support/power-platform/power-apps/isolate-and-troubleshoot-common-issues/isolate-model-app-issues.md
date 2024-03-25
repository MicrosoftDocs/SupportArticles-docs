---
title: Isolate issues in model-driven apps
description: Learn about techniques to narrow down the cause of errors in model-driven apps.
author: tahoon
ms.reviewer: matp
ms.date: 10/23/2023
ms.author: tahoon
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tahoon
---
# Isolate issues in model-driven apps

Model-driven apps are driven by configuration. You can give high-level instructions to generate an app. You can also introduce custom components that affect multiple parts of the app. When an app isn't behaving as expected, it may not be obvious if it's a customization error or a bug in the Power Apps system.

Here are some techniques to isolate problems in a model-driven app.

## Remove customizations

The following features can affect normal operation. Try disabling or removing them and check if the problem still occurs. [Learn more about finding and disabling customizations on forms](/power-apps/developer/model-driven-apps/troubleshoot-forms#use-url-parameters-to-disable-various-form-components).

### Business rules

**Affects**: Form pages

[Business rules](/power-apps/maker/data-platform/data-platform-create-business-rule) change a form's behavior based on the state of a record. Try disabling or simplifying the rule and check if the form still works as expected.

### Client scripts

**Affects**: Form pages

[Client scripts](/power-apps/developer/model-driven-apps/client-scripting) contain JavaScript code that can conflict with the Power Apps system or change it in unexpected ways. If disabling the script solves the issue, you should [isolate which part of the custom script causes the issue](#simplify-custom-scripts).

You can temporarily disable all custom scripts by appending this to the URL of the page:

```http
&flags=DisableFormLibraries=true,DisableWebResourceControls=true
```

### Custom commands

**Affects**: Form pages, Table-based view pages

If a problem happens after selecting a [command in the command bar](/power-apps/developer/model-driven-apps/command-bar-ribbon-presentation), check if it's a [custom command](/power-apps/maker/model-driven-apps/command-designer-overview). Custom commands can contain JavaScript code that causes unexpected behavior. Modern commands can have [custom actions defined with Power Fx](/power-apps/maker/model-driven-apps/commanding-use-powerfx). In either case, try simplifying the command to find out if there's an error in how the custom command is defined.

### Custom controls

**Affects**: Form pages, Table-based view pages, Custom pages

You can [replace controls on form pages](/power-apps/maker/model-driven-apps/add-move-configure-or-delete-components-on-form#configure-components-on-a-form) or [replace the grid control used on table-based view pages](/power-apps/maker/model-driven-apps/make-grids-lists-editable-custom-control) with [Power Apps components](/power-apps/developer/component-framework/overview). These controls are custom controls with JavaScript and CSS code that can affect other parts of the page. Try switching to an out-of-the-box control to see if the custom control is the problem.

### Server plugins and processes

**Affects**: All pages

Administrators can [install plugins and create processes that modify the business logic of an app](/power-apps/developer/data-platform/apply-business-logic-with-code). Check with your administrator if there are any relevant server-side customizations.

## Compare with out-of-the-box configurations

To help determine if something is a configuration error, it can be useful to check other parts of the app.

For example, does the problem happen with a different:

- Table (entity)
- View
- App with the same table
- Form for the same table
- Control referencing the same column (attribute)

Ideally, compare with an out-of-the-box one that hasn't been customized. For example, if the issue is with a table (entity) you created, check an out-of-the-box table.

If the problem doesn't happen elsewhere, compare the differences with how they're configured. Perhaps table relationships and permissions are set up differently. Or a table isn't enabled for Unified Interface.

## Re-create items

Creating an item from scratch not only allows you to examine and compare default configurations, it can also fix corrupted configurations.

If any of the following aren't working, try re-creating them. It can be a simplified version, to narrow down which part isn't working.

- Custom table (entity)
- View
- Form
- Custom script

## Find out if the issue occurs when getting data or showing data

When data isn't showing correctly in an app, it could either be a server issue in providing the data, or an app issue in processing and displaying it. To narrow down the cause, you can try [general methods for isolating the problematic layer](isolate-common-issues.md#find-out-which-layer-has-data-issues).

Model-driven apps have a complex data flow. Here are more advanced things to try.

- Examine the [FetchXML](/power-apps/developer/data-platform/use-fetchxml-construct-query) of network requests and check if the app is making the right network requests and receiving data correctly from the server. You can use [Monitor](/power-apps/maker/monitor-modelapps) to view network requests.
- If the [app has an offline profile](/power-apps/mobile/setup-mobile-offline#enable-your-app-for-offline-use-preview), try removing the user from the profile or the profile entirely. Even when there's an Internet connection, the data flow is different for apps that can work offline.
- Check for permission issues by trying a different user or table.

## Simplify custom scripts

Custom scripts are an advanced feature for developers. They can be used on [forms](/power-apps/developer/model-driven-apps/client-scripting), [custom commands](/power-apps/maker/model-driven-apps/command-designer-overview), [Power Apps components](/power-apps/developer/component-framework/overview), and [webpage (HTML) web resources](/power-apps/developer/model-driven-apps/webpage-html-web-resources). There's enormous flexibility in what scripts can do, but there's also a high chance that they can accidentally break the system.

If you suspect that a script is causing an issue, follow these steps:

1. Disable all custom scripts and see if the issue still happens.

2. If it doesn't, enable scripts one by one to see which one causes the issue.

3. Once the script(s) are found that cause the issue, remove irrelevant code from them. For example, if only one field has a problem, remove code that interacts with other form fields.

4. By progressively simplifying the script, you should be able to determine if the problem is caused by custom code or incorrect behavior of [Client API](/power-apps/developer/model-driven-apps/clientapi/reference) features.

   - If the error is from custom code, contact the developer who wrote the script for assistance.

   - If a Client API feature isn't working as documented, you can report it to Microsoft. Attach a copy of the simplified script and mention which API feature isn't working.

## Create a vanilla repro app

The process of creating a [vanilla repro app](vanilla-model-driven-app-repro.md) may uncover configuration errors that aren't obvious in an environment with many customizations. Even if the problem isn't fixed, you would have narrowed the cause and made it easier to explain the problem to others.

## Next steps

- [Troubleshoot commands](../create-and-use-apps/ribbon-issues.md)
- [Troubleshoot forms](/power-apps/developer/model-driven-apps/troubleshoot-forms)
- [Troubleshoot plug-ins](/power-apps/developer/data-platform/troubleshoot-plug-in)
- [Troubleshoot permission issues with Microsoft Dataverse](/power-platform/admin/troubleshooting-user-needs-read-write-access-organization)
- [Debugging model-driven apps with Monitor](/power-apps/maker/monitor-modelapps)
- [Debugging model-driven apps forms with Monitor](/power-apps/maker/model-driven-apps/monitor-form-checker)

## See also

- [General Power Apps debugging strategies](isolate-common-issues.md)
