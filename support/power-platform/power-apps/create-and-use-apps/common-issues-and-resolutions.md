---
title: Common Issues and Resolutions for Power Apps
description: Resolve common Power Apps issues with step-by-step solutions and troubleshooting tips for connectors, integration, Power Apps Studio, and more. 
author: KumarVivek
ms.custom: sap:App Creation (Canvas App)
ms.reviewer: tapanm, lanced, tahoon 
ms.date: 04/15/2025
ms.author: kvivek
search.audienceType: 
  - maker
search.app: 
  - PowerApps
contributors:
  - tapanm-msft
  - mduelae
---
# Common issues and resolutions for Power Apps

## Summary

This article provides solutions to common problems that you might encounter when you create or use Power Apps. The article organizes problems by functional area, such as connectors, Power Automate integrations, Power Fx, and Power Apps Studio. Each section includes troubleshooting steps and links to related documentation.

Before you troubleshoot specific problems, review [Power Apps troubleshooting strategies](./isolate-common-issues.md) for guidance on how to identify the source of a problem. That article outlines key principles for debugging both functional and performance problems.

## Common Power Apps issue areas

- [Connectors and delegation](#connectors-and-delegation)
- [Power Automate Integration](#power-automate-integration)
- [Power Fx](#power-fx)
- [Regional performance issues](#regional-performance)
- [Power Apps Studio and Forms](#power-apps-studio-and-forms)
- [Browser performance](#browser-performance)
- [Power Apps for Windows](#power-apps-for-windows)

## Connectors and delegation

For an overview of how tabular and action connectors work, see [Connections](/power-apps/maker/canvas-apps/connections-list).

For details about delegation, see [Understanding delegation in a canvas app](/power-apps/maker/canvas-apps/delegation-overview).

For a description of how to monitor the data being sent and returned, see [Debugging canvas apps with Monitor](/power-apps/maker/monitor-canvasapps).

- **You don't have the correct permissions to use a connection.**

  Users might encounter this message in two situations:

  - The application shares an implicit connection that isn't a secure implicit connection. To resolve the problem, share the connection with the end user, but consider that this approach isn't recommended. The author should convert all connections to secure implicit connections.

  - The application uses a secure implicit connection. In this case, republishing the app might resolve the problem.

- **Automatic Next links for galleries and grids don't work for action-based connectors.**

  Action-based connectors don't support next links. Next links are properties on query results that allow a gallery or grid to automatically load the next set of results. For more information, see [Overview of connectors for canvas apps](/power-apps/maker/canvas-apps/connections-list#actions).

- **Sharing a Canvas app using SharePoint connector**

  For more information about how to share an app for SharePoint, see [Connect to SharePoint from a canvas app](/power-apps/maker/canvas-apps/connections/connection-sharepoint-online).

- **SQL data sources no longer add a `[dbo]` prefix to the data source name.**

  For more information about this change, see [Connect to SQL Server from Power Apps](/power-apps/maker/canvas-apps/connections/connection-azure-sqldatabase).

- **Custom connectors and Microsoft Dataverse**

  You need to make adjustments if you built your app with Power Apps that:

  - Is version 2.0.540 or earlier.
  - Relies on a Dataverse database.
  - Uses at least one custom connector from a separate environment.

  First, deploy the custom connector to the same environment as the database. Then, update the app to use the newly deployed connector. Otherwise, a dialog notifies users that the API wasn't found. For more information, see [Environments overview](/power-platform/admin/environments-overview).

- **Column names with spaces**

  If you're using a list created using Microsoft Lists, a SharePoint library, or an Excel table in which a column name contains a space, use single quotes with the column name, for example `someList.'Color Tag'`.

- **Apps that connect to on-premises SharePoint**

  If you share an app that relies on connections that aren't automatically shared (for example, an on-premises SharePoint site), users who open the app in a browser see a dialog box with no text when they select or tap **Sign in**. To close the dialog box, select or tap the close (X) icon in the upper-right corner.

  The dialog box doesn't appear if you open the app in [Power Apps Studio](/power-apps/maker/canvas-apps/power-apps-studio) or [Power Apps mobile](/power-apps/mobile/run-powerapps-on-mobile). For more information about shared connections, see [Share app resources](/power-apps/maker/canvas-apps/share-app-resources).

- **For apps that are created from data, only the first 500 records of a data source can be accessed.**

  Power Apps works with large data sources by delegating operations to the data source. For operations that can't be delegated, Power Apps shows a warning at authoring time and operates on only the first 500 records of the data source. For more information, see the [Delegation overview](/power-apps/maker/canvas-apps/delegation-overview#delegable-functions).

- **Excel data must be formatted as a table.**

  For information about limitations when you use Excel as a data source, see [Cloud-storage connections](/power-apps/maker/canvas-apps/connections/cloud-storage-blob-connections).

- **Microsoft Lists is supported but not SharePoint libraries, some types of list columns, or columns that support multiple values or selections.**

  For more information, see [SharePoint Online](/power-apps/maker/canvas-apps/connections/connection-sharepoint-online#known-issues).

- **Sign-in issues on certain Android mobile devices when using authenticator**

  On certain devices and in certain scenarios, you might experience sign-in failures when you use an authenticator. This problem happens because of a limitation that the OEM imposes. For more information, see [ADALError: BROKER_AUTHENTICATOR_NOT_RESPONDING](https://github.com/AzureAD/azure-activedirectory-library-for-android/wiki/ADALError:-BROKER_AUTHENTICATOR_NOT_RESPONDING).

- **Apps cannot save null/blank values to data sources**

  If your app is unable to save null or blank values to data sources, this issue may occur when the Formula-level error management feature is disabled. To resolve this problem, go to **Settings** > **Updates** > **Retired** and ensure that the Formula-level error management feature is not disabled.

## Power Automate integration

- **Power Automate flows are orphaned in Power Apps.**

  Power Automate flows that you add by using an older version of the Power Apps panel might become orphaned and removed. To fix this problem, re-add the flows manually.

- **Power Apps custom pages (in a model-driven app) are out of synchronization with embedded Power Automate flow metadata.**

  The metadata for a Power Automate flow might get out of synchronization with a model-driven app's custom page if you update the flow after embedding it. To update the metadata, follow these steps for each embedded flow:

  1. Edit the custom pages that use the flow.
  1. Open the Power Automate pane and refresh the flow.
  1. Save and republish the custom page.

    When you're done, follow these steps:

  1. Edit the model-driven app.
  1. Make a minor change to trigger the save option.
  1. Save and publish the model-driven app.

## Power Fx

For more information about Power Fx, see [Microsoft Power Fx](/power-platform/power-fx/overview).

- **`Connection.Connected` returns the wrong value during OnStart in Power Apps for Windows.**

  While offline, the **[Connection.Connected](/power-platform/power-fx/reference/signals#connection)** formula might wrongly return **true** immediately after starting an app in Power Apps for Windows. As a workaround, use a [Timer](/power-apps/maker/canvas-apps/controls/control-timer) control to delay the execution of the logic depending on it.

- **Issues with Date-time**

  For more information about date and time problems, see:

  - [Troubleshoot Canvas app date time issues](./troubleshoot-canvas-app-date-time-issues.md)
  - [Troubleshoot Model driven app date time issues](./troubleshoot-model-driven-app-date-time-issues.md)

## Regional performance

- **Performance degradation when opening Power Apps Studio in China**

  [Power Apps Studio](/power-apps/maker/canvas-apps/power-apps-studio) might take more than 30 seconds to load in China. This problem doesn't affect tenants that 21Vianet hosts locally.

## Power Apps Studio and forms

The [Power Apps Studio](/power-apps/maker/canvas-apps/power-apps-studio) hosts the app editing and publishing experience.  

- **Problems with startup**

  If you have trouble accessing or starting Power Apps, see [Troubleshooting startup or sign-in issues for Power Apps](~/power-platform/power-apps/sign-in/troubleshooting-startup-issues.md).

- **Problems changing dimensions or orientation of SharePoint forms**

  If you have problems with the **Screen size + orientation** settings for custom SharePoint forms, use the **Custom** size to work around the problem:

  1. Reset the setting by selecting the **Small** size.
  1. Toggle **Orientation** to **Portrait** and then back to **Landscape**.
  1. Select **Custom** and enter a desired screen size. For reference, the preset values are:
     - "Width: 270, Height: 480" for the Small Portrait size.
     - "Width: 720, Height: 480" for the Small Landscape size.

- **Copying and pasting screens across apps**

  Copying and pasting screens across apps isn't currently supported. To work around this problem:

  1. Add a new screen to your target app.
  1. Copy the controls from the screen in your source app.
  1. Paste the controls into the screen of your target app.

- **Changing the layout of SharePoint forms**

  When you customize SharePoint forms in certain languages, if you try to change the layout from **Portrait** (default) to **Landscape**, the app might show multiple errors (yellow triangles in controls). To resolve these errors and retain the landscape layout, select **Undo**.

- **Changing a flow in a shared app**

  If you add a flow to an app and share the app, and then make changes to the flow, such as adding a service or modifying a connection, more steps are required. You must also first remove the flow from the shared app. Next, re-add the flow to the app. Finally, re-share the app.

- **Changing a "Title" field in a table**

  If you change the **Title** field for a table that other tables reference through one or more lookups, an error occurs when you try to save the change. To work around this problem:
  
  1. Remove any lookups to the table you want to change.
  1. Change the table's **Title** field.
  1. Re-create the lookups.

  For more information about lookups, see [Create a relationship between tables](/power-apps/maker/data-platform/data-platform-entity-lookup).

- **When Power Apps generates an app from data, the field used for sorting and searching isn't automatically configured.**

  To configure the field, edit the [Items](/power-apps/maker/canvas-apps/controls/properties-core) formula for the gallery, as described in [Filter and sort a gallery](/power-apps/maker/canvas-apps/add-gallery#filter-and-sort-a-gallery).

- **It can sometimes take a moment before a newly shared app can be used.**

  In some cases, a newly shared app isn't immediately available. Wait a few moments, and it should become available.

- **In the [Form control](/power-apps/maker/canvas-apps/controls/control-form-detail), you can't change data by using a custom card.**

  The stock custom card is missing the [Update](/power-apps/maker/canvas-apps/controls/control-card) property, which is required to write back changes. To work around this problem:

  1. Select the **Form** control, and insert a card by using the right-hand pane based on the field that you want the card to show.
  1. Unlock the card, as described in [Understanding data cards](/power-apps/maker/canvas-apps/working-with-cards#unlock-a-card).
  1. Remove or rearrange controls within the card as you see fit, just as you would with the custom card.

- **Card gallery is deprecated.**

  Existing apps that use this feature continue to run for now, but you can't add a card gallery. Replace card galleries with the new [Edit form](/power-apps/maker/canvas-apps/controls/control-form-detail) and [Display form](/power-apps/maker/canvas-apps/controls/control-form-detail) controls.

## Browser performance

- **Browser running out of memory**

  If you're using the 32-bit version of Google Chrome or Microsoft Edge and the browser runs out of memory while you're using Power Apps, consider using the 64-bit version.

## Power Apps for Windows

- **Power Apps mobile app for the Windows platform doesn't support the Dropbox connector.**

  A pop-up dialog shows the following message in this situation:

  > We can't connect to the service you need right now. Check your network connection or try again later.

  When this issue occurs, consider using a web player on the Windows platform.

- **Microsoft Entra Conditional Access with the policy _Require device to be marked as compliant_ doesn't work in Power Apps for Windows.**

  When the Conditional Access policy is set to _Require device to be marked as compliant_ in Microsoft Entra ID, users receive the following sign-in error and can't access their Power Apps.

  > The application contains sensitive information and can only be accessed from devices or client applications that meet your enterprise management compliance policy.

  To work around the issue, they can use a browser.

## Next steps

If your issue isn't listed in this article, you can [search for more support resources](https://powerapps.microsoft.com/support), or contact [Microsoft support](https://admin.powerplatform.microsoft.com/support). For more information, see [Get Help + Support](/power-platform/admin/get-help-support).
